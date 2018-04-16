package com.imooc.io;

import java.io.File;
import java.io.IOException;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: EncodeDemo.java
 * 类的详细说明
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2018/4/9
 */
public class EncodeDemo {

    public static void main(String[] args) {
        // 了解构造函数的几种情况，可以查阅API
        File file = new File("d:/javaio/imooc");
        // File.separator不管是windows系统还是linux系统都能够创建
        //File file1 = new File("d:" + File.separator + "javaio");
        //System.out.println(file.exists());
        if (!file.exists()){
            file.mkdir(); // file.makedirs()创建多级目录
        } else {
            file.delete();
        }
        // 是否是一个目录,如果是目录返回true，如果不是目录或者目录不存在返回false
        System.out.println(file.isDirectory());
        // 是否是一个文件
        System.out.println(file.isFile());

        File file1 = new File("D:/javaio/日记.txt");
        //File file1 = new File("D:/javaio","日记.txt");
        if (!file1.exists()){
            try {
                file1.createNewFile();
            } catch (IOException e) {

            }
        } else {
            file1.delete();
        }
        // 常用的File对象的API
        System.out.println(file); // 相当于file.toString()的内容
        System.out.println(file.getAbsolutePath());
        System.out.println(file.getAbsoluteFile());
        System.out.println(file.getName());
        System.out.println(file1.getName());
        System.out.println(file.getParent());
        System.out.println(file1.getParent());
        System.out.println(file.getParentFile().getAbsolutePath());
    }
}