package com.hzg.order;

import org.springframework.cloud.netflix.feign.FeignClient;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: SysClient.java
 * 使用@FeignClient注解的fallback属性，指定fallback类
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/10/17
 */
@FeignClient(name = "microservice-provider-sys", path="/sys", fallback = SysClient.ErpClientFallback.class)
public interface SysClient {
    org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(SysClient.class);

    @RequestMapping(value = "/getCompanyByUser", method = RequestMethod.POST)
    String getCompanyByUser(@RequestBody String json);

    @RequestMapping(value = "/computeSysCurrentTimeMillis", method = RequestMethod.GET)
    long computeSysCurrentTimeMillis();

    @RequestMapping(value = "/query", method = RequestMethod.POST)
    String query(@RequestParam("entity") String entity, @RequestBody String json);

    @Component
    class ErpClientFallback implements SysClient {
        @Override
        public String getCompanyByUser(String json) {
            logger.info("getCompanyByUser 异常发生，进入fallback方法，接收的参数：" + json);
            return "{}";
        }

        @Override
        public long computeSysCurrentTimeMillis() {
            logger.info("computeSysCurrentTimeMillis 异常发生，进入fallback方法");
            return -1L;
        }

        @Override
        public String query(String entity, String json) {
            logger.info("query 异常发生，进入fallback方法，接收的参数：" + entity + ":" + json);
            return "[]";
        }
    }
}
