package com.nms.thread.pool;

import org.apache.commons.lang.StringUtils;

import nis.nms.util.BaseAction;

public class ThreadPoolConfig {
	public static Integer EXECUTOR_SOCKET_THREAD_SIZE = StringUtils.isNotBlank(BaseAction.rb.getString("executor_socket_thread_size"))? Integer.parseInt(BaseAction.rb.getString("executor_socket_thread_size")): 10 ;//	线程池
	public static Integer EXECUTOR_SCHEDULED_THREAD_SIZE = StringUtils.isNotBlank(BaseAction.rb.getString("executor_scheduled_thread_size"))? Integer.parseInt(BaseAction.rb.getString("executor_scheduled_thread_size")): 5 ;//	线程池
	public static final String DC_HANDSHAKE_MANAGER = "DC_HANDSHAKE_MANAGER";
	public static final String DC_HANDSHAKE = "DC_HANDSHAKE";
	public static final Integer DC_HANDSHAKE_START = StringUtils.isNotBlank(BaseAction.rb.getString("dc.handshake.start"))? Integer.parseInt(BaseAction.rb.getString("dc.handshake.start")):30;
	public static final Integer DC_HANDSHAKE_PERIOD = StringUtils.isNotBlank(BaseAction.rb.getString("dc.handshake.period"))? Integer.parseInt(BaseAction.rb.getString("dc.handshake.period")):60*5;
	public static final String DETEC_TIMEOUT_CHECK_MANAGER = "DETEC_TIMEOUT_CHECK_MANAGER";
	public static final Integer DETEC_TIMEOUT_ALARM_PERIOD_TIMES =2;
	/**
	 * 超时告警 延迟时间，为了防止 国家中心，分中心 两个web 同时判断生成多条 记录
	 */
	public static final Integer DETEC_TIMEOUT_ALARM_PERIOD_DELAY =StringUtils.isNotBlank(BaseAction.rb.getString("detec.timeout.alarm.period.delay"))? Integer.parseInt(BaseAction.rb.getString("detec.timeout.alarm.period.delay")): 5;
	public static final Integer DETEC_TIMEOUT_CHECK_PERIOD = StringUtils.isNotBlank(BaseAction.rb.getString("detec.timeout.check.period"))? Integer.parseInt(BaseAction.rb.getString("detec.timeout.check.period")): 15*60;
	public static final Integer FLAG_DETEC_TIMEOUT = StringUtils.isNotBlank(BaseAction.rb.getString("flag_detec_timeout"))? Integer.parseInt(BaseAction.rb.getString("flag_detec_timeout")):  1;
	
	public static final String MAILING_MANAGER = "errorInfoResoveManager";		//错误信息解析入库管理线程 标识, futureMap 中的Key值
	public static final String MAILING_THREAD = "errorInfoResove";		//错误信息解析入库操作线程 标识, futureMap 中的Key值	
	public static final Integer MAILING_PERIOD =  StringUtils.isNotBlank(BaseAction.rb.getString("mailing_period"))? Integer.parseInt(BaseAction.rb.getString("mailing_period")): 2*60;		//邮件发送周期
	/**
	 * 是否启用 监测入库控制线程
	 */
	public static final Integer FLAG_DETECT_INSERT_CONTROL =  StringUtils.isNotBlank(BaseAction.rb.getString("flag.detect.insert.control"))? Integer.parseInt(BaseAction.rb.getString("flag.detect.insert.control")): 0; 
	/**
	 * 监测入库 控制轮询间隔
	 */
	public static final Integer DETECT_INSERT_CONTROL_PERIOD =  StringUtils.isNotBlank(BaseAction.rb.getString("detect.insert.control.period"))? Integer.parseInt(BaseAction.rb.getString("detect.insert.control.period")): 60; 
}
