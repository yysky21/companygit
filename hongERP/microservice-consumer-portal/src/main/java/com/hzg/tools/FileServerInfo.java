package com.hzg.tools;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: FileServerInfo.java
 * 类的详细说明
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/6/16
 */
@Component
@ConfigurationProperties("fileServerInfo")
public class FileServerInfo {
    public static String uploadFilesUrl;

    public static String uploadDirOrFilesUrl;

    public static String imageServerUrl;

    public static String getUploadFilesUrl() {
        return uploadFilesUrl;
    }

    public static void setUploadFilesUrl(String uploadFilesUrl) {
        FileServerInfo.uploadFilesUrl = uploadFilesUrl;
    }

    public static String getUploadDirOrFilesUrl() {
        return uploadDirOrFilesUrl;
    }

    public static void setUploadDirOrFilesUrl(String uploadDirOrFilesUrl) {
        FileServerInfo.uploadDirOrFilesUrl = uploadDirOrFilesUrl;
    }

    public static String getImageServerUrl() {
        return imageServerUrl;
    }

    public static void setImageServerUrl(String imageServerUrl) {
        FileServerInfo.imageServerUrl = imageServerUrl;
    }
}
