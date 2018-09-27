package com.nms.thread.socket;

import java.io.File;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import nis.nms.util.BaseAction;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.filefilter.FalseFileFilter;
import org.apache.commons.io.filefilter.PrefixFileFilter;
import org.apache.commons.lang.StringUtils;

import com.nms.thread.DetectInsertThread;
import com.nms.thread.utils.ssl.SSLSocketRunnable;
import com.socket.utils.FileComment;

public class SSLServer extends SSLSocketRunnable{
	private String uploadPath ;
	private String snmpDir ;
	
	public static final String TYPE_MISSION = "1";
	public static final String TYPE_SNMP_CLASS = "2";
	public static final String TYPE_SNMP_MIB = "3";
	
	public SSLServer(Socket client,String uploadPath,String snmpDir) {
		super(client);
		this.uploadPath = uploadPath;
		this.snmpDir = snmpDir;
	}

	@SuppressWarnings("unchecked")
	@Override
	protected void toDo() throws Exception {
		String cmd = this.receiveMessage();
		System.out.println("cmd "+cmd);
		String uploadPath = this.uploadPath;
		//- 断点下载MissionFiles
		
//		if("byte:bpDownloadFile".equals(cmd)){
		if(StringUtils.isNotEmpty(cmd) && cmd.startsWith("byte:bpDownloadFile")){
			this.sendMessage(SUCCESS);
			String[] cmds = cmd.split(":");
			if(cmds.length>2){
				if(cmds[2].equals(TYPE_MISSION)){	//download MissionFile
					uploadPath = this.uploadPath;
				}else if(cmds[2].equals(TYPE_SNMP_CLASS)){	//download snmp jarFile
					uploadPath = this.snmpDir;
				}else if(cmds[2].equals(TYPE_SNMP_MIB)){	//download snmp mibFile
					uploadPath = this.snmpDir;
				}
			}
			List<FileComment> fileList = (List<FileComment>) this.receiveObject();
			for(FileComment fileInfo : fileList){
				fileInfo.setFileName(uploadPath+ fileInfo.getFileName());
				pl("DownloadPath  "+fileInfo.getFileName());
			}
			bpSendFileByBathMD5(fileList);
			this.receiveMessage();
		}
		
		//- 断点上传
		else if("byte:bpUploadFiles".equals(cmd)){
			this.sendMessage(SUCCESS);
			bpReceiveFileByBath(uploadPath);
			this.sendMessage(SUCCESS);
		}
		//- server握手请求
		else if("char:getLocalIp".equals(cmd)){
			this.sendMessage(socket.getInetAddress().getHostAddress());
			pl(socket.getInetAddress().getHostAddress());
			this.receiveMessage();
		}
		
		/**
		 *  server请求下载第三方监测脚本
		 *  根据脚本文件名下发单个脚本
		 */
		else if("char:downloadPluginScript".equalsIgnoreCase(cmd)) {
			this.sendMessage(SUCCESS);
			String prefixNames = this.receiveMessage();
			String uploadFilePath = new String(BaseAction.rb.getString("uploadServerPath"));
			File pluginScriptDir = new File(uploadFilePath, "pluginDetecScript");
			Collection<?> files = FileUtils.listFiles(pluginScriptDir, 
					new PrefixFileFilter(prefixNames.split(",")), FalseFileFilter.FALSE);
			if(files.isEmpty()) {
				this.sendMessage(FAIL);
			} else {
				this.sendMessage(SUCCESS);
				this.receiveMessage();
				List<File> fileList = new ArrayList<File>();
				fileList.addAll((Collection<? extends File>) files);
				this.bpSendFileByBath(fileList, pluginScriptDir.getCanonicalPath());
			}
		}
		/**
		 * dc 释放 监测数据入库锁
		 */
		else if("char:releaseDetect".equalsIgnoreCase(cmd)){
			this.sendMessage(SUCCESS);
			String ip = socket.getInetAddress().getHostAddress();
			String cip = DetectInsertThread.getCurrentDc();
			if(cip != null && ip.equalsIgnoreCase(cip)){
				DetectInsertThread.release();
				logger.info(ip + " char:releaseDetect 监测数据入库完成");
			}else{
				logger.debug("监测数据入库锁不一致：currentDc: "+ cip + ",requestIp : " + ip);
			}
		}
	}

	/*
	private boolean bpUpLoadFiles(){
		boolean flag = true;
		//- 获取上传文件参数 fileNames 字符串数组 Json信息
		String params = this.receiveMessage();
		System.out.println(""+params);
		//- JSON解析 并循环
		List<String> upFName = new LinkedList<String>();
		JSONArray fileNames = JSONArray.fromObject(params);

		if(fileNames!= null && fileNames.size()>0 ){
			for(int i = 0; i < fileNames.size() ; i++){
				String fileName = (String)fileNames.get(i);
				File file = new File(uploadPath+fileName);
				if(!file.exists()){
					upFName.add(fileName);
				}
			}
		}
		
		this.sendMessage(JSONArray.fromObject(upFName).toString());
		
		String msg = this.receiveMessage();
		try {
			while (SUCCESS.equals(msg)) {
				this.sendMessage(SUCCESS);
				String fn = this.receiveMessage();
				this.sendMessage(SUCCESS);
				
				pl("" + fn + "文件接收开始");
				logger.debug("" + fn + "文件接收开始");
				bpReceiveFile(uploadPath+fn);
				this.sendMessage(SUCCESS);
				msg = this.receiveMessage();
			}
		}catch (Exception e) {
			logger.error(ExceptionPrintUtils.printExceptionStack(e));
		}
		return flag;
	}*/
}
