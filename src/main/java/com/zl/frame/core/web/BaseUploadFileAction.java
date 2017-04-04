package com.zl.frame.core.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @desc：文件上传Action封装
 * @author lixin
 * @date: 2013-11-19上午11:50:55
 */
public class BaseUploadFileAction extends BaseAction {

	private static final long serialVersionUID = -935875408998443270L;
  
    public static final int BUFFER_SIZE=16*1024;   
    // 用File数组来封装多个上传文件域对象   
    public File[] upload;   
    // 用String数组来封装多个上传文件名   
    public String[] uploadFileName;   
    // 用String数组来封装多个上传文件类型   
    public String[] uploadContentType;   
    // 保存文件的目录路径(通过依赖注入)   
    public String savePath="";   
    
    public BaseUploadFileAction(){
    	savePath="\\uploadFile";	
    }

	/**
	 * 文件复制
	 * @param File src
	 * @param File dst
	 * @param BUFFER_SIZE
	 * @return
	 */
	public boolean copy(File src, File dst,int BUFFER_SIZE) {
		
        boolean result = false;   
        InputStream in = null;   
        OutputStream out = null;   
        try {   
            in = new BufferedInputStream(new FileInputStream(src), BUFFER_SIZE);
            out = new BufferedOutputStream(new FileOutputStream(dst), BUFFER_SIZE);   
            byte[] buffer = new byte[BUFFER_SIZE];
            int len = 0;
            while ((len = in.read(buffer)) > 0) {
                out.write(buffer, 0, len);   
            }   
            result = true;   
        } catch (Exception e) {
            e.printStackTrace();
            result = false;
        } finally {
            if (null != in) {
                try {
                    in.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (null != out) {   
                try {   
                    out.close();   
                } catch (IOException e) {   
                    e.printStackTrace();   
                }   
            }   
        }   
        return result;   
    }   
	
	
	/**
	 * 上传文件方法
	 * @param path
	 * @param isFullPath
	 * @return
	 * @throws IOException
	 */
	public List<String> uploadFile(String path,boolean isFullPath) throws IOException{
		  
		  List<String> successFileList=new ArrayList<String>();   
          // 处理每个要上传的文件   
          for (int i = 0; i < upload.length; i++) {
        	  
              // 根据服务器的文件保存地址和原文件名创建目录文件全路径  
        	  String srcFilesInfo = uploadFileName[i].toString();
        	  
        	  //取得文件的后缀
        	  String FileExtensions = srcFilesInfo.substring(srcFilesInfo.lastIndexOf("."), srcFilesInfo.length());
        	  String fileName = new Date().getTime() + i + FileExtensions;
              String dstPath = getRealyPath(path) + "\\"+fileName;  
              
              File dstFile = new File(dstPath);
              
              if(copy(upload[i], dstFile,BUFFER_SIZE)){   
            	  if(isFullPath){
            		  successFileList.add(path+fileName);  
            	  }else{
            		  successFileList.add(fileName);
            	  }
              }  
              if(successFileList.size()<1){
            	  throw new IOException();
              }
          } 
          return successFileList;
	  }
	  
	/**
	 * 批量上传
	 * @param path
	 * @return
	 * @throws IOException
	 */
	public List<String> uploadFile(String path) throws IOException{
		  return uploadFile(path,false);
	  }
	  
	/**
	 * 取得路径中的文件名
	 * @param path
	 * @return
	 */
	public List<String> getFileNames(String path){
		 
		  File file=new File(getRealyPath(path));
		  List<String> resultList=new ArrayList<String>();
		  File[] files= file.listFiles();
		  
		  for (File tempFile : files) {
			if(tempFile.isFile()){
				resultList.add(tempFile.getName());	
			}
		}
		  return resultList;
	  }
	  
	/**
	 * 建立文件夹
	 * @param path
	 */
	public void createFold(String path){
	    	try{
	    		path=getRealyPath(path);
		    	File folder = new File(path); 
				if(!folder.exists()){
					folder.mkdirs();
				}
	    	}catch (Exception e) {
				e.printStackTrace();
			}
	    }
	  
	public File[] getUpload() {
		return upload;
	}

	public void setUpload(File[] upload) {
		this.upload = upload;
	}

	public String[] getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String[] uploadFileName) {
		this.uploadFileName = uploadFileName;
	}

	public String[] getUploadContentType() {
		return uploadContentType;
	}

	public void setUploadContentType(String[] uploadContentType) {
		this.uploadContentType = uploadContentType;
	}

	public String getSavePath() {
		return savePath;
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}

	public static int getBUFFER_SIZE() {
		return BUFFER_SIZE;
	}   
}  
