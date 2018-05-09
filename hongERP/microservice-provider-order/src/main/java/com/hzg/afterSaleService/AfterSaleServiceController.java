package com.hzg.afterSaleService;

import com.google.gson.reflect.TypeToken;
import com.hzg.erp.Product;
import com.hzg.order.*;
import com.hzg.sys.Action;
import com.hzg.tools.*;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.math.BigInteger;
import java.util.*;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: AfterSaleServiceController.java
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/11/30
 */
@Controller
@RequestMapping("/afterSaleService")
public class AfterSaleServiceController {

    Logger logger = Logger.getLogger(AfterSaleServiceController.class);

    @Autowired
    private AfterSaleServiceDao afterSaleServiceDao;

    @Autowired
    private AfterSaleServiceService afterSaleServiceService;

    @Autowired
    private Writer writer;

    @Autowired
    private Transcation transcation;

    @Autowired
    private DateUtil dateUtil;

    @Autowired
    CustomerClient customerClient;

    /**
     * 保存实体
     * @param response
     * @param entity
     * @param json
     */
    @Transactional
    @PostMapping("/save")
    public void save(HttpServletResponse response, String entity, @RequestBody String json){
        logger.info("save start, parameter:" + entity + ":" + json);
        String result = CommonConstant.fail;
        Integer id = null;

        try {
            if (entity.equalsIgnoreCase(ReturnProduct.class.getSimpleName())) {
                ReturnProduct returnProduct = writer.gson.fromJson(json, ReturnProduct.class);
                result += afterSaleServiceService.saveReturnProduct(returnProduct);
                id = returnProduct.getId();

            } else if (entity.equalsIgnoreCase(ChangeProduct.class.getSimpleName())) {
                ChangeProduct changeProduct = writer.gson.fromJson(json, ChangeProduct.class);
                result += afterSaleServiceService.saveChangeProduct(changeProduct);
                id = changeProduct.getId();

            } else if (entity.equalsIgnoreCase(RepairProduct.class.getSimpleName())) {
                RepairProduct repairProduct = writer.gson.fromJson(json, RepairProduct.class);
                result += afterSaleServiceService.saveRepairProduct(repairProduct);
                id = repairProduct.getId();
            }

        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            result += CommonConstant.fail;
        } finally {
            result = transcation.dealResult(result);
        }

        writer.writeStringToJson(response, "{\"" + CommonConstant.result + "\":\"" + result + "\",\"" + CommonConstant.id + "\":" + id + "}");
        logger.info("save end, result:" + result);
    }


    @Transactional
    @PostMapping("/business")
    public void business(HttpServletResponse response, String name, @RequestBody String json){
        logger.info("business start, parameter:" + name + ":" + json);

        String result = CommonConstant.fail;

        try {
            if (name.equals(AfterSaleServiceConstant.returnProduct_action_name_returnProduct)) {
                result += CommonConstant.success;
                writer.writeStringToJson(response, writer.gson.toJson(afterSaleServiceService.setReturnProduct(json)));
                logger.info("business end");
                return;

            } else if (name.equals(AfterSaleServiceConstant.returnProduct_action_name_saleAudit)) {
                result += afterSaleServiceService.doReturnProductBusinessAction(json, AfterSaleServiceConstant.returnProduct_state_salePass,
                        AfterSaleServiceConstant.returnProduct_action_salePass, AfterSaleServiceConstant.returnProduct_state_saleNotPass,
                        AfterSaleServiceConstant.returnProduct_action_saleNotPass);

            } else if (name.equals(AfterSaleServiceConstant.returnProduct_action_name_directorAudit)) {
                result += afterSaleServiceService.doReturnProductBusinessAction(json, AfterSaleServiceConstant.returnProduct_state_directorPass,
                        AfterSaleServiceConstant.returnProduct_action_directorPass, AfterSaleServiceConstant.returnProduct_state_directorNotPass,
                        AfterSaleServiceConstant.returnProduct_action_directorNotPass);

            } else if (name.equals(AfterSaleServiceConstant.returnProduct_action_name_warehousingAudit)) {
                result += afterSaleServiceService.returnProductWarehouseAudit(json, AfterSaleServiceConstant.returnProduct_state_warehousingPass,
                        AfterSaleServiceConstant.returnProduct_action_warehousingPass, AfterSaleServiceConstant.returnProduct_state_warehousingNotPass,
                        AfterSaleServiceConstant.returnProduct_action_warehousingNotPass);

            } else if (name.equals(AfterSaleServiceConstant.returnProduct_action_name_purchase_returnProduct)) {
                result += CommonConstant.success;
                writer.writeStringToJson(response, writer.gson.toJson(afterSaleServiceService.setPurchaseReturnProduct(json)));
                logger.info("business end");
                return;

            } else if (name.equals(AfterSaleServiceConstant.returnProduct_action_name_purchase_audit)) {
                result += afterSaleServiceService.doReturnProductBusinessAction(json, AfterSaleServiceConstant.returnProduct_state_purchase_purchasePass,
                        AfterSaleServiceConstant.returnProduct_action_purchase_purchasePass, AfterSaleServiceConstant.returnProduct_state_purchase_purchaseNotPass,
                        AfterSaleServiceConstant.returnProduct_action_purchase_purchaseNotPass);

            } else if (name.equals(AfterSaleServiceConstant.returnProduct_action_name_purchase_warehousingAudit)) {
                result += afterSaleServiceService.doReturnProductBusinessAction(json, AfterSaleServiceConstant.returnProduct_state_purchase_warehousingPass,
                        AfterSaleServiceConstant.returnProduct_action_purchase_warehousingPass, AfterSaleServiceConstant.returnProduct_state_purchase_warehousingNotPass,
                        AfterSaleServiceConstant.returnProduct_action_purchase_warehousingNotPass);

            } else if (name.equals(AfterSaleServiceConstant.returnProduct_action_name_purchase_supplierReceived)) {
                result += afterSaleServiceService.doReturnProductBusinessAction(json, AfterSaleServiceConstant.returnProduct_state_purchase_supplierPass,
                        AfterSaleServiceConstant.returnProduct_action_purchase_supplierPass, AfterSaleServiceConstant.returnProduct_state_purchase_supplierNotPass,
                        AfterSaleServiceConstant.returnProduct_action_purchase_supplierNotPass);

            } else if (name.equals(AfterSaleServiceConstant.returnProduct_action_name_refund)) {
                Action action = writer.gson.fromJson(json, Action.class);
                ReturnProduct idReturnProduct = new ReturnProduct(action.getEntityId());
                ReturnProduct returnProduct = afterSaleServiceService.queryReturnProduct(idReturnProduct).get(0);

                /**
                 * 设置sessionId，后面入库用到
                 */
                returnProduct.setSessionId(action.getSessionId());
                result += afterSaleServiceService.refundReturnProduct(returnProduct);

                action.setEntity(AfterSaleServiceConstant.returnProduct);
                action.setType(AfterSaleServiceConstant.returnProduct_action_refund);
                action.setInputer(afterSaleServiceService.getUserBySessionId(action.getSessionId()));
                action.setInputDate(dateUtil.getSecondCurrentTimestamp());
                result += afterSaleServiceDao.save(action);

            } else if (name.equals(AfterSaleServiceConstant.changeProduct_action_name_changeProduct)) {
                result += CommonConstant.success;
                writer.writeStringToJson(response, writer.gson.toJson(afterSaleServiceService.setChangeProduct(json)));
                logger.info("business end");
                return;

            } else if (name.equals(AfterSaleServiceConstant.changeProduct_action_name_saleAudit)) {
                result += afterSaleServiceService.doChangeProductBusinessAction(json, AfterSaleServiceConstant.changeProduct_state_salePass,
                        AfterSaleServiceConstant.changeProduct_action_salePass, AfterSaleServiceConstant.changeProduct_state_saleNotPass,
                        AfterSaleServiceConstant.changeProduct_state_saleNotPass);

            } else if (name.equals(AfterSaleServiceConstant.changeProduct_action_name_directorAudit)) {
                result += afterSaleServiceService.doChangeProductBusinessAction(json, AfterSaleServiceConstant.changeProduct_state_directorPass,
                        AfterSaleServiceConstant.changeProduct_action_directorPass, AfterSaleServiceConstant.changeProduct_state_directorNotPass,
                        AfterSaleServiceConstant.changeProduct_state_directorNotPass);

            } else if (name.equals(AfterSaleServiceConstant.changeProduct_action_name_warehousingAudit)) {
                result += afterSaleServiceService.changeProductWarehouseAudit(json, AfterSaleServiceConstant.changeProduct_state_warehousingPass,
                        AfterSaleServiceConstant.changeProduct_action_warehousingPass, AfterSaleServiceConstant.changeProduct_state_warehousingNotPass,
                        AfterSaleServiceConstant.changeProduct_state_warehousingNotPass);

            } else if (name.equals(AfterSaleServiceConstant.changeProduct_action_name_changeProductComplete)) {
                Action action = writer.gson.fromJson(json, Action.class);
                ChangeProduct changeProduct = (ChangeProduct) afterSaleServiceDao.queryById(action.getEntityId(), ChangeProduct.class);
                /**
                 * 设置sessionId，后面换货中的换货商品订单确认付款及退货商品入库用到
                 */
                changeProduct.setSessionId(action.getSessionId());

                result += afterSaleServiceService.changeProductComplete(changeProduct);

                action.setEntity(AfterSaleServiceConstant.changeProduct);
                action.setType(AfterSaleServiceConstant.changeProduct_action_complete);
                action.setInputer(afterSaleServiceService.getUserBySessionId(action.getSessionId()));
                action.setInputDate(dateUtil.getSecondCurrentTimestamp());
                result += afterSaleServiceDao.save(action);

            } else if (name.equals(AfterSaleServiceConstant.repairProduct_action_name_repairProduct)) {
                result += CommonConstant.success;
                writer.writeStringToJson(response, writer.gson.toJson(afterSaleServiceService.setRepairProduct(json)));
                logger.info("business end");
                return;

            } else if (name.equals(AfterSaleServiceConstant.repairProduct_action_name_saleAudit)) {
                result += afterSaleServiceService.doRepairProductBusinessAction(json, AfterSaleServiceConstant.repairProduct_state_salePass,
                        AfterSaleServiceConstant.repairProduct_action_salePass, AfterSaleServiceConstant.repairProduct_state_saleNotPass,
                        AfterSaleServiceConstant.repairProduct_action_saleNotPass);

            } else if (name.equals(AfterSaleServiceConstant.repairProduct_action_name_directorAudit)) {
                result += afterSaleServiceService.doRepairProductBusinessAction(json, AfterSaleServiceConstant.repairProduct_state_directorPass,
                        AfterSaleServiceConstant.repairProduct_action_directorPass, AfterSaleServiceConstant.repairProduct_state_directorNotPass,
                        AfterSaleServiceConstant.repairProduct_action_directorNotPass);

            } else if (name.equals(AfterSaleServiceConstant.repairProduct_action_name_warehousingAudit)) {
                result += afterSaleServiceService.repairProductWarehouseAudit(json, AfterSaleServiceConstant.repairProduct_state_warehousingPass,
                        AfterSaleServiceConstant.repairProduct_action_warehousingPass, AfterSaleServiceConstant.repairProduct_state_warehousingNotPass,
                        AfterSaleServiceConstant.repairProduct_action_warehousingNotPass);

            } else if (name.equals(AfterSaleServiceConstant.repairProduct_action_name_paid)) {
                Action action = writer.gson.fromJson(json, Action.class);
                result += afterSaleServiceService.repairProductPaid(afterSaleServiceService.queryRepairProductById(action.getEntityId()));

                action.setEntity(AfterSaleServiceConstant.repairProduct);
                action.setType(AfterSaleServiceConstant.repairProduct_action_paid);
                action.setInputer(afterSaleServiceService.getUserBySessionId(action.getSessionId()));
                action.setInputDate(dateUtil.getSecondCurrentTimestamp());
                result += afterSaleServiceDao.save(action);

            } else if (name.equals(AfterSaleServiceConstant.repairProduct_action_name_complete)) {
                Action action = writer.gson.fromJson(json, Action.class);
                RepairProduct repairProduct = afterSaleServiceService.queryRepairProductById(action.getEntityId());
                repairProduct.setUser(afterSaleServiceService.getUserBySessionId(action.getSessionId()));
                repairProduct.setDate(action.getRepairDate());
                result += afterSaleServiceService.repairProductComplete(repairProduct);

                action.setEntity(AfterSaleServiceConstant.repairProduct);
                action.setType(AfterSaleServiceConstant.repairProduct_action_complete);
                action.setInputer(afterSaleServiceService.getUserBySessionId(action.getSessionId()));
                action.setInputDate(dateUtil.getSecondCurrentTimestamp());
                result += afterSaleServiceDao.save(action);
            }

        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            result += CommonConstant.fail;
        } finally {
            result = transcation.dealResult(result);
        }

        writer.writeStringToJson(response, "{\"" + CommonConstant.result + "\":\"" + result + "\"}");
        logger.info("business end, result:" + result);
    }

    @Transactional
    @PostMapping("/print")
    public void print(HttpServletResponse response, String name, @RequestBody String json){
        logger.info("print start, parameter:" + name + ":" + json);

        String result = CommonConstant.fail;
        String printContent = "";

        try {
            Action action = writer.gson.fromJson(json, Action.class);
            if (name.equalsIgnoreCase(AfterSaleServiceConstant.action_name_print_expressWaybill)) {
                printContent = afterSaleServiceService.getSfExpressWaybill(action.getEntity(), action.getEntityId());
                action.setType(AfterSaleServiceConstant.action_print_expressWaybill);
            }

            action.setInputer(afterSaleServiceService.getUserBySessionId(action.getSessionId()));
            action.setInputDate(dateUtil.getSecondCurrentTimestamp());
            result += afterSaleServiceDao.save(action);

        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            result += CommonConstant.fail;
        } finally {
            result = transcation.dealResult(result);
        }

        if (result.contains(CommonConstant.fail)) {
            writer.write(response, result);
        } else {
            writer.write(response, printContent);
        }
        logger.info("print end, result:" + result);
    }

    @RequestMapping(value = "/getProductOnReturnQuantity", method = {RequestMethod.GET, RequestMethod.POST})
    public void getProductOnReturnQuantity(HttpServletResponse response, @RequestBody String json){
        logger.info("getProductOnReturnQuantity start, parameter:" + json);
        writer.writeStringToJson(response, "{\"" + ErpConstant.product_onReturn_quantity +"\":\"" + afterSaleServiceService.getProductOnReturnQuantity(writer.gson.fromJson(json, Product.class)) + "\"}");
        logger.info("getProductOnReturnQuantity end");
    }

    @RequestMapping(value = "/getProductReturnedQuantity", method = {RequestMethod.GET, RequestMethod.POST})
    public void getProductReturnedQuantity(HttpServletResponse response, @RequestBody String json){
        logger.info("getProductReturnedQuantity start, parameter:" + json);
        writer.writeStringToJson(response, "{\"" + ErpConstant.product_returned_quantity +"\":\"" + afterSaleServiceService.getProductReturnedQuantity(writer.gson.fromJson(json, Product.class)) + "\"}");
        logger.info("getProductReturnedQuantity end");
    }

    @RequestMapping(value = "/getPurchaseProductOnReturnQuantity", method = {RequestMethod.GET, RequestMethod.POST})
    public void getPurchaseProductOnReturnQuantity(HttpServletResponse response, @RequestBody String json){
        logger.info("getPurchaseProductOnReturnQuantity start, parameter:" + json);
        writer.writeStringToJson(response, "{\"" + ErpConstant.product_onReturn_quantity +"\":\"" + afterSaleServiceService.getPurchaseProductOnReturnQuantity(writer.gson.fromJson(json, Product.class)) + "\"}");
        logger.info("getPurchaseProductOnReturnQuantity end");
    }

    @RequestMapping(value = "/getPurchaseProductReturnedQuantity", method = {RequestMethod.GET, RequestMethod.POST})
    public void getPurchaseProductReturnedQuantity(HttpServletResponse response, @RequestBody String json){
        logger.info("getPurchaseProductReturnedQuantity start, parameter:" + json);
        writer.writeStringToJson(response, "{\"" + ErpConstant.product_returned_quantity +"\":\"" + afterSaleServiceService.getPurchaseProductReturnedQuantity(writer.gson.fromJson(json, Product.class)) + "\"}");
        logger.info("getPurchaseProductReturnedQuantity end");
    }

    @RequestMapping(value = "/getProductOnChangeQuantity", method = {RequestMethod.GET, RequestMethod.POST})
    public void getProductOnChangeQuantity(HttpServletResponse response, @RequestBody String json){
        logger.info("getProductOnChangeQuantity start, parameter:" + json);
        writer.writeStringToJson(response, "{\"" + ErpConstant.product_onChange_quantity +"\":\"" + afterSaleServiceService.getProductOnChangeQuantity(writer.gson.fromJson(json, Product.class)) + "\"}");
        logger.info("getProductOnChangeQuantity end");
    }

    @RequestMapping(value = "/getProductOnChangeOnReturnQuantity", method = {RequestMethod.GET, RequestMethod.POST})
    public void getProductOnChangeOnReturnQuantity(HttpServletResponse response, @RequestBody String json){
        logger.info("getProductOnChangeOnReturnQuantity start, parameter:" + json);
        writer.writeStringToJson(response, "{\"" + ErpConstant.product_onChange_quantity +"\":\"" + afterSaleServiceService.getProductOnChangeOnReturnQuantity(writer.gson.fromJson(json, Product.class)) + "\"}");
        logger.info("getProductOnChangeOnReturnQuantity end");
    }

    @RequestMapping(value = "/getProductChangedQuantity", method = {RequestMethod.GET, RequestMethod.POST})
    public void getProductChangedQuantity(HttpServletResponse response, @RequestBody String json){
        logger.info("getProductChangedQuantity start, parameter:" + json);
        writer.writeStringToJson(response, "{\"" + ErpConstant.product_changed_quantity +"\":\"" + afterSaleServiceService.getProductChangedQuantity(writer.gson.fromJson(json, Product.class)) + "\"}");
        logger.info("getProductChangedQuantity end");
    }

    @RequestMapping(value = "/getProductOnRepairQuantity", method = {RequestMethod.GET, RequestMethod.POST})
    public void getProductOnRepairQuantity(HttpServletResponse response, @RequestBody String json){
        logger.info("getProductOnRepairQuantity start, parameter:" + json);
        writer.writeStringToJson(response, "{\"" + ErpConstant.product_onRepair_quantity +"\":\"" + afterSaleServiceService.getProductOnRepairQuantity(writer.gson.fromJson(json, Product.class)) + "\"}");
        logger.info("getProductOnRepairQuantity end");
    }

    @RequestMapping(value = "/getProductRepairedQuantity", method = {RequestMethod.GET, RequestMethod.POST})
    public void getProductRepairedQuantity(HttpServletResponse response, @RequestBody String json){
        logger.info("getProductRepairedQuantity start, parameter:" + json);
        writer.writeStringToJson(response, "{\"" + ErpConstant.product_repaired_quantity +"\":\"" + afterSaleServiceService.getProductRepairedQuantity(writer.gson.fromJson(json, Product.class)) + "\"}");
        logger.info("getProductRepairedQuantity end");
    }

    @RequestMapping(value = "/unlimitedQuery", method = {RequestMethod.GET, RequestMethod.POST})
    public void unlimitedQuery(HttpServletResponse response, String entity, @RequestBody String json){
        logger.info("unlimitedQuery start, parameter:" + entity + ":" + json);

        if (entity.equalsIgnoreCase(ReturnProduct.class.getSimpleName())) {
            List<ReturnProduct> returnProducts = afterSaleServiceService.queryReturnProduct(writer.gson.fromJson(json, ReturnProduct.class));
            writer.writeObjectToJson(response, returnProducts);

        } else if (entity.equalsIgnoreCase(ChangeProduct.class.getSimpleName())) {
            List<ChangeProduct> changeProducts = afterSaleServiceService.queryChangeProduct(writer.gson.fromJson(json, ChangeProduct.class));
            writer.writeObjectToJson(response, changeProducts);

        } else if (entity.equalsIgnoreCase(RepairProduct.class.getSimpleName())) {
            List<RepairProduct> repairProducts = afterSaleServiceService.queryRepairProduct(writer.gson.fromJson(json, RepairProduct.class));
            writer.writeObjectToJson(response, repairProducts);
        }

        logger.info("unlimitedQuery end");
    }

    @RequestMapping(value = "/unlimitedSuggest", method = {RequestMethod.GET, RequestMethod.POST})
    public void unlimitedSuggest(HttpServletResponse response, String entity, @RequestBody String json){
        logger.info("unlimitedSuggest start, parameter:" + entity + ":" + json);

        if (entity.equalsIgnoreCase(ReturnProduct.class.getSimpleName())) {
            writer.writeObjectToJson(response, afterSaleServiceDao.suggest(writer.gson.fromJson(json, ReturnProduct.class), null));

        } else if (entity.equalsIgnoreCase(ChangeProduct.class.getSimpleName())) {
            writer.writeObjectToJson(response, afterSaleServiceDao.suggest(writer.gson.fromJson(json, ChangeProduct.class), null));

        } else if (entity.equalsIgnoreCase(RepairProduct.class.getSimpleName())) {
            writer.writeObjectToJson(response, afterSaleServiceDao.suggest(writer.gson.fromJson(json, RepairProduct.class), null));
        }

        logger.info("unlimitedSuggest end");
    }

    @RequestMapping(value = "/unlimitedComplexQuery", method = {RequestMethod.GET, RequestMethod.POST})
    public void unlimitedComplexQuery(HttpServletResponse response, String entity, @RequestBody String json, int position, int rowNum){
        logger.info("unlimitedComplexQuery start, parameter:" + entity + ":" + json + "," + position + "," + rowNum);

        if (entity.equalsIgnoreCase(ReturnProduct.class.getSimpleName())) {
            writer.writeObjectToJson(response, afterSaleServiceService.complexQueryReturnProduct(json, position, rowNum));

        } else if (entity.equalsIgnoreCase(ChangeProduct.class.getSimpleName())) {
            writer.writeObjectToJson(response, afterSaleServiceDao.complexQuery(ChangeProduct.class,
                    writer.gson.fromJson(json, new TypeToken<Map<String, String>>(){}.getType()), position, rowNum));

        } else if (entity.equalsIgnoreCase(RepairProduct.class.getSimpleName())) {
            writer.writeObjectToJson(response, afterSaleServiceDao.complexQuery(RepairProduct.class,
                    writer.gson.fromJson(json, new TypeToken<Map<String, String>>(){}.getType()), position, rowNum));
        }

        logger.info("unlimitedComplexQuery end");
    }

    /**
     * 查询条件限制下的记录数
     * @param response
     * @param entity
     * @param json
     */
    @RequestMapping(value = "/unlimitedRecordsSum", method = {RequestMethod.GET, RequestMethod.POST})
    public void unlimitedRecordsSum(HttpServletResponse response, String entity, @RequestBody String json){
        logger.info("unlimitedRecordsSum start, parameter:" + entity + ":" + json);
        BigInteger recordsSum = new BigInteger("-1");

        if (entity.equalsIgnoreCase(ReturnProduct.class.getSimpleName())) {
            recordsSum = afterSaleServiceDao.recordsSum(ReturnProduct.class, writer.gson.fromJson(json, new TypeToken<Map<String, String>>(){}.getType()));

        } else if (entity.equalsIgnoreCase(ChangeProduct.class.getSimpleName())) {
            recordsSum = afterSaleServiceDao.recordsSum(ChangeProduct.class, writer.gson.fromJson(json, new TypeToken<Map<String, String>>(){}.getType()));

        } else if (entity.equalsIgnoreCase(RepairProduct.class.getSimpleName())) {
            recordsSum = afterSaleServiceDao.recordsSum(RepairProduct.class, writer.gson.fromJson(json, new TypeToken<Map<String, String>>(){}.getType()));
        }

        writer.writeStringToJson(response, "{\"" + CommonConstant.recordsSum + "\":" + recordsSum + "}");
        logger.info("unlimitedRecordsSum end");
    }

    @RequestMapping(value = "/getLastValidReturnProductByProduct", method = {RequestMethod.GET, RequestMethod.POST})
    public void getLastValidReturnProductByProduct(HttpServletResponse response, @RequestBody String json){
        logger.info("getLastValidReturnProductByProduct start, parameter:" + json);
        writer.writeObjectToJson(response, afterSaleServiceService.getLastValidReturnProductByProduct(writer.gson.fromJson(json, Product.class)));
        logger.info("getLastValidReturnProductByProduct end");
    }

    @RequestMapping(value = "/getLastValidChangeProductByProduct", method = {RequestMethod.GET, RequestMethod.POST})
    public void getLastValidChangeProductByProduct(HttpServletResponse response, @RequestBody String json){
        logger.info("getLastValidChangeProductByProduct start, parameter:" + json);
        writer.writeObjectToJson(response, afterSaleServiceService.getLastValidChangeProductByProduct(writer.gson.fromJson(json, Product.class)));
        logger.info("getLastValidChangeProductByProduct end");
    }

    @RequestMapping(value = "/getLastValidRepairProductByProduct", method = {RequestMethod.GET, RequestMethod.POST})
    public void getLastValidRepairProductByProduct(HttpServletResponse response, @RequestBody String json){
        logger.info("getLastValidRepairProductByProduct start, parameter:" + json);
        writer.writeObjectToJson(response, afterSaleServiceService.getLastValidRepairProductByProduct(writer.gson.fromJson(json, Product.class)));
        logger.info("getLastValidRepairProductByProduct end");
    }
}
