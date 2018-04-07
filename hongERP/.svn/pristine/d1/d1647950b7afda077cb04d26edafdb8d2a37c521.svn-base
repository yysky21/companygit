package com.hzg.tools;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

/**
 * Created by Administrator on 2017/3/16.
 */
@Component
public class Writer {

    static Logger logger = Logger.getLogger(Writer.class);

    public Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();


    /**
     * 输出 text
     * @param response
     */
    public void write(HttpServletResponse response, String string) {
        logger.info("the string to response:" + string);

        PrintWriter out = null;
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=utf-8");
        try {
            out = response.getWriter();
            out.print(string);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (out != null) {
                out.close();
            }
        }
    }

    /**
     * 输出 byte
     * @param response
     */
    public void writeBytes(HttpServletResponse response, byte[] bytes) {
        logger.info("the bytes to response:" + bytes);

        OutputStream out = null;
        try {
            out = response.getOutputStream();
            out.write(bytes);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (out != null) {
                try {
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                    out = null;
                }
            }
        }
    }

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

        writeStringToJson(response, json);
    }

    /**
     * 以JSON格式输出
     * @param response
     */
    public void writeStringToJsonAccessAllow(HttpServletResponse response, String string) {
        response.setHeader("Access-Control-Allow-Origin", "*");
        writeStringToJson(response, string);
    }

    /**
     * 以JSON格式输出
     * @param response
     */
    public void writeObjectToJsonAccessAllow(HttpServletResponse response, Object object) {
        response.setHeader("Access-Control-Allow-Origin", "*");
        writeStringToJson(response, gson.toJson(object));
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
            e.printStackTrace();
        } finally {
            if (out != null) {
                out.close();
            }
        }
    }

    public void writeHtml(HttpServletResponse response, String string) {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = null;
        try {
            out = response.getWriter();
            out.print(string);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (out != null) {
                out.close();
            }
        }
    }
}
