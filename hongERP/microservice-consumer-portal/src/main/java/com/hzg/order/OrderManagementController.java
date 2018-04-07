package com.hzg.order;

import com.google.common.reflect.TypeToken;
import com.hzg.pay.Account;
import com.hzg.pay.PayClient;
import com.hzg.sys.User;
import com.hzg.tools.CommonConstant;
import com.hzg.tools.Writer;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: OrderManagementController.java
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/8/28
 */
@Controller
@RequestMapping("/orderManagement")
public class OrderManagementController extends com.hzg.base.Controller {

    Logger logger = Logger.getLogger(OrderManagementController.class);

    @Autowired
    private OrderClient orderClient;

    @Autowired
    private PayClient payClient;

    @Autowired
    private Writer writer;

    public OrderManagementController(OrderClient orderClient) {
        super(orderClient);
    }

    @GetMapping("/view/{entity}/{id}")
    public String viewById(Map<String, Object> model, @PathVariable("entity") String entity, @PathVariable("id") Integer id,
                           @CookieValue(name=CommonConstant.sessionId, defaultValue = "")String sessionId) {
        logger.info("viewById start, entity:" + entity + ", id:" + id);

        List<Object> entities = null;

        String json = "{\"" + CommonConstant.id +"\":" + id + "}";

        if (entity.equalsIgnoreCase(Order.class.getSimpleName())) {
            entities = writer.gson.fromJson(orderClient.unlimitedQuery(entity, json), new TypeToken<List<Order>>() {}.getType());

            model.put(CommonConstant.resources, dao.getFromRedis((String)dao.getFromRedis(CommonConstant.sessionId + CommonConstant.underline + sessionId) +
                    CommonConstant.underline + CommonConstant.resources));

        } else if (entity.equalsIgnoreCase(OrderPrivate.class.getSimpleName())) {
            entities = writer.gson.fromJson(orderClient.unlimitedQuery(entity, json), new TypeToken<List<OrderPrivate>>() {}.getType());
        }

        model.put(CommonConstant.sessionId, sessionId);
        model.put(CommonConstant.entity, entities.isEmpty() ? null : entities.get(0));
        logger.info("viewById end");

        return "/order/" + entity;
    }

    @RequestMapping(value = "/business/{name}", method = {RequestMethod.GET, RequestMethod.POST})
    public String business(Map<String, Object> model, @PathVariable("name") String name, String json,
                           @CookieValue(name=CommonConstant.sessionId, defaultValue = "")String sessionId) {
        logger.info("business start, name:" + name + ", json:" + json);

        model.put(CommonConstant.sessionId, sessionId);
        model.put(CommonConstant.userId, ((User)dao.getFromRedis((String)dao.getFromRedis(CommonConstant.sessionId + CommonConstant.underline + sessionId))).getId());
        model.put("accounts", writer.gson.fromJson(payClient.query(Account.class.getSimpleName().toLowerCase(), "{}"), new com.google.gson.reflect.TypeToken<List<Account>>() {}.getType()));
        logger.info("business " + name + " end");

        return "/order/" + name;
    }

    @RequestMapping(value = "/doBusiness/{name}", method = {RequestMethod.GET, RequestMethod.POST})
    public void doBusiness(HttpServletResponse response, @PathVariable("name") String name, String json) {
        writer.writeStringToJson(response, orderClient.business(name, json));
    }

    @PostMapping("/assistBook")
    public void assistBook(HttpServletResponse response, String json) {
        writer.writeStringToJson(response, orderClient.save(Order.class.getSimpleName(), json));
    }

    @PostMapping("/cancel")
    public void cancel(HttpServletResponse response, String json) {
        logger.info("cancel order start:" + json);
        writer.writeStringToJson(response, orderClient.cancel(json));
        logger.info("cancel order end");
    }

    @PostMapping("/paid")
    public void paid(HttpServletResponse response, String json) {
        logger.info("paid order start:" + json);
        writer.writeStringToJson(response, orderClient.paid(json));
        logger.info("paid order end");
    }

    @PostMapping("/audit")
    public void audit(HttpServletResponse response, String json) {
        logger.info("audit order start:" + json);
        writer.writeStringToJson(response, orderClient.audit(json));
        logger.info("audit order end");
    }
}
