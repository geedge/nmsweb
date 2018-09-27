package com.nms.thread;

import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import nis.nms.util.BaseAction;
import nis.nms.util.ConnectionOracle;
import nis.nms.util.DateUtil;

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
			//ArrayList<Map<String, String>> nmsRuleInfo = service.getNmsRuleInfo(nowLong, nowLong-interval);
		} catch (Exception e) {
			logger.error(e);
		} finally {
			if (connection != null) {
				connection.close();
			}
		}
	}
}
