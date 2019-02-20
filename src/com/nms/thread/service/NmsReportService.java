package com.nms.thread.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import nis.nms.util.BaseAction;
import nis.nms.util.ConnectionOracle;

import org.apache.log4j.Logger;

public class NmsReportService {
	private final Logger logger = Logger.getLogger(NmsReportService.class);
	private ConnectionOracle dao = null;
	
	public NmsReportService(ConnectionOracle dao){
		this.dao = dao;
	}
	
	public ArrayList<Map<String, String>> getNmsStatusInfo(String setId) {
		Integer systemId = null;
		try {
			systemId = Integer.parseInt(BaseAction.rb.getString("addr.system.id"));
		} catch (Exception e) {
			systemId = 100017;
		}
		//detectioned_state=1时正常
		String sql = "select nt.node_ip, ds.host_name, din.detectioned_state, st.addr as system_name "
				+ "from node_table nt "
				+ "left join detection_info_new din on din.SEQ_ID=nt.seq_id "
				+ "left join di_systeminfo ds on nt.SEQ_ID=ds.SEQ_ID " 
				+ "left join system_table st ON nt.system_id=st.system_id "
				+ "where nt.node_state=0 AND din.DETECTION_SET_INFO_ID=" + setId 
				+ " and st.system_id < " + systemId
				+ " group by nt.node_ip";
		ArrayList<String> fields = new ArrayList<String>();
		fields.add("node_ip");
		fields.add("host_name");
		fields.add("detectioned_state");
		fields.add("system_name");
		try {
			 ArrayList<Map<String, String>> dbSelect = dao.dbSelect(sql, fields);
			 return dbSelect;
		} catch (Exception e) {
			logger.error(e);
			return null;
		}
	}
	
	public ArrayList<Map<String, String>> getNmsRuleInfo(Long end, Long start) {
		//end=1539073880004l, start=1539073579984l
		String sql = "SELECT dr.detection_info_id, dr.ServiceIndex, dr.ServiceCode, dr.ServiceDesc, dr.agedTime, dr.ClientNum, dr.RefluxPort, dr.RuleNumber, dr.usedRuleNum, dr.leftRuleNum, dr.HitTotalNum, dr.DETECTIONED_STATE, dr.SEQ_ID, dr.DETECTION_SET_INFO_ID, dr.data_check_time, dr.data_arrive_time, dr.data_check_time_digital, dr.data_arrive_time_digital "
				+ "FROM di_rule dr "
				+ "LEFT JOIN node_table nt ON nt.seq_id=dr.seq_id "
				+ "WHERE nt.node_state=0 AND dr.data_check_time_digital<" + end + " AND dr.data_check_time_digital>=" + start;
		ArrayList<String> fields = new ArrayList<String>();
		fields.add("detection_info_id");
		fields.add("ServiceIndex");
		fields.add("ServiceCode");
		fields.add("ServiceDesc");
		fields.add("agedTime");
		fields.add("ClientNum");
		fields.add("RefluxPort");
		fields.add("RuleNumber");
		fields.add("usedRuleNum");
		fields.add("leftRuleNum");
		fields.add("HitTotalNum");
		fields.add("DETECTIONED_STATE");
		fields.add("SEQ_ID");
		fields.add("DETECTION_SET_INFO_ID");
		fields.add("data_check_time");
		fields.add("data_arrive_time");
		fields.add("data_check_time_digital");
		fields.add("data_arrive_time_digital");
		
		try {
			 ArrayList<Map<String, String>> dbSelect = dao.dbSelect(sql, fields);
			 return dbSelect;
		} catch (Exception e) {
			logger.error(e);
			return null;
		}
	}
	
	public ArrayList<Map<String, String>> getNmsPortInfo(Long end, Long start) {
		//end=1539073220004l,start=1539064699984l
		//只查询 网元类型为 特种设备：1的端口信息
		String sql = "SELECT DISTINCT nt.node_ip, nt.node_name, ds.ifindex, ds.IFDESCR, ds.IFSPEED, ds.IFINOCTETS, ds.IFOUTOCTETS,ds.INOCTETSSPEED,ds.INPKTSSPEED,ds.OUTOCTETSSPEED, ds.OUTPKTSSPEED, ds.DATA_CHECK_TIME,st.ADDR  "
				+ " ds.IFADMINSTATUS ,nt.seq_id"
				+ "FROM di_switchport ds "
				+ "LEFT JOIN node_table nt ON nt.seq_id=ds.seq_id "
				+ " left join system_table st on st.system_id = nt.system_id "
				+ "WHERE nt.network_element_type = 1 and nt.node_state=0 AND ds.data_check_time_digital<" + end + " AND ds.data_check_time_digital>=" + start;
		ArrayList<String> fields = new ArrayList<String>();
		fields.add("node_ip");
		fields.add("node_name");
		fields.add("ifindex");
		fields.add("IFDESCR");
		fields.add("IFSPEED");
		fields.add("IFINOCTETS");
		fields.add("IFOUTOCTETS");
		fields.add("INOCTETSSPEED");
		fields.add("INPKTSSPEED");
		fields.add("OUTOCTETSSPEED");
		fields.add("OUTPKTSSPEED");
		fields.add("DATA_CHECK_TIME");
		fields.add("ADDR");
		fields.add("IFADMINSTATUS");
		fields.add("seq_id");
		
		try {
			ArrayList<Map<String, String>> dbSelect = dao.dbSelect(sql, fields);
			return dbSelect;
		} catch (Exception e) {
			logger.error(e);
			return null;
		}
	}

	
	/**
	 * 获取 端口状态配置信息
	 * @return
	 */
	public ArrayList<Map<String, String>> getPortStatusInfo() {
		//end=1539073220004l,start=1539064699984l
		//只查询 网元类型为 特种设备：1的端口信息
		StringBuffer sql = new StringBuffer();
		sql.append(" select t.seqid, t.name_flag,(case when port_set_state is null then 1   else port_set_state end) state from node_figure_info t ");
		sql.append(" where ");
		sql.append(" t.name_flag is not null  and t.is_leaf = 1   ");
		ArrayList<String> fields = new ArrayList<String>();
		fields.add("seqid");
		fields.add("name_flag");
		fields.add("state");
		try {
			ArrayList<Map<String, String>> dbSelect = dao.dbSelect(sql.toString(), fields);
			return dbSelect;
		} catch (Exception e) {
			logger.error(e);
			return null;
		}
	}
	
}
