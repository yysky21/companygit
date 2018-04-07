package com.hzg.tools;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: SpringContext.java
 * 类的详细说明
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/6/15
 */
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

@Component
public class SpringUtil implements ApplicationContextAware {

    private static ApplicationContext applicationContext;

    /**
     * 当继承了ApplicationContextAware类之后，那么程序在调用 getBean(String)的时候会自动调用该方法，不用自己操作
     */
    @Override
    public void setApplicationContext(ApplicationContext applicationContext)
            throws BeansException {
        this.applicationContext = applicationContext;
    }

    public static Object getBean(String beanName) {
        return applicationContext.getBean(beanName);
    }
}