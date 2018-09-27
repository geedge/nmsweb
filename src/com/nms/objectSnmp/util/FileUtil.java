package com.nms.objectSnmp.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import nis.nms.util.BaseAction;
import nis.nms.util.Constant;

import org.apache.log4j.Logger;



public class FileUtil{
	private static Logger logger = Logger.getLogger(FileUtil.class);
	public boolean checkFile(String javaFilePath,String javaEntityName){
		File file = new File(javaFilePath+"/"+javaEntityName+".java");
		if(file.exists()){
			return true;//已生成javaBean
		}else{
			return false;	
		}
	}
	
	public List<String> getAllMibFileNames() throws Exception{
		//List<String> fileNames = new List<String>();
		List<String> fileNames = new ArrayList<String>();
		String errMsg="";
		try {
			//先加载全局Mib再加载私有的
			Class cla = this.getClass();
			ClassLoader classLoader = cla.getClassLoader();
			URL url  = classLoader.getResource("/mibs");
			java.net.URI uri = url.toURI();
			File files = new File(uri);
			File[] fs = files.listFiles();
			if(fs.length>0){
				for(int i=0;i<fs.length;i++){
					File fi = new File(fs[i].toString());
					if(fi.isDirectory()){//如果是文件夹
						continue;
					}
					fileNames.add(fi.getName());
				}
				//导入的私有Mib
				url = classLoader.getResource("/mibs/iana");
				if(url != null){
					java.net.URI urisub = url.toURI();
					File subfiles = new File(urisub);
					if(subfiles !=null){
						File[] subfilesArr = subfiles.listFiles();
						if(subfilesArr.length>0){
							for(int j=0;j<subfilesArr.length;j++){
								File fisub = new File(subfilesArr[j].toString());
								fileNames.add(fisub.getName());
							}
						}
					}
				}
			}else{
				errMsg="i18n_FileUtil.getAllMibFileNames.noMibFile_n81i";
				throw new Exception();
			}
		} catch (Exception e) {
			logger.error("Error to get MIB file name!"+e.getStackTrace());
			throw new Exception("i18n_FileUtil.getAllMibFileNames.getMibNameErr_n81i"+errMsg);
		}
		return fileNames;
	}
	
	public void createClass(String javaBeanName) throws Exception{
		try {
			if(javaBeanName!=null && !"".equals(javaBeanName)){
				File file1 = new File(Constant.CLASS_DIR_PATH);
				if(!file1.exists()){//如果路径不存在 则创建
					file1.mkdirs();
				}
				
				File file = new File(Constant.JAVABEAN_PATH+javaBeanName+".java");
				if(file.exists()){
					URL url  = this.getClass().getClassLoader().getResource("../lib/snmp/zhtelecombasis.jar");
					java.net.URI uri = url.toURI();
					File fileJar =new File(uri);
					if(fileJar.exists()){
						String jarpath = fileJar.getPath();
						jarpath = "\""+jarpath+"\"";
						StringBuilder sb = new StringBuilder("javac -classpath ");
						sb.append(jarpath+" ");
						sb.append("\""+Constant.JAVABEAN_PATH);
						sb.append(javaBeanName+".java"+"\""+" -d ");
						sb.append("\""+Constant.CLASS_DIR_PATH+"\"");
						String cmd = sb.toString();
						System.out.println(cmd);//路径都用双引括起来---不用管路径中的空格
						
						String os = System.getProperty("os.name");
						if (os.startsWith("Windows")) {
							execWinCmd(cmd);
						} else if (os.startsWith("Linux")) {
							execLinuxCmd(cmd);
						}
						System.out.println("=================执行成功");
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Create class file error!",e);
			throw new Exception("i18n_FileUtil.getAllMibFileNames.createClassErr_n81i");
			
		}
	}
	
	/** 
	 * @param src
	 * 		源文件
	 * @param dst 
	 * 		目标文件
	 * @param bufferSize  缓冲大小 16 * 1024
	 */
	public void copy(File src, File dst, int bufferSize) throws Exception{
		try {
			long start  =  System.currentTimeMillis();
			InputStream in = null;
			OutputStream out = null;
			try {
				in = new BufferedInputStream(new FileInputStream(src),	bufferSize);
				out = new BufferedOutputStream(new FileOutputStream(dst),	bufferSize);
				byte[] buffer = new byte[bufferSize];
				
				
				int length = -1;
				while((length = in.read(buffer)) != -1)
				{
					out.write(buffer, 0, length);
				}
				out.flush();
				System.out.println("上传文件耗时："+(System.currentTimeMillis()-start)+"毫秒！");
			} finally {
				if (null != in) {
					in.close();
				}
				if (null != out) {
					out.close();
				}
			}
		} catch (Exception e) {
			logger.error("上传文件时出错！！！"+e.getStackTrace());
			throw new Exception("上传文件时出错！！！");
		}
	}
	
	public static String execLinuxCmd(String cmd) throws Exception{
		BufferedReader bReader = null;
		BufferedReader errorReader = null;
		Process process = null;
		try {
			logger.info("execLinuxCmd start-------" + cmd);
			String[] shellCmd = new String[] { "/bin/bash", "-c", cmd };
			process = Runtime.getRuntime().exec(shellCmd);
			process.getOutputStream().close();

			bReader = new BufferedReader(new InputStreamReader(process
					.getInputStream()));
			errorReader = new BufferedReader(new InputStreamReader(process
					.getErrorStream()));
			String line = null;
			while ((line = bReader.readLine()) != null) {
				logger.debug("execLinuxCmd line--->" + line);
			}
			StringBuffer errorSb = new StringBuffer();
			while ((line = errorReader.readLine()) != null) {
				logger.debug("execLinuxCmd error line--->" + line);
				errorSb.append(line + ",");
			}

			if (errorSb.toString().length() > 0) {
				return errorSb.toString().substring(0, errorSb.toString().length()-1);
			}

			logger.info("execLinuxCmd end-------" + cmd);
		} catch (Exception e) {
			throw e;
		} finally {
			 try {
				if (bReader != null) {
					bReader.close();
				}
				if (errorReader != null) {
					errorReader.close();
				}
				if (process != null) {
					process.destroy();
				}
			} catch (Exception e1) {
			}
		}
		return null;
	}
	
	public static String execWinCmd(String cmd) throws Exception {
		BufferedReader bReader = null;
		BufferedReader errorReader = null;
		Process process = null;
		try {
			logger.info("execWinCmd start-------" + cmd);
			String[] cmdArr = new String[] { "cmd.exe", "/C", cmd };
			process = Runtime.getRuntime().exec(cmdArr);
			if (cmd.endsWith(".exe")) {
				synchronized (process) {
					process.wait(1000 * 5);
				}
			} else {
				process.getOutputStream().close();
				bReader = new BufferedReader(new InputStreamReader(process
						.getInputStream()));
				errorReader = new BufferedReader(new InputStreamReader(process
						.getErrorStream()));
				String line = null;
				while ((line = bReader.readLine()) != null) {
					logger.debug("execWinCmd line--->" + line);
				}
				StringBuffer errorSb = new StringBuffer();
				while ((line = errorReader.readLine()) != null) {
					logger.debug("execWinCmd error--->" + line);
					errorSb.append(line + ",");
				}
				if (errorSb.toString().length() > 0) {
					return errorSb.toString().substring(0,
							errorSb.toString().length() - 1);
				}
			}
			
			logger.info("execWinCmd end-------" + cmd);

		} catch (Exception e) {
			throw e;
		} finally {
			 try {
				if (bReader != null) {
					bReader.close();
				}
				if (errorReader != null) {
					errorReader.close();
				}
				if (process != null) {
					process.destroy();
				}
			} catch (Exception e1) {
			}
		}
		
		return null;
	}
	 /**
	 * 删除文件
	 */
	public static void delDir(File file) throws IOException {
		if (file.exists() ) {
			if (!file.isDirectory()) {
				file.delete();
				logger.debug("FileUtil.delDir(File file)删除文件--" + file.getAbsolutePath());
			} 
		}
	}
}
