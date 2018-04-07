package com.hzg.afterSaleService;

import com.hzg.tools.CommonConstant;
import org.springframework.cloud.netflix.feign.FeignClient;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: OrderClient.java
 * 使用@FeignClient注解的fallback属性，指定fallback类
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/10/30
 */
@FeignClient(name = "microservice-provider-order", path="/order", fallback = OrderClient.OrderClientFallback.class)
public interface OrderClient {
    org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(OrderClient.class);

    @RequestMapping(value = "/unlimitedQuery", method = RequestMethod.POST)
    String unlimitedQuery(@RequestParam("entity") String entity, @RequestBody String json);

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    String save(@RequestParam("entity") String entity, @RequestBody String json);

    @RequestMapping(value = "/paid", method = RequestMethod.POST)
    String paid(@RequestBody String json);

    @Component
    class OrderClientFallback implements OrderClient {
        @Override
        public String unlimitedQuery(String entity, String json) {
            logger.info("unlimitedQuery 异常发生，进入fallback方法，接收的参数：" + entity + ":" + json);
            return "[]";
        }

        @Override
        public String save(String entity, String json) {
            logger.info("save 异常发生，进入fallback方法，接收的参数：" + entity + ":" + json);
            return "{\"" + CommonConstant.result + "\":\"系统异常，保存出错\"}";
        }

        public String paid(String json) {
            logger.info("paid 异常发生，进入fallback方法，接收的参数：" + json);
            return "{\"" + CommonConstant.result + "\":\"系统异常，确认收款出错\"}";
        }
    }
}
