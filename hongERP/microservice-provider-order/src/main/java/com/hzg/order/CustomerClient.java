package com.hzg.order;

import org.springframework.cloud.netflix.feign.FeignClient;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: CustomerClient.java
 * 使用@FeignClient注解的fallback属性，指定fallback类
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/10/31
 */
@FeignClient(name = "microservice-provider-customer", path="/customer", fallback = CustomerClient.PayClientFallback.class)
public interface CustomerClient {
    org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(CustomerClient.class);

    @RequestMapping(value = "/unlimitedQuery", method = RequestMethod.POST)
    String unlimitedQuery(@RequestParam("entity") String entity, @RequestBody String json);

    @Component
    class PayClientFallback implements CustomerClient {
        @Override
        public String unlimitedQuery(String entity, String json) {
            logger.info("unlimitedQuery 异常发生，进入fallback方法，接收的参数：" + entity + ":" + json);
            return "[]";
        }
    }
}
