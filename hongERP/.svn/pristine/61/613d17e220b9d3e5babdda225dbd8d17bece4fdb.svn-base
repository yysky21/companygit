package com.hzg.sys;

import com.hzg.tools.CommonConstant;
import org.springframework.cloud.netflix.feign.FeignClient;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: Client.java
 * 使用@FeignClient注解的fallback属性，指定fallback类
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/6/23
 */
@FeignClient(name = "microservice-provider-erp", path="/erp", fallback = ErpClient.ErpClientFallback.class)
public interface ErpClient {
    org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(ErpClient.class);

    @RequestMapping(value = "/auditAction", method = RequestMethod.POST)
    String auditAction(@RequestBody String json);

    @RequestMapping(value = "/query", method = RequestMethod.POST)
    String query(@RequestParam("entity") String entity, @RequestBody String json);

    @RequestMapping(value = "/getNo", method = RequestMethod.POST)
    String getNo(@RequestParam("prefix") String prefix);

    @Component
    class ErpClientFallback implements ErpClient {
        @Override
        public String auditAction(String json) {
            logger.info("auditAction 异常发生，进入fallback方法，接收的参数：" + json);
            return "{\"" + CommonConstant.result + "\":\"" + CommonConstant.fail + ",系统异常，更新出错\"}";
        }

        @Override
        public String query(String entity, String json) {
            logger.info("query 异常发生，进入fallback方法，接收的参数：" + entity + ":" + json);
            return "[]";
        }

        @Override
        public String getNo(String prefix) {
            logger.info("getNo 异常发生，进入fallback方法，接收的参数：" + prefix);
            return "[]";
        }
    }
}
