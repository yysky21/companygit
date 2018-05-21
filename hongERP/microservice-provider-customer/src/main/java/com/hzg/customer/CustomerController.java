package com.hzg.customer;

import com.google.gson.reflect.TypeToken;
import com.hzg.base.Dao;
import com.hzg.sys.Action;
import com.hzg.tools.*;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Field;
import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.*;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: CustomerController.java
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/8/15
 */
@Controller
@RequestMapping("/customer")
public class CustomerController {

    Logger logger = Logger.getLogger(CustomerController.class);

    @Autowired
    private Dao dao;

    @Autowired
    private SmsClient smsClient;

    @Autowired
    private Writer writer;

    @Autowired
    private SignInUtil signInUtil;

    @Autowired
    private Transcation transcation;

    @Autowired
    private DateUtil dateUtil;

    @Autowired
    private StrUtil strUtil;

    @Autowired
    private CustomerService customerService;

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

        try {
            /**
             * 客户、用户注册要验证短信验证码
             */
            if (entity.equalsIgnoreCase(Customer.class.getSimpleName())) {
                Map<String, Object> saveData = writer.gson.fromJson(json, new TypeToken<Map<String, Object>>() {}.getType());
                String validateCode = saveData.get(SmsConstant.validateCode).toString();
                int index = validateCode.indexOf(".");
                if (index != -1) {
                    validateCode = validateCode.substring(0, index);
                }

                Map<String, Object> dbValidateCodeMap = writer.gson.fromJson(smsClient.getValidateCode(saveData.get(SmsConstant.mobile).toString(), saveData.get(SmsConstant.validateCodeKey).toString()),
                        new TypeToken<Map<String, Object>>() {
                        }.getType());
                String dbValidateCode = dbValidateCodeMap.get(SmsConstant.validateCode).toString();
                int dbIndex = dbValidateCode.indexOf(".");
                if (dbIndex != -1) {
                    dbValidateCode = dbValidateCode.substring(0, index);
                }

                if (dbValidateCode != null && validateCode.equals(dbValidateCode)) {
                    /**
                     * 客户注册
                     */
                    result += customerService.saveCustomer(writer.gson.fromJson(json, Customer.class));
                    if (!result.contains(CommonConstant.fail)) {
                        smsClient.delValidateCode(saveData.get(SmsConstant.phone).toString(), saveData.get(SmsConstant.validateCodeKey).toString());
                    }

                } else {
                    if (dbValidateCode != null) {
                        result += CommonConstant.fail + ",验证码不正确，或者注册的手机号不是接受短信验证码的手机号，不能保存信息";

                    } else {
                        result += CommonConstant.fail + ",验证码已经过期，请重新获取验证码，来保存信息";
                    }
                }
            }

            if (entity.equalsIgnoreCase(Express.class.getSimpleName())) {
                result += customerService.saveExpress(writer.gson.fromJson(json, Express.class));
            }

        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            result += CommonConstant.fail;
        } finally {
            result = transcation.dealResult(result);
        }

        writer.writeStringToJson(response, "{\"" + CommonConstant.result + "\":\"" + result + "\"}");
        logger.info("save end, result:" + result);
    }

    @Transactional
    @PostMapping("/update")
    public void update(HttpServletResponse response, String entity, @RequestBody String json){
        logger.info("update start, parameter:" + entity + ":" + json);

        String result = CommonConstant.fail;

        User signUser = getSignUser(json);

        try {
            if (entity.equalsIgnoreCase(Customer.class.getSimpleName())) {
                Customer customer = writer.gson.fromJson(json, Customer.class);

                if (customer.getId().compareTo(signUser.getCustomer().getId()) == 0) {
                    result += dao.updateById(customer.getId(), customer);
                }

            } else if (entity.equalsIgnoreCase(User.class.getSimpleName())) {
                User user = writer.gson.fromJson(json, User.class);

                if (user.getId().compareTo(signUser.getId()) == 0) {
                    result += dao.updateById(user.getId(), user);
                }

            } else if (entity.equalsIgnoreCase(Express.class.getSimpleName())) {
                Express express = writer.gson.fromJson(json, Express.class);

                Express dbExpress = (Express) dao.queryById(express.getId(), express.getClass());
                if (dbExpress.getCustomer().getId().compareTo(signUser.getCustomer().getId()) == 0) {
                    result += dao.updateById(express.getId(), express);
                    result += customerService.setExpressDefaultUse(express);
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            result += CommonConstant.fail;
        } finally {
            result = transcation.dealResult(result);
        }

        writer.writeStringToJson(response, "{\"" + CommonConstant.result + "\":\"" + result + "\"}");
        logger.info("update end, result:" + result);
    }

    @Transactional
    @PostMapping("/business")
    public void business(HttpServletResponse response, String name, @RequestBody String json){
        logger.info("business start, parameter:" + name + ":" + json);

        String result = CommonConstant.fail;

        try {
            if (name.equalsIgnoreCase(CustomerConstant.user_action_name_modifyPassword)) {
                Action action = writer.gson.fromJson(json, Action.class);
                User user = (User) dao.queryById(action.getEntityId(), User.class);

                Object sessionUser = getUserBySessionId(action.getSessionId());
                if (sessionUser != null) {
                    /**
                     * 由于前台用户及后台用户（管理员）都可以修改前台用户密码
                     * 如果是前台用户自己修改，则判断修改人和要修改密码的用户是否是同一个人
                     */
                    if (sessionUser instanceof User) {
                        if (((User)sessionUser).getId().compareTo(user.getId()) != 0) {
                            result += CommonConstant.fail + "，非法操作，用户只能修改自己的密码";
                        }
                    }

                    if (!result.substring(CommonConstant.fail.length()).contains(CommonConstant.fail)) {
                        if (user.getPassword().equals(action.getOldPassword())) {
                            user.setPassword(action.getNewPassword());
                            result += dao.updateById(user.getId(), user);

                            action.setEntity(CustomerConstant.user);
                            action.setType(CustomerConstant.user_action_modifyPassword);
                            /**
                             * 前台用户和后台用户类型不一致，这里如果是前台用户，则把前台用户简单转换为后台用户对象里进行保存
                             */
                            action.setInputer(writer.gson.fromJson(writer.gson.toJson(sessionUser), com.hzg.sys.User.class));
                            action.setInputDate(dateUtil.getSecondCurrentTimestamp());
                            result += dao.save(action);

                        } else {
                            result += CommonConstant.fail + ",旧密码不对，不能修改密码";
                        }
                    }
                } else {
                    result += CommonConstant.fail + ",用户没有登录或会话已过期，不能修改密码";
                }

            } else if (name.equalsIgnoreCase(CustomerConstant.user_action_name_resetPassword)) {
                Action action = writer.gson.fromJson(json, Action.class);
                User user = (User) dao.queryById(action.getEntityId(), User.class);

                Object sessionUser = getUserBySessionId(action.getSessionId());
                if (sessionUser != null) {
                    String newPassword = strUtil.generateRandomStr(8);
                    user.setPassword(DigestUtils.md5Hex(newPassword).toUpperCase());
                    result += dao.updateById(user.getId(), user);

                    action.setEntity(CustomerConstant.user);
                    action.setType(CustomerConstant.user_action_resetPassword);
                    /**
                     * 前台用户和后台用户类型不一致，这里如果是前台用户，则把前台用户简单转换为后台用户对象里进行保存
                     */
                    action.setInputer(writer.gson.fromJson(writer.gson.toJson(sessionUser), com.hzg.sys.User.class));
                    action.setInputDate(dateUtil.getSecondCurrentTimestamp());
                    result += dao.save(action);

                    result = transcation.dealResult(result);
                    writer.writeStringToJson(response, "{\"" + CommonConstant.result + "\":\"" + result + "\",\"newPassword\":\"" + newPassword + "\"}");
                    logger.info("business end, result:" + result);
                    return;

                } else {
                    result += CommonConstant.fail + ",用户没有登录或会话已过期，不能重置密码";
                }

            } else if (name.equalsIgnoreCase(CustomerConstant.customer_action_admin_save)) {
                Customer customer = writer.gson.fromJson(json, Customer.class);
                if (customerService.getBackUserBySessionId(customer.getSessionId()) != null) {
                    result += customerService.saveCustomer(customer);
                } else {
                    result += CommonConstant.fail + ",用户没有登录或会话已过期，不能保存客户";
                }

            } else if (name.equalsIgnoreCase(CustomerConstant.customer_action_admin_update)) {
                Customer customer = writer.gson.fromJson(json, Customer.class);
                if (customerService.getBackUserBySessionId(customer.getSessionId()) != null) {
                    result += dao.updateById(customer.getId(), customer);
                } else {
                    result += CommonConstant.fail + ",用户没有登录或会话已过期，不能修改客户";
                }

            } else if (name.equalsIgnoreCase(CustomerConstant.user_action_admin_save)) {
                User user = writer.gson.fromJson(json, User.class);
                if (customerService.getBackUserBySessionId(user.getSessionId()) != null) {
                    result += customerService.saveUserAdmin(user);
                } else {
                    result += CommonConstant.fail + ",用户没有登录或会话已过期，不能保存用户";
                }

            } else if (name.equalsIgnoreCase(CustomerConstant.user_action_admin_update)) {
                User user = writer.gson.fromJson(json, User.class);
                if (customerService.getBackUserBySessionId(user.getSessionId()) != null) {
                    result += dao.updateById(user.getId(), user);
                } else {
                    result += CommonConstant.fail + ",用户没有登录或会话已过期，不能修改用户";
                }

            } else if (name.equalsIgnoreCase(CustomerConstant.express_action_admin_save)) {
                Express express = writer.gson.fromJson(json, Express.class);
                if (customerService.getBackUserBySessionId(express.getSessionId()) != null) {
                    result += customerService.saveExpressAdmin(express);
                } else {
                    result += CommonConstant.fail + ",用户没有登录或会话已过期，不能保存收件信息";
                }

            } else if (name.equalsIgnoreCase(CustomerConstant.express_action_admin_update)) {
                Express express = writer.gson.fromJson(json, Express.class);
                if (customerService.getBackUserBySessionId(express.getSessionId()) != null) {
                    result += dao.updateById(express.getId(), express);
                    result += customerService.setExpressDefaultUse(express);
                } else {
                    result += CommonConstant.fail + ",用户没有登录或会话已过期，不能修改收件信息";
                }
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

    @RequestMapping(value = "/query", method = {RequestMethod.GET, RequestMethod.POST})
    public void query(HttpServletResponse response, String entity, @RequestBody String json){
        logger.info("query start, parameter:" + entity + ":" + json);

        User signUser = getSignUser(json);

        if (entity.equalsIgnoreCase(Customer.class.getSimpleName())) {
            writer.writeObjectToJson(response, writer.gson.toJson(dao.queryById(signUser.getCustomer().getId(), signUser.getCustomer().getClass())));

        } else if (entity.equalsIgnoreCase(User.class.getSimpleName())) {
            writer.writeObjectToJson(response, signUser);

        } else if (entity.equalsIgnoreCase(Express.class.getSimpleName())) {
            Express express = writer.gson.fromJson(json, Express.class);
            express.setCustomer(signUser.getCustomer());
            writer.writeObjectToJson(response, dao.query(express));
        }

        logger.info("query end");
    }

    @RequestMapping(value = "/unlimitedQuery", method = {RequestMethod.GET, RequestMethod.POST})
    public void unlimitedQuery(HttpServletResponse response, String entity, @RequestBody String json){
        logger.info("unlimitedQuery start, parameter:" + entity + ":" + json);

        if (entity.equalsIgnoreCase(Customer.class.getSimpleName())) {
            writer.writeObjectToJson(response, dao.query(writer.gson.fromJson(json, Customer.class)));

        } if (entity.equalsIgnoreCase(User.class.getSimpleName())) {
            writer.writeObjectToJson(response, dao.query(writer.gson.fromJson(json, User.class)));

        } else if (entity.equalsIgnoreCase(Express.class.getSimpleName())) {
            writer.writeObjectToJson(response, dao.query(writer.gson.fromJson(json, Express.class)));
        }

        logger.info("unlimitedQuery end");
    }

    @RequestMapping(value = "/suggest", method = {RequestMethod.GET, RequestMethod.POST})
    public void suggest(HttpServletResponse response, String entity, @RequestBody String json){
        logger.info("suggest start, parameter:" + entity + ":" + json);

        if (entity.equalsIgnoreCase(User.class.getSimpleName())) {
            User user = writer.gson.fromJson(json, User.class);
            /**
             * 用户只能查询自己所属同一个客户下的所有账户
             */
            User sessionUser = (User) getUserBySessionId(user.getSessionId());
            user.setCustomer(sessionUser.getCustomer());

            List<User> users = dao.suggest(user, null);
            for (User ele : users) {
                ele.setCustomer((Customer) dao.queryById(ele.getCustomer().getId(), ele.getCustomer().getClass()));
            }

            writer.writeObjectToJson(response, users);
        }

        logger.info("suggest end");
    }

    @RequestMapping(value = "/unlimitedSuggest", method = {RequestMethod.GET, RequestMethod.POST})
    public void unlimitedSuggest(HttpServletResponse response, String entity, @RequestBody String json){
        logger.info("unlimitedSuggest start, parameter:" + entity + ":" + json);

        if (entity.equalsIgnoreCase(Customer.class.getSimpleName())) {
            writer.writeObjectToJson(response, dao.suggest(writer.gson.fromJson(json, Customer.class), null));

        } else if (entity.equalsIgnoreCase(User.class.getSimpleName())) {
            List<User> users = dao.suggest(writer.gson.fromJson(json, User.class), null);
            for (User ele : users) {
                ele.setCustomer((Customer) dao.queryById(ele.getCustomer().getId(), ele.getCustomer().getClass()));
            }
            writer.writeObjectToJson(response, users);

        } else if (entity.equalsIgnoreCase(Express.class.getSimpleName())) {
            List<Express> expresses = dao.suggest(writer.gson.fromJson(json, Express.class), null);
            for (Express ele : expresses) {
                ele.setCustomer((Customer) dao.queryById(ele.getCustomer().getId(), ele.getCustomer().getClass()));
            }
            writer.writeObjectToJson(response, expresses);
        }

        logger.info("unlimitedSuggest end");
    }

    @RequestMapping(value = "/unlimitedComplexQuery", method = {RequestMethod.GET, RequestMethod.POST})
    public void unlimitedComplexQuery(HttpServletResponse response, String entity, @RequestBody String json, int position, int rowNum){
        logger.info("unlimitedComplexQuery start, parameter:" + entity + ":" + json + "," + position + "," + rowNum);

        if (entity.equalsIgnoreCase(Customer.class.getSimpleName())) {
            writer.writeObjectToJson(response, dao.complexQuery(Customer.class,
                    writer.gson.fromJson(json, new TypeToken<Map<String, String>>(){}.getType()), position, rowNum));

        } else if (entity.equalsIgnoreCase(User.class.getSimpleName())) {
            writer.writeObjectToJson(response, dao.complexQuery(User.class,
                    writer.gson.fromJson(json, new TypeToken<Map<String, String>>(){}.getType()), position, rowNum));

        } else if (entity.equalsIgnoreCase(Express.class.getSimpleName())) {
            writer.writeObjectToJson(response, dao.complexQuery(Express.class,
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

        if (entity.equalsIgnoreCase(Customer.class.getSimpleName())) {
            recordsSum = dao.recordsSum(Customer.class, writer.gson.fromJson(json, new TypeToken<Map<String, String>>(){}.getType()));

        } else if (entity.equalsIgnoreCase(User.class.getSimpleName())) {
            recordsSum = dao.recordsSum(User.class, writer.gson.fromJson(json, new TypeToken<Map<String, String>>(){}.getType()));

        } else if (entity.equalsIgnoreCase(Express.class.getSimpleName())) {
            recordsSum = dao.recordsSum(Express.class, writer.gson.fromJson(json, new TypeToken<Map<String, String>>(){}.getType()));
        }

        writer.writeStringToJson(response, "{\"" + CommonConstant.recordsSum + "\":" + recordsSum + "}");
        logger.info("unlimitedRecordsSum end");
    }

    public User getSignUser(String json) {
        Map<String, Object> jsonData = writer.gson.fromJson(json, new TypeToken<Map<String, Object>>(){}.getType());
        User user = (User) dao.getFromRedis((String) dao.getFromRedis(CommonConstant.sessionId +
                CommonConstant.underline + (String) jsonData.get(CommonConstant.sessionId)));

        User signUser = new User();
        signUser.setId(user.getId());
        signUser.setCustomer(user.getCustomer());

        return signUser;
    }

    /**
     * 用户登录
     * @param response
     * @param json
     */
    @RequestMapping(value = "/user/signIn", method = {RequestMethod.GET, RequestMethod.POST})
    public void signIn(HttpServletResponse response, @RequestBody String json) {
        logger.info("signIn start, parameter:" + json);

        String result = CommonConstant.fail;

        Map<String, String> signInInfo = writer.gson.fromJson(json, new TypeToken<Map<String, String>>(){}.getType());
        String username = signInInfo.get(CommonConstant.username);

        long waitTime = signInUtil.userWait(username);
        if (waitTime > 0) {
            result = "请等待" + (waitTime/1000) + "秒后再次登录";
            writer.writeStringToJson(response, "{\"" + CommonConstant.result + "\":\"" + result + "\"}");
            return ;
        }

        String salt = (String)dao.getFromRedis(CommonConstant.salt + CommonConstant.underline + signInInfo.get(CommonConstant.sessionId));
        if (salt == null) {
            result = "加密信息丢失，请刷新后再次登录";
            writer.writeStringToJson(response, "{\"" + CommonConstant.result + "\":\"" + result + "\"}");
            return ;
        }

        User user = new User(username);
        user.setState(0); //有效用户

        List<User> dbUsers = dao.query(user);
        if (dbUsers.size() == 1) {
            String encryptDbPassword = DigestUtils.md5Hex(dbUsers.get(0).getPassword().toUpperCase() + salt).toUpperCase();

            /**
             * 账号密码正确
             */
            if (encryptDbPassword.equals(signInInfo.get("encryptPassword"))) {
                result = CommonConstant.success;
                signInUtil.removeSignInFailInfo(username);

            } else {
                result = "用户名或密码错误";

                signInUtil.setSignInFailInfo(username);
                long waitSeconds = signInUtil.getWaitSeconds(username);
                if (waitSeconds != 0) {
                    result += "<br/>已<span style='color:#db6a41;padding-left:2px;padding-right:2px'>" +
                             signInUtil.getSignInFailCount(username) +
                             "</span>次登录错误，请等待" + waitSeconds + "秒后再次登录";

                }
            }

        } else if (dbUsers.size() < 1){
           result = "查询不到 " + user.getUsername() + "，或者该用户已注销";

        } else if (dbUsers.size() > 1){
           result = dbUsers.get(0).getUsername() + " 是重名用户，请联系管理员处理";
        }

        /**
         * 用户已经登录
         */
        if (signInUtil.isUserExist(username) && result.equals(CommonConstant.success)) {
            if (signInUtil.getSessionIdByUser(username) != null) {
                if (!signInUtil.getSessionIdByUser(username).equals(signInInfo.get(CommonConstant.sessionId))) {
                    dao.storeToRedis(username + CommonConstant.underline + signInInfo.get(CommonConstant.sessionId), dbUsers.get(0), signInUtil.sessionTime);
                    result = username + "已经登录";
                }
            }
        }

        /**
         * 登录成功,设置用户,该用户权限资源到 redis
         */
        if (result.equals(CommonConstant.success)) {
            dao.storeToRedis(username, dbUsers.get(0), signInUtil.sessionTime);
            signInUtil.setUser(signInInfo.get(CommonConstant.sessionId), username);
        }

        writer.writeStringToJson(response, "{\"" + CommonConstant.result + "\":\"" + result + "\"}");
        logger.info("signIn end");
    }


    /**
     * 用户注销
     */
    @RequestMapping(value="/user/signOut")
    public void signOut(HttpServletResponse response,  @RequestBody String json) {
        logger.info("signOut start, parameter:" + json);

        String result = CommonConstant.fail;

        Map<String, String> signOutInfo = writer.gson.fromJson(json, new TypeToken<Map<String, String>>(){}.getType());
        String sessionId =  signOutInfo.get(CommonConstant.sessionId);

        String username = (String)dao.getFromRedis(CommonConstant.sessionId + CommonConstant.underline + sessionId);
        if (username != null) {
            dao.deleteFromRedis(username);
            dao.deleteFromRedis(username + CommonConstant.underline + CommonConstant.resources);
            dao.deleteFromRedis(CommonConstant.salt + CommonConstant.underline + sessionId);
            signInUtil.removeUser(username);

            logger.info(username + "注销");

            result = CommonConstant.success;
        }

        writer.writeStringToJson(response, "{\"" + CommonConstant.result + "\":\"" + result + "\"}");
        logger.info("signOut end");
    }

    /**
     * 处理重复登录
     */
    @RequestMapping(value="/user/hasLoginDeal")
    public void hasLoginDeal(HttpServletResponse response,  @RequestBody String json) {
        logger.info("hasLoginDeal start, parameter:" + json);

        String result = CommonConstant.fail;

        Map<String, String> dealInfo = writer.gson.fromJson(json, new TypeToken<Map<String, String>>(){}.getType());
        String username = dealInfo.get(CommonConstant.username);
        String sessionId = dealInfo.get(CommonConstant.sessionId);

        String tempUserKey = username + CommonConstant.underline +  sessionId;

        if (dealInfo.get("dealType").equals("againSignIn")) {
            User user = (User) dao.getFromRedis(tempUserKey);

            if (user != null) {
                //移除之前登录的用户
                signInUtil.removeUser(username);

                dao.storeToRedis(username, user, signInUtil.sessionTime);
                signInUtil.setUser(sessionId, username);

                //移除临时登录用户
                dao.deleteFromRedis(tempUserKey);

                result = CommonConstant.success;
            }

        } else {
            result = "no operation";
        }

        writer.writeStringToJson(response, "{\"" + CommonConstant.result + "\":\"" + result + "\"}");
        logger.info("hasLoginDeal end");
    }

    public Object getUserBySessionId(String sessionId){
        return dao.getFromRedis((String)dao.getFromRedis(CommonConstant.sessionId + CommonConstant.underline + sessionId));
    }
}
