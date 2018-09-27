package com.nms.thread;

import java.util.concurrent.Future;

import org.apache.log4j.Logger;

import com.nms.thread.common.ThreadPoolCommon;
import com.nms.thread.pool.ThreadPoolConfig;

/**
 *  DC心跳线程启动控制器
 *  @date Jan 21, 2013 4:28:00 PM
 *	@author ZhangGang
 *
 */
public class DCHandShakeManagerThread  implements Runnable{
	
	private Logger logger = Logger.getLogger(DCHandShakeManagerThread.class);
	private DCHandShakeThread handShakeThread = new DCHandShakeThread();
	public void run() {
//		Thread.currentThread().setName("DC心跳监测管理线程");
		Thread.currentThread().setName("DC Heartbeat Monitoring Management Thread");

		//将线程运行程序，尽可能的catch捕获异常
		try {
			//- 检查线程运行状态  运行中无操作
			Future<?> future = ThreadPoolCommon.threadManagerMap.get(ThreadPoolConfig.DC_HANDSHAKE);
			if(future != null && !future.isCancelled() && !future.isDone()){	//运行中
				logger.debug("DC心跳监测线程 运行中 不再启动");
				return ;
			}else{
				future = ThreadPoolCommon.service.submit(handShakeThread);
				ThreadPoolCommon.threadManagerMap.put(ThreadPoolConfig.DC_HANDSHAKE, future);
				logger.debug("DC心跳监测线程 空闲中 再次启动");
			}
			
		} catch (Exception e) {
			logger.error("",e);
		}finally{
			logger.info("执行结束");
		}
	}

}
