package com.nms.thread;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.concurrent.Callable;

import org.apache.log4j.Logger;

import com.nms.thread.pool.ThreadConstants;


public class PingThread implements Callable<Object> {
	private Logger logger = Logger.getLogger(DCHandShakeThread.class);
	private String ip;
	public PingThread(String ip){
		this.ip = ip;
	}
	
	@Override
	public Object call() throws Exception {
		String command = ""; // 命令语句
		int snum = 0, fnum = 0; // 发包成功和失败数
		
		Process process = null;
		BufferedReader in = null; // 读取 Ping命令返回的信息
		try {
			
			// 判断系统类型 win or Linux
			String system = (String) (System.getProperty("os.name")).toLowerCase();
			
			if (system.toLowerCase().indexOf("win") != -1) {
				command += "ping -n 4 " + ip;
			} else if (system.toLowerCase().indexOf("linux") != -1) {
				command += "ping -c 4 " + ip;
			} else {
				command += "ping -w 4 " + ip;
			}
		
			process = Runtime.getRuntime().exec(command);
			in = new BufferedReader(new InputStreamReader(process.getInputStream()));
			String line = null;
			long count = 4 + 10;
			// 最多多读10行
			while ((line = in.readLine()) != null && count != 0) {
				if ("".equals(line)) {
					continue;
				} // 空串跳过

				line = line.toLowerCase();
				logger.debug("line:"+line);
				if (line.indexOf("ttl") > 0) { // 获得成功响应的数据
					count--; // 计数器自减1
					snum++; // 成功接收次数加1
				} else if (line.split(" ").length < 4) {
					count--; // 计数器自减1
					fnum++; // 失败接收次数加1
				}
			}
		} catch (Exception e) {
			logger.error("",e);
		}finally{
			if(in!=null){try {
				in.close();
			} catch (IOException e) {
				logger.error("",e);
			}}
			if(process!= null)process.destroy();
			process = null;
		}
		
		if(snum>0){
			return ThreadConstants.HAND_SHAKE_RESULT_PING_SUCCESS;
		}else{
			return ThreadConstants.HAND_SHAKE_RESULT_PING_FAILED;
		}
	}

}
