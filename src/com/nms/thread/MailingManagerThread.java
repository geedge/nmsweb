package com.nms.thread;

import java.util.List;
import java.util.ResourceBundle;
import java.util.concurrent.Future;

import nis.nms.util.BaseAction;
import nis.nms.util.ConnectionOracle;
import nis.nms.util.ResourceBundleWrapper;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.nms.thread.common.ThreadPoolCommon;
import com.nms.thread.pool.ThreadPoolConfig;


/**
 * 
 *  邮件发送管理器
 *  @date Mar 29, 2013 10:37:27 AM
 *	@author ZhangGang
 *
 */
public class MailingManagerThread implements Runnable{
	private Logger logger = Logger.getLogger(MailingManagerThread.class);

	private boolean emailConfigSuccess = true;
	private boolean dbErrorInfoFlag = true;
	private boolean dbInitFlag = true;
	
	public void run() {
		//将线程运行程序，尽可能的catch捕获异常
//		Thread.currentThread().setName("邮件发送管理线程");
		Thread.currentThread().setName("Mail Send Management Thread");
		ConnectionOracle dao = null;
		try {
			dao = ConnectionOracle.getConnection();
			List<String> flaglist = dao.dbSelectSingleColumn("select t.type_state from type_table t where t.type_identity='emailflag'");//type_state:0启用；1：停用
			if(flaglist!=null&&flaglist.size()>0){//未配置emailflag，则默认为发送邮件
				String flag = flaglist.get(0);
				if(!"0".equals(flag)){
					logger.info("邮件功能未开启");
					return;
				}
			}		
			
			ResourceBundleWrapper rb = BaseAction.rb;			
			String address = rb.getString("email.address");
			String userName = rb.getString("email.userName");
			String password = rb.getString("email.password");
			String host = rb.getString("email.host");
			
			String errorInfo = null;
			if(StringUtils.isBlank(address)){
				emailConfigSuccess = false;
//				errorInfo += "缺少参数 email.address;";
//				logger.error("邮件功能已开启但缺少参数 email.address");
				errorInfo += "Lack of parameters email.address;";
				logger.error("The Email function has been opened,but the parameter email.address is missing");
			}
			
			if(StringUtils.isBlank(userName)){
				emailConfigSuccess = false;
//				errorInfo += "缺少参数 email.userName;";
//				logger.error("邮件功能已开启但缺少参数 email.userName");
				errorInfo += "Lack of parameters email.userName;";
				logger.error("The Email function has been opened,but the parameter email.userName is missing");
			}
			
			if(StringUtils.isBlank(password)){
				emailConfigSuccess = false;
//				errorInfo += "缺少参数 email.password;";
//				logger.error("邮件功能已开启但缺少参数 email.password");
				errorInfo += "Lack of parameters email.password;";
				logger.error("The Email function has been opened,but the parameter email.password is missing");
			}
			
			if(StringUtils.isBlank(host)){
				emailConfigSuccess = false;
//				errorInfo += "缺少参数 email.host;";
//				logger.error("邮件功能已开启但缺少参数 email.host");
				errorInfo += "Lack of parameters email.host;";
				logger.error("The Email function has been opened,but the parameter email.host is missing");
			}
			
			if(!emailConfigSuccess){
				logger.error("Mail function can not be started");
				return;
			}
			
			
			//- 检查线程运行状态  运行中无操作
			Future<?> future = ThreadPoolCommon.threadManagerMap.get(ThreadPoolConfig.MAILING_THREAD);
			if(future != null && !future.isCancelled() && !future.isDone()){	//运行中
				logger.info("邮件发送线程 运行中 不再启动新线程");
			}
			
			//- 非升级操作判断
			logger.info("邮件发送线程  空闲中 启动新解析线程");
			//-- 获取线程执行 需进行主动告警和邮件通知等相关操作，待考虑
			future = ThreadPoolCommon.service.submit(new MailingThread());
			//注册
			ThreadPoolCommon.threadManagerMap.put(ThreadPoolConfig.MAILING_THREAD, future);
			logger.debug("执行结束");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(dao != null){
					dao.close();
				}
			} catch (Exception e2) {
			}
		}
	}
	
	
	public static void main(String [] args) {
		Thread thread = new Thread(new MailingManagerThread());
		thread.start();
		try {
			Thread.sleep(10000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		System.exit(0);
	}
}
