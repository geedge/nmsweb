package nis.nms.service;



import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.criterion.Expression;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.util.Assert;

import nis.nms.bean.ContactSetInfo;
import nis.nms.bean.DiSysteminfo;
import nis.nms.bean.DiSysteminfoDisk;
import nis.nms.bean.DiSysteminfoNet;
import nis.nms.core.CommonResources;
import nis.nms.persistence.HibernateGeneralDaoImpl;
import nis.nms.persistence.OracleToMysql;
import nis.nms.util.BaseAction;
import nis.nms.util.Constant;
import nis.nms.util.Page;
import nis.nms.util.pwd.SendMail;


public class CommonService<T> extends HibernateGeneralDaoImpl<T>{
	SimpleDateFormat format = new SimpleDateFormat(BaseAction.rb.getString("common.date.format"));
	public DiSysteminfo findSysteminfo(String detectId ){
		/*
		DETECTION_INFO_ID	NUMBER	N			
		HOST_NAME	VARCHAR2(200)	Y			
		OPERATE_SYSTEM	VARCHAR2(200)	Y			
		CPU_CNT	NUMBER	Y			
		CPU_MHZ	NUMBER	Y			
		MEMORY_SIZE	NUMBER	Y			
		SWAP_SIZE	NUMBER	Y			
		DISK_SIZE	NUMBER	Y			
		NET_CNT	NUMBER	Y			
		DATA_CHECK_TIME	DATE	Y			
		DATA_ARRIVE_TIME	DATE	Y			
		DATA_CHECK_TIME_DIGITAL	NUMBER	Y			
		DATA_ARRIVE_TIME_DIGITAL	NUMBER	Y			
			*/		
		;
		String column = "DETECTION_INFO_ID," +
				"HOST_NAME," +
				"OPERATE_SYSTEM," +
				"CPU_CNT," +
				"CPU_MHZ," +
				"MEMORY_SIZE," +
				"SWAP_SIZE," +
				"DISK_SIZE," +
				"NET_CNT," +
				"to_char(DATA_CHECK_TIME,'yyyy-mm-dd HH24:mi:ss')," +
				"to_char(DATA_ARRIVE_TIME,'yyyy-mm-dd HH24:mi:ss')";
		List siList;
		DiSysteminfo systeminfo = null;
		try {
			siList = this.executeSQL("select "+column+" from di_systeminfo dsi where dsi.detection_info_id = ?",detectId);
			if(siList!= null && siList.size()>0){
				Object [] args = (Object[]) siList.get(0);
				systeminfo = new DiSysteminfo();
				systeminfo.setDetectionInfoId(args[0]==null?null:((BigDecimal)args[0]).longValue());
				systeminfo.setHostName(args[1]==null?null:(String) args[1]);
				systeminfo.setOperateSystem(args[2]==null?null:(String) args[2]);
				systeminfo.setCpuCnt(args[3]==null?null:((BigDecimal)args[3]).longValue());
				systeminfo.setCpuMhz(args[4]==null?null:((BigDecimal)args[4]).longValue());
				systeminfo.setMemorySize(args[5]==null?null:((BigDecimal)args[5]).doubleValue());
				systeminfo.setSwapSize(args[6]==null?null:((BigDecimal)args[6]).doubleValue());
				systeminfo.setDiskSize(args[7]==null?null:((BigDecimal)args[7]).doubleValue());
				systeminfo.setNetCnt(args[8]==null?null:((BigDecimal)args[8]).longValue());
				systeminfo.setDataCheckTimeStr(args[9]==null?null:(String) args[9]);
				systeminfo.setDataArriveTimeStr(args[10]==null?null:(String) args[10]);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return systeminfo;
	}
	public List<DiSysteminfoDisk> findSysteminfoDisk(String detectId){
		/*
			DETECTION_INFO_ID	NUMBER	N			
			DISK_RANG	VARCHAR2(50)	Y			盘符
			DISK_SIZE	NUMBER	Y			大小
			DATA_CHECK_TIME	DATE	Y			
			DATA_ARRIVE_TIME	DATE	Y			
			DATA_CHECK_TIME_DIGITAL	NUMBER	Y			
			DATA_ARRIVE_TIME_DIGITAL	NUMBER	Y			
		 */
		
		
		String column = "DETECTION_INFO_ID," +
				"DISK_RANG," +
				"DISK_SIZE" +
				"";
		List<DiSysteminfoDisk> dsinList = null;
		try {
			List siList = this.executeSQL("select "+column+" from di_systeminfo_disk dsi where dsi.detection_info_id = ?",detectId);
			if(siList!= null && siList.size()>0){
				dsinList = new ArrayList<DiSysteminfoDisk>();
				for (int i = 0; i < siList.size(); i++) {
					DiSysteminfoDisk dsiDisk = null;
					Object [] args = (Object[]) siList.get(i);
					dsiDisk = new DiSysteminfoDisk();
					dsiDisk.setDetectionInfoId(args[0]==null?null:((BigDecimal)args[0]).longValue());
					dsiDisk.setDiskRang(args[1]==null?null:(String) args[1]);
					dsiDisk.setDiskSize(args[2]==null?null:((BigDecimal)args[2]).doubleValue());
					dsinList.add(dsiDisk);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dsinList;
	}
	
	public List<DiSysteminfoNet> findSysteminfoNet(String detectId){
		String column = "DETECTION_INFO_ID," +
				"NET_NAME," +
				"NET_STATE," +
				"NET_SPEED," +
				"NET_IP," +
				"NET_SUBMASK," +
				"NET_GATEWAY," +
				"NET_MAC" +
//				"to_char(DATA_CHECK_TIME,'yyyy-mm-dd HH24:mi:ss')," +
//				"to_char(DATA_ARRIVE_TIME,'yyyy-mm-dd HH24:mi:ss')" +
				"";
		List<DiSysteminfoNet> dsinList = null;
		try {
			List siList = this.executeSQL("select "+column+" from di_systeminfo_net dsi where dsi.detection_info_id = ?",detectId);
			if(siList!= null && siList.size()>0){
				dsinList = new ArrayList<DiSysteminfoNet>();
				for (int i = 0; i < siList.size(); i++) {
					DiSysteminfoNet dsinet = null;
					Object [] args = (Object[]) siList.get(i);
				 	dsinet = new DiSysteminfoNet();
					dsinet.setDetectionInfoId(args[0]==null?null:((BigDecimal)args[0]).longValue());
					dsinet.setNetName(args[1]==null?null:(String) args[1]);
					dsinet.setNetState(args[2]==null?null:(String) args[2]);
					dsinet.setNetSpeed(args[3]==null?null:((BigDecimal)args[3]).longValue());
					dsinet.setNetIp(args[4]==null?null:(String) args[4]);
					dsinet.setNetSubmask(args[5]==null?null:(String) args[5]);
					dsinet.setNetGateway(args[6]==null?null:(String) args[6]);
					dsinet.setNetMac(args[7]==null?null:(String) args[7]);
					dsinList.add(dsinet);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dsinList;
	}
	public Page findByPageForSql(String sql, int pageNo, int pageSize, Object... values) throws Exception {
		Assert.hasText(sql);
		Assert.isTrue(pageNo >= 1, "pageNo should start from 1");
		// Count查询
		if (values != null && values.length == 0) {
			values = null;
		}
		List countlist = null;
		long totalCount = 0;
			String countQueryString = " select count(*) as totalCount from ( " + sql + " ) trySearch ";
			totalCount = (Long)createSQLQuery(countQueryString, values)
								.addScalar("totalCount", Hibernate.LONG)
									.uniqueResult();
		if (totalCount < 1) return new Page();
		// 实际查询返回分页对象
		int startIndex = Page.getStartOfPage(pageNo, pageSize);
		Query query = createSQLQuery(sql, values);
		List list = query.setFirstResult(startIndex).setMaxResults(pageSize).list();
		Page page = new Page(startIndex, totalCount, pageSize, list);
		return page;
	}
	
	public List executeSQL(String sql,Class entity) throws Exception {
		Assert.hasText(sql);
		Query query = createSQLQuery(sql).addEntity(entity);
		List list = query.list();
		return list;
	}
	
	//@Override
	public Page findByPageForSql(String sql, int pageNo, int pageSize, Class c,Object... values) throws Exception {
		Assert.hasText(sql);
		Assert.isTrue(pageNo >= 1, "pageNo should start from 1");
		// Count查询
		if (values != null && values.length == 0) {
			values = null;
		}
		List countlist = null;
		long totalCount = 0;
			String countQueryString = " select count(*) as totalCount from ( " + sql + " ) ";
			totalCount = (Long)createSQLQuery(countQueryString, values)
								.addScalar("totalCount", Hibernate.LONG)
									.uniqueResult();
		if (totalCount < 1) return new Page();
		// 实际查询返回分页对象
		int startIndex = Page.getStartOfPage(pageNo, pageSize);
		Query query = null;
		if(c!=null){
			query = createSQLQuery(sql, values).addEntity(c);
		}else{
			query = createSQLQuery(sql, values);
		}
		
		List list = query.setFirstResult(startIndex).setMaxResults(pageSize).list();
		Page page = new Page(startIndex, totalCount, pageSize, list);
		return page;
	}
	
	
	
	/*
	 * 将查询的数据结构封装成hashMap,key为数据库的字段名称。
	 */
	@SuppressWarnings( { "unchecked", "deprecation" })
	public List findByJdbcStrUp(String str) {
		ArrayList al = new ArrayList();
		ResultSet rs;
		try {
			rs = this.getSession().connection().createStatement().executeQuery(
					str);
			int num = rs.getMetaData().getColumnCount();
			while (rs.next()) {
				HashMap hashmap = new HashMap();
				for (int i = 1; i <= num; i++) {
					hashmap.put(
							rs.getMetaData().getColumnName(i).toUpperCase(), rs
									.getString(i));
				}
				al.add(hashmap);
			}
		} catch (DataAccessResourceFailureException e) {
			e.printStackTrace();
		} catch (HibernateException e) {

			e.printStackTrace();
		} catch (IllegalStateException e) {

			e.printStackTrace();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return al;
	}
	
	
	public SQLQuery createSQLQuery(String sql, Object... values){
		Assert.hasText(sql);
		sql = OracleToMysql.trans(sql);
		SQLQuery query = getSession().createSQLQuery(sql);
		if (values != null) {
			for(int i = 0; i < values.length; i++){
				query.setParameter(i, values[i]);
			}
		}
		return query;
	}

	public List findTopByHql(String hql,int top,Object... values){
		hql = OracleToMysql.trans(hql);
		Query query = this.getSession().createQuery(hql);
		for(int i=0;i<values.length;i++){
			query.setParameter(i, values[i]);
		}
		query.setMaxResults(top);
		return query.list();
	}
	
	public Object getUniqueByHql(String hql,Object... values){
		hql = OracleToMysql.trans(hql);
		Query query = this.getSession().createQuery(hql);
		for(int i = 0;i<values.length;i++){
			query.setParameter(i,values[i]);
		}
		query.setMaxResults(1);
		return query.uniqueResult();
	}
	
	/*
	 * 根据选择的ID导出Excel文件,表示id的属性名必须为id
	 */
	@SuppressWarnings("deprecation")
	public boolean createExcel(Class clazz,Long[] ids, String[] labels, String excelFileName){
		Criteria criteria = this.getSession().createCriteria(clazz);
		try {
			criteria.add(Expression.in(getIdentifierPropertyName(clazz), ids));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List dataList  = criteria.list();
		return this.createExcel(dataList, labels, excelFileName);
	}
	
	public boolean createExcelByMap(List<? extends Map> dataList,String [] labels,String excelFileName){
		HSSFWorkbook wb = new HSSFWorkbook();
		FileOutputStream fos = null;		

		try{
			fos = new FileOutputStream(excelFileName);
			HSSFSheet sheet1 = wb.createSheet("RESULT");
			HSSFRow   row0    = sheet1.createRow(0);
			HSSFCellStyle  dateStyle = wb.createCellStyle();
			dateStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("yyyy-MM-dd"));
			for(int t = 0 ; t < labels.length ; t++){
				 row0.createCell((short)t).setCellValue(labels[t]);
			}
			Map map;
			HSSFRow row;
			Object value;
			for(int i =0 ;i<dataList.size();i++){
				map = dataList.get(i);
				row = sheet1.createRow(i+1);
				for(int j = 0;j<labels.length ;j++){
					value = map.get(labels[j]);
					if(value instanceof String){
						row.createCell((short)j).setCellValue((String)value);
					}
					else if(value instanceof Long){
						row.createCell((short)j).setCellValue((Long)value);
					}
					else if(value instanceof Integer){
						row.createCell((short)j).setCellValue((Integer)value);
					}
					else if(value instanceof Date){
						row.createCell((short)j).setCellValue((Date)value);
					}
					else if(value instanceof Calendar){
						row.createCell((short)j).setCellValue((Calendar)value);
					}
					else if(value instanceof Boolean){
						row.createCell((short)j).setCellValue((Boolean)value);
					}
					else if(value instanceof Double){
						row.createCell((short)j).setCellValue((Double)value);
					}
				}
			}
			wb.write(fos);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return false;
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}  finally{
			try {
				fos.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return true;
	}
	
	public boolean createExcel(List<? extends Object> dataList,String [] labels,String excelFileName){
		HSSFWorkbook wb = new HSSFWorkbook();
		FileOutputStream fos = null;		
		try{
			fos = new FileOutputStream(excelFileName);
			HSSFSheet sheet1 = wb.createSheet("RESULT");
			HSSFRow   row0    = sheet1.createRow(0);
			HSSFCellStyle  dateStyle = wb.createCellStyle();
			dateStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("yyyy-MM-dd"));
			for(int t = 0 ; t < labels.length ; t++){
				 row0.createCell((short)t).setCellValue(labels[t]);
			}
			Object obj;
			Method method;
			String label;
			HSSFRow row;
			Object value;
			for(int i =0 ;i<dataList.size();i++){
				obj = dataList.get(i);
				row = sheet1.createRow(i+1);
				for(int j = 0;j<labels.length ;j++){
					label = labels[j];
					method = obj.getClass().getDeclaredMethod("get"+label.substring(0,1).toUpperCase()+label.substring(1));
					value = method.invoke(obj);
					if(value instanceof String){
						row.createCell((short)j).setCellValue((String)value);
					}
					else if(value instanceof Long){
						row.createCell((short)j).setCellValue((Long)value);
					}
					else if(value instanceof Integer){
						row.createCell((short)j).setCellValue((Integer)value);
					}
					else if(value instanceof Date){
						row.createCell((short)j).setCellValue((Date)value);
					}
					else if(value instanceof Calendar){
						row.createCell((short)j).setCellValue((Calendar)value);
					}
					else if(value instanceof Boolean){
						row.createCell((short)j).setCellValue((Boolean)value);
					}
					else if(value instanceof Double){
						row.createCell((short)j).setCellValue((Double)value);
					}
				}
			}
			wb.write(fos);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return false;
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} finally{
			try {
				fos.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return true;
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
		
		String sendInfo = "i18n_CommonService.sendEmailForMission.missionName_n81i"+"："+info.getMissionName()
		+ " \n"+"i18n_CommonService.sendEmailForMission.missionType_n81i"+"：" + res.getObject("mt_"+info.getMissionType().longValue());
		
		if(info.getMissionType().longValue()==4l){
			sendInfo += " \n"+"i18n_CommonService.sendEmailForMission.loopMission_n81i"+"：" +(info.getIsLoop()==null?BaseAction.getI18nText("i18n_CommonService.sendEmailForMission.no_n81i"):(info.getIsLoop().longValue()==1l?BaseAction.getI18nText("i18n_CommonService.sendEmailForMission.yes_n81i"):BaseAction.getI18nText("i18n_CommonService.sendEmailForMission.no_n81i")));
		}
		sendInfo += " \n"+"i18n_CommonService.sendEmailForMission.missions_n81i"+"：" + res.getObject("ms_"+info.getMissionState().intValue());
		sendInfo +=  " \n"+"i18n_CommonService.sendEmailForMission.planTime_n81i"+"：" +  startTime+" -- "+endTime
		+ " \n"+"i18n_CommonService.sendEmailForMission.nodeGroup_n81i"+"：" + info.getNodeGroupName()
		+ " \n"+"i18n_CommonService.sendEmailForMission.node_n81i"+"：" + info.getNodeIpsName()
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
					cn.setAddress(BaseAction.rb.getString("email.address"), addr, emaiTitle);
					cn.send(sendInfo);
				}
			}
		} catch (Exception e) {
			logger.error("",e);
		}
		logger.info("任务下发 邮件通知 发送完成");
		
		//-结束
	}
	
	private ContactSetInfo getContactSetInfoByMissionId(Long mId){
		ContactSetInfo contactSetInfo = null;
		StringBuffer selectSql = new StringBuffer();
		selectSql.append("select ");
		selectSql.append("mst.mission_id, ");
		selectSql.append("mst.mission_name, ");
		selectSql.append("mst.mission_type, ");
		selectSql.append("mst.mission_state, ");
		selectSql.append("mst.is_loop , ");
		selectSql.append("to_char(mst.start_time,'yyyy-MM-dd HH24:mi:ss' ) start_time, ");
		selectSql.append("to_char(mst.end_time,'yyyy-MM-dd HH24:mi:ss' ) end_time, ");
		selectSql.append("mst.view_level, ");
		selectSql.append("mst.user_id, ");
		selectSql.append("mst.group_id, ");
		selectSql.append("mst.system_id, ");
		selectSql.append("mst.contact_user_ids ");
		selectSql.append("from mission_state_table mst ");
		selectSql.append("where mst.mission_id= '"+mId+"' ");
		
		try {
			List<Object[]> objsList = this.executeSQL(selectSql.toString());
			if(objsList!=null && objsList.size()>0){
				 Object[] objs = objsList.get(0);
				 contactSetInfo = new ContactSetInfo();
				 
				 contactSetInfo.setMissionId(objs[0]==null?null:((BigDecimal)objs[0]).longValue());
				 contactSetInfo.setMissionName(objs[1]==null?null:(String) objs[1]);
				 contactSetInfo.setMissionType(objs[2]==null?null:((BigDecimal)objs[2]).longValue());
				 contactSetInfo.setMissionState(objs[3]==null?null:((BigDecimal)objs[3]).longValue());
				 contactSetInfo.setIsLoop(objs[4]==null?null:((BigDecimal)objs[4]).longValue());
				 contactSetInfo.setStartTime(objs[5]==null?null:format.parse(objs[5].toString()));
				 contactSetInfo.setEndTime(objs[6]==null?null:format.parse(objs[6].toString()));
				 contactSetInfo.setViewLevel(objs[7]==null?null:((BigDecimal)objs[7]).longValue());
				 contactSetInfo.setCreateUserId(objs[8]==null?null:((BigDecimal)objs[8]).longValue());
				 contactSetInfo.setCreateUserGroupId(objs[9]==null?null:((BigDecimal)objs[9]).longValue());
				 contactSetInfo.setSystemId(objs[10]==null?null:((BigDecimal)objs[10]).longValue());
				 contactSetInfo.setContactUserIds(objs[11]==null?null:(String) objs[11]);
				 
				 ArrayList<String> paramsFields = new ArrayList<String>();
				 paramsFields.add("node_groups_id");
				 paramsFields.add("node_ips_id");
				 String paramsSql = "select mpt.node_groups_id,mpt.node_ips_id from mission_parameter_table"+contactSetInfo.getMissionType().intValue()+" mpt where mpt.mission_id="+mId;
				 List<Object[]> paramsList = this.executeSQL(paramsSql);
				 
				 if(paramsList!= null && paramsList.size()>0){
					 Object[] paraObjs = paramsList.get(0);
					 contactSetInfo.setNodeGroupsId(paraObjs[0]==null?null:(String) paraObjs[0]);
					 contactSetInfo.setNodeIpsId(paraObjs[1]==null?null:(String) paraObjs[1]);
				 }
			}
			
			
			
			//节点组和节点名称填写
			if(contactSetInfo!= null){
				if(contactSetInfo.getNodeGroupsId()!= null){
					//查询节点组名称
					String ngNameSql = "select ngt.group_name from nodegroup_table ngt where ngt.group_id in ("+contactSetInfo.getNodeGroupsId()+")";
					List<Object[]> ngnList =  this.executeSQL(ngNameSql);
					if(ngnList != null && ngnList.size()>0){
						StringBuffer ngnsb = new StringBuffer();
						for(Object ngn : ngnList){
							if(ngn!=null) {
								ngnsb.append(","+ngn.toString());								
							}
						}
						if(ngnsb.length()>0){
							ngnsb.deleteCharAt(0);
						}
						contactSetInfo.setNodeGroupName(ngnsb.toString());
					}
					
					//查询节点名称
					String nnNameSql = null;
					List<Object[]> nnList = null;
					if(contactSetInfo.getNodeIpsId()!= null){
						nnNameSql = "select nt.node_name from node_table nt where nt.node_id in ("+contactSetInfo.getNodeIpsId()+")";
						nnList = this.executeSQL(nnNameSql);
					}else{
						nnNameSql = "select nt.node_name from node_table nt where nt.node_group_id in ("+contactSetInfo.getNodeGroupsId()+") ";
						if(contactSetInfo.getIsLoop()==null || contactSetInfo.getIsLoop()==0){	//非周期任务
							nnNameSql += "and nt.seq_id in (select mrt.seq_id from mission_result_table"+contactSetInfo.getMissionType()+" mrt where mrt.mission_id="+mId+")";
						}else{	//周期任务
							nnNameSql += "and nt.seq_id in (select distinct mrt.seq_id from mission_result_table4 mrt where mrt.mission_id in (select lmst.cur_mission_id from loopmission_state_table lmst where lmst.mission_id="+mId+"))";
						}
						nnList = this.executeSQL(nnNameSql.toString());
					}
					if(nnList != null && nnList.size()>0){
						StringBuffer nnsb = new StringBuffer();
						for(Object nn : nnList){
							if(nn!=null) {
								nnsb.append(","+nn.toString());
							}
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
		}
		return contactSetInfo;
	}
	
	private LinkedList<String> getEmailList(ContactSetInfo contactSetInfo,Long seqId) {
		LinkedList<String> emailList = new LinkedList<String>();
			if(contactSetInfo!=null && contactSetInfo.getViewLevel()!=null){
				try {
					if(contactSetInfo.getViewLevel().intValue()==1){	//个人查看	邮件发送给 创建者
						String sql1 = "select distinct xyj.email from xt_yh_jbxx xyj where xyj.yhid = '"+contactSetInfo.getCreateUserId()+"' and xyj.is_receiveemail='0'";
						List<Object[]> map1 = this.executeSQL(sql1);
						if(map1 != null && map1.size()>0){
							Object objEmail = map1.get(0);
							if(objEmail!=null) {
								emailList.add(objEmail.toString());								
							}
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
							selectSql.append("where  nt.node_state = 0 ");		//  节点有效状态 0有效
							selectSql.append("and ngt.is_valid = 1 ");		//  节点组有效状态 1有效
							selectSql.append("and st.system_state  = 0 ");		//  系统有效状态 0有效
							selectSql.append("and xjj.zxbz = 0 ");		//  用户组有效状态 0有效
							selectSql.append("and xjj.type = 1 ");		//  组类别状态 1是用户组 0是角色
							selectSql.append("and xyj.zxbz = 0 and xyj.is_receiveemail='0'");		//  用户有效状态 0 有效
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
							List<Object[]> mapList = this.executeSQL(selectSql.toString());
							if(mapList != null && mapList.size()>0){
								for (Object objTmp:mapList) {
									if(objTmp!=null) {
										emailList.add(objTmp.toString());										
									}
								}
							}
						}
						//-- 组或系统内指定联系人情况
						else{
							String sql0 = "select distinct xyj.email from xt_yh_jbxx xyj where xyj.yhid in ("+contactSetInfo.getContactUserIds()+") and xyj.is_receiveemail='0'";
							List<Object[]> map0List = this.executeSQL(sql0);
							if(map0List != null && map0List.size()>0){
								for (Object objTmp2:map0List) {
									if(objTmp2!=null) {
										emailList.add(objTmp2.toString());										
									}
								}
							}
						}
					}
				} catch (Exception e) {
					logger.error(" Fail to query the list of email addresses to be sent to failure!",e);
				}
			}
		 
		return emailList;
	}
	
	/**
	 * 字节平均速度图示计算方法
	 * @time May 21, 2013-9:48:02 AM
	 * @param sourceList <Object []{longTime(sort asc),dataFlag,ifSpeed,octetsSpeed,octets(x64)}> 
	 * @param timeout 超时时间
	 * @return
	 * @throws Exception
	 */
	public Object[] bitSpeedSourceList(List<Object[]> sourceList,Long timeout)throws Exception{
			
		List<Object[]> dataArea = new LinkedList<Object[]>();
		List<Object[]> dataPoint = new LinkedList<Object[]>();
		
		/**
		 * 
		 * 1、超时时间范围内两点计算平均速度
		 * 2、超出超时时间两点无法计算：
		 * 		第一个超出时间点，取前一点速度计算值并增加空点
		 * 		连续超出时间的点，第二个及之后超出时间点速度值为null
		 * 3、计算结果值与带宽值进行比较，大于带宽值时，按超出时间点处理
		 * */
		Object prevValue = null;
		if(sourceList!=null){
			for (int i = 0; i < sourceList.size(); i++) {
				
				Object[] olds = (Object[]) sourceList.get(i);
				dataPoint.add(new Object[]{olds[0],olds[3]});
				
				Object[] news = null;
				
				//获取下移时间点数据
				if(i+1<sourceList.size()){
					news = (Object[])sourceList.get(i+1);
				}else{	//不再计算 如展示数据集合
					if(dataArea.size()==0) {
						dataArea.add(new Object[]{olds[0],null});
					}else {
						dataArea.add(new Object[]{olds[0],dataArea.get(dataArea.size()-1)[1]});
					}
					continue;
				}
				
				//展示图数据点
				Object[] tmp = new Object[]{olds[0],prevValue};
				
				//64位计数据标示 false为32位计数
				boolean data64FlagOld = olds[1]==null?false:("1".equals(olds[1].toString())?true:false);

				//64位计数据标示 false为32位计数
				boolean data64Flag = news[1]==null?false:("1".equals(news[1].toString())?true:false);
				
				//news 和 old 均不为空的情况	计算值
				long newsTime = news[0]==null?null:Long.parseLong(news[0].toString());
				long oldsTime = olds[0]==null?null:Long.parseLong(olds[0].toString());
				
				// 当时间间隔超过两周期时  取消当前点计算，并增加空点 处理规则如上部描述
				if(newsTime > oldsTime+timeout*2){	//相邻数据间超过计算周期，不再计算 但需要设置空点(断点)
					tmp[1] = prevValue;
					dataArea.add(tmp);
					if(prevValue != null){	//前一计算值非空，做空值断点处理
						prevValue = null;
						dataArea.add(new Object[]{oldsTime+1l,null});
					}
					continue;
				}
//				logger.warn(newsTime+" tvs "+oldsTime);
				// 数据计数格式不相同不计算 处理方式同超时时间点
				if(data64FlagOld != data64Flag){
					tmp[1] = prevValue;
					dataArea.add(tmp);
					if(prevValue != null){	//前一计算值非空，做空值断点处理
						prevValue = null;
						dataArea.add(new Object[]{oldsTime+1l,null});
					}
					continue;
				}
				
				//计算
				double newCts = news[4]==null?0d:Double.parseDouble(news[4].toString());
				double oldCts = olds[4]==null?0d:Double.parseDouble(olds[4].toString());
				double oldWidth = olds[2]==null?0d:Double.parseDouble(olds[2].toString());
//				logger.warn(newCts+" tvs "+oldCts);
				tmp[1] = bitSpeedMath(newCts, newsTime, oldCts, oldsTime, data64Flag,oldWidth);//超过带宽的值
				
				if(tmp[1] ==null ){	//超时时间情况处理 
					tmp[1] = prevValue;
					dataArea.add(tmp);
					if(prevValue != null){	//前一计算值非空，做空值断点处理
						prevValue = null;
						dataArea.add(new Object[]{oldsTime+1l,null});
					}
				}else{	//校验数据合法性
					
					prevValue = tmp[1];
					dataArea.add(tmp);
				}
			}
	    }
		
		//-返回结果数据集合
		List<List<Object[]>> objs = new ArrayList<List<Object[]>>();
		objs.add(dataArea);
		objs.add(dataPoint);
		return (Object[]) objs.toArray();
		
	}
	
	
	public List<Object[]> pktDiscardsList(List<Object[]> sourceList)throws Exception{
		
		List<Object[]> dataArea = new LinkedList<Object[]>();
		
		/**
		 * 1、超时时间范围内两点计算平均速度
		 * 2、超出超时时间两点无法计算，去前一点平均速度
		 * 		连续超出超时时间点，第二个点及之后超出时间点值为null
		 * */
		if(sourceList!=null){
			for (int i = 0; i < sourceList.size(); i++) {
				
				Object[] olds = (Object[]) sourceList.get(i);

				Object[] news = null;
				
				//获取下移时间点数据
				if(i+1<sourceList.size()){
					news = (Object[])sourceList.get(i+1);
				}else{	//不再计算 如展示数据集合
					continue;
				}
				
				//展示图数据点
				Object[] tmp = new Object[]{news[0],null};
				
				//计算
				double newDiscards = news[4]==null?0d:Double.parseDouble(news[4].toString());
				double oldDiscards = olds[4]==null?0d:Double.parseDouble(olds[4].toString());
//				logger.warn(newUcastpkts+" vs "+oldUcastpkts+"  "+newNucastpkts+" vs "+oldNucastpkts);
				double discards = newDiscards - oldDiscards;
				if(discards >= 0 ){
					tmp[1] = new Double(discards).longValue();
				}
				dataArea.add(tmp);
			}
	    }
		
		//-返回结果数据集合
		return dataArea;
	}
	
	/**
	 * 包平均速度图示计算方法
	 * @time May 21, 2013-9:48:02 AM
	 * @param sourceList <Object []{longTime(sort asc),width,dataFlag,pktSpeed,upkt(x64),nupkt(x64),octs}> 
	 * @param timeout 超时时间
	 * @return
	 * @throws Exception
	 */
	public Object[] pktSpeedSourceList(List<Object[]> sourceList,Long timeout)throws Exception{
			
		List<Object[]> dataArea = new LinkedList<Object[]>();
		List<Object[]> dataPoint = new LinkedList<Object[]>();
		
		/**
		 * 1、超时时间范围内两点计算平均速度
		 * 2、超出超时时间两点无法计算，去前一点平均速度
		 * 		连续超出超时时间点，第二个点及之后超出时间点值为null
		 * */
		Object prevValue = null;
		if(sourceList!=null){
			for (int i = 0; i < sourceList.size(); i++) {
				
				Object[] olds = (Object[]) sourceList.get(i);
				dataPoint.add(new Object[]{olds[0],olds[3]});
//				logger.warn(Arrays.toString(olds));
				Object[] news = null;
				
				//获取下移时间点数据
				if(i+1<sourceList.size()){
					news = (Object[])sourceList.get(i+1);
				}else{	//不再计算 如展示数据集合
					dataArea.add(new Object[]{olds[0],dataArea.get(dataArea.size()-1)[1]});
					continue;
				}
				
				//展示图数据点
				Object[] tmp = new Object[]{olds[0],prevValue};
				
				//仅计算64位数据作展示
				boolean data64FlagOld = olds[1]==null?false:("1".equals(olds[1].toString())?true:false);
				//仅计算64位数据作展示
				boolean data64Flag = news[1]==null?false:("1".equals(news[1].toString())?true:false);
				
				// news 和old 均不为空的情况	计算值
				long newsTime = news[0]==null?null:Long.parseLong(news[0].toString());
				long oldsTime = olds[0]==null?null:Long.parseLong(olds[0].toString());

				// 当时间间隔超过两周期时  取消当前点计算，增加空点
				if(newsTime > oldsTime+timeout*2){	//相邻数据间超过计算周期，不再计算 但需要设置空点(断点)
					tmp[1] = prevValue;
					dataArea.add(tmp);
					if(prevValue != null){	//前一计算值非空，做空值断点处理
						prevValue = null;
						dataArea.add(new Object[]{oldsTime+1l,null});
					}
					continue;
				}
				
				// 数据计数格式不相同不计算 处理方式同超时时间点
				if(data64FlagOld != data64Flag){
					tmp[1] = prevValue;
					dataArea.add(tmp);
					if(prevValue != null){	//前一计算值非空，做空值断点处理
						prevValue = null;
						dataArea.add(new Object[]{oldsTime+1l,null});
					}
					continue;
				}
				
				//计算
				double minPacketLength = 28;
				double oldWidth = olds[2]==null?0d:Double.parseDouble(olds[2].toString());
				double newUcastpkts = news[4]==null?0d:Double.parseDouble(news[4].toString());
				double newNucastpkts = news[5]==null?0d:Double.parseDouble(news[5].toString());
				double newCts = news[6]==null?0d:Double.parseDouble(news[6].toString());
				double oldUcastpkts = olds[4]==null?0d:Double.parseDouble(olds[4].toString());
				double oldNucastpkts = olds[5]==null?0d:Double.parseDouble(olds[5].toString());
				double oldCts = olds[6]==null?0d:Double.parseDouble(olds[6].toString());
//				logger.warn(newUcastpkts+" vs "+oldUcastpkts+"  "+newNucastpkts+" vs "+oldNucastpkts);
//				if(oldWidth!=0){
//					int isd = 0;
//					isd = 2;
//				}
				Double bitSpeed = bitSpeedMath(newCts, newsTime, oldCts, oldsTime, data64Flag,oldWidth);
				Double pktsSpeed = pktsSpeedMath(newUcastpkts, newNucastpkts, newsTime, oldUcastpkts, oldNucastpkts, oldsTime, data64FlagOld);
				if(bitSpeed == null || pktsSpeed == null || bitSpeed < pktsSpeed*minPacketLength){
					pktsSpeed = null;
				}
				tmp[1] = pktsSpeed;
				if(tmp[1] ==null){
					tmp[1] = prevValue;
					dataArea.add(tmp);
					if(prevValue != null){	//前一计算值非空，做空值断点处理
						prevValue = null;
						dataArea.add(new Object[]{oldsTime+1l,null});
					}
				}else{
					prevValue = tmp[1];
					dataArea.add(tmp);
				}
				
			}
	    }
		
		//-返回结果数据集合
		List<List<Object[]>> objs = new ArrayList<List<Object[]>>();
		objs.add(dataArea);
		objs.add(dataPoint);
		return objs.toArray();
	}
	

	/**
	 * 根据前后两点时间 及两点的数据，进行速度计算
	 * 描述：后前两点
	 * @time May 28, 2013-3:30:50 PM
	 * @param newOctets
	 * @param newTime
	 * @param oldOctets
	 * @param oldTime
	 * @param dataFlag64
	 * @return
	 * @throws Exception
	 */
	private Double bitSpeedMath(double newOctets,long newTime,double oldOctets,long oldTime,boolean dataFlag64,double oldWidth)throws Exception{
		BigDecimal value64 = new BigDecimal((1d+Long.MAX_VALUE)*2);
		BigDecimal value32 = new BigDecimal((1d+Integer.MAX_VALUE)*2);
		BigDecimal octets = new BigDecimal(newOctets-oldOctets);
		
		if(octets.doubleValue()<0){
			if(dataFlag64){
				octets=octets.add(value64);
			}else{
				octets=octets.add(value32);
			}
		}
		//logger.info("octets->"+octets+"="+dataFlag64);
		BigDecimal timss = new BigDecimal(newTime-oldTime);
		
		if(timss.longValue()>0){
			//logger.info(newTime+"->"+oldTime+"data:>"+"("+newOctets+"-"+oldOctets+")="+(newOctets-oldOctets)+" / timss "+timss+" values "+octets.multiply(new BigDecimal(1000)).multiply(new BigDecimal(8)).divide(timss, 5, BigDecimal.ROUND_HALF_UP)/*.divide(new BigDecimal(1024),2).divide(new BigDecimal(1024),2)*/.setScale(0, BigDecimal.ROUND_UP).doubleValue());
			//乘以1000，是要把每毫秒转换为每秒
			double value = octets.multiply(new BigDecimal(1000)).multiply(new BigDecimal(8)).divide(timss, 2, BigDecimal.ROUND_HALF_UP)/*.divide(new BigDecimal(1024),2).divide(new BigDecimal(1024),2)*/.setScale(0, BigDecimal.ROUND_UP).doubleValue();		// 字节/ms -->Mb/s
//			return octets.multiply(new BigDecimal(1000)).multiply(new BigDecimal(8)).divide(timss, 2, BigDecimal.ROUND_HALF_UP)/*.divide(new BigDecimal(1024),2).divide(new BigDecimal(1024),2)*/.setScale(0, BigDecimal.ROUND_UP).doubleValue();		// 字节/ms -->Mb/s
			return value>oldWidth?null:value;
		}else{
			return null;
		}
	}
	
	/**
	 * 端口包速度计算
	 * U包和NU包各后前相减，根据计数器格式，进行非负数处理。
	 * 
	 * @time May 27, 2013-11:22:13 AM
	 * @param newUcastpkts
	 * @param newNucastpkts
	 * @param newTime
	 * @param oldUcastpkts
	 * @param oldNucastpkts
	 * @param oldTime
	 * @param dataFlag64
	 * @return
	 */
	private Double pktsSpeedMath(double newUcastpkts,double newNucastpkts,long newTime,double oldUcastpkts,double oldNucastpkts,long oldTime,boolean dataFlag64){
		BigDecimal value64 = new BigDecimal((1d+Long.MAX_VALUE)*2);
		BigDecimal value32 = new BigDecimal((1d+Integer.MAX_VALUE)*2);
		
		BigDecimal upkts = new BigDecimal((newUcastpkts-oldUcastpkts));
		if(upkts.doubleValue()<0){
			if(dataFlag64){
				upkts = upkts.add(value64);
			}else{
				upkts = upkts.add(value32);
			}
		}
		
		BigDecimal nupkts = new BigDecimal((newNucastpkts-oldNucastpkts));
		if(nupkts.doubleValue()<0){
			if(dataFlag64){
				nupkts = nupkts.add(value64);
			}else{
				nupkts = nupkts.add(value32);
			}
		}
		
		BigDecimal pkts = new BigDecimal((upkts.doubleValue()+nupkts.doubleValue()));
		BigDecimal timss = new BigDecimal(newTime-oldTime);
		
		
		if(timss.longValue()>0){
			return pkts.divide(timss, 5, BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(1000)).setScale(0, BigDecimal.ROUND_UP).doubleValue();	//pps
		}else{
			return null;
		}
	}
	/**
	 * 判断表是否已经存在
	 * @param tableName
	 * @return
	 * @throws Exception
	 */
	public int isTableExist(String tableName) throws Exception{
		String sql = null;
		if(Constant.IS_MYSQL){
			sql = "select COUNT(1) from information_schema.`TABLES` WHERE TABLE_SCHEMA  = 'nms' and UPPER(TABLE_NAME) = ? ";
		}else{
			sql = "SELECT COUNT(1) from user_tables where table_name = ? ";
		}
		List list = executeSQL(sql, tableName.toUpperCase().trim());
		return Integer.parseInt(list.get(0).toString());
	}

	/**
	 * 获取nodegroup_table group_id
	 * @param sql
	 * @param start
	 * @param idName
	 * @param pidName
	 * @return
	 * @throws Exception
	 */
	public String getGroupIdStartWith(String sql,String start) throws Exception{
		List<Map<String,Object>> list = this.startWithConnectBy(sql, start, "group_id", "parent_group_id");
		//StringBuilder sb = new StringBuilder("-9999");
		StringBuilder sb = new StringBuilder("-9999");
		for(Map<String,Object> m :list){
			sb.append(",");
			sb.append(HibernateGeneralDaoImpl.getIgnoreCase(m, "group_id"));
		}
		/*if(sb.length() > 0){
			sb.deleteCharAt(0);
		}*/
		return sb.toString();
		
	}
	
	public static void main(String[] args) {
		new CommonService().sendEmailForMission(Long.parseLong("1108"), "任务执行通知", "任务执行结束");
	}
}
