package com.hzg.finance;

import com.hzg.base.Dao;
import com.hzg.tools.CommonConstant;
import com.hzg.tools.DateUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.BoundHashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.support.atomic.RedisAtomicLong;
import org.springframework.stereotype.Repository;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import java.lang.reflect.Field;
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
public class FinanceDao extends Dao {

    Logger logger = Logger.getLogger(FinanceDao.class);

    @Autowired
    private DateUtil dateUtil;

    @Autowired
    public RedisTemplate<String, Long> redisTemplateLong;

    private int countLength = 4;

    private RedisAtomicLong counter;

    /**
     * 产生一个编号
     * @return
     */
    public String getNo() {
        String key = "counter_voucher";

        Long count = 1L;
        Long value = redisTemplateLong.opsForValue().get(key);

        if (value == null) {
            counter = new RedisAtomicLong(key, redisTemplateLong.getConnectionFactory(), count);
            counter.expireAt(dateUtil.getMonth(1));
        } else {
            if (counter == null) {
                counter = new RedisAtomicLong(key, redisTemplate.getConnectionFactory());
                counter.set(value);
                counter.expireAt(dateUtil.getMonth(1));
            }

            count = counter.incrementAndGet();
        }


        String countStr = String.valueOf(count);

        int minusLength = countLength - countStr.length();
        while (minusLength > 0) {
            countStr = "0" + countStr;
            --minusLength;
        }

        String no = countStr;

        logger.info("generate no:" + no);

        return no;
    }

    public List queryDistinct(Object object){
        List objects = new ArrayList<>();

        Class clazz = object.getClass();
        Integer id = getId(object, clazz);

        if (id != null) {
            Object dbObject = queryById(id, clazz);
            if (dbObject != null) {
                objects.add(dbObject);
            }

        }else {
            String sql = "";
            if (clazz.getSimpleName().equalsIgnoreCase(BankSubjectExtend.class.getSimpleName())){
                sql = "select * from hzg_finance_banksubject_extend";
            } else if(clazz.getSimpleName().equalsIgnoreCase(PurchaseSubjectExtend.class.getSimpleName())) {
                sql = "select * from hzg_finance_purchasesubject_extend";
            } else {
                sql = "SELECT * FROM hzg_finance_subject s  WHERE id IN (SELECT MIN(id) FROM hzg_finance_subject ss WHERE s.`categoryId`=ss.`categoryId`) ORDER BY id";
            }
            objects = queryBySql(sql, clazz);

        }

        return objects;
    }

    public Map<String, List<Object>> queryBySql(String sql, Class[] clazzs) {
        Map<String, List<Object>> result = new HashMap<>();

        int startPosition = 0;
        List<Object[]> values = (List<Object[]>) sessionFactory.getCurrentSession().createSQLQuery(sql).list();
        for (Class clazz : clazzs) {
            result.put(clazz.getName(), getValues(values, clazz, startPosition));

            startPosition += getColumnNum(clazz);
        }

        return result;
    }

    public List<Object> getValues(List<Object[]> values, Class clazz, int startPosition) {
        List<Object> objects = new ArrayList<>();

        // 设置对象
        Object obj = null;
        for (Object[] value : values) {
            try {
                obj = clazz.newInstance();
            } catch (Exception e) {
                e.printStackTrace();
            }

            objects.add(setObjectValue(obj, value, startPosition));
        }

        return objects;
    }

    public int getColumnNum(Class clazz) {
        int num = 0;

        Field[] fields = clazz.getDeclaredFields();
        for (Field field : fields) {
            if (field.isAnnotationPresent(Column.class) ||
                    field.isAnnotationPresent(JoinColumn.class)){
                num++;
            }
        }

        return num;
    }

    public Object setObjectValue(Object object, Object[] values, int startPosition) {

        Field[] fields = object.getClass().getDeclaredFields();
        for (Field field : fields) {

            if (values[startPosition] != null) {
                boolean isSet = setFieldValue(field, values[startPosition], object);
                if (isSet) startPosition++;

            } else {
                startPosition++;
            }

            if (startPosition > values.length -1) {
                break;
            }

        }

        return object;
    }

    public String[] getSqlPart(String sql, Class clazz){
        String[] sqlPartArr = new String[4];

        String[] sqlParts = sql.split(" from ");
        sqlPartArr[0] = getSelectColumns("t", clazz);
        String[] sqlParts1 = sqlParts[1].split(" where ");

        sqlPartArr[1] = sqlParts1[0];
        if (sqlParts1.length == 2) {
            String parts[] = sqlParts1[1].split(" order by ");

            sqlPartArr[2] = parts[0];
            if (parts.length == 2) {
                sqlPartArr[3] = parts[1];
            }
        } else {
            String parts[] = sqlParts1[0].split(" order by ");

            sqlPartArr[1] = parts[0];
            sqlPartArr[2] = "";
            if (parts.length == 2) {
                sqlPartArr[3] = parts[1];
            }
        }

        return sqlPartArr;
    }

    public String getSelectColumns(String abbrTableName, Class clazz) {
        String selectColumns = "";

        Field[] fields = clazz.getDeclaredFields();
        for (Field field : fields) {
            String column = null;
            if (field.isAnnotationPresent(Column.class)){
                column = field.getAnnotation(Column.class).name();

            } else if (field.isAnnotationPresent(JoinColumn.class)){
                column = field.getAnnotation(JoinColumn.class).name();
            }

            if (column != null) {
                selectColumns += abbrTableName + "." + column + " as " + abbrTableName + column + ", ";
            }
        }

        int length = selectColumns.length();
        return length > 0 ? selectColumns.substring(0, length-", ".length()) : selectColumns;
    }

}
