package com.nms.thread.common;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.Semaphore;

import nis.nms.domains.NmsErrorInfo;

import org.apache.log4j.Logger;

import com.nms.thread.pool.ThreadPoolConfig;

public class ThreadPoolCommon {
	private static Logger logger = Logger.getLogger(ThreadPoolCommon.class);
	public static ExecutorService service = Executors.newFixedThreadPool(ThreadPoolConfig.EXECUTOR_SOCKET_THREAD_SIZE);	//非周期执行线程池
	public static ScheduledExecutorService scheduled = Executors.newScheduledThreadPool(ThreadPoolConfig.EXECUTOR_SCHEDULED_THREAD_SIZE);	//定时周期执行线程池
	
	public static Map<String, Future<?>> threadManagerMap = new HashMap<String, Future<?>>(); 
	

	public static Map<String,Integer[]> DCStatusMap = new HashMap<String,Integer[]>(); //
//	Map<dcip,int[]{state,nodeNum}>	state（DC状态值1 通讯正常、0通讯失败、-1Ping失败、2通讯恢复[从非1状态恢复]）	NodeNum（管理节点数量 0表示未分配节点，其他表示已分配节点）
	private static final Semaphore handShakeSemaphore = new Semaphore(5,true);	//主动监测线程最大并发数
	
//	public static List<NmsErrorInfo> nelist = new LinkedList<NmsErrorInfo>();
	private static boolean alarmDataFlag = true;
	private static final LinkedList<NmsErrorInfo> nmsErrorList1 = new LinkedList<NmsErrorInfo>();
	private static final LinkedList<NmsErrorInfo> nmsErrorList2 = new LinkedList<NmsErrorInfo>();
	
	private static final Byte[] ALARM_DATA_LOCK = new Byte[0];	//告警数据锁
	/**
	 * 改变存放监测数据的数据集合
	 * @time Mar 7, 2012-2:15:38 PM
	 */
	public static void chengeNmsErrorFlag() {
		
		alarmDataFlag = alarmDataFlag ? false : true;
		logger.info("监测数据缓存集合变更为集合"+(alarmDataFlag?"1":"2"));
	}
	
	/**
	 * 获得 非存放状态的数据集合
	 * @time Mar 7, 2012-3:18:11 PM
	 * @return
	 */
	public static LinkedList<NmsErrorInfo> getNmsErrorList() {
			
			if(!alarmDataFlag){logger.info("取到集合1的缓存告警数据 共"+nmsErrorList1.size());
				return nmsErrorList1;}
			else{logger.info("取到集合2的缓存告警数据 共"+nmsErrorList2.size());
				return nmsErrorList2;}
		
	}
	
	/**
	 * 将监测数据存入存放状态的数据集合中
	 * @time Mar 7, 2012-3:18:58 PM
	 * @param dsb
	 */
	public static void addNmsError(NmsErrorInfo nei) {
		
		synchronized (ALARM_DATA_LOCK) {
			if(nei==null){
				logger.debug("告警数据 字节长度0 无需添加到监测数据集合");
				return;
			}
			
			if(alarmDataFlag){logger.debug("告警数据 添加到 集合1");
			nmsErrorList1.add(nei);}
			else{logger.debug("告警数据 添加到 集合2");
			nmsErrorList2.add(nei);	}
			
		}
		
	}
	/**
	 * 将监测数据存入存放状态的数据集合中
	 * @time Mar 7, 2012-3:18:58 PM
	 * @param seqId
	 * @param dsb
	 */
	public static void addAllAlarmDataList(List<NmsErrorInfo> neiList) {
		
		synchronized (ALARM_DATA_LOCK) {
			if(neiList==null || neiList.size()==0l){
				logger.debug("告警数据 个数0 无需添加到监测数据集合");
				return;
			}
			if(alarmDataFlag){logger.debug("告警数据 添加到 集合1");
				nmsErrorList1.addAll(neiList);}
			else{logger.debug("告警数据 添加到 集合2");
				nmsErrorList2.addAll(neiList);}
		
		}
		
	}
	/**
	 * 清空非存放状态的数据集合
	 * @time Mar 7, 2012-3:19:30 PM
	 * @param seqId
	 * @param dsb
	 */
	public static void clearAlarmDataList() {
		
		synchronized (ALARM_DATA_LOCK) {
			
			getNmsErrorList().clear();
			logger.info("清空该集合");
		}
		
	}
	/**
	 * 获取握手信号
	 * @time Nov 23, 2011-3:49:38 PM
	 */
	public static void acquireHandShakeSemaphore() {
//		synchronized (changeSemaphore) {
			try {
				handShakeSemaphore.acquire();
				logger.debug("变更锁 已申请 剩余可用许可:> "+handShakeSemaphore.availablePermits());
			} catch (Exception e) {
				logger.warn("Changed lock thread failed to apply for ,and it has been interrupted："+Thread.currentThread().interrupted(),e);
			}
//		}
	}
	/**
	 * 释放握手信号
	 * @time Nov 25, 2011-1:24:08 PM
	 */
	public static void releaseHandShakeSemaphore() {
//		synchronized (changeSemaphore) {
		handShakeSemaphore.release();
		logger.debug("变更锁 已释放 当前可用许可:> "+handShakeSemaphore.availablePermits());
//		}
	}
	
	/**
	 * 执行握手线程
	 * 引入 申请信号，和释放信号 操作
	 * @time Sep 12, 2012-4:28:45 PM
	 * @param runnable
	 */
	public static void runHandShakeRunnable(final Object runnable){
		try {
			//-- 针对节点  进行文件推送
			acquireHandShakeSemaphore();		//申请监测信号
			
			//-- 启动新线程 推送文件和任务信息
			final Future<?> future;
			if(runnable instanceof Runnable){
				future = service.submit((Runnable)runnable);
			}else if(runnable instanceof Callable){
				future = service.submit((Callable)runnable);
			}else {
				future = null;
			}
			
			final String threadName =  Thread.currentThread().getName();
			service.submit(new Runnable() {
				
				public void run() {
					Thread.currentThread().setName(threadName);
					try {
						future.get();
					} catch (Exception e) {
						logger.error("",e);
					}finally{
						releaseHandShakeSemaphore();
					}
				}
			});
			
		} catch (Exception e) {
			logger.error("",e);
			releaseHandShakeSemaphore();
		}finally{
			
		}
	}
	
	static{
//		System.out.println("公共信息类加载");
	}
}
