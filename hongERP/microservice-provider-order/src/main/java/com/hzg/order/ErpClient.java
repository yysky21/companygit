package com.hzg.order;

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

    @RequestMapping(value = "/querySalePrice", method = RequestMethod.GET)
    String querySalePrice(@RequestBody String json);

    @RequestMapping(value = "/getProductOnSaleQuantity", method = RequestMethod.POST)
    String getProductOnSaleQuantity(@RequestBody String json);

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    String save(@RequestParam("entity") String entity, @RequestBody String json);

    @RequestMapping(value = "/business", method = RequestMethod.POST)
    String business(@RequestParam("name") String name, @RequestBody String json);

    @RequestMapping(value = "/getNo", method = RequestMethod.POST)
    String getNo(@RequestParam("prefix") String prefix);

    @RequestMapping(value = "/getWarehouseByCompany", method = RequestMethod.GET)
    String getWarehouseByCompany(@RequestBody String json);

    @RequestMapping(value = "/sfExpress/order", method = RequestMethod.POST)
    String sfExpressOrder(@RequestBody String json);

    @RequestMapping(value = "/query", method = RequestMethod.POST)
    String query(@RequestParam("entity") String entity, @RequestBody String json);

    @RequestMapping(value = "/getLastStockInOutByProductAndType", method = RequestMethod.POST)
    String getLastStockInOutByProductAndType(@RequestBody String json, @RequestParam("type") String type);

    @RequestMapping(value = "/getStockInProcessAmount", method = RequestMethod.POST)
    String getStockInProcessAmount(@RequestBody String json);

    @RequestMapping(value = "/getProductUnit", method = RequestMethod.POST)
    String getProductUnit(@RequestBody String json);

    @RequestMapping(value = "/sfExpress/waybill/getByProduct", method = RequestMethod.POST)
    String sfExpressWaybillGetByProduct(@RequestBody String json);

    @Component
    class ErpClientFallback implements ErpClient {
        @Override
        public String querySalePrice(String json) {
            logger.info("querySalePrice 异常发生，进入fallback方法，接收的参数：" + json);
            return "[]";
        }

        @Override
        public String getProductOnSaleQuantity(String json) {
            logger.info("getProductOnSaleQuantity 异常发生，进入fallback方法，接收的参数：" + json);
            return "{\"" + CommonConstant.result + "\":\"" + CommonConstant.fail + ",系统异常，更新出错\"}";
        }

        @Override
        public String save(String entity, String json) {
            logger.info("save 异常发生，进入fallback方法，接收的参数：" + entity + ":" + json);
            return "{\"" + CommonConstant.result + "\":\"" + CommonConstant.fail + ",系统异常，保存出错\"}";
        }

        @Override
        public String business(String name, String json) {
            logger.info("business 异常发生，进入fallback方法，接收的参数：" + name + ":" + json);
            return "{\"" + CommonConstant.result + "\":\"" + CommonConstant.fail + ",系统异常，执行业务出错\"}";
        }

        @Override
        public String getNo(String prefix) {
            logger.info("getNo 异常发生，进入fallback方法，接收的参数：" + prefix);
            return "[]";
        }

        @Override
        public String getWarehouseByCompany(String json) {
            logger.info("getWarehouseByCompany 异常发生，进入fallback方法，接收的参数：" + json);
            return "[]";
        }

        @Override
        public String sfExpressOrder(String json) {
            logger.info("sfExpressOrder 异常发生，进入fallback方法，接收的参数：" + json);
            return "{\"" + CommonConstant.result + "\":\"" + CommonConstant.fail + ",系统异常，执行顺丰下单出错\"}";
        }

        @Override
        public String query(String entity, String json) {
            logger.info("query 异常发生，进入fallback方法，接收的参数：" + entity + ":" +json);
            return "[]";
        }

        @Override
        public String getLastStockInOutByProductAndType(String json, String type) {
            logger.info("getLastStockInOutByProductAndType 异常发生，进入fallback方法，接收的参数：" + json + "," + type);
            return "{}";
        }

        @Override
        public String getStockInProcessAmount(String json) {
            logger.info("getStockInProcessAmount 异常发生，进入fallback方法，接收的参数：" + json);
            return "{}";
        }

        @Override
        public String getProductUnit(String json) {
            logger.info("getProductUnit 异常发生，进入fallback方法，接收的参数：" + json);
            return "{}";
        }

        @Override
        public String sfExpressWaybillGetByProduct(String json) {
            logger.info("sfExpressWaybillGetByProduct 异常发生，进入fallback方法，接收的参数：" + json);
            return "{}";
        }
    }
}
