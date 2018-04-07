package com.hzg.sys;

import com.google.gson.internal.LinkedTreeMap;
import com.google.gson.reflect.TypeToken;
import com.hzg.base.Dao;
import com.hzg.erp.ProductType;
import com.hzg.erp.Warehouse;
import com.hzg.finance.DocType;
import com.hzg.finance.Subject;
import com.hzg.pay.Account;
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
 * @author smjie
 * @version 1.00
 * @Date 2017/3/16
 */
@Controller
@RequestMapping("/sys")
public class SysController extends com.hzg.base.Controller {

    Logger logger = Logger.getLogger(SysController.class);

    @Autowired
    private Writer writer;

    @Autowired
    private SysClient sysClient;

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

    public SysController(SysClient sysClient) {
        super(sysClient);
    }

    @GetMapping("/view/{entity}/{id}")
    public String viewById(Map<String, Object> model, @PathVariable("entity") String entity, @PathVariable("id") Integer id,
            @CookieValue(name=CommonConstant.sessionId, defaultValue = "")String sessionId) {
        logger.info("viewById start, entity:" + entity + ", id:" + id);

        List<Object> entities = null;

        String json = "{\"id\":" + id + "}";

        if (entity.equalsIgnoreCase(User.class.getSimpleName())) {
            entities = writer.gson.fromJson(client.query(entity, json), new TypeToken<List<User>>() {}.getType());
            model.put(CommonConstant.sessionId, sessionId);

        } else if (entity.equalsIgnoreCase(Post.class.getSimpleName())) {
            entities = writer.gson.fromJson(client.query(entity, json), new TypeToken<List<Post>>() {}.getType());

        } else if (entity.equalsIgnoreCase(Dept.class.getSimpleName())) {
            entities = writer.gson.fromJson(client.query(entity, json), new TypeToken<List<Dept>>() {}.getType());

        } else if (entity.equalsIgnoreCase(Company.class.getSimpleName())) {
            entities = writer.gson.fromJson(client.query(entity, json), new TypeToken<List<Company>>() {}.getType());

        } else if (entity.equalsIgnoreCase(PrivilegeResource.class.getSimpleName())) {
            entities = writer.gson.fromJson(client.query(entity, json), new TypeToken<List<PrivilegeResource>>() {}.getType());

        } else if (entity.equalsIgnoreCase(Audit.class.getSimpleName())) {
            json = json.substring(0, json.length()-1) + ",\"" + CommonConstant.sessionId + "\":\"" + sessionId + "\"}";
            entities = writer.gson.fromJson(sysClient.privateQuery(entity, json), new TypeToken<List<Audit>>(){}.getType());

            List<Audit> audits = null;
            if (!entities.isEmpty()) {
                audits = writer.gson.fromJson(sysClient.privateQuery(entity, "{\"no\":" + ((Audit)entities.get(0)).getNo() + ",\"" + CommonConstant.sessionId + "\":\"" + sessionId + "\"}"),
                        new TypeToken<List<Audit>>() {}.getType());
            }

            if (!audits.isEmpty()) {
                audits.sort(new Comparator<Audit>() {
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
                    public int compare(Audit o1, Audit o2) {
                        if (o1.getId().compareTo(o2.getId()) > 0) {
                            return 1;
                        } else if (o1.getId().compareTo(o2.getId()) < 0) {
                            return -1;
                        }

                        return 0;
                    }
                });
            }

            String refuseUserOptions = "";
            if (!audits.isEmpty()) {
                User currentUser = (User)dao.getFromRedis((String)dao.getFromRedis(CommonConstant.sessionId + CommonConstant.underline + sessionId));
                refuseUserOptions = renderHtmlData.getRefuseUserOptions(currentUser, audits, "", 0);
            }

            if (!refuseUserOptions.equals("")) {
                model.put("refuseUserOptions", refuseUserOptions);
            }

            model.put("entities", audits);
            model.put(CommonConstant.sessionId, sessionId);

        } else if (entity.equalsIgnoreCase(AuditFlow.class.getSimpleName())) {
            entities = writer.gson.fromJson(client.query(entity, json), new TypeToken<List<AuditFlow>>() {}.getType());

            if (!entities.isEmpty()) {
                AuditFlow auditFlow = (AuditFlow) entities.get(0);

                if (!auditFlow.getAuditFlowNodes().isEmpty()) {
                    AuditFlowNode[] auditFlowNodes = new AuditFlowNode[auditFlow.getAuditFlowNodes().size()];
                    auditFlow.getAuditFlowNodes().toArray(auditFlowNodes);

                    Arrays.sort(auditFlowNodes, new Comparator<AuditFlowNode>() {
                        @Override
                        public int compare(AuditFlowNode o1, AuditFlowNode o2) {
                            if (o1.getId().compareTo(o2.getId()) > 0) {
                                return 1;
                            } else if (o1.getId().compareTo(o2.getId()) < 0) {
                                return -1;
                            }

                            return 0;
                        }
                    });

                    model.put("auditFlowNodes", auditFlowNodes);
                }
            }
        } else if (entity.equalsIgnoreCase(Article.class.getSimpleName())) {
            entities = writer.gson.fromJson(client.query(entity, json), new TypeToken<List<Article>>() {}.getType());
            model.put("user",dao.getFromRedis((String) dao.getFromRedis(CommonConstant.sessionId + CommonConstant.underline + sessionId)));

        } else if (entity.equalsIgnoreCase(ArticleCate.class.getSimpleName())) {
            entities = writer.gson.fromJson(client.query(entity, json), new TypeToken<List<ArticleCate>>() {}.getType());

        } else if (entity.equalsIgnoreCase(ArticleTag.class.getSimpleName())) {
            entities = writer.gson.fromJson(client.query(entity, json), new TypeToken<List<ArticleTag>>() {}.getType());

        }

        model.put("entity", entities.isEmpty() ? null : entities.get(0));
        logger.info("viewById end");
        return "/sys/" + entity;
    }

    @RequestMapping(value = "/privateQuery/{entity}", method = {RequestMethod.GET, RequestMethod.POST})
    public void privateQuery(HttpServletResponse response, String dataTableParameters, String json, Integer recordsSum,
                             @PathVariable("entity") String entity, @CookieValue(name=CommonConstant.sessionId, defaultValue = "")String sessionId) {
        logger.info("privateQuery start, entity:" + entity + ", json:" + json);
        String privateCondition = "";

        if (entity.equals("audit")) {
            User user = (User) dao.getFromRedis((String)dao.getFromRedis(CommonConstant.sessionId + CommonConstant.underline + sessionId));
            for (Post post : user.getPosts()) {
                privateCondition += post.getId() + ",";
            }

            if (!privateCondition.equals("")) {
                if (!json.equals("{}")) {
                    json = json.substring(0, json.length()-1) + ",\"post\":\" in (" + privateCondition.substring(0, privateCondition.length()-1) + ")\"" +
                            ",\"user\":\"" + user.getId() +"\"}";
                } else {
                    json = "{" + "\"post\": \"in(" + privateCondition.substring(0, privateCondition.length()-1) + ")\"" +
                            ",\"user\":\"" + user.getId() + "\"}";
                }
            }

            complexQuery(response, dataTableParameters, json, recordsSum, entity);
        }

        logger.info("privateQuery " + entity + " end");
    }

    @RequestMapping(value = "/specialQuery/{entity}", method = {RequestMethod.GET, RequestMethod.POST})
    public void privateQuery(HttpServletResponse response, String json,Integer position, @PathVariable("entity") String entity) {
        logger.info("specialQuery start, entity:" + entity + ", json:" + json);

        List<Object> entities = null;
        Map<String, Object> model = new HashMap<>();
        if (entity.equalsIgnoreCase(ArticleTag.class.getSimpleName())) {
            entities = writer.gson.fromJson(client.complexQuery(entity,json,position,30), new TypeToken<List<ArticleTag>>() {
            }.getType());
            model.put(CommonConstant.entities,entities == null || entities.isEmpty() ? null : entities);
            Integer recordsSum = ((Map<String, Integer>)writer.gson.fromJson(client.recordsSum(entity, json), new TypeToken<Map<String, Integer>>(){}.getType())).get(CommonConstant.recordsSum);
            model.put(CommonConstant.recordsSum,recordsSum);
            writer.writeObjectToJson(response, model);

        }

        logger.info("specialQuery " + entity + " end");
    }

    @RequestMapping(value = "/business/{name}", method = {RequestMethod.GET, RequestMethod.POST})
    public String business(Map<String, Object> model, @PathVariable("name") String name, String json) {
        logger.info("business start, name:" + name + ", json:" + json);

        if (name.equals("assignPrivilege")) {
            Map<String, Object> result = writer.gson.fromJson(sysClient.queryPrivilege(json), new TypeToken<Map<String, Object>>(){}.getType());
            if (result.get("post") != null) {
                Post post = writer.gson.fromJson(writer.gson.toJson(result.get("post")), Post.class);
                PrivilegeResource[] assignPrivilegeResources = new PrivilegeResource[post.getPrivilegeResources().size()];
                post.getPrivilegeResources().toArray(assignPrivilegeResources);

                Arrays.sort(assignPrivilegeResources, new Comparator<PrivilegeResource>() {
                    @Override
                    public int compare(PrivilegeResource o1, PrivilegeResource o2) {
                        if (o1.getId().compareTo(o2.getId()) > 0) {
                            return -1;
                        } else if (o1.getId().compareTo(o2.getId()) < 0) {
                            return 1;
                        }

                        return 0;
                    }
                });
                model.put("entity", post);
                model.put("assignPrivileges", assignPrivilegeResources);
            }
            model.put("unAssignPrivileges", result.get("unAssignPrivileges"));
        }

        logger.info("business " + name + " end");
        return "/sys/" + name;
    }

    @RequestMapping(value = "/doBusiness/{name}", method = {RequestMethod.GET, RequestMethod.POST})
    public void doBusiness(javax.servlet.http.HttpServletRequest request, HttpServletResponse response,
                           @PathVariable("name") String name, String json, String sessionId) {
        logger.info("doBusiness start, name:" + name + ", json:" + json);
        writer.writeStringToJson(response, sysClient.business(name, json));
        logger.info("doBusiness " + name + " end");
    }

    @CrossOrigin
    @PostMapping("/authorize")
    public void authorize(HttpServletResponse response, String sessionId, String uri) {
        logger.info("authorize start, sessionId:" + sessionId + ", uri:" + uri);

        String result = "{\"" + CommonConstant.result + "\":\"" + CommonConstant.fail +"\"}";

        String username = (String)dao.getFromRedis(CommonConstant.sessionId + CommonConstant.underline + sessionId);

        if (username != null) {
            String signInedUserSessionId = (String)dao.getFromRedis(CommonConstant.user + CommonConstant.underline + username);

            if (signInedUserSessionId != null && signInedUserSessionId.equals(sessionId)) {

                String resources = (String)dao.getFromRedis(username + CommonConstant.underline + CommonConstant.resources);
                if (resources != null && resources.contains(uri)) {
                    result = "{\"" + CommonConstant.result + "\":\"" + CommonConstant.success +"\"}";
                }
            }
        }

        writer.writeStringToJson(response, result);
        logger.info("authorize end");
    }

    /**
     * 事宜办理
     * @param response
     * @param json
     */
    @PostMapping("/audit")
    public void audit(HttpServletResponse response, String json) {
        logger.info("audit start, json:" + json);
        writer.writeStringToJson(response, sysClient.audit(json));
        logger.info("audit end");
    }

    /**
     * 到登录页面，设置加密密码的 salt
     * @param model
     * @return
     */
    @GetMapping("/user/signIn")
    public String signIn(HttpServletResponse response, Map<String, Object> model) {
        String sessionId = strUtil.generateDateRandomStr(32);

        String salt = "";
        if (model.get(CommonConstant.oldSessionId) == null) {
            salt = strUtil.generateRandomStr(256);
        } else {
            salt = (String) dao.getFromRedis(CommonConstant.salt + CommonConstant.underline + (String)model.get(CommonConstant.oldSessionId));
        }

        cookieUtils.addCookie(response, CommonConstant.sessionId, sessionId);
        dao.storeToRedis(CommonConstant.salt + CommonConstant.underline + sessionId, salt, sessionTime);

        model.put(CommonConstant.salt, salt);
        model.put(CommonConstant.sessionId, sessionId);

        return "/signIn";
    }

    /**
     * 显示登录结果
     * @param model
     * @param sessionId
     * @return
     */
    @GetMapping("/user/signResult")
    public String signResult(HttpServletResponse response, Map<String, Object> model, String sessionId) {
        model.put(CommonConstant.result, dao.getFromRedis(CommonConstant.result + CommonConstant.underline + sessionId));
        model.put(CommonConstant.oldSessionId, sessionId);
        return signIn(response, model);
    }

    /**
     * 用户登录，注销，重复登录
     * @param name
     * @param json
     * @return
     */
    @PostMapping("/user/{name}")
    public String user(HttpServletRequest request, HttpServletResponse response, @PathVariable("name") String name, String json) {
        logger.info("user start, name:" + name + ", json:" + json);

        String page;

        Map<String, String> result = null;
        if (name.equals("signIn")) {
            result = writer.gson.fromJson(sysClient.signIn(json), new TypeToken<Map<String, String>>(){}.getType());

        } else if (name.equals("signOut")) {
            cookieUtils.delCookie(request, response, CommonConstant.sessionId);
            result = writer.gson.fromJson(sysClient.signOut(json), new TypeToken<Map<String, String>>(){}.getType());

        } else if (name.equals("hasLoginDeal")) {
            result = writer.gson.fromJson(sysClient.hasLoginDeal(json), new TypeToken<Map<String, String>>(){}.getType());
        }

        if (result.get(CommonConstant.result).equals(CommonConstant.success)) {
            page = "redirect:/";

            if (name.equals("signOut")) {
                page = "redirect:/sys/user/signIn";
            }

        } else {
            Map<String, String> formInfo = writer.gson.fromJson(json, new TypeToken<Map<String, String>>(){}.getType());

            dao.storeToRedis(CommonConstant.result + CommonConstant.underline + formInfo.get(CommonConstant.sessionId), result.get(CommonConstant.result), 30);
            page = "redirect:/sys/user/signResult?sessionId=" + formInfo.get(CommonConstant.sessionId);

            if (name.equals("signOut")) {
                page = "redirect:/";
            }
        }

        logger.info("user " + name + " end");

        return page;
    }
}
