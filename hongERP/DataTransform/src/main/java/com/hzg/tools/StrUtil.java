package com.hzg.tools;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: StrUtil.java
 * 字符串工具栏
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/5/12
 */
@Component
public class StrUtil {
    private char[] chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".toCharArray();
    private char[] numbers = "0123456789".toCharArray();

    @Autowired
    private DateUtil dateUtil;

    private static final HashMap<String,String> sqlTokens;
    private static Pattern sqlTokenPattern;

    static
    {
        //MySQL escape sequences: http://dev.mysql.com/doc/refman/5.1/en/string-syntax.html
        String[][] search_regex_replacement = new String[][]
                {
                        //search string     search regex        sql replacement regex
                        {   "\u0000"    ,       "\\x00"     ,       "\\\\0"     },
                        {   "'"         ,       "'"         ,       "\\\\'"     },
                        {   "\""        ,       "\""        ,       "\\\\\""    },
                        {   "\b"        ,       "\\x08"     ,       "\\\\b"     },
                        {   "\n"        ,       "\\n"       ,       "\\\\n"     },
                        {   "\r"        ,       "\\r"       ,       "\\\\r"     },
                        {   "\t"        ,       "\\t"       ,       "\\\\t"     },
                        {   "\u001A"    ,       "\\x1A"     ,       "\\\\Z"     },
                        {   "\\"        ,       "\\\\"      ,       "\\\\\\\\"  }
                };

        sqlTokens = new HashMap<String,String>();
        String patternStr = "";
        for (String[] srr : search_regex_replacement)
        {
            sqlTokens.put(srr[0], srr[2]);
            patternStr += (patternStr.isEmpty() ? "" : "|") + srr[1];
        }
        sqlTokenPattern = Pattern.compile('(' + patternStr + ')');
    }


    public String escape(String s)
    {
        Matcher matcher = sqlTokenPattern.matcher(s);
        StringBuffer sb = new StringBuffer();
        while(matcher.find())
        {
            matcher.appendReplacement(sb, sqlTokens.get(matcher.group(1)));
        }
        matcher.appendTail(sb);
        return sb.toString();
    }

    public String generateRandomStr(int strLength) {
        return generateStr(strLength, chars);
    }

    public String generateDateRandomStr(int strLength) {
        return System.currentTimeMillis() + generateRandomStr(strLength);
    }

    public String generateRandomNumberStr(int strLength) {
        return generateStr(strLength, numbers);
    }

    public String generateStr(int strLength, char[] chars) {
        String randomStr = null;

        if (strLength > 0) {
            randomStr = "";
        }

        Random random = new Random();

        for ( int i = 0 ; i < strLength ; i++) {
            randomStr += String.valueOf(chars[random.nextInt(chars.length)]);
        }

        return randomStr;
    }

    public String getStringValue(Object value) {
        return value == null ? null : String.valueOf(value).trim();
    }

    public Integer getIntegerValue(Object value) {
        return value == null ? null : Integer.parseInt(String.valueOf(value));
    }

    public Long getLongValue(Object value) {
        return value == null ? null : Long.parseLong(String.valueOf(value));
    }

    public Float getFloatValue(Object value) {
        return value == null ? null : Float.parseFloat(String.valueOf(value));
    }

    public Timestamp getTimestampValue(Object value) {
        return value == null ? null : Timestamp.valueOf(String.valueOf(value));
    }

    public Timestamp getTimestampByDate(Date date) {
        return date == null ? null : Timestamp.valueOf(dateUtil.getSimpleDateFormat().format(date));
    }

    public Date getDateValue(Object value) {
        Long dataLong = getLongValue(value);
        return dataLong == null ? null : new Date(dataLong);
    }

    public Boolean getBooleanValue(Object value) {
        return value == null ? null : (Boolean)value;
    }
}
