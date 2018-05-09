package com.hzg.mq;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.annotation.JmsListener;
import org.springframework.jms.core.JmsMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.jms.JMSException;
import javax.jms.Queue;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: MQReceiver.java
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/3/28
 */
@Controller
@RequestMapping("/mq")
public class MQReceiver {

    Logger logger = Logger.getLogger(MQReceiver.class);

    @Autowired
    private JmsMessagingTemplate jmsMessagingTemplate;

    @Autowired
    private Queue queue;

    // 自动触发接受
    @JmsListener(destination = "userQueue")
    public void receiveQueue(String text) {
        logger.info("receive message from userQueue: " + text);
    }

    // 从 userQueue 队列接受消息
    @RequestMapping(value="/receiveMQ",method= RequestMethod.GET)
    public String receiveMQ(){
        String message = jmsMessagingTemplate.receive(queue).toString();
        String queueName = "";
        try {
            queueName = queue.getQueueName();
        } catch (JMSException e) {
            logger.error(e.getMessage(), e);
        }
        logger.info("receive message from " + queueName + ":" + message);

        return message;
    }
}
