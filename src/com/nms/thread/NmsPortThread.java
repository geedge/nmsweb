package com.nms.thread;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;
import nis.nms.util.BaseAction;
import nis.nms.util.ConnectionOracle;
import nis.nms.util.HttpClientUtil;

import org.apache.log4j.Logger;

import com.nms.thread.service.NmsReportService;

public class NmsPortThread implements Runnable {

	private Logger logger = Logger.getLogger(NmsPortThread.class);

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
			ArrayList<Map<String, String>> nmsPortInfo = service.getNmsPortInfo(nowLong, nowLong-interval*1000);
			if (nmsPortInfo != null && nmsPortInfo.size() > 0) {
				
				Map<String, List<Map<String, String>>> data = new HashMap<String, List<Map<String, String>>>();
				List<Map<String, String>> results = new ArrayList<Map<String, String>>();
				
				for (Map<String, String> info : nmsPortInfo) {
					Map<String, String> result = new HashMap<String, String>();
					result.put("port", info.get("ifindex") == null ? "" : info.get("ifindex"));
					result.put("nodeName", info.get("node_name") == null ? "" : info.get("node_name"));
					result.put("nodeIp", info.get("node_ip") == null ? "" : info.get("node_ip"));
					result.put("portDesc", info.get("IFDESCR") == null ? "" : info.get("IFDESCR"));
					result.put("bandwidth", info.get("IFSPEED") == null ? "" : info.get("IFSPEED"));
					result.put("inoctets", info.get("IFINOCTETS") == null ? "" : info.get("IFINOCTETS"));
					result.put("outoctets", info.get("IFOUTOCTETS") == null ? "" : info.get("IFOUTOCTETS"));
					result.put("inoctetsSpeed", info.get("INOCTETSSPEED") == null ? "" : info.get("INOCTETSSPEED"));
					result.put("outoctetsSpeed", info.get("OUTOCTETSSPEED") == null ? "" : info.get("OUTOCTETSSPEED"));
					result.put("inpktsSpeed", info.get("INPKTSSPEED") == null ? "" : info.get("INPKTSSPEED"));
					result.put("outpktsSpeed", info.get("OUTPKTSSPEED") == null ? "" : info.get("OUTPKTSSPEED"));
					result.put("recvTime", info.get("DATA_CHECK_TIME") == null ? "" : info.get("DATA_CHECK_TIME"));
					results.add(result);
				}
				data.put("trafficNetflowPortInfoList", results);
				HttpClientUtil httpUtil = new HttpClientUtil();
				JSONObject fromObject = JSONObject.fromObject(data);
				
				httpUtil.post(BaseAction.rb.getString("nms.port.url"), fromObject.toString());
				logger.info("port上报完毕");
			} else {
				logger.info("暂无可上报的port数据");
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
