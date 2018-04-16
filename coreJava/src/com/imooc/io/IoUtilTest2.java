package com.imooc.io;

import java.io.IOException;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: IoUtilTest2.java
 * 类的详细说明
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2018/4/10
 */
public class IoUtilTest2 {
    public static void main(String[] args) {
        IoUtils ioUtils = new IoUtils();
        try {
            ioUtils.printHexByByteArray("d:/javaio/FileUtils.java");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}