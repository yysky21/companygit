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
 * 文件名: AfterSaleServiceClient.java
 * 使用@FeignClient注解的fallback属性，指定fallback类
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/11/30
 */
@FeignClient(name = "microservice-provider-order", path="/afterSaleService", fallback = AfterSaleServiceClient.AfterSaleServiceClientFallback.class)
public interface AfterSaleServiceClient {
    org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(AfterSaleServiceClient.class);

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    String save(@RequestParam("entity") String entity, @RequestBody String json);

    @RequestMapping(value = "/business", method = RequestMethod.POST)
    String business(@RequestParam("name") String name, @RequestBody String json);


    @Component
    class AfterSaleServiceClientFallback implements AfterSaleServiceClient {
        @Override
        public String save(String entity, String json) {
            logger.info("save 异常发生，进入fallback方法，接收的参数：" + entity + ":" + json);
            return "{\"" + CommonConstant.result + "\":\"系统异常，保存出错\"}";
        }

        @Override
        public String business(String name, String json) {
            logger.info("business 异常发生，进入fallback方法，接收的参数：" + name + ":" + json);
            return "{\"" + CommonConstant.result + "\":\"系统异常，执行业务出错\"}";
        }
    }
}
