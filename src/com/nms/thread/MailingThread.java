package com.nms.thread;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.concurrent.Callable;

import nis.nms.bean.EmailInfo;
import nis.nms.util.ConnectionOracle;

import org.apache.log4j.Logger;

import com.nms.thread.common.ThreadPoolCommon;
import com.nms.thread.service.EmailService;

/**
 * CSV解析线程
 * 
 * @author ZGGG3
 * 
 */
public class MailingThread implements Callable<Object> {
	Logger logger = Logger.getLogger(MailingThread.class);
	volatile boolean stop = false;// 线程是否被取消标志
	private static long startTime;
	Long waitTime = 30 * 60 * 1000l;

	// 初始化starttime 在重启服务器的时候
	static {
		ConnectionOracle dao  = null;
		try {
			dao = ConnectionOracle.getConnection();
			List<String> emaillist = dao.dbSelectSingleColumn(
					"select to_char(create_time,'yyyy-mm-dd hh24:mi:ss') create_time from email_table where send_flag='0' and send_level='1' order by create_time asc");
			if (emaillist != null && emaillist.size() > 0) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				if (emaillist.get(0) != null && !emaillist.get(0).equals("")) {
					Date d = sdf.parse(emaillist.get(0));
					startTime = d.getTime();
				} else {
					startTime = System.currentTimeMillis();
				}
			} else {
				startTime = System.currentTimeMillis();
			}
			System.out.println("====static===,startTime=" + startTime);
			System.out.println("====static===,startTime=" + new Date(startTime));
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				if(dao != null){
					dao.close();
				}
			} catch (Exception e2) {
			}
		}

	}

	/*
	 * 线程操作
	 * 
	 * 依次解析urlList中仍存在的Files
	 * 
	 * 实现了依次解析Files，由于后期实现多线程解析操作
	 */
	public Object call() {
		// 为当前线程命名 ，用与开发阶段友好输出。
		// Thread.currentThread().setName("邮件发送线程");
		Thread.currentThread().setName("Mail Sending Thread");
		logger.info("**************startTime=" + startTime + "startTimeStr=" + new Date(startTime) + ",waitTime=" + waitTime);
		ConnectionOracle dao = null;
		try {
			dao = ConnectionOracle.getConnection();

			boolean sendflag = true;// 发送标识 若非紧急状态下延时时间为-1 则不发送非紧急邮件
			List<String> timelist = dao.dbSelectSingleColumn(
					"select t.delay_time from option_table t where t.type_identity='emergent' and t.type_code='1'");
			if (timelist != null && timelist.size() > 0) {
				logger.info("delayTime:" + timelist.get(0));
				if (timelist.get(0).equals("-1")) {
					sendflag = false;
				}
				try {
					waitTime = Long.parseLong(timelist.get(0)) * 60 * 1000;
				} catch (Exception e) {
					logger.error("Non emergency time setting error", e);
				}
			}
			EmailService service = new EmailService(dao);
			boolean flag = false;// 时间标识 若等待时间大于等于设定周期 则发送非紧急邮件 否则不发送

			System.out.println("当前时间：" + new Date() + ",=" + System.currentTimeMillis());
			System.out.println("startTime=" + startTime);
			System.out.println("waitTime=" + waitTime);
			System.out.println("startTimeStr=" + new Date(startTime));
			System.out.println("startTimeWaitTimeStr=" + new Date(startTime + waitTime));
			logger.info("当前时间：" + new Date() + ",=" + System.currentTimeMillis());
			logger.info("startTime=" + startTime);
			logger.info("waitTime=" + waitTime);
			logger.info("startTimeStr=" + new Date(startTime));
			logger.info("startTimeWaitTimeStr=" + new Date(startTime + waitTime));

			if (startTime + waitTime < System.currentTimeMillis()) {
				flag = true;
				startTime = startTime + waitTime;// 每个周期结束后重新设定起始时间，起始时间增加值为设定周期时间
				logger.info(new Date(startTime));
			}
			logger.info("----------" + new Date(startTime) + "延时设置：" + sendflag + ",到时，发送非紧急邮件：" + flag);
			// 发送标识和时间标识皆为true时 系统发送非紧急邮件 （注：预防设定非紧急状态下的延时时间为-1时
			// 系统按照默认30分钟发送非紧急邮件）
			List<EmailInfo> eiList = service.getEmailInfoList(sendflag, flag);
			// -- 空数据集合 结束操作
			if (eiList == null || eiList.size() == 0) {
				return null;
			}
			long sTime = System.currentTimeMillis();
			service.sendEmailNew(eiList);
			long eTime = System.currentTimeMillis();
			logger.debug("本次邮件发送耗时： " + (sTime - eTime) + " ms");
		} catch (Exception e) {
			logger.error("Running exception", e);
		} finally {
			try {
				if(dao != null){
					dao.close();
				}
			} catch (Exception e2) {
			}
			logger.debug("线程结束");
		}

		return null;
	}

	public static void main(String[] args) {
		ThreadPoolCommon.service.submit(new MailingThread());
	}
}
