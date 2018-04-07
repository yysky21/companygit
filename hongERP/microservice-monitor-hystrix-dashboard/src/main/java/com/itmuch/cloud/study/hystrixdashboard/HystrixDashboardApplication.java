package com.itmuch.cloud.study.hystrixdashboard;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.cloud.netflix.hystrix.dashboard.EnableHystrixDashboard;
import org.springframework.cloud.netflix.turbine.EnableTurbine;

/**
 * 测试步骤:
 * 1. 访问http://localhost:8030/hystrix.stream 可以查看Dashboard
 * 2. 在上面的输入框填入: http://想监控的服务:端口/hystrix.stream进行测试
 * 注意：首先要先调用一下想监控的服务的API，否则将会显示一个空的图表.
 * 3. http://localhost:8030/hystrix.stream，并
 * 将http://localhost:8030/turbine.stream输入到其上的输入框，并随意指定一个
 * Title,监控 turbine
 * @author eacdy
 */
@SpringBootApplication
@EnableEurekaClient
@EnableHystrixDashboard
@EnableTurbine
public class HystrixDashboardApplication {
  public static void main(String[] args) {
    new SpringApplicationBuilder(HystrixDashboardApplication.class).web(true).run(args);
  }
}
