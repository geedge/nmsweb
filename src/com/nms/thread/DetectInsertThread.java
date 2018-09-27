package com.nms.thread;

import java.util.Map.Entry;
import java.util.Set;
import java.util.concurrent.Future;
import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;

import org.apache.log4j.Logger;

import com.nms.thread.common.ThreadPoolCommon;
import com.nms.thread.pool.ThreadPoolConfig;
import com.nms.thread.socket.SSLClient;

import nis.nms.util.BaseAction;
/**
 * 监测数据入库 控制 线程，主动与dc 通信通知dc 入库监测数据
 * @author dell
 *
 */
public class DetectInsertThread implements Runnable{
	private static final Logger logger = Logger.getLogger(DetectInsertThread.class);
	public static boolean flag = true;//当前时间是否可以入库
	public static String currentDc;//当前入库的dc
	private static Semaphore insertSem = new Semaphore(1);
	//通知dc 入库，超过 此值 继续下一个 dc 入库，同时  尝试通知 超时的dc 暂停 入库，单位：s
	private static long timeout = Integer.parseInt(BaseAction.rb.getString("detect.insert.timeout"));//入库超时时间
	/**
	 * 通知超时时间,3s
	 */
	public static long INSERT_DETECT_SSL_TIMEOUT = 3000l;
	/**
	 * 释放锁
	 */
	public static void release(){
		DetectInsertTimeOutThread.stop();
		insertSem.release();
		currentDc = null;
		logger.debug("监测入库 release");
	}
	
	@Override
	public void run() {
		Thread.currentThread().setName("DC监测数据入库控制线程");
		long start = System.currentTimeMillis();
		long now = start;
		while(true){
			now = System.currentTimeMillis();
			if((now - start) > ThreadPoolConfig.DETECT_INSERT_CONTROL_PERIOD*1000){
				start = now;
				Set<Entry<String, Integer[]>> es = ThreadPoolCommon.DCStatusMap.entrySet();
				for(Entry<String, Integer[]> en : es){
					String ip = null;
					try {
						ip = en.getKey();
						Integer[] value = en.getValue();
						Integer status = value[0];
						logger.debug(ip +"状态："+ status);
						if(status == null || status != 1){
							logger.error(ip + " 通信异常，不做监测入库通信");
							continue;
						}
						insertSem.acquire();
						currentDc = ip;
						SSLClient client = new SSLClient(ip, SSLClient.DC_PORT, SSLClient.INSERT_DETECT);
						Future<Object> future = ThreadPoolCommon.service.submit(client);
						Object r = future.get(INSERT_DETECT_SSL_TIMEOUT, TimeUnit.MILLISECONDS);
						Integer result = Integer.valueOf(r+"");
						logger.debug(ip+ " 通知下发结果 " + result);
						if(result.intValue() > 0){
							//启动超时判断线程
							ThreadPoolCommon.service.submit(new DetectInsertTimeOutThread(ip, SSLClient.DC_PORT, timeout));
							logger.info("入库超时监控线程创建成功");
						}else if(result.intValue() ==0){
							insertSem.release();//释放锁
							logger.debug(ip + "监测数据为 0");
						}else if(result.intValue() == -1){
							insertSem.release();//释放锁
							logger.debug(ip + "通知下发响应异常");
						}else if(result.intValue() == -2){//
							insertSem.release();//释放锁
							logger.debug(ip + " 监测数据上传web");
						}else if(result.intValue() == -4){
							insertSem.release();//释放锁
							logger.debug(ip + " DC 主动入库");
						}else{
							insertSem.release();//释放锁
							logger.debug("未知响应");
						}
					} catch (Exception e) {
						logger.error(ip,e);
					} 
				}
			}else{
				try {
					Thread.sleep(now -start);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}
	}

	/**
	 * 获取当前入库的dc
	 * @return
	 */
	public static String getCurrentDc(){
		return currentDc;
	}
	
}