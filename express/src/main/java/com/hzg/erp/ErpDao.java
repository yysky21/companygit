package com.hzg.erp;

import com.hzg.base.Dao;
import com.hzg.tools.DateUtil;
import org.apache.commons.collections.map.HashedMap;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Repository;

import java.util.*;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: SysDao.java
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/4/12
 */
@Repository
public class ErpDao extends Dao {

    Logger logger = Logger.getLogger(ErpDao.class);

    @Autowired
    private DateUtil dateUtil;

    private static int counter = 0;

    /**
     * 每天 0 点设置计数器为 0
     */
    @Scheduled(cron = "0 0 0 * * ?")
    public void resetCounter(){
        counter = 0;
    }

    /**
     * 顺丰交易流水号格式如：YYYYMMDDHHmmss+流水号{10},例如:201811121633230001,交易流水号唯一且不能重复
     */
    private int sfTransMessageIdCountLength = 4;

    public String getSfTransMessageId() {
        String countStr = String.valueOf(counter());

        int minusLength = sfTransMessageIdCountLength - countStr.length();
        while (minusLength > 0) {
            countStr = "0" + countStr;
            --minusLength;
        }

        String sfTransMessageId = dateUtil.getCurrentDayStr("yyyyMMddHHmmss") + countStr;

        logger.info("generate getSfTransMessageId:" + sfTransMessageId);

        return sfTransMessageId;
    }

    public synchronized int counter() {
        return ++counter;
    }



    private static Map<String, Object> store = new HashedMap();
    private static Map<String, Object> expireTimes = new HashedMap();
    private static Map<String, Object> storeTimes = new HashedMap();

    /**
     * 每 30 分钟清空一次过期对象
     */
    @Scheduled(cron = "0 0/30 0 * * ?")
    public void clearExpireObject(){
        long currentTime = System.currentTimeMillis();
        Set<String> keys = expireTimes.keySet();
        List<String> expireKeys = new ArrayList<>();

        for (String key : keys) {
            if ((Integer)expireTimes.get(key) * 1000 < (currentTime - (long)storeTimes.get(key))) {
                expireKeys.add(key);
            }
        }

        for (String expireKey : expireKeys) {
            store.remove(expireKey);
            expireTimes.remove(expireKey);
            storeTimes.remove(expireKey);
        }
    }

    public void store(String key, String object, Integer expire) {
        store.put(key, object);

        if (expire != null) {
            expireTimes.put(key, expire);
            storeTimes.put(key, System.currentTimeMillis());
        }
    }

    public Object getFromStore(String key) {
        Object value = store.get(key);

        Integer expireTime = (Integer)expireTimes.get(key);

        if (expireTime != null) {
            if (expireTime * 1000 < (System.currentTimeMillis() - (long)storeTimes.get(key))) {
                store.remove(key);
                value = null;
            }
        }

        return value;
    }
}
