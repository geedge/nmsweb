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

public class NmsPortThread implements Runnable {

	private static Logger logger = Logger.getLogger(NmsPortThread.class);

	@Override
	public void run() {
		Thread currentThread = Thread.currentThread();
		currentThread.setName("Port Report Thread");
		Date now = new Date();
		Long nowLong = now.getTime();
		Integer interval = null;
		try {
			interval = Integer.parseInt(BaseAction.rb.getString("nms.report.port.interval"));
		} catch (Exception e) {
			interval = 300;
		}
		
		ConnectionOracle connection = null;
		try {
			connection = ConnectionOracle.getConnection();
			NmsReportService service = new NmsReportService(connection);
			ArrayList<Map<String, String>> nmsPortInfo = service.getNmsPortInfo(nowLong, nowLong-interval*1000);
			if (nmsPortInfo != null && nmsPortInfo.size() > 0) {
				ArrayList<Map<String,String>> portStatusInfo = service.getPortStatusInfo();//串联设备端口配置状态
				Map<String,String> portStatusInfoMap = new HashMap<String,String>();
				for(Map<String,String> map : portStatusInfo){
					portStatusInfoMap.put(map.get("seqid")+map.get("name_flag"), map.get("state"));
				}
				logger.debug(String.format("查询数量：%s", nmsPortInfo.size()));
				Map<String, List<Map<String, String>>> data = new HashMap<String, List<Map<String, String>>>();
				List<Map<String, String>> results = new ArrayList<Map<String, String>>();
				List<Map<String, String>> portStatusWarn = new ArrayList<Map<String, String>>();
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
					result.put("entranceId", info.get("ADDR") == null ? "" : info.get("ADDR"));
					results.add(result);
					//整理端口状态告警推送
					String seqId = info.get("seq_id");
					String portName = info.get("IFDESCR");
					String adminStatus = info.get("IFADMINSTATUS");
					String setStatus = portStatusInfoMap.get(seqId + portName);//配置状态
					if(setStatus != null && !setStatus.equals(adminStatus)){
						Map<String,String> sw = new HashMap<String,String>();
						sw.put("area",info.get("ADDR") );
						sw.put("port", portName);
						sw.put("status", "1".equals(adminStatus)?"UP":"DOWN");
						sw.put("commitTime", info.get("DATA_CHECK_TIME"));
						portStatusWarn.add(sw);
					}
				}
				data.put("trafficNetflowPortInfoList", results);
				HttpClientUtil httpUtil = new HttpClientUtil();
				String dataStr = Json.toJson(data,JsonFormat.tidy());
				String url = BaseAction.rb.getString("nms.port.url");
				httpUtil.post(url, dataStr);
				//推送端口状态告警
				data.clear();
				data.put("trafficSeriesDevicePortInfoList", portStatusWarn);
				dataStr = Json.toJson(data,JsonFormat.tidy());
				url = BaseAction.rb.getString("nms.port.warn.url");
				httpUtil.post(url, dataStr);
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
