package com.hzg.tools;

import com.hzg.sys.User;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: MacValidator.java
 * 类的详细说明
 *
 * @author smjie
 * @version 1.00
 * @Date 2018/5/18
 */
@Component
public class MacValidator {
    @Autowired
    public RedisTemplate<String, Object> redisTemplate;

    public boolean md5Validate(String mac, String sessionId, String validateStr) {
        boolean pass = false;

        String salt = (String)redisTemplate.opsForValue().get(CommonConstant.salt + CommonConstant.underline + sessionId);
        com.hzg.customer.User user = (com.hzg.customer.User) redisTemplate.opsForValue().get((String)redisTemplate.opsForValue().get(CommonConstant.sessionId + CommonConstant.underline + sessionId));
        String pin = DigestUtils.md5Hex(salt + user.getPassword()).toUpperCase();

        if (mac.equals(DigestUtils.md5Hex(validateStr + pin).toUpperCase())) {
            pass = true;
        }

        return pass;
    }
}
