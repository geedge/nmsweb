package com.nms.thread.service;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Map.Entry;

import nis.nms.bean.ContactSetInfo;
import nis.nms.bean.EmailInfo;
import nis.nms.bean.EmailModel;
import nis.nms.filter.I18n;
import nis.nms.util.BaseAction;
import nis.nms.util.ConnectionOracle;
import nis.nms.util.SendMail;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.nis.util.StringUtil;
import com.nms.thread.common.EmailTypeConstants;
import com.nms.thread.common.TaskResources;
import com.nms.thread.utils.SQLExecuteTimeoutException;



/**
 *  创建并保存邮件信息
 *  查询邮件信息并将邮件信息整理成单一邮件进行查询
 *  @date Feb 6, 2012 10:17:56 AM
 *	@author ZhangGang
 *
 */
public class EmailService {
	private final Logger logger = Logger.getLogger(EmailService.class);
	private final String FROM_ADDRESS = BaseAction.rb.getString("email.address");
	
	
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private ConnectionOracle dao = null;

	public EmailService(ConnectionOracle dao){
		this.dao = dao;
	}
	
	public List<EmailInfo> getEmailInfoList(boolean sendflag//非紧急邮件是否发送标识
			, boolean flag//是否到达周期时间标识
	) {
		String selectSql = "";
		Object [] params = new Object[]{EmailTypeConstants.FLAG_SEND_LATER};
		List<EmailInfo> eiList = new LinkedList<EmailInfo>();
		
		//非紧急周期不为-1，即按设定周期发送非紧急邮件
		if (sendflag) {
			// 到达周期时间
			if (flag) {
				selectSql = "select et.id , et.to_address ,et.action_type ,et.action_desc ,et.action_ip ,to_char(et.action_date,'yyyy-mm-dd hh24:mi:ss') action_date,"
						+ "et.content,et.send_level from email_table et where et.send_flag = ? and ( et.send_level=0 or et.send_level is null or et.send_level=1) "
						+ "order by et.send_level asc,et.action_date asc";
logger.info("发送非紧急邮件："+selectSql);
			} else {
				selectSql = "select et.id from email_table et where et.send_flag = ? and ( et.send_level=0 or et.send_level is null) "
						+ "order by et.send_level asc,et.action_date asc";
logger.info("发送紧急邮件？："+selectSql);
				List<String> emailList = null;
				try {
					emailList = dao.dbSelectSingleColumn(selectSql,
							params);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}// 判断是否存在紧急邮件
				if (emailList != null && emailList.size() > 0) {// 非周期时间时，查询是否有紧急邮件
																// ，如有则发送紧急邮件并附加非紧急邮件，如无则不发送邮件
					selectSql = "select et.id , et.to_address ,et.action_type ,et.action_desc ,et.action_ip ,to_char(et.action_date,'yyyy-mm-dd hh24:mi:ss') action_date,"
							+ "et.content,et.send_level from email_table et where et.send_flag = ? and ( et.send_level=0 or et.send_level is null or et.send_level=1) "
							+ "order by et.send_level asc,et.action_date asc";
logger.info("发送紧急邮件，添加非紧急邮件："+selectSql);
				}else{
logger.info("无需发送紧急邮件");
					return eiList;
				}
			}
		} else { // 非紧急邮件不发送
			selectSql = "select et.id , et.to_address ,et.action_type ,et.action_desc ,et.action_ip ,to_char(et.action_date,'yyyy-mm-dd hh24:mi:ss') action_date,"
					+ "et.content,et.send_level from email_table et where et.send_flag = ? and ( et.send_level=0 or et.send_level is null) "
					+ "order by et.send_level asc,et.action_date asc";
logger.info("只需发送紧急邮件");
		}
		ArrayList<String> fields = new ArrayList<String>();
		fields.add("id");
		fields.add("to_address");
		fields.add("action_type");
		fields.add("action_desc");
		fields.add("action_ip");
		fields.add("action_date");
		fields.add("content");
		fields.add("send_level");
		
		try {
			ArrayList<Map<String, String>> mapsList = dao.dbSelect(selectSql, fields, params);
			if(mapsList!=null && mapsList.size()>0){
				for(Map<String, String> maps : mapsList){
					EmailInfo ei = new EmailInfo();
					ei.setId(StringUtils.isEmpty(maps.get("id"))?null:Long.parseLong(maps.get("id")));
logger.info("id="+ei.getId());
					ei.setToAddress(maps.get("to_address"));
					ei.setActionType(StringUtils.isEmpty(maps.get("action_type"))?null:Integer.parseInt(maps.get("action_type")));
					ei.setActionDesc(maps.get("action_desc"));
					ei.setActionIp(maps.get("action_ip"));
					ei.setActionDate(maps.get("action_date"));
					ei.setContent(maps.get("content"));
					ei.setSendFlag(StringUtils.isEmpty(maps.get("send_level"))?null:Integer.parseInt(maps.get("send_level")));
					ei.setSendLevel(StringUtils.isEmpty(maps.get("send_level"))?null:Integer.parseInt(maps.get("send_level")));
					eiList.add(ei);
				}
			}
		} catch (Exception e) {
			logger.error("Query Email information failed!", e);
		}
		
		return eiList;
	}
	
	public String getEmailTypeDescByTypeValue(int type){
		switch (type) {
		
		case EmailTypeConstants.TYPE_DETECTION_INFO_RECOVER:
			return EmailTypeConstants.DESC_DETECTION_INFO_RECOVER;
		case EmailTypeConstants.TYPE_DETECTION_INFO_EXCEPTION:
			return EmailTypeConstants.DESC_DETECTION_INFO_EXCEPTION;
		case EmailTypeConstants.TYPE_DETECTION_INFO_TIMEOUT:
			return EmailTypeConstants.DESC_DETECTION_INFO_TIMEOUT;
			
		case EmailTypeConstants.TYPE_ALARM_INFO_EXCEPTION:
			return EmailTypeConstants.DESC_ALARM_INFO_EXCEPTION;
		case EmailTypeConstants.TYPE_ALARM_INFO_RECOVER:
			return EmailTypeConstants.DESC_ALARM_INFO_RECOVER;
			
		case EmailTypeConstants.TYPE_TASK_NODE_RESULT_ERROR:
			return EmailTypeConstants.DESC_TASK_NODE_RESULT_ERROR;
		case EmailTypeConstants.TYPE_TASK_STATE_CHANGE:
			return EmailTypeConstants.DESC_TASK_STATE_CHANGE;
			
		case EmailTypeConstants.TYPE_SYSTEM_RUNNING_EXCEPTION:
			return EmailTypeConstants.DESC_SYSTEM_RUNNING_EXCEPTION;
		case EmailTypeConstants.TYPE_SYSTEM_RUNNING_RECOVER:
			return EmailTypeConstants.DESC_SYSTEM_RUNNING_RECOVER;

		default:
			return null;
		}
		
	}
	public void sendEmailForDetection(Long dId,EmailInfo emailInfo){
	//- 邮件功能开启判断
		if("0".equals(BaseAction.rb.getString("email.host"))){
			logger.warn("The Email function has bean successfully stoped");
			return;
		}
		
		//- 数据校验 无效返回
		if(dId==null || dId.longValue() == 0l){
			return;
		}
		
		//- 无效状态过滤
		if(emailInfo.getSendFlag()==null || emailInfo.getSendFlag()==1){	//无需发送的邮件 ，无需保存
			return;
		}
		
		//- 查询联系人设置信息
		ContactSetInfo contactSetInfo  = this.getContactSetInfoByDetecId(dId);
		
		//- 整理联系人邮件
		List<EmailInfo> eiList = new LinkedList<EmailInfo>();
		List<String> emaiList =  this.getEmailList(contactSetInfo);
		if(emaiList!=null && emaiList.size()>0){
			for(String addr : emaiList){
				if(StringUtils.isEmpty(addr))continue;		//邮件地址不为空
				EmailInfo emailInfo2 = new EmailInfo(emailInfo);
				emailInfo2.setToAddress(addr);
				eiList.add(emailInfo2);
			}
		}
	
		/*//- 是否即时发送
		if(emailInfo.getSendFlag()==2){	//即时发送
			this.sendEmail(eiList);
		}*/
		
		//- 保存入库
		try {
			saveEmailInfoList(eiList);
		} catch (SQLExecuteTimeoutException e) {
			logger.error("",e);
		} catch (SQLException e) {
			logger.error("",e);
		}

	}
	
	/**
	 * 增加处理紧急和非紧急邮件信息
	 * @time May 30, 2013-9:04:19 PM
	 * @param eiList
	 */
	public void sendEmailNew(List<EmailInfo> eiList){

		// 为当前线程命名 ，用与开发阶段友好输出。
//		Thread.currentThread().setName("邮件发送线程");
		Thread.currentThread().setName("Mail Sending Thread");
		try {
			//-- 空数据集合 结束操作
			if(eiList == null || eiList.size() == 0 ){
				return ;
			}
			
			Collections.sort(eiList, new ComparatorEmailInfo());
			
			long sTime = System.currentTimeMillis();
			logger.debug("待整理邮件数 " + (eiList.size())+ "条，整理开始");
logger.info("待整理邮件数 " + (eiList.size())+ "条，整理开始");
			
			String trMark = "@tr0@";
			String tableModel = "<table cellpadding='0' cellspacing='0' border='1' width='750px'>" +
					"<tr align='center'><th width='120px'>i18n_EmailService.sendEmailNew.msgType_n81i</th><th width='100px'>i18n_EmailService.sendEmailNew.msgDesc_n81i</th><th width='70px'>i18n_EmailService.sendEmailNew.eventIp_n81i</th><th width='160px'>i18n_EmailService.sendEmailNew.time_n81i</th><th width='300px'>i18n_EmailService.sendEmailNew.msgContent_n81i</th></tr>" +
					trMark+"</table>";
			String trModel = "<tr align='center'><td>@args0@</td><td>@args1@</td><td>@args2@</td><td>@args3@</td><td>@args4@</td></tr>";
			
			Iterator<EmailInfo> ite = eiList.iterator();
			Map<String,EmailModel> emMap = new HashMap<String,EmailModel>();

			while (ite.hasNext()) {
				EmailInfo ei = ite.next();
				EmailModel em = emMap.get(ei.getToAddress());
				if(em == null){
					em = new EmailModel();
					em.setToAddress(ei.getToAddress());
					em.setSendFlag(1);//初始化发送标识为1
//					em.setSubjectDesc("NMS系统邮件");
					em.setSubjectDesc("i18n_EmailService.sendEmailNew.subjectDesc_n81i");
					if(ei.getSendLevel()==null||ei.getSendLevel()==0){//向emMap中添加新地址时  判断如果存在紧急通知 则添加紧急通知表头  不存在则不添加
						em.setContent(new String(tableModel).replace("@tr0@", "<tr align='center'><td colspan='5'><h3>i18n_EmailService.sendEmailNew.emergencyNotice_n81i</h3></td></tr>@tr0@"));
					}else{
						em.setContent(new String(tableModel));
					}
					emMap.put(ei.getToAddress(), em);
				}
				String thisTr = new String(trModel);
				if(ei.getSendLevel()!=null&&ei.getSendLevel()==1&&em.getSendFlag()==1){ //第一次发现非紧急通知时 添加非紧急通知表头
					thisTr = "<tr align='center'><td colspan='5'><h3>i18n_EmailService.sendEmailNew.noEmergencyNotice_n81i</h3></td></tr>"+thisTr;
					em.setSendFlag(2);//添加非紧急通知表头后，设置发送标识为2.防止多次添加非紧急通知表头
				}		
				
				//追加类型描述
				thisTr = thisTr.replace("@args0@", getEmailTypeDescByTypeValue(ei.getActionType())+"");
				
				//追加事件描述
				thisTr = thisTr.replace("@args1@", ei.getActionDesc()==null?"":ei.getActionDesc());
				
				//追加IP描述
				thisTr = thisTr.replace("@args2@", StringUtils.isEmpty(ei.getActionIp())?"":ei.getActionIp());
				
				//追加时间描述
				thisTr = thisTr.replace("@args3@", ei.getActionDate()==null?"":ei.getActionDate());
				thisTr = thisTr.replace("@args4@", ei.getContent()==null?"":ei.getContent());
				em.setContent(em.getContent().replace("@tr0@", thisTr+"@tr0@"));
			}
			
			if(emMap.size()>0){
logger.info("共"+emMap.size()+"封邮件");
				SendMail cn = new SendMail();
				Iterator<Entry<String,EmailModel>> emIte = emMap.entrySet().iterator();
				while (emIte.hasNext()) {
					Entry<String,EmailModel> emEntry = (Entry<String,EmailModel>) emIte.next();
					System.out.println("邮件地址："+emEntry.getKey());
logger.info("邮件地址："+emEntry.getKey());
					EmailModel em = emEntry.getValue();
					System.out.println("邮件标题："+em.getSubjectDesc());
					System.out.println("邮件内容："+em.getContent());
logger.info("邮件标题："+em.getSubjectDesc());
logger.info("邮件内容："+em.getContent());
					
					if(StringUtils.isEmpty(em.getToAddress()))continue;
					logger.debug("邮件 To "+(em.getToAddress()));
logger.info("邮件 To "+(em.getToAddress()));
					// 设置发件人地址、收件人地址和邮件标题
					this.getI18nEmail(em);
					cn.sendHTML(FROM_ADDRESS,em.getToAddress(), em.getSubjectDesc(),em.getContent().replace("@tr0@", ""));
//					break;
				}
				
				//更新库表ID
				ite = eiList.iterator();
				StringBuffer ids = new StringBuffer("0");
				int i = 0;

				while (ite.hasNext()) {
					EmailInfo ei = ite.next();
					if(ei==null || ei.getId()==null){
						continue;
					}
					ids.append(","+ei.getId());
					i++;
					if(i>900){
						dao.dbUpdate("update email_table et set et.SEND_FLAG = 1 where et.id in("+ids+")");
						ids.delete(1, ids.length());
						i = 0;
					}
				}
				if(i>0){
					dao.dbUpdate("update email_table et set et.SEND_FLAG = 1 where et.id in("+ids+")");
					ids.delete(1, ids.length());
					i = 0;
				}
			}
		} catch (Exception e) {
			logger.error("Running Exception",e);
		}finally{
			if(dao != null)dao.close();
			logger.debug("线程结束");
		}
		
		return ;
	}
	
	public void getI18nEmail(EmailModel em) {
		String sql="select t.language from xt_yh_jbxx t where email=?";
		try {
			ArrayList<String> result = dao.dbSelectSingleColumn(sql, em.getToAddress());
			String language=result.get(0);
			Locale locale;
			if(!StringUtil.isEmpty(language)){
				pl("用户语言："+language);
				String[] split = language.split("_");
				locale= new Locale(split[0],split[1]);
			}else{
				locale=I18n.defaultLang;
			}
			if(locale==null){
				throw new Exception("International language init faild!");
			}
			String contentTemp=em.getContent();
			contentTemp=contentTemp.substring(contentTemp.lastIndexOf("i18n_"));
			int indexOf = contentTemp.indexOf("_n81i");
			if(indexOf==-1){
				contentTemp=em.getContent();
				contentTemp=contentTemp.substring(0,contentTemp.lastIndexOf("【"))+contentTemp.substring(contentTemp.lastIndexOf("</td>"));
			}
			System.err.println("contentTemp:"+contentTemp);
			String content = I18n.trans(contentTemp, locale);
			em.setContent(content);
			String subject=I18n.trans(em.getSubjectDesc(), locale);
			em.setSubjectDesc(subject);
			
		} catch (Exception e) {
			logger.warn("I18n trans failed!");
			e.printStackTrace();
		}
	}

	public void sendEmail(List<EmailInfo> eiList){

		// 为当前线程命名 ，用与开发阶段友好输出。
//		Thread.currentThread().setName("邮件发送线程");
		Thread.currentThread().setName("Mail Sending Thread");
		try {
			//-- 空数据集合 结束操作
			if(eiList == null || eiList.size() == 0 ){
				return ;
			}
			long sTime = System.currentTimeMillis();
			logger.debug("待整理邮件数 " + (eiList.size())+ "条，整理开始");
			
			String trMark = "@tr0@";
			String tableModel = "<table cellpadding='0' cellspacing='0' border='1' width='750px'>" +
					"<tr align='center'><th width='120px'>i18n_EmailService.sendEmailNew.msgType_n81i</th><th width='100px'>i18n_EmailService.sendEmailNew.msgDesc_n81i</th><th width='70px'>i18n_EmailService.sendEmailNew.eventIp_n81i</th><th width='160px'>i18n_EmailService.sendEmailNew.time_n81i</th><th width='300px'>i18n_EmailService.sendEmailNew.msgContent_n81i</th></tr>" +
					trMark+"</table>";
			String trModel = "<tr align='center'><td>@args0@</td><td>@args1@</td><td>@args2@</td><td>@args3@</td><td>@args4@</td></tr>";
			
			Iterator<EmailInfo> ite = eiList.iterator();
			Map<String,EmailModel> emMap = new HashMap<String,EmailModel>();

			while (ite.hasNext()) {
				EmailInfo ei = ite.next();
				ei.setSendFlag(1);	//置为已发送
				EmailModel em = emMap.get(ei.getToAddress());
				if(em == null){
					em = new EmailModel();
					em.setToAddress(ei.getToAddress());
//					em.setToAddress("zhanggang@intranet.com");
					
					em.setSubjectDesc("i18n_EmailService.sendEmailNew.subjectDesc_n81i");
					em.setContent(new String(tableModel));
					emMap.put(ei.getToAddress(), em);
				}
				String thisTr = new String(trModel);
				
				//追加类型描述
//				if(ei.getActionType() != oldEI.getActionType()){
					thisTr = thisTr.replace("@args0@", getEmailTypeDescByTypeValue(ei.getActionType())+"");
//					System.out.println(""+service.getEmailTypeDescByTypeValue(ei.getActionType()));
//				}else{
//					thisTr = thisTr.replace("@args1@", "&nbsp;");
//				}
				
				//追加事件描述
//				if(StringUtils.isNotBlank(ei.getActionDesc()) && !ei.getActionDesc().equalsIgnoreCase(oldEI.getActionDesc())){
					thisTr = thisTr.replace("@args1@", ei.getActionDesc()==null?"":ei.getActionDesc());
//				}else{
//					thisTr = thisTr.replace("@args2@", "&nbsp;");
//				}
				
				//追加IP描述
//				StringBuffer tdContent = new StringBuffer();
//				if(StringUtils.isNotBlank(ei.getActionIp()) && !ei.getActionIp().equalsIgnoreCase(oldEI.getActionIp())){
				thisTr = thisTr.replace("@args2@", StringUtils.isEmpty(ei.getActionIp())?"":ei.getActionIp());
//				}else{
//					tdContent.append("\t ");
//				}
				
				//追加时间描述
//				if(StringUtils.isNotBlank(ei.getActionDate()) && !ei.getActionDate().equalsIgnoreCase(oldEI.getActionDate())){
				thisTr = thisTr.replace("@args3@", ei.getActionDate()==null?"":ei.getActionDate());
//				}else{
//					tdContent.append("\t ");
//				}
				thisTr = thisTr.replace("@args4@", ei.getContent()==null?"":ei.getContent());
//				tdContent.append(ei.getContent());
//				HtmlUtils.htmlEscapeHex(tdContent.toString());
//				System.out.println(""+HtmlUtils.htmlEscapeHex(tdContent.toString()));
				
//				thisTr = thisTr.replace("@args3@", HtmlUtils.htmlEscapeHex(tdContent.toString()));
//				thisTr = thisTr.replace("@args3@", tdContent.toString());
				em.setContent(em.getContent().replace("@tr0@", thisTr+"@tr0@"));
				
				//追加内容
				
				//换行和更新oldEI处理
//				trContent.append(thisTr);
//				oldEI = ei;
			}
			
			if(emMap.size()>0){
				SendMail cn = new SendMail();
				Iterator<Entry<String,EmailModel>> emIte = emMap.entrySet().iterator();
				while (emIte.hasNext()) {
					Entry<String,EmailModel> emEntry = (Entry<String,EmailModel>) emIte.next();
					System.out.println("邮件地址："+emEntry.getKey());
					EmailModel em = emEntry.getValue();
					System.out.println("邮件标题："+em.getSubjectDesc());
					System.out.println(""+em.getContent());
					
					if(StringUtils.isEmpty(em.getToAddress()))continue;
					logger.debug("邮件 To "+(em.getToAddress()));
					// 设置发件人地址、收件人地址和邮件标题
					this.getI18nEmail(em);
					cn.sendHTML(FROM_ADDRESS,em.getToAddress(), em.getSubjectDesc(),em.getContent().replace("@tr0@", ""));
//					break;
				}
				
				//更新库表ID
				ite = eiList.iterator();
				StringBuffer ids = new StringBuffer("0");
				int i = 0;

				while (ite.hasNext()) {
					EmailInfo ei = ite.next();
					if(ei==null || ei.getId()==null){
						continue;
					}
					ids.append(","+ei.getId());
					i++;
					if(i>900){
						dao.dbUpdate("update email_table et set et.SEND_FLAG = 1 where et.id in("+ids+")");
						ids.delete(1, ids.length());
						i = 0;
					}
				}
				if(i>0){
					dao.dbUpdate("update email_table et set et.SEND_FLAG = 1 where et.id in("+ids+")");
					ids.delete(1, ids.length());
					i = 0;
				}
			}
		} catch (Exception e) {
			logger.error("Running Exception",e);
		}finally{
			if(dao != null)dao.close();
			logger.debug("线程结束");
		}
		
		return ;
	}
	
	public void sendEmailForDetectionBySeqId(Long dId,Long seqId,EmailInfo emailInfo){
//		if(Constants.FLAG_EMAIL == 0){
//			logger.warn("邮件功能已关闭");
//			return;
//		}
		
		//-- 数据校验 无效返回
		if(dId==null || dId.longValue() == 0l || seqId==null || seqId.longValue() == 0l){
			return;
		}
		
		//-- 查询联系人设置信息
		ContactSetInfo contactSetInfo  = this.getContactSetInfoByDetecId(dId);
		
		//-- 获取联系人列表
		List<EmailInfo> eiList = new LinkedList<EmailInfo>();
		List<String> emaiList = this.getEmailList(contactSetInfo, seqId);
		logger.debug("邮件数量 "+(emaiList==null?null:emaiList.size()));
		if(emaiList!=null && emaiList.size()>0){

			for (Iterator emailIte = emaiList.iterator(); emailIte.hasNext();) {
				String addr = (String) emailIte.next();
				if(StringUtils.isEmpty(addr))continue;		//邮件地址不为空
				EmailInfo emailInfo2 = new EmailInfo(emailInfo);
				emailInfo2.setToAddress(addr);
				eiList.add(emailInfo2);
			}
			
			try {
				if(emailInfo.getSendFlag()==0){	//保存入库
					saveEmailInfoList(eiList);
				}else{	//即时发送
					
				}
			} catch (SQLExecuteTimeoutException e) {
				logger.error("",e);
			} catch (SQLException e) {
				logger.error("",e);
			}
		}
	}
	
	public void sendEmailForMissionBySeqId(Long mId,int missionType,Long seqId,EmailInfo emailInfo){
//		if(Constants.FLAG_EMAIL == 0){
//			logger.warn("邮件功能已关闭");
//			return;
//		}
		//-- 数据校验 无效返回
		if(mId==null || mId.longValue() == 0l || missionType==0 || seqId==null || seqId.longValue() == 0l){
			return;
		}
		//-- 查询联系人设置信息
		ContactSetInfo contactSetInfo  = this.getContactSetInfoByMissionId(mId);
		//-- 获取联系人列表
		List<EmailInfo> eiList = new LinkedList<EmailInfo>();
		List<String> emaiList = this.getEmailList(contactSetInfo, seqId);
		logger.debug("邮件数量 "+(emaiList==null?null:emaiList.size()));
		//-- 发邮件
		if(emaiList!=null && emaiList.size()>0){
			for (Iterator emailIte = emaiList.iterator(); emailIte.hasNext();) {
				String addr = (String) emailIte.next();
				if(StringUtils.isEmpty(addr))continue;
				EmailInfo emailInfo2 = new EmailInfo(emailInfo);
				emailInfo2.setToAddress(addr);
				eiList.add(emailInfo2);
			}
		}
		
		try {
			if(emailInfo.getSendFlag()==0){	//保存入库
				saveEmailInfoList(eiList);
			}else{	//即时发送
				
			}
		} catch (SQLExecuteTimeoutException e) {
			logger.error("",e);
		} catch (SQLException e) {
			logger.error("",e);
		}
		//-结束
	}
	
	/**
	 * 任务执行邮件通知方法
	 * 任务类型 1 根据 系统 用户组 指定用户处理
	 * 任务类型 4 根据 系统 用户组 指定用户处理
	 * 任务类型 6 根据 下发机器 的管理用户发送通知
	 * @time Mar 28, 2012-1:53:56 PM
	 * @param mission	任务信息
	 * @param emaiTitle	主题
	 * @param emailContext	内容
	 */
	public void sendEmailForMission(Long missionId,String emaiTitle,String emailContext){
//		if(Constants.FLAG_EMAIL == 0){
//			logger.warn("邮件功能已关闭");
//			return;
//		}
		
		//-- 参数校验
		if(missionId==null || StringUtils.isEmpty(emaiTitle) || StringUtils.isEmpty(emailContext)){
			return;
		}
		
		ContactSetInfo info = this.getContactSetInfoByMissionId(missionId);
		LinkedList<String> emailList = null;
		
		ResourceBundle res = ResourceBundle.getBundle(TaskResources.class.getName());
//		ContactSetInfo info = getContactSetInfoByMissionId(mId,mType);
		String startTime = "";
		String endTime = "";
		if(info.getStartTime()!=null){
			startTime = format.format(info.getStartTime());
		}
		if(info.getEndTime()!=null){
			endTime = format.format(info.getEndTime());
		}
		
		String sendInfo = "";
		
		if(info.getMissionType().longValue()==4l){
			sendInfo += " \ni18n_EmailService.sendEmailNew.isLoop_n81i：" +(info.getIsLoop()==null?"i18n_EmailService.sendEmailNew.no_n81i":(info.getIsLoop().longValue()==1l?"i18n_EmailService.sendEmailNew.yes_n81i":"i18n_EmailService.sendEmailNew.no_n81i"));
			sendInfo +=  " \ni18n_EmailService.sendEmailNew.scheduleTime_n81i：" +  startTime+" -- "+endTime;
		}
		sendInfo += " \ni18n_EmailService.sendEmailNew.missionState_n81i：" + res.getObject("ms_"+info.getMissionState().intValue())
		+ " \ni18n_EmailService.sendEmailNew.nodeGroup_n81i：" + info.getNodeGroupName()
		+ " \ni18n_EmailService.sendEmailNew.node_n81i：" + info.getNodeIpsName()
		+ " \n" + emailContext;
		
		EmailInfo emailInfo = new EmailInfo();
		emailInfo.setActionDesc(info.getMissionName()+"("+res.getObject("mt_"+info.getMissionType().longValue())+")");
		emailInfo.setActionDate(format.format(new Date()));
		emailInfo.setActionType(EmailTypeConstants.TYPE_TASK_STATE_CHANGE);
		emailInfo.setSendFlag(EmailTypeConstants.FLAG_SEND_LATER);
		emailInfo.setContent(sendInfo);
		
		//- 发送邮件业务
		try {
			//-- 查询联系人参数过滤
			switch (info.getMissionType().intValue()) {
			case 6:
				info.setViewLevel(3l);	// 升级部署 通知均为系统内通知
				emailList = getEmailList(info, null);
				break;
			default:	//任务1 任务4 均按原有业务发送邮件
				emailList = getEmailList(info, null);
				break;
			}
			logger.debug("邮件数量 "+(emailList==null?null:emailList.size()));
			
			//-- 发送邮件
			List<EmailInfo> eiList = new LinkedList<EmailInfo>();
			if(emailList !=null && emailList.size()>0){
				for (Iterator emailIte = emailList.iterator(); emailIte.hasNext();) {
					String addr = (String) emailIte.next();
					if(StringUtils.isEmpty(addr))continue;
					EmailInfo emailInfo2 = new EmailInfo(emailInfo);
					emailInfo2.setToAddress(addr);
					eiList.add(emailInfo2);
//					logger.debug("邮件 To "+(addr));
//					// 设置发件人地址、收件人地址和邮件标题
//					cn.setAddress(Constants.EMAIL_ADDRESS, addr, emaiTitle);
//					cn.send(sendInfo);
				}
				if(emailInfo.getSendFlag() == EmailTypeConstants.FLAG_SEND_IMMEDIATELY){	//立即发送
					SendMail cn = new SendMail();
					
				}else{
					saveEmailInfoList(eiList);
				}
			}
			
		} catch (Exception e) {
			logger.error("",e);
		}
		logger.info("任务下发 邮件通知 发送完成");
		
		//-结束
	}
	private String DB_DATE_FORMAT = "yyyy-mm-dd HH24:mi:ss";
	public boolean saveEmailInfoList(List<EmailInfo> eiList) throws SQLExecuteTimeoutException,SQLException {
		
		String insertSql = " insert into email_table (to_address,action_type,content,send_flag,action_ip,action_date,action_desc,send_level,CREATE_TIME)" +
				" values(?,?,?,?,?,to_date(?,'"+DB_DATE_FORMAT+"'),?,?,to_date(?,'"+DB_DATE_FORMAT+"'))" ;
		List<String[]> paramsList = new LinkedList<String[]>();
		if(eiList != null && eiList.size()>0){
			String createTime = format.format(new Date());
			for(EmailInfo ei :eiList){
				paramsList.add(new String[]{ei.getToAddress(),ei.getActionType()+"",ei.getContent(),ei.getSendFlag()+"",ei.getActionIp(),ei.getActionDate(),ei.getActionDesc(),ei.getSendLevel()+"",createTime});
			}
			return dao.dbUpdateByBatch(insertSql, paramsList);
		}
		return false;
	}
	
	public boolean saveEmailInfo(EmailInfo ei) throws SQLException {
		
		String insertSql = " insert into email_table (to_address,action_type,content,send_flag,action_ip,action_date,action_desc,send_level,CREATE_TIME)" +
				" values(?,?,?,?,?,to_date(?,'"+DB_DATE_FORMAT+"'),?,?,to_date(?,'"+DB_DATE_FORMAT+"'))" ;
		if(ei != null ){
			String createTime = format.format(new Date());
			return dao.dbUpdate(insertSql, new String[]{ei.getToAddress(),ei.getActionType()+"",ei.getContent(),ei.getSendFlag()+"",ei.getActionIp(),ei.getActionDate(),ei.getActionDesc(),ei.getSendLevel()+"",createTime});
		}else
		return false;
	}
	/*private void sendEmailForDetectionBySeqId(Long dId,Long seqId,String emaiTitle,String emailContext){
		if(Constants.FLAG_EMAIL == 0){
			logger.warn("邮件功能已关闭");
			return;
		}
		//-- 数据校验 无效返回
		if(dId==null || dId.longValue() == 0l || seqId==null || seqId.longValue() == 0l){
			return;
		}
		//-- 查询联系人设置信息
		ContactSetInfo contactSetInfo  = this.getContactSetInfoByDetecId(dId);
		//-- 获取联系人列表
		List<String> emaiList = this.getEmailList(contactSetInfo, seqId);
		logger.debug("邮件数量 "+(emaiList==null?null:emaiList.size()));
		//-- 发邮件
		if(emaiList!=null && emaiList.size()>0){
			SendMail cn = new SendMail();
			for (Iterator emailIte = emaiList.iterator(); emailIte.hasNext();) {
				String addr = (String) emailIte.next();
				if(StringUtils.isEmpty(addr))continue;
				logger.debug("邮件 To "+(addr));
				 // 设置发件人地址、收件人地址和邮件标题
				 cn.setAddress(Constants.EMAIL_ADDRESS, addr, emaiTitle);
				 cn.send(emailContext);
			}
		}
		//-结束
	}*/
	
	
	
	/*private void sendEmailForMissionBySeqId(Long mId,int missionType,Long seqId,String emaiTitle,String emailContext){
		if(Constants.FLAG_EMAIL == 0){
			logger.warn("邮件功能已关闭");
			return;
		}
		//-- 数据校验 无效返回
		if(mId==null || mId.longValue() == 0l || missionType==0 || seqId==null || seqId.longValue() == 0l){
			return;
		}
		//-- 查询联系人设置信息
		ContactSetInfo contactSetInfo  = this.getContactSetInfoByMissionId(mId);
		//-- 获取联系人列表
		List<String> emaiList = this.getEmailList(contactSetInfo, seqId);
		logger.debug("邮件数量 "+(emaiList==null?null:emaiList.size()));
		//-- 发邮件
		if(emaiList!=null && emaiList.size()>0){
			SendMail cn = new SendMail();
			for (Iterator emailIte = emaiList.iterator(); emailIte.hasNext();) {
				String addr = (String) emailIte.next();
				if(StringUtils.isEmpty(addr))continue;
				logger.debug("邮件 To "+(addr));
				// 设置发件人地址、收件人地址和邮件标题
				cn.setAddress(Constants.EMAIL_ADDRESS, addr, emaiTitle);
				cn.send(emailContext);
			}
		}
		//-结束
	}*/
	
	/**
	 * 任务执行邮件通知方法
	 * 任务类型 1 根据 系统 用户组 指定用户处理
	 * 任务类型 4 根据 系统 用户组 指定用户处理
	 * 任务类型 6 根据 下发机器 的管理用户发送通知
	 * @time Mar 28, 2012-1:53:56 PM
	 * @param mission	任务信息
	 * @param emaiTitle	主题
	 * @param emailContext	内容
	 */
	/*private void sendEmailForMission(Long missionId,String emaiTitle,String emailContext){
		if(Constants.FLAG_EMAIL == 0){
			logger.warn("邮件功能已关闭");
			return;
		}
		//-- 参数校验
		if(missionId==null || StringUtils.isEmpty(emaiTitle) || StringUtils.isEmpty(emailContext)){
			return;
		}
		ContactSetInfo info = this.getContactSetInfoByMissionId(missionId);
		LinkedList<String> emailList = null;
		
		ResourceBundle res = ResourceBundle.getBundle(CommonResources.class.getName());
//		ContactSetInfo info = getContactSetInfoByMissionId(mId,mType);
		String startTime = "";
		String endTime = "";
		if(info.getStartTime()!=null){
			startTime = format.format(info.getStartTime());
		}
		if(info.getEndTime()!=null){
			endTime = format.format(info.getEndTime());
		}
		
		String sendInfo = "任务名称："+info.getMissionName()
		+ " \n任务类型：" + res.getObject("mt_"+info.getMissionType().longValue());
		
		if(info.getMissionType().longValue()==4l){
			sendInfo += " \n周期任务：" +(info.getIsLoop()==null?"否":(info.getIsLoop().longValue()==1l?"是":"否"));
		}
		sendInfo += " \n任务状态：" + res.getObject("ms_"+info.getMissionState().intValue());
		sendInfo +=  " \n计划执行时间：" +  startTime+" -- "+endTime
		+ " \n节点组：" + info.getNodeGroupName()
		+ " \n节点：" + info.getNodeIpsName()
		+ " \n" + emailContext;
		
		//- 发送邮件业务
		try {
			//-- 查询联系人参数过滤
			switch (info.getMissionType().intValue()) {
			case 6:
				info.setViewLevel(3l);	// 升级部署 通知均为系统内通知
				emailList = getEmailList(info, null);
				break;
			default:	//任务1 任务4 均按原有业务发送邮件
				emailList = getEmailList(info, null);
				break;
			}
			logger.debug("邮件数量 "+(emailList==null?null:emailList.size()));
			
			//-- 发送邮件
			if(emailList !=null && emailList.size()>0){
				SendMail cn = new SendMail();
				for (Iterator emailIte = emailList.iterator(); emailIte.hasNext();) {
					String addr = (String) emailIte.next();
					if(StringUtils.isEmpty(addr))continue;
					logger.debug("邮件 To "+(addr));
					// 设置发件人地址、收件人地址和邮件标题
					cn.setAddress(Constants.EMAIL_ADDRESS, addr, emaiTitle);
					cn.send(sendInfo);
				}
			}
		} catch (Exception e) {
			logger.error("",e);
		}
		logger.info("任务下发 邮件通知 发送完成");
		
		//-结束
	}*/
	private LinkedList<String> getEmailList(ContactSetInfo contactSetInfo) {
		LinkedList<String> emailList = new LinkedList<String>();
		ArrayList<String> fields = new ArrayList<String>();
		fields.add("email");
			if(contactSetInfo!=null && contactSetInfo.getViewLevel()!=null){
				try {
					if(contactSetInfo.getViewLevel().intValue()==1){	//个人查看	邮件发送给 创建者
						String sql1 = "select distinct xyj.email from xt_yh_jbxx xyj where xyj.is_receiveemail='0' and xyj.yhid = '"+contactSetInfo.getCreateUserId()+"' ";
						List<Map<String, String>> map1 = (List<Map<String, String>>)dao.dbSelect(sql1, fields);
						if(map1 != null && map1.size()>0){
							emailList.add(map1.get(0).get("email"));
						}
					}else {		//非个人
						//-- 无限制 或 未指定联系人情况
						if(contactSetInfo.getViewLevel().intValue()==4 || (contactSetInfo.getContactUserIds()==null || contactSetInfo.getContactUserIds().length()==0)){
							/**
							 * 查询seqId所在的系统
							 * 系统关联的用户维护组的有效维护人员接收邮件信息
							 * */
							StringBuffer selectSql = new StringBuffer();
							selectSql.append("select distinct xyj.email ");
							selectSql.append("from xt_yh_jbxx xyj ");
							selectSql.append("left join xt_yh_js_index xyji on xyji.yhid = xyj.yhid ");
							selectSql.append("left join xt_js_jbxx xjj on xjj.jsbh = xyji.jsbh ");
							selectSql.append("left join gorup_system_table gst on gst.user_group_id = xjj.jsbh ");
							selectSql.append("left join system_table st on st.system_id = gst.system_id ");
							selectSql.append("left join node_table nt on nt.system_id = gst.system_id ");
							selectSql.append("left join nodegroup_table ngt on ngt.group_id = nt.node_group_id ");
							selectSql.append("where nt.node_state = 0 ");		//  节点有效状态 0有效
							selectSql.append("and ngt.is_valid = 1 ");		//  节点组有效状态 1有效
							selectSql.append("and st.system_state  = 0 ");		//  系统有效状态 0有效
							selectSql.append("and xjj.zxbz = 0 ");		//  用户组有效状态 0有效
							selectSql.append("and xjj.type = 1 ");		//  组类别状态 1是用户组 0是角色
							selectSql.append("and xyj.zxbz = 0 and xyj.is_receiveemail='0'");		//  用户有效状态 0 有效
//							if(seqId != null && seqId.longValue() != 0){
//								selectSql.append("and nt.seq_id = "+seqId);		
//							}
							//-- 无限制 情况
							if(contactSetInfo.getViewLevel().intValue()==4){	
								
							}else
							//-- 系统内 情况
								if(contactSetInfo.getViewLevel().intValue()==3){
								selectSql.append("and nt.system_id = '"+contactSetInfo.getSystemId()+"' ");
							}else 
							//-- 组内 情况
								if(contactSetInfo.getViewLevel().intValue()==2){
								selectSql.append("and xjj.jsbh =  '"+contactSetInfo.getCreateUserGroupId()+"' "); 
							}
							List<Map<String, String>> mapList = (List<Map<String, String>>) dao.dbSelect(selectSql.toString(), fields);
							if(mapList != null && mapList.size()>0){
								for (Iterator<Map<String,String>> mapIte = mapList.iterator(); mapIte.hasNext();) {
									Map<String,String> map = mapIte.next();
									emailList.add(map.get("email"));
								}
							}
						}
						//-- 组或系统内指定联系人情况
						else{
							String sql0 = "select distinct xyj.email from xt_yh_jbxx xyj where xyj.yhid in ("+contactSetInfo.getContactUserIds()+") and xyj.is_receiveemail='0'";
							List<Map<String, String>> map0List = (List<Map<String, String>>)dao.dbSelect(sql0, fields);
							if(map0List != null && map0List.size()>0){
								for (Iterator<Map<String,String>> map0Ite = map0List.iterator(); map0Ite.hasNext();) {
									Map<String,String> map0 = map0Ite.next();
									emailList.add(map0.get("email"));
								}
							}
						}
					}
				} catch (Exception e) {
					logger.error(" Fail to query the list of email addresses to be sent to failure",e);
				}finally{
					dao.clearConn();
				}
			}
		 
		return emailList;
	}
	private LinkedList<String> getEmailList(ContactSetInfo contactSetInfo,Long seqId) {
		LinkedList<String> emailList = new LinkedList<String>();
		ArrayList<String> fields = new ArrayList<String>();
		fields.add("email");
			if(contactSetInfo!=null && contactSetInfo.getViewLevel()!=null){
				try {
					if(contactSetInfo.getViewLevel().intValue()==1){	//个人查看	邮件发送给 创建者
						String sql1 = "select distinct xyj.email from xt_yh_jbxx xyj where xyj.yhid = '"+contactSetInfo.getCreateUserId()+"'  and xyj.is_receiveemail='0'";
						List<Map<String, String>> map1 = (List<Map<String, String>>)dao.dbSelect(sql1, fields);
						if(map1 != null && map1.size()>0){
							emailList.add(map1.get(0).get("email"));
						}
					}else {		//非个人
						//-- 无限制 或 未指定联系人情况
						if(contactSetInfo.getViewLevel().intValue()==4 || (contactSetInfo.getContactUserIds()==null || contactSetInfo.getContactUserIds().length()==0)){
							/**
							 * 查询seqId所在的系统
							 * 系统关联的用户维护组的有效维护人员接收邮件信息
							 * */
							StringBuffer selectSql = new StringBuffer();
							selectSql.append("select distinct xyj.email ");
							selectSql.append("from xt_yh_jbxx xyj ");
							selectSql.append("left join xt_yh_js_index xyji on xyji.yhid = xyj.yhid ");
							selectSql.append("left join xt_js_jbxx xjj on xjj.jsbh = xyji.jsbh ");
							selectSql.append("left join gorup_system_table gst on gst.user_group_id = xjj.jsbh ");
							selectSql.append("left join system_table st on st.system_id = gst.system_id ");
							selectSql.append("left join node_table nt on nt.system_id = gst.system_id ");
							selectSql.append("left join nodegroup_table ngt on ngt.group_id = nt.node_group_id ");
							selectSql.append("where nt.node_state = 0 ");		//  节点有效状态 0有效
							selectSql.append("and ngt.is_valid = 1 ");		//  节点组有效状态 1有效
							selectSql.append("and st.system_state  = 0 ");		//  系统有效状态 0有效
							selectSql.append("and xjj.zxbz = 0 ");		//  用户组有效状态 0有效
							selectSql.append("and xjj.type = 1 ");		//  组类别状态 1是用户组 0是角色
							selectSql.append("and xyj.zxbz = 0  and xyj.is_receiveemail='0'");		//  用户有效状态 0 有效
							if(seqId != null && seqId.longValue() != 0){
								selectSql.append("and nt.seq_id = "+seqId);		
							}
							//-- 无限制 情况
							if(contactSetInfo.getViewLevel().intValue()==4){	
								
							}else
							//-- 系统内 情况
								if(contactSetInfo.getViewLevel().intValue()==3){
								selectSql.append("and nt.system_id = '"+contactSetInfo.getSystemId()+"' ");
							}else 
							//-- 组内 情况
								if(contactSetInfo.getViewLevel().intValue()==2){
								selectSql.append("and xjj.jsbh =  '"+contactSetInfo.getCreateUserGroupId()+"' "); 
							}
							List<Map<String, String>> mapList = (List<Map<String, String>>) dao.dbSelect(selectSql.toString(), fields);
							if(mapList != null && mapList.size()>0){
								for (Iterator<Map<String,String>> mapIte = mapList.iterator(); mapIte.hasNext();) {
									Map<String,String> map = mapIte.next();
									emailList.add(map.get("email"));
								}
							}
						}
						//-- 组或系统内指定联系人情况
						else{
							String sql0 = "select distinct xyj.email from xt_yh_jbxx xyj where xyj.yhid in ("+contactSetInfo.getContactUserIds()+")  and xyj.is_receiveemail='0'";
							List<Map<String, String>> map0List = (List<Map<String, String>>)dao.dbSelect(sql0, fields);
							if(map0List != null && map0List.size()>0){
								for (Iterator<Map<String,String>> map0Ite = map0List.iterator(); map0Ite.hasNext();) {
									Map<String,String> map0 = map0Ite.next();
									emailList.add(map0.get("email"));
								}
							}
						}
					}
				} catch (Exception e) {
					logger.error(" Fail to query the list of email addresses to be sent to failure",e);
				}finally{
					dao.clearConn();
				}
			}
		 
		return emailList;
	}
	
	private ContactSetInfo getContactSetInfoByDetecId(Long dId){
		ContactSetInfo contactSetInfo = null;
		StringBuffer selectSql = new StringBuffer();
		selectSql.append("select ");
		selectSql.append("dsi.view_level, ");
		selectSql.append("dsi.create_user_id, ");
		selectSql.append("dsi.create_usergroup_id, ");
		selectSql.append("dsi.system_id, ");
		selectSql.append("dsi.contact_user_ids ");
		selectSql.append("from detection_set_info dsi where dsi.id= '"+dId+"' ");
		ArrayList<String> fields = new ArrayList<String>();
		fields.add("view_level");
		fields.add("create_user_id");
		fields.add("create_usergroup_id");
		fields.add("system_id");
		fields.add("contact_user_ids");
		try {
			ArrayList<Map<String, String>> mapList = dao.dbSelect(selectSql.toString(), fields);
			if(mapList!=null && mapList.size()>0){
				Map<String, String> map0 = mapList.get(0);
				 contactSetInfo = new ContactSetInfo();
				 contactSetInfo.setViewLevel(map0.get("view_level")==null?null:Long.parseLong(map0.get("view_level")));
				 contactSetInfo.setCreateUserId(map0.get("create_user_id")==null?null:Long.parseLong(map0.get("create_user_id")));
				 contactSetInfo.setCreateUserGroupId(map0.get("create_usergroup_id")==null?null:Long.parseLong(map0.get("create_usergroup_id")));
				 contactSetInfo.setSystemId(map0.get("system_id")==null?null:Long.parseLong(map0.get("system_id")));
				 contactSetInfo.setContactUserIds(map0.get("contact_user_ids"));
			}
		} catch (Exception e) {
			logger.error("",e);
		}finally{
			dao.clearConn();
		}
		return contactSetInfo;
	}
		
	private ContactSetInfo getContactSetInfoByMissionId(Long mId){
		ContactSetInfo contactSetInfo = null;
		StringBuffer selectSql = new StringBuffer();
		selectSql.append("select ");
		selectSql.append("mst.mission_id, ");
		selectSql.append("mst.mission_name, ");
//		selectSql.append("ngt.group_name node_group_name, ");
//		selectSql.append("mpt.node_groups_id, ");
//		selectSql.append("mpt.node_ips_id, ");
		selectSql.append("mst.mission_type, ");
		selectSql.append("mst.mission_state, ");
		selectSql.append("mst.is_loop , ");
		selectSql.append("to_char(mst.start_time,'"+DB_DATE_FORMAT+"' ) start_time, ");
		selectSql.append("to_char(mst.end_time,'"+DB_DATE_FORMAT+"' ) end_time, ");
		selectSql.append("mst.view_level, ");
		selectSql.append("mst.user_id, ");
		selectSql.append("mst.group_id, ");
		selectSql.append("mst.system_id, ");
		selectSql.append("mst.contact_user_ids ");
		selectSql.append("from mission_state_table mst ");
//		selectSql.append("left join mission_parameter_table"+missionType+" mpt on mpt.mission_id = mst.mission_id ");
//		selectSql.append("left join nodegroup_table ngt on ngt.group_id = mpt.node_groups_id ");
		selectSql.append("where mst.mission_id= '"+mId+"' ");
		
		ArrayList<String> fields = new ArrayList<String>();
		fields.add("mission_id");
		fields.add("mission_name");
//		fields.add("node_groups_id");
//		fields.add("node_ips_id");
		fields.add("mission_type");
		fields.add("mission_state");
		fields.add("is_loop");
		fields.add("start_time");
		fields.add("end_time");
		fields.add("view_level");
		fields.add("user_id");
		fields.add("group_id");
		fields.add("system_id");
		fields.add("contact_user_ids");
		try {
			ArrayList<Map<String, String>> mapList = dao.dbSelect(selectSql.toString(), fields);
			if(mapList!=null && mapList.size()>0){
				Map<String, String> map = mapList.get(0);
				 contactSetInfo = new ContactSetInfo();
				 contactSetInfo.setMissionId(map.get("mission_id")==null?null:Long.parseLong(map.get("mission_id")));
				 contactSetInfo.setMissionName(map.get("mission_name"));
				 contactSetInfo.setMissionType(map.get("mission_type")==null?null:Long.parseLong(map.get("mission_type")));
				 contactSetInfo.setMissionState(map.get("mission_state")==null?null:Long.parseLong(map.get("mission_state")));
				 contactSetInfo.setIsLoop(map.get("is_loop")==null?null:Long.parseLong(map.get("is_loop")));
				 contactSetInfo.setStartTime(map.get("start_time")==null?null:format.parse(map.get("start_time")));
				 contactSetInfo.setEndTime(map.get("end_time")==null?null:format.parse(map.get("end_time")));
				 contactSetInfo.setViewLevel(map.get("view_level")==null?null:Long.parseLong(map.get("view_level")));
				 contactSetInfo.setCreateUserId(map.get("user_id")==null?null:Long.parseLong(map.get("user_id")));
				 contactSetInfo.setCreateUserGroupId(map.get("group_id")==null?null:Long.parseLong(map.get("group_id")));
				 contactSetInfo.setSystemId(map.get("system_id")==null?null:Long.parseLong(map.get("system_id")));
				 contactSetInfo.setContactUserIds(map.get("contact_user_ids"));
				 
				 ArrayList<String> paramsFields = new ArrayList<String>();
				 paramsFields.add("node_groups_id");
				 paramsFields.add("node_ips_id");
				 String paramsSql = "select mpt.node_groups_id,mpt.node_ips_id from mission_parameter_table"+contactSetInfo.getMissionType().intValue()+" mpt where mpt.mission_id=?";
				 ArrayList<Map<String, String>> paramsMapList = dao.dbSelect(paramsSql.toString(), paramsFields,mId);
				 
				 if(paramsMapList!= null && paramsMapList.size()>0){
					 Map<String, String> map0 = paramsMapList.get(0);
					 contactSetInfo.setNodeGroupsId(map0.get("node_groups_id"));
					 contactSetInfo.setNodeIpsId(map0.get("node_ips_id"));
				 }
			}
			
			
			
			//节点组和节点名称填写
			if(contactSetInfo!= null){
				if(contactSetInfo.getNodeGroupsId()!= null){
					//查询节点组名称
					ArrayList<String> ngnFields = new ArrayList<String>();
					ngnFields.add("group_name");
					String ngNameSql = "select ngt.group_name from nodegroup_table ngt where ngt.group_id in ("+contactSetInfo.getNodeGroupsId()+")";
					ArrayList<Map<String, String>> ngnMapList = dao.dbSelect(ngNameSql.toString(), ngnFields);
					if(ngnMapList != null && ngnMapList.size()>0){
						StringBuffer ngnsb = new StringBuffer();
						for(Map<String, String> map : ngnMapList){
							ngnsb.append(","+map.get(ngnFields.get(0)));
						}
						if(ngnsb.length()>0){
							ngnsb.deleteCharAt(0);
						}
						contactSetInfo.setNodeGroupName(ngnsb.toString());
					}
					
					//查询节点名称
					ArrayList<String> nnFields = new ArrayList<String>();
					nnFields.add("node_name");
					String nnNameSql = null;
					ArrayList<Map<String, String>> nnMapList = null;
					if(contactSetInfo.getNodeIpsId()!= null){
						nnNameSql = "select nt.node_name from node_table nt where nt.node_id in ("+contactSetInfo.getNodeIpsId()+")";
						nnMapList = dao.dbSelect(nnNameSql.toString(), nnFields);
					}else{
						nnNameSql = "select nt.node_name from node_table nt where nt.node_group_id in ("+contactSetInfo.getNodeGroupsId()+") ";
						if(contactSetInfo.getIsLoop()==null || contactSetInfo.getIsLoop()==0){	//非周期任务
							nnNameSql += "and nt.seq_id in (select mrt.seq_id from mission_result_table"+contactSetInfo.getMissionType()+" mrt where mrt.mission_id=?)";
						}else{	//周期任务
							nnNameSql += "and nt.seq_id in (select distinct mrt.seq_id from mission_result_table4 mrt where mrt.mission_id in (select lmst.cur_mission_id from loopmission_state_table lmst where lmst.mission_id=?))";
						}
						nnMapList = dao.dbSelect(nnNameSql.toString(), nnFields,mId);
					}
					if(nnMapList != null && nnMapList.size()>0){
						StringBuffer nnsb = new StringBuffer();
						for(Map<String, String> map : nnMapList){
							nnsb.append(","+map.get(nnFields.get(0)));
						}
						if(nnsb.length()>0){
							nnsb.deleteCharAt(0);
						}
						contactSetInfo.setNodeIpsName(nnsb.toString());
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			dao.clearConn();
		}
		return contactSetInfo;
	}
	
	public static void main(String [] args){
//		ConnectionOracle dao = null;
//		try {
//			dao = ConnectionOracle.getConnection();
//			EmailService emailService = new EmailService(dao);
//			
//			//- 查询联系人设置信息
//			ContactSetInfo contactSetInfo  = emailService.getContactSetInfoByDetecId(12l);
//			
//			//- 整理联系人邮件
//			List<EmailInfo> eiList = new LinkedList<EmailInfo>();
//			List<String> emaiList =  emailService.getEmailList(contactSetInfo);
//			if(emaiList!=null && emaiList.size()>0){
//				for(String addr : emaiList){
//					System.out.println(addr);
//				}
//			}
		
			
//			
//			
//			EmailInfo  emailInfo = new EmailInfo(11,"测试监测","10.0.6.113",new SimpleDateFormat("yyyy-MM:ss HH:mm:ss").format(new Date()),"这是一条关于监测设置的测试信息",0,EmailTypeConstants.URGENT_LATER);
//			//113监测邮件测试
//			emailService.sendEmailForDetectionBySeqId(22l, 85l, emailInfo);
//			EmailInfo  emailInfo2 = new EmailInfo(31,"任务XXX","10.0.6.113",new SimpleDateFormat(Constants.COMMON_DATE_FORMAT).format(new Date()),"这是一条关于任务结果的测试信息",0);
//			emailService.sendEmailForMissionBySeqId(2570l, 6, 85l, emailInfo2);
//			emailService.sendEmailForMission(2570l, "任务XXX", "这是一条关于任务状态的测试信息");
			
//			pl("测试邮件入库完毕");
//		} catch (Exception e) {
//			e.printStackTrace();
//		}finally{
//			dao.close();
//		}
		EmailModel em =new EmailModel();
		em.setToAddress("test2@123.com");
		em.setSubjectDesc("i18n_EmailService.sendEmailNew.threadName_n81i "+"i18n_EmailService.sendEmailNew.subjectDesc_n81i");
		em.setContent("i18n_EmailService.sendEmailNew.threadName_n81i "+"i18n_EmailService.sendEmailNew.subjectDesc_n81i"+"i18n_EmailService.sendEmailNew.scheduleTime_n81i");
		ConnectionOracle dao = null;
		try {
			dao = ConnectionOracle.getConnection();
			EmailService es=new EmailService(dao);
			es.getI18nEmail(em);
			pl("邮件地址：:"+em.getToAddress());
			pl("邮件内容：："+em.getContent());
			pl("邮件主题：："+em.getSubjectDesc());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	private static void pl(Object object) {
		System.out.println(object==null?null:object.toString());
	}
}

class ComparatorEmailInfo implements Comparator<EmailInfo>{

	@Override
	public int compare(EmailInfo emailInfo1, EmailInfo emailInfo2) {
		// TODO Auto-generated method stub		
		if(emailInfo1.getSendLevel()==emailInfo2.getSendLevel()){
			return emailInfo1.getActionDate().compareTo(emailInfo2.getActionDate());
		}else if(emailInfo1.getSendLevel()==null){
			return -1;
		}else if(emailInfo2.getSendLevel()==null){
			return 1;
		}else{
			return emailInfo1.getSendLevel().compareTo(emailInfo2.getSendLevel());
		}
	}
}
