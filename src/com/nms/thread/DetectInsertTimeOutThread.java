package com.nms.thread;

import org.apache.log4j.Logger;

import com.nms.thread.common.ThreadPoolCommon;
import com.nms.thread.socket.SSLClient;

public class DetectInsertTimeOutThread implements Runnable{
	private static final Logger logger = Logger.getLogger(DetectInsertTimeOutThread.class);
	private String ip;
	private int port;
	private long timeout;
	private long start = System.currentTimeMillis();
	private static boolean stop  = false;
	public DetectInsertTimeOutThread(String ip ,int port,long timeout) {
		this.ip = ip;
		this.port = port;
		this.timeout = timeout*1000;
		stop = false;
	}
	
	@Override
	public void run() {
		Thread.currentThread().setName(ip + "-监测数据入库超时监控线程-"+ System.currentTimeMillis());
		logger.debug("线程开始");
		try {
			long now;
			while(!stop){
				now = System.currentTimeMillis();
				if(now - start > timeout){
					SSLClient sc = new SSLClient(ip, port, SSLClient.RELEASE_DETECT);
					ThreadPoolCommon.service.submit(sc);
					DetectInsertThread.release();
					stop = true;
					logger.warn("监测数据入库超时释放锁");
				}
			}
		} catch (Exception e) {
			logger.error("",e);
			DetectInsertThread.release();
		}
		logger.debug("线程结束");
	}

	public static void stop() {
		stop = true;
	}
}
