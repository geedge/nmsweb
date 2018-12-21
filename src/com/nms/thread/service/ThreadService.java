package com.nms.thread.service;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.nis.util.StringUtil;
import com.nms.thread.common.EmailTypeConstants;
import com.nms.thread.pool.ThreadPoolConfig;

import nis.nms.bean.EmailInfo;
import nis.nms.bean.SetInfo;
import nis.nms.core.Constants;
import nis.nms.util.ConnectionOracle;
import nis.nms.util.Constant;

public class ThreadService {
	Logger logger = Logger.getLogger(ThreadService.class);
//	private CommonService commonService ;
	private ConnectionOracle dao;
//	public static ResourceBundle rb = ResourceBundle.getBundle("myconfig");
	public static URL url = ThreadService.class.getResource("myconfig.properties");
	public ThreadService(ConnectionOracle conn) {
		this.dao = conn;
	}
	
	/*public NmsErrorCode getNMSErrorCodeByName(String name){
		try {
			
			
			String sql = "select t.trouble_code,t.trouble_descr,t.system_id from trouble_state t";
			maps = conn.dbSelect(sql);
			List<NmsErrorCode> list =  conn.find("from NmsErrorCode nec where nec.errorName=?", name);
			if(list!= null && list.size()>0){
				return list.get(0);
			}else{
				return null;
			}
		} catch (Exception e) {
			logger.error("Get Error Code Error："+name, e);
			return null;
		}
	}
	
	public void saveNmsErrorInfo(String errorCode, Date errorTime,
			String errortGetip, String errortIp, Long errorState,
			Date stateUpdateTime, Long stateUpdateUserid){
		
		NmsErrorInfo info = new NmsErrorInfo(errorCode, errorTime,
				errortGetip, errortIp, errorState,
				stateUpdateTime, stateUpdateUserid);
		
		
		try {
			commonService.save(info);
		} catch (Exception e) {
			logger.error("Save Error Info Error："+(info==null?null:info.getErrorCode()), e);
		}
	}
	public void saveNmsErrorInfo(NmsErrorInfo info){
		
		
		NmsErrorInfo info = new NmsErrorInfo(errorCode, errorTime,
				errortGetip, errortIp, errorState,
				stateUpdateTime, stateUpdateUserid);
		
		
		try {
			conn.save(info);
			System.out.println("保存完成");
		} catch (Exception e) {
			logger.error("Save Error Info Error："+(info==null?null:info.getErrorCode()), e);
		}
	}
	*/
	private final SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");	
	/**
	 * 获取指定监测名称的SetInfo信息
	 * @time Oct 12, 2011-10:45:54 AM
	 * @param setInfoId		SetInfo ID
	 * @return
	 */
	public SetInfo getSetInfoByCheckName(Integer setInfoState,String checkTypeName) {
		SetInfo setInfo = new SetInfo();
		try {
			if(StringUtils.isNotBlank(checkTypeName)) {				
				// SetInfo信息查询
				ArrayList<String> fields = new ArrayList<String>();
				fields.add("id");
				fields.add("node_ips_id");
				fields.add("check_type_id");
				fields.add("check_gap");
				fields.add("check_out_time");
				fields.add("check_max_times");
				fields.add("process_Iden");
				fields.add("process_file");
				fields.add("process_path");
				fields.add("detection_set_state");
				fields.add("check_way");
				fields.add("check_type_name");
				fields.add("is_control_start");
				fields.add("control_start_time");
				fields.add("upload_gap");
				fields.add("plan_check_time");
				fields.add("is_schedule");
				fields.add("is_snmp");
				fields.add("node_groups_id");
				fields.add("check_type_name1");
				fields.add("process_Iden_name");
				String sql = "select dsi.id,dsi.check_type_id,dsi.node_ips_id,dsi.check_gap,dsi.check_out_time,dsi.check_max_times,check_way,dsi.process_Iden,dsi.process_file,dsi.process_path,cti.check_type_name,cti.is_snmp,dsi.detection_set_state, "
					+ "to_char(dsi.plan_check_time,'yyyy-MM-dd HH24:mi:ss') plan_check_time, "
					+ "dsi.is_control_start,dsi.upload_gap,dsi.control_start_time,is_schedule,dsi.node_groups_id,cti.check_type_name1,dsi.process_Iden_name "
					+ "from detection_set_info dsi "
					+ "left join check_type_info cti on cti.id = dsi.check_type_id " 
					+ "where lower(cti.check_type_name)=lower('"+checkTypeName+"')";
				if(setInfoState != null ){
					sql += " and dsi.DETECTION_SET_STATE ='"+setInfoState+"'";
				}
				sql += " and lower(cti.check_type_name) <>lower('SNMP_TRAP')";
				ArrayList<Map<String, String>> mapList = dao.dbSelect(sql,fields);
				if (mapList != null && mapList.size() > 0) {
					Map<String, String> map = mapList.get(0);
					setInfo.setId(StringUtils.isEmpty(map.get("id"))?null:Long.valueOf(map.get("id")));
					setInfo.setCheckTypeId(StringUtils.isEmpty(map.get("check_type_id"))?null:Long.valueOf(map.get("check_type_id")));
					setInfo.setCheckGap(StringUtils.isEmpty(map.get("check_gap"))?null:Long.valueOf(map.get("check_gap")));
					setInfo.setCheckOutTime(
							StringUtils.isEmpty(map.get("check_out_time"))?null:Long.valueOf(map.get("check_out_time")));
					setInfo.setCheckMaxTimes(
							StringUtils.isEmpty(map.get("check_max_times"))?null:Long.valueOf(map.get("check_max_times")));
					setInfo.setProcessIden(map.get("process_Iden"));
					setInfo.setProcessFile(map.get("process_file"));
					setInfo.setProcessPath(map.get("process_path"));
					setInfo.setCheckWay(map.get("check_way"));
					setInfo.setCheckState(map.get("detection_set_state"));
					setInfo.setCheckTypeName(map.get("check_type_name"));
					setInfo.setIsControlStart(map.get("is_control_start"));
					setInfo.setUploadGap(
							StringUtils.isEmpty(map.get("upload_gap"))?null:Long.valueOf(map.get("upload_gap"))
					);
					if (!StringUtils.isEmpty(map.get("plan_check_time"))) {
						setInfo.setPlanCheckTime(format.parse(map.get("plan_check_time")).getTime());
					}
					
					if (!StringUtils.isEmpty(map.get("control_start_time"))) {
						setInfo.setControlStartTime(format.parse(map.get("control_start_time")).getTime());
					}
					setInfo.setIsSchedule(StringUtils.trim(map.get("is_schedule")));
					setInfo.setIsSNMP(StringUtils.isBlank(map.get("is_snmp"))?null:Long.valueOf(StringUtils.trim(map.get("is_snmp"))));
					setInfo.setNodeIpsId(StringUtils.trim(map.get("node_ips_id")));
					setInfo.setNodeGroupsId(StringUtils.trim(map.get("node_groups_id")));
					setInfo.setCheckTypeName1(StringUtils.trim(map.get("check_type_name1")));
					setInfo.setProcessIdenName(StringUtils.trim(map.get("process_Iden_name")));
				}
			}
		} catch (Exception e) {
			logger.error("",e);
		}finally{
			dao.clearConn();
		}
		return setInfo;
	}
	
	/**
	 * 获取指定ID的SetInfo信息
	 * @time Oct 12, 2011-10:45:54 AM
	 * @param setInfoId		SetInfo ID
	 * @return
	 */
	public List<SetInfo> getAllSetInfo(Integer setInfoState,Integer checkWay) {
		List<SetInfo> setInfoList = new ArrayList<SetInfo>();
		try {
			// SetInfo信息查询
			ArrayList<String> fields = new ArrayList<String>();
			fields.add("id");
			fields.add("node_ips_id");
			fields.add("check_type_id");
			fields.add("check_gap");
			fields.add("check_out_time");
			fields.add("check_max_times");
			fields.add("process_Iden");
			fields.add("process_file");
			fields.add("process_path");
			fields.add("detection_set_state");
			fields.add("check_way");
			fields.add("check_type_name");
			fields.add("is_control_start");
			fields.add("control_start_time");
			fields.add("upload_gap");
			fields.add("plan_check_time");
			fields.add("is_schedule");
			fields.add("is_snmp");
			fields.add("node_groups_id");
			fields.add("check_type_name1");
			fields.add("process_Iden_name");
			String sql = "select dsi.id,dsi.check_type_id,dsi.node_ips_id,dsi.check_gap,dsi.check_out_time,dsi.check_max_times,check_way,dsi.process_Iden,dsi.process_file,dsi.process_path,cti.check_type_name,cti.is_snmp,dsi.detection_set_state, "
				+ "to_char(dsi.plan_check_time,'yyyy-MM-dd HH24:mi:ss') plan_check_time, "
				+ "dsi.is_control_start,dsi.upload_gap,dsi.control_start_time,is_schedule,dsi.node_groups_id,cti.check_type_name1,dsi.process_Iden_name "
				+ "from detection_set_info dsi "
				+ "left join check_type_info cti on cti.id = dsi.check_type_id " 
				+ "where 1=1";
			if(setInfoState != null ){
				sql += " and dsi.DETECTION_SET_STATE ='"+setInfoState+"'";
			}
			if(checkWay != null ){
				sql += " and dsi.CHECK_WAY ='"+checkWay+"'";
			}
			sql += " and lower(cti.check_type_name) <>lower('SNMP_TRAP')";
			ArrayList<Map<String, String>> mapList = dao.dbSelect(sql,fields);
			if (mapList != null && mapList.size() > 0) {
				for (Map<String, String> map : mapList) {
					SetInfo setInfo = new SetInfo();
					setInfo.setId(StringUtils.isEmpty(map.get("id"))?null:Long.valueOf(map.get("id")));
					setInfo.setCheckTypeId(StringUtils.isEmpty(map.get("check_type_id"))?null:Long.valueOf(map.get("check_type_id")));
					setInfo.setCheckGap(StringUtils.isEmpty(map.get("check_gap"))?null:Long.valueOf(map.get("check_gap")));
					setInfo.setCheckOutTime(
							StringUtils.isEmpty(map.get("check_out_time"))?null:Long.valueOf(map.get("check_out_time")));
					setInfo.setCheckMaxTimes(
							StringUtils.isEmpty(map.get("check_max_times"))?null:Long.valueOf(map.get("check_max_times")));
					setInfo.setProcessIden(map.get("process_Iden"));
					setInfo.setProcessFile(map.get("process_file"));
					setInfo.setProcessPath(map.get("process_path"));
					setInfo.setCheckWay(map.get("check_way"));
					setInfo.setCheckState(map.get("detection_set_state"));
					setInfo.setCheckTypeName(map.get("check_type_name"));
					setInfo.setIsControlStart(map.get("is_control_start"));
					setInfo.setUploadGap(
							StringUtils.isEmpty(map.get("upload_gap"))?null:Long.valueOf(map.get("upload_gap"))
					);
					if (!StringUtils.isEmpty(map.get("plan_check_time"))) {
						setInfo.setPlanCheckTime(format.parse(map.get("plan_check_time")).getTime());
					}
					
					if (!StringUtils.isEmpty(map.get("control_start_time"))) {
						setInfo.setControlStartTime(format.parse(map.get("control_start_time")).getTime());
					}
					setInfo.setIsSchedule(StringUtils.trim(map.get("is_schedule")));
					setInfo.setIsSNMP(StringUtils.isBlank(map.get("is_snmp"))?null:Long.valueOf(StringUtils.trim(map.get("is_snmp"))));
					setInfo.setNodeIpsId(StringUtils.trim(map.get("node_ips_id")));
					setInfo.setNodeGroupsId(StringUtils.trim(map.get("node_groups_id")));
					setInfo.setCheckTypeName1(StringUtils.trim(map.get("check_type_name1")));
					setInfo.setProcessIdenName(StringUtils.trim(map.get("process_Iden_name")));
//					setInfo.setNodeIp(map.get("node_ip"));
//					setInfo.setGroupId(StringUtils.isEmpty(map.get("group_id"))?null:Long.valueOf(map.get("group_id")));
					setInfoList.add(setInfo);
				}
			}
		} catch (Exception e) {
			logger.error("",e);
		}finally{
			dao.clearConn();
		}
		return setInfoList;
	}
	
	//查询超时的握手监测节点的seqId
	public List<String> searchTimeoutNmsClient(SetInfo setInfo){
		List<String> errorSeqIds = new ArrayList<String>();
		if(setInfo!=null && setInfo.getId()!=null) {
			String sql = "select t.seq_id from detection_info_new t " +
				" where exists(select * from node_table nt left join nodegroup_table ngt on nt.node_group_id=ngt.group_id where nt.NODE_STATE=0 and ngt.is_valid=1 and nt.seq_id=t.seq_id) and" +
				" t.detection_set_info_id="+setInfo.getId()+" and t.detectioned_state in (-1,0)" +
				" order by t.data_check_time desc";
			ArrayList<String> fields = new ArrayList<String>();
			fields.add("seq_id");
			try {
//				System.out.println(""+sql);
				ArrayList<Map<String, String>> mapsList = dao.dbSelect(sql, fields);	
				if(mapsList!=null && mapsList.size()>0) {
					for(Map<String, String> maps : mapsList){
						errorSeqIds.add(maps.get(fields.get(0)));
					}
				}
			} catch (Exception e) {
				logger.error("SeqId exception of a handshake monitoring node that queries over time!",e);
			}
		}
		
		return errorSeqIds;
	}
	
	public List<String []> detectDatasTimeoutCheck(SetInfo setInfo,Date startTime,String errorSeqIds){
		List<String []> alarmInfoList = new ArrayList<String[]>();
		String sql = null;
		Integer delay = ThreadPoolConfig.DETEC_TIMEOUT_ALARM_PERIOD_DELAY;
		//无效状态跳过
		if(!(StringUtils.isNotEmpty(setInfo.getCheckState()) && "1".equals(setInfo.getCheckState())))return alarmInfoList;//监测设置的状态是否有效，无效则不检查，返回空列表
		int periodTimes = ThreadPoolConfig.DETEC_TIMEOUT_ALARM_PERIOD_TIMES;	
//		periodTimes = 1;	
		//节点
		String systemidSql = "-1".equals(Constant.CURRENT_SYSTEM_ID) ? "" : ("and nt.system_id=" + Constant.CURRENT_SYSTEM_ID);
		if(StringUtils.isNotBlank(setInfo.getNodeIpsId())){
			sql="select nt0.seq_id,nt0.node_ip,nt0.NODE_TYPE from " +
			"(select distinct nt.seq_id,nt.node_ip,nt.NODE_TYPE from node_table nt left join nodegroup_table ngt on ngt.group_id = nt.node_group_id where nvl(ngt.is_valid, '1') = '1' and nt.node_id in (-9999,"+setInfo.getNodeIpsId()+", -9999) and nt.node_state = 0 " + systemidSql + ") nt0" +
			" where (not exists (select din.seq_id from detection_info_new din where nt0.seq_id = din.seq_id and din.detection_set_info_id = '"+setInfo.getId()+"') " +
			" or exists (select din.seq_id from detection_info_new din where nt0.seq_id = din.seq_id and din.detection_set_info_id = '"+setInfo.getId()+"' and  din.DATA_CHECK_TIME < sysdate  - "+((setInfo.getCheckGap()==null?5:setInfo.getCheckGap())*periodTimes+delay)+"/24/60 ))";
//			 sql = "select din.seq_id from detection_info_new din where " +
//			"(din.seq_id not in(select distinct nt.seq_id from node_table nt left join nodegroup_table ngt on ngt.group_id = nt.node_group_id where nvl(ngt.is_valid,'1') = '1' and nt.node_id in (0,"+setInfo.getNodeIpsId()+",0) and nt.node_state =0) or (din.seq_id in(select distinct nt.seq_id from node_table nt left join nodegroup_table ngt on ngt.group_id = nt.node_group_id where nvl(ngt.is_valid,'1') = '1' and nt.node_id in (0,"+setInfo.getNodeIpsId()+",0) and nt.node_state =0) and sysdate - din.DATA_CHECK_TIME - "+((setInfo.getCheckGap()==null?5:setInfo.getCheckGap())*Constants.DETEC_TIMEOUT_ALARM_PERIOD_TIMES+5)+"/24/60> 0 ) )"+
//					" and din.detection_set_info_id = "+setInfo.getId();
		}else
			//节点组
			if(StringUtils.isNotBlank(setInfo.getNodeGroupsId())){
			
				//@2018-3-12 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
				String groupIdSql = "select nt.group_id from NODEGROUP_TABLE nt where nt.leaf_group = 1 ";
				String ids = "";
				try {
					ids = dao.startWithConnectBy(groupIdSql, "nt.group_id in (-9999,"+setInfo.getNodeGroupsId()+", -9999)","group_id","parent_group_id");
				} catch (Exception e) {
					e.printStackTrace();
				}
				sql="select nt0.seq_id,nt0.node_ip,nt0.NODE_TYPE from " +
				"(select distinct nt.seq_id,nt.node_ip,nt.NODE_TYPE from node_table nt left join nodegroup_table ngt on ngt.group_id = nt.node_group_id where nvl(ngt.is_valid, '1') = '1' and nt.node_group_id in ("+ids+") and nt.node_state = 0 " + systemidSql + ") nt0" +
				" where (not exists (select din.seq_id from detection_info_new din where nt0.seq_id = din.seq_id and din.detection_set_info_id = '"+setInfo.getId()+"') " +
				" or exists (select din.seq_id from detection_info_new din where nt0.seq_id = din.seq_id and din.detection_set_info_id = '"+setInfo.getId()+"' and  din.DATA_CHECK_TIME < sysdate - "+((setInfo.getCheckGap()==null?5:setInfo.getCheckGap())*periodTimes+delay)+"/24/60 ))";
/*				sql="select nt0.seq_id,nt0.node_ip,nt0.NODE_TYPE from " +
						"(select distinct nt.seq_id,nt.node_ip,nt.NODE_TYPE from node_table nt left join nodegroup_table ngt on ngt.group_id = nt.node_group_id where nvl(ngt.is_valid, '1') = '1' and nt.node_group_id in (select nt.group_id from NODEGROUP_TABLE nt where nt.leaf_group = 1 start with nt.group_id in (-9999,"+setInfo.getNodeGroupsId()+", -9999) connect by prior nt.group_id = nt.parent_group_id) and nt.node_state = 0) nt0" +
						" where (not exists (select din.seq_id from detection_info_new din where nt0.seq_id = din.seq_id and din.detection_set_info_id = '"+setInfo.getId()+"') " +
						" or exists (select din.seq_id from detection_info_new din where nt0.seq_id = din.seq_id and din.detection_set_info_id = '"+setInfo.getId()+"' and  sysdate - din.DATA_CHECK_TIME - "+((setInfo.getCheckGap()==null?5:setInfo.getCheckGap())*periodTimes+5)+" / 24 / 60 > 0))";
*/				

				
			}else
				//全局
				if(StringUtils.isBlank(setInfo.getNodeGroupsId())){
					sql="select nt0.seq_id,nt0.node_ip,nt0.NODE_TYPE from " +
					"(select distinct nt.seq_id,nt.node_ip,nt.NODE_TYPE from node_table nt left join nodegroup_table ngt on ngt.group_id = nt.node_group_id where nvl(ngt.is_valid, '1') = '1' and nt.node_state = 0 " + systemidSql + ") nt0" +
					" where (not exists (select din.seq_id from detection_info_new din where nt0.seq_id = din.seq_id and din.detection_set_info_id = '"+setInfo.getId()+"') " +
					" or exists (select din.seq_id from detection_info_new din where nt0.seq_id = din.seq_id and din.detection_set_info_id = '"+setInfo.getId()+"' and din.DATA_CHECK_TIME < sysdate  - "+((setInfo.getCheckGap()==null?5:setInfo.getCheckGap())*periodTimes+5)+"/24/60))";
					
//			 sql = "select din.seq_id from detection_info_new din where " +
//					"(din.seq_id not in(select distinct nt.seq_id from node_table nt left join nodegroup_table ngt on ngt.group_id = nt.node_group_id where nvl(ngt.is_valid,'1') = '1'and nt.node_state =0) or (din.seq_id in(select distinct nt.seq_id from node_table nt left join nodegroup_table ngt on ngt.group_id = nt.node_group_id where nvl(ngt.is_valid,'1') = '1' and nt.node_state =0) and sysdate - din.DATA_CHECK_TIME - "+((setInfo.getCheckGap()==null?5:setInfo.getCheckGap())*Constants.DETEC_TIMEOUT_ALARM_PERIOD_TIMES+5)+"/24/60> 0) )" +
//					" and din.detection_set_info_id  = "+setInfo.getId();
				}
		
		if(StringUtils.isNotBlank(errorSeqIds)) {//握手监测异常节点的seqId，对于握手监测异常的节点，无需检查其他监测信息
			String[] arr = errorSeqIds.split(",");
			StringBuffer strb = new StringBuffer();
			for(int i=0;i<arr.length;i++){
				if(i!=0&&i%1000==0){
					strb.deleteCharAt(strb.length() - 1);
					strb.append(") or nt0.seq_id not in ( '"+ arr[i] + "',");
				}else{
					strb.append("'" + arr[i] + "',");
				}
			}
			if(strb.length()>0){
				strb.deleteCharAt(strb.length() - 1);
			}
			sql = sql+" and (nt0.seq_id not in("+strb+"))";
		}
		
		ArrayList<String> fields = new ArrayList<String>();
		fields.add("seq_id");
		fields.add("NODE_TYPE");
		fields.add("node_ip");
		FileInputStream inStream = null;
		try {
//			logger.info("查询"+setInfo.getCheckTypeName()+"监测，超周期无上报数据sql："+sql);
//			System.out.println("查询"+setInfo.getCheckTypeName()+"监测，超周期无上报数据sql==："+sql);
			ArrayList<Map<String, String>> mapsList = dao.dbSelect(sql, fields);
			boolean mainFlag = false;//全局监测
			boolean serverFlag = false;
			boolean scheduleFlag = false;//预置监测
			boolean otherFlag = false;
			
			/** 全局监测
			 * 节点不对应不进行告警
			 *  */
			
			if(StringUtils.isEmpty(setInfo.getNodeGroupsId())){//全局的监测
				mainFlag =  true;
			}
			if("0".equals(setInfo.getIsSchedule())){// 0预置监测类型，1三方监测类型，2页面不显示（如snmp_trap）
				scheduleFlag = true;
			}
			
			/* 监测类型判断ISSNMP */
			URL url2 = ThreadService.class.getResource("/myconfig.properties");
			Properties properties = new Properties();
			inStream = new FileInputStream(url2.getPath().replace("%20", " "));
			properties.load(inStream);
			
			//获取预置监测设置名称
			String pingType = properties.getProperty("detec.ping.str");
			if(StringUtils.isEmpty(pingType)){
				pingType = "PING";
			}
			String nmscType = properties.getProperty("detec.nmsclient.str");
			if(StringUtils.isEmpty(nmscType)){
				nmscType = "NMSClient";
			}
			String systemType = properties.getProperty("detec.system.str");
			if(StringUtils.isEmpty(systemType)){
				systemType = "SYSTEM";
			}
			String switchPortType = properties.getProperty("detec.switch.str");
			if(StringUtils.isEmpty(switchPortType)){
				switchPortType = "switchport";
			}
			
			if(setInfo.getIsSNMP()==null || setInfo.getIsSNMP()==2l){	//监测仅适用于服务器节点（ping nmsclient除外）：是否是SNMP 监控，标识从属于字段IS_SCHEDULE的1三方监测类型：0，是ObjectSNMP监控 1，是SNMP4J监控，2 或null否  默认null
				serverFlag = true;
				if(scheduleFlag){//预置监测
					if(pingType.trim().equalsIgnoreCase(setInfo.getCheckTypeName()) || nmscType.trim().equalsIgnoreCase(setInfo.getCheckTypeName())){
						otherFlag = true;
					}
				}
			}else{	//监测适用于服务器节点或其他设备节点(system switchport 除外)
				otherFlag = true;
				serverFlag = true;
				if(scheduleFlag){	//预置监测
					if(switchPortType.trim().equalsIgnoreCase(setInfo.getCheckTypeName())
							|| systemType.trim().equalsIgnoreCase(setInfo.getCheckTypeName())){	//
						serverFlag = false;
					}
				}
			}
			
//			String emergent="1";//设置默认告警级别  如果监测类别为NMSClient则告警级别为紧急
//			if(nmscType.trim().equalsIgnoreCase(setInfo.getCheckTypeName())){
//				emergent= "0";
//				logger.info("*****握手监测告警，状态为紧急*****");
//			}
			
			//2013-10-28 hyx 当握手监测超周期无数据时，就不报其他监测的超周期无数据，此时握手监测超周期为紧急，则其它监测的超周期是否紧急就无关紧要了，但是当握手监测正常时，其它监测超周期，此时其它监测的超周期就要报一级紧急报警
			String emergent=Constants.DETEC_TIMEOUT_POLICE_EMERGENT;//所有的超周期默认都是紧急一级的（但是当握手和其它监测都超周期时，只会报握手的超周期，所以告警信息列表不会同时显示一个节点的握手超周期和其它监测超周期，只会显示握手或者其它监测超周期）
			
			StringBuffer alarmSeqId = new StringBuffer();
			for(Map<String, String> maps : mapsList){
				if(scheduleFlag){	//预置监测类型
					if("0".equals(maps.get("NODE_TYPE"))){	//是服务器节点
						if(serverFlag){		//适用于服务器监测，进行超时校验
							alarmSeqId.append(maps.get(fields.get(0))+",");
//							alarmInfoList.add(createAlarmInfo(setInfo, maps.get(fields.get(0)),maps.get(fields.get(2)),startTime,"超过 "+periodTimes+" 监测周期，未接收到监测结果信息",emergent));
							alarmInfoList.add(createAlarmInfo(setInfo, maps.get(fields.get(0)),maps.get(fields.get(2)),startTime,String.format(Constants.DETECT_TIMEOUT_ALARMINFO, periodTimes),emergent));
						}else{	//不适用于服务器监测，除全局监测外，进行不适用告警
							if(!mainFlag){
//								map.put(maps.get(fields.get(0)), maps.get(fields.get(2))+",");
								alarmSeqId.append(maps.get(fields.get(0))+",");
//								alarmInfoList.add(createAlarmInfo(setInfo, maps.get(fields.get(0)),maps.get(fields.get(2)),startTime,"该节点为服务器节点，不适用于该检测类别",emergent));
//								alarmInfoList.add(createAlarmInfo(setInfo, maps.get(fields.get(0)),maps.get(fields.get(2)),startTime,"This node is a server node and is not used to detect this category",emergent));
								alarmInfoList.add(createAlarmInfo(setInfo, maps.get(fields.get(0)),maps.get(fields.get(2)),startTime,"i18n_ThreadService.detectDatasTimeoutCheck.count_n81i",emergent));
							}
						}
					}else{		//非服务器节点
						if(otherFlag){	//适用于服务器监测，进行超时校验
							alarmSeqId.append(maps.get(fields.get(0))+",");
							alarmInfoList.add(createAlarmInfo(setInfo, maps.get(fields.get(0)),maps.get(fields.get(2)),startTime,String.format(Constants.DETECT_TIMEOUT_ALARMINFO, periodTimes),emergent));
						}else{
							if(!mainFlag){
								alarmSeqId.append(maps.get(fields.get(0))+",");
//								alarmInfoList.add(createAlarmInfo(setInfo, maps.get(fields.get(0)),maps.get(fields.get(2)),startTime,"该节点为非服务器节点，不适用于该检测类别",emergent));
//								alarmInfoList.add(createAlarmInfo(setInfo, maps.get(fields.get(0)),maps.get(fields.get(2)),startTime,"This node is a server node and is not used to detect this category",emergent));
								alarmInfoList.add(createAlarmInfo(setInfo, maps.get(fields.get(0)),maps.get(fields.get(2)),startTime,"i18n_ThreadService.detectDatasTimeoutCheck.count_n81i",emergent));
							}
						}
					}
				}else{
					alarmSeqId.append(maps.get(fields.get(0))+",");
					alarmInfoList.add(createAlarmInfo(setInfo, maps.get(fields.get(0)),maps.get(fields.get(2)),startTime,String.format(Constants.DETECT_TIMEOUT_ALARMINFO, periodTimes),emergent));
				}
			}
			if(alarmInfoList.size()>0){
				for(String[] strSrr:alarmInfoList) {
//						logger.info("超时告警数据 "+Arrays.toString(alarmInfoList.get(alarmInfoList.size()-1)));
//					System.out.println("超时告警数据 "+Arrays.toString(strSrr));
//					logger.info(setInfo.getCheckTypeName()+"超时告警数据: "+Arrays.toString(strSrr));//i18nlog
					
				}
			}
//			System.out.println("seqId "+alarmSeqId);
			//整理Email告警
			if(alarmSeqId.length()>0){
				alarmSeqId.deleteCharAt(alarmSeqId.length()-1);
				
				StringBuffer strb = new StringBuffer();
				if (StringUtils.isNotBlank(alarmSeqId.toString())) {
					String[] arr = alarmSeqId.toString().split(",");
					
					for (int i = 0; i < arr.length; i++) {
						if (i != 0 && i % 1000 == 0) {
							strb.deleteCharAt(strb.length() - 1);
							strb.append(") or nt.seq_id in ( '" + arr[i] + "',");
						} else {
							strb.append("'" + arr[i] + "',");
						}
					}
					if (strb.length() > 0) {
						strb.deleteCharAt(strb.length() - 1);
					}
				}
				
				String checkSql = "select nt0.seq_id,nt0.node_ip,nt0.NODE_TYPE from " +
				"(select distinct nt.seq_id,nt.node_ip,nt.NODE_TYPE from node_table nt where nt.seq_id in ("+strb+")) nt0 " +
				"where nt0.seq_id not in  ( select din.seq_id from detection_info_new din where din.detection_set_info_id = '"+setInfo.getId()+"') " +
				"or nt0.seq_id in ( select din.seq_id from detection_info_new din " +
				"where din.detection_set_info_id = '"+setInfo.getId()+"' and din.detectioned_state <> -1 or (din.detectioned_state = -1 and din.police_level <>1))";
//				System.out.println(checkSql);
				ArrayList<Map<String, String>> mapsList0 = dao.dbSelect(checkSql, fields);
				StringBuffer alarmIP = new StringBuffer();
				if(mapsList0!=null && mapsList0.size()>0){
					for(Map<String, String> map0 : mapsList0){
						int oldLen = alarmIP.toString().getBytes().length;
						int newLen = (map0.get(fields.get(2))+",").getBytes().length;
						if((oldLen+newLen)<70) {//数据库中actionIP的长度为100
							alarmIP.append(map0.get(fields.get(2))+",");
						}
					}
					alarmIP.deleteCharAt(alarmIP.length()-1);
					System.out.println("---"+alarmIP);
					EmailService emailService = new EmailService(dao);
					EmailInfo emailInfo = null;
					if(mapsList0.size()==1) {
						emailInfo = new EmailInfo(EmailTypeConstants.TYPE_DETECTION_INFO_TIMEOUT,setInfo.getProcessIdenName()+"("+setInfo.getCheckTypeName1()+")",alarmIP.toString(),format.format(System.currentTimeMillis()),alarmIP+"\n i18n_ThreadService.detectDatasTimeoutCheck.timeout_n81i",EmailTypeConstants.FLAG_SEND_LATER,EmailTypeConstants.URGENT_IMMEDIATELY);
					}else {
//						String subAlarmIpStr = alarmIP.toString()+"...\n获取监测数据超时";
//						String subAlarmIpStr = alarmIP.toString()+"...\nGet monitoring data timeout";
						String subAlarmIpStr = alarmIP.toString()+"...\n i18n_ThreadService.detectDatasTimeoutCheck.timeout_n81i";
//						emailInfo = new EmailInfo(EmailTypeConstants.TYPE_DETECTION_INFO_TIMEOUT,setInfo.getProcessIdenName()+"("+setInfo.getCheckTypeName1()+")","多IP",format.format(System.currentTimeMillis()),subAlarmIpStr,EmailTypeConstants.FLAG_SEND_LATER,EmailTypeConstants.URGENT_IMMEDIATELY);
						emailInfo = new EmailInfo(EmailTypeConstants.TYPE_DETECTION_INFO_TIMEOUT,setInfo.getProcessIdenName()+"("+setInfo.getCheckTypeName1()+")","i18n_ThreadService.detectDatasTimeoutCheck.ips_n81i",format.format(System.currentTimeMillis()),subAlarmIpStr,EmailTypeConstants.FLAG_SEND_LATER,EmailTypeConstants.URGENT_IMMEDIATELY);
					}
					emailService.sendEmailForDetection(setInfo.getId(),emailInfo);
//					emailService.saveEmailInfo(emailInfo);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				if(inStream!=null){					
					inStream.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return alarmInfoList;
	}
	
	public List<String []> detectDatasTimeoutCheck(SetInfo setInfo,Date startTime){
		List<String []> alarmInfoList = new ArrayList<String[]>();
		String sql = null;
		//无效状态跳过
		if(!(StringUtils.isNotEmpty(setInfo.getCheckState()) && "1".equals(setInfo.getCheckState())))return alarmInfoList;//监测设置的状态是否有效，无效则不检查，返回空列表
		int periodTimes = ThreadPoolConfig.DETEC_TIMEOUT_ALARM_PERIOD_TIMES;	
//		periodTimes = 1;	
		//节点
		if(StringUtils.isNotBlank(setInfo.getNodeIpsId())){
			sql="select nt0.seq_id,nt0.node_ip,nt0.NODE_TYPE from " +
			"(select distinct nt.seq_id,nt.node_ip,nt.NODE_TYPE from node_table nt left join nodegroup_table ngt on ngt.group_id = nt.node_group_id where nvl(ngt.is_valid, '1') = '1' and nt.node_id in (-9999,"+setInfo.getNodeIpsId()+", -9999) and nt.node_state = 0) nt0" +
			" where nt0.seq_id not in  ( select din.seq_id from detection_info_new din where din.detection_set_info_id = '"+setInfo.getId()+"') " +
			" or nt0.seq_id in ( select din.seq_id from detection_info_new din where din.detection_set_info_id = '"+setInfo.getId()+"' and  din.DATA_CHECK_TIME < sysdate  - "+((setInfo.getCheckGap()==null?5:setInfo.getCheckGap())*periodTimes+5)+"/24/60)";
			
			sql = sql+" and nt0.seq_id not in(-1)";
//			 sql = "select din.seq_id from detection_info_new din where " +
//			"(din.seq_id not in(select distinct nt.seq_id from node_table nt left join nodegroup_table ngt on ngt.group_id = nt.node_group_id where nvl(ngt.is_valid,'1') = '1' and nt.node_id in (0,"+setInfo.getNodeIpsId()+",0) and nt.node_state =0) or (din.seq_id in(select distinct nt.seq_id from node_table nt left join nodegroup_table ngt on ngt.group_id = nt.node_group_id where nvl(ngt.is_valid,'1') = '1' and nt.node_id in (0,"+setInfo.getNodeIpsId()+",0) and nt.node_state =0) and sysdate - din.DATA_CHECK_TIME - "+((setInfo.getCheckGap()==null?5:setInfo.getCheckGap())*Constants.DETEC_TIMEOUT_ALARM_PERIOD_TIMES+5)+"/24/60> 0 ) )"+
//					" and din.detection_set_info_id = "+setInfo.getId();
		}else
			
			//节点组
			if(StringUtils.isNotBlank(setInfo.getNodeGroupsId())){
				
				//@2018-3-12 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
				String groupIdSql = "select nt.group_id from NODEGROUP_TABLE nt where nt.leaf_group = 1 ";
				String ids = "";
				try {
					ids = dao.startWithConnectBy(groupIdSql, "nt.group_id in (-9999,"+setInfo.getNodeGroupsId()+", -9999)","group_id","parent_group_id");
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				sql="select nt0.seq_id,nt0.node_ip,nt0.NODE_TYPE from " +
				"(select distinct nt.seq_id,nt.node_ip,nt.NODE_TYPE from node_table nt left join nodegroup_table ngt on ngt.group_id = nt.node_group_id where nvl(ngt.is_valid, '1') = '1' and nt.node_group_id in ("+ids+") and nt.node_state = 0) nt0" +
				" where nt0.seq_id not in  ( select din.seq_id from detection_info_new din where din.detection_set_info_id = '"+setInfo.getId()+"') " +
				" or nt0.seq_id in ( select din.seq_id from detection_info_new din where din.detection_set_info_id = '"+setInfo.getId()+"' and  din.DATA_CHECK_TIME < sysdate  - "+((setInfo.getCheckGap()==null?5:setInfo.getCheckGap())*periodTimes+5)+"/24/60 )";
				
				/*sql="select nt0.seq_id,nt0.node_ip,nt0.NODE_TYPE from " +
				"(select distinct nt.seq_id,nt.node_ip,nt.NODE_TYPE from node_table nt left join nodegroup_table ngt on ngt.group_id = nt.node_group_id where nvl(ngt.is_valid, '1') = '1' and nt.node_group_id in (select nt.group_id from NODEGROUP_TABLE nt where nt.leaf_group = 1 start with nt.group_id in (-9999,"+setInfo.getNodeGroupsId()+", -9999) connect by prior nt.group_id = nt.parent_group_id) and nt.node_state = 0) nt0" +
				" where nt0.seq_id not in  ( select din.seq_id from detection_info_new din where din.detection_set_info_id = '"+setInfo.getId()+"') " +
				" or nt0.seq_id in ( select din.seq_id from detection_info_new din where din.detection_set_info_id = '"+setInfo.getId()+"' and  sysdate - din.DATA_CHECK_TIME - "+((setInfo.getCheckGap()==null?5:setInfo.getCheckGap())*periodTimes+5)+" / 24 / 60 > 0)";
				 */
				
			}else
				//全局
				if(StringUtils.isBlank(setInfo.getNodeGroupsId())){
					sql="select nt0.seq_id,nt0.node_ip,nt0.NODE_TYPE from " +
					"(select distinct nt.seq_id,nt.node_ip,nt.NODE_TYPE from node_table nt left join nodegroup_table ngt on ngt.group_id = nt.node_group_id where nvl(ngt.is_valid, '1') = '1' and nt.node_state = 0 ) nt0" +
					" where nt0.seq_id not in  ( select din.seq_id from detection_info_new din where din.detection_set_info_id = '"+setInfo.getId()+"') " +
					" or nt0.seq_id in ( select din.seq_id from detection_info_new din where din.detection_set_info_id = '"+setInfo.getId()+"' and  din.DATA_CHECK_TIME < sysdate  - "+((setInfo.getCheckGap()==null?5:setInfo.getCheckGap())*periodTimes+5)+"/24/60 )";
					
//			 sql = "select din.seq_id from detection_info_new din where " +
//					"(din.seq_id not in(select distinct nt.seq_id from node_table nt left join nodegroup_table ngt on ngt.group_id = nt.node_group_id where nvl(ngt.is_valid,'1') = '1'and nt.node_state =0) or (din.seq_id in(select distinct nt.seq_id from node_table nt left join nodegroup_table ngt on ngt.group_id = nt.node_group_id where nvl(ngt.is_valid,'1') = '1' and nt.node_state =0) and sysdate - din.DATA_CHECK_TIME - "+((setInfo.getCheckGap()==null?5:setInfo.getCheckGap())*Constants.DETEC_TIMEOUT_ALARM_PERIOD_TIMES+5)+"/24/60> 0) )" +
//					" and din.detection_set_info_id  = "+setInfo.getId();
				}
		
		ArrayList<String> fields = new ArrayList<String>();
		fields.add("seq_id");
		fields.add("NODE_TYPE");
		fields.add("node_ip");
		FileInputStream inStream = null;
		try {
			System.out.println(""+sql);
			ArrayList<Map<String, String>> mapsList = dao.dbSelect(sql, fields);
			boolean mainFlag = false;
			boolean serverFlag = false;
			boolean scheduleFlag = false;
			boolean otherFlag = false;
			
			/** 全局监测
			 * 节点不对应不进行告警
			 *  */
			
			if(StringUtils.isEmpty(setInfo.getNodeGroupsId())){//全局的监测
				mainFlag =  true;
			}
			if("0".equals(setInfo.getIsSchedule())){// 0预置监测类型，1三方监测类型，2页面不显示（如snmp_trap）
				scheduleFlag = true;
			}
			
			/* 监测类型判断ISSNMP */
			URL url2 = ThreadService.class.getResource("/myconfig.properties");
			Properties properties = new Properties();
			inStream = new FileInputStream(url2.getPath().replace("%20", " "));
			properties.load(inStream);
			
			//获取预置监测设置名称
			String pingType = properties.getProperty("detec.ping.str");
			if(StringUtils.isEmpty(pingType)){
				pingType = "PING";
			}
			String nmscType = properties.getProperty("detec.nmsclient.str");
			if(StringUtils.isEmpty(nmscType)){
				nmscType = "NMSClient";
			}
			String systemType = properties.getProperty("detec.system.str");
			if(StringUtils.isEmpty(systemType)){
				systemType = "SYSTEM";
			}
			String switchPortType = properties.getProperty("detec.switch.str");
			if(StringUtils.isEmpty(switchPortType)){
				switchPortType = "switchport";
			}
			
			if(setInfo.getIsSNMP()==null || setInfo.getIsSNMP()==2l){	//监测仅适用于服务器节点（ping nmsclient除外）：是否是SNMP 监控，标识从属于字段IS_SCHEDULE的1三方监测类型：0，是ObjectSNMP监控 1，是SNMP4J监控，2 或null否  默认null
				serverFlag = true;
				if(scheduleFlag){//预置监测
					if(pingType.trim().equalsIgnoreCase(setInfo.getCheckTypeName()) || nmscType.trim().equalsIgnoreCase(setInfo.getCheckTypeName())){
						otherFlag = true;
					}
				}
			}else{	//监测适用于服务器节点或其他设备节点(system switchport 除外)
				otherFlag = true;
				serverFlag = true;
				if(scheduleFlag){	//预置监测
					if(switchPortType.trim().equalsIgnoreCase(setInfo.getCheckTypeName())
							|| systemType.trim().equalsIgnoreCase(setInfo.getCheckTypeName())){	//
						serverFlag = false;
					}
				}
			}
			String emergent="1";
			if(nmscType.trim().equalsIgnoreCase(setInfo.getCheckTypeName())){
				emergent= "0";
			}
			StringBuffer alarmSeqId = new StringBuffer();
			for(Map<String, String> maps : mapsList){
				if(scheduleFlag){	//预置监测类型
					if("0".equals(maps.get("NODE_TYPE"))){	//是服务器节点
						if(serverFlag){		//适用于服务器监测，进行超时校验
							alarmSeqId.append(maps.get(fields.get(0))+",");
							alarmInfoList.add(createAlarmInfo(setInfo, maps.get(fields.get(0)),maps.get(fields.get(2)),startTime,String.format(Constants.DETECT_TIMEOUT_ALARMINFO, periodTimes),emergent));
						}else{	//不适用于服务器监测，除全局监测外，进行不适用告警
							if(!mainFlag){
//								map.put(maps.get(fields.get(0)), maps.get(fields.get(2))+",");
								alarmSeqId.append(maps.get(fields.get(0))+",");
//								alarmInfoList.add(createAlarmInfo(setInfo, maps.get(fields.get(0)),maps.get(fields.get(2)),startTime,"该节点为服务器节点，不适用于该检测类别",emergent));
								alarmInfoList.add(createAlarmInfo(setInfo, maps.get(fields.get(0)),maps.get(fields.get(2)),startTime,"i18n_ThreadService.detectDatasTimeoutCheck.count_n81i",emergent));
							}
						}
					}else{		//非服务器节点
						if(otherFlag){		//适用于服务器监测，进行超时校验
							alarmSeqId.append(maps.get(fields.get(0))+",");
							alarmInfoList.add(createAlarmInfo(setInfo, maps.get(fields.get(0)),maps.get(fields.get(2)),startTime,String.format(Constants.DETECT_TIMEOUT_ALARMINFO, periodTimes),emergent));
						}else{
							if(!mainFlag){
								alarmSeqId.append(maps.get(fields.get(0))+",");
//								alarmInfoList.add(createAlarmInfo(setInfo, maps.get(fields.get(0)),maps.get(fields.get(2)),startTime,"该节点为非服务器节点，不适用于该检测类别",emergent));
								alarmInfoList.add(createAlarmInfo(setInfo, maps.get(fields.get(0)),maps.get(fields.get(2)),startTime,"i18n_ThreadService.detectDatasTimeoutCheck.count_n81i",emergent));
							}
						}
					}
				}else{
					alarmSeqId.append(maps.get(fields.get(0))+",");
					alarmInfoList.add(createAlarmInfo(setInfo, maps.get(fields.get(0)),maps.get(fields.get(2)),startTime,String.format(Constants.DETECT_TIMEOUT_ALARMINFO, periodTimes),emergent));
				}
				if(alarmInfoList.size()>0){
					for(String[] strSrr:alarmInfoList) {
//						logger.info("超时告警数据 "+Arrays.toString(alarmInfoList.get(alarmInfoList.size()-1)));
//						System.out.println("超时告警数据 "+Arrays.toString(alarmInfoList.get(alarmInfoList.size()-1)));
//						logger.info(setInfo.getCheckTypeName()+"超时告警数据: "+Arrays.toString(strSrr));//i18nlog
						
					}
				}
			}
//			System.out.println("seqId "+alarmSeqId);
			//整理Email告警
			if(alarmSeqId.length()>0){
				alarmSeqId.deleteCharAt(alarmSeqId.length()-1);
//				System.out.println("seqId "+alarmSeqId);
				//整理状态变化的告警字段
				//（该监测设置 在上周期之前状态变化的字段）
				//
				String checkSql = "select nt0.seq_id,nt0.node_ip,nt0.NODE_TYPE from " +
				"(select distinct nt.seq_id,nt.node_ip,nt.NODE_TYPE from node_table nt where nt.seq_id in ("+alarmSeqId+")) nt0 " +
				"where nt0.seq_id not in  ( select din.seq_id from detection_info_new din where din.detection_set_info_id = '"+setInfo.getId()+"') " +
				"or nt0.seq_id in ( select din.seq_id from detection_info_new din " +
				"where din.detection_set_info_id = '"+setInfo.getId()+"' and din.detectioned_state <> -1 or (din.detectioned_state = -1 and din.police_level <>1))";
//				System.out.println(checkSql);
				ArrayList<Map<String, String>> mapsList0 = dao.dbSelect(checkSql, fields);
				StringBuffer alarmIP = new StringBuffer();
				if(mapsList0!=null && mapsList0.size()>0){
					for(Map<String, String> map0 : mapsList0){
						alarmIP.append(map0.get(fields.get(2))+",");
					}
					alarmIP.deleteCharAt(alarmIP.length()-1);
					System.out.println("---"+alarmIP);
					EmailService emailService = new EmailService(dao);
					EmailInfo emailInfo = new EmailInfo(EmailTypeConstants.TYPE_DETECTION_INFO_TIMEOUT,setInfo.getProcessIdenName()+"("+setInfo.getCheckTypeName1()+")",null,format.format(System.currentTimeMillis()),alarmIP+"\n i18n_ThreadService.detectDatasTimeoutCheck.timeout_n81i",EmailTypeConstants.FLAG_SEND_LATER,Integer.parseInt(emergent));
					emailService.sendEmailForDetection(setInfo.getId(),emailInfo);
//					emailService.saveEmailInfo(emailInfo);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				inStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return alarmInfoList;
	}
	
//	public String [] createDetectInfo(SetInfo setInfo , String seqId,Date startTime,String alarmInfo){
////		StringBuffer detecData = new StringBuffer();
////		detecData.append(seqId+",");
////		detecData.append(setInfo.getCheckTypeId()+",");
////		detecData.append(setInfo.getCheckTypeName()+",");
////		detecData.append(setInfo.getProcessIden()+",");
////		detecData.append(new Date().getTime()+",");
////		detecData.append(0+",");
////		detecData.append(new Date().getTime()+",");
////		detecData.append(1+",");
//		Date nextTime = new Date();
////		detecData.append(nextTime.getTime()+",");
////		detecData.append(0+",");
////		detecData.append(",");
////		detecData.append(",");
////		detecData.append(",");
////		detecData.append("超过两个监测周期（"+((setInfo.getCheckGap()==null?5:setInfo.getCheckGap())*Constants.DETEC_TIMEOUT_OUT_TIMES+5)+"分钟），未接收到监测结果信息");
////		detecData.append("超过两个监测周期（"+((setInfo.getCheckGap()==null?5:setInfo.getCheckGap())*Constants.DETEC_TIMEOUT_OUT_TIMES+5)+"分钟），未接收到监测结果信息");
//		String [] detecData = new String[15];
//		detecData[0] = seqId;
//		detecData[1] = setInfo.getId()+"";
//		detecData[2] = setInfo.getCheckTypeName()+"";
//		detecData[3] = setInfo.getProcessIden()+"";
//		detecData[4] = startTime.getTime()+"";
//		detecData[5] = 1+"";
//		detecData[6] = nextTime.getTime()+"";
//		detecData[7] = 1+"";
//		nextTime.setSeconds(nextTime.getSeconds()+(int)(setInfo.getCheckGap()==null?5:setInfo.getCheckGap())*60);
//		detecData[8] = nextTime.getTime()+"";
//		detecData[9] = -1+"";
//		detecData[10] = "";
//		detecData[11] = "";
//		detecData[12] = "";
//		detecData[13] = alarmInfo;
//		detecData[14] = alarmInfo;
//		//System.out.println(""+Arrays.toString(detecData));
////		byte [] bs = CSVUtils.csvBytesPrinter(detecData, Constants.COMMON_TEXT_CODING);
//		
//		return detecData;
//	}
	
//	public static String[] createAlarmInfo(long setInfoId,long seqId,String checkIp,String checkType,String processName,long checkTime,long level,long state,String exInfo) {
	public static String[] createAlarmInfo(SetInfo setInfo , String seqId,String checkIp,Date startTime,String alarmInfo,String emergent) {
		String[] datas = new String[11];
		datas[0] = setInfo.getId()+"";
		datas[1] = seqId+"";
		datas[2] = setInfo.getCheckTypeName();
		datas[3] = setInfo.getProcessIden();
		datas[4] = startTime.getTime()+"";
		datas[5] = System.currentTimeMillis()+"";
		datas[6] = Constants.DETEC_TIMEOUT_POLICE_LEVEL;
		datas[7] = "-1";
		datas[8] = alarmInfo;
		datas[9] = checkIp;
		datas[10] = emergent;
		return datas;
	}
	
	/**
	 * 批量 入库监测告警数据
	 * @param alarmList
	 * @return
	 * @throws Exception
	 */
	public boolean resoveAlarmsBatch(List<String[]> alarmList) throws Exception{
		boolean flag = false;
		if(alarmList == null || alarmList.size() <1 ){
			return true;
		}
		Connection conn = dao.getConn();
		PreparedStatement diStmt = null;
		PreparedStatement diwStmt = null;
		PreparedStatement insertNewStmt = null;
		PreparedStatement updateNewStmt = null;
		try {
			conn.setAutoCommit(false);
			String diSql = "insert into detection_info (id,seq_Id,detection_set_info_id,start_time,data_check_time,police_level,detectioned_state,detection_state_info,performace_data,data_arrive_time,status_change_time,data_check_time_digital,data_arrive_time_digital,police_emergent) value (?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
			String diwSql = "insert into detection_info_warning (detection_info_id,seq_Id,detection_set_info_id,start_time,data_check_time,police_level,detectioned_state,detection_state_info,performace_data,data_arrive_time,status_change_time,data_check_time_digital,data_arrive_time_digital,police_emergent) value (?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
			String insertSql=getSaveToNewSql();
			String updateSql=getUpdateToNewSql();
			
			diStmt = conn.prepareStatement(diSql);
			diwStmt = conn.prepareStatement(diwSql);
			insertNewStmt=conn.prepareStatement(insertSql);
			updateNewStmt=conn.prepareStatement(updateSql);
			
			Calendar arriveTime = Calendar.getInstance();
			String arriveTimeStr = format.format(arriveTime.getTime());
			
			Map<String,List<String[]>> split=checkIsExists(alarmList);//查询new表，对alarmList分类，insert还是update
			pushToNewStmt(insertNewStmt,updateNewStmt,split,alarmList,arriveTime,arriveTimeStr);
			
			for(String[] alarms : alarmList){
				
				//seq_Id
				diwStmt.setObject(2, alarms[1]);
				diStmt.setObject(2, alarms[1]);
				//detection_set_info_id
				diwStmt.setObject(3, alarms[0]);
				diStmt.setObject(3,alarms[0]);
				// 监测服务启动时间，
				String startTime =format.format(new Date(Long.parseLong(alarms[4])));
				diwStmt.setObject(4, startTime);
				diStmt.setObject(4, startTime);
				// 本次检测时间，
				String checkTime =format.format(new Date(Long.parseLong(alarms[5])));
				diwStmt.setObject(5, checkTime);
				diStmt.setObject(5, checkTime);
				// 告警级别
				String pLevel = alarms[6];
				String state = alarms[7];
				if(StringUtils.isEmpty(pLevel)){
					if("-2".equals(state)){
						pLevel = "1";
					}else if("2".equals(state)){
						pLevel = "99";
					}
				}
				diwStmt.setObject(6, pLevel);
				diStmt.setObject(6, pLevel);
				// 执行状态是否成功，记录的状态是否正常（用于报警 -2主动告警 -1执行失败 0不正常，1正常），
				diwStmt.setObject(7, state);
				diStmt.setObject(7, state);
				// 状态信息（描述信息），
				diwStmt.setObject(8, alarms[8]);
				diStmt.setObject(8, alarms[8]);
				//性能数据，
				diwStmt.setObject(9, alarms[8]);
				diStmt.setObject(9, alarms[8]);
				//DATA_ARRIVE_TIME
				diwStmt.setObject(10, arriveTimeStr);
				diStmt.setObject(10, arriveTimeStr);
				//STATUS_CHANGE_TIME
				diwStmt.setObject(11, checkTime);
				diStmt.setObject(11, checkTime);
				//data_check_time_digital
				diwStmt.setObject(12, alarms[5]);
				diStmt.setObject(12, alarms[5]);
				//data_arrive_time_digital
				diwStmt.setObject(13, arriveTime.getTimeInMillis()+"");
				diStmt.setObject(13, arriveTime.getTimeInMillis()+"");
				//POLICE_EMERGENT
				diwStmt.setObject(14, alarms[10]);
				diStmt.setObject(14, alarms[10]);
				String idstr=computeId(alarms[5], alarms[1], alarms[0]);
				Long id =Long.parseLong(idstr);
//				System.out.println("id -> " + id);
				diwStmt.setObject(1, id);
				diStmt.setObject(1, id);
				
				diStmt.addBatch();
				diwStmt.addBatch();
			}
			diStmt.executeBatch();
			diwStmt.executeBatch();
			insertNewStmt.executeBatch();
			updateNewStmt.executeBatch();
			conn.commit();
			flag = true;
		} catch (Exception e) {
			logger.error("",e);
			conn.rollback();
		}finally{
			if(diStmt != null){
				diStmt.close();
			}
			if(diwStmt != null){
				diwStmt.close();
			}
			if(insertNewStmt!=null){
				insertNewStmt.close();
			}
			if(updateNewStmt!=null){
				insertNewStmt.close();
			}
		}
		return flag;
	}
	
	
	private void pushToNewStmt(PreparedStatement insertNewStmt, PreparedStatement updateNewStmt,
			Map<String, List<String[]>> split, List<String[]> alarmList, Calendar arriveTime, String arriveTimeStr) {
		try{
		List<String[]> insert = split.get("insert");
		List<String[]> update = split.get("update");
		if(null!=insert&&insert.size()>0) {
			for (int i=insert.size()-1;i>=0;i--) {
				String[] alarm=	insert.get(i);
				//seq_Id
				String seqId= alarm[1];
				insertNewStmt.setObject(11, seqId);
				//detection_set_info_id
				String setInfoId=alarm[0];
				insertNewStmt.setObject(1, setInfoId);
				// 监测服务启动时间，
				String startTime =format.format(new Date(Long.parseLong(alarm[4])));
				insertNewStmt.setObject(5, startTime);
				// 本次检测时间，
				String checkTime =format.format(new Date(Long.parseLong(alarm[5])));
				insertNewStmt.setObject(7, checkTime);
				// 告警级别
				String pLevel = alarm[6];
				String state = alarm[7];
				if(StringUtils.isEmpty(pLevel)){
					if("-2".equals(state)){
						pLevel = "1";
					}else if("2".equals(state)){
						pLevel = "99";
					}
				}
				insertNewStmt.setObject(6, pLevel);
				// 执行状态是否成功，记录的状态是否正常（用于报警 -2主动告警 -1执行失败 0不正常，1正常），
				insertNewStmt.setObject(9, state);
				// 状态信息（描述信息），
				String stateInfo=alarm[8];
				insertNewStmt.setObject(2, stateInfo);
				//性能数据，
				String performaceData=alarm[8];
				insertNewStmt.setObject(3, performaceData);
				//DATA_ARRIVE_TIME
				insertNewStmt.setObject(8, arriveTimeStr);
				//STATUS_CHANGE_TIME
				insertNewStmt.setObject(10, checkTime);
				//data_check_time_digital
				String checkTimeDigtal=alarm[5];
				insertNewStmt.setObject(13, checkTimeDigtal);
				//data_arrive_time_digital
				String arriveTimeDigital=arriveTime.getTimeInMillis()+"";
				insertNewStmt.setObject(14, arriveTimeDigital);
				//POLICE_EMERGENT
				String policeEmergent=alarm[10];
				insertNewStmt.setObject(15, policeEmergent);
				//detection_info_id
				String detectionId=computeId(alarm[5],seqId,setInfoId);
				insertNewStmt.setObject(12, detectionId);
				//currentTimes
				insertNewStmt.setObject(4, null);
				
				insertNewStmt.addBatch();
				insert.remove(i);
			}
		}
		if(null!=update&&update.size()>0) {
			for (int i=update.size()-1;i>=0;i--) {
				String[] alarm=	update.get(i);
				String seqId= alarm[1];
				updateNewStmt.setObject(14, seqId);
				//detection_set_info_id
				String setInfoId=alarm[0];
				updateNewStmt.setObject(13, setInfoId);
				// 监测服务启动时间，
				String startTime =format.format(new Date(Long.parseLong(alarm[4])));
				updateNewStmt.setObject(3, startTime);
				// 本次检测时间，
				String checkTime =format.format(new Date(Long.parseLong(alarm[5])));
				updateNewStmt.setObject(5, checkTime);
				// 告警级别
				String pLevel = alarm[6];
				String state = alarm[7];
				if(StringUtils.isEmpty(pLevel)){
					if("-2".equals(state)){
						pLevel = "1";
					}else if("2".equals(state)){
						pLevel = "99";
					}
				}
				updateNewStmt.setObject(4, pLevel);
				// 执行状态是否成功，记录的状态是否正常（用于报警 -2主动告警 -1执行失败 0不正常，1正常），
				updateNewStmt.setObject(7, state);
				// 状态信息（描述信息），
				String stateInfo=alarm[8];
				updateNewStmt.setObject(1, stateInfo);
				//性能数据，
				String performaceData=alarm[8];
				updateNewStmt.setObject(2, performaceData);
				//DATA_ARRIVE_TIME
				updateNewStmt.setObject(6, arriveTimeStr);
				//STATUS_CHANGE_TIME
				updateNewStmt.setObject(8, alarm[alarm.length-1]);
				//data_check_time_digital
				String checkTimeDigtal=alarm[5];
				updateNewStmt.setObject(10, checkTimeDigtal);
				//data_arrive_time_digital
				String arriveTimeDigital=arriveTime.getTimeInMillis()+"";
				updateNewStmt.setObject(11, arriveTimeDigital);
				//POLICE_EMERGENT
				String policeEmergent=alarm[10];
				updateNewStmt.setObject(12, policeEmergent);
				//detection_info_id
				String detectionId=computeId(alarm[5],seqId,setInfoId);
				updateNewStmt.setObject(9, detectionId);
				
				updateNewStmt.addBatch();
				update.remove(i);
			}
		}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	/**
	 * 计算 detection_info 及详细表的关联主键
	 * @param checkTime 监测时间
	 * @param seqId 节点id
	 * @param setId 监测设置id
	 * @return  10位时间戳 + 5位 seqId + 3位 setId
	 */
	public  String computeId(String checkTime,String seqId,String setId){
		if(!StringUtil.isBlank(checkTime)&&!StringUtil.isBlank(seqId)&&!StringUtil.isBlank(setId)){
			StringBuilder sb = new StringBuilder();
			checkTime = checkTime.substring(checkTime.length() -10);//截取时间戳 后10位
			sb.append("00000");
			sb.append(seqId);
			seqId = sb.substring(sb.length()-5);// seqId 占 5位
			sb.delete(0, sb.length());//清空sb
			sb.append("000");
			sb.append(setId);
			setId = sb.substring(sb.length() - 3); // set info id 占 3位
			sb.setLength(0);
			sb.append(checkTime);
			sb.append(seqId);
			sb.append(setId);
			return sb.toString();
		}
		return null;
	}
	private Map<String, List<String[]>> checkIsExists(List<String[]> alarmList) {
		Map<String,List<String[]>> split=new HashMap<String,List<String[]>>();
		List<String[]> insert=new ArrayList<String[]>();
		List<String[]> update=new ArrayList<String[]>();
		String sql="select count(*), DETECTIONED_STATE,STATUS_CHANGE_TIME from detection_info_new  where SEQ_ID=? and DETECTION_SET_INFO_ID=?";
		try {
			Connection conn = dao.getConn();
			PreparedStatement stmt = conn.prepareStatement(sql);
			for (String[] alarm : alarmList) {
				String seqId=alarm[1];
				String setInfoId=alarm[0];
				String state=alarm[7];
				stmt.setObject(1, seqId);
				stmt.setObject(2, setInfoId);
				if(!StringUtil.isBlank(seqId)&&!StringUtil.isBlank(setInfoId)){
					ResultSet rs = stmt.executeQuery();
					while(rs.next()){
						int count = rs.getInt(1);
						String  oldState=rs.getString(2);
						String statusChangeTime=rs.getString(3);
						if(count==0){
							insert.add(alarm);
						}else{
							alarm=Arrays.copyOf(alarm, alarm.length+1);
							if(oldState.equals("1")){
								alarm[alarm.length-1]=format.format(new Date(Long.parseLong(alarm[5])));;
								update.add(alarm);
							}else{
								alarm[alarm.length-1]=statusChangeTime;
								update.add(alarm);
							}
						}
					}
				}
			}
			split.put("insert", insert);
			split.put("update", update);
			stmt.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return split;
	}

	public boolean resoveAlarms(String[] alarms) throws Exception{
		boolean flag = false;
		// alarms长度为9 ip type 进程标识，告警信息
		if (alarms == null || alarms.length < 9) {
			return false;
		}
		
		// 整理
		try {
			String setInfoId = alarms[0];
			Map<String, String> publicInfo = new HashMap<String, String>();

			// seqId，
			String seqId = alarms[1];
			publicInfo.put("seq_Id", seqId);
//			publicInfo.put("node_ip", Common.getSeqIdMape().get(Long.parseLong(seqId)));
			// 监测设置ID，
			publicInfo.put("detection_set_info_id", setInfoId);
//			publicInfo.put("check_way", "1");
			// 监测类别，
			String checkType = alarms[2];
			// 进程名称（检查类别设置名称），
			String process = alarms[3];
			// 监测服务启动时间，
			String startTime =format.format(new Date(Long.parseLong(alarms[4])));
			publicInfo.put("start_time", startTime);
			// 本次检测时间，
			String checkTime =format.format(new Date(Long.parseLong(alarms[5])));
			publicInfo.put("DATA_CHECK_TIME".toLowerCase(), checkTime); // 测试时间
			
			// 告警级别
			String pLevel = alarms[6];
			String state = alarms[7];
			if(StringUtils.isEmpty(pLevel)){
				if("-2".equals(state)){
					pLevel = "1";
				}else if("2".equals(state)){
					pLevel = "99";
				}
			}
			publicInfo.put("police_level", pLevel);
			// 执行状态是否成功，记录的状态是否正常（用于报警 -2主动告警 -1执行失败 0不正常，1正常），
			publicInfo.put("detectioned_state", state);
			// 状态信息（描述信息），
			publicInfo.put("detection_state_info", alarms[8]);
			//性能数据，
			publicInfo.put("performace_data",alarms[8]);
			// -- 根据执行状态判断是否需要获取详细数据的信息 及报警信息
			// ip
//			String clientIp = alarms[9];
			// 将数据保存到历史数据表，并查询出Id
			Calendar arriveTime = Calendar.getInstance();
			publicInfo.put("DATA_ARRIVE_TIME".toLowerCase(), format.format(arriveTime.getTime()));// 获取到数据时间（入库时间）
			publicInfo.put("STATUS_CHANGE_TIME".toLowerCase(), checkTime);// 获取到数据时间（入库时间）
			publicInfo.put("data_check_time_digital".toLowerCase(), alarms[5]);// 获取到数据时间长整形
			publicInfo.put("data_arrive_time_digital".toLowerCase(), arriveTime.getTimeInMillis()+"");// 获取到数据时间长整形
			publicInfo.put("POLICE_EMERGENT".toLowerCase(), alarms[10]);// 获取到数据时间长整形
			
			/* 第五步：状态变更时发送邮件 */
			/*// -- 告警信息整理
			StringBuffer pInfo = new StringBuffer();
			pInfo.append("告警级别 "  + alarms[6] + " 监测内容 "  + alarms[8] + "\n");
//			publicInfo.put("notice_info".toLowerCase(), pInfo.toString().toCharArray().length>499?StringUtil.getChineseByLength(pInfo.toString(), 0, 499):pInfo.toString());
			//- 组织邮件信息
			int actionType = 21;
			if("99".equals(pLevel)){
				actionType = 20;
			}
			
			ArrayList<String> fields = new ArrayList<String>();
			//查询detection_info_new 表，判断状态变更，进行报警通知
			String searchSql = "select count(1) counts from detection_info_new din where din.seq_id = ?  and din.detection_set_info_id = ? "
				+ "and (din.detectioned_state <>? or (din.detectioned_state = ? and din.police_level<>?)) ";
			fields.add("counts");
			List<Map<String, String>> dta = dao.dbSelect(searchSql, fields, seqId, setInfoId,publicInfo.get("detectioned_state"),publicInfo.get("detectioned_state"),publicInfo.get("police_level"));
			
			//-- 拼写邮件头
			boolean sendEmailFlag = false;			
			if (dta == null || dta.size()==0) {
				sendEmailFlag = true;
			}else{
				if (dta.get(0) != null) {
					String counts = dta.get(0).get("counts");
					if((StringUtils.isNotEmpty(counts) && !"null".equalsIgnoreCase(counts) && !counts.equals("0"))){	//状态变化发送
						sendEmailFlag = true;
					}
				}
			}
			
			if(sendEmailFlag){
				long seqIdLong = Long.parseLong(seqId);
				long setInfoIdLong = Long.parseLong(setInfoId);
				EmailInfo emailInfo = new EmailInfo(actionType,process+"("+checkType+")",clientIp, format.format(Long.parseLong(checkTime)),pInfo.toString(),0);
				new EmailService(dao).sendEmailForDetectionBySeqId(setInfoIdLong,seqIdLong,emailInfo);
			}*/
			
			// 新增保存报警表信息
//			publicInfo.put("notice_flag".toLowerCase(), "1");// 1已发送 0未发送
			
			//-- 获取ID
			//2018年12月1日20:45:42 id 改為 主鍵自增
			ArrayList<String> fields = new ArrayList<String>();
			String searchIdSql = "select seq_detection_info.nextval id from dual";
			fields.add("id");
			List<Map<String, String>> sid = dao.dbSelect(searchIdSql, fields);
			String id = null;
			if(sid!=null && sid.size()>0){
				id = sid.get(0).get("id");
			}
			dao.setAutoCommit(false);
			publicInfo.put("id", id);
			dao.insertObj("detection_info", publicInfo);
			publicInfo.remove("id");
			publicInfo.put("detection_info_id", id);
			// 保存到报警表
			flag = dao.insertObj("detection_info_warning".toLowerCase(),publicInfo);
			dao.commit();
			logger.debug("************************************************最新的监测时间("+alarms[9]+":"+alarms[0]+")："+checkTime);
		} catch (Exception e) {
			logger.error("resoveAlarms Parsing anomaly of alarm information："+"",e);
			dao.rollback();
			return false;
		} finally {
			dao.clearConn();
		}
		return flag;
	}
	
	public static String getSaveToNewSql(){
		String sql=" insert into detection_info_new(detection_set_info_id  ,detection_state_info  ,"
				+ "performace_data  ,current_times  ,start_time  ,"
				+ "police_level   ,data_check_time  ,data_arrive_time  ,detectioned_state  ,"
				+ "status_change_time  ,seq_id  ,detection_info_id,data_check_time_digital,data_arrive_time_digital      ,"
				+ "POLICE_EMERGENT,NEXT_CHECK_TIME  ) VALUES"
				+"(?,?,"
				+ "?,?,?,"
				+ "?,?,?,?,"
				+ "?,?,?,?,?,?,null)";
		return sql;
	}
	
	public static String getUpdateToNewSql(){
		String sql=" update detection_info_new din set "
				
				+"din.detection_state_info = ?"

				+", din.performace_data = ?"

            +", din.start_time =?"

           +" , din.police_level = ?"

           +" , din.data_check_time = ?"

           +" , din.data_arrive_time = ?"

            +", din.detectioned_state = ?"

          +"  , din.status_change_time = ?"

           +" , detection_info_id = ?"

          +"  ,data_check_time_digital = ?"

           +" ,data_arrive_time_digital = ?"

           +" ,POLICE_EMERGENT = ?"
           +" ,NEXT_CHECK_TIME = NULL"

          +"  where din.detection_set_info_id = ?"

           +" and din.seq_id = ?";
		return sql;
	}
	
	/**
	 * 详细数据解析
	 * 第一步：解析公共数据部分，保存各字段值到Map<String, String> publicInfo 中
	 * 第二步：解析详细数据部分，保存各字段到 Map<String, String> detail 中
	 * 第三步：检查告警信息数据，多字段告警去最高级（Level最小）
	 * 第四步：查询数据库中最新同类监测记录，并判断状态是否变化（同类判定：seq_id、detection_set_info_id，变化判定：DETECTIONED_STATE 和 POLICE_LEVEL 至少一个变化）
	 * 第五步：根据告警信息数据，拼写告警信息 
	 * 第六步：状态变更时发送邮件，将告警信息邮件发送
	 * 第七步：保存到基本信息、非正常数据和状态变更数据信息保存到告警表中
	 * 完成...
	 * @time Sep 8, 2011-3:40:45 PM
	 * @param datas
	 * @param dao
	 */
	/*public boolean resoveData(String[] datas) throws Exception{
		boolean flag = false;
		try {
			 第一步：解析公共数据部分 
			StringBuffer errorInfo= new StringBuffer();		//数据文件错误，信息整理
			if(datas==null){
				errorInfo.append("数据内容为空，不予解析;");
				return flag;
			}
			if(datas.length<15){
				errorInfo.append("数据解析长度："+datas.length+" 小于最小解析标准，不予解析；");
				return flag;
			}
			
			Map<String, String> publicInfo = new HashMap<String, String>();		//公共信息集合
			int index = 0;		//数据集合解析游标
			//seqId，
			String seqId = datas[index++];
			if(StringUtils.isEmpty(seqId)){
				errorInfo.append("第"+(index)+"数据 节点seqId(物理主机标识)不能为空；");
			};
			publicInfo.put("seq_Id", seqId);
//			publicInfo.put("node_ip", seqId);
//			publicInfo.put("node_ip", Common.getSeqIdMape().get(Long.parseLong(seqId)));
			//监测设置ID，
			String setInfoId = datas[index++];
			if(StringUtils.isEmpty(setInfoId)){
				errorInfo.append("第"+(index)+"数据 监测设置ID不能为空；");
			}
			publicInfo.put("detection_set_info_id", setInfoId);
			//监测类别
			String checkType = datas[index++];
			if(StringUtils.isEmpty(checkType)){
				errorInfo.append("第"+(index)+"数据 监测类别不能为空；");
			}
			//进程名称（检查类别设置名称），
			String process = datas[index++];
			//监测服务启动时间，
			String startTime = datas[index++];
			if(StringUtils.isNotEmpty(startTime)){
				try {
					long st = Long.parseLong(startTime);
					publicInfo.put("start_time".toLowerCase(),format.format(new Date(st)));	//测试时间
				} catch (Exception e) {
					errorInfo.append("第"+(index)+"数据 “"+startTime+"” 监测服务启动时间须为整形数；");
				}
			}else {
				errorInfo.append("第"+(index)+"数据 监测服务启动时间不能为空；");
			}
			//检测时延（秒），
			String delayTime = datas[index++];
			if(StringUtils.isNotEmpty(delayTime)){
				try {
					Integer.parseInt(delayTime);
					publicInfo.put("delay_time", delayTime);
				} catch (Exception e) {
					errorInfo.append("第"+(index)+"数据 “"+delayTime+"” 检测时延（秒）须为整形数；");
				}
			}
			//本次检测时间，
			String checkTime = datas[index++];
			if(StringUtils.isNotEmpty(checkTime)){
				try {
					long ct = Long.parseLong(checkTime);
					publicInfo.put("data_check_time_digital", checkTime);
					publicInfo.put("DATA_CHECK_TIME".toLowerCase(),format.format(new Date(ct)));	//测试时间
				} catch (Exception e) {
					errorInfo.append("第"+(index)+"数据 “"+checkTime+"” 本次检测时间须为整形数；");
				}
			}else {
				errorInfo.append("第"+(index)+"数据 本次检测时间不能为空；");
			}
			//尝试次数，
			String currentTimes = datas[index++];
			if(StringUtils.isNotEmpty(currentTimes)){
				try {
					Integer.parseInt(currentTimes);
					publicInfo.put("current_times", currentTimes);
				} catch (Exception e) {
					errorInfo.append("第"+(index)+"数据 “"+currentTimes+"” 尝试次数须为整形数；");
				}
			}else{
				errorInfo.append("第"+(index)+"数据 尝试次数不能为空；");
			}
			//下次计划监测时间，
			String nextCheckTime = datas[index++];
			if(StringUtils.isNotEmpty(nextCheckTime)){
				try {
					long nct = Long.parseLong(nextCheckTime);
					publicInfo.put("next_check_time", format.format(new Date(nct)));
				} catch (Exception e) {
					errorInfo.append("第"+(index)+"数据 “"+nextCheckTime+"” 下次计划监测时间须为整形数；");
				}
			}else{
				errorInfo.append("第"+(index)+"数据 尝试次数不能为空；");
			}
			//执行状态是否成功，记录的状态是否正常（用于报警 -1执行失败 0不正常，1正常），
			String stateStr = datas[index++];
			int state = -1;
			if(StringUtils.isNotEmpty(stateStr)){
				try {
					state = Integer.parseInt(stateStr);
					publicInfo.put("detectioned_state", stateStr);
				} catch (Exception e) {
					errorInfo.append("第"+(index)+"数据 “"+stateStr+"” 执行状态须为整形数；");
				}
			}else{
				errorInfo.append("第"+(index)+"数据 执行状态不能为空；");
			}
			//告警序列
			String showNums =  datas[index++];
			//告警级别
			String pLevel =  datas[index++];
			//告警值
			String pValue =  datas[index++];
			// 状态信息（描述信息），
			String dsinfo = datas[index++];
			if(StringUtils.isNotEmpty(dsinfo)){
				if(dsinfo.length()>256){
					dsinfo = dsinfo.substring(0,255);
				}
			}
			publicInfo.put("detection_state_info",dsinfo);
			//性能数据，
			String pdata = datas[index++];
			if(StringUtils.isNotEmpty(pdata)){
				if(pdata.length()>256){
					pdata = pdata.substring(0,255);
				}
			}
			publicInfo.put("performace_data", pdata);
			
			
			 第二步：解析详细数据部分 
			
			//-- 根据执行状态判断是否需要获取详细数据的信息 及报警信息
			boolean delyFlag = true;
			if(state == -1){	//失败	报警only
				delyFlag = false;
			}
			
			//--  详细信息整理 监测具体数据信息（每个字段一列）。
			Map<String, String> detail = new HashMap<String, String>();
			
		
			 第三步：检查告警信息数据 
			//--  告警级别
			String [] nums0 = pLevel.split("\\|");
			int pl = 99;
			for(String num : nums0){
				if(StringUtils.isEmpty(num)){
					continue;
				}
				int level = Integer.parseInt(num);
				if(pl>level){
					pl = level;
				}
			}
			
			//失败	最高级
			if(state == -1){
				pl = 1;
			}
			publicInfo.put("police_level",pl+"");
			Calendar arriveTime = Calendar.getInstance();
			publicInfo.put("data_arrive_time_digital", arriveTime.getTimeInMillis()+"");
			publicInfo.put("DATA_ARRIVE_TIME".toLowerCase(),format.format(arriveTime.getTime()));	//测试时间
//			publicInfo.put("STATUS_CHANGE_TIME".toLowerCase(), publicInfo.get("data_check_time"));//获取到数据时间（入库时间）
		
		boolean stateChangefalg = false;
		
		
		 第四步：查询数据库中最新同类监测记录 
		//--数据入库处理
		ArrayList<String> fields = new ArrayList<String>();
		
		
		//查询detection_info_new 表，判断状态变更，进行报警通知
		String searchSql = "select count(1) counts from detection_info_new din where din.seq_id = ?  and din.detection_set_info_id = ? "
			+ "and (din.detectioned_state <>? or (din.detectioned_state = ? and din.police_level<>?)) ";
		fields.add("counts");
		System.out.println(seqId+" "+setInfoId+" "+publicInfo.get("detectioned_state")+" "+publicInfo.get("detectioned_state")+" "+publicInfo.get("police_level"));
		List<Map<String, String>> dta = dao.dbSelect(searchSql, fields, seqId, setInfoId,publicInfo.get("detectioned_state"),publicInfo.get("detectioned_state"),publicInfo.get("police_level"));
		
		 第五步：状态变更时发送邮件 
		//-- 拼写邮件头
//		String pInfo = "监测时间 " + publicInfo.get("data_check_time") + "\n";
//		pInfo += "监测节点 " + Common.getNodeIpByUUID(Long.parseLong(seqId)) + "\n";
//		pInfo += "监测类别 " + checkType + "\n";
//		pInfo += "监测设置 " + process + "\n";
		String cpInfo ="";
		if (dta != null && dta.size()>0) {
			if (dta.get(0) != null) {
				String counts = dta.get(0).get("counts");
				System.out.println("counts "+counts);
				System.out.println((StringUtils.isNotEmpty(counts) && !"null".equalsIgnoreCase(counts) && !counts.equals("0")));
				if((StringUtils.isNotEmpty(counts) && !"null".equalsIgnoreCase(counts) && !counts.equals("0"))){
					
					//整理告警数据,拼写邮件信息
					if(state == -1){	//执行失败
//						cpInfo += "监测任务执行失败\n";
//						cpInfo += "状态信息："+dsinfo+"\n";
//						publicInfo.put("notice_info".toLowerCase(), pInfo.toCharArray().length>499?StringUtil.getChineseByLength(pInfo, 0, 499):pInfo);
//						pInfo = "----------- 监测执行失败告警 -----------\n"+pInfo+cpInfo;
					}else if(state == 0){
						
						cpInfo+=dsinfo+" \n";
						// 新增保存报警表信息
//						publicInfo.put("notice_info".toLowerCase(), pInfo.toCharArray().length>499?StringUtil.getChineseByLength(pInfo, 0, 499):pInfo);
//						pInfo = "----------- 监测信息异常告警 -----------\n"+pInfo+cpInfo;
					}else if(state == 1){
						cpInfo +="监测恢复正常";
//						publicInfo.put("notice_info".toLowerCase(), pInfo.toCharArray().length>499?StringUtil.getChineseByLength(pInfo, 0, 499):pInfo);
//						pInfo = "----------- 监测恢复正常通知 -----------\n"+pInfo+cpInfo;
					}
					
					// 报警通知
//					EmailService emailService = new EmailService(dao);
//					emailService.sendEmailForDetectionBySeqId(Long.parseLong(setInfoId), Long.parseLong(seqId), "原数据监测告警", pInfo);
					stateChangefalg = true;
					publicInfo.put("STATUS_CHANGE_TIME", publicInfo.get("DATA_CHECK_TIME"));
					System.out.println("stateChangefalg "+stateChangefalg);
				}else{
					// 数据状态无变化
				}
			}
		}else{
			cpInfo +="该监测为新增监测";
			// 报警通知
//			EmailService emailService = new EmailService(dao);
//			emailService.sendEmailForDetectionBySeqId(Long.parseLong(setInfoId), Long.parseLong(seqId), "新监测任务通知", pInfo+cpInfo);
		}
		
		 第六步：保存信息 
		dao.setAutoCommit(false);
		
		//判断入库标示
//		if(Constants.FLAG_RESOVE_COMMIT_DB != 1){
//			logger.warn("file.resove.commitDB.flag 不为1,数据不可保存，请检查配置文件");
//			return true;
//		}
		
		//-- 申请sequences for detection_info
		String searchIdSql = "select seq_detection_info.nextval id from dual";
		fields.clear();
		fields.add("id");
		List<Map<String, String>> sid = dao.dbSelect(searchIdSql, fields);
		String id = null;
		if(sid!=null && sid.size()>0){
			id = sid.get(0).get("id");
		}
		publicInfo.put("id", id);

//		boolean noticeFlag = false;
		
//		if(publicInfo.get("notice_info")!= null){
//			noticeFlag = true;
//			publicInfo.remove("notice_info");
//		}
		//-- 保存detection_info 信息
		dao.insertObj("detection_info", publicInfo);
//		logger.debug("pInfo: "+pInfo);
//		logger.debug("cpInfo: "+cpInfo);
//		if(noticeFlag){
//			publicInfo.put("notice_info".toLowerCase(), pInfo.toCharArray().length>499?StringUtil.getChineseByLength(pInfo, 0, 499):pInfo);
//		}
		
		//-- 告警信息整理
		if(state != 1 || stateChangefalg){
			publicInfo.put("notice_info".toLowerCase(), cpInfo.toCharArray().length>499?StringUtil.getChineseByLength(cpInfo, 0, 499):cpInfo);
			publicInfo.put("DETECTION_INFO_ID".toLowerCase(), id);//detection_info_id
			publicInfo.put("notice_flag".toLowerCase(), "1");//1已发送  0未发送
			// 保存到报警表
			flag = dao.insertObj("detection_info_warning".toLowerCase(), publicInfo);
		}
		dao.commit();
		logger.debug("数据解析 完成");
		return flag;
		} catch (Exception e) {
			logger.debug("数据解析 异常");
			dao.rollback();
			throw e;
		}finally{
			dao.clearConn();
		}
	}*/
}
