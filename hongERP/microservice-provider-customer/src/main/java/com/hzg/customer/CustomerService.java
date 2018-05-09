package com.hzg.customer;

import com.hzg.base.Dao;
import com.hzg.tools.CommonConstant;
import com.hzg.tools.CustomerConstant;
import com.hzg.tools.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.List;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: CustomerService.java
 * 类的详细说明
 *
 * @author smjie
 * @version 1.00
 * @Date 2018/4/23
 */
@Service
public class CustomerService {

    @Autowired
    private Dao dao;

    @Autowired
    private DateUtil dateUtil;

    /**
     * 保存客户
     * @param customer
     * @return
     */
    public String saveCustomer(Customer customer) {
        String result = CommonConstant.fail;

        Timestamp inputDate = dateUtil.getSecondCurrentTimestamp();

        Degree degree = new Degree();
        degree.setLoyalty(CustomerConstant.customer_init_loyalty);
        degree.setCredit(CustomerConstant.customer_init_credit);
        degree.setLevel(CustomerConstant.customer_level_normal);
        degree.setSpendAmount(0f);
        degree.setSpendCount(0);
        degree.setSpendPoints(0);
        result += dao.save(degree);

        customer.setDegree(degree);
        customer.setInputDate(inputDate);
        result += dao.save(customer);

        Customer idCustomer = new Customer();
        idCustomer.setId(customer.getId());

        User user = (User) customer.getUsers().toArray()[0];
        if (!dao.isValueRepeat(User.class, CommonConstant.username, user.getUsername(), user.getId())) {
            user.setCustomer(idCustomer);
            user.setInputDate(inputDate);
            user.setState(CustomerConstant.user_state_onUse);
            user.setOnlineTime(0);
            user.setClickCount(0);
            user.setLoginCount(0);
            user.setPoints(0);

            result += dao.save(user);

            /**
             * 一对多保存时，为一的实体里的子元素 id 为空，重新设置 redis 里为一的实体里的子元素
             */
            customer.getUsers().clear();
            customer.getUsers().add(user);
            dao.storeToRedis(customer.getClass().getName() + CommonConstant.underline + customer.getId(), customer);

        } else {
            result = CommonConstant.fail + ",用户名已经存在";
        }

        for (Express express : customer.getExpresses()) {
            express.setCustomer(idCustomer);
            express.setState(CustomerConstant.express_state_onUse);
            express.setDefaultUse(CustomerConstant.express_default_use);
            result += dao.save(express);
        }

        return result.equals(CommonConstant.fail) ? result : result.substring(CommonConstant.fail.length());
    }

    /**
     * 保存用户
     * @param user
     * @return
     */
    public String saveUser(User user) {
        String result = CommonConstant.fail;

        User singInUser = (User) dao.getFromRedis((String) dao.getFromRedis(CommonConstant.sessionId + CommonConstant.underline + user.getSessionId()));

        if (!dao.isValueRepeat(User.class, CommonConstant.username, user.getUsername(), user.getId())) {
            Customer idCustomer = new Customer();
            idCustomer.setId(singInUser.getCustomer().getId());
            user.setCustomer(idCustomer);

            user.setInputDate(dateUtil.getSecondCurrentTimestamp());
            user.setState(CustomerConstant.user_state_onUse);
            user.setOnlineTime(0);
            user.setClickCount(0);
            user.setLoginCount(0);
            user.setPoints(0);

            result += dao.save(user);

            /**
             * 多次增加一对多中为一的实体里的子元素，需要重新设置为一的实体到 redis
             */
            singInUser.getCustomer().getUsers().add(user);
            dao.storeToRedis(singInUser.getCustomer().getClass().getName() + CommonConstant.underline + singInUser.getCustomer().getId(), singInUser.getCustomer());

        }  else {
            result = CommonConstant.fail + ",用户名已经存在";
        }

        return result.equals(CommonConstant.fail) ? result : result.substring(CommonConstant.fail.length());
    }


    /**
     * 后台保存用户
     * @param user
     * @return
     */
    public String saveUserAdmin(User user) {
        String result = CommonConstant.fail;


        if (!dao.isValueRepeat(User.class, CommonConstant.username, user.getUsername(), user.getId())) {
            user.setInputDate(dateUtil.getSecondCurrentTimestamp());
            user.setState(CustomerConstant.user_state_onUse);
            user.setOnlineTime(0);
            user.setClickCount(0);
            user.setLoginCount(0);
            user.setPoints(0);

            result += dao.save(user);

            /**
             * 多次增加一对多中为一的实体里的子元素，需要重新设置为一的实体到 redis
             */
            Customer dbCustomer = (Customer) dao.queryById(user.getCustomer().getId(), user.getCustomer().getClass());
            dbCustomer.getUsers().add(user);
            dao.storeToRedis(dbCustomer.getClass().getName() + CommonConstant.underline + dbCustomer.getId(), dbCustomer);

        }  else {
            result = CommonConstant.fail + ",用户名已经存在";
        }

        return result.equals(CommonConstant.fail) ? result : result.substring(CommonConstant.fail.length());
    }

    /**
     * 保存收件信息
     * @param express
     * @return
     */
    public String saveExpress(Express express) {
        String result = CommonConstant.fail;

        User singInUser = (User) dao.getFromRedis((String) dao.getFromRedis(CommonConstant.sessionId + CommonConstant.underline + express.getSessionId()));

        Customer idCustomer = new Customer();
        idCustomer.setId(singInUser.getCustomer().getId());
        express.setCustomer(idCustomer);

        result += dao.save(express);
        result += setExpressDefaultUse(express);

        /**
         * 多次增加一对多中为一的实体里的子元素，需要重新设置为一的实体到 redis
         */
        singInUser.getCustomer().getExpresses().add(express);
        dao.storeToRedis(singInUser.getCustomer().getClass().getName() + CommonConstant.underline + singInUser.getCustomer().getId(), singInUser.getCustomer());

        return result.equals(CommonConstant.fail) ? result : result.substring(CommonConstant.fail.length());
    }

    /**
     * 后台保存收件信息
     * @param express
     * @return
     */
    public String saveExpressAdmin(Express express) {
        String result = CommonConstant.fail;

        result += dao.save(express);
        result += setExpressDefaultUse(express);

        /**
         * 多次增加一对多中为一的实体里的子元素，需要重新设置为一的实体到 redis
         */
        Customer dbCustomer = (Customer) dao.queryById(express.getCustomer().getId(), express.getCustomer().getClass());
        dbCustomer.getExpresses().add(express);
        dao.storeToRedis(dbCustomer.getClass().getName() + CommonConstant.underline + dbCustomer.getId(), dbCustomer);

        return result.equals(CommonConstant.fail) ? result : result.substring(CommonConstant.fail.length());
    }

    /**
     * 设置默认收件信息
     * @param express
     * @return
     */
    public String setExpressDefaultUse(Express express) {
        String result = CommonConstant.fail;

        if (express.getDefaultUse().equals(CommonConstant.Y)) {
            Express queryExpress = new Express();
            queryExpress.setCustomer(express.getCustomer());
            List<Express> expresses = dao.query(queryExpress);

            for (Express ele : expresses) {
                if (ele.getId().compareTo(express.getId()) != 0) {
                    ele.setDefaultUse(CommonConstant.N);
                    result += dao.updateById(ele.getId(), ele);
                }
            }
        }

        return result.equals(CommonConstant.fail) ? result : result.substring(CommonConstant.fail.length());
    }

    public com.hzg.sys.User getBackUserBySessionId(String sessionId){
        Object user = dao.getFromRedis((String)dao.getFromRedis(CommonConstant.sessionId + CommonConstant.underline + sessionId));
        if (user instanceof com.hzg.sys.User) {
            return (com.hzg.sys.User)user;
        } else {
            return null;
        }
    }
}
