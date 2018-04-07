package com.hzg.tools.httpProxy;

import org.springframework.boot.bind.RelaxedPropertyResolver;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.EnvironmentAware;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: HttpProxyServletConfiguration.java
 * 类的详细说明
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/10/11
 */
@Configuration
public class HttpProxyServletConfiguration implements EnvironmentAware {

    @Bean
    public ServletRegistrationBean alipayServletRegistrationBean(){
        ServletRegistrationBean servletRegistrationBean = new ServletRegistrationBean(new ProxyServlet(), propertyResolver.getProperty("url"));
        return servletRegistrationBean;
    }

    private RelaxedPropertyResolver propertyResolver;

    @Override
    public void setEnvironment(Environment environment) {
        this.propertyResolver = new RelaxedPropertyResolver(environment, "httpProxy.");
    }
}
