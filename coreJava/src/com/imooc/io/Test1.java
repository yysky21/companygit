package com.imooc.io;

import java.io.File;
import java.io.IOException;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: Test1.java
 * 类的详细说明
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2018/4/9
 */
public class Test1 {

    public static void main(String[] args) throws IOException {
        FileUtils.listDirectory(new File("D:/learngit"));
    }
}