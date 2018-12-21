package com.nms.thread;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.nutz.json.Json;
import org.nutz.json.JsonFormat;

import com.nis.util.StringUtil;
import com.nms.thread.service.NmsReportService;

import nis.nms.util.BaseAction;
import nis.nms.util.ConnectionOracle;
import nis.nms.util.DateUtil;
import nis.nms.util.HttpClientUtil;

public class NmsStatusThread implements Runnable {

	private static Logger logger = Logger.getLogger(NmsStatusThread.class);
	
	@Override
	public void run() {
		Thread currentThread = Thread.currentThread();
		currentThread.setName("Status Report Thread");
		
		String now = DateUtil.format.format(new Date());
		List<Map> results = new ArrayList<Map>();
		String setId = null;
		try {
			setId = BaseAction.rb.getString("nms.status.setId");
		} catch (Exception e) {
			setId = "7";
		}
		ConnectionOracle connection = null;
		try {
			connection = ConnectionOracle.getConnection();
			NmsReportService service = new NmsReportService(connection);
			ArrayList<Map<String, String>> nmsReportInfo = service.getNmsStatusInfo(setId);
			logger.debug(String.format("查询设备数量：%s", nmsReportInfo == null ? 0 : nmsReportInfo.size()));
			Map<String, List<Map<String, String>>> tmp = new HashMap<String, List<Map<String, String>>>();
			tmp.put("unknown", new ArrayList<Map<String, String>>());
			for (Map<String, String> info : nmsReportInfo) {
				if (!StringUtil.isBlank(info.get("system_name"))) {
					if (tmp.containsKey(info.get("system_name"))) {
						tmp.get(info.get("system_name")).add(info);
					} else {
						List<Map<String, String>> l = new ArrayList<Map<String, String>>();
						l.add(info);
						tmp.put(info.get("system_name"), l);
					}
				} else {
					tmp.get("unknown").add(info);
				}
			}
			
			for (String area : tmp.keySet()) {
				
				List<Map<String, String>> l = tmp.get(area);
				if (l.size() > 0) {
					Map result = new HashMap();
					result.put("area", area);
					result.put("commitTime", now);
					result.put("total", l.size());
					
					List<Map<String, String>> abnormalList = new ArrayList<Map<String, String>>();
					
					int normal = 0;
					for (Map<String, String> m : l) {
						if ("1".equals(m.get("detectioned_state"))) {
							normal++;
						} else {
							Map<String, String> abnormal = new HashMap<String, String>();
							abnormal.put("hostName", m.get("host_name") == null ? "" : m.get("host_name"));
							abnormal.put("ip", m.get("node_ip") == null ? "" : m.get("node_ip"));
							abnormalList.add(abnormal);
						}
					}
					
					result.put("normal", normal);
					result.put("abnormal", l.size()-normal);
					if (abnormalList.size() > 0) {
						result.put("abnormalMachineList", abnormalList);
					}
					
					results.add(result);
				}
			}
			Map<String, List<Map>> map = new HashMap<String, List<Map>>();
			map.put("trafficNmsServerList", results);
			HttpClientUtil httpUtil = new HttpClientUtil();
			String data = Json.toJson(map,JsonFormat.tidy());
			logger.debug("url:" +BaseAction.rb.getString("nms.status.url") + ",data :" + data);
			httpUtil.post(BaseAction.rb.getString("nms.status.url"), data);
			logger.info("status上报完毕");
		} catch (Exception e) {
			logger.error(e);
		} finally {
			if (connection != null) {
				connection.close();
			}
		}
		
	}
	
}
