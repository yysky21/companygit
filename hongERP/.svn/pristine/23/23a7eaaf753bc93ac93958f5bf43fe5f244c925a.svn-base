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
 * @Date 2017/6/22
 */
@FeignClient(name = "microservice-provider-sys", path="/sys", fallback = SysClient.SysClientFallback.class)
public interface SysClient {
    org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(SysClient.class);

    @RequestMapping(value = "/computeSysCurrentTimeMillis", method = RequestMethod.GET)
    long computeSysCurrentTimeMillis();

    @Component
    class SysClientFallback implements SysClient {

        @Override
        public long computeSysCurrentTimeMillis() {
            logger.info("computeSysCurrentTimeMillis 异常发生，进入fallback方法");
            return -1L;
        }
    }
}
