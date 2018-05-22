package com.hzg.upload;

import cn.twinkling.stream.config.Configurations;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.ProgressListener;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @from http://www.cnblogs.com/xdp-gacl/p/4200090.html
 * @author: �°�����
 * @date: 2015-1-3 ����11:35:  *
 */
public class UploadCKEditorFileServlet extends HttpServlet {

    private static long fileSizeMax = 1024*1024;
    private static long sizeMax = 1024*1024*10;

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //��Ϣ��ʾ
        String message = "";
        String filePath = "";

        //�õ��ϴ��ļ��ı���Ŀ¼�����ϴ����ļ������WEB-INFĿ¼�£����������ֱ�ӷ��ʣ���֤�ϴ��ļ��İ�ȫ
        String baseDir = Configurations.getFileRepository();
        //�ϴ�ʱ���ɵ���ʱ�ļ�����Ŀ¼
        String tempPath = Configurations.getTempRepository();

        File tmpFile = new File(tempPath);
        if (!tmpFile.exists()) {
            //������ʱĿ¼
            tmpFile.mkdirs();
        }

        try{
            //ʹ��Apache�ļ��ϴ���������ļ��ϴ����裺
            //1������һ��DiskFileItemFactory����
            DiskFileItemFactory factory = new DiskFileItemFactory();
            //���ù����Ļ������Ĵ�С�����ϴ����ļ���С�����������Ĵ�Сʱ���ͻ�����һ����ʱ�ļ���ŵ�ָ������ʱĿ¼���С�
            factory.setSizeThreshold(1024*100);//���û������Ĵ�СΪ100KB�������ָ������ô�������Ĵ�СĬ����10KB
            //�����ϴ�ʱ���ɵ���ʱ�ļ��ı���Ŀ¼
            factory.setRepository(tmpFile);

            //2������һ���ļ��ϴ�������
            ServletFileUpload upload = new ServletFileUpload(factory);
            //�����ļ��ϴ�����
            upload.setProgressListener(new ProgressListener(){
                public void update(long pBytesRead, long pContentLength, int arg2) {}
            });

             //����ϴ��ļ�������������
            upload.setHeaderEncoding("UTF-8");
            //3���ж��ύ�����������Ƿ����ϴ���������
            if(!ServletFileUpload.isMultipartContent(request)){
                //���մ�ͳ��ʽ��ȡ����
                return;
            }

           //�����ϴ������ļ��Ĵ�С�����ֵ��Ŀǰ������Ϊ1024*1024�ֽڣ�Ҳ����1MB
            upload.setFileSizeMax(fileSizeMax);
            //�����ϴ��ļ����������ֵ�����ֵ=ͬʱ�ϴ��Ķ���ļ��Ĵ�С�����ֵ�ĺͣ�Ŀǰ����Ϊ10MB
            upload.setSizeMax(sizeMax);
            //4��ʹ��ServletFileUpload�����������ϴ����ݣ�����������ص���һ��List<FileItem>���ϣ�ÿһ��FileItem��Ӧһ��Form����������
            List<FileItem> list = upload.parseRequest(request);

            Map uploadInfo = new HashMap();
            for(FileItem item : list) {
                //���fileitem�з�װ������ͨ�����������
                if (item.isFormField()) {
                    String name = item.getFieldName();
                    //�����ͨ����������ݵ�������������
                    String value = item.getString("UTF-8");
                    uploadInfo.put(name, value);

                    System.out.println(name + "=" + value);

                }
            }

            for(FileItem item : list){
                if(!item.isFormField()){
                    //���fileitem�з�װ�����ϴ��ļ�
                    //�õ��ϴ����ļ����ƣ�
                    String filename = item.getName();
                    System.out.println(filename);
                    if(filename==null || filename.trim().equals("")){
                            continue;
                     }

                    //ע�⣺��ͬ��������ύ���ļ����ǲ�һ���ģ���Щ������ύ�������ļ����Ǵ���·���ģ��磺  c:\a\b\1.txt������Щֻ�ǵ������ļ������磺1.txt
                    //�����ȡ�����ϴ��ļ����ļ�����·�����֣�ֻ�����ļ�������
                    filename = filename.substring(filename.lastIndexOf(File.separator)+1);
                    //�õ��ϴ��ļ�����չ��
                    String fileExtName = filename.substring(filename.lastIndexOf(".")+1);
                    //�����Ҫ�����ϴ����ļ����ͣ���ô����ͨ���ļ�����չ�����ж��ϴ����ļ������Ƿ�Ϸ�
                    System.out.println("�ϴ����ļ�����չ���ǣ�"+fileExtName);
                    //��ȡitem�е��ϴ��ļ���������
                    InputStream in = item.getInputStream();
                    //�õ��ļ���������Ƽ�·��
                    String saveFilename = uploadInfo.get("name") == null ? filename : uploadInfo.get("name").toString() + "." + fileExtName;
                    String dateStr = sdf.format(new Date());
                    String timeStr = new SimpleDateFormat("HHmmss").format(new Date());
                    String childDir = dateStr+"/article/"+timeStr;
                    String osChildDir = childDir.replace("/", File.separator);

                    //�õ��ļ��ı���Ŀ¼
                    String realSavePath = getDir(baseDir, osChildDir);
                    filePath = realSavePath + File.separator + saveFilename;

                    File saveFile = new File(filePath);
                    if (saveFile.exists()) {
                        saveFile.delete();
                    }

                    //����һ���ļ������
                    FileOutputStream out = new FileOutputStream(filePath);
                    //����һ��������
                    byte buffer[] = new byte[1024];

                    //�ж��������е������Ƿ��Ѿ�����ı�ʶ
                    int len = 0;
                    //ѭ�������������뵽���������У�(len=in.read(buffer))>0�ͱ�ʾin���滹������
                    while((len=in.read(buffer))>0){
                        //ʹ��FileOutputStream�������������������д�뵽ָ����Ŀ¼(savePath + "\\" + filename)����
                        out.write(buffer, 0, len);
                    }
                    //�ر�������
                    in.close();
                    //�ر������
                    out.close();

                    //ɾ�������ļ��ϴ�ʱ���ɵ���ʱ�ļ�
                    item.delete();
                    message = "";
                }
            }

         }catch (FileUploadBase.FileSizeLimitExceededException e) {
            e.printStackTrace();
            message = "�����ļ��������ֵ:" + fileSizeMax/(1024*1024) + "M";

        }catch (FileUploadBase.SizeLimitExceededException e) {
            e.printStackTrace();
            message = "�ϴ��ļ����ܵĴ�С�������Ƶ����ֵ:" + sizeMax/(1024*1024) + "M";

        }catch (Exception e) {
            e.printStackTrace();
            message= "upload file fail";
        }

        response.sendRedirect(Configurations.getConfig("ckeditorUpload_CROSS_ORIGIN")+"?imageUrl="+ Configurations.getConfig("imageServerUrl") + "/" + filePath.replace(baseDir+File.separator, "").replace(File.separator, "/") + "&message=" + message + "&CKEditorFuncNum=" + request.getParameter("CKEditorFuncNum"));
    }

    /**
     * @Method: makeFileName
     * @Description: �����ϴ��ļ����ļ������ļ����ԣ�uuid+"_"+�ļ���ԭʼ����
     * @Anthor:�°�����
     * @param filename �ļ���ԭʼ����
     * @return uuid+"_"+�ļ���ԭʼ����
     */
    private String makeFileName(String filename){  //2.jpg
        //Ϊ��ֹ�ļ����ǵ���������ҪΪ�ϴ��ļ�����һ��Ψһ���ļ���
        return UUID.randomUUID().toString() + "_" + filename;
    }

    /**
     * Ϊ��ֹһ��Ŀ¼�������̫���ļ���Ҫʹ��hash�㷨��ɢ�洢
     * @Method: makePath
     * @Description:
     * @Anthor:�°�����
     *
     * @param filename �ļ�����Ҫ�����ļ������ɴ洢Ŀ¼
     * @param savePath �ļ��洢·��
     * @return �µĴ洢Ŀ¼
     */
    private String makePath(String filename,String savePath){
        //�õ��ļ�����hashCode��ֵ���õ��ľ���filename����ַ����������ڴ��еĵ�ַ
        int hashcode = filename.hashCode();
        int dir1 = hashcode&0xf;  //0--15
        int dir2 = (hashcode&0xf0)>>4;  //0-15
        //�����µı���Ŀ¼
        String dir = savePath + File.separator + dir1 + File.separator + dir2;  //upload\2\3  upload\3\5
        //File�ȿ��Դ����ļ�Ҳ���Դ���Ŀ¼
        File file = new File(dir);
        //���Ŀ¼������
        if(!file.exists()){
            //����Ŀ¼
            file.mkdirs();
        }
        return dir;
    }

    private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");


    /**
     *
     * @param parentDir ���ļ���
     * @param childDir ���ļ���
     * @return
     */
    private String getDir(String parentDir, String childDir){
        String path = null;
        if (childDir != null) {
            path = parentDir + File.separator + childDir;
        } else {
            path = parentDir + File.separator + sdf.format(new Date());
        }
        return mkDirs(path);
    }

    private String mkDirs(String dir) {
        File file = new File(dir);
        //���Ŀ¼������
        if(!file.exists()){
            //����Ŀ¼
            file.mkdirs();
        }
        return dir;
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}