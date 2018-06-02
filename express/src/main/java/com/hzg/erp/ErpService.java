package com.hzg.erp;

import com.hzg.tools.*;
import com.sf.openapi.common.entity.AppInfo;
import com.sf.openapi.common.entity.HeadMessageReq;
import com.sf.openapi.common.entity.MessageReq;
import com.sf.openapi.common.entity.MessageResp;
import com.sf.openapi.express.sample.order.dto.*;
import com.sf.openapi.express.sample.order.tools.OrderTools;
import com.sf.openapi.express.sample.security.dto.TokenReqDto;
import com.sf.openapi.express.sample.security.dto.TokenRespDto;
import com.sf.openapi.express.sample.security.tools.SecurityTools;
import com.sf.openapi.express.sample.waybill.dto.WaybillReqDto;
import com.sf.openapi.express.sample.waybill.dto.WaybillRespDto;
import com.sf.openapi.express.sample.waybill.tools.WaybillDownloadTools;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.log4j.Logger;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
public class ErpService {

    Logger logger = Logger.getLogger(ErpService.class);

    @Autowired
    private ErpDao erpDao;

    @Autowired
    public ObjectToSql objectToSql;

    @Autowired
    public SessionFactory sessionFactory;

    @Autowired
    private DateUtil dateUtil;

    @Autowired
    BarcodeUtil barcodeUtil;

    @Autowired
    ImageBase64 imageBase64;

    @Autowired
    private SfExpress sfExpress;

    public List<String> expressDeliverOrder(ExpressDeliver expressDeliver) {
        List<String> expressNos = new ArrayList<>();

        expressDeliver.setState(ErpConstant.express_state_sending);
        expressDeliver.setInputDate(dateUtil.getSecondCurrentTimestamp());
        String result = erpDao.save(expressDeliver);

        for (ExpressDeliverDetail expressDeliverDetail : expressDeliver.getDetails()) {
            expressDeliverDetail.setExpressNo(ErpConstant.no_expressDelivery_perfix + erpDao.getSfTransMessageId());
            expressDeliverDetail.setState(ErpConstant.express_detail_state_unSend);
            expressDeliverDetail.setExpressDeliver(expressDeliver);
            result += erpDao.save(expressDeliverDetail);

            expressNos.add(expressDeliverDetail.getExpressNo());
        }

        result += sfExpressOrder(expressDeliver);

        if (result.contains(CommonConstant.fail)) {
           expressNos.clear();
        }
        return  expressNos;
    }


    /**
     * 调用顺丰快递单接口，在顺丰系统生成快递单
     * @param expressDeliver
     *
     *  快递单内容
     *
     *  请求报文内容
    字段名称 类型 是否
    必须
    描述
    orderId  String(56)  是  客户订单号，最大长度限于 56 位，该字段客户
    可自行定义，请尽量命名的规范有意义，如
    SFAPI20160830001，订单号作为客户下单的凭
    证， 不允许重复提交 订单号。
    expressType  String(5)  是  常用快件产品类别：
    类别 描述
    1  顺丰标快
    2  顺丰特惠
    3  电商特惠
    5  顺丰次晨
    6  顺丰即日
    7  电商速配
    15  生鲜速配
    payMethod  Number(1)  是  付款方式：
    类别 描述
    1  寄付现结（可不传 custId）
    /寄付月结 【默认值】 (必传
    custId)
    2  收方付
    3  第三方月结卡号支付
    isDoCall  Number(1)  否  是否下 call（通知收派员上门取件）
    类别 描述
    1  下 call
    0  不下 call【默认值】
    isGenBillno  Number(1)  否  是否申请运单号
    类别 描述
    1  申请【默认值】
    0  不申请
    isGenEletricPic  Number(1)  否  是否生成电子运单图片
    类别 描述
    1  生成【默认值】
    0  不生成
    custId  String(20)  是  顺丰月结卡号
    顺丰开放平台接口接入规范 V1.0
    12  顺丰科技
    2016 年 08 月 30 日
    payArea  String(20)  否  月结卡号对应的网点，如果付款方式为第三方月
    结卡号支付，则必填
    sendStartTime  String(18)
    否  要求上门取件开始时间，格式：YYYY-MM-DD
    HH24:MM:SS，示例：2016-8-30 09:30:00，
    默认值为系统收到订单的系统时间
    needReturnTrackingNo String(2)  否  是否需要签回单号
    类别 描述
    1  需要
    0  不需要【默认值】
    remark String(100) 否 备注，最大长度 30 个汉字
    deliverInfo  否  寄件方信息
    company  String(100)  否  寄件方公司名称
    如果不提供，将从系统默认配置获取
    contact  String(100)  否  寄件方联系人
    如果不提供，将从系统默认配置获取
    tel  String(20)  否  寄件方联系电话
    如果不提供，将从系统默认配置获取
    province  String(30)  否  寄件方所在省份，必须是标准的省名称称谓
    如： 广东省（省字不要省略）
    如果是直辖市，请直接传北京市、上海市等
    如果不提供，将从系统默认配置获取
    city  String(100)  否  寄件方所属城市名称，必须是标准的城市称谓
    如： 深圳市（市字不要省略）
    如果是直辖市，请直接传北京市、上海市等
    如果不提供，将从系统默认配置获取
    county  String(30)  否
    寄件人所在县/区，必须是标准的县/区称谓
    示例： 福田区（区字不要省略）
    如果不提供，将从系统默认配置获取
    address  String(200)  否  寄件方详细地址
    如：“福田区新洲十一街万基商务大厦 10 楼”
    如果不提供，将从系统默认配置获取
    shipperCode  String(30)  否  寄件方邮编代码
    mobile String(20) 否 寄件方手机
    consignee Info  收件方信息
    company  String(100)  是  到件方公司名称
    contact  String(100)  是  到件方联系人
    tel  String(20)  是  到件方联系电话
    province  String(30)  是  到件方所在省份，必须是标准的省名称称谓
    如：广东省（省字不要省略）
    如果是直辖市，请直接传北京市、上海市等
    city  String(100)  是  到件方所属城市名称，必须是标准的城市称谓
    如：深圳市（市字不要省略）
    如果是直辖市，请直接传北京市、上海市等
    county  String(30)  是
    到件人所在县/区，必须是标准的县/区称谓
    如：福田区（区字不要省略）
    address  String(200)  是  到件方详细地址
    如：“新洲十一街万基商务大厦 10 楼”
    shipperCode  String(30)  否  到件方邮编代码
    mobile String(20) 否 到件方手机
    顺丰开放平台接口接入规范 V1.0
    13  顺丰科技
    2016 年 08 月 30 日
    cargoInfo  货物信息
    parcelQuantity  Number(5)  否  包裹数，一个包裹对应一个运单号，如果是大于
    1 个包裹，则返回按照子母件的方式返回母运单
    号和子运单号。默认为 1
    cargo  String(4000)  是  货物名称，如果有多个货物，以英文逗号分隔，
    如：“手机,IPAD,充电器”
    cargoCount  String(4000)  否  货物数量，多个货物时以英文逗号分隔，且与货
    物名称一一对应
    如：2,1,3
    cargoUnit  String(4000)  否  货物单位，多个货物时以英文逗号分隔，且与货
    物名称一一对应
    如：个,台,本
    cargoWeight  String(4000)  否  货物重量，多个货物时以英文逗号分隔，且与货
    物名称一一对应
    如：1.0035,1.0,3.0
    cargoAmount  String(4000)  否  货物单价，多个货物时以英文逗号分隔，且与货
    物名称一一对应
    如：1000,2000,1500
    cargoTotalWeight Number(10,2) 否 订单货物总重量， 单位 KG， 如果提供此值， 必须>0
    addedServices  增值服务 （注意字段名称必须为英文字母大写 ）
    CUSTID  String(30)  否  代收货款月结卡号，如果选择 COD 增值服务-代
    收货款， 必填， 该项为代送货款使用的月结卡号，
    该项值必须在，COD 前设置（即先传 CUSTID 值再
    传 COD 值） 否则无效
    COD  String(20)  否  代收货款，value代收货款值，上限为20000，以
    原寄地所在区域币种为准，如中国大陆为人民
    币，香港为港币，保留1位小数，如 99.9 。
    value1为代收货款协议卡号（可能与月结卡号相
    同），
    如选择此服务，须增加CUSTID字段
    INSURE  String(30)  否  保价，value为声明价值(即该包裹的价值)
    MSG  String(30)  否  签收短信通知，value 为手机号码
    PKFREE  String(30)  否  包装费，value 为包装费费用.
    SINSURE String(30)  否  特殊保价，value 为服务费.
    SDELIVERY  String(30)  否  特殊配送，value为服务特殊配送服务费.
    SADDSERVICE  String(30)  否  特殊增值服务，value 特殊增值服务费
    5.1.1.2.1.2  响应 报文内容
    字段名称  类型  是否
    必须
    描述
    orderId  String  是  客户订单号
    filterLevel  String  否  筛单级别 0：不筛单 4：四级筛单
    orderTriggerCondi
    tion
    String  否  订单触发条件 1：上门收件 2 电子称 3：
    收件入仓 4：大客户装包 5：大客户装车
    remarkCode  String  否  01 ：下单操作成功 02：下单操作失败 03：
    订单号重复
     *
     */
    public String sfExpressOrder(ExpressDeliver expressDeliver) {
        logger.info("sfExpressOrder start, details:" + expressDeliver.toString());

        String result = CommonConstant.fail;

        //设置 uri
        String url = sfExpress.getOrderUri();
        AppInfo appInfo = new AppInfo();
        appInfo.setAppId(sfExpress.getAppId());
        appInfo.setAppKey(sfExpress.getAppKey());
        appInfo.setAccessToken(getSfToken());

        for (ExpressDeliverDetail expressDeliverDetail : expressDeliver.getDetails()) {
            //设置请求头
            MessageReq req = new MessageReq();
            HeadMessageReq head = new HeadMessageReq();
            head.setTransType(ErpConstant.sf_action_code_order);
            head.setTransMessageId(expressDeliverDetail.getExpressNo().replace(ErpConstant.no_expressDelivery_perfix, ""));
            req.setHead(head);

            OrderReqDto orderReqDto = new OrderReqDto();
            orderReqDto.setOrderId(expressDeliverDetail.getExpressNo());
            orderReqDto.setExpressType((short) 1);
            orderReqDto.setPayMethod((short) 1);
            orderReqDto.setNeedReturnTrackingNo((short) 0);
            orderReqDto.setIsDoCall((short) 1);
            orderReqDto.setIsGenBillNo((short) 1);
            orderReqDto.setCustId(sfExpress.getCustId());
            /**
             * 月结卡号对应的网点，如果付款方式为第三方月结卡号支付(即payMethod=3)，则必填
             */
//            orderReqDto.setPayArea(sfExpress.getPayArea());
            orderReqDto.setSendStartTime(dateUtil.getSimpleDateFormat().format(expressDeliver.getDate()));
            orderReqDto.setRemark("易碎物品，小心轻放");

            //收件人信息
            DeliverConsigneeInfoDto consigneeInfoDto = new DeliverConsigneeInfoDto();
            consigneeInfoDto.setCompany(expressDeliver.getReceiverCompany());
            consigneeInfoDto.setAddress(expressDeliver.getReceiverAddress());
            consigneeInfoDto.setCity(expressDeliver.getReceiverCity());
            consigneeInfoDto.setProvince(expressDeliver.getReceiverProvince());
            consigneeInfoDto.setCountry(expressDeliver.getReceiverCountry());
            consigneeInfoDto.setShipperCode(expressDeliver.getReceiverPostCode());
            consigneeInfoDto.setMobile(expressDeliver.getReceiverMobile());
            consigneeInfoDto.setTel(expressDeliver.getReceiverTel());
            consigneeInfoDto.setContact(expressDeliver.getReceiver());

            //寄件人信息
            DeliverConsigneeInfoDto deliverInfoDto = new DeliverConsigneeInfoDto();
            deliverInfoDto.setCompany(expressDeliver.getSenderCompany());
            deliverInfoDto.setAddress(expressDeliver.getSenderAddress());
            deliverInfoDto.setCity(expressDeliver.getSenderCity());
            deliverInfoDto.setProvince(expressDeliver.getSenderProvince());
            deliverInfoDto.setCountry(expressDeliver.getSenderCountry());
            deliverInfoDto.setShipperCode(expressDeliver.getSenderPostCode());
            deliverInfoDto.setMobile(expressDeliver.getSenderMobile());
            deliverInfoDto.setTel(expressDeliver.getSenderTel());
            deliverInfoDto.setContact(expressDeliver.getSender());

            //货物信息
            CargoInfoDto cargoInfoDto = new CargoInfoDto();
            cargoInfoDto.setParcelQuantity(Integer.valueOf(1));
            cargoInfoDto.setCargo(expressDeliverDetail.getProductNo());
            cargoInfoDto.setCargoCount(Integer.toString((int)Math.rint(expressDeliverDetail.getQuantity().doubleValue())));
            cargoInfoDto.setCargoUnit(expressDeliverDetail.getUnit());
            cargoInfoDto.setCargoAmount(Integer.toString((int)Math.rint(expressDeliverDetail.getPrice().doubleValue())));

            orderReqDto.setDeliverInfo(deliverInfoDto);
            orderReqDto.setConsigneeInfo(consigneeInfoDto);
            orderReqDto.setCargoInfo(cargoInfoDto);

            //增值服务，商品保价
            if (expressDeliverDetail.getInsure() != null && expressDeliverDetail.getInsure().compareTo(0f) > 0) {
                AddedServiceDto insureServiceDto = new AddedServiceDto();
                insureServiceDto.setName(ErpConstant.sf_added_service_name_insure);
                insureServiceDto.setValue(Integer.toString((int)Math.rint(expressDeliverDetail.getInsure().doubleValue())));

                orderReqDto.setAddedServices(new ArrayList());
                orderReqDto.getAddedServices().add(insureServiceDto);
            }

            req.setBody(orderReqDto);

            System.out.println("传入参数" + ToStringBuilder.reflectionToString(req));
            MessageResp<OrderRespDto> messageResp = null;
            try {
                messageResp = OrderTools.order(url, appInfo, req);
            } catch (Exception e) {
                e.printStackTrace();
                result += CommonConstant.fail;
            }

            if (messageResp.getHead().getCode().equals(ErpConstant.sf_response_code_success) &&
                    messageResp.getBody().getRemarkCode().equals("01")) {
                result += CommonConstant.success;
            } else {
                result += CommonConstant.fail;
                logger.info(messageResp.getHead().getMessage());
            }
        }

        logger.info("sfExpressOrder end, " + result);
        return result.equals(CommonConstant.fail) ? result : result.substring(CommonConstant.fail.length());
    }

    /**
     * sf快递单订单查询
     * @param expressNo
     * @return
     */
    public OrderQueryRespDto sfExpressOrderQuery(String expressNo) {
        String url = sfExpress.getOrderQueryUri();
        AppInfo appInfo = new AppInfo();
        appInfo.setAppId(sfExpress.getAppId());
        appInfo.setAppKey(sfExpress.getAppKey());
        appInfo.setAccessToken(getSfToken());

        MessageReq req = new MessageReq();
        HeadMessageReq head = new HeadMessageReq();
        head.setTransType(ErpConstant.sf_action_code_query_order);
        head.setTransMessageId(erpDao.getSfTransMessageId());
        req.setHead(head);

        OrderQueryReqDto oderQueryReqDto = new OrderQueryReqDto();
        oderQueryReqDto.setOrderId(expressNo);
        req.setBody(oderQueryReqDto);

        MessageResp<OrderQueryRespDto> messageResp = null;
        try {
            messageResp = OrderTools.orderQuery(url, appInfo, req);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (messageResp.getHead().getCode().equals(ErpConstant.sf_response_code_success)) {
            updateMailNo(expressNo, messageResp.getBody().getMailNo());
            return messageResp.getBody();
        } else {
            return null;
        }
    }

    public void updateMailNo(String expressNo, String mailNo) {
        try {
            ExpressDeliverDetail deliverDetail = new ExpressDeliverDetail();
            deliverDetail.setExpressNo(expressNo);
            ExpressDeliverDetail dbDeliverDetail = (ExpressDeliverDetail) erpDao.query(deliverDetail).get(0);
            dbDeliverDetail.setMailNo(mailNo);
            erpDao.updateById(dbDeliverDetail.getId(), dbDeliverDetail);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 下载顺丰快递单
     * @param expressNo
     * @return
     */
    public String downloadSfWaybill(String expressNo) {
        String sfWaybillImage = "";

        String url = sfExpress.getImageUri();
        AppInfo appInfo = new AppInfo();
        appInfo.setAppId(sfExpress.getAppId());
        appInfo.setAppKey(sfExpress.getAppKey());
        appInfo.setAccessToken(getSfToken());

        //设置请求头
        MessageReq<WaybillReqDto> req = new MessageReq<>();
        HeadMessageReq head = new HeadMessageReq();
        head.setTransType(ErpConstant.sf_action_code_download_waybill);
        head.setTransMessageId(erpDao.getSfTransMessageId());
        req.setHead(head);

        WaybillReqDto waybillReqDto = new WaybillReqDto();
        waybillReqDto.setOrderId(expressNo);
        req.setBody(waybillReqDto);

        try {
            MessageResp<WaybillRespDto> messageResp = WaybillDownloadTools.waybillDownload(url, appInfo, req);

            if (messageResp.getHead().getCode().equals(ErpConstant.sf_response_code_success)) {
                String[] images = messageResp.getBody().getImages();

                if (images != null) {
                    for (String image : images) {
                        sfWaybillImage += "<img src='data:image/png;base64," + image + "'/><br/><br/>";
                    }
                }
            }
        } catch (Exception e){
            e.printStackTrace();
        }

        return sfWaybillImage;
    }

    /**
     * 获取顺丰 token
     * @return
     */
    public String getSfToken() {
        logger.info("getSfToken start");
        String token = (String) erpDao.getFromStore(ErpConstant.sf_access_token_key);

        if (token == null) {
            setSfTokens();
        }

        logger.info("getSfToken end");
        return (String) erpDao.getFromStore(ErpConstant.sf_access_token_key);
    }

    public void setSfTokens() {
        logger.info("setSfTokens start");

        String url = sfExpress.getTokenUri();
        AppInfo appInfo = new AppInfo();
        appInfo.setAppId(sfExpress.getAppId());
        appInfo.setAppKey(sfExpress.getAppKey());

        MessageReq<TokenReqDto> req = new MessageReq<>();
        HeadMessageReq head = new HeadMessageReq();
        head.setTransType(ErpConstant.sf_action_code_access_token);
        head.setTransMessageId(erpDao.getSfTransMessageId());
        req.setHead(head);

        try {
            MessageResp<TokenRespDto> messageResp = SecurityTools.applyAccessToken(url, appInfo, req);

            if (messageResp.getHead().getCode().equals(ErpConstant.sf_response_code_success)) {
                erpDao.store(ErpConstant.sf_access_token_key, messageResp.getBody().getAccessToken(), ErpConstant.sf_token_time);
                erpDao.store(ErpConstant.sf_refresh_token_key, messageResp.getBody().getRefreshToken(), ErpConstant.sf_refresh_token_time);
            }

            logger.info(messageResp.getHead().getCode() + "," + messageResp.getHead().getMessage() + "," +
                    messageResp.getBody().getAccessToken() + "," + messageResp.getBody().getRefreshToken());

        } catch (Exception e) {
            e.printStackTrace();
        }

        logger.info("setSfTokens end");
    }

    public void refreshSfTokens(String accessToken, String refreshToken) {
        logger.info("refreshSfTokens start:" + accessToken + "," + refreshToken);

        String url = sfExpress.getTokenRefreshUri();
        AppInfo appInfo = new AppInfo();
        appInfo.setAppId(sfExpress.getAppId());
        appInfo.setAppKey(sfExpress.getAppKey());
        appInfo.setAccessToken(accessToken);
        appInfo.setRefreshToken(refreshToken);

        MessageReq req = new MessageReq();
        HeadMessageReq head = new HeadMessageReq();
        head.setTransType(ErpConstant.sf_action_code_refresh_Token);
        head.setTransMessageId(erpDao.getSfTransMessageId());
        req.setHead(head);

        try {
            MessageResp<TokenRespDto> messageResp = SecurityTools.refreshAccessToken(url, appInfo, req);

            if (messageResp.getHead().getCode().equals(ErpConstant.sf_response_code_refresh_token_unExist) ||
                    messageResp.getHead().getCode().equals(ErpConstant.sf_response_code_refresh_token_timeout)){
                setSfTokens();

            } else if(messageResp.getHead().getCode().equals(ErpConstant.sf_response_code_success)) {
                erpDao.store(ErpConstant.sf_access_token_key, messageResp.getBody().getAccessToken(), ErpConstant.sf_token_time);
                erpDao.store(ErpConstant.sf_refresh_token_key, messageResp.getBody().getRefreshToken(), ErpConstant.sf_refresh_token_time);
            }

            logger.info(messageResp.getHead().getCode() + "," + messageResp.getHead().getMessage() + "," +
                    messageResp.getBody().getAccessToken() + "," + messageResp.getBody().getRefreshToken());

        } catch (Exception e) {
            e.printStackTrace();
        }

        logger.info("refreshSfTokens end");
    }

    /**
     * 接收人信息是否相同
     * @param receiverInfo
     * @param expressDeliver
     * @return
     */
    boolean isReceiverInfoSame (ExpressDeliver receiverInfo, ExpressDeliver expressDeliver) {
        try {
            if (receiverInfo.getReceiver().equals(expressDeliver.getReceiver()) &&
                    receiverInfo.getReceiverAddress().equals(expressDeliver.getReceiverAddress()) &&
                    receiverInfo.getReceiverCity().equals(expressDeliver.getReceiverCity()) &&
                    receiverInfo.getReceiverCountry().equals(expressDeliver.getReceiverCountry()) &&
                    receiverInfo.getReceiverProvince().equals(expressDeliver.getReceiverProvince()) &&
                    dateUtil.getSimpleDateFormat().format(receiverInfo.getDate()).equals(dateUtil.getSimpleDateFormat().format(expressDeliver.getDate()))) {

                if (receiverInfo.getReceiverMobile() != null && expressDeliver.getReceiverMobile() != null) {
                    if (receiverInfo.getReceiverMobile().equals(expressDeliver.getReceiverMobile())) {
                        return true;
                    }
                }

                if (receiverInfo.getReceiverTel() != null && expressDeliver.getReceiverTel() != null) {
                    if (receiverInfo.getReceiverTel().equals(expressDeliver.getReceiverTel())) {
                        return true;
                    }
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}