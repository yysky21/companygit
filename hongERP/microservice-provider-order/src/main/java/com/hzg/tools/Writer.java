package com.hzg.tools;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.util.Map;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: Writer.java
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/3/16
 */
@Component
public class Writer {

    static Logger logger = Logger.getLogger(Writer.class);

    public Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

    /**
     * 以JSON格式输出
     * @param response
     */
    public void writeObjectToJson(HttpServletResponse response, Object object) {
        String json;
        if (object != null) {
            json = gson.toJson(object);
        } else {
            json = "{}";
        }

        if (json.contains("\"password\"")) {
            json = json.replaceAll("\"password\":\"\\w*\"", "\"password\":\"\"");
        }
        writeStringToJson(response, json);
    }

    public void writeStringToJson(HttpServletResponse response, String string) {
        logger.info("the string to response:" + string);

        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=utf-8");
        PrintWriter out = null;
        try {
            out = response.getWriter();
            out.print(string);
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
        } finally {
            if (out != null) {
                out.close();
            }
        }
    }

    public void write(HttpServletResponse response, String string) {
        logger.info("the string to response:" + string);

        PrintWriter out = null;
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=utf-8");
        try {
            out = response.getWriter();
            out.print(string);
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
        } finally {
            if (out != null) {
                out.close();
            }
        }
    }

    public Type stringMapType =  new TypeToken<Map<String, String>>(){}.getType();

    public String getResult(String resultJson) {
        return ((Map<String, String>)gson.fromJson(resultJson, stringMapType)).get(CommonConstant.result);
    }
}
