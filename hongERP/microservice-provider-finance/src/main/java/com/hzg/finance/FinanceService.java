package com.hzg.finance;

import com.hzg.customer.Customer;
import com.hzg.erp.ProductType;
import com.hzg.erp.Supplier;
import com.hzg.erp.Warehouse;
import com.hzg.pay.Account;
import com.hzg.sys.*;
import com.hzg.tools.*;
import org.apache.log4j.Logger;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.Array;
import java.math.BigInteger;
import java.util.*;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: ErpService.java
 * 类的详细说明
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/6/28
 */
@Service
public class FinanceService {

    Logger logger = Logger.getLogger(FinanceService.class);

    @Autowired
    private FinanceDao financeDao;

    @Autowired
    private SysClient sysClient;

    @Autowired
    private Writer writer;

    @Autowired
    public ObjectToSql objectToSql;

    @Autowired
    public SessionFactory sessionFactory;

    public String launchAuditFlow(String entity, Integer entityId, String auditName, String content, User user) {
        String result = CommonConstant.fail;

        logger.info("launchAuditFlow start:" + result);

        /**
         * 创建审核流程第一个节点，发起审核流程
         */
        Audit audit = new Audit();
        audit.setEntity(entity);
        audit.setEntityId(entityId);
        audit.setName(auditName);
        audit.setContent(content);

        Post post = (Post)(((List<User>)financeDao.query(user)).get(0)).getPosts().toArray()[0];
        audit.setCompany(post.getDept().getCompany());

        Map<String, String> result1 = writer.gson.fromJson(sysClient.launchAuditFlow(writer.gson.toJson(audit)),
                new com.google.gson.reflect.TypeToken<Map<String, String>>() {}.getType());

        result = result1.get(CommonConstant.result);

        logger.info("launchAuditFlow end, result:" + result);

        return result;
    }

    public String saveVoucherDetail(Voucher voucher) {
        String result = CommonConstant.fail;

        if (voucher.getDetails() != null && !voucher.getDetails().isEmpty()) {
            for (VoucherDetail detail : voucher.getDetails()) {
                if (detail.getVoucherItem() != null){
                    VoucherItem voucherItem = detail.getVoucherItem();
                    if (voucherItem.getId() == null){
                        result += financeDao.save(voucherItem);
                    }
                    Voucher voucher1 = new Voucher();
                    voucher1.setId(voucher.getId());
                    detail.setVoucher(voucher1);
                    result += financeDao.save(detail);
                }
            }
        }

        return result.equals(CommonConstant.fail) ? result : result.substring(CommonConstant.fail.length());
    }

    public String updateVoucherDetail(Voucher voucher) {
        String result = CommonConstant.fail;

        if (voucher.getDetails() != null && !voucher.getDetails().isEmpty()) {
            Voucher voucher1 = new Voucher();
            VoucherDetail voucherDetail = new VoucherDetail();
            voucher1.setId(voucher.getId());
            voucherDetail.setVoucher(voucher1);
            List<VoucherDetail> voucherDetails = financeDao.query(voucherDetail);
            if (voucherDetails != null && !voucherDetails.isEmpty()){
                for (VoucherDetail voucherDetail1 : voucherDetails){
                    VoucherItem voucherItem = voucherDetail1.getVoucherItem();
                    result += financeDao.delete(voucherItem).substring(0,7);
                    result += financeDao.delete(voucherDetail1).substring(0,7);
                }
            }
            for (VoucherDetail voucherDetail1 : voucher.getDetails()){
                if (voucherDetail1.getVoucherItem() != null){
                    VoucherItem voucherItem = voucherDetail1.getVoucherItem();
                    if (voucherItem.getId() == null){
                        result += financeDao.save(voucherItem);
                    }
                    Voucher voucher2 = new Voucher();
                    voucher2.setId(voucher.getId());
                    voucherDetail1.setVoucher(voucher2);
                    result += financeDao.save(voucherDetail1);
                }
            }
        }

        return result.equals(CommonConstant.fail) ? result : result.substring(CommonConstant.fail.length());
    }

    public String updateVoucherItemSource(Voucher voucher) {
        String result = CommonConstant.fail;

        if (voucher.getVoucherItemSources() != null && !voucher.getVoucherItemSources().isEmpty()) {
            Set<VoucherItemSource> voucherItemSources = new HashSet<VoucherItemSource>();
            for (VoucherItemSource voucherItemSource : voucher.getVoucherItemSources()) {
                Voucher voucher1 = new Voucher();
                voucher1.setId(voucher.getId());
                voucherItemSource.setVoucher(voucher1);
                voucherItemSource.setState(0);
                result += financeDao.updateById(voucherItemSource.getId(),voucherItemSource);
                voucherItemSources.add(voucherItemSource);
            }
            voucher.setVoucherItemSources(voucherItemSources);
            result += financeDao.updateById(voucher.getId(),voucher);
        }

        return result.equals(CommonConstant.fail) ? result : result.substring(CommonConstant.fail.length());
    }

    public List privateQuery(String entity, String json, int position, int rowNum) {

        if (entity.equalsIgnoreCase(Voucher.class.getSimpleName())) {
            Class[] clazzs = {Voucher.class, VoucherCategory.class,User.class};
            Map<String, List<Object>> results = financeDao.queryBySql(getVoucherComplexSql(json, position, rowNum), clazzs);

            List<Object> vouchers = results.get(Voucher.class.getName());
            List<Object> voucherCategorys = results.get(VoucherCategory.class.getName());
            List<Object> users = results.get(User.class.getName());

            int i = 0;
            for (Object voucher : vouchers) {
                ((Voucher)voucher).setVoucherCategory((VoucherCategory) voucherCategorys.get(i));
                ((Voucher)voucher).setChartMaker((User) users.get(i));

                i++;
            }
            return vouchers;

        } else if (entity.equalsIgnoreCase(VoucherItemSource.class.getSimpleName())) {
            Map<String, Object> queryParameters = writer.gson.fromJson(json, new com.google.gson.reflect.TypeToken<Map<String, Object>>() {}.getType());
            String docType = (String)((Map)queryParameters.get("docType")).get("name");
            String[] docTypes = docType.split(";");
            List<VoucherItemSource> voucherItemSourceList = new ArrayList<VoucherItemSource>();
            for (String doc : docTypes){
                String jsonn = "";
                if (doc.equals(FinanceConstant.purchase) || doc.equals(FinanceConstant.order)){
                    if (doc.equals(FinanceConstant.purchase)){
                        jsonn += "{\"docType\":{\"name\":\"采购单\"}";
                    } else {
                        jsonn += "{\"docType\":{\"name\":\"销售订单\"}";
                    }
                    if (queryParameters.get("warehouse") == null){
                        jsonn += json.substring(json.indexOf("}")+1,json.length());
                    } else {
                        if (queryParameters.get("voucherItemSourceDetail") == null){
                            jsonn += json.substring(json.indexOf("}")+1,json.indexOf("warehouse")-2)+"}";
                        }else {
                            jsonn += json.substring(json.indexOf("}")+1,json.indexOf("warehouse")-2)+json.substring(json.indexOf("voucherItemSourceDetail")-2,json.length());
                        }
                    }

                    Class[] clazzs = {VoucherItemSource.class, DocType.class, User.class};
                    Map<String, List<Object>> results = financeDao.queryBySql(getVoucherItemSourceComplexSql(jsonn, 0, -1), clazzs);

                    List<Object> voucherItemSources = results.get(VoucherItemSource.class.getName());
                    List<Object> docTypes1 = results.get(DocType.class.getName());
                    List<Object> users = results.get(User.class.getName());

                    int i = 0;
                    for (Object voucherItemSource : voucherItemSources) {
                        VoucherItemSource voucherItemSource1 = (VoucherItemSource)voucherItemSource;
                        voucherItemSource1.setDocType((DocType) docTypes1.get(i));
                        voucherItemSource1.setChartMaker((User) users.get(i));
                        voucherItemSourceList.add(voucherItemSource1);
                        i++;
                    }
                } else if (doc.equals(FinanceConstant.stockIn) || doc.equals(FinanceConstant.stockOut) || doc.equals(FinanceConstant.transform) || doc.equals(FinanceConstant.damageStockOut)){
                    if (doc.equals(FinanceConstant.stockIn)){
                        jsonn += "{\"docType\":{\"name\":\"入库单\"}";
                    } else if (doc.equals(FinanceConstant.stockOut)){
                        jsonn += "{\"docType\":{\"name\":\"出库单\"}";
                    } else if (doc.equals(FinanceConstant.transform)){
                        jsonn += "{\"docType\":{\"name\":\"形态转换单\"}";
                    } else {
                        jsonn += "{\"docType\":{\"name\":\"报损出库单\"}";
                    }
                    if (queryParameters.get("voucherItemSourceDetail") == null){
                        jsonn += json.substring(json.indexOf("}")+1,json.length());
                    } else {
                        if (((String)((Map)(((List)queryParameters.get("voucherItemSourceDetail")).get(0))).get("entityId")).equals("")){
                            jsonn += json.substring(json.indexOf("}")+1,json.indexOf("voucherItemSourceDetail")-2)+"}";
                        } else {
                            jsonn += json.substring(json.indexOf("}")+1,json.indexOf("voucherItemSourceDetail")-2) + json.substring(json.indexOf("voucherItemSourceDetail")-2,json.indexOf("["))+
                                    json.substring(json.indexOf("voucherItemSourceDetail"),json.length()).substring(json.substring(json.indexOf("voucherItemSourceDetail"),json.length()).indexOf("[")+1,
                                            json.substring(json.indexOf("voucherItemSourceDetail"),json.length()).indexOf("}")+1)+"}";
                        }
                    }

                    Class[] clazzs = {VoucherItemSource.class, DocType.class, User.class,Warehouse.class};
                    Map<String, List<Object>> results = financeDao.queryBySql(getVoucherItemSourceComplexSql(jsonn, 0, -1), clazzs);

                    List<Object> voucherItemSources = results.get(VoucherItemSource.class.getName());
                    List<Object> docTypes1 = results.get(DocType.class.getName());
                    List<Object> users = results.get(User.class.getName());
                    List<Object> warehouses = results.get(Warehouse.class.getName());

                    int i = 0;
                    for (Object voucherItemSource : voucherItemSources) {
                        VoucherItemSource voucherItemSource1 = (VoucherItemSource)voucherItemSource;
                        voucherItemSource1.setDocType((DocType) docTypes1.get(i));
                        voucherItemSource1.setChartMaker((User) users.get(i));
                        voucherItemSource1.setWarehouse((Warehouse) warehouses.get(i));
                        voucherItemSourceList.add(voucherItemSource1);
                        i++;
                    }
                }else if (doc.equals(FinanceConstant.pay) || doc.equals(FinanceConstant.receipt)){
                    if (doc.equals(FinanceConstant.pay)){
                        jsonn += "{\"docType\":{\"name\":\"付款单\"}";
                    } else {
                        jsonn += "{\"docType\":{\"name\":\"收款单\"}";
                    }
                    if (queryParameters.get("voucherItemSourceDetail") == null){
                        jsonn += json.substring(json.indexOf("voucherItemSource")-2,json.length()).substring(0,json.substring(json.indexOf("voucherItemSource")-2,json.length()).indexOf("}")+1)+"}";
                    } else {
                        if (((String)((Map)(((List)queryParameters.get("voucherItemSourceDetail")).get(2))).get("entityId")).equals("")){
                            jsonn += json.substring(json.indexOf("voucherItemSource")-2,json.length()).substring(0,json.substring(json.indexOf("voucherItemSource")-2,json.length()).indexOf("}")+1)+"}";
                        } else {
                            jsonn += json.substring(json.indexOf("voucherItemSource")-2,json.length()).substring(0,json.substring(json.indexOf("voucherItemSource")-2,json.length()).indexOf("}")+1);
                            jsonn += json.substring(json.indexOf("voucherItemSourceDetail")-2,json.indexOf("["))+json.substring(json.indexOf("account")-11,json.indexOf("]"))+"}";
                        }
                    }

                    Class[] clazzs = {VoucherItemSource.class, DocType.class};
                    Map<String, List<Object>> results = financeDao.queryBySql(getVoucherItemSourceComplexSql(jsonn, 0, -1), clazzs);

                    List<Object> voucherItemSources = results.get(VoucherItemSource.class.getName());
                    List<Object> docTypes1 = results.get(DocType.class.getName());

                    int i = 0;
                    for (Object voucherItemSource : voucherItemSources) {
                        VoucherItemSource voucherItemSource1 = (VoucherItemSource)voucherItemSource;
                        voucherItemSource1.setDocType((DocType) docTypes1.get(i));
                        voucherItemSourceList.add(voucherItemSource1);
                        i++;
                    }
                }
            }
            for (VoucherItemSource voucherItemSource : voucherItemSourceList){
                if (voucherItemSource.getContactUnit() == null){
                    voucherItemSource.setContactUnit("");
                }
            }
            if (voucherItemSourceList != null && !voucherItemSourceList.isEmpty()) {
                voucherItemSourceList.sort(new Comparator<VoucherItemSource>() {
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
                    public int compare(VoucherItemSource o1, VoucherItemSource o2) {
                        if (o1.getContactUnit().compareTo(o2.getContactUnit()) > 0) {
                            return 1;
                        } else if (o1.getContactUnit().compareTo(o2.getContactUnit()) < 0) {
                            return -1;
                        }
                        return 0;
                    }
                });
            }
            return voucherItemSourceList;

        } else if (entity.equalsIgnoreCase(GrossProfit.class.getSimpleName())) {
            Class[] clazzs = {GrossProfit.class,User.class, Customer.class, ProductType.class};
            Map<String, List<Object>> results = financeDao.queryBySql(getGrossProfitComplexSql(json, position, rowNum), clazzs);

            List<Object> grossProfits = results.get(GrossProfit.class.getName());
            List<Object> users = results.get(User.class.getName());
            List<Object> customers = results.get(Customer.class.getName());
            List<Object> types = results.get(ProductType.class.getName());

            int i = 0;
            for (Object grossProfit : grossProfits) {
                ((GrossProfit)grossProfit).setChartMaker((User) users.get(i));
                ((GrossProfit)grossProfit).setCustomer((Customer) customers.get(i));
                ((GrossProfit)grossProfit).setType((ProductType) types.get(i));

                i++;
            }
            return grossProfits;

        } else if (entity.equalsIgnoreCase(SupplierContact.class.getSimpleName())) {
            Class[] clazzs = {SupplierContact.class,Supplier.class,DocType.class};
            Map<String, List<Object>> results = financeDao.queryBySql(getSupplierContactComplexSql(json, position, rowNum), clazzs);

            List<Object> supplierContacts = results.get(SupplierContact.class.getName());
            List<Object> suppliers = results.get(Supplier.class.getName());
            List<Object> docTypes = results.get(DocType.class.getName());

            int i = 0;
            for (Object supplierContact : supplierContacts) {
                ((SupplierContact)supplierContact).setSupplier((Supplier) suppliers.get(i));
                ((SupplierContact)supplierContact).setDocType((DocType) docTypes.get(i));
                i++;
            }
            return supplierContacts;

        } else if (entity.equalsIgnoreCase(CustomerContact.class.getSimpleName())) {
            Class[] clazzs = {CustomerContact.class,Customer.class,DocType.class};
            Map<String, List<Object>> results = financeDao.queryBySql(getCustomerContactComplexSql(json, position, rowNum), clazzs);

            List<Object> customerContacts = results.get(CustomerContact.class.getName());
            List<Object> customers = results.get(Customer.class.getName());
            List<Object> docTypes = results.get(DocType.class.getName());

            int i = 0;
            for (Object customerContact : customerContacts) {
                ((CustomerContact)customerContact).setCustomer((Customer) customers.get(i));
                ((CustomerContact)customerContact).setDocType((DocType) docTypes.get(i));

                i++;
            }
            return customerContacts;

        } else if (entity.equalsIgnoreCase(InOutDetail.class.getSimpleName())) {
            Class[] clazzs = {InOutDetail.class,ProductType.class,DocType.class};
            Map<String, List<Object>> results = financeDao.queryBySql(getInOutDetailComplexSql(json, position, rowNum), clazzs);

            List<Object> inOutDetails = results.get(InOutDetail.class.getName());
            List<Object> types = results.get(ProductType.class.getName());
            List<Object> docTypes = results.get(DocType.class.getName());

            int i = 0;
            for (Object inOutDetail : inOutDetails) {
                ((InOutDetail)inOutDetail).setType((ProductType) types.get(i));
                ((InOutDetail)inOutDetail).setDocType((DocType) docTypes.get(i));

                i++;
            }
            return inOutDetails;

        } else if (entity.equalsIgnoreCase(CapitalFlowMeter.class.getSimpleName())) {
            Class[] clazzs = {CapitalFlowMeter.class,Account.class,DocType.class};
            Map<String, List<Object>> results = financeDao.queryBySql(getCapitalFlowMeterComplexSql(json, position, rowNum), clazzs);

            List<Object> capitalFlowMeters = results.get(CapitalFlowMeter.class.getName());
            List<Object> accounts = results.get(Account.class.getName());
            List<Object> docTypes = results.get(DocType.class.getName());

            int i = 0;
            for (Object capitalFlowMeter : capitalFlowMeters) {
                ((CapitalFlowMeter)capitalFlowMeter).setAccount((Account) accounts.get(i));
                ((CapitalFlowMeter)capitalFlowMeter).setDocType((DocType) docTypes.get(i));

                i++;
            }
            return capitalFlowMeters;

        }

        return new ArrayList();
    }

    private String getVoucherComplexSql(String json, int position, int rowNum) {
        String sql = "";

        try {
            Map<String, Object> queryParameters = writer.gson.fromJson(json, new com.google.gson.reflect.TypeToken<Map<String, Object>>() {}.getType());

            String voucherSql = objectToSql.generateComplexSqlByAnnotation(Voucher.class,
                    writer.gson.fromJson(writer.gson.toJson(queryParameters.get(Voucher.class.getSimpleName().toLowerCase())),
                            new com.google.gson.reflect.TypeToken<Map<String, String>>() {}.getType()), position, rowNum);

            String selectSql = "", fromSql = "", whereSql = "", sortNumSql = "";

            String[] sqlParts = financeDao.getSqlPart(voucherSql, Voucher.class);
            selectSql = sqlParts[0];
            fromSql = sqlParts[1];
            whereSql = sqlParts[2];
            sortNumSql = sqlParts[3];

            selectSql += ", " + financeDao.getSelectColumns("t11", VoucherCategory.class);
            fromSql += ", " + objectToSql.getTableName(VoucherCategory.class) + " t11 ";
            if (!whereSql.trim().equals("")) {
                whereSql += " and ";
            }
            whereSql += " t11." + objectToSql.getColumn(VoucherCategory.class.getDeclaredField("id")) +
                        " = t." + objectToSql.getColumn(Voucher.class.getDeclaredField("voucherCategory"));

            selectSql += ", " + financeDao.getSelectColumns("t12", User.class);
            fromSql += ", " + objectToSql.getTableName(User.class) + " t12 ";
            whereSql += " and t12." + objectToSql.getColumn(User.class.getDeclaredField("id")) +
                    " = t." + objectToSql.getColumn(Voucher.class.getDeclaredField("chartMaker"))+
                    " and t12." + objectToSql.getColumn(User.class.getDeclaredField("name")) +
                    " like '%" + ((Map)(queryParameters.get("chartMaker"))).get("name")+"%'";

            if (whereSql.indexOf(" and") == 0) {
                whereSql = whereSql.substring(" and".length());
            }

            sql = "select " + selectSql + " from " + fromSql + " where " + whereSql + " order by " + sortNumSql;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return sql;
    }

    private String getVoucherItemSourceComplexSql(String json, int position, int rowNum) {
        String sql = "";

        try {
            Map<String, Object> queryParameters = writer.gson.fromJson(json, new com.google.gson.reflect.TypeToken<Map<String, Object>>() {}.getType());

            String voucherItemSourceSql = objectToSql.generateComplexSqlByAnnotation(VoucherItemSource.class,
                    writer.gson.fromJson(writer.gson.toJson(queryParameters.get("voucherItemSource")),
                            new com.google.gson.reflect.TypeToken<Map<String, String>>() {}.getType()), position, rowNum);

            String selectSql = "", fromSql = "", whereSql = "", sortNumSql = "";

            String[] sqlParts = financeDao.getSqlPart(voucherItemSourceSql, VoucherItemSource.class);
            selectSql = sqlParts[0];
            fromSql = sqlParts[1];
            whereSql = sqlParts[2];
            sortNumSql = sqlParts[3];

            String docType = (String)((Map)queryParameters.get("docType")).get("name");
            if (docType.equals(FinanceConstant.purchase) || docType.equals(FinanceConstant.order)){

                // 查询满足商品分类、支付方式和支付账号等条件的凭证条目来源
                if (queryParameters.get("voucherItemSourceDetail") != null){
                    // 获取条件：凭证条目来源明细的集合
                    List<Object> list = (List<Object>)queryParameters.get("voucherItemSourceDetail");
                    List<VoucherItemSourceDetail> voucherItemSourceDetails = new ArrayList<VoucherItemSourceDetail>();
                    List<VoucherItemSourceDetail> voucherItemSourceDetailList = new ArrayList<VoucherItemSourceDetail>();
                    List<VoucherItemSourceDetail> details = new ArrayList<VoucherItemSourceDetail>();
                    VoucherItemSourceDetail voucherItemSourceDetail = new VoucherItemSourceDetail();
                    for (Object object : list){
                        details.clear();
                        String entityId = (String)((Map)object).get("entityId");
                        if (!entityId.equals("")){
                            String entity = (String)((Map)object).get("entity");
                            String[] entityIds = entityId.split(";");
                            for (String entityIdd : entityIds){
                                voucherItemSourceDetail.setEntity(entity);
                                voucherItemSourceDetail.setEntityId(Integer.valueOf(entityIdd));
                                voucherItemSourceDetails = financeDao.query(voucherItemSourceDetail);
                                if (voucherItemSourceDetails != null && !voucherItemSourceDetails.isEmpty()){
                                    for (VoucherItemSourceDetail voucherItemSourceDetail1 : voucherItemSourceDetails){
                                        voucherItemSourceDetailList.add(voucherItemSourceDetail1);
                                        details.add(voucherItemSourceDetail1);
                                    }
                                }
                            }
                            if (details != null && !details.isEmpty()) {
                                whereSql += " and t.id in(";
                                for (int i = 0; i < details.size(); i++) {
                                    whereSql += details.get(i).getVoucherItemSource().getId();
                                    if (i != details.size() - 1) {
                                        whereSql += ",";
                                    }
                                }
                                whereSql += ")";
                            } else {
                                // 根据传过来的商品分类、支付方式和支付账号查到的凭证条目来源为空，那么不管其他条件如何，最后都查不到，所以将凭证条目来源的id=-1作为条件
                                whereSql += " and t.id = -1";
                            }
                        }
                    }
                }

                selectSql += ", " + financeDao.getSelectColumns("t11", DocType.class);
                fromSql += ", " + objectToSql.getTableName(DocType.class) + " t11 ";
                if (!whereSql.trim().equals("")) {
                    whereSql += " and ";
                }
                whereSql += " t11." + objectToSql.getColumn(DocType.class.getDeclaredField("id")) +
                        " = t." + objectToSql.getColumn(VoucherItemSource.class.getDeclaredField("docType"))+
                        " and t11." + objectToSql.getColumn(DocType.class.getDeclaredField("name")) +
                        "='" + ((Map)(queryParameters.get("docType"))).get("name") + "'";

                selectSql += ", " + financeDao.getSelectColumns("t12", User.class);
                fromSql += ", " + objectToSql.getTableName(User.class) + " t12 ";
                whereSql += " and t12." + objectToSql.getColumn(User.class.getDeclaredField("id")) +
                        " = t." + objectToSql.getColumn(VoucherItemSource.class.getDeclaredField("chartMaker"));
                // 查询满足制单员条件的凭证条目来源
                if (queryParameters.get("chartMaker") != null){
                    whereSql += " and t12." + objectToSql.getColumn(User.class.getDeclaredField("name")) +
                            " in(";
                    String chartMaker = (String)((Map)queryParameters.get("chartMaker")).get("name");
                    // 得到制单员数组
                    String[] chartMakers = chartMaker.split(";");
                    for (int i = 0;i<chartMakers.length;i++){
                        whereSql += "'"+ chartMakers[i] + "'";
                        if (i != chartMakers.length-1){
                            whereSql += ",";
                        }
                    }
                    whereSql += ")";
                }

                if (whereSql.indexOf(" and") == 0) {
                    whereSql = whereSql.substring(" and".length());
                }

                sql = "select " + selectSql + " from " + fromSql + " where " + whereSql + " order by " + sortNumSql;

            } else if (docType.equals(FinanceConstant.stockIn) || docType.equals(FinanceConstant.stockOut) || docType.equals(FinanceConstant.transform) || docType.equals(FinanceConstant.damageStockOut)){
                // 查询满足商品分类条件的凭证条目来源(因为入库不涉及到支付方式和支付账号，所以这里只是商品分类)
                if (queryParameters.get("voucherItemSourceDetail") != null){
                    // 获取条件：凭证条目来源明细
                    Object object = queryParameters.get("voucherItemSourceDetail");
                    List<VoucherItemSourceDetail> voucherItemSourceDetails = new ArrayList<VoucherItemSourceDetail>();
                    List<VoucherItemSourceDetail> voucherItemSourceDetailList = new ArrayList<VoucherItemSourceDetail>();
                    VoucherItemSourceDetail voucherItemSourceDetail = new VoucherItemSourceDetail();
                    String entityId = (String)((Map)object).get("entityId");
                    String entity = (String)((Map)object).get("entity");
                    String[] entityIds = entityId.split(";");
                    for (String entityIdd : entityIds){
                        voucherItemSourceDetail.setEntity(entity);
                        voucherItemSourceDetail.setEntityId(Integer.valueOf(entityIdd));
                        voucherItemSourceDetails = financeDao.query(voucherItemSourceDetail);
                        if (voucherItemSourceDetails != null && !voucherItemSourceDetails.isEmpty()){
                            for (VoucherItemSourceDetail voucherItemSourceDetail1 : voucherItemSourceDetails){
                                voucherItemSourceDetailList.add(voucherItemSourceDetail1);
                            }
                        }
                    }

                    if (voucherItemSourceDetailList != null && !voucherItemSourceDetailList.isEmpty()) {
                        whereSql += " and t.id in(";
                        for (int i = 0; i < voucherItemSourceDetailList.size(); i++) {
                            whereSql += voucherItemSourceDetailList.get(i).getVoucherItemSource().getId();
                            if (i != voucherItemSourceDetailList.size() - 1) {
                                whereSql += ",";
                            }
                        }
                        whereSql += ")";
                    } else {
                        // 根据传过来的商品分类查到的凭证条目来源为空，那么不管其他条件如何，最后都查不到，所以将凭证条目来源的id=-1作为条件
                        whereSql += " and t.id = -1";
                    }
                }

                selectSql += ", " + financeDao.getSelectColumns("t11", DocType.class);
                fromSql += ", " + objectToSql.getTableName(DocType.class) + " t11 ";
                if (!whereSql.trim().equals("")) {
                    whereSql += " and ";
                }
                whereSql += " t11." + objectToSql.getColumn(DocType.class.getDeclaredField("id")) +
                        " = t." + objectToSql.getColumn(VoucherItemSource.class.getDeclaredField("docType"))+
                        " and t11." + objectToSql.getColumn(DocType.class.getDeclaredField("name")) +
                        "='" + ((Map)(queryParameters.get("docType"))).get("name") + "'";

                selectSql += ", " + financeDao.getSelectColumns("t12", User.class);
                fromSql += ", " + objectToSql.getTableName(User.class) + " t12 ";
                whereSql += " and t12." + objectToSql.getColumn(User.class.getDeclaredField("id")) +
                        " = t." + objectToSql.getColumn(VoucherItemSource.class.getDeclaredField("chartMaker"));
                // 查询满足制单员条件的凭证条目来源
                if (queryParameters.get("chartMaker") != null){
                    whereSql += " and t12." + objectToSql.getColumn(User.class.getDeclaredField("name")) +
                            " in(";
                    String chartMaker = (String)((Map)queryParameters.get("chartMaker")).get("name");
                    // 得到制单员数组
                    String[] chartMakers = chartMaker.split(";");
                    for (int i = 0;i<chartMakers.length;i++){
                        whereSql += "'"+ chartMakers[i] + "'";
                        if (i != chartMakers.length-1){
                            whereSql += ",";
                        }
                    }
                    whereSql += ")";
                }

                selectSql += ", " + financeDao.getSelectColumns("t13", Warehouse.class);
                fromSql += ", " + objectToSql.getTableName(Warehouse.class) + " t13 ";
                whereSql += " and t13." + objectToSql.getColumn(Warehouse.class.getDeclaredField("id")) +
                        " = t." + objectToSql.getColumn(VoucherItemSource.class.getDeclaredField("warehouse"));
                // 查询满足仓库条件的凭证条目来源
                if (queryParameters.get("warehouse") != null){
                    whereSql += " and t13." + objectToSql.getColumn(Warehouse.class.getDeclaredField("name")) +
                            " in(";
                    String warehouse = (String)((Map)queryParameters.get("warehouse")).get("name");
                    // 得到仓库数组
                    String[] warehouses = warehouse.split(";");
                    for (int i = 0;i<warehouses.length;i++){
                        whereSql += "'"+ warehouses[i] + "'";
                        if (i != warehouses.length-1){
                            whereSql += ",";
                        }
                    }
                    whereSql += ")";
                }

                if (whereSql.indexOf(" and") == 0) {
                    whereSql = whereSql.substring(" and".length());
                }

                sql = "select " + selectSql + " from " + fromSql + " where " + whereSql + " order by " + sortNumSql;

            } else if (docType.equals(FinanceConstant.pay) || docType.equals(FinanceConstant.receipt)){
                // 查询满足支付账号条件的凭证条目来源
                if (queryParameters.get("voucherItemSourceDetail") != null){
                    // 获取条件：凭证条目来源明细
                    Object object = queryParameters.get("voucherItemSourceDetail");
                    List<VoucherItemSourceDetail> voucherItemSourceDetails = new ArrayList<VoucherItemSourceDetail>();
                    List<VoucherItemSourceDetail> voucherItemSourceDetailList = new ArrayList<VoucherItemSourceDetail>();
                    VoucherItemSourceDetail voucherItemSourceDetail = new VoucherItemSourceDetail();
                    String entityId = (String)((Map)object).get("entityId");
                    String entity = (String)((Map)object).get("entity");
                    String[] entityIds = entityId.split(";");
                    for (String entityIdd : entityIds){
                        voucherItemSourceDetail.setEntity(entity);
                        voucherItemSourceDetail.setEntityId(Integer.valueOf(entityIdd));
                        voucherItemSourceDetails = financeDao.query(voucherItemSourceDetail);
                        if (voucherItemSourceDetails != null && !voucherItemSourceDetails.isEmpty()){
                            for (VoucherItemSourceDetail voucherItemSourceDetail1 : voucherItemSourceDetails){
                                voucherItemSourceDetailList.add(voucherItemSourceDetail1);
                            }
                        }
                    }

                    if (voucherItemSourceDetailList != null && !voucherItemSourceDetailList.isEmpty()) {
                        whereSql += " and t.id in(";
                        for (int i = 0; i < voucherItemSourceDetailList.size(); i++) {
                            whereSql += voucherItemSourceDetailList.get(i).getVoucherItemSource().getId();
                            if (i != voucherItemSourceDetailList.size() - 1) {
                                whereSql += ",";
                            }
                        }
                        whereSql += ")";
                    } else {
                        // 根据传过来的支付账号查到的凭证条目来源为空，那么不管其他条件如何，最后都查不到，所以将凭证条目来源的id=-1作为条件
                        whereSql += " and t.id = -1";
                    }
                }

                selectSql += ", " + financeDao.getSelectColumns("t11", DocType.class);
                fromSql += ", " + objectToSql.getTableName(DocType.class) + " t11 ";
                if (!whereSql.trim().equals("")) {
                    whereSql += " and ";
                }
                whereSql += " t11." + objectToSql.getColumn(DocType.class.getDeclaredField("id")) +
                        " = t." + objectToSql.getColumn(VoucherItemSource.class.getDeclaredField("docType"))+
                        " and t11." + objectToSql.getColumn(DocType.class.getDeclaredField("name")) +
                        "='" + ((Map)(queryParameters.get("docType"))).get("name") + "'";

                if (whereSql.indexOf(" and") == 0) {
                    whereSql = whereSql.substring(" and".length());
                }

                sql = "select " + selectSql + " from " + fromSql + " where " + whereSql + " order by " + sortNumSql;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return sql;
    }

    private String getGrossProfitComplexSql(String json, int position, int rowNum) {
        String sql = "";

        try {
            Map<String, Object> queryParameters = writer.gson.fromJson(json, new com.google.gson.reflect.TypeToken<Map<String, Object>>() {}.getType());

            String grossProfitSql = objectToSql.generateComplexSqlByAnnotation(GrossProfit.class,
                    writer.gson.fromJson(writer.gson.toJson(queryParameters.get("grossProfit")),
                            new com.google.gson.reflect.TypeToken<Map<String, String>>() {}.getType()), position, rowNum);

            String selectSql = "", fromSql = "", whereSql = "", sortNumSql = "";

            String[] sqlParts = financeDao.getSqlPart(grossProfitSql, GrossProfit.class);
            selectSql = sqlParts[0];
            fromSql = sqlParts[1];
            whereSql = sqlParts[2];
            sortNumSql = sqlParts[3];

            selectSql += ", " + financeDao.getSelectColumns("t11", User.class);
            fromSql += ", " + objectToSql.getTableName(User.class) + " t11 ";
            if (!whereSql.trim().equals("")) {
                whereSql += " and ";
            }
            whereSql += " t11." + objectToSql.getColumn(User.class.getDeclaredField("id")) +
                    " = t." + objectToSql.getColumn(GrossProfit.class.getDeclaredField("chartMaker"));

            String chartMaker = (String)((Map)queryParameters.get("chartMaker")).get("name");
            if (chartMaker != null && !chartMaker.equals("")){
                whereSql += " and t11." + objectToSql.getColumn(User.class.getDeclaredField("name")) + " in(";
                // 得到制单员数组
                String[] chartMakers = chartMaker.split(";");
                for (int i = 0;i<chartMakers.length;i++){
                    whereSql += "'"+ chartMakers[i] + "'";
                    if (i != chartMakers.length-1){
                        whereSql += ",";
                    }
                }
                whereSql += ")";
            }

            selectSql += ", " + financeDao.getSelectColumns("t12", Customer.class);
            fromSql += ", " + objectToSql.getTableName(Customer.class) + " t12 ";
            whereSql += " and t12." + objectToSql.getColumn(Customer.class.getDeclaredField("id")) +
                    " = t." + objectToSql.getColumn(GrossProfit.class.getDeclaredField("customer"));

            selectSql += ", " + financeDao.getSelectColumns("t13", ProductType.class);
            fromSql += ", " + objectToSql.getTableName(ProductType.class) + " t13 ";
            whereSql += " and t13." + objectToSql.getColumn(ProductType.class.getDeclaredField("id")) +
                    " = t." + objectToSql.getColumn(GrossProfit.class.getDeclaredField("type"));

            if (whereSql.indexOf(" and") == 0) {
                whereSql = whereSql.substring(" and".length());
            }

            sql = "select " + selectSql + " from " + fromSql + " where " + whereSql + " order by " + sortNumSql;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return sql;
    }

    private String getSupplierContactComplexSql(String json, int position, int rowNum) {
        String sql = "";

        try {
            Map<String, Object> queryParameters = writer.gson.fromJson(json, new com.google.gson.reflect.TypeToken<Map<String, Object>>() {}.getType());

            String supplierContactSql = objectToSql.generateComplexSqlByAnnotation(SupplierContact.class,
                    writer.gson.fromJson(writer.gson.toJson(queryParameters.get("supplierContact")),
                            new com.google.gson.reflect.TypeToken<Map<String, String>>() {}.getType()), position, rowNum);

            String selectSql = "", fromSql = "", whereSql = "", sortNumSql = "";

            String[] sqlParts = financeDao.getSqlPart(supplierContactSql, SupplierContact.class);
            selectSql = sqlParts[0];
            fromSql = sqlParts[1];
            whereSql = sqlParts[2];
            if (rowNum != -1){
                sortNumSql = "t.id asc limit " + position + "," + rowNum;
            } else {
                sortNumSql = "t.id asc";
            }

            selectSql += ", " + financeDao.getSelectColumns("t11", Supplier.class);
            fromSql += ", " + objectToSql.getTableName(Supplier.class) + " t11 ";
            if (!whereSql.trim().equals("")) {
                whereSql += " and ";
            }
            whereSql += " t11." + objectToSql.getColumn(Supplier.class.getDeclaredField("id")) +
                    " = t." + objectToSql.getColumn(SupplierContact.class.getDeclaredField("supplier"))+
                    " and t11." + objectToSql.getColumn(Supplier.class.getDeclaredField("name")) +
                    "='" + ((Map)(queryParameters.get("supplier"))).get("name") + "'";

            selectSql += ", " + financeDao.getSelectColumns("t12", DocType.class);
            fromSql += ", " + objectToSql.getTableName(DocType.class) + " t12 ";
            whereSql += " and t12." + objectToSql.getColumn(DocType.class.getDeclaredField("id")) +
                    " = t." + objectToSql.getColumn(SupplierContact.class.getDeclaredField("docType"));

            if (whereSql.indexOf(" and") == 0) {
                whereSql = whereSql.substring(" and".length());
            }

            sql = "select " + selectSql + " from " + fromSql + " where " + whereSql + " order by " + sortNumSql;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return sql;
    }

    private String getCustomerContactComplexSql(String json, int position, int rowNum) {
        String sql = "";

        try {
            Map<String, Object> queryParameters = writer.gson.fromJson(json, new com.google.gson.reflect.TypeToken<Map<String, Object>>() {}.getType());

            String customerContactSql = objectToSql.generateComplexSqlByAnnotation(CustomerContact.class,
                    writer.gson.fromJson(writer.gson.toJson(queryParameters.get("customerContact")),
                            new com.google.gson.reflect.TypeToken<Map<String, String>>() {}.getType()), position, rowNum);

            String selectSql = "", fromSql = "", whereSql = "", sortNumSql = "";

            String[] sqlParts = financeDao.getSqlPart(customerContactSql, CustomerContact.class);
            selectSql = sqlParts[0];
            fromSql = sqlParts[1];
            whereSql = sqlParts[2];
            if (rowNum != -1){
                sortNumSql = "t.id asc limit " + position + "," + rowNum;
            } else {
                sortNumSql = "t.id asc";
            }

            selectSql += ", " + financeDao.getSelectColumns("t11", Customer.class);
            fromSql += ", " + objectToSql.getTableName(Customer.class) + " t11 ";
            if (!whereSql.trim().equals("")) {
                whereSql += " and ";
            }
            whereSql += " t11." + objectToSql.getColumn(Customer.class.getDeclaredField("id")) +
                    " = t." + objectToSql.getColumn(CustomerContact.class.getDeclaredField("customer"))+
                    " and t11." + objectToSql.getColumn(Customer.class.getDeclaredField("name")) +
                    "='" + ((Map)(queryParameters.get("customer"))).get("name") + "'";

            selectSql += ", " + financeDao.getSelectColumns("t12", DocType.class);
            fromSql += ", " + objectToSql.getTableName(DocType.class) + " t12 ";
            whereSql += " and t12." + objectToSql.getColumn(DocType.class.getDeclaredField("id")) +
                    " = t." + objectToSql.getColumn(CustomerContact.class.getDeclaredField("docType"));

            if (whereSql.indexOf(" and") == 0) {
                whereSql = whereSql.substring(" and".length());
            }

            sql = "select " + selectSql + " from " + fromSql + " where " + whereSql + " order by " + sortNumSql;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return sql;
    }

    private String getInOutDetailComplexSql(String json, int position, int rowNum) {
        String sql = "";

        try {
            Map<String, Object> queryParameters = writer.gson.fromJson(json, new com.google.gson.reflect.TypeToken<Map<String, Object>>() {}.getType());

            String inOutDetailSql = objectToSql.generateComplexSqlByAnnotation(InOutDetail.class,
                    writer.gson.fromJson(writer.gson.toJson(queryParameters.get("inOutDetail")),
                            new com.google.gson.reflect.TypeToken<Map<String, String>>() {}.getType()), position, rowNum);

            String selectSql = "", fromSql = "", whereSql = "", sortNumSql = "";

            String[] sqlParts = financeDao.getSqlPart(inOutDetailSql, InOutDetail.class);
            selectSql = sqlParts[0];
            fromSql = sqlParts[1];
            whereSql = sqlParts[2];
            if (rowNum != -1){
                sortNumSql = "t.productNo asc limit " + position + "," + rowNum;
            } else {
                sortNumSql = "t.productNo asc";
            }

            selectSql += ", " + financeDao.getSelectColumns("t11", ProductType.class);
            fromSql += ", " + objectToSql.getTableName(ProductType.class) + " t11 ";
            if (!whereSql.trim().equals("")) {
                whereSql += " and ";
            }
            whereSql += " t11." + objectToSql.getColumn(ProductType.class.getDeclaredField("id")) +
                    " = t." + objectToSql.getColumn(InOutDetail.class.getDeclaredField("type"));

            selectSql += ", " + financeDao.getSelectColumns("t12", DocType.class);
            fromSql += ", " + objectToSql.getTableName(DocType.class) + " t12 ";
            whereSql += " and t12." + objectToSql.getColumn(DocType.class.getDeclaredField("id")) +
                    " = t." + objectToSql.getColumn(CustomerContact.class.getDeclaredField("docType"));

            if (whereSql.indexOf(" and") == 0) {
                whereSql = whereSql.substring(" and".length());
            }

            sql = "select " + selectSql + " from " + fromSql + " where " + whereSql + " order by " + sortNumSql;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return sql;
    }

    private String getCapitalFlowMeterComplexSql(String json, int position, int rowNum) {
        String sql = "";

        try {
            Map<String, Object> queryParameters = writer.gson.fromJson(json, new com.google.gson.reflect.TypeToken<Map<String, Object>>() {}.getType());

            String capitalFlowMeterSql = objectToSql.generateComplexSqlByAnnotation(CapitalFlowMeter.class,
                    writer.gson.fromJson(writer.gson.toJson(queryParameters.get("capitalFlowMeter")),
                            new com.google.gson.reflect.TypeToken<Map<String, String>>() {}.getType()), position, rowNum);

            String selectSql = "", fromSql = "", whereSql = "", sortNumSql = "";

            String[] sqlParts = financeDao.getSqlPart(capitalFlowMeterSql, CapitalFlowMeter.class);
            selectSql = sqlParts[0];
            fromSql = sqlParts[1];
            whereSql = sqlParts[2];
            if (rowNum != -1){
                sortNumSql = "t.id asc limit " + position + "," + rowNum;
            } else {
                sortNumSql = "t.id asc";
            }

            selectSql += ", " + financeDao.getSelectColumns("t11", Account.class);
            fromSql += ", " + objectToSql.getTableName(Account.class) + " t11 ";
            if (!whereSql.trim().equals("")) {
                whereSql += " and ";
            }
            whereSql += " t11." + objectToSql.getColumn(Account.class.getDeclaredField("id")) +
                    " = t." + objectToSql.getColumn(CapitalFlowMeter.class.getDeclaredField("account"))+
                    " and t11." + objectToSql.getColumn(Account.class.getDeclaredField("name")) +
                    "='" + ((Map)(queryParameters.get("account"))).get("name") + "'";

            selectSql += ", " + financeDao.getSelectColumns("t12", DocType.class);
            fromSql += ", " + objectToSql.getTableName(DocType.class) + " t12 ";
            whereSql += " and t12." + objectToSql.getColumn(DocType.class.getDeclaredField("id")) +
                    " = t." + objectToSql.getColumn(CapitalFlowMeter.class.getDeclaredField("docType"));

            if (whereSql.indexOf(" and") == 0) {
                whereSql = whereSql.substring(" and".length());
            }

            sql = "select " + selectSql + " from " + fromSql + " where " + whereSql + " order by " + sortNumSql;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return sql;
    }

    public BigInteger privateRecordNum(String entity, String json){
        String sql = "";

        if (entity.equalsIgnoreCase(Voucher.class.getSimpleName())) {
            sql = getVoucherComplexSql(json, 0, -1);

        } else if (entity.equalsIgnoreCase(GrossProfit.class.getSimpleName())){
            sql = getGrossProfitComplexSql(json, 0, -1);

        } else if (entity.equalsIgnoreCase(SupplierContact.class.getSimpleName())){
            sql = getSupplierContactComplexSql(json, 0, -1);

        } else if (entity.equalsIgnoreCase(CustomerContact.class.getSimpleName())){
            sql = getCustomerContactComplexSql(json, 0, -1);

        } else if (entity.equalsIgnoreCase(InOutDetail.class.getSimpleName())){
            sql = getInOutDetailComplexSql(json, 0, -1);

        } else if (entity.equalsIgnoreCase(CapitalFlowMeter.class.getSimpleName())){
            sql = getCapitalFlowMeterComplexSql(json, 0, -1);
        }

        sql = "select count(t.id) from " + sql.split(" from ")[1];
        return (BigInteger)sessionFactory.getCurrentSession().createSQLQuery(sql).uniqueResult();
    }

}