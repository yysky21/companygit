package com.imooc.io;

import java.io.File;
import java.io.IOException;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: FileUtils.java
 * 类的详细说明
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2018/4/9
 */
// 列出File的一些常用操作，比如过滤、遍历等操作
public class FileUtils {
    /**
     *列出指定目录下（包括其子目录)下的所有文件
     * @param dir
     * @throws IOException
     */
    public static void listDirectory(File dir) throws IOException{
        if (!dir.exists()){
            throw new IllegalArgumentException("目录" + dir + "不存在");
        }
        if (!dir.isDirectory()){
            throw new IllegalArgumentException(dir + "不是目录");
        }
        String[] fileNames = dir.list(); // 返回的是字符串数组，是直接子的名称，不包含子目录下的内容
        for (String fileName:fileNames) {
            System.out.println(dir + "/" + fileName);
        }
        // 如果要遍历子目录下的内容，就需要构造File对象做递归操作，File提供了直接返回File对象的API
        File[] files = dir.listFiles(); // 返回的是直接子目录（文件）的抽象
        if (files != null && files.length > 0){
            for (File file : files){
                if (file.isDirectory()){
                    // 递归
                    listDirectory(file);
                } else {
                    System.out.println(file);
                }
            }
        }
    }
}