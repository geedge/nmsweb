package com.nms.thread.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import nis.nms.util.ConnectionOracle;

import org.apache.log4j.Logger;

public class NmsReportService {
	private final Logger logger = Logger.getLogger(NmsReportService.class);
	private ConnectionOracle dao = null;
	
	public NmsReportService(ConnectionOracle dao){
		this.dao = dao;
	}
	
	public ArrayList<Map<String, String>> getNmsStatusInfo(String setId) {
		
		//detectioned_state=1时正常
		String sql = "select nt.node_ip, ds.host_name, din.detectioned_state, st.system_name "
				+ "from node_table nt "
				+ "left join detection_info_new din on din.SEQ_ID=nt.seq_id "
				+ "left join di_systeminfo ds on nt.SEQ_ID=ds.SEQ_ID " 
				+ "left join system_table st ON nt.system_id=st.system_id "
				+ "where nt.node_state=0 AND din.DETECTION_SET_INFO_ID=" + setId + " "
				+ "group by nt.node_ip";
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
		String sql = "SELECT nt.node_ip, dr.ServiceIndex, dr.ServiceCode, dr.ServiceDesc, dr.agedTime, dr.ClientNum, dr.RefluxPort, dr.RuleNumber, dr.usedRuleNum, dr.leftRuleNum, dr.HitTotalNum, dr.DETECTIONED_STATE "
				+ "FROM di_rule dr "
				+ "LEFT JOIN node_table nt ON nt.seq_id=dr.seq_id "
				+ "WHERE nt.node_state=0 AND dr.data_check_time_digital<" + end + " AND dr.data_check_time_digital>=" + start;
		ArrayList<String> fields = new ArrayList<String>();
		fields.add("node_ip");
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
		
		try {
			 ArrayList<Map<String, String>> dbSelect = dao.dbSelect(sql, fields);
			 return dbSelect;
		} catch (Exception e) {
			logger.error(e);
			return null;
		}
	}
	
	public ArrayList<Map<String, String>> getNmsPortInfo(Long end, Long start) {
		String sql = "SELECT nt.node_ip, ds.* "
				+ "FROM di_switchport ds "
				+ "LEFT JOIN node_table nt ON nt.seq_id=ds.seq_id"
				+ "WHERE nt.node_state=0 AND ds.data_check_time_digital<" + end + " AND ds.data_check_time_digital>=" + start;
		ArrayList<String> fields = new ArrayList<String>();
		fields.add("node_ip");
		
		try {
			ArrayList<Map<String, String>> dbSelect = dao.dbSelect(sql, fields);
			return dbSelect;
		} catch (Exception e) {
			logger.error(e);
			return null;
		}
	}
}
