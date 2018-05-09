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
 * 文件名: FinanceClient.java
 * 使用@FeignClient注解的fallback属性，指定fallback类
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2017/11/25
 */
@FeignClient(name = "microservice-provider-finance", path="/finance", fallback = FinanceClient.FinanceClientFallback.class)
public interface FinanceClient extends Client {
    org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(FinanceClient.class);

    @RequestMapping(value = "/auditAction", method = RequestMethod.POST)
    String auditAction(@RequestBody String json);

    @RequestMapping(value = "/privateQuery", method = RequestMethod.POST)
    String privateQuery(@RequestParam("entity") String entity, @RequestBody String json);

    @RequestMapping(value = "/getNo", method = RequestMethod.POST)
    String getNo();

    @RequestMapping(value = "/queryDistinct", method = RequestMethod.POST)
    String queryDistinct(@RequestParam("entity") String entity);

    @Component
    class FinanceClientFallback extends ClientFallback implements FinanceClient {
        @Override
        public String privateQuery(String entity, String json) {
            logger.info("privateQuery 异常发生，进入fallback方法，接收的参数：" + entity + ":" + json);
            return "[]";
        }

        @Override
        public String auditAction(@RequestBody String json) {
            logger.info("auditAction 异常发生，进入fallback方法，接收的参数：" + json);
            return "{\"" + CommonConstant.result + "\":\"" + CommonConstant.fail + ",系统异常，更新出错\"}";
        }

        @Override
        public String getNo() {
            logger.info("getNo 异常发生，进入fallback方法" );
            return "[]";
        }

        @Override
        public String queryDistinct(String entity) {
            logger.info("queryPrivilege 异常发生，进入fallback方法，接收的参数："  + entity);
            return "{\"" + CommonConstant.result + "\":\"系统异常，查询出错\"}";
        }

    }
}
