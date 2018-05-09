package com.hzg.tools;

import com.boyuanitsm.pay.wxpay.protocol.downloadbill_protocol.DownloadBillReqData;
import com.hzg.sys.SysClient;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.BoundValueOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.TimeUnit;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: DateUtil.java
 * 类的详细说明
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/4/26
 */
@Component
public class DateUtil {
    Logger logger = Logger.getLogger(DateUtil.class);

    private SimpleDateFormat dayFormat = new SimpleDateFormat("yyyy-MM-dd");
    private SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private static final long expire_second_7_days = 3600 * 24 * 7;

    @Autowired
    private SysClient sysClient;

    @Autowired
    public RedisTemplate<String, Object> redisTemplate;

    public String getCurrentDayStr() {
        Date date = new Date();
        return dayFormat.format(date);
    }

    public String getCurrentDayStr(String dateFormat) {
        SimpleDateFormat df = new SimpleDateFormat(dateFormat);
        return df.format(new Date());
    }

    public String getCurrentDateStr() {
        Date date = new Date();
        return simpleDateFormat.format(date);
    }

    public String getDaysDate(String dateStr, String dateFormat, int num) {
        SimpleDateFormat df = new SimpleDateFormat(dateFormat);

        Date date = null;
        try {
             date = df.parse(dateStr);
        } catch (ParseException e) {
            logger.error(e.getMessage(), e);
        }

        return df.format(new Date(date.getTime() + (long)num * 24 * 60 * 60 * 1000));
    }

    /**
     * 获得当前日期的指定天数的日期
     *
     * @param days
     * @return
     */
    public Date getDay(int days) {
        Calendar calendar = Calendar.getInstance();
        Date date = null;

        try {
            date = new SimpleDateFormat("yy-M-d").parse(calendar.get(Calendar.YEAR) + "-" +
                    (calendar.get(Calendar.MONTH)+1) + "-" + calendar.get(Calendar.DATE));
        } catch (ParseException e) {
            logger.error(e.getMessage(), e);
        }

        calendar.setTime(date);
        int day = calendar.get(Calendar.DATE);
        calendar.set(Calendar.DATE, day + days);

        return calendar.getTime();
    }

    public Timestamp getSecondCurrentTimestamp(){
        long sysCurrentTimeMillis;

        BoundValueOperations<String, Object> operation = redisTemplate.boundValueOps("sysCurrentTimeMillis");

        Long currentTimeMillisStr = (Long)operation.get();
        if (currentTimeMillisStr != null) {
            sysCurrentTimeMillis = currentTimeMillisStr + (expire_second_7_days - operation.getExpire()) * 1000L;

        } else {
            sysCurrentTimeMillis = sysClient.computeSysCurrentTimeMillis();
            operation.set(sysCurrentTimeMillis);
            operation.expire(expire_second_7_days, TimeUnit.SECONDS);
        }

        return new Timestamp(sysCurrentTimeMillis - (sysCurrentTimeMillis % 1000));
    }

    public SimpleDateFormat getSimpleDateFormat() {
        return simpleDateFormat;
    }

    public Date getDate(String dateFormat, String dateStr) {
        try {
            return new SimpleDateFormat(dateFormat).parse(dateStr);
        } catch (ParseException e) {
            logger.error(e.getMessage(), e);
        }

        return null;
    }
}
