package com.nms.thread;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.nutz.json.Json;
import org.nutz.json.JsonFormat;

import com.nms.thread.service.NmsReportService;

import nis.nms.util.BaseAction;
import nis.nms.util.ConnectionOracle;
import nis.nms.util.HttpClientUtil;

public class NmsRuleThread implements Runnable {

	private static Logger logger = Logger.getLogger(NmsRuleThread.class);

	@Override
	public void run() {
		Thread currentThread = Thread.currentThread();
		currentThread.setName("Rule Report Thread");
		Date now = new Date();
		Long nowLong = now.getTime();
		Integer interval = null;
		try {
			interval = Integer.parseInt(BaseAction.rb.getString("nms.report.rule.interval"));
		} catch (Exception e) {
			interval = 300;
		}
		
		ConnectionOracle connection = null;
		try {
			connection = ConnectionOracle.getConnection();
			NmsReportService service = new NmsReportService(connection);
			ArrayList<Map<String, String>> nmsRuleInfo = service.getNmsRuleInfo(nowLong, nowLong-interval*1000);
			if (nmsRuleInfo != null && nmsRuleInfo.size() > 0) {
				logger.debug(String.format("查询数量：%s", nmsRuleInfo.size()));
				Map<String, List<Map<String, String>>> data = new HashMap<String, List<Map<String, String>>>();
				List<Map<String, String>> results = new ArrayList<Map<String, String>>();
				
				for (Map<String, String> info : nmsRuleInfo) {
					Map<String, String> result = new HashMap<String, String>();
					result.put("detectionInfoId", info.get("detection_info_id") == null ? "" : info.get("detection_info_id"));
					result.put("serviceIndex", info.get("ServiceIndex") == null ? "" : info.get("ServiceIndex"));
					result.put("serviceCode", info.get("ServiceCode") == null ? "" : info.get("ServiceCode"));
					result.put("serviceDesc", info.get("ServiceDesc") == null ? "" : info.get("ServiceDesc"));
					result.put("agedTime", info.get("agedTime") == null ? "" : info.get("agedTime"));
					result.put("clientNum", info.get("ClientNum") == null ? "" : info.get("ClientNum"));
					result.put("refluxPort", info.get("RefluxPort") == null ? "" : info.get("RefluxPort"));
					result.put("ruleNumber", info.get("RuleNumber") == null ? "" : info.get("RuleNumber"));
					result.put("usedRuleNum", info.get("usedRuleNum") == null ? "" : info.get("usedRuleNum"));
					result.put("leftRuleNum", info.get("leftRuleNum") == null ? "" : info.get("leftRuleNum"));
					result.put("hitTotalNum", info.get("HitTotalNum") == null ? "" : info.get("HitTotalNum"));
					result.put("detectionedState", info.get("DETECTIONED_STATE") == null ? "" : info.get("DETECTIONED_STATE"));
					result.put("seqId", info.get("SEQ_ID") == null ? "" : info.get("SEQ_ID"));
					result.put("detectionSetInfoId", info.get("DETECTION_SET_INFO_ID") == null ? "" : info.get("DETECTION_SET_INFO_ID"));
					result.put("dataCheckTime", info.get("data_check_time") == null ? "" : info.get("data_check_time"));
					result.put("dataArriveTime", info.get("data_arrive_time") == null ? "" : info.get("data_arrive_time"));
					result.put("dataCheckTimeDigital", info.get("data_check_time_digital") == null ? "" : info.get("data_check_time_digital"));
					result.put("dataArriveTimeDigital", info.get("data_arrive_time_digital") == null ? "" : info.get("data_arrive_time_digital"));
					results.add(result);
				}
				data.put("nmsDiRuleList", results);
				HttpClientUtil httpUtil = new HttpClientUtil();
				String dataStr = Json.toJson(data,JsonFormat.tidy());
				logger.debug("url:" +BaseAction.rb.getString("nms.rule.url") + ",data :" + dataStr);
				httpUtil.post(BaseAction.rb.getString("nms.rule.url"), dataStr);
				logger.info("rule上报完毕");
			} else {
				logger.info("暂无可上报的rule数据");
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
