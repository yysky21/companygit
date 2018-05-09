package com.hzg.finance;

import com.google.gson.reflect.TypeToken;
import com.hzg.base.Dao;
import com.hzg.erp.ProductType;
import com.hzg.erp.Warehouse;
import com.hzg.pay.Account;
import com.hzg.sys.*;
import com.hzg.tools.*;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: SysController.java
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2017/11/25
 */
@Controller
@RequestMapping("/finance")
public class FinanceController extends com.hzg.base.Controller {

    Logger logger = Logger.getLogger(FinanceController.class);

    @Autowired
    private Writer writer;

    @Autowired
    private FinanceClient financeClient;

    @Autowired
    private StrUtil strUtil;

    @Autowired
    private CookieUtils cookieUtils;

    @Autowired
    public Integer sessionTime;

    @Autowired
    public RenderHtmlData renderHtmlData;

    @Autowired
    private Dao dao;

    public FinanceController(FinanceClient financeClient) {
        super(financeClient);
    }

    @GetMapping("/view/{entity}/{id}")
    public String viewById(Map<String, Object> model, @PathVariable("entity") String entity, @PathVariable("id") Integer id,
            @CookieValue(name=CommonConstant.sessionId, defaultValue = "")String sessionId) {
        logger.info("viewById start, entity:" + entity + ", id:" + id);

        List<Object> entities = null;

        String json = "{\"id\":" + id + "}";
        if (entity.equalsIgnoreCase(FinanceConstant.subjectSet)){
            entities = writer.gson.fromJson(financeClient.queryDistinct(FinanceConstant.subject), new TypeToken<List<Subject>>() {
            }.getType());
            model.put(CommonConstant.entities,entities);
        } else if (entity.equalsIgnoreCase(FinanceConstant.extendSet)){
            List<Object> entities1 = null;
            List<Object> entities2 = null;
            String jsonn = "{\"subjectCategory\":{\"id\":" + id + "}}";
            entities = writer.gson.fromJson(financeClient.query(FinanceConstant.subjectRelate,jsonn), new TypeToken<List<SubjectRelate>>() {
            }.getType());
            entities1 = writer.gson.fromJson(financeClient.query(FinanceConstant.subjectCategory,json), new TypeToken<List<SubjectCategory>>() {
            }.getType());
            if (id==2) {
                entities2 = writer.gson.fromJson(financeClient.queryDistinct(FinanceConstant.bankSubjectExtend), new TypeToken<List<BankSubjectExtend>>() {
                }.getType());
            } else if (id==6){
                entities2 = writer.gson.fromJson(financeClient.queryDistinct(FinanceConstant.purchaseSubjectExtend), new TypeToken<List<PurchaseSubjectExtend>>() {
                }.getType());
            }
            model.put(CommonConstant.entities,entities.isEmpty() ? null : entities);
            model.put(CommonConstant.entity, entities1.isEmpty() ? null : entities1.get(0));
            model.put("entities2", entities2.isEmpty() ? null : entities2);
        } else if (entity.equalsIgnoreCase(FinanceConstant.createVoucher)){

        } else {
            if (entity.equalsIgnoreCase(Voucher.class.getSimpleName())) {
                entities = writer.gson.fromJson(client.query(entity, json), new TypeToken<List<Voucher>>() {
                }.getType());
                if (entities.isEmpty()) {
                    Map<String, String> no = writer.gson.fromJson(financeClient.getNo(), new TypeToken<Map<String, String>>() {
                    }.getType());
                    model.put(CommonConstant.no, no.get(CommonConstant.no));
                }

            } else if (entity.equalsIgnoreCase(VoucherCategory.class.getSimpleName())) {
                entities = writer.gson.fromJson(client.query(entity, json), new TypeToken<List<VoucherCategory>>() {
                }.getType());

            } else if (entity.equalsIgnoreCase(Subject.class.getSimpleName())) {
                entities = writer.gson.fromJson(client.query(entity, json), new TypeToken<List<Subject>>() {
                }.getType());

            }

            User user = (User) dao.getFromRedis((String) dao.getFromRedis(CommonConstant.sessionId + CommonConstant.underline + sessionId));

            model.put(CommonConstant.entity, entities.isEmpty() ? null : entities.get(0));
            model.put(CommonConstant.userId, user.getId());
            model.put(CommonConstant.userName,user.getName());
            logger.info("viewById end");
        }

        return "/finance/" + entity;
    }


    @RequestMapping(value = "/privateQuery/{entity}", method = {RequestMethod.GET, RequestMethod.POST})
    public void privateQuery(HttpServletResponse response, String json,Integer position, @PathVariable("entity") String entity) {
        logger.info("privateQuery start, entity:" + entity + ", json:" + json);

        List<Object> entities = null;
        Map<String, Object> model = new HashMap<>();
        if (entity.equalsIgnoreCase(Subject.class.getSimpleName())) {
            writer.writeStringToJson(response, financeClient.privateQuery(entity, json));

        } else if (entity.equalsIgnoreCase(DocType.class.getSimpleName())) {
            entities = writer.gson.fromJson(client.complexQuery(entity,json,position,30), new TypeToken<List<DocType>>() {
            }.getType());
            model.put(CommonConstant.entities,entities == null || entities.isEmpty() ? null : entities);
            Integer recordsSum = ((Map<String, Integer>)writer.gson.fromJson(client.recordsSum(entity, json), new TypeToken<Map<String, Integer>>(){}.getType())).get(CommonConstant.recordsSum);
            model.put(CommonConstant.recordsSum,recordsSum);
            writer.writeObjectToJson(response, model);

        } else if (entity.equalsIgnoreCase(FinanceConstant.chartMaker)) {
            entities = writer.gson.fromJson(client.complexQuery(entity,json,position,30), new TypeToken<List<User>>() {
            }.getType());
            model.put(CommonConstant.entities,entities == null || entities.isEmpty() ? null : entities);
            Integer recordsSum = ((Map<String, Integer>)writer.gson.fromJson(client.recordsSum(entity, json), new TypeToken<Map<String, Integer>>(){}.getType())).get(CommonConstant.recordsSum);
            model.put(CommonConstant.recordsSum,recordsSum);
            writer.writeObjectToJson(response, model);

        } else if (entity.equalsIgnoreCase(Warehouse.class.getSimpleName())) {
            entities = writer.gson.fromJson(client.complexQuery(entity,json,position,30), new TypeToken<List<Warehouse>>() {
            }.getType());
            model.put(CommonConstant.entities,entities == null || entities.isEmpty() ? null : entities);
            Integer recordsSum = ((Map<String, Integer>)writer.gson.fromJson(client.recordsSum(entity, json), new TypeToken<Map<String, Integer>>(){}.getType())).get(CommonConstant.recordsSum);
            model.put(CommonConstant.recordsSum,recordsSum);
            writer.writeObjectToJson(response, model);

        } else if (entity.equalsIgnoreCase(ProductType.class.getSimpleName())) {
            entities = writer.gson.fromJson(client.complexQuery(entity,json,position,30), new TypeToken<List<ProductType>>() {
            }.getType());
            model.put(CommonConstant.entities,entities == null || entities.isEmpty() ? null : entities);
            Integer recordsSum = ((Map<String, Integer>)writer.gson.fromJson(client.recordsSum(entity, json), new TypeToken<Map<String, Integer>>(){}.getType())).get(CommonConstant.recordsSum);
            model.put(CommonConstant.recordsSum,recordsSum);
            writer.writeObjectToJson(response, model);

        } else if (entity.equalsIgnoreCase(Account.class.getSimpleName())) {
            entities = writer.gson.fromJson(client.complexQuery(entity,json,position,30), new TypeToken<List<Account>>() {
            }.getType());
            model.put(CommonConstant.entities,entities == null || entities.isEmpty() ? null : entities);
            Integer recordsSum = ((Map<String, Integer>)writer.gson.fromJson(client.recordsSum(entity, json), new TypeToken<Map<String, Integer>>(){}.getType())).get(CommonConstant.recordsSum);
            model.put(CommonConstant.recordsSum,recordsSum);
            writer.writeObjectToJson(response, model);
        }

        logger.info("privateQuery " + entity + " end");
    }

    @RequestMapping(value = "/specialQuery/{entity}", method = {RequestMethod.GET, RequestMethod.POST})
    public String specialQuery(Map<String, Object> model, String json, @PathVariable("entity") String entity) {
        logger.info("specialQuery start, entity:" + entity + ", json:" + json);

        List<Object> entities = null;
        if (entity.equalsIgnoreCase(VoucherItemSource.class.getSimpleName())) {
            entities = writer.gson.fromJson(client.complexQuery(entity,json,0,-1), new TypeToken<List<VoucherItemSource>>() {
            }.getType());
            model.put(CommonConstant.recordsSum,entities == null || entities.isEmpty() ? 0 : entities.size());
            model.put(CommonConstant.entities,entities == null || entities.isEmpty() ? null : entities);
        }

        logger.info("specialQuery " + entity + " end");
        return "/finance/" + entity;
    }

    @RequestMapping(value = "/create/{entity}", method = {RequestMethod.GET, RequestMethod.POST})
    public String create(Map<String, Object> model, String json, @PathVariable("entity") String entity,@CookieValue(name=CommonConstant.sessionId, defaultValue = "")String sessionId) {
        logger.info("create start, entity:" + entity + ", json:" + json);

        List<Object> entities = null;
        if (entity.equalsIgnoreCase(Voucher.class.getSimpleName())) {
            entities = writer.gson.fromJson(financeClient.privateQuery(entity, json), new TypeToken<List<Voucher>>() {
            }.getType());
            model.put(CommonConstant.entities,entities == null || entities.isEmpty() ? null : entities);
            String jsonn = writer.gson.toJson(entities);
            model.put("json",jsonn);
            User user = (User) dao.getFromRedis((String) dao.getFromRedis(CommonConstant.sessionId + CommonConstant.underline + sessionId));
            model.put(CommonConstant.userId, user.getId());
            model.put(CommonConstant.userName,user.getName());
        }

        logger.info("create " + entity + " end");
        return "/finance/voucherResult";
    }

    @RequestMapping(value = "/print/{name}", method = {RequestMethod.POST})
    public String print(Map<String, Object> model, @PathVariable("name") String name, String json) {
        logger.info("print start, name:" + name + ", json:" + json);

        String printContent = "";
        if (name.equalsIgnoreCase(FinanceConstant.voucher_action_name_print_voucher)){
            printContent = ((Map<String, Object>) writer.gson.fromJson(json, new TypeToken<Map<String, Object>>() {
            }.getType())).get(CommonConstant.printContent).toString();
            model.put(CommonConstant.printContent, printContent);
        }
        logger.info("print " + name + " end");

        return  CommonConstant.print;
    }

}
