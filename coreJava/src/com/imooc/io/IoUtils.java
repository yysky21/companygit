package com.imooc.io;

import java.io.*;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: IoUtils.java
 * 类的详细说明
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2018/4/10
 */
public class IoUtils {
    /**
     * 读取指定文件内容，按照16进制输出到控制台
     * 并且每输出10个byte换行
     * @param fileName
     */
    public static void printHex(String fileName) throws IOException{
        // 把文件最为字节流进行读操作
        InputStream in = new FileInputStream(fileName);
        int b ;
        int i = 1;
        while ((b = in.read()) != -1){
            if (b <= 0xf){
                System.out.print("0");
            }
            System.out.print(Integer.toHexString(b & 0xff) + "  ");
            if (i++ % 10 == 0){
                System.out.println();
            }
        }
        in.close();
    }

    public static void printHexByByteArray(String fileName) throws IOException{
        FileInputStream in = new FileInputStream(fileName);
        byte[] buf = new byte[20*1024];
        /*从in中批量读取字节，放入到bytes这个字节数组中
        从0这个位置开始放，最多放bytes.length个
        返回的是读到的字节个数*/
        /*int j = 1;
        int bytes = in.read(buf,0,buf.length); // 一次性读完，说明字节数组足够大
        for (int i = 0;i < bytes;i++){
            if (buf[i] <= 0xf){
                System.out.print("0");
            }
            System.out.print(Integer.toHexString(buf[i] & 0xff) + "  ");
            if (j++ % 10 == 0){
                System.out.println();
            }
        }*/
        int bytes = 0;
        int j = 1;
        while ((bytes = in.read(buf,0,buf.length)) != -1){
            for (int i = 0;i < bytes;i++){
                if (buf[i] <= 0xf){
                    System.out.print("0");
                }
                System.out.print(Integer.toHexString(buf[i] & 0xff) + "  ");
                if (j++ % 10 == 0){
                    System.out.println();
                }
            }
        }
        in.close();
    }

    public static void copyFile (File srcFile, File destFile) throws IOException{
        if (!srcFile.exists()){
            throw new IllegalArgumentException("文件" + srcFile + "不存在");
        }
        if (!srcFile.isFile()){
            throw new IllegalArgumentException(srcFile + "不是文件");
        }
        FileInputStream in = new FileInputStream(srcFile);
        FileOutputStream out = new FileOutputStream(destFile,true);
        byte[] buf = new byte[2 * 1024];
        int b = 0;
        while ((b = in.read(buf,0,buf.length)) != -1){
            out.write(buf,0,b);
            out.flush();
        }
        out.close();
        in.close();
    }
}