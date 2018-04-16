package com.imooc.io;

import java.io.File;
import java.io.IOException;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: IoUtilTest3.java
 * 类的详细说明
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2018/4/10
 */
public class IoUtilTest3 {
    public static void main(String[] args) {
        IoUtils ioUtils = new IoUtils();
        try {
            ioUtils.copyFile(new File("d:/javaio/demo.txt"),new File("d:/javaio/demo1.txt"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}