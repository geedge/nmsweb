package com.nms.thread.utils.ssl;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.Socket;
import java.net.URL;
import java.security.KeyManagementException;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.UnrecoverableKeyException;
import java.security.cert.CertificateException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.LinkedList;
import java.util.List;

import javax.net.ssl.KeyManagerFactory;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManagerFactory;

import nis.nms.util.BaseAction;
import nis.nms.util.BufferedRandomAccessFile;
import nis.nms.util.MD5Util;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.socket.utils.FileComment;

/**
 * 	SSL 通讯 工具类
 *  @date Feb 29, 2012 10:05:50 AM
 *	@author ZhangGang
 *
 */
public abstract class SocketUtils{

	//文件传输 临时文件命名后缀
	private static final String TEMP_SUFFIX = ".tp";
	
	//SSLContext 重置标识
	private static boolean resetSSLContextFlag = false; 
	//通讯编码方式
	private static final String DEFAULT_ENCODING = "utf-8"; 
	
	//公有密匙库	存放公钥（与其他主机加密通讯对应的密匙）
	private static final String SERVER_TRUST = BaseAction.rb.getString("common.ssl.ts"); //System.getProperty("user.dir")+File.separator+"src\\conf\\ssl" + File.separator + "client_ts";
	
	//私有密匙库	存放私钥(向其他主机发布信息的使用的加密密匙)
	private static final String SERVER_STORE = BaseAction.rb.getString("common.ssl.ks"); //System.getProperty("user.dir")+File.separator+"src\\conf\\ssl" + File.separator + "client_ks";
	
	//密匙库 类型 
	private static final String KEYSTORE_TYPE = "jceks";
	
	//私有密匙库 密码
	private static final String SERVER_STORE_PSW = "client";
	
	//公有密匙库 密码
	private static final String SERVER_TRUST_PSW = "client";
	
	//私有密匙 密码
	private static final String SERVER_KEY_PSW = "123456";
	
	//加密上下位 类型
	private static final String SSL_CONTEXT_TYPE = "TLS";
	
	//日志组件对象
	protected static Logger logger = Logger.getLogger(SocketUtils.class);
	
	//Socket 通讯
	protected Socket socket = null;		//Socket
	
	//字节输出流
	protected OutputStream out = null;
	
	//字节输入流
	protected InputStream in = null;		//读取字符流
	
	//通讯目标主机IP
	protected String ip = null;
	
	//通讯目标主机端口
	protected Integer port = null ;
	
	//SSL通讯上下文对象
	protected static SSLContext sSLContext = getSSLContext();
	
	//缓存字节长度
	protected static final int BUFF_SIZE = 1024;
	
	/**
	 * 通讯正常标识
	 */
	protected static final String SUCCESS ="success";		//通信操作正常

	/**
	 * 通讯异常或终止标识
	 */
	protected static final String FAIL ="fail";			//通信操作异常或终止
	
    /**
     * 通讯创建
	 * @param ip		目标主机IP
	 * @param port		目标主机端口
	 * @throws Exception
	 */
	public SocketUtils(String ip,Integer port){
		logger.info("客户端通讯建立 TO:> "+ip);
		this.ip = ip;
		this.port = port;
	}
	
    /**
     * 通讯创建
     * @param client	目标通讯实例
	 */
    public SocketUtils(Socket client) {
    	socket = client;
    	logger.info("服务端通讯建立 From:> "+socket.getInetAddress().getHostAddress());
    }
    
    /**
	 * 字符流 接收信息
	 **/
	protected void sendMessage(String msg) throws UnsupportedEncodingException {
		
		PrintWriter pw = new PrintWriter(new OutputStreamWriter(out,DEFAULT_ENCODING));
		pw.println(msg);
		pw.flush();
		
	}
	
	/**
	 * 字符流 发送信息
	 */
	protected String receiveMessage()throws UnsupportedEncodingException ,IOException{
		
		BufferedReader br = new BufferedReader(new InputStreamReader(in,DEFAULT_ENCODING));
		return br.readLine();
		
	}
	
	/**
	 * Object 形式 发送信息
	 */
	protected void sendObject(Object object) throws IOException{

		ObjectOutputStream oos  = new ObjectOutputStream(out);
		oos.writeObject(object);
		oos.flush();

	}
	
	/**
	 * Object 形式 接收信息
	 */
	protected Object receiveObject() throws ClassNotFoundException,IOException{
		
		ObjectInputStream ois = new ObjectInputStream(in);
		return ois.readObject();
	}
	
	/**
	 * 字节流 发送单个文件
	 **/
	public void sendFile(File file) throws IOException{
		
		if(file==null ||file.length()==0){
			return;
		}
		
		FileInputStream fis = null;
		
		try {
			
			//发送文件大小
			sendMessage(file.length() + "");
			
			//发送文件内容
			int len;
			byte[] buff = new byte[BUFF_SIZE];
			fis = new FileInputStream(file);
			
			while ((len = fis.read(buff)) != -1) {
				
				//将读取的内容写入文件
				out.write(buff, 0, len);
				
			}
			
			out.flush();
//		} catch (IOException e) {
//			logger.error("单个发送文件失败！\n"+ExceptionPrintUtils.printExceptionStack(e));
		} finally{
			if(fis!=null){
				//try {
					fis.close();
					fis=null;
			//} catch (IOException e) {
					//logger.error("",e);
				//}
			}
		}
	}
	
	
	
	/**
	 * 字节流 接收单个文件 并保存
	 */
	protected void receiveFile(String filePath) throws IOException{
		
		FileOutputStream fos = null;

		File file = new File(filePath); 
		if(!file.getParentFile().exists()){
			file.getParentFile().mkdirs();
		}
		
		if(!file.exists()){
			file.createNewFile();
		}
		
		try {
			
			//接收文件大小 
			long fileSize = Long.parseLong(receiveMessage());
			
			//接收文件内容
			byte[] buff = new byte[BUFF_SIZE];
			fos = new FileOutputStream(filePath);
			int nRead = 0;			
			
			//单个文件循环读取
			rfile:while ((nRead = in.read(buff, 0, (int)(BUFF_SIZE<fileSize?BUFF_SIZE:fileSize))) > 0) {
				fos.write(buff,0,nRead);
				fos.flush();
				fileSize -= nRead;
				if(fileSize<=0){
					break rfile;
				}
			}
			fos.close();

//		} catch (IOException e) {
//			logger.error("接收文件失败！",e);
		}finally{
			if(fos!=null){
				//try {
					fos.close();
					fos = null;
				//} catch (IOException e) {
				//	logger.error("",e);
				//}
			}
		}
	}
	
	/**
	 * 字节流接收文件，文件已临时命名形式接收 （已废弃）
	 * (DC未使用)
	 */
	protected TempFile receiveTempFile(String filePath) {
		ObjectInputStream ois = null;
		FileOutputStream fos = null;
		TempFile tempFile = new TempFile();
		try {
			ois = new ObjectInputStream(in);
			String[] fileInfo = (String[])ois.readObject();
			//接收文件大小 
			long fileSize = Long.parseLong(fileInfo[0]);
			tempFile.setFileName(fileInfo[1]);
			String tempName = addTimeTagForFileName("temp.tmp",false);
//			int buffSize = 1024;
//			int counts = (int) ((fileSize % BUFF_SIZE==0)?(fileSize / BUFF_SIZE):(fileSize / BUFF_SIZE + 1));
			//接收文件内容 
			byte[] buff = new byte[BUFF_SIZE];
//			int len = 0;
			fos = new FileOutputStream(filePath+File.separator+tempName);
			int nRead = 0;			
			
			//单个文件循环读取
			rfile:while ((nRead = in.read(buff, 0, (int)(BUFF_SIZE<fileSize?BUFF_SIZE:fileSize))) > 0) {
				fos.write(buff,0,nRead);
				fos.flush();
				fileSize -= nRead;
				if(fileSize<=0){
					break rfile;
				}
			}
			fos.close();
			
			
			/*for (int i = 0; i < counts; i++) {
				len = inl.read(buff);
				//读联欢数据               
				if (len == 1 && buff[0] == TranTool.DATA_END)//数据结束标志
					break;
				//将读取的内容写入文件
				fos.write(buff, 0, len);
				fos.flush();
			}
			fos.close();*/
			File file0 = new File(filePath+File.separator+tempName);
			tempName = addTimeTagForFileName("temp.ok",false);
			File file = new File(filePath+File.separator+tempName);
//			file0.renameTo(file);
			FileUtils.copyFile(file0, file);	//将临时文件名改为正式文件名，即去掉.tp后缀
			file0.delete();
			tempFile.setFile(file);
		} catch (IOException e) {
			logger.error("Fail to recive file!",e);
		} catch (ClassNotFoundException e) {
			logger.error("",e);
		}finally{
			if(fos!=null){
				try {
					fos.close();
				} catch (IOException e) {
					logger.error("",e);
				}
			}
		}
		return tempFile;
	}

	/**
	 * 批量上传文件
	 * @param dir	本地文件集合根目录绝对路径
	 * @param fileList	上传的文件列表
	 * (DC未使用)
	 */
	protected void sendFileByBath(String dir, List<File> fileList) {
		ObjectOutputStream oos = null;
		FileInputStream fis = null;

		try {
			// 第一步发送本地根目录地址（用于地址截取）保证fileList的目录结构完整性
			this.sendMessage(dir);
			String result = this.receiveMessage();
			logger.debug("根目录路径通信状态: " + result);
			// 第二步 用ObjectOutputStream工具类 发送file对象信息 用于文件名，文件目录，文件大小的获取
			oos = new ObjectOutputStream(out);
			List<String[]> fileStrList = new ArrayList<String[]>(); 
			for(File f : fileList){
				String[] tmpArr = new String[]{
						f.getAbsolutePath(), f.length() + ""
				};
				fileStrList.add(tmpArr);
			}
			oos.writeObject(fileStrList);
			// 第三部，发送文件
			byte[] buff = new byte[BUFF_SIZE];
			int len = 0;
			// 循环上传文件
			for (File file : fileList) {
				fis = new FileInputStream(file);
				while ((len = fis.read(buff)) != -1) {// 将读取的内容输出流
					out.write(buff, 0, len);
				}
				out.flush();
				fis.close();
				fis = null;
			}
			logger.debug("多文件上传结束，共 "+(fileList==null ? 0 : fileList.size())+ "个文件");
		} catch (IOException e) {
			logger.error("Fail to send file",e);
		} finally {
			try {
				if (fis != null) {
					fis.close();
					fis = null;
				}
			} catch (IOException e) {
				logger.error("",e);
			}
		}
	}
	
	/**
	 * 批量接收文件
	 * @param newDir
	 * (DC未使用)
	 */
	protected void receiveFileByBath(String newDir) {
		ObjectInputStream ois = null;
		FileOutputStream fos = null;
		try {
			//获取集合文件路径
			String oldDir = this.receiveMessage();
			logger.debug("根目录 记录: " + oldDir+" VS "+newDir);
			this.sendMessage(SUCCESS);
			ois = new ObjectInputStream(in);
			List<String[]> fileList = (List<String[]>)ois.readObject();
//			byte[] buff = null;
			if(fileList != null && fileList.size()>0){
				for(String[] arr : fileList){
					String newUrl = arr[0].replace(oldDir, newDir);//新路径
					newUrl = newUrl.replaceAll("\\\\", "/");
					int fileLength = Integer.parseInt(arr[1]);		//大小
					File newFile = new File(newUrl);
					if(newFile.exists()){
						newFile.delete();
					}
					
					if(!newFile.getParentFile().exists()){
						newFile.getParentFile().mkdirs();
					}
					
					fos = new FileOutputStream(newUrl+TEMP_SUFFIX);
					int nRead = 0;
					byte[] buff = new byte[BUFF_SIZE];
					
					
					//单个文件循环读取
					rfile:while ((nRead = in.read(buff, 0, (int)(BUFF_SIZE<fileLength?BUFF_SIZE:fileLength))) > 0) {
						fos.write(buff,0,nRead);
						fos.flush();
						fileLength -= nRead;
						if(fileLength<=0){
							break rfile;
						}
					}
					fos.close();
					fos = null;
					File newFile2 = new File(newUrl+TEMP_SUFFIX);
//					newFile2.renameTo(newFile);		//将临时文件名改为正式文件名，即去掉.tp后缀
					FileUtils.copyFile(newFile2, newFile);	//将临时文件名改为正式文件名，即去掉.tp后缀
					newFile2.delete();
				}
			}
			logger.debug("多文件接收结束，共 "+(fileList==null ? 0 : fileList.size())+ "个文件");
		} catch (IOException e) {
			logger.error("",e);
		} catch (ClassNotFoundException e) {
			logger.error("",e);
		}finally{
			if(fos!=null){
				try {
					fos.close();
					fos = null;
				} catch (IOException e) {
					logger.error("",e);
				}
			}
		}

	}
	
	/**
	 * 批量接收文件 保存为 List<byte[]>形式
	 * @param newDir
	 * (DC未使用)
	 */
	protected LinkedList<byte []> receiveFileBytesByBath() {
		LinkedList<byte []> bsList = new LinkedList<byte []>();
		ObjectInputStream ois = null;
		try {
			//获取集合文件路径
			String oldDir = this.receiveMessage();
			this.sendMessage(SUCCESS);
			ois = new ObjectInputStream(in);
			List<String[]> fileList = (List<String[]>)ois.readObject();
			
			//循环读取多个文件
			if(fileList != null && fileList.size()>0){
				for(String[] arr : fileList){
					
					int fileLength = Integer.parseInt(arr[1]);		//大小
					byte[] buff0 = new byte[fileLength];
					byte[] buff = new byte[BUFF_SIZE];
					int nRead = 0;
					int j = 0;
					
					//单个文件循环读取
					rfile:while ((nRead = in.read(buff, 0, (int)(BUFF_SIZE<fileLength?BUFF_SIZE:fileLength))) > 0) {
						
						//将数据存入集合
						for(int i = 0 ; i < nRead ; i++){
							buff0[j] = buff[i];
							j++;
						}
						
						logger.debug(j+" "+buff0.length);
						
						fileLength -= nRead;
						if(fileLength<=0){
							break rfile;
						}
					}
					
					bsList.add(buff0);				
				}
			}
			logger.debug("共接收 "+(fileList==null ? 0 : fileList.size())+ "个文件 存入内存");
		} catch (IOException e) {
			logger.error("",e);
			bsList.clear();
		} catch (ClassNotFoundException e) {
			logger.error("",e);
			bsList.clear();
		}
		return bsList;
	}
	
	/**
	 * 批量上传文件
	 * @param dir	本地文件集合根目录绝对路径
	 * @param fileList	上传的文件列表
	 * (DC未使用)
	 */
	protected void sendFileByBathMD5(List<String[]> fileCommentsList) {
		ObjectOutputStream oos = null;
		FileInputStream fis = null;

		try {
			// 第一步 用ObjectOutputStream工具类 发送file对象信息 用于文件名，文件目录，文件大小的获取
			oos = new ObjectOutputStream(out);
			List<File> fileList = new LinkedList<File>();
			List<String[]> fileStrList = new ArrayList<String[]>();
			for(String[] fileComments : fileCommentsList){
				File file = new File(fileComments[0]);
				if(file.exists()){
					String[] tmpArr = new String[]{
							removeTimeTagFileName(file.getName()), file.length() + "",fileComments[1]
					};
					fileList.add(file);
					fileStrList.add(tmpArr);
				}else {
					logger.warn("-- File:>"+file.getAbsolutePath()+" not exist ,can not be sent");
				}
			}
			oos.writeObject(fileStrList);
			// 第三部，发送文件
			byte[] buff = new byte[BUFF_SIZE];
			int len = 0;
			// 循环上传文件
			for (File file : fileList) {
				fis = new FileInputStream(file);
				while ((len = fis.read(buff)) != -1) {// 将读取的内容输出流
					out.write(buff, 0, len);
				}
				out.flush();
				fis.close();
				fis = null;
			}
			logger.debug("多文件上传结束，共 "+(fileList==null ? 0 : fileList.size())+ "个文件");
		} catch (IOException e) {
			logger.error("",e);
		} finally {
			try {
				if (fis != null) {
					fis.close();
					fis = null;
				}
			} catch (IOException e) {
				logger.error("",e);
			}
		}
	}

	/**
	 * 批量接收文件, 使用Md5校验文件是否完整
	 * @param newDir
	 * (DC未使用)
	 */
	protected boolean receiveFileByBathMd5(String newDir) {
		boolean flag = true;
		ObjectInputStream ois = null;
		FileOutputStream fos = null;
		try {
			ois = new ObjectInputStream(in);
			List<String[]> fileList = (List<String[]>)ois.readObject();
			if(fileList != null && fileList.size()>0){
				int sucessCnt = 0;
				int failCnt = 0;
				for(int i=0; i<fileList.size(); i++){
					String[] arr = fileList.get(i);//arr[0] 存放文件名，arr[1] 存放文件长度，arr[2] 存放Md5值
					String newUrl = newDir + File.separator + arr[0];
					int fileLength = Integer.parseInt(arr[1]);//大小
					String md5Val = arr[2];
					File newFile = new File(newUrl);
					if(newFile.exists()){
						newFile.delete();
					}
					if(!newFile.getParentFile().exists()){
						newFile.getParentFile().mkdirs();
					}
					fos = new FileOutputStream(newUrl+TEMP_SUFFIX);
					int nRead = 0;
					byte[] buff = new byte[BUFF_SIZE];
					
					
					//单个文件循环读取
					rfile:while ((nRead = in.read(buff, 0, (int)(BUFF_SIZE<fileLength?BUFF_SIZE:fileLength))) > 0) {
						fos.write(buff,0,nRead);
						fos.flush();
						fileLength -= nRead;
						if(fileLength<=0){
							break rfile;
						}
					}
					fos.close();
					
//					int buffSize = 1024;
//					logger.debug("buffSize = "+ BUFF_SIZE);
//					int counts = (int) ((fileLength % BUFF_SIZE == 0) ? (fileLength / BUFF_SIZE)
//							: (fileLength / BUFF_SIZE + 1));
//					byte[] buff = new byte[BUFF_SIZE];
					//接收文件内容 
					/*if(fileLength>0){
						for (int k = 0; k < counts; k++) {
							len = inl.read(buff);
							fos.write(buff, 0, len);
							fos.flush();
						}
					}else{
						fos.write(buff, 0, len);
						fos.flush();
					}
					fos.close();*/
					fos = null;
					File newFile2 = new File(newUrl+TEMP_SUFFIX);
					if (md5Val != null
							&& md5Val
									.equals(MD5Util.getFileMD5String(newFile2))) {
						logger.debug("接收文件" + (i+1) + "“" + newFile2.getAbsolutePath() + "”完整");
//						newFile2.renameTo(newFile);		//将临时文件名改为正式文件名，即去掉.tp后缀
						FileUtils.copyFile(newFile2, newFile);	//将临时文件名改为正式文件名，即去掉.tp后缀
						newFile2.delete();
						sucessCnt ++ ;
					} else {
						logger.debug("接收文件" + (i+1) + "“" + newFile2.getAbsolutePath() + "”不完整，失败");
						failCnt ++ ;
					}
				}
				logger.info("批理接收文件个数：" + fileList.size() + ", 成功：" + sucessCnt + ", 失败：" + failCnt);
				if(failCnt > 0) {
					flag = false;
				}
			}else{
				logger.info("批量接收文件列表为空");
			}
		} catch (IOException e) {
			logger.error("Batch recive file failure",e);
			return false;
		} catch (ClassNotFoundException e) {
			logger.error("",e);
			return false;
		}finally{
			if(fos!=null){
				try {
					fos.close();
					fos = null;
				} catch (IOException e) {
					logger.error("",e);
				}
			}
		}
		
		return flag;
	}
	/**
	 * 断点续传 发送方法
	 * @time Mar 2, 2012-2:30:16 PM
	 * @param filePath
	 * (DC未使用)
	 */
	protected int bpSendFile (String filePath) throws UnsupportedEncodingException,IOException {
		File file = new File(filePath);
		
		//发送长度 end
		this.sendMessage(file.length()+"");
		
		String msg = this.receiveMessage();
		long start = Long.parseLong(msg);
		long end = file.length();
//		pl("start "+msg);
//		pl("end "+end);
		bpSendFile(filePath, start, end);
//		pl("bpSendFile sucess");
		return 0;
	}
	
	/**
	 * 断点续传 接收方法
	 * @time Mar 2, 2012-2:30:16 PM
	 * @param filePath
	 * @param start
	 * @param end
	 */
	protected int bpReceiveFile (String filePath) throws UnsupportedEncodingException,IOException{
		File file = new File(filePath);
		if(!file.exists()){
			file = new File(filePath+TEMP_SUFFIX);
		}
		String msg = this.receiveMessage();
		long start = file.length();
		long end = Long.parseLong(msg);
		sendMessage(start+"");
		
		logger.debug(file.getName()+" start:> "+start);
		logger.debug(file.getName()+" end  :> "+end);
		bpReceiveFile(file.getAbsolutePath(), start, end);
		if(file.exists()){
			FileUtils.copyFile(file, new File(filePath));	//将临时文件名改为正式文件名，即去掉.tp后缀
			file.delete();
		}
		//发送
		logger.debug(file.getName()+" bpReceiveFile sucess");
		return 0;
	}
	
	/**
	 * 断点续传 发送方法
	 * @time Mar 2, 2012-2:30:16 PM
	 * @param filePath
	 * @param start
	 * @param end
	 * (DC未使用)
	 */
	protected void bpSendFile (String filePath,long start,long end) throws IOException{
		if(start == end){
			return ;
		}
        BufferedRandomAccessFile braf = null;
        
        try {
        	
            File file = new File(filePath);
            
            //- 不存在，终止； 存在则继续
            if(!file.exists()){
            	this.sendMessage(FAIL);
            	return ;
            }else
            	this.sendMessage(SUCCESS);
            
            String msg = this.receiveMessage();
            pl("Recive:   " + msg); 
            
            //- BufferedRandomAccessFile 读取指定位置的文件字节数组，写入输出通讯
            byte[] b = new byte[BUFF_SIZE];
            braf = new BufferedRandomAccessFile(file,"r");  
            braf.seek(start);
            int nRead;
            while ((nRead = braf.read(b, 0, BUFF_SIZE)) > 0) {
            	
            	out.write(b, 0, nRead);
            	start += nRead;
            	
            	//-- 读取完成 跳出
            	if(start==end){break;}
            	
            }
            
//        }catch (IOException e) {
//        	logger.error("",e);
		}finally{
			
//			try {
				//- 关闭 随机访问文件对象（关闭流）
			if (braf != null) {
				braf.close();
				braf = null;
			}
				
//			} catch (IOException e) {
//				logger.error("",e);
//			}
			
		}
	}
	
	/**
	 * 断点续传 接收方法
	 * @time Mar 2, 2012-2:30:16 PM
	 * @param filePath
	 * @param start
	 * @param end
	 * (DC未使用)
	 */
	private void bpReceiveFile (String filePath,long start,long end) throws IOException{
		
		BufferedRandomAccessFile raf = null;
		
		try {
			if(StringUtils.isEmpty(filePath)){
				return;
			}
			
			File file = new File(filePath);
			
			//- 文件路径不存在 则创建
			if (!file.getParentFile().exists()) {
				file.getParentFile().mkdirs();
			}
			
			//- 文件不存在 则创建
			if (!file.exists()) {
				file.createNewFile();
			}
			
			//- 文件已传输完成（包括0字节）
			if(start == end){
				return ;
			}
			
			//- 接收发送端 发送数据准备 确认信息
			String msg = this.receiveMessage();
			
			if (FAIL.equals(msg)) {			//结束操作
				return;
			} else 
				this.sendMessage(SUCCESS);	// 通知发送端 接收数据准备完成 确认信息

			// 将通信中读出的数据 写入文件指定位置
			byte[] b = new byte[BUFF_SIZE];
			raf = new BufferedRandomAccessFile(file, "rw");
			raf.seek(start);
			int nRead;
			
			while ((nRead = in.read(b, 0, BUFF_SIZE)) > 0) {
				
				raf.write(b, 0, nRead);
				start += nRead;
				
				if (start == end) {		//写完跳出
					break;
				}
			}
			
//		} catch (IOException e) {
//			logger.error("",e);
		}finally{
			
//			try {
				
				//- 关闭 随机访问文件对象（关闭流）
			if (raf != null) {
				raf.close();
				raf= null;
			}
			
//			} catch (IOException e) {
//				logger.error("",e);
//			}
		}
	}
	/**
	 * 批量上传文件
	 * @param fileList	上传的文件列表
	 * @param dir	本地文件集合根目录绝对路径
	 */
	protected void bpSendFileByBath(List<File> fileList,String dir) throws ClassNotFoundException,IOException {
		BufferedRandomAccessFile oReadFile =  null;

		try {
			// 第一步发送本地根目录地址（用于地址截取）保证fileList的目录结构完整性
			this.sendMessage("abs:"+(dir==null?"":dir));
			String result = this.receiveMessage();
			logger.debug("根目录路径通信状态: " + result);
			// 第二步 用ObjectOutputStream工具类 发送file对象信息 用于文件名，文件目录，文件大小的获取

			//原文件文件名 和 大小（即end长度）
			List<String[]> sourceFileList = new ArrayList<String[]>(); 
			for(File f : fileList){
				String[] tmpArr = new String[]{
						f.getAbsolutePath(),0+"",f.length() + ""
				};
				sourceFileList.add(tmpArr);
			}

			logger.debug("发送信息: " + Arrays.toString(sourceFileList.toArray()));
			this.sendObject(sourceFileList);
		
			//得到需要下载的文件信息
			List<String[]> sendFileList = (List<String[]>)receiveObject();
			
			// 第三部，发送文件
			byte[] buff = new byte[BUFF_SIZE];
			
			// 循环上传文件
			for (String[] sendFile: sendFileList) {
				long start = Long.parseLong(sendFile[1]);
				long end = Long.parseLong(sendFile[2]);
				if(start >= end){
					continue;
				}
				File file = new File(sendFile[0]);
				oReadFile = new BufferedRandomAccessFile(file,"r");
				
				// 定位文件指针到nPos位置
				oReadFile.seek(start);		//从0开始
				int nRead;
				
				// 从输入流中读入字节流，然后写到文件中
			    while ((nRead = oReadFile.read(buff, 0, BUFF_SIZE)) > 0) {
			    	
			    	out.write(buff, 0, nRead);
			    	start += nRead;		//调整为从1开始
			        if(start >= end){
			        	break;
			        }
			        
			    }
			    oReadFile.close();
			    oReadFile = null;
			}
			logger.debug("多文件上传结束，共 "+(fileList==null ? 0 : fileList.size())+ "个文件");
//		} catch (IOException e) {
//			logger.error("",e);
//		} catch (ClassNotFoundException e) {
//			logger.error("",e);
		} finally {
//			try {
				if (oReadFile != null) {
					oReadFile.close();
					oReadFile = null;
				}
//			} catch (IOException e) {
//				logger.error("",e);
//			}
		}
	}
	
	/**
	 * 批量上传文件
	 * @param fileList	上传的文件列表
	 * @param dir	本地文件集合根目录绝对路径
	 */
	protected void bpSendFileByBathMD5(List<FileComment> fileCommentsList)throws ClassNotFoundException,IOException {
		BufferedRandomAccessFile oReadFile =  null;

		try {
			//原文件文件名 和 大小（即end长度）
			List<FileComment> sourceFileList = new ArrayList<FileComment>(); 
			if(fileCommentsList !=null && fileCommentsList.size()!=0){
				for(FileComment fileComment : fileCommentsList){
					File f = new File(fileComment.getFileName());
//					pl(f.getName()+" " +f.length());
					if(!f.exists()){
						sourceFileList.add(new FileComment(f.getAbsolutePath(),0,-1,fileComment.getMd5Val()));
					}else {
						String md5Val = StringUtils.isEmpty(fileComment.getMd5Val())?MD5Util.getFileMD5String(f):fileComment.getMd5Val();
						sourceFileList.add(new FileComment(f.getAbsolutePath(),0,f.length(),md5Val));
					}
				}
			}

			logger.debug("发送信息: " + Arrays.toString(sourceFileList.toArray()));
			this.sendObject(sourceFileList);
		
			//得到需要下载的文件信息
			List<FileComment> sendFileList = (List<FileComment>)receiveObject();
			
			// 第三部，发送文件
			byte[] buff = new byte[BUFF_SIZE];
			
			// 循环上传文件
			for (FileComment sendFile: sendFileList) {
				long start = sendFile.getStart();
				long end = sendFile.getEnd();
				if(start >= end){
					continue;
				}
				File file = new File(sendFile.getFileName());
				oReadFile = new BufferedRandomAccessFile(file,"r");
				
				// 定位文件指针到nPos位置
				oReadFile.seek(start);		//从0开始
				int nRead;
				
				// 从输入流中读入字节流，然后写到文件中
			    while ((nRead = oReadFile.read(buff, 0, BUFF_SIZE)) > 0) {
			    	
			    	out.write(buff, 0, nRead);
			    	start += nRead;		//调整为从1开始
			        if(start >= end){
			        	break;
			        }
			        
			    }
			    oReadFile.close();
			    oReadFile = null;
			}
			logger.debug("多文件上传结束，共 "+(sendFileList==null ? 0 : sendFileList.size())+ "个文件");
//		} catch (IOException e) {
//			logger.error("",e);
//		} catch (ClassNotFoundException e) {
//			logger.error("",e);
		} finally {
//			try {
				if (oReadFile != null) {
					oReadFile.close();
					oReadFile = null;
				}
//			} catch (IOException e) {
//				logger.error("批量接收文件失败",e);
//			}
		}
	}
	
	/**
	 * 批量接收文件
	 * @param newDir
	 */
	protected int bpReceiveFileByBathMd5(String newDir) {
		int rFlag = 0; //0 OK  -1 MD5 ERROR -2 Function ERROR -3 文件不存在
		BufferedRandomAccessFile oSavedFile =  null;	//有缓存的 随机文件IO对象
		try {

			List<FileComment> remoteFileList = (List<FileComment>)receiveObject();	//接收可接收的文件信息 string[]{fileName,start,end,MD5}
			List<FileComment> receiveFileList = new LinkedList<FileComment>();		//需要续传的文件及其索引信息 string[]{fileName,start,end,MD5}
			byte[] buff = new byte[BUFF_SIZE];	//缓存 大小

			//- 检查实际接收文件大小
			if(remoteFileList != null && remoteFileList.size()>0){
				for(FileComment arr : remoteFileList){
					
					String filePath = arr.getFileName().replaceAll("\\\\", "/");
//					System.out.println("filePath  "+filePath);
					String fileName = filePath.substring(filePath.lastIndexOf("/")+1, filePath.length());
//					System.out.println("fileName  "+fileName);
					String newUrl = newDir+fileName;
//					System.out.println("newUrl  "+newUrl);
					File newFile = new File(newUrl);
					
					//-- 已接收完成
					if(newFile.exists()){
						continue;
					}
					
					//-- 续传文件及起始长度
					newFile = new File(newUrl+TEMP_SUFFIX);
					arr.setStart(newFile.length());
					receiveFileList.add(arr);
				}
			}
			this.sendObject(receiveFileList);
			
			//- 接收文件
			if(receiveFileList != null && receiveFileList.size()>0){
				for(FileComment arr : receiveFileList){
					String filePath = arr.getFileName().replaceAll("\\\\", "/");
//					System.out.println("filePath  "+filePath);
					String fileName = filePath.substring(filePath.lastIndexOf("/")+1, filePath.length());
//					System.out.println("fileName  "+fileName);
					String newUrl = newDir+fileName;
//					System.out.println("newUrl  "+newUrl);
					
					File newFile = new File(newUrl+TEMP_SUFFIX);
					if(!newFile.getParentFile().exists()){
						newFile.getParentFile().mkdirs();
					}
					//创建空文件
					if (!newFile.exists()) {
						newFile.createNewFile();
					}
					
					long start = arr.getStart();		// 起始
					long end = arr.getEnd();		// 结束
					if(end == -1){
						return -3;
					}
					
					if(start<end){
						oSavedFile = new BufferedRandomAccessFile(newFile,"rw");
						oSavedFile.seek(start);
						int nRead;
						rfile:while ((nRead = in.read(buff, 0, (int)(BUFF_SIZE<end?BUFF_SIZE:end))) > 0) {
							oSavedFile.write(buff,0,nRead);
							end -= nRead;
							if(end<=0){
								break rfile;
							}
						}
						oSavedFile.close();
						oSavedFile = null;
					}
//					pl("--!! "+arr.getStart()+" "+arr.getEnd()+"   "+arr.getMd5Val());
//					Scanner scanner = new Scanner(System.in);
//					newFile.renameTo(new File(newUrl));		// 慎用 将临时文件名改为正式文件名，即去掉.tp后缀
					if(newFile.exists()){
						FileUtils.copyFile(newFile, new File(newUrl));	//将临时文件名改为正式文件名，即去掉.tp后缀
						newFile.delete();
					}
					
					logger.debug(newFile.getAbsolutePath()+" 下载完成！");
					
					//-- MD5为空 无需校验
					if(StringUtils.isEmpty(arr.getMd5Val())){
						continue;
					}

					File newFile2 = new File(newUrl);
					//-- MD5不相等，则删除该文件 返回-1
					if(!arr.getMd5Val().equals(MD5Util.getFileMD5String(newFile2))){
						newFile.delete();
						logger.debug(newFile.getAbsolutePath()+" MD5值校验不一致");
						return -1;
					}
					//-- MD5相等
					else
					logger.debug(newFile.getAbsolutePath()+" MD5值校验一致");
				}
			}
			logger.debug("多文件接收结束，共 "+(remoteFileList==null ? 0 : remoteFileList.size())+ "个文件");
			return rFlag;
		} catch (IOException e) {
			logger.error("",e);
			return -2;
		} catch (ClassNotFoundException e) {
			logger.error("",e);
			return -2;
		}finally{
			if(oSavedFile!=null){
				try {
					oSavedFile.close();
					oSavedFile = null;
				} catch (IOException e) {
					logger.error("",e);
				}
			}
		}
	}
	

	/**
	 * 批量接收文件
	 * @param newDir
	 * (DC未使用)
	 */
	protected void bpReceiveFileByBath(String newDir) throws ClassNotFoundException,IOException {

		BufferedRandomAccessFile oSavedFile =  null;
		try {
			//获取集合文件路径
			String oldDir = this.receiveMessage();
			int headLength = "abs:".length();
			oldDir = ((StringUtils.isNotEmpty(oldDir) 
						&& oldDir.length()>=headLength)
						?oldDir.substring(headLength,oldDir.length())
								:oldDir);
			if(StringUtils.isEmpty(oldDir)){
				logger.debug("远程 目录根路径为空 接收文件不保留目录格式 统一存放到本地目录：》"+newDir);
			}else{
				logger.debug("根目录 记录: " + oldDir+" VS "+newDir);
			}
			this.sendMessage(SUCCESS);

			List<String[]> remoteFileList = (List<String[]>)receiveObject();
			List<String[]> receiveFileList = new LinkedList<String[]>();
			byte[] buff = new byte[BUFF_SIZE];
			if(remoteFileList != null && remoteFileList.size()>0){
				for(String[] arr : remoteFileList){
					String newUrl = null;
					if(StringUtils.isEmpty(oldDir)){
						newUrl = newDir+(new File(arr[0].replaceAll("\\\\", "/")).getName());
					}else{
						newUrl = arr[0].replace(oldDir, newDir);//新路径
						newUrl = newUrl.replaceAll("\\\\", "/");
					}
					
					File newFile = new File(newUrl);
					
					//该文件已存在
					if(newFile.exists()){
						continue;
					}

					newFile = new File(newUrl+TEMP_SUFFIX);
					arr[1] = newFile.length()+"";
					receiveFileList.add(arr);
				}
			}
			this.sendObject(receiveFileList);
			
			if(receiveFileList != null && receiveFileList.size()>0){
				for(String[] arr : receiveFileList){
					String newUrl = null;
					if(StringUtils.isEmpty(oldDir)){
						newUrl = newDir+(new File(arr[0].replaceAll("\\\\", "/")).getName());
					}else{
						newUrl = arr[0].replace(oldDir, newDir);//新路径
						newUrl = newUrl.replaceAll("\\\\", "/");
					}

					File newFile = new File(newUrl+TEMP_SUFFIX);
					
					if(!newFile.getParentFile().exists()){
						newFile.getParentFile().mkdirs();
					}
					
					if(!newFile.exists()){
						newFile.createNewFile();
					}
					
					int start = Integer.parseInt(arr[1]);		// 起始
					int end = Integer.parseInt(arr[2]);		// 结束
					if(start<end){
						oSavedFile = new BufferedRandomAccessFile(newFile,"rw");
						oSavedFile.seek(start);
						int nRead;
						rfile:while ((nRead = in.read(buff, 0, BUFF_SIZE<end?BUFF_SIZE:end)) > 0) {
							oSavedFile.write(buff,0,nRead);
							end -= nRead;
							if(end<=0){
								break rfile;
							}
						}
						oSavedFile.close();
						oSavedFile = null;
					}
//					newFile.renameTo(new File(newUrl));		//将临时文件名改为正式文件名，即去掉.tp后缀
					FileUtils.copyFile(newFile, new File(newUrl));	//将临时文件名改为正式文件名，即去掉.tp后缀
					newFile.delete();
				}
			}
			logger.debug("多文件接收结束，共 "+(remoteFileList==null ? 0 : remoteFileList.size())+ "个文件");
//		} catch (IOException e) {
//			logger.error("",e);
//		} catch (ClassNotFoundException e) {
//			logger.error("",e);
		}finally{
			if(oSavedFile!=null){
//				try {
					oSavedFile.close();
					oSavedFile = null;
//				} catch (IOException e) {
//					logger.error("",e);
//				}
			}
		}
	}

	/**
	 * @time Mar 12, 2012-11:07:02 AM
	 * @param URL
	 * @param file
	 * @param nStartPos
	 * @param nEndPos
	 * @return -2错误的URL  -1下载失败可再次尝试 1下载成功 
	 * (DC未使用)
	 */
	public static int bpDownLoadHTTP(String URL, File file,long nStartPos,long nEndPos) {
		BufferedRandomAccessFile oSavedFile = null;
		try {
			URL url = new URL(URL);
			HttpURLConnection httpConnection = (HttpURLConnection) url.openConnection();
			// 设置User-Agent
			httpConnection.setRequestProperty("User-Agent", "NetFox");
			httpConnection.setRequestProperty("User-Agent", "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.3) Gecko/2008092510 Ubuntu/8.04 (hardy) Firefox/3.0.3");
			httpConnection.setRequestProperty("Accept-Language", "en-us,en;q=0.7,zh-cn;q=0.3");
			httpConnection.setRequestProperty("Accept-Encoding", "aa");
			httpConnection.setRequestProperty("Accept-Charset", "ISO-8859-1,utf-8;q=0.7,*;q=0.7");
			httpConnection.setRequestProperty("Keep-Alive", "300");
			httpConnection.setRequestProperty("Connection", "keep-alive");
			httpConnection.setRequestProperty("If-Modified-Since", "Fri, 02 Jan 2009 17:00:05 GMT");
			httpConnection.setRequestProperty("If-None-Match", "\"1261d8-4290-df64d224\"");
			httpConnection.setRequestProperty("Cache-Control", "max-age=0");
			httpConnection.setRequestProperty("Referer", "http://www.skycn.com/soft/14857.html");
			// 设置断点续传的开始位置
			httpConnection.setRequestProperty("RANGE", "bytes="+nStartPos+"-" + nEndPos);
			
			//判断http status是否为HTTP/1.1 206 Partial Content或者200 OK
			//如果不是以上两种状态，把status改为STATUS_HTTPSTATUS_ERROR
			if (httpConnection.getResponseCode() != HttpURLConnection.HTTP_OK
					&& httpConnection.getResponseCode() != HttpURLConnection.HTTP_PARTIAL) {
				return -2;
			}
			logger.debug("httpConnection.getResponseCode() " + httpConnection.getResponseCode() + "\n " +
					"HttpURLConnection.HTTP_OK "	+ HttpURLConnection.HTTP_OK + "\n " +
					"HttpURLConnection.HTTP_PARTIAL "	+ HttpURLConnection.HTTP_PARTIAL);
			// 获得输入流
			InputStream input = httpConnection.getInputStream();
			oSavedFile = new BufferedRandomAccessFile(file,"rw");
			
			// 定位文件指针到nPos位置
			oSavedFile.seek(nStartPos);		//从0开始
			byte[] b = new byte[BUFF_SIZE];
			int nRead;
			
			// 从输入流中读入字节流，然后写到文件中
		    while ((nRead = input.read(b, 0, 1024)) > 0) {
		    	
		        (oSavedFile).write(b, 0, nRead);
		        nStartPos += nRead;		//调整为从1开始
		        if(nStartPos >= nEndPos){
		        	break;
		        }
		    }
		    
		    httpConnection.disconnect();
		    return 1;
		} catch (MalformedURLException e) {	//错误的URL
		    logger.error("",e);
		    return -2;
		} catch (IOException e) {
		    logger.error("",e);
		    return -1;
		}finally{
			if(oSavedFile!=null){
				try {
					oSavedFile.close();
				} catch (IOException e) {
					logger.error("",e);
				}
				oSavedFile=null;
			}
		}
	}
	
	/**
	 * 关闭通讯
	 * @time Aug 28, 2011-8:35:21 PM
	 */
	protected void close(){
		try {
			if(in!=null){in.close();in=null;}
			if(out!=null){out.close();out=null;}
			if(socket!=null){socket.close();socket=null;}
		} catch (IOException e) {
			logger.error("",e);
		}
	}
	
	/**
	 * 创建SSLContext方法
	 * @time Feb 29, 2012-11:40:24 AM
	 * @return
	 */
	public static SSLContext getSSLContext(){
		SSLContext ctx = null ;
		
		//- 创建 新的sSLContext 校验
		//- reCreateSSLContextFlag 为false 且 sSLContext 不为空时无需创建
		if(!resetSSLContextFlag && sSLContext !=null){
			return sSLContext;
		}
		
		//- 创建 新的sSLContext
		try {
			System.setProperty("javax.net.ssl.trustStore", SERVER_TRUST);
			//-- 初始化私钥证书库
			KeyManagerFactory kmf = KeyManagerFactory.getInstance("SunX509");
			KeyStore ks = KeyStore.getInstance(KEYSTORE_TYPE);
			ks.load(new FileInputStream(SERVER_STORE), SERVER_STORE_PSW.toCharArray());//载入keystore
			kmf.init(ks, SERVER_KEY_PSW.toCharArray());
			//-- 初始化公钥证书库
			TrustManagerFactory tmf = TrustManagerFactory.getInstance("SunX509");
			KeyStore tks = KeyStore.getInstance(KEYSTORE_TYPE);
			tks.load(new FileInputStream(SERVER_TRUST), SERVER_TRUST_PSW.toCharArray());//载入keystore
			tmf.init(tks);
			//-- 初始化SSL通讯上下文对象 和 SSL通讯工厂
			ctx = SSLContext.getInstance(SSL_CONTEXT_TYPE);
			ctx.init(kmf.getKeyManagers(), tmf.getTrustManagers(),new SecureRandom());
			logger.info("证书库载入成功(load keystore success.)");
			resetSSLContextFlag = false;
		} catch (NoSuchAlgorithmException e) {
			logger.error("",e);
		} catch (CertificateException e) {
			logger.error("",e);
		} catch (FileNotFoundException e) {
			logger.error("",e);
		} catch (IOException e) {
			logger.error("",e);
		} catch (KeyStoreException e) {
			logger.error("",e);
		} catch (UnrecoverableKeyException e) {
			logger.error("",e);
		} catch (KeyManagementException e) {
			logger.error("",e);
		}finally{
		}
		return ctx;
	}
	
	public static void resetSSLContext(){
		synchronized (sSLContext) {
			resetSSLContextFlag = true;
			sSLContext = getSSLContext(); 
		}
	}
	
	/**
	 * 
	 * @time Mar 12, 2012-11:08:43 AM
	 * @param url
	 * @return -1文件不存在  0文件长度为0  N文件长度
	 */
	public static long getRemoteFileSize(String url) {
		
	    long size = -1;
	    
	    try {
	        HttpURLConnection conn = (HttpURLConnection) (new URL(url)).openConnection();
	        
	        //请求状态 大于等于400 均为 represent access error
	        if(conn.getResponseCode() >= 400){
	        	logger.error("HttpURLConnection Error Code:"+conn.getResponseCode());
	        	return -2;	
	        }
	        
	        //获取ContentLength 并 关闭连接 
	        size = conn.getContentLength();
	        conn.disconnect();
	        
	    } catch (Exception e) {
	        logger.error("",e);
	    }
	    return size;
	}
	
	/**
	 * 删除addTimeTagForFileName()方法 所添加的时间戳
	 * @time Mar 12, 2012-3:36:16 PM
	 * @param fileName
	 * @return
	 */
	public static String removeTimeTagFileName(String fileName) {
		
		if (StringUtils.isNotBlank(fileName) && fileName.contains("_")) {
			
			String timeTag = fileName.substring(fileName.lastIndexOf("_"),
					fileName.lastIndexOf(".")==-1?fileName.length():fileName.lastIndexOf("."));		//针对无后缀名文件，时间戳截取校验
			fileName = fileName.replace(timeTag, "");
			
		}
		
		return fileName;
		
	}
	
	/**
	 * 上传文件时，判断该文件是否已存在，如存在，则在后面加入时间戳
	 * 
	 * @param fileName
	 *            单纯的文件名
	 */
	public static String addTimeTagForFileName(String fileName,boolean isDirectory) {
		
		Calendar calendar = new GregorianCalendar();
		long timestamp = calendar.getTimeInMillis();
		
		// 去掉后缀的文件名
		String fielType = "";
		
		if (!isDirectory && fileName.lastIndexOf(".") != -1) {
			fielType = fileName.substring(fileName.lastIndexOf("."));
			fileName = fileName.substring(0, fileName.lastIndexOf("."));
		}
		
		fileName += "_" + timestamp+""+((int)(Math.random()*1000));
		fileName += fielType;
		
		return fileName;
	}
	
	/**
	 * 获取 断点续传 文件参数信息
	 * @time Apr 17, 2012-9:56:56 AM
	 * @param filePath
	 * @return
	 */
//	public static FileComment getFileParams(String filePath) throws Exception{
//		File file = new File(filePath);
//		FileComment fileParam = new FileComment(file.getName(),file.length(),0l,file.exists()?MD5Util.getFileMD5String(file):null);
//		if(!file.exists()){
//			file = new File(filePath+TEMP_SUFFIX);
//			fileParam.setStart(file.length());
//		}
//		return fileParam;
//	}

	public static void pl(Object object){
		System.out.println(object==null?null:object.toString());
	}
}

class TempFile {
	private String fileName = null;
	private File File = null;
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public File getFile() {
		return File;
	}
	public void setFile(File file) {
		File = file;
	}
}