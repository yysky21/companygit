package com.hzg.erp;

import com.hzg.sys.Article;
import com.hzg.sys.User;
import com.hzg.tools.*;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.log4j.Logger;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: DataTransformController.java
 *
 * @author smjie
 * @version 1.00
 * @Date 2018/5/8
 */
@Controller
@RequestMapping("/dataTransform")
public class DataTransformController {

    Logger logger = Logger.getLogger(DataTransformController.class);

    @Autowired
    private Writer writer;

    @Autowired
    private DataTransformService dataTransformService;

    @Autowired
    private  StrUtil strUtil;

    @Autowired
    public SessionFactory sessionFactory;

    /**
     * 保存实体
     * @param response
     * @param entity
     */
    @GetMapping("/importData/{entity}")
    public void importData(HttpServletResponse response, @PathVariable("entity") String entity){
        logger.info("importData start, parameter:" + entity);

        String failIds = "";

        int position = 0, rowNum = 300, num = 0;
        Integer  id = -1;
        String sql = null;
        List<Object[]> values = null;

        if (entity.equalsIgnoreCase(Product.class.getSimpleName())) {
            sql = "SELECT t.* FROM web_product t where t.product_id > ";
            values = (List<Object[]>) sessionFactory.getCurrentSession().createSQLQuery(sql + id + " order by t.product_id asc limit " + position + "," + rowNum).list();

            while (!values.isEmpty()) {
                for (Object[] objects : values) {
                    failIds += dataTransformService.saveProduct(objects);
                    num++;
                }

                id = strUtil.getIntegerValue(values.get(values.size()-1)[0]);
                values = (List<Object[]>) sessionFactory.getCurrentSession().createSQLQuery(sql + id + " order by t.product_id asc limit " + position + "," + rowNum).list();
            }

        } else if (entity.equalsIgnoreCase(Article.class.getSimpleName())) {
            sql = "SELECT t.* FROM web_article t where t.article_id > ";
            values = (List<Object[]>) sessionFactory.getCurrentSession().createSQLQuery(sql + id + " order by t.article_id asc limit " + position + "," + rowNum).list();

            while (!values.isEmpty()) {
                for (Object[] objects : values) {
                    failIds += dataTransformService.saveArticle(objects);
                    num++;
                }

                id = strUtil.getIntegerValue(values.get(values.size()-1)[0]);
                values = (List<Object[]>) sessionFactory.getCurrentSession().createSQLQuery(sql + id + " order by t.article_id asc limit " + position + "," + rowNum).list();
            }
        }

        writer.writeStringToJson(response, "{\"" + CommonConstant.result + "\":\"" + num + " items insert\", \"fail id\":\"" + failIds + "\"}");
        logger.info("importData end, result:");
    }
}
