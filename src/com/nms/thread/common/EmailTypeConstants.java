package com.nms.thread.common;

public class EmailTypeConstants {
//	private static final Object[][] type =new Object[][]{
//		{10,"监测信息恢复"},
//		{11,"监测信息异常"},
//		{12,"监测信息超时"},
//		{20,"主动告警异常"},
//		{21,"主动告警恢复"},
//		{31,"节点结果失败"},
//		{32,"任务状态变更"},
//		{40,"系统运行异常"},
//		{41,"系统运行恢复"},
//	};
	public static final int FLAG_SEND_LATER = 0;
	public static final int FLAG_SEND_ALLREADY = 1;
	public static final int FLAG_SEND_IMMEDIATELY = 2;
	
	public static final int URGENT_IMMEDIATELY = 0;
	public static final int URGENT_LATER = 1;
	
	
	public static final int TYPE_DETECTION_INFO_RECOVER = 10;
	public static final String DESC_DETECTION_INFO_RECOVER = "i18n_EmailTypeConstants.content.DESC_DETECTION_INFO_RECOVER_n81i";
	public static final int TYPE_DETECTION_INFO_EXCEPTION = 11;
	public static final String DESC_DETECTION_INFO_EXCEPTION = "i18n_EmailTypeConstants.content.DESC_DETECTION_INFO_EXCEPTION_n81i";
	public static final int TYPE_DETECTION_INFO_TIMEOUT = 12;
	public static final String DESC_DETECTION_INFO_TIMEOUT = "i18n_EmailTypeConstants.content.DESC_DETECTION_INFO_TIMEOUT_n81i";
	
	public static final int TYPE_ALARM_INFO_EXCEPTION = 20;
	public static final String DESC_ALARM_INFO_EXCEPTION = "i18n_EmailTypeConstants.content.DESC_ALARM_INFO_EXCEPTION_n81i";
	public static final int TYPE_ALARM_INFO_RECOVER = 21;
	public static final String DESC_ALARM_INFO_RECOVER = "i18n_EmailTypeConstants.content.DESC_ALARM_INFO_RECOVER_n81i";
	
	public static final int TYPE_TASK_NODE_RESULT_ERROR = 31;
	public static final String DESC_TASK_NODE_RESULT_ERROR = "i18n_EmailTypeConstants.content.DESC_TASK_NODE_RESULT_ERROR_n81i";
	public static final int TYPE_TASK_STATE_CHANGE = 32;
	public static final String DESC_TASK_STATE_CHANGE = "i18n_EmailTypeConstants.content.DESC_TASK_STATE_CHANGE_n81i";
	
	public static final int TYPE_SYSTEM_RUNNING_EXCEPTION = 40;
	public static final String DESC_SYSTEM_RUNNING_EXCEPTION = "i18n_EmailTypeConstants.content.DESC_SYSTEM_RUNNING_EXCEPTION_n81i";
	public static final int TYPE_SYSTEM_RUNNING_RECOVER = 41;
	public static final String DESC_SYSTEM_RUNNING_RECOVER = "i18n_EmailTypeConstants.content.DESC_SYSTEM_RUNNING_RECOVER_n81i";
}
