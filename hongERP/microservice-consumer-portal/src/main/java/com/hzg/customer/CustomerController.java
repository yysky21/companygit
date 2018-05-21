package com.hzg.customer;

import com.google.gson.reflect.TypeToken;
import com.hzg.tools.*;
import org.apache.commons.collections.map.HashedMap;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

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
public class CustomerController extends com.hzg.base.SessionController {

    Logger logger = Logger.getLogger(CustomerController.class);

    @Autowired
    private Writer writer;

    @Autowired
    private CustomerClient customerClient;

    @Autowired
    private SmsClient smsClient;

    @Autowired
    private StrUtil strUtil;

    @Autowired
    private CookieUtils cookieUtils;

    @Autowired
    public Integer sessionTime;

    public CustomerController(CustomerClient customerClient) {
        super(customerClient);
    }

    @CrossOrigin
    @RequestMapping(value = "/user/modifyPassword", method = {RequestMethod.GET, RequestMethod.POST})
    public void modifyPassword(HttpServletResponse response, String json) {
        logger.info("modifyPassword start, json:" + json);
        writer.writeStringToJson(response, customerClient.business(CustomerConstant.user_action_name_modifyPassword, json));
        logger.info("modifyPassword end");
    }

    /**
     * 获取 sessionId
     * @param response
     * @return
     */
    @CrossOrigin
    @GetMapping("/user/getSessionId")
    public void getSessionId(HttpServletResponse response) {
        String sessionId = strUtil.generateDateRandomStr(32);
        cookieUtils.addCookie(response, CommonConstant.sessionId, sessionId);
        writer.writeStringToJson(response, "{\"" + CommonConstant.sessionId + "\":\"" + sessionId + "\"}");
    }

    /**
     * 获取 salt
     * @param response
     * @return
     */
    @CrossOrigin
    @GetMapping("/user/getSalt/{sessionId}")
    public void getSalt(HttpServletResponse response, @PathVariable("sessionId") String sessionId) {
        String salt = strUtil.generateRandomStr(256);
        dao.storeToRedis(CommonConstant.salt + CommonConstant.underline + sessionId, salt, sessionTime);
        writer.writeStringToJson(response, "{\"" + CommonConstant.salt + "\":\"" + salt + "\"}");
    }

    /**
     * 用户登录，注销，重复登录
     * @param name
     * @param json
     * @return
     */
    @CrossOrigin
    @PostMapping("/user/{name}")
    public void user(HttpServletRequest request, HttpServletResponse response, @PathVariable("name") String name, String json) {
        logger.info("user start, name:" + name + ", json:" + json);

        String result = null;
        if (name.equals("signIn")) {
            result = customerClient.signIn(json);

        } else if (name.equals("signOut")) {
            cookieUtils.delCookie(request, response, CommonConstant.sessionId);
            result = customerClient.signOut(json);

        } else if (name.equals("hasLoginDeal")) {
            result = customerClient.hasLoginDeal(json);
        }

        writer.writeStringToJson(response, result);


        logger.info("user " + name + " end");
    }

    @CrossOrigin
    @GetMapping("/user/sendValidateCode/{mobileNumber}")
    public void sendValidateCode(HttpServletResponse response, @PathVariable("mobileNumber") String mobileNumber) {
        String validateCodeInfoStr = smsClient.generateValidateCode(SmsConstant.validateCodeLength, mobileNumber);
        Map<String, Object> validateCodeInfo = writer.gson.fromJson(validateCodeInfoStr, new TypeToken<Map<String, Object>>(){}.getType());

        if (!validateCodeInfoStr.contains(CommonConstant.fail)) {
            /**
             * gson 会把数字转换为 double 类型，toString后会形成如：23.0，这样带 .0 的字符串，需要去除.0
             */
            String codeStr = validateCodeInfo.get(SmsConstant.validateCode).toString();
            int index = codeStr.indexOf(".");
            if (index != -1) {
                codeStr = codeStr.substring(0, index);
            }

            Map<String, String> sendResult = writer.gson.fromJson(
                    smsClient.send("{\"" + SmsConstant.mobileNumber + "\":\"" + mobileNumber + "\",\"" + SmsConstant.content + "\":\"用户注册验证码是：" + codeStr + ",请查收\"}"),
                    new TypeToken<Map<String, String>>(){}.getType());
            writer.writeStringToJson(response, "{\"" + CommonConstant.result + "\":\"" + sendResult.get(CommonConstant.result) + "\"," +
                    "\"" + SmsConstant.validateCodeKey + "\":\"" + validateCodeInfo.get(SmsConstant.validateCodeKey).toString() + "\"}");
        } else {
            writer.writeStringToJson(response, validateCodeInfoStr);
        }
    }
}
