package com.hzg.mq;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.core.JmsMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.jms.Queue;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: MQSender.java
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/3/28
 */
@Controller
@RequestMapping("/mq")
public class MQSender {
    @Autowired
    private JmsMessagingTemplate jmsMessagingTemplate;

    @Autowired
    private Queue queue;

    // 发送消息到 userQueue 队列
    @RequestMapping(value="/sendMQ",method= RequestMethod.GET)
    public void sendMQ(String message){
        jmsMessagingTemplate.convertAndSend(queue, message);
    }
}
