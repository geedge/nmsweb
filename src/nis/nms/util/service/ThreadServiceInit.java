package nis.nms.util.service;

import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpServlet;

import org.apache.log4j.Logger;

import com.nms.thread.DCHandShakeManagerThread;
import com.nms.thread.DetectDatasTimeoutAlarmThread;
import com.nms.thread.DetectInsertThread;
import com.nms.thread.MailingManagerThread;
import com.nms.thread.common.ThreadPoolCommon;
import com.nms.thread.pool.ThreadPoolConfig;

public class ThreadServiceInit  extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5912472395977662214L;
	private Logger logger = Logger.getLogger(ThreadServiceInit.class);
//	private SSLServerSocket sslServer ;

	public void destroy() {
		logger.info("线程池服务销毁");
			//关闭普通线程池
			if(!ThreadPoolCommon.service.isShutdown()){
				ThreadPoolCommon.service.shutdown();
				ThreadPoolCommon.service = null;
				logger.info("普通线程池关闭");
			}
			
			//关闭定时线程池
			if(!ThreadPoolCommon.scheduled.isShutdown()){
				ThreadPoolCommon.scheduled.shutdown();
				ThreadPoolCommon.scheduled = null;
				logger.info("定时线程池关闭");
			}
	}

	public void init() {
		logger.info("线程池服务初始化");
		//-- 创建线程池
		if(ThreadPoolCommon.service ==null || ThreadPoolCommon.service.isShutdown()){
			ThreadPoolCommon.service = Executors.newFixedThreadPool(ThreadPoolConfig.EXECUTOR_SOCKET_THREAD_SIZE);	//非周期执行线程池
		}
		
		if(ThreadPoolCommon.scheduled ==null || ThreadPoolCommon.scheduled.isShutdown()){
			ThreadPoolCommon.scheduled = Executors.newScheduledThreadPool(ThreadPoolConfig.EXECUTOR_SCHEDULED_THREAD_SIZE);	//定时周期执行线程池
		}
		
		//-- 启动业务线程
		Future<?> DCFuture = ThreadPoolCommon.scheduled.scheduleAtFixedRate(new DCHandShakeManagerThread(),ThreadPoolConfig.DC_HANDSHAKE_START,ThreadPoolConfig.DC_HANDSHAKE_PERIOD,TimeUnit.SECONDS);
		ThreadPoolCommon.threadManagerMap.put(ThreadPoolConfig.DC_HANDSHAKE_MANAGER, DCFuture);
		
		//-- 启动检测数据超时告警
		if(ThreadPoolConfig.FLAG_DETEC_TIMEOUT==1){	// true  已启动 终止所有，及关闭操作
			Future<?> TimeoutFuture = ThreadPoolCommon.scheduled.scheduleAtFixedRate(new DetectDatasTimeoutAlarmThread(),10,ThreadPoolConfig.DETEC_TIMEOUT_CHECK_PERIOD,TimeUnit.SECONDS);
			ThreadPoolCommon.threadManagerMap.put(ThreadPoolConfig.DETEC_TIMEOUT_CHECK_MANAGER, TimeoutFuture);
		}
		
		
		//--监测数据入库控制线程，启用会定时轮询通知 dc 入库
		if(ThreadPoolConfig.FLAG_DETECT_INSERT_CONTROL==1){	// true  已启动 终止所有，及关闭操作
			Future<?> TimeoutFuture = ThreadPoolCommon.scheduled.scheduleAtFixedRate(new DetectInsertThread(),10,ThreadPoolConfig.DETECT_INSERT_CONTROL_PERIOD,TimeUnit.SECONDS);
			ThreadPoolCommon.threadManagerMap.put("DetectInsertThread", TimeoutFuture);
		}
		
		
		//-- 邮件发送
		Future<?> TimeoutFuture = ThreadPoolCommon.scheduled.scheduleAtFixedRate(new MailingManagerThread(),60,ThreadPoolConfig.MAILING_PERIOD,TimeUnit.SECONDS);
		ThreadPoolCommon.threadManagerMap.put(ThreadPoolConfig.MAILING_MANAGER, TimeoutFuture);
		
	}
	
	/**
	 * 通讯服务
	 * @time Jan 21, 2013-4:24:32 PM
	 */
	public void startSSLServer(){
		
	}
	
	public void startDCTester(){
		
	}
}
