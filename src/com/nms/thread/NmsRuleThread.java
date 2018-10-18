package com.nms.thread;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;
import nis.nms.util.BaseAction;
import nis.nms.util.ConnectionOracle;
import nis.nms.util.DateUtil;
import nis.nms.util.HttpClientUtil;

import org.apache.log4j.Logger;

import com.nms.thread.service.NmsReportService;

public class NmsRuleThread implements Runnable {

	private Logger logger = Logger.getLogger(NmsRuleThread.class);

	@Override
	public void run() {
		Date now = new Date();
		Long nowLong = now.getTime();
		Integer interval = null;
		try {
			interval = Integer.parseInt(BaseAction.rb.getString("nms.report.interval"));
		} catch (Exception e) {
			interval = 300;
		}
		
		ConnectionOracle connection = null;
		try {
			connection = ConnectionOracle.getConnection();
			NmsReportService service = new NmsReportService(connection);
			ArrayList<Map<String, String>> nmsRuleInfo = service.getNmsRuleInfo(nowLong, nowLong-interval);
			if (nmsRuleInfo != null && nmsRuleInfo.size() > 0) {
				
				Map<String, List<Map<String, String>>> data = new HashMap<String, List<Map<String, String>>>();
				List<Map<String, String>> results = new ArrayList<Map<String, String>>();
				
				for (Map<String, String> info : nmsRuleInfo) {
					Map<String, String> result = new HashMap<String, String>();
					result.put("detectionInfoId", info.get("detection_info_id"));
					result.put("serviceIndex", info.get("ServiceIndex"));
					result.put("serviceCode", info.get("ServiceCode"));
					result.put("serviceDesc", info.get("ServiceDesc"));
					result.put("agedTime", info.get("agedTime"));
					result.put("clientNum", info.get("ClientNum"));
					result.put("refluxPort", info.get("RefluxPort"));
					result.put("ruleNumber", info.get("RuleNumber"));
					result.put("usedRuleNum", info.get("usedRuleNum"));
					result.put("leftRuleNum", info.get("leftRuleNum"));
					result.put("hitTotalNum", info.get("HitTotalNum"));
					result.put("detectionedState", info.get("DETECTIONED_STATE"));
					result.put("seqId", info.get("SEQ_ID"));
					result.put("detectionSetInfoId", info.get("DETECTION_SET_INFO_ID"));
					result.put("dataCheckTime", info.get("data_check_time"));
					result.put("dataArriveTime", info.get("data_arrive_time"));
					result.put("dataCheckTimeDigital", info.get("data_check_time_digital"));
					result.put("dataArriveTimeDigital", info.get("data_arrive_time_digital"));
					results.add(result);
				}
				data.put("nmsDiRuleList", results);
				HttpClientUtil httpUtil = new HttpClientUtil();
				JSONObject fromObject = JSONObject.fromObject(data);
				
				httpUtil.post(BaseAction.rb.getString("nms.rule.url"), fromObject.toString());
			}
		} catch (Exception e) {
			logger.error(e);
		} finally {
			if (connection != null) {
				connection.close();
			}
		}
	}
}
