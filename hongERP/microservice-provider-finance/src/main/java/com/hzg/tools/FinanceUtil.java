package com.hzg.tools;

import com.google.gson.reflect.TypeToken;
import com.hzg.afterSaleService.ReturnProduct;
import com.hzg.afterSaleService.ReturnProductDetail;
import com.hzg.afterSaleService.ReturnProductDetailProduct;
import com.hzg.customer.Customer;
import com.hzg.erp.*;
import com.hzg.finance.*;
import com.hzg.order.Order;
import com.hzg.order.OrderBook;
import com.hzg.order.OrderDetail;
import com.hzg.order.OrderDetailProduct;
import com.hzg.pay.Account;
import com.hzg.pay.Pay;
import com.hzg.pay.Refund;
import com.hzg.sys.Action;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: FinanceUtil.java
 * 类的详细说明
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2018/1/5
 */
@Component
public class FinanceUtil {

    private SimpleDateFormat dayFormat = new SimpleDateFormat("yyyy/MM/dd");

    @Autowired
    private FinanceDao financeDao;

    @Autowired
    private Writer writer;

    @Autowired
    private DateUtil dateUtil;

    /**
     * 每天凌晨0点查询是否有各种单据生成，有的话获取需要数据插入到凭证条目来源表里
     */
    @Transactional
    @Scheduled(cron = "0 0 0 * * ?")
    public void generateVoucherItemSource(){
        String result ="";
        DocType docType = new DocType();
        Map<String, String> queryParameters = null;
        String date1 = dayFormat.format(dateUtil.getForwardDay(1));
        String date2 = dayFormat.format(new Date(System.currentTimeMillis()));
        String date = date1 + " - " + date2;

        String json = "{\"date\":\""+date+"\"}";
        try {
            queryParameters = writer.gson.fromJson(json, new TypeToken<Map<String, String>>(){}.getType());
        } catch (Exception e){
            e.getMessage();
        }
        //查询采购单
        List<Purchase> purchases = financeDao.complexQuery(Purchase.class, queryParameters, 0, -1);
        if (purchases != null && !purchases.isEmpty()){
            PurchaseDetail purchaseDetail = new PurchaseDetail();
            for (Purchase purchase:purchases) {
                if (purchase != null) {
                    if (purchase.getState() == 1){
                        VoucherItemSource voucherItemSource = new VoucherItemSource();
                        // 设置制单人
                        voucherItemSource.setChartMaker(purchase.getInputer());
                        // 设置单据日期
                        voucherItemSource.setDate(purchase.getInputDate());
                        // 设置单据类型为采购单
                        docType.setId(1);
                        voucherItemSource.setDocType(docType);
                        // 设置业务类型
                        Integer type = purchase.getType();
                        if (type == 0) {
                            voucherItemSource.setBusinessType("正常采购");
                        } else if (type == 1) {
                            voucherItemSource.setBusinessType("临时采购");
                        } else if (type == 2) {
                            voucherItemSource.setBusinessType("应急采购");
                        } else if (type == 3) {
                            voucherItemSource.setBusinessType("现金采购");
                        } else if (type == 4) {
                            voucherItemSource.setBusinessType("押金采购");
                        }
                        // 设置单据编号
                        voucherItemSource.setDocNo(purchase.getNo());
                        // 设置往来单位，对于采购单来说往来单位就是供应商
                        Set<PurchaseDetail> details = purchase.getDetails();
                        Iterator<PurchaseDetail> iterator = details.iterator();
                        while (iterator.hasNext()){
                            purchaseDetail = iterator.next();
                            break;
                        }
                        Supplier supplier = (Supplier)financeDao.queryById(purchaseDetail.getSupplier().getId(), Supplier.class);
                        voucherItemSource.setContactUnit(supplier.getName());
                        // 设置金额和备注
                        voucherItemSource.setAmount(purchase.getAmount());
                        voucherItemSource.setRemark(purchase.getDescribes());
                        voucherItemSource.setState(1);
                        result = financeDao.save(voucherItemSource);
                        if (result == "success"){
                            VoucherItemSourceDetail voucherItemSourceDetail = new VoucherItemSourceDetail();
                            voucherItemSourceDetail.setVoucherItemSource(voucherItemSource);
                            PurchaseDetailProduct purchaseDetailProduct = new PurchaseDetailProduct();
                            for (PurchaseDetail purchaseDetail1 : details){
                                purchaseDetailProduct.setPurchaseDetail(purchaseDetail1);
                                List<PurchaseDetailProduct> purchaseDetailProducts = financeDao.query(purchaseDetailProduct);
                                Iterator<PurchaseDetailProduct> iterator1 = purchaseDetailProducts.iterator();
                                while (iterator1.hasNext()){
                                    purchaseDetailProduct = iterator1.next();
                                    break;
                                }
                                // 采购明细与产品关联id
                                Integer id = purchaseDetailProduct.getId();
                                // 采购明细对应商品的商品类型
                                ProductType productType = ((PurchaseDetailProduct)financeDao.queryById(id,PurchaseDetailProduct.class)).getProduct().getType();
                                voucherItemSourceDetail.setEntity("productType");
                                voucherItemSourceDetail.setEntityId(productType.getId());
                                financeDao.save(voucherItemSourceDetail);
                            }

                            // 查询采购单的支付记录
                            Pay pay = new Pay();
                            pay.setEntity("purchase");
                            pay.setEntityId(purchase.getId());
                            List<Pay> pays = financeDao.query(pay);
                            if (pays != null && !pays.isEmpty()){
                                for (Pay pay1 : pays){
                                    voucherItemSourceDetail.setEntity("payType");
                                    // 获取支付方式
                                    Integer payType = pay1.getPayType();
                                    voucherItemSourceDetail.setEntityId(payType);
                                    financeDao.save(voucherItemSourceDetail);
                                    // 获取付款账号
                                    String payAccount = pay1.getPayAccount();
                                    // 查询付款账号所对应的账户
                                    Account account = new Account();
                                    account.setAccount(payAccount);
                                    account = (Account) financeDao.query(account).get(0);
                                    voucherItemSourceDetail.setEntity("account");
                                    voucherItemSourceDetail.setEntityId(account.getId());
                                    financeDao.save(voucherItemSourceDetail);
                                }
                            }
                        }
                    } else {
                        continue;
                    }
                }
            }
        }

        //查询入库单和出库单
        List<StockInOut> stockInOuts = financeDao.complexQuery(StockInOut.class, queryParameters, 0, -1);
        if (stockInOuts != null && !stockInOuts.isEmpty()){
            for (StockInOut stockInOut:stockInOuts) {
                if (stockInOut != null) {
                    if (stockInOut.getState() == 1){
                        VoucherItemSource voucherItemSource = new VoucherItemSource();
                        // 设置制单人
                        voucherItemSource.setChartMaker(stockInOut.getInputer());
                        //设置单据日期
                        voucherItemSource.setDate(stockInOut.getInputDate());
                        // 设置出库和入库仓库
                        voucherItemSource.setWarehouse(stockInOut.getWarehouse());
                        // 设置单据类型
                        Integer type = stockInOut.getType();
                        if (type <= 2 || type == 4 || type == 16){
                            // 入库单
                            docType.setId(2);
                        } else if (type ==11 || type == 14 || type == 15 || type == 51){
                            // 出库单
                            docType.setId(4);
                        } else if (type == 3 || type == 5){
                            // 形态转换单
                            docType.setId(7);
                        } else if (type == 12){
                            // 报损出库单
                            docType.setId(8);
                        } else {
                            continue;
                        }
                        voucherItemSource.setDocType(docType);
                        // 设置业务类型
                        if (type == 0) {
                            voucherItemSource.setBusinessType("现金入库");
                        } else if (type == 1) {
                            voucherItemSource.setBusinessType("代销入库");
                        } else if (type == 2) {
                            voucherItemSource.setBusinessType("增量入库");
                        } else if (type == 3) {
                            voucherItemSource.setBusinessType("加工入库");
                        } else if (type == 4) {
                            voucherItemSource.setBusinessType("押金入库");
                        } else if (type == 5) {
                            voucherItemSource.setBusinessType("修补入库");
                        } else if (type == 51) {
                            voucherItemSource.setBusinessType("销售退货");
                        } else if (type == 6) {
                            voucherItemSource.setBusinessType("调仓入库");
                        } else if (type == 11) {
                            voucherItemSource.setBusinessType("系统自动出库");
                        } else if (type == 12) {
                            voucherItemSource.setBusinessType("报损出库");
                        } else if (type == 13) {
                            voucherItemSource.setBusinessType("调仓出库");
                        } else if (type == 14) {
                            voucherItemSource.setBusinessType("内购出库");
                        } else if (type == 15) {
                            voucherItemSource.setBusinessType("正常出库");
                        } else if (type == 16){
                            voucherItemSource.setBusinessType("采购退货");
                        }
                        // 设置单据编号
                        voucherItemSource.setDocNo(stockInOut.getNo());
                        Float amount = 0.0f;
                        Set<StockInOutDetail> stockInOutDetails = stockInOut.getDetails();
                        StockInOutDetailProduct stockInOutDetailProduct = new StockInOutDetailProduct();
                        if (type == 4){
                            amount += stockInOut.getDeposit().getAmount();
                        } else {
                            Float unitPrice = 0.0f;
                            for (StockInOutDetail stockInOutDetail : stockInOutDetails) {
                                stockInOutDetailProduct.setStockInOutDetail(stockInOutDetail);
                                List<StockInOutDetailProduct> stockInOutDetailProducts = financeDao.query(stockInOutDetailProduct);
                                for (StockInOutDetailProduct stockInOutDetailProduct1 : stockInOutDetailProducts) {
                                    Integer id = stockInOutDetailProduct1.getId();
                                    stockInOutDetailProduct1 = (StockInOutDetailProduct) financeDao.queryById(id, StockInOutDetailProduct.class);
                                    unitPrice = stockInOutDetailProduct1.getProduct().getUnitPrice();
                                    break;
                                }
                                amount += unitPrice * stockInOutDetail.getQuantity();
                            }
                        }
                        // 设置金额
                        voucherItemSource.setAmount(amount);
                        if (type == 3 || type == 5){
                            // 设置扩展字段，这里是加工费
                            Float processBill = stockInOut.getProcessRepair().getExpense();
                            voucherItemSource.setExtend(processBill.toString());
                        }
                        // 设置备注
                        voucherItemSource.setRemark(stockInOut.getDescribes());
                        voucherItemSource.setState(1);
                        result = financeDao.save(voucherItemSource);
                        if (result == "success"){
                            VoucherItemSourceDetail voucherItemSourceDetail = new VoucherItemSourceDetail();
                            voucherItemSourceDetail.setVoucherItemSource(voucherItemSource);
                            for (StockInOutDetail stockInOutDetail : stockInOutDetails){
                                stockInOutDetail = (StockInOutDetail) financeDao.query(stockInOutDetail).get(0);
                                Set<StockInOutDetailProduct> stockInOutDetailProducts = stockInOutDetail.getStockInOutDetailProducts();
                                Iterator<StockInOutDetailProduct> iterator = stockInOutDetailProducts.iterator();
                                while (iterator.hasNext()){
                                    stockInOutDetailProduct = iterator.next();
                                    break;
                                }
                                // 出入库明细与产品关联id
                                Integer id = stockInOutDetailProduct.getId();
                                // 出入库明细对应商品的商品类型
                                ProductType productType = ((StockInOutDetailProduct)financeDao.queryById(id,StockInOutDetailProduct.class)).getProduct().getType();
                                voucherItemSourceDetail.setEntity("productType");
                                voucherItemSourceDetail.setEntityId(productType.getId());
                                financeDao.save(voucherItemSourceDetail);
                            }
                        }
                    } else {
                        continue;
                    }
                }
            }
        }

        //查询订单
        String json1 = "{\"soldDate\":\""+date+"\"}";
        try {
            queryParameters = writer.gson.fromJson(json1, new TypeToken<Map<String, String>>(){}.getType());
        } catch (Exception e){
            e.getMessage();
        }
        List<Order> orders = financeDao.complexQuery(Order.class, queryParameters, 0, -1);
        if (orders != null && !orders.isEmpty()){
            for (Order order:orders) {
                if (order != null) {
                    VoucherItemSource voucherItemSource = new VoucherItemSource();
                    // 设置制单人
                    voucherItemSource.setChartMaker(order.getSaler());
                    // 设置单据日期
                    voucherItemSource.setDate(order.getDate());
                    // 设置单据类型为销售订单
                    docType.setId(3);
                    voucherItemSource.setDocType(docType);
                    // 设置业务类型
                    Integer type = order.getType();
                    if (type == 0) {
                        voucherItemSource.setBusinessType("自助下单");
                    } else if (type == 1) {
                        voucherItemSource.setBusinessType("代下单");
                    } else if (type == 2) {
                        voucherItemSource.setBusinessType("私人订制");
                    } else if (type == 3) {
                        voucherItemSource.setBusinessType("预定");
                    } else if (type == 4) {
                        voucherItemSource.setBusinessType("代下单加工");
                    } else if (type == 5) {
                        voucherItemSource.setBusinessType("换货订单");
                    }
                    // 设置单据编号
                    voucherItemSource.setDocNo(order.getNo());
                    // 设置往来单位，对于订单来说往来单位就是客户
                    Integer id = order.getUser().getCustomer().getId();
                    Customer customer = (Customer) financeDao.queryById(id, Customer.class);
                    voucherItemSource.setContactUnit(customer.getName());
                    // 设置金额和备注
                    voucherItemSource.setAmount(order.getPayAmount());
                    voucherItemSource.setRemark(order.getDescribes());
                    voucherItemSource.setState(1);
                    result = financeDao.save(voucherItemSource);
                    if (result == "success"){
                        VoucherItemSourceDetail voucherItemSourceDetail = new VoucherItemSourceDetail();
                        voucherItemSourceDetail.setVoucherItemSource(voucherItemSource);
                        OrderDetailProduct orderDetailProduct = new OrderDetailProduct();
                        Set<OrderDetail> orderDetails = order.getDetails();
                        for (OrderDetail orderDetail : orderDetails){
                            orderDetailProduct.setOrderDetail(orderDetail);
                            List<OrderDetailProduct> orderDetailProducts = financeDao.query(orderDetailProduct);
                            Iterator<OrderDetailProduct> iterator = orderDetailProducts.iterator();
                            while (iterator.hasNext()){
                                orderDetailProduct = iterator.next();
                                break;
                            }
                            // 订单明细与产品关联id
                            Integer id1 = orderDetailProduct.getId();
                            // 订单明细对应商品的商品类型
                            ProductType productType = ((OrderDetailProduct)financeDao.queryById(id1,OrderDetailProduct.class)).getProduct().getType();
                            voucherItemSourceDetail.setEntity("productType");
                            voucherItemSourceDetail.setEntityId(productType.getId());
                            financeDao.save(voucherItemSourceDetail);
                        }

                        // 查询订单的支付记录
                        Pay pay = new Pay();
                        pay.setEntity("order");
                        pay.setEntityId(order.getId());
                        List<Pay> pays = financeDao.query(pay);
                        if (pays != null && !pays.isEmpty()){
                            for (Pay pay1 : pays){
                                voucherItemSourceDetail.setEntity("payType");
                                // 获取支付方式
                                Integer payType = pay1.getPayType();
                                voucherItemSourceDetail.setEntityId(payType);
                                financeDao.save(voucherItemSourceDetail);
                                // 获取收款账号
                                String receiptAccount = pay1.getReceiptAccount();
                                // 查询收款账号所对应的账户
                                Account account = new Account();
                                account.setAccount(receiptAccount);
                                account = (Account) financeDao.query(account).get(0);
                                voucherItemSourceDetail.setEntity("account");
                                voucherItemSourceDetail.setEntityId(account.getId());
                                financeDao.save(voucherItemSourceDetail);
                            }
                        }
                    }
                }
            }
        }

        // 查询付款单和收款单
        String json2 = "{\"payDate\":\""+date+"\"}";
        try {
            queryParameters = writer.gson.fromJson(json2, new TypeToken<Map<String, String>>(){}.getType());
        } catch (Exception e){
            e.getMessage();
        }
        List<Pay> pays = financeDao.complexQuery(Pay.class, queryParameters, 0, -1);
        if (pays != null && !pays.isEmpty()){
            Purchase purchase = new Purchase();
            PurchaseBook purchaseBook = new PurchaseBook();
            PurchaseDetail purchaseDetail = new PurchaseDetail();
            Order order = new Order();
            OrderBook orderBook = new OrderBook();
            for (Pay pay:pays) {
                if (pay != null && !pay.getEntity().equals("changeProduct")) {
                    VoucherItemSource voucherItemSource = new VoucherItemSource();
                    // 设置单据日期
                    voucherItemSource.setDate(pay.getPayDate());
                    String entity = pay.getEntity();
                    Integer id = pay.getEntityId();
                    if (pay.getBalanceType() == 1){
                        // 设置单据类型为付款单
                        docType.setId(5);
                        voucherItemSource.setDocType(docType);
                        purchase.setId(id);
                        purchaseBook.setPurchase(purchase);
                        List<PurchaseBook> purchaseBooks = financeDao.query(purchaseBook);
                        if (purchaseBooks != null && !purchaseBooks.isEmpty()){
                            voucherItemSource.setBusinessType("预付款");
                        } else {
                            voucherItemSource.setBusinessType("普通付款");
                        }
                        purchaseDetail.setPurchase(purchase);
                        // 获取供应商的名称
                        String supplier = ((PurchaseDetail)financeDao.query(purchaseDetail).get(0)).getSupplier().getName();
                        voucherItemSource.setContactUnit(supplier);
                    } else {
                        // 设置单据类型为收款单
                        docType.setId(6);
                        voucherItemSource.setDocType(docType);
                        if (entity.equals("order")) {
                            order.setId(id);
                            orderBook.setOrder(order);
                            List<OrderBook> orderBooks = financeDao.query(orderBook);
                            if (orderBooks != null && !orderBooks.isEmpty()) {
                                voucherItemSource.setBusinessType("预收款");
                            } else {
                                voucherItemSource.setBusinessType("普通收款");
                            }
                        } else {
                            voucherItemSource.setBusinessType("修补货品");
                        }
                        Customer customer = pay.getUser().getCustomer();
                        // 获取客户的名字
                        String customerName = ((Customer)financeDao.queryById(customer.getId(),Customer.class)).getName();
                        voucherItemSource.setContactUnit(customerName);
                    }
                    voucherItemSource.setDocNo(pay.getNo());
                    voucherItemSource.setAmount(pay.getAmount());
                    voucherItemSource.setState(1);
                    result = financeDao.save(voucherItemSource);
                    if (result == "success"){
                        VoucherItemSourceDetail voucherItemSourceDetail = new VoucherItemSourceDetail();
                        voucherItemSourceDetail.setVoucherItemSource(voucherItemSource);
                        Account account = new Account();
                        if (voucherItemSource.getDocType().getId()==5){
                            // 获取付款账号
                            String payAccount = pay.getPayAccount();
                            account.setAccount(payAccount);
                        } else {
                            // 获取收款账号
                            String receiptAccount = pay.getReceiptAccount();
                            account.setAccount(receiptAccount);
                        }
                        // 查询付款账号或者收款账号所对应的账户
                        account = (Account) financeDao.query(account).get(0);
                        voucherItemSourceDetail.setEntity("account");
                        voucherItemSourceDetail.setEntityId(account.getId());
                        financeDao.save(voucherItemSourceDetail);
                    }
                }
            }
        }

        // 查询采购退货单和销售退货单
        String json3 = "{\"date\":\""+date+"\"}";
        try {
            queryParameters = writer.gson.fromJson(json3, new TypeToken<Map<String, String>>(){}.getType());
        } catch (Exception e){
            e.getMessage();
        }
        List<ReturnProduct> returnProducts = financeDao.complexQuery(ReturnProduct.class, queryParameters, 0, -1);
        if (returnProducts != null && !returnProducts.isEmpty()){
            for (ReturnProduct returnProduct:returnProducts) {
                if (returnProduct != null) {
                    Integer state = returnProduct.getState();
                    if (state == 1 || state == 61){
                        VoucherItemSource voucherItemSource = new VoucherItemSource();
                        // 设置单据日期
                        voucherItemSource.setDate(returnProduct.getDate());
                        // 设置单据编号
                        voucherItemSource.setDocNo(returnProduct.getNo());
                        Action action = new Action();
                        action.setEntity("returnProduct");
                        action.setEntityId(returnProduct.getId());
                        List<Action> actions = financeDao.query(action);
                        if (actions != null && !actions.isEmpty()){
                            action = actions.get(actions.size()-1);
                            voucherItemSource.setChartMaker(action.getInputer());
                        }
                        Set<ReturnProductDetail> returnProductDetails = returnProduct.getDetails();
                        ReturnProductDetailProduct returnProductDetailProduct = new ReturnProductDetailProduct();
                        if (returnProduct.getEntity().equals(FinanceConstant.returnproduct_purchase)){
                            // 设置单据类型为采购单
                            docType.setId(1);
                            voucherItemSource.setDocType(docType);
                            // 设置业务类型
                            voucherItemSource.setBusinessType("采购退货");
                            // 设置往来单位，对于采购退货来说就是供应商
                            Iterator<ReturnProductDetail> iterator = returnProductDetails.iterator();
                            ReturnProductDetail returnProductDetail = null;
                            while (iterator.hasNext()){
                                returnProductDetail = iterator.next();
                                break;
                            }
                            returnProductDetailProduct.setReturnProductDetail(returnProductDetail);
                            List<ReturnProductDetailProduct> returnProductDetailProducts = financeDao.query(returnProductDetailProduct);
                            Iterator<ReturnProductDetailProduct> iterator1 = returnProductDetailProducts.iterator();
                            while (iterator1.hasNext()){
                                returnProductDetailProduct = (ReturnProductDetailProduct) financeDao.queryById(iterator1.next().getId(),ReturnProductDetailProduct.class);
                                break;
                            }
                            Supplier supplier = (Supplier)financeDao.queryById(returnProductDetailProduct.getProduct().getSupplier().getId(),Supplier.class);
                            voucherItemSource.setContactUnit(supplier.getName());
                        } else {
                            // 设置单据类型为销售订单
                            docType.setId(3);
                            voucherItemSource.setDocType(docType);
                            // 设置业务类型
                            voucherItemSource.setBusinessType("销售退货");
                            // 设置往来单位，对于销售退货来说就是客户
                            Customer customer = (Customer)financeDao.queryById(returnProduct.getUser().getCustomer().getId(),Customer.class);
                            voucherItemSource.setContactUnit(customer.getName());
                        }
                        // 设置金额和备注
                        voucherItemSource.setAmount(returnProduct.getAmount());
                        voucherItemSource.setRemark(returnProduct.getReason());
                        voucherItemSource.setState(1);
                        result = financeDao.save(voucherItemSource);
                        if (result == "success"){
                            VoucherItemSourceDetail voucherItemSourceDetail = new VoucherItemSourceDetail();
                            voucherItemSourceDetail.setVoucherItemSource(voucherItemSource);
                            for (ReturnProductDetail returnProductDetail : returnProductDetails){
                                returnProductDetailProduct.setReturnProductDetail(returnProductDetail);
                                List<ReturnProductDetailProduct> returnProductDetailProducts = financeDao.query(returnProductDetailProduct);
                                Iterator<ReturnProductDetailProduct> iterator1 = returnProductDetailProducts.iterator();
                                while (iterator1.hasNext()){
                                    returnProductDetailProduct = iterator1.next();
                                    break;
                                }
                                // 采购退货明细与产品关联id
                                Integer id = returnProductDetailProduct.getId();
                                // 采购退货明细对应商品的商品类型
                                ProductType productType = ((ReturnProductDetailProduct)financeDao.queryById(id,ReturnProductDetailProduct.class)).getProduct().getType();
                                voucherItemSourceDetail.setEntity("productType");
                                voucherItemSourceDetail.setEntityId(productType.getId());
                                financeDao.save(voucherItemSourceDetail);
                            }

                            // 查询采购退货单和销售退货单的支付记录
                            Pay pay = new Pay();
                            pay.setEntity("returnProduct");
                            pay.setEntityId(returnProduct.getId());
                            pays = financeDao.query(pay);
                            if (pays !=null && !pays.isEmpty()){
                                for (Pay pay1 : pays){
                                    voucherItemSourceDetail.setEntity("payType");
                                    // 获取支付方式
                                    Integer payType = pay1.getPayType();
                                    voucherItemSourceDetail.setEntityId(payType);
                                    financeDao.save(voucherItemSourceDetail);
                                    Account account = new Account();
                                    if (returnProduct.getEntity().equals(FinanceConstant.returnproduct_purchase)){
                                        //获取收款账号
                                        String receiptAccount = pay.getReceiptAccount();
                                        account.setAccount(receiptAccount);
                                    } else {
                                        // 获取付款账号
                                        String payAccount = pay1.getPayAccount();
                                        account.setAccount(payAccount);
                                    }
                                    // 查询付款账号所对应的账户
                                    account = (Account) financeDao.query(account).get(0);
                                    voucherItemSourceDetail.setEntity("account");
                                    voucherItemSourceDetail.setEntityId(account.getId());
                                    financeDao.save(voucherItemSourceDetail);
                                }
                            }
                        }
                    } else {
                        continue;
                    }
                }
            }
        }

        //  查询退款单
        String json4 = "{\"refundDate\":\""+date+"\"}";
        try {
            queryParameters = writer.gson.fromJson(json4, new TypeToken<Map<String, String>>(){}.getType());
        } catch (Exception e){
            e.getMessage();
        }
        List<Refund> refunds = financeDao.complexQuery(Refund.class, queryParameters, 0, -1);
        if (refunds != null && !refunds.isEmpty()){
            for (Refund refund :refunds) {
                if (refund != null) {
                    VoucherItemSource voucherItemSource = new VoucherItemSource();
                    // 设置单据日期
                    voucherItemSource.setDate(refund.getRefundDate());
                    if (refund.getBalanceType() == 1){
                        // 设置单据类型为付款单
                        docType.setId(5);
                        voucherItemSource.setDocType(docType);
                        voucherItemSource.setBusinessType("采购退货");
                        Purchase purchase = new Purchase();
                        purchase.setId(refund.getPay().getEntityId());
                        PurchaseDetail purchaseDetail = new PurchaseDetail();
                        purchaseDetail.setPurchase(purchase);
                        purchaseDetail = (PurchaseDetail)(financeDao.query(purchaseDetail).get(0));
                        // 设置往来单位,对于采购退货的退款往来单位就是供应商
                        voucherItemSource.setContactUnit(purchaseDetail.getSupplier().getName());
                    } else {
                        // 设置单据类型为收款单
                        docType.setId(6);
                        voucherItemSource.setDocType(docType);
                        voucherItemSource.setBusinessType("销售退货");
                        Order order = new Order();
                        order = (Order)financeDao.queryById(refund.getPay().getEntityId(),Order.class);
                        Customer customer = (Customer) financeDao.queryById(order.getUser().getCustomer().getId(),Customer.class);
                        // 设置往来单位，对于销售退货的退款往来单位就是客户
                        voucherItemSource.setContactUnit(customer.getName());
                    }
                    voucherItemSource.setDocNo(refund.getNo());
                    voucherItemSource.setAmount(refund.getAmount());
                    voucherItemSource.setState(1);
                    result = financeDao.save(voucherItemSource);
                    if (result == "success"){
                        VoucherItemSourceDetail voucherItemSourceDetail = new VoucherItemSourceDetail();
                        voucherItemSourceDetail.setVoucherItemSource(voucherItemSource);
                        Account account = new Account();
                        if (voucherItemSource.getDocType().getId()==5){
                            // 获取收款账号
                            account.setAccount(refund.getPay().getPayAccount());
                        } else {
                            // 获取付款账号
                            account.setAccount(refund.getPay().getReceiptAccount());
                        }
                        // 查询付款账号或者收款账号所对应的账户
                        account = (Account) financeDao.query(account).get(0);
                        voucherItemSourceDetail.setEntity("account");
                        voucherItemSourceDetail.setEntityId(account.getId());
                        financeDao.save(voucherItemSourceDetail);
                    }
                }
            }
        }
    }

    /**
     * 每天凌晨0点扫描销售订单，如果有新生成的做相应处理后插入到销售毛利分析表中
     */
    @Transactional
    @Scheduled(cron = "0 0 0 * * ?")
    public void generateGrossProfit(){
        Map<String, String> queryParameters = null;
        String date1 = dayFormat.format(dateUtil.getForwardDay(1));
        String date2 = dayFormat.format(new Date(System.currentTimeMillis()));
        String date = date1 + " - " + date2;

        //查询订单
        String json = "{\"soldDate\":\""+date+"\"}";
        try {
            queryParameters = writer.gson.fromJson(json, new TypeToken<Map<String, String>>(){}.getType());
        } catch (Exception e){
            e.getMessage();
        }
        List<Order> orders = financeDao.complexQuery(Order.class, queryParameters, 0, -1);
        if (orders != null && !orders.isEmpty()){
            sortOfOrder(orders);
            for (Order order:orders) {
                if (order != null) {
                    Integer type = order.getType();
                    // 设置业务类型
                    String businessType = "";
                    if (type == 0) {
                        businessType = "自助下单";
                    } else if (type == 1) {
                        businessType = "代下单";
                    } else if (type == 2) {
                        businessType = "私人订制";
                    } else if (type == 3) {
                        businessType = "预定";
                    } else if (type == 4) {
                        businessType = "代下加工单";
                    } else if (type == 5){
                        businessType = "换货订单";
                    }
                    Set<OrderDetail> orderDetails = order.getDetails();
                    for (OrderDetail orderDetail : orderDetails){
                        GrossProfit grossProfit = new GrossProfit();
                        // 设置业务类型
                        grossProfit.setBusinessType(businessType);
                        // 设置销售日期
                        grossProfit.setDate(order.getSoldDate());
                        // 设置销售订单号
                        grossProfit.setNo(order.getNo());
                        // 设置业务员
                        grossProfit.setChartMaker(order.getSaler());
                        // 设置客户
                        grossProfit.setCustomer(order.getUser().getCustomer());
                        // 设置计量单位
                        grossProfit.setUnit(orderDetail.getUnit());
                        OrderDetail orderDetail1 = (OrderDetail) financeDao.queryById(orderDetail.getId(),OrderDetail.class);
                        // 获取关联商品
                        Set<OrderDetailProduct> orderDetailProducts = orderDetail1.getOrderDetailProducts();
                        Iterator<OrderDetailProduct> iterator = orderDetailProducts.iterator();
                        OrderDetailProduct orderDetailProduct = null;
                        while (iterator.hasNext()){
                            orderDetailProduct = iterator.next();
                            break;
                        }
                        orderDetailProduct = (OrderDetailProduct) financeDao.queryById(orderDetailProduct.getId(),OrderDetailProduct.class);
                        // 设置商品类型
                        grossProfit.setType(orderDetailProduct.getProduct().getType());
                        grossProfit.setProductNo(orderDetail1.getProductNo());
                        grossProfit.setProductName(orderDetailProduct.getProduct().getName());
                        grossProfit.setQuantity(orderDetail1.getQuantity());
                        grossProfit.setUnitPrice(orderDetail1.getProductPrice());
                        grossProfit.setDiscount(orderDetail1.getDiscount());
                        grossProfit.setSaleAmount(orderDetail1.getPayAmount());
                        grossProfit.setCost(orderDetailProduct.getProduct().getUnitPrice()*grossProfit.getQuantity());
                        grossProfit.setGrossProfit(grossProfit.getSaleAmount()-grossProfit.getCost());
                        grossProfit.setGrossProfitRate(DecimalToPercent.change(grossProfit.getGrossProfit()/grossProfit.getSaleAmount()));
                        if (type == 4){
                            Float processIncome = 0.0f;
                            Float processCost = 0.0f;
                            // 用来存储根据代下加工单里面的商品查询出来的对应的加工入库单
                            List<StockInOut> stockInOuts = new ArrayList<StockInOut>();
                            // 将Set集合orderDetailProducts转化为List集合
                            List<OrderDetailProduct> orderDetailProducts1 = new ArrayList<>(orderDetailProducts);
                            StockInOutDetailProduct stockInOutDetailProduct = new StockInOutDetailProduct();
                            for (int i = 0; i < orderDetailProducts1.size(); i++){
                                stockInOutDetailProduct.setProduct(orderDetailProducts1.get(i).getProduct());
                                // 因为查询的订单都是销售完成了的，所以这里去查询该订单里的商品对应的加工入库单肯定能查到。
                                StockInOutDetailProduct  stockInOutDetailProduct1 = (StockInOutDetailProduct) financeDao.query(stockInOutDetailProduct).get(0);
                                StockInOutDetail stockInOutDetail = stockInOutDetailProduct1.getStockInOutDetail();
                                StockInOut stockInOut = (StockInOut) financeDao.queryById(stockInOutDetail.getStockInOut().getId(),StockInOut.class);
                                stockInOuts.add(stockInOut);
                                if (i != 0){
                                    // 判断加工入库单是否为同一个的标志，false代表不是，true代表是
                                    boolean flag = false;
                                    for (StockInOut stockInOut1 : stockInOuts){
                                        if (stockInOut.getId() == stockInOut1.getId()){
                                            flag = true;
                                            break;
                                        }
                                    }
                                    if (flag == false){
                                        processIncome += stockInOut.getProcessRepair().getSaleExpense();
                                        processCost += stockInOut.getProcessRepair().getExpense();
                                    }
                                } else {
                                    processIncome += stockInOut.getProcessRepair().getSaleExpense();
                                    processCost += stockInOut.getProcessRepair().getExpense();
                                }
                            }
                            grossProfit.setProcessIncome(processIncome);
                            grossProfit.setProcessCost(processCost);
                            grossProfit.setProcessGrossProfit(grossProfit.getProcessIncome()-grossProfit.getProcessCost());
                            grossProfit.setProcessGrossProfitRate(DecimalToPercent.change(grossProfit.getProcessGrossProfit()/grossProfit.getProcessIncome()));
                        }
                        financeDao.save(grossProfit);
                    }
                }
            }
        }
    }


    /**
     * 每天凌晨0点扫描销售订单、收款单、退货单和收支类型为支出的退款单，如果有新生成的做相应处理后插入到客户往来对账表中
     */
    @Transactional
    @Scheduled(cron = "0 0 0 * * ?")
    public void generateCustomerContact() {
        Map<String, String> queryParameters = null;
        String date1 = dayFormat.format(dateUtil.getForwardDay(1));
        String date2 = dayFormat.format(new Date(System.currentTimeMillis()));
        String date = date1 + " - " + date2;
        String flag = "";

        //查询订单
        String json = "{\"soldDate\":\"" + date + "\"}";
        try {
            queryParameters = writer.gson.fromJson(json, new TypeToken<Map<String, String>>() {
            }.getType());
        } catch (Exception e) {
            e.getMessage();
        }
        List<Order> orders = financeDao.complexQuery(Order.class, queryParameters, 0, -1);
        if (orders != null && !orders.isEmpty()){
            sortOfOrder(orders);
            for (Order order:orders) {
                if (order != null) {
                    Set<OrderDetail> orderDetails = order.getDetails();
                    for (OrderDetail orderDetail : orderDetails) {
                        CustomerContact customerContact = new CustomerContact();
                        customerContact.setCustomer(order.getUser().getCustomer());
                        customerContact.setDate(order.getSoldDate());
                        DocType docType = new DocType();
                        docType.setId(3);
                        customerContact.setDocType(docType);
                        customerContact.setNo(order.getNo());
                        customerContact.setProductNo(orderDetail.getProductNo());
                        OrderDetail orderDetail1 = (OrderDetail) financeDao.queryById(orderDetail.getId(),OrderDetail.class);
                        // 获取关联商品,为的是得到每一条明细中商品的名称
                        Set<OrderDetailProduct> orderDetailProducts = orderDetail1.getOrderDetailProducts();
                        Iterator<OrderDetailProduct> iterator = orderDetailProducts.iterator();
                        OrderDetailProduct orderDetailProduct = null;
                        while (iterator.hasNext()){
                            orderDetailProduct = iterator.next();
                            break;
                        }
                        orderDetailProduct = (OrderDetailProduct) financeDao.queryById(orderDetailProduct.getId(),OrderDetailProduct.class);
                        customerContact.setProductName(orderDetailProduct.getProduct().getName());
                        customerContact.setUnit(orderDetail.getUnit());
                        customerContact.setQuantity(orderDetail.getQuantity());
                        customerContact.setUnitPrice(orderDetail.getProductPrice());
                        customerContact.setReceivable(orderDetail.getPayAmount());
                        CustomerContact customerContact1 = new CustomerContact();
                        customerContact1.setCustomer(customerContact.getCustomer());
                        // 得到数据库中customer为当前需要保存的这条客户往来对账记录的customer的所有客户往来对账记录
                        List<CustomerContact> customerContacts = financeDao.query(customerContact1);
                        // 客户往来对账记录表的记录是应还是已的标志
                        flag = FinanceConstant.SHOULD;
                        setBeginAndReceivableOrReceivedOfCustomerContact(customerContacts,customerContact,flag);
                        financeDao.save(customerContact);
                    }
                }
            }
        }

        //查询收款单
        String json1 = "{\"payDate\":\"" + date + "\"}";
        try {
            queryParameters = writer.gson.fromJson(json1, new TypeToken<Map<String, String>>() {
            }.getType());
        } catch (Exception e) {
            e.getMessage();
        }
        List<Pay> pays = financeDao.complexQuery(Pay.class, queryParameters, 0, -1);
        if (pays != null && !pays.isEmpty()){
            sortOfPay(pays);
            for (Pay pay:pays) {
                if (pay != null) {
                    if (pay.getBalanceType() == 0){
                        CustomerContact customerContact = new CustomerContact();
                        customerContact.setCustomer(pay.getUser().getCustomer());
                        customerContact.setDate(pay.getPayDate());
                        DocType docType = new DocType();
                        docType.setId(6);
                        customerContact.setDocType(docType);
                        customerContact.setNo(pay.getNo());
                        customerContact.setReceived(pay.getAmount());
                        CustomerContact customerContact1 = new CustomerContact();
                        customerContact1.setCustomer(customerContact.getCustomer());
                        // 得到数据库中customer为当前需要保存的这条客户往来对账记录的customer的所有客户往来对账记录
                        List<CustomerContact> customerContacts = financeDao.query(customerContact1);
                        flag = FinanceConstant.ALREADY;
                        setBeginAndReceivableOrReceivedOfCustomerContact(customerContacts,customerContact,flag);
                        financeDao.save(customerContact);
                    }
                }
            }
        }

        //查询退货单
        String json2 = "{\"date\":\"" + date + "\"}";
        try {
            queryParameters = writer.gson.fromJson(json2, new TypeToken<Map<String, String>>() {
            }.getType());
        } catch (Exception e) {
            e.getMessage();
        }
        List<ReturnProduct> returnProducts = financeDao.complexQuery(ReturnProduct.class, queryParameters, 0, -1);
        if (returnProducts != null && !returnProducts.isEmpty()){
            sortOfReturnProduct(returnProducts);
            for (ReturnProduct returnProduct:returnProducts) {
                if (returnProduct != null) {
                    // 对应的实体为销售订单
                    if (returnProduct.getEntity().equals(FinanceConstant.returnproduct_order)){
                        Set<ReturnProductDetail> returnProductDetails = returnProduct.getDetails();
                        for (ReturnProductDetail returnProductDetail : returnProductDetails) {
                            CustomerContact customerContact = new CustomerContact();
                            customerContact.setCustomer(returnProduct.getUser().getCustomer());
                            customerContact.setDate(returnProduct.getDate());
                            DocType docType = new DocType();
                            docType.setId(3);
                            customerContact.setDocType(docType);
                            customerContact.setNo(returnProduct.getNo());
                            customerContact.setProductNo(returnProductDetail.getProductNo());
                            ReturnProductDetail returnProductDetail1 = (ReturnProductDetail) financeDao.queryById(returnProductDetail.getId(),ReturnProductDetail.class);
                            // 获取关联商品
                            Set<ReturnProductDetailProduct> returnProductDetailProducts = returnProductDetail1.getReturnProductDetailProducts();
                            Iterator<ReturnProductDetailProduct> iterator = returnProductDetailProducts.iterator();
                            ReturnProductDetailProduct returnProductDetailProduct = null;
                            while (iterator.hasNext()){
                                returnProductDetailProduct = iterator.next();
                                break;
                            }
                            returnProductDetailProduct = (ReturnProductDetailProduct) financeDao.queryById(returnProductDetailProduct.getId(),ReturnProductDetailProduct.class);
                            customerContact.setProductName(returnProductDetailProduct.getProduct().getName());
                            customerContact.setUnit(returnProductDetail.getUnit());
                            customerContact.setQuantity(returnProductDetail.getQuantity());
                            customerContact.setUnitPrice(returnProductDetail.getPrice());
                            customerContact.setReceivable(-returnProductDetail.getAmount());
                            CustomerContact customerContact1 = new CustomerContact();
                            customerContact1.setCustomer(customerContact.getCustomer());
                            List<CustomerContact> customerContacts = financeDao.query(customerContact1);
                            flag = FinanceConstant.SHOULD;
                            setBeginAndReceivableOrReceivedOfCustomerContact(customerContacts,customerContact,flag);
                            financeDao.save(customerContact);
                        }
                    }
                }
            }
        }

        //查询退款单
        String json3 = "{\"refundDate\":\"" + date + "\"}";
        try {
            queryParameters = writer.gson.fromJson(json3, new TypeToken<Map<String, String>>() {
            }.getType());
        } catch (Exception e) {
            e.getMessage();
        }
        List<Refund> refunds = financeDao.complexQuery(Refund.class, queryParameters, 0, -1);
        if (refunds != null && !refunds.isEmpty()){
            sortOfRefund(refunds);
            for (Refund refund:refunds) {
                if (refund != null) {
                    // 收支类型为支出
                    if (refund.getBalanceType() == 0){
                        CustomerContact customerContact = new CustomerContact();
                        // 因为收支类型为支出，所以退款单中对应的实体为退货单，而退货单中对应的实体为销售订单
                        ReturnProduct returnProduct = (ReturnProduct) financeDao.queryById(refund.getEntityId(),ReturnProduct.class);
                        Order order = (Order) financeDao.queryById(returnProduct.getEntityId(),Order.class);
                        customerContact.setCustomer(order.getUser().getCustomer());
                        customerContact.setDate(refund.getRefundDate());
                        DocType docType = new DocType();
                        docType.setId(6);
                        customerContact.setDocType(docType);
                        customerContact.setNo(refund.getNo());
                        customerContact.setReceived(-refund.getAmount());
                        CustomerContact customerContact1 = new CustomerContact();
                        customerContact1.setCustomer(customerContact.getCustomer());
                        List<CustomerContact> customerContacts = financeDao.query(customerContact1);
                        flag = FinanceConstant.ALREADY;
                        setBeginAndReceivableOrReceivedOfCustomerContact(customerContacts,customerContact,flag);
                        financeDao.save(customerContact);
                    }
                }
            }
        }
    }


    /**
     * 每天凌晨0点扫描采购单、付款单、退货单和收支类型为收入的退款单，如果有新生成的做相应处理后插入到供应商往来对账表中
     */
    @Transactional
    @Scheduled(cron = "0 0 0 * * ?")
    public void generateSupplierContact() {
        Map<String, String> queryParameters = null;
        String date1 = dayFormat.format(dateUtil.getForwardDay(1));
        String date2 = dayFormat.format(new Date(System.currentTimeMillis()));
        String date = date1 + " - " + date2;
        String flag = "";

        //查询采购单
        String json = "{\"inputDate\":\"" + date + "\"}";
        try {
            queryParameters = writer.gson.fromJson(json, new TypeToken<Map<String, String>>() {
            }.getType());
        } catch (Exception e) {
            e.getMessage();
        }
        List<Purchase> purchases = financeDao.complexQuery(Purchase.class, queryParameters, 0, -1);
        if (purchases != null && !purchases.isEmpty()){
            sortOfPurchase(purchases);
            for (Purchase purchase:purchases) {
                if (purchase != null) {
                    if (purchase.getState() == 1) {
                        Set<PurchaseDetail> purchaseDetails = purchase.getDetails();
                        for (PurchaseDetail purchaseDetail : purchaseDetails) {
                            SupplierContact supplierContact = new SupplierContact();
                            supplierContact.setSupplier(purchaseDetail.getSupplier());
                            supplierContact.setDate(purchase.getInputDate());
                            DocType docType = new DocType();
                            docType.setId(1);
                            supplierContact.setDocType(docType);
                            supplierContact.setNo(purchase.getNo());
                            supplierContact.setProductNo(purchaseDetail.getProductNo());
                            PurchaseDetail purchaseDetail1 = (PurchaseDetail) financeDao.queryById(purchaseDetail.getId(), PurchaseDetail.class);
                            // 获取关联商品，为的是得到每一条明细中商品的名称
                            Set<PurchaseDetailProduct> purchaseDetailProducts = purchaseDetail1.getPurchaseDetailProducts();
                            Iterator<PurchaseDetailProduct> iterator = purchaseDetailProducts.iterator();
                            PurchaseDetailProduct purchaseDetailProduct = null;
                            while (iterator.hasNext()) {
                                purchaseDetailProduct = iterator.next();
                                break;
                            }
                            purchaseDetailProduct = (PurchaseDetailProduct) financeDao.queryById(purchaseDetailProduct.getId(), PurchaseDetailProduct.class);
                            supplierContact.setProductName(purchaseDetailProduct.getProduct().getName());
                            supplierContact.setUnit(purchaseDetail.getUnit());
                            supplierContact.setQuantity(purchaseDetail.getQuantity());
                            supplierContact.setUnitPrice(purchaseDetail.getPrice());
                            supplierContact.setPayable(purchaseDetail.getAmount());
                            SupplierContact supplierContact1 = new SupplierContact();
                            supplierContact1.setSupplier(supplierContact.getSupplier());
                            // 得到数据库中supplier为当前需要保存的这条供应商往来对账记录的supplier的所有供应商往来对账记录
                            List<SupplierContact> supplierContacts = financeDao.query(supplierContact1);
                            flag = FinanceConstant.SHOULD;
                            setBeginAndPayableOrPaidOfSupplierContact(supplierContacts,supplierContact,flag);
                            financeDao.save(supplierContact);
                        }
                    } else {
                        continue;
                    }
                }
            }
        }

        //查询付款单
        String json1 = "{\"payDate\":\"" + date + "\"}";
        try {
            queryParameters = writer.gson.fromJson(json1, new TypeToken<Map<String, String>>() {
            }.getType());
        } catch (Exception e) {
            e.getMessage();
        }
        List<Pay> pays = financeDao.complexQuery(Pay.class, queryParameters, 0, -1);
        if (pays != null && !pays.isEmpty()){
            sortOfPay(pays);
            for (Pay pay:pays) {
                if (pay != null) {
                    if (pay.getBalanceType() == 1){
                        SupplierContact supplierContact = new SupplierContact();
                        Purchase purchase = (Purchase) financeDao.queryById(pay.getEntityId(),Purchase.class);
                        for (PurchaseDetail purchaseDetail : purchase.getDetails()){
                            supplierContact.setSupplier(purchaseDetail.getSupplier());
                            break;
                        }
                        supplierContact.setDate(pay.getPayDate());
                        DocType docType = new DocType();
                        docType.setId(5);
                        supplierContact.setDocType(docType);
                        supplierContact.setNo(pay.getNo());
                        supplierContact.setPaid(pay.getAmount());
                        SupplierContact supplierContact1 = new SupplierContact();
                        supplierContact1.setSupplier(supplierContact.getSupplier());
                        // 得到数据库中supplier为当前需要保存的这条供应商往来对账记录的supplier的所有供应商往来对账记录
                        List<SupplierContact> supplierContacts = financeDao.query(supplierContact1);
                        flag = FinanceConstant.ALREADY;
                        setBeginAndPayableOrPaidOfSupplierContact(supplierContacts,supplierContact,flag);
                        financeDao.save(supplierContact);
                    }
                }
            }
        }

        //查询退货单
        String json2 = "{\"date\":\"" + date + "\"}";
        try {
            queryParameters = writer.gson.fromJson(json2, new TypeToken<Map<String, String>>() {
            }.getType());
        } catch (Exception e) {
            e.getMessage();
        }
        List<ReturnProduct> returnProducts = financeDao.complexQuery(ReturnProduct.class, queryParameters, 0, -1);
        if (returnProducts != null && !returnProducts.isEmpty()){
            sortOfReturnProduct(returnProducts);
            for (ReturnProduct returnProduct:returnProducts) {
                if (returnProduct != null) {
                    // 对应的实体为采购单
                    if (returnProduct.getEntity().equals(FinanceConstant.returnproduct_purchase)){
                        SupplierContact supplierContact = new SupplierContact();
                        Purchase purchase = (Purchase) financeDao.queryById(returnProduct.getEntityId(),Purchase.class);
                        for (PurchaseDetail purchaseDetail : purchase.getDetails()){
                            supplierContact.setSupplier(purchaseDetail.getSupplier());
                            break;
                        }
                        Set<ReturnProductDetail> returnProductDetails = returnProduct.getDetails();
                        for (ReturnProductDetail returnProductDetail : returnProductDetails) {
                            supplierContact.setDate(returnProduct.getDate());
                            DocType docType = new DocType();
                            docType.setId(1);
                            supplierContact.setDocType(docType);
                            supplierContact.setNo(returnProduct.getNo());
                            supplierContact.setProductNo(returnProductDetail.getProductNo());
                            ReturnProductDetail returnProductDetail1 = (ReturnProductDetail) financeDao.queryById(returnProductDetail.getId(),ReturnProductDetail.class);
                            // 获取关联商品
                            Set<ReturnProductDetailProduct> returnProductDetailProducts = returnProductDetail1.getReturnProductDetailProducts();
                            Iterator<ReturnProductDetailProduct> iterator = returnProductDetailProducts.iterator();
                            ReturnProductDetailProduct returnProductDetailProduct = null;
                            while (iterator.hasNext()){
                                returnProductDetailProduct = iterator.next();
                                break;
                            }
                            returnProductDetailProduct = (ReturnProductDetailProduct) financeDao.queryById(returnProductDetailProduct.getId(),ReturnProductDetailProduct.class);
                            supplierContact.setProductName(returnProductDetailProduct.getProduct().getName());
                            supplierContact.setUnit(returnProductDetail.getUnit());
                            supplierContact.setQuantity(returnProductDetail.getQuantity());
                            supplierContact.setUnitPrice(returnProductDetail.getPrice());
                            supplierContact.setPayable(-returnProductDetail.getAmount());
                            SupplierContact supplierContact1 = new SupplierContact();
                            supplierContact1.setSupplier(supplierContact.getSupplier());
                            List<SupplierContact> supplierContacts = financeDao.query(supplierContact1);
                            flag = FinanceConstant.SHOULD;
                            setBeginAndPayableOrPaidOfSupplierContact(supplierContacts,supplierContact,flag);
                        }
                        financeDao.save(supplierContact);
                    }
                }
            }
        }

        //查询退款单
        String json3 = "{\"refundDate\":\"" + date + "\"}";
        try {
            queryParameters = writer.gson.fromJson(json3, new TypeToken<Map<String, String>>() {
            }.getType());
        } catch (Exception e) {
            e.getMessage();
        }
        List<Refund> refunds = financeDao.complexQuery(Refund.class, queryParameters, 0, -1);
        if (refunds != null && !refunds.isEmpty()){
            sortOfRefund(refunds);
            for (Refund refund:refunds) {
                if (refund != null) {
                    // 收支类型为收入
                    if (refund.getBalanceType() == 1){
                        SupplierContact supplierContact = new SupplierContact();
                        /*收支类型为收入的可能是正常的采购退货，也有可能是押金采购退货，如果是正常的采购退货则退款单中对应的实体是退货单，
                        而退货单中对应的实体是采购单，如果是押金采购退货则退款单对应的实体是入库类型为押金入库的入库单*/
                        if (refund.getEntity().equals("returnProduct")){
                            ReturnProduct returnProduct = (ReturnProduct) financeDao.queryById(refund.getEntityId(),ReturnProduct.class);
                            Purchase purchase = (Purchase) financeDao.queryById(returnProduct.getEntityId(),Purchase.class);
                            for (PurchaseDetail purchaseDetail : purchase.getDetails()){
                                supplierContact.setSupplier(purchaseDetail.getSupplier());
                                break;
                            }
                        } else {
                            StockInOut stockInOut = (StockInOut) financeDao.queryById(refund.getEntityId(),StockInOut.class);
                            Purchase purchase = new Purchase();
                            purchase = (Purchase) financeDao.queryById(stockInOut.getDeposit().getPurchase().getId(),Purchase.class);
                            for (PurchaseDetail purchaseDetail : purchase.getDetails()){
                                supplierContact.setSupplier(purchaseDetail.getSupplier());
                                break;
                            }
                        }
                        supplierContact.setDate(refund.getRefundDate());
                        DocType docType = new DocType();
                        docType.setId(5);
                        supplierContact.setDocType(docType);
                        supplierContact.setNo(refund.getNo());
                        supplierContact.setPaid(-refund.getAmount());
                        SupplierContact supplierContact1 = new SupplierContact();
                        supplierContact1.setSupplier(supplierContact.getSupplier());
                        List<SupplierContact> supplierContacts = financeDao.query(supplierContact1);
                        flag = FinanceConstant.ALREADY;
                        setBeginAndPayableOrPaidOfSupplierContact(supplierContacts,supplierContact,flag);
                        financeDao.save(supplierContact);
                    }
                }
            }
        }
    }


    /**
     * 每天凌晨0点扫描收款单、付款单和退款单，如果有新生成的做相应处理后插入到资金流水表中
     */
    @Transactional
    @Scheduled(cron = "0 0 0 * * ?")
    public void generateCapitalFlowMeter() {
        Map<String, String> queryParameters = null;
        String date1 = dayFormat.format(dateUtil.getForwardDay(1));
        String date2 = dayFormat.format(new Date(System.currentTimeMillis()));
        String date = date1 + " - " + date2;

        //查询收款单和付款单
        String json = "{\"payDate\":\"" + date + "\"}";
        try {
            queryParameters = writer.gson.fromJson(json, new TypeToken<Map<String, String>>() {
            }.getType());
        } catch (Exception e) {
            e.getMessage();
        }
        List<Pay> pays = financeDao.complexQuery(Pay.class, queryParameters, 0, -1);
        if (pays != null && !pays.isEmpty()) {
            sortOfPay(pays);
            for (Pay pay : pays) {
                if (pay != null) {
                    CapitalFlowMeter capitalFlowMeter = new CapitalFlowMeter();
                    capitalFlowMeter.setNo(pay.getNo());
                    capitalFlowMeter.setDate(pay.getPayDate());
                    String json1 = "{\"refundDate\":\"" + date + "\"}";
                    try {
                        queryParameters = writer.gson.fromJson(json1, new TypeToken<Map<String, String>>() {
                        }.getType());
                    } catch (Exception e) {
                        e.getMessage();
                    }
                    if (pay.getBalanceType() == 0){
                        Account account = new Account();
                        account.setAccount(pay.getReceiptAccount());
                        account = (Account) financeDao.query(account).get(0);
                        capitalFlowMeter.setAccount(account);
                        DocType docType = new DocType();
                        docType.setId(6);
                        capitalFlowMeter.setDocType(docType);
                        CapitalFlowMeter capitalFlowMeter1 = new CapitalFlowMeter();
                        capitalFlowMeter1.setAccount(account);
                        List<CapitalFlowMeter> capitalFlowMeters = financeDao.query(capitalFlowMeter1);
                        /*如果记录不为空,则当前这条资金流水记录的期初余额就是数据库中最新保存的一条资金流水记录的期末余额
                        如果为空的需要去查询账户表中该账户的账户金额*/
                        if (capitalFlowMeters != null && !capitalFlowMeters.isEmpty()) {
                            capitalFlowMeter1 = capitalFlowMeters.get(0);
                            capitalFlowMeter.setBeginning(capitalFlowMeter1.getEnding());
                        } else {
                            capitalFlowMeter.setBeginning(getBeginingAmountByPay(pays,queryParameters,account));
                        }
                        capitalFlowMeter.setIncome(pay.getAmount());
                        capitalFlowMeter.setEnding(capitalFlowMeter.getBeginning() + capitalFlowMeter.getIncome());
                    } else {
                        Account account = new Account();
                        account.setAccount(pay.getPayAccount());
                        account = (Account) financeDao.query(account).get(0);
                        capitalFlowMeter.setAccount(account);
                        DocType docType = new DocType();
                        docType.setId(5);
                        capitalFlowMeter.setDocType(docType);
                        CapitalFlowMeter capitalFlowMeter1 = new CapitalFlowMeter();
                        capitalFlowMeter1.setAccount(account);
                        List<CapitalFlowMeter> capitalFlowMeters = financeDao.query(capitalFlowMeter1);
                        /*如果记录不为空,则当前这条资金流水记录的期初余额就是数据库中最新保存的一条资金流水记录的期末余额
                        如果为空则需要获取账户表中该账户在该期间内的初始金额*/
                        if (capitalFlowMeters != null && !capitalFlowMeters.isEmpty()) {
                            capitalFlowMeter1 = capitalFlowMeters.get(0);
                            capitalFlowMeter.setBeginning(capitalFlowMeter1.getEnding());
                        } else {
                            capitalFlowMeter.setBeginning(getBeginingAmountByPay(pays,queryParameters,account));
                        }
                        capitalFlowMeter.setSpending(pay.getAmount());
                        capitalFlowMeter.setEnding(capitalFlowMeter.getBeginning() - capitalFlowMeter.getSpending());
                    }
                    financeDao.save(capitalFlowMeter);
                }
            }
        }

        //查询退款单
        String json1 = "{\"refundDate\":\"" + date + "\"}";
        try {
            queryParameters = writer.gson.fromJson(json1, new TypeToken<Map<String, String>>() {
            }.getType());
        } catch (Exception e) {
            e.getMessage();
        }
        List<Refund> refunds = financeDao.complexQuery(Refund.class, queryParameters, 0, -1);
        if (refunds != null && !refunds.isEmpty()) {
            sortOfRefund(refunds);
            for (Refund refund : refunds) {
                if (refund != null) {
                    CapitalFlowMeter capitalFlowMeter = new CapitalFlowMeter();
                    capitalFlowMeter.setNo(refund.getNo());
                    capitalFlowMeter.setDate(refund.getRefundDate());
                    String json2 = "{\"payDate\":\"" + date + "\"}";
                    try {
                        queryParameters = writer.gson.fromJson(json2, new TypeToken<Map<String, String>>() {
                        }.getType());
                    } catch (Exception e) {
                        e.getMessage();
                    }
                    if (refund.getBalanceType() == 0){
                        Account account = new Account();
                        Pay pay = (Pay) financeDao.queryById(refund.getPay().getId(),Pay.class);
                        account.setAccount(pay.getReceiptAccount());
                        account = (Account) financeDao.query(account).get(0);
                        capitalFlowMeter.setAccount(account);
                        DocType docType = new DocType();
                        docType.setId(5);
                        capitalFlowMeter.setDocType(docType);
                        CapitalFlowMeter capitalFlowMeter1 = new CapitalFlowMeter();
                        capitalFlowMeter1.setAccount(account);
                        List<CapitalFlowMeter> capitalFlowMeters = financeDao.query(capitalFlowMeter1);
                        /*如果记录不为空,则当前这条资金流水记录的期初余额就是数据库中最新保存的一条资金流水记录的期末余额
                        如果为空的需要去查询账户表中该账户的账户金额*/
                        if (capitalFlowMeters != null && !capitalFlowMeters.isEmpty()) {
                            capitalFlowMeter1 = capitalFlowMeters.get(0);
                            capitalFlowMeter.setBeginning(capitalFlowMeter1.getEnding());
                        } else {
                            capitalFlowMeter.setBeginning(getBeginingAmountByRefund(refunds,queryParameters,account));
                        }
                        capitalFlowMeter.setSpending(refund.getAmount());
                        capitalFlowMeter.setEnding(capitalFlowMeter.getBeginning() - capitalFlowMeter.getSpending());
                    } else {
                        Account account = new Account();
                        Pay pay = (Pay) financeDao.queryById(refund.getPay().getId(),Pay.class);
                        account.setAccount(pay.getPayAccount());
                        account = (Account) financeDao.query(account).get(0);
                        capitalFlowMeter.setAccount(account);
                        DocType docType = new DocType();
                        docType.setId(6);
                        capitalFlowMeter.setDocType(docType);
                        CapitalFlowMeter capitalFlowMeter1 = new CapitalFlowMeter();
                        capitalFlowMeter1.setAccount(account);
                        List<CapitalFlowMeter> capitalFlowMeters = financeDao.query(capitalFlowMeter1);
                        /*如果记录不为空,则当前这条资金流水记录的期初余额就是数据库中最新保存的一条资金流水记录的期末余额
                        如果为空则需要获取账户表中该账户在该期间内的初始金额*/
                        if (capitalFlowMeters != null && !capitalFlowMeters.isEmpty()) {
                            capitalFlowMeter1 = capitalFlowMeters.get(0);
                            capitalFlowMeter.setBeginning(capitalFlowMeter1.getEnding());
                        } else {
                            capitalFlowMeter.setBeginning(getBeginingAmountByRefund(refunds,queryParameters,account));
                        }
                        capitalFlowMeter.setIncome(refund.getAmount());
                        capitalFlowMeter.setEnding(capitalFlowMeter.getBeginning() + capitalFlowMeter.getIncome());
                    }
                    financeDao.save(capitalFlowMeter);
                }
            }
        }
    }


    /**
     * 每天凌晨0点扫描入库单和出库单，如果有新生成的做相应处理后插入到进销存明细账表中
     */
    @Transactional
    @Scheduled(cron = "0 0 0 * * ?")
    public void generateInOutDetail() {
        Map<String, String> queryParameters = null;
        String date1 = dayFormat.format(dateUtil.getForwardDay(1));
        String date2 = dayFormat.format(new Date(System.currentTimeMillis()));
        String date = date1 + " - " + date2;

        //查询入库单和出库单
        String json = "{\"date\":\"" + date + "\"}";
        try {
            queryParameters = writer.gson.fromJson(json, new TypeToken<Map<String, String>>() {
            }.getType());
        } catch (Exception e) {
            e.getMessage();
        }
        List<StockInOut> stockInOuts = financeDao.complexQuery(StockInOut.class, queryParameters, 0, -1);
        if (stockInOuts != null && !stockInOuts.isEmpty()) {
            sortOfStockInOut(stockInOuts);
            for (StockInOut stockInOut : stockInOuts) {
                if (stockInOut != null) {
                    Set<StockInOutDetail> stockInOutDetails = stockInOut.getDetails();
                    for (StockInOutDetail stockInOutDetail : stockInOutDetails){
                        InOutDetail inOutDetail = new InOutDetail();
                        // 出库或者入库商品的单价
                        Float inOutUnitPrice = 0.0f;
                        stockInOutDetail = (StockInOutDetail) financeDao.query(stockInOutDetail).get(0);
                        Set<StockInOutDetailProduct> stockInOutDetailProducts = stockInOutDetail.getStockInOutDetailProducts();
                        for (StockInOutDetailProduct stockInOutDetailProduct : stockInOutDetailProducts){
                            stockInOutDetailProduct = (StockInOutDetailProduct) financeDao.query(stockInOutDetailProduct).get(0);
                            inOutDetail.setType(stockInOutDetailProduct.getProduct().getType());
                            inOutDetail.setProductNo(stockInOutDetail.getProductNo());
                            inOutDetail.setProductName(stockInOutDetailProduct.getProduct().getName());
                            inOutUnitPrice = stockInOutDetailProduct.getProduct().getUnitPrice();
                            break;
                        }
                        inOutDetail.setUnit(stockInOutDetail.getUnit());
                        inOutDetail.setDate(stockInOut.getDate());
                        inOutDetail.setNo(stockInOut.getNo());
                        InOutDetail inOutDetail1 = new InOutDetail();
                        inOutDetail1.setProductNo(inOutDetail.getProductNo());
                        List<InOutDetail> inOutDetails = financeDao.query(inOutDetail1);
                        /*设置期初相关的数据时，首先查询是否有该商品编码的进销存明细记录，
                        如果有的话，则当前这条进销存明细的期初数据就等于数据库中商品编码为该商品编码的最新一条进销存明细记录的结存数据，
                        如果没有则当前这条进销存明细的期初数据就为0。*/
                        if (inOutDetails != null && !inOutDetails.isEmpty()){
                            InOutDetail inOutDetail2 = inOutDetails.get(0);
                            inOutDetail.setBeginQuantity(inOutDetail2.getEndQuantity());
                            inOutDetail.setBeginUnitPrice(inOutDetail2.getEndUnitPrice());
                            inOutDetail.setBeginAmount(inOutDetail2.getEndAmount());
                        } else {
                            inOutDetail.setBeginQuantity(0.0f);
                            inOutDetail.setBeginUnitPrice(0.0f);
                            inOutDetail.setBeginAmount(0.0f);
                        }
                        DocType docType = new DocType();
                        // 出入库类型为入库则单据类型为入库单
                        if (stockInOut.getType() <= 7){
                            docType.setId(2);
                            inOutDetail.setDocType(docType);
                            inOutDetail.setInQuantity(stockInOutDetail.getQuantity());
                            inOutDetail.setInUnitPrice(inOutUnitPrice);
                            inOutDetail.setInAmount(inOutDetail.getInUnitPrice() * inOutDetail.getInQuantity());
                            inOutDetail.setEndQuantity(inOutDetail.getBeginQuantity() + inOutDetail.getInQuantity());
                            inOutDetail.setEndAmount(inOutDetail.getBeginAmount()+inOutDetail.getInAmount());
                            if (inOutDetail.getEndQuantity() == 0 ){
                                inOutDetail.setEndUnitPrice(null);
                            } else {
                                inOutDetail.setEndUnitPrice(inOutDetail.getEndAmount() / inOutDetail.getEndQuantity());
                            }
                        } else {
                            docType.setId(4);
                            inOutDetail.setDocType(docType);
                            inOutDetail.setOutQuantity(stockInOutDetail.getQuantity());
                            inOutDetail.setOutUnitPrice(inOutUnitPrice);
                            inOutDetail.setOutAmount(inOutDetail.getOutUnitPrice() * inOutDetail.getOutQuantity());
                            inOutDetail.setEndQuantity(inOutDetail.getBeginQuantity() - inOutDetail.getOutQuantity());
                            inOutDetail.setEndAmount(inOutDetail.getBeginAmount()-inOutDetail.getOutAmount());
                            if (inOutDetail.getEndQuantity() == 0 ){
                                inOutDetail.setEndUnitPrice(null);
                            } else {
                                inOutDetail.setEndUnitPrice(inOutDetail.getEndAmount() / inOutDetail.getEndQuantity());
                            }
                        }
                        financeDao.save(inOutDetail);
                    }
                }
            }
        }
    }


    /**
     * 设置供应商往来对账记录的期初余额和应付余额或已付余额
     * @param supplierContacts
     * @param supplierContact
     * @param flag
     */
    public void setBeginAndPayableOrPaidOfSupplierContact(List<SupplierContact> supplierContacts,SupplierContact supplierContact,String flag){
        /*如果记录不为空,则当前这条供应商往来对账记录的期初余额就是数据库中
        最新保存的一条供应商往来对账记录的余额*/
        if (supplierContacts != null && !supplierContacts.isEmpty()) {
            //获取数据库中最新保存的一条供应商往来对账记录
            SupplierContact supplierContact1 = supplierContacts.get(0);
            supplierContact.setBeginning(supplierContact1.getRemainder());
            /*如果为应付则当前这条供应商往来对账记录的应付余额就是数据库中
            最新保存的一条供应商往来对账记录的应付余额加上当前这条供应商往来对账记录的应付金额，如果为已付就是减*/
            if (flag.equals(FinanceConstant.SHOULD)){
                supplierContact.setRemainder(supplierContact1.getRemainder() + supplierContact.getPayable());
            } else {
                supplierContact.setRemainder(supplierContact1.getRemainder() - supplierContact.getPaid());
            }
        } else { //如果记录为空，则当前这条供应商往来对账记录的期初余额就是0
            supplierContact.setBeginning(0.0f);
            if (flag.equals(FinanceConstant.SHOULD)){
                supplierContact.setRemainder(supplierContact.getPayable());
            } else {
                supplierContact.setRemainder(-supplierContact.getPaid());
            }
        }
    }

    /**
     * 设置客户往来对账记录的期初余额和应收余额或已收余额
     * @param customerContacts
     * @param customerContact
     * @param flag
     */
    public void setBeginAndReceivableOrReceivedOfCustomerContact(List<CustomerContact> customerContacts,CustomerContact customerContact,String flag){
        /*如果记录不为空,则当前这条客户往来对账记录的期初余额就是数据库中
        最新保存的一条客户往来对账记录的余额*/
        if (customerContacts != null && !customerContacts.isEmpty()) {
            //获取数据库中最新保存的一条客户往来对账记录
            CustomerContact customerContact1 = customerContacts.get(0);
            customerContact.setBeginning(customerContact1.getRemainder());
            /*如果为应付则当前这条供应商往来对账记录的应付余额就是数据库中
            最新保存的一条供应商往来对账记录的应付余额加上当前这条供应商往来对账记录的应付金额，如果为已付就是减*/
            if (flag.equals(FinanceConstant.SHOULD)){
                customerContact.setRemainder(customerContact1.getRemainder() + customerContact.getReceivable());
            } else {
                customerContact.setRemainder(customerContact1.getRemainder() - customerContact.getReceived());
            }
        } else { //如果记录为空，则当前这条客户往来对账记录的期初余额就是0
            customerContact.setBeginning(0.0f);
            if (flag.equals(FinanceConstant.SHOULD)){
                customerContact.setRemainder(customerContact.getReceivable());
            } else {
                customerContact.setRemainder(-customerContact.getReceived());
            }
        }
    }

    /**
     * 获取账户的期初余额根据付款单或者收款单
     * @param pays
     * @param queryParameters
     * @param account
     * @return
     */
    public Float getBeginingAmountByPay(List<Pay> pays,Map<String, String> queryParameters,Account account){
        Float amount = 0.0f;
        for (Pay pay : pays){
            amount += getInOutByPay(pay,account);
        }
        List<Refund> refunds = financeDao.complexQuery(Refund.class, queryParameters, 0, -1);
        if (refunds != null && !refunds.isEmpty()){
            for(Refund refund : refunds){
                if (refund != null){
                    Pay pay = (Pay) financeDao.queryById(refund.getPay().getId(),Pay.class);
                    amount += getInOutByRefund(refund,pay,account);
                }
            }
        }
        return (account.getAmount() + amount);
    }

    /**
     * 获取账户的期初余额根据退款单
     * @param refunds
     * @param queryParameters
     * @param account
     * @return
     */
    public Float getBeginingAmountByRefund(List<Refund> refunds,Map<String, String> queryParameters,Account account){
        Float amount = 0.0f;
        for (Refund refund : refunds){
            Pay pay = (Pay) financeDao.queryById(refund.getPay().getId(),Pay.class);
            amount += getInOutByRefund(refund,pay,account);
        }
        List<Pay> pays = financeDao.complexQuery(Pay.class, queryParameters, 0, -1);
        if (pays != null && !pays.isEmpty()){
            for(Pay pay : pays){
                if (pay != null){
                    amount += getInOutByPay(pay,account);
                }
            }
        }
        return (account.getAmount() + amount);
    }

    /**
     * 获取收入或支出根据收款单或者付款单
     * @param pay
     * @param account
     * @return
     */
    public Float getInOutByPay(Pay pay,Account account){
        Float amount = 0.0f;
        if (1 == pay.getBalanceType()){
            if (pay.getPayAccount().equals(account.getAccount())){
                amount = pay.getAmount();
            }
        } else {
            if (pay.getReceiptAccount().equals(account.getAccount())){
                amount = -pay.getAmount();
            }
        }
        return amount;
    }

    /**
     * 获取收入或支出根据退款单
     * @param refund
     * @param pay
     * @param account
     * @return
     */
    public Float getInOutByRefund(Refund refund,Pay pay,Account account){
        Float amount = 0.0f;
        if (refund.getBalanceType() == 0){
            if (pay.getReceiptAccount().equals(account.getAccount())){
                amount = refund.getAmount();
            }
        } else {
            if (pay.getPayAccount().equals(account.getAccount())){
                amount = -refund.getAmount();
            }
        }
        return amount;
    }

    /**
     * 对支付记录进行排序
     * @param pays
     */
    public void sortOfPay(List<Pay> pays){
        pays.sort(new Comparator<Pay>() {
            /**
             * 如果要按照升序排序，
             * 则o1 小于o2，返回-1（负数），相等返回0，o1大于o2返回1（正数）
             * 如果要按照降序排序
             * 则o1 小于o2，返回1（正数），相等返回0，o1大于o2返回-1（负数）
             * @param o1
             * @param o2
             * @return
             */
            @Override
            public int compare(Pay o1, Pay o2) {
                if (o1.getId().compareTo(o2.getId()) > 0) {
                    return 1;
                } else if (o1.getId().compareTo(o2.getId()) < 0) {
                    return -1;
                }

                return 0;
            }
        });
    }

    /**
     * 对采购单单进行排序
     * @param purchases
     */
    public void sortOfPurchase(List<Purchase> purchases){
        purchases.sort(new Comparator<Purchase>() {
            /**
             * 如果要按照升序排序，
             * 则o1 小于o2，返回-1（负数），相等返回0，o1大于o2返回1（正数）
             * 如果要按照降序排序
             * 则o1 小于o2，返回1（正数），相等返回0，o1大于o2返回-1（负数）
             * @param o1
             * @param o2
             * @return
             */
            @Override
            public int compare(Purchase o1, Purchase o2) {
                if (o1.getId().compareTo(o2.getId()) > 0) {
                    return 1;
                } else if (o1.getId().compareTo(o2.getId()) < 0) {
                    return -1;
                }

                return 0;
            }
        });
    }

    /**
     * 对销售订单进行排序
     * @param orders
     */
    public void sortOfOrder(List<Order> orders){
        orders.sort(new Comparator<Order>() {
            /**
             * 如果要按照升序排序，
             * 则o1 小于o2，返回-1（负数），相等返回0，o1大于o2返回1（正数）
             * 如果要按照降序排序
             * 则o1 小于o2，返回1（正数），相等返回0，o1大于o2返回-1（负数）
             * @param o1
             * @param o2
             * @return
             */
            @Override
            public int compare(Order o1, Order o2) {
                if (o1.getId().compareTo(o2.getId()) > 0) {
                    return 1;
                } else if (o1.getId().compareTo(o2.getId()) < 0) {
                    return -1;
                }

                return 0;
            }
        });
    }

    /**
     * 对退货记录进行排序
     * @param returnProducts
     */
    public void sortOfReturnProduct(List<ReturnProduct> returnProducts){
        returnProducts.sort(new Comparator<ReturnProduct>() {
            /**
             * 如果要按照升序排序，
             * 则o1 小于o2，返回-1（负数），相等返回0，o1大于o2返回1（正数）
             * 如果要按照降序排序
             * 则o1 小于o2，返回1（正数），相等返回0，o1大于o2返回-1（负数）
             * @param o1
             * @param o2
             * @return
             */
            @Override
            public int compare(ReturnProduct o1, ReturnProduct o2) {
                if (o1.getId().compareTo(o2.getId()) > 0) {
                    return 1;
                } else if (o1.getId().compareTo(o2.getId()) < 0) {
                    return -1;
                }

                return 0;
            }
        });
    }

    /**
     * 对退款记录进行排序
     * @param refunds
     */
    public void sortOfRefund(List<Refund> refunds){
        refunds.sort(new Comparator<Refund>() {
            /**
             * 如果要按照升序排序，
             * 则o1 小于o2，返回-1（负数），相等返回0，o1大于o2返回1（正数）
             * 如果要按照降序排序
             * 则o1 小于o2，返回1（正数），相等返回0，o1大于o2返回-1（负数）
             * @param o1
             * @param o2
             * @return
             */
            @Override
            public int compare(Refund o1, Refund o2) {
                if (o1.getId().compareTo(o2.getId()) > 0) {
                    return 1;
                } else if (o1.getId().compareTo(o2.getId()) < 0) {
                    return -1;
                }

                return 0;
            }
        });
    }

    /**
     * 对出入库单进行排序
     * @param stockInOuts
     */
    public void sortOfStockInOut(List<StockInOut> stockInOuts){
        stockInOuts.sort(new Comparator<StockInOut>() {
            /**
             * 如果要按照升序排序，
             * 则o1 小于o2，返回-1（负数），相等返回0，o1大于o2返回1（正数）
             * 如果要按照降序排序
             * 则o1 小于o2，返回1（正数），相等返回0，o1大于o2返回-1（负数）
             * @param o1
             * @param o2
             * @return
             */
            @Override
            public int compare(StockInOut o1, StockInOut o2) {
                if (o1.getId().compareTo(o2.getId()) > 0) {
                    return 1;
                } else if (o1.getId().compareTo(o2.getId()) < 0) {
                    return -1;
                }

                return 0;
            }
        });
    }
}