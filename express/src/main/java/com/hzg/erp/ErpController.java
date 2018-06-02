package com.hzg.erp;

import com.google.gson.reflect.TypeToken;
import com.hzg.tools.*;
import com.sf.openapi.common.entity.MessageResp;
import com.sf.openapi.express.sample.order.dto.*;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: SysController.java
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/5/25
 */
@Controller
@RequestMapping("/erp")
public class ErpController {

    Logger logger = Logger.getLogger(ErpController.class);

    @Autowired
    private ErpDao erpDao;

    @Autowired
    private Writer writer;

    @Autowired
    private ErpService erpService;

    @Autowired
    private Transcation transcation;

    @RequestMapping(value = "/complexQuery", method = {RequestMethod.GET, RequestMethod.POST})
    public void complexQuery(HttpServletResponse response, String entity, @RequestBody String json){
        logger.info("complexQuery start, parameter:" + entity + ":" + json);
        writer.writeObjectToJson(response, erpDao.complexQuery(ExpressDeliver.class,
                writer.gson.fromJson(json, new TypeToken<Map<String, String>>(){}.getType()), 0, 500));
        logger.info("complexQuery end");
    }

    /**
     *
     *  ========================= 顺丰接口 =======================
     *  https://open.sf-express.com/apitools/sdk.html
     */

    /**
     * sf快递单下单接口
     * @param json
     * @param response
     */
    @Transactional
    @PostMapping(value = "/sfExpress/order")
    public void sfExpressOrder( HttpServletResponse response, @RequestBody String json) {
        logger.info("sfExpressOrder start, json:" + json);

        List<String> expressNos = new ArrayList<>();
        String result = CommonConstant.fail;

        try {
            List<ExpressDeliver> expressDelivers = writer.gson.fromJson(json, new TypeToken<List<ExpressDeliver>>(){}.getType());
            for (ExpressDeliver expressDeliver : expressDelivers) {
                List<String> expressNosPart = erpService.expressDeliverOrder(expressDeliver);

                if (!expressNosPart.isEmpty()) {
                    expressNos.addAll(expressNosPart);
                    result += CommonConstant.success;
                } else {
                    result += CommonConstant.fail;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            result += CommonConstant.fail;
        } finally {
            transcation.dealResult(result);
        }

        writer.writeObjectToJson(response, expressNos);
        logger.info("sfExpressOrder end");
    }

    /**
     * 查询快递单情况
     * @param expressNos
     * @param response
     */
    @Transactional
    @GetMapping(value = "/sfExpress/order/query/{expressNos}")
    public void sfExpressOrderQuery(HttpServletResponse response, @PathVariable("expressNos") String expressNos) {
        logger.info("sfExpressOrderQuery start, expressNos:" + expressNos);
        String[] expressNosArr = expressNos.split(",");
        List<OrderQueryRespDto> orderQueryRespDtos = new ArrayList<>();

        for (String expressNo : expressNosArr) {
            orderQueryRespDtos.add(erpService.sfExpressOrderQuery(expressNo));
        }

        writer.writeObjectToJson(response, orderQueryRespDtos);
        logger.info("sfExpressOrderQuery end");
    }

    /**
     * 下载顺丰快递单图片
     * @param expressNo
     * @param response
     */
    @Transactional
    @GetMapping(value = "/sfExpress/waybill/download/{expressNo}")
    public void sfExpressWaybillDownload(HttpServletResponse response, @PathVariable("expressNo") String expressNo) {
        logger.info("sfExpressWaybillDownload start, expressNo:" + expressNo);
        writer.write(response, erpService.downloadSfWaybill(expressNo));
        logger.info("sfExpressWaybillDownload end");
    }

    /**
     * sf快递单订单结果通知
     * @param json
     * @param response
     */
    @Transactional
    @PostMapping(value = "/sfExpress/order/notify")
    public void sfExpressOrderNotify(HttpServletResponse response, String json) {
        logger.info("sfExpressOrderNotify start, json:" + json);

        String result = CommonConstant.fail;

        MessageResp<OrderNotifyReqDto> messageResp = writer.gson.fromJson(json, new TypeToken<MessageResp<OrderNotifyReqDto>>(){}.getType());
        if (messageResp.getHead().getCode().equals(ErpConstant.sf_response_code_success) && messageResp.getBody().getMailNo() != null) {
            ExpressDeliverDetail expressDeliverDetail = new ExpressDeliverDetail();
            expressDeliverDetail.setExpressNo(messageResp.getBody().getOrderId());

            ExpressDeliverDetail dbExpressDeliverDetail = (ExpressDeliverDetail) erpDao.query(expressDeliverDetail).get(0);
            dbExpressDeliverDetail.setMailNo(messageResp.getBody().getMailNo());
            result = erpDao.updateById(expressDeliverDetail.getId(), dbExpressDeliverDetail);
        }

        if (!result.contains(CommonConstant.fail)) {
            MessageResp<OrderNotifyRespDto> resp = new MessageResp<>();
            resp.getHead().setTransType(4201);
            resp.getHead().setTransMessageId(erpDao.getSfTransMessageId());
            resp.getBody().setOrderId(messageResp.getBody().getOrderId());

            writer.writeStringToJson(response, writer.gson.toJson(resp));
        } else {
            writer.writeStringToJson(response, result);
        }

        logger.info("sfExpressOrderNotify end");
    }
}
