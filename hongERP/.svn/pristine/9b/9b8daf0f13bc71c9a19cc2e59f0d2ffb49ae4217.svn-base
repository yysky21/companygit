package com.hzg.erp;

import org.springframework.cloud.netflix.feign.FeignClient;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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

    @RequestMapping(value = "/getProductSoldQuantity", method = RequestMethod.POST)
    String getProductSoldQuantity(@RequestBody String json);

    @RequestMapping(value = "/getLastValidOrderByProduct", method = RequestMethod.POST)
    String getLastValidOrderByProduct(@RequestBody String json);

    @Component
    class OrderClientFallback implements OrderClient {
        @Override
        public String getProductSoldQuantity(String json) {
            logger.info("getProductSoldQuantity 异常发生，进入fallback方法，接收的参数：" + json);
            return "{}";
        }

        @Override
        public String getLastValidOrderByProduct(String json) {
            logger.info("getLastValidOrderByProduct 异常发生，进入fallback方法，接收的参数：" + json);
            return "{}";
        }
    }
}
