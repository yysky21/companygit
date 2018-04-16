package com.imooc.io;

import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.util.Arrays;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: RafDemo.java
 * 类的详细说明
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2018/4/10
 */
public class RafDemo {

    public static void main(String[] args) throws IOException {
        File demo = new File("demo");
        if (!demo.exists()){
            demo.mkdir();
        }
        File file = new File(demo,"raf.dat");
        if (!file.exists()){
            file.createNewFile();
        }
        RandomAccessFile raf = new RandomAccessFile(file,"rw");
        System.out.println(raf.getFilePointer());
        raf.write('A');
        System.out.println(raf.getFilePointer());
        raf.write('B');
        System.out.println(raf.getFilePointer());
        int i = 0x7fffffff;
        // 用write方法写，每次只能写一个字节，如果要把i写进去就的写4次
        raf.write(i >>>24);
        raf.write(i >>>16);
        raf.write(i>>>8);
        raf.write(i);
        System.out.println(raf.getFilePointer());
        // 可以直接写一个int
        raf.writeInt(i);
        String s = "中";
        byte[] bytes = s.getBytes("gbk");
        raf.write(bytes);
        //System.out.println(raf.getFilePointer());
        System.out.println(raf.length());
        // 读文件，必须把指针移到头
        raf.seek(0);
        // 一次性读取，吧文件中的内容都读到字节数组中
        byte[] buf = new byte[(int)raf.length()];
        raf.read(buf);
        System.out.println(Arrays.toString(buf));
        for (byte b : buf){
            System.out.println(Integer.toHexString(b & 0xff));
        }
        raf.close();
    }
}