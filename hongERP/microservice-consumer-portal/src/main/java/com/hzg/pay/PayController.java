package com.hzg.pay;

import com.boyuanitsm.pay.alipay.bean.AyncNotify;
import com.boyuanitsm.pay.alipay.bean.SyncReturn;
import com.google.gson.reflect.TypeToken;
import com.hzg.erp.*;
import com.hzg.order.Order;
import com.hzg.order.OrderClient;
import com.hzg.sys.User;
import com.hzg.tools.CommonConstant;
import com.hzg.tools.DateUtil;
import com.hzg.tools.ErpConstant;
import com.hzg.tools.Writer;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: SysController.java
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/3/16
 */
@Controller
@RequestMapping("/pay")
public class PayController extends com.hzg.base.Controller {

    Logger logger = Logger.getLogger(PayController.class);

    @Autowired
    private Writer writer;

    @Autowired
    private PayClient payClient;

    public PayController(PayClient payClient) {
        super(payClient);
    }

    @GetMapping("/view/{entity}/{id}")
    public String viewById(Map<String, Object> model, @PathVariable("entity") String entity, @PathVariable("id") Integer id,
                           @CookieValue(name=CommonConstant.sessionId, defaultValue = "")String sessionId) {
        logger.info("viewById start, entity:" + entity + ", id:" + id);

        List<Object> entities = null;

        String json = "{\"id\":" + id + "}";

        if (entity.equalsIgnoreCase(Pay.class.getSimpleName())) {
            entities = writer.gson.fromJson(client.query(entity, json), new TypeToken<List<Pay>>() {}.getType());

        } else if (entity.equalsIgnoreCase(Account.class.getSimpleName())) {
            entities = writer.gson.fromJson(client.query(entity, json), new TypeToken<List<Account>>() {}.getType());

        } else if (entity.equalsIgnoreCase(Refund.class.getSimpleName())) {
            entities = writer.gson.fromJson(client.query(entity, json), new TypeToken<List<Refund>>() {}.getType());
        }

        User user = (User)dao.getFromRedis((String)dao.getFromRedis(CommonConstant.sessionId + CommonConstant.underline + sessionId));

        model.put("entity", entities.isEmpty() ? null : entities.get(0));
        model.put("userId", user.getId());
        logger.info("viewById end");

        return "/pay/" + entity;
    }



    /**
     *
     *  ========================= alipay 支付接口 =======================
     *
     */

    /**
     * 根据支付号 no 查询支付记录，调用 alipay 网页支付
     * @param no 支付号
     * @param payType 支付方式
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/alipay/pay", produces = "text/html;charset=UTF-8", method = RequestMethod.GET)
    public void alipay(String no, String payType, HttpServletResponse response) {
        logger.info("alipay, no:" + no + ",toAlipay:" + payType);
        writer.write(response, payClient.alipay(no, payType));
    }

    /**
     * 获取 alipay 二维码支付 url 对应的图片
     * @param no 支付号
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/alipay/payQrcode.jpg", produces = "image/jpeg;charset=UTF-8", method = RequestMethod.GET)
    public void alipayPayQrcode(String no, HttpServletResponse response) {
        logger.info("alipayPayQrcode, no:" + no);
        writer.writeBytes(response, payClient.alipayPayQrcode(no));
    }

    /**
     * /alipay/toAlipay?no=xxx&payType=xxx 为：alipay 二维码支付图片对应的 url，支付宝 app 扫描支付图片后，就会自动访问该 url，
     * 然后跳转到支付页面
     * @param no 支付号
     * @param payType 支付方式
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/alipay/toAlipay", produces = "text/html;charset=UTF-8", method = RequestMethod.GET)
    public void toAlipay(String no, String payType, HttpServletResponse response) {
        logger.info("toAlipay, no:" + no + ",toAlipay:" + payType);
        writer.write(response, payClient.toAlipay(no, payType));
    }

    /**
     * 根据 no 查询退款记录，调用支付宝退款
     * @param no 退款编号
     */
    @RequestMapping(value = "/alipay/refund", produces = "text/html;charset=UTF-8", method = RequestMethod.GET)
    public void alipayRefund(String no, HttpServletResponse response) {
        logger.info("alipayRefund, refundNo:" + no);
        writer.write(response, payClient.alipayRefund(no));
    }

    /**
     * 支付宝页面跳转同步通知，跳转到支付结果页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/alipay/syncReturn", method = RequestMethod.GET)
    public String alipaySyncReturn(HttpServletRequest request, Map<String, Object> model) {
        String json = writer.gson.toJson(request.getParameterMap());
        logger.info("alipaySyncReturn, json:" + json);
        model.put(CommonConstant.result, writer.gson.fromJson(payClient.alipaySyncReturn(json), new TypeToken<Map<String, String>>(){}.getType()));
        return CommonConstant.result;
    }

    /**
     * 支付宝服务器异步通知页面
     * @param request
     */
    @RequestMapping(value = "/alipay/ayncNotify", method = RequestMethod.POST)
    public void alipayAyncNotify(HttpServletRequest request, HttpServletResponse response) {
        String json = writer.gson.toJson(request.getParameterMap());
        logger.info("alipayAyncNotify, json:" + json);
        writer.write(response, payClient.alipayAyncNotify(json));
    }

    /**
     * 支付宝服务器退款异步通知页面
     * @param request
     */
    @RequestMapping(value = "/alipay/refundAyncNotify", method = RequestMethod.POST)
    @ResponseBody
    public void alipayRefundAyncNotify(HttpServletRequest request, HttpServletResponse response) {
        String json = writer.gson.toJson(request.getParameterMap());
        logger.info("alipayRefundAyncNotify, json:" + json);
        writer.write(response, payClient.alipayRefundAyncNotify(json));
    }



    /**
     *
     *  ========================= 微信支付接口 =======================
     *
     */

    /**
     * 微信二维码支付
     * @param no 支付号
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/wechat/payQrcode.jpg", produces = "image/jpeg;charset=UTF-8", method = RequestMethod.GET)
    public void wechatPayQrcode(String no, HttpServletResponse response) {
        logger.info("wechatPayQrcode, no:" + no);
        writer.writeBytes(response, payClient.wechatUnifiedOrder(no));
    }

    /**
     * 微信退款
     * @param no 退款编号
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/wechat/refund", method = RequestMethod.GET)
    public void wechatRefund(String no, HttpServletResponse response) {
        logger.info("wechatRefund, no:" + no);
        writer.writeStringToJson(response, payClient.wechatRefund(no));
    }

    /**
     * 微信支付结果通知
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/wechat/payResultCallback", method = RequestMethod.POST)
    public void payResultCallback(HttpServletRequest request, HttpServletResponse response) throws IOException {
        writer.write(response, payClient.wechatPayResultCallback(IOUtils.toString(request.getInputStream())));
    }

    /**
     * 微信退款结果通知
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/wechat/refundResultCallback", method = RequestMethod.POST)
    public void refundResultCallback(HttpServletRequest request, HttpServletResponse response) throws IOException {
        writer.write(response, payClient.wechatRefundResultCallback(IOUtils.toString(request.getInputStream())));
    }




    /**
     *
     *  ========================= 银联支付接口 =======================
     *
     */


    /**
     * 根据支付号 no 查询支付记录，调用 unionpay 网页支付
     * @param no 支付号
     */
    @RequestMapping(value = "/unionpay/acp/frontConsume", produces = "text/html;charset=UTF-8", method = RequestMethod.GET)
    public void frontConsume(String no, HttpServletResponse response) {
        logger.info("alipay, no:" + no);
        writer.write(response, payClient.unionpayFrontConsume(no));
    }

    /**
     * unionpay 页面跳转同步通知，跳转到支付结果页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/unionpay/acp/frontNotify", method = RequestMethod.GET)
    public String unionpayFrontNotify(HttpServletRequest request, Map<String, Object> model) {
        String json = writer.gson.toJson(request.getParameterMap());
        logger.info("unionpayFrontNotify, json:" + json);
        model.put(CommonConstant.result, writer.gson.fromJson(payClient.unionpayFrontNotify(json), new TypeToken<Map<String, String>>(){}.getType()));
        return CommonConstant.result;
    }

    /**
     * unionpay 服务器异步通知
     * @param request
     */
    @RequestMapping(value = "/unionpay/acp/backNotify", method = RequestMethod.POST)
    public void unionpayBackNotify(HttpServletRequest request, HttpServletResponse response) {
        String json = writer.gson.toJson(request.getParameterMap());
        logger.info("unionpayBackNotify, json:" + json);
        writer.write(response, payClient.unionpayBackNotify(json));
    }
}
