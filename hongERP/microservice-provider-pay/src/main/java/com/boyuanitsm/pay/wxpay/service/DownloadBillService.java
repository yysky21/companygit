/*
 * Copyright 2016-2017 Shanghai Boyuan IT Services Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.boyuanitsm.pay.wxpay.service;

import com.boyuanitsm.pay.wxpay.common.Configure;
import com.boyuanitsm.pay.wxpay.common.XMLParser;
import com.boyuanitsm.pay.wxpay.protocol.downloadbill_protocol.DownloadBillReqData;
import com.boyuanitsm.pay.wxpay.protocol.downloadbill_protocol.DownloadBillResData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * User: rizenguo
 * Date: 2014/10/29
 * Time: 16:04
 */
@Service
public class DownloadBillService extends BaseService{

    @Autowired
    Configure configure;

    public DownloadBillService() throws IllegalAccessException, InstantiationException, ClassNotFoundException {
        super(Configure.DOWNLOAD_BILL_API);
    }

    //ALL，返回当日所有订单信息，默认值
    public static final String BILL_TYPE_ALL = "ALL";

    //SUCCESS，返回当日成功支付的订单
    public static final String BILL_TYPE_SUCCESS = "SUCCESS";

    //REFUND，返回当日退款订单
    public static final String BILL_TYPE_REFUND = "REFUND";

    //REVOKED，已撤销的订单
    public static final String BILL_TYPE_REVOKE = "REVOKE";


    /**
     * 请求对账单下载服务
     * @param downloadBillReqData 这个数据对象里面包含了API要求提交的各种数据字段
     * @return API返回的XML数据
     * @throws Exception
     */
    public String request(DownloadBillReqData downloadBillReqData) throws Exception {

        //--------------------------------------------------------------------
        //发送HTTPS的Post请求到API地址
        //--------------------------------------------------------------------
        String responseString = sendPost(configure.getDownloadBillApi(), downloadBillReqData);

        return responseString;
    }
}
