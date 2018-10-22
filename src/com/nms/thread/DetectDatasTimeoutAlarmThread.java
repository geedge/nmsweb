package com.nms.thread;

import java.io.FileInputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.nms.thread.service.ThreadService;

import nis.nms.bean.SetInfo;
import nis.nms.util.ConnectionOracle;

public class DetectDatasTimeoutAlarmThread implements Runnable{
	private Logger logger = Logger.getLogger(DetectDatasTimeoutAlarmThread.class);
	private Date startTime = Calendar.getInstance().getTime();
	private boolean detectDatasTimeoutOthers = false;//监测超时 是否 过滤 握手监测 节点
	@Override
	public void run() {
//		Thread.currentThread().setName("监测数据超时告警线程");
		Thread.currentThread().setName("Monitoring Data Timeout Alarm Thread");
		ConnectionOracle conn = null;
		try {
			conn = ConnectionOracle.getConnection();
			ThreadService service = new ThreadService(conn);
			
			//先检查握手监测是否正常，若正常再检查其他监测，若超周期无数据，则无需检查其他监测（因为握手如果异常，其他监测也会异常）
			FileInputStream inStream = null;
			URL url2 = ThreadService.class.getResource("/myconfig.properties");
			Properties properties = new Properties();
			inStream = new FileInputStream(url2.getPath().replace("%20", " "));
			properties.load(inStream);
			String checkTypeName = properties.getProperty("detec.nmsclient.str");
			String detectOthers = properties.getProperty("detec.datastimeout.others");//监测超时 是否 过滤 握手监测 节点
//			String checkTypeName = Constants.NMS_CLIENT_CHECKTYPENAME;
			if(StringUtils.isEmpty(checkTypeName)){
				checkTypeName = "NMSClient";
			}
			//过滤 握手监测 超时 告警
			if(StringUtils.isNotBlank(detectOthers) && "1".equalsIgnoreCase(detectOthers.trim())){
				detectDatasTimeoutOthers = true;
			}
			SetInfo nmsClientSet = service.getSetInfoByCheckName(1,checkTypeName);	//查询握手监测相关信息		
			
			List<String[]> alarm = new ArrayList<String[]>();
			List<String []> nmsClientAlarmList  = service.detectDatasTimeoutCheck(nmsClientSet,startTime,null);//监测当前监测是否超时无数据
			String errorSeqIds = "-1";//握手监测异常的节点
			if(nmsClientAlarmList != null && nmsClientAlarmList.size()>0){//握手监测异常:有异常的节点（此次检查产生超周期告警信息）
				alarm.addAll(nmsClientAlarmList);
				for(String [] datas: nmsClientAlarmList){
					try {
						//service.resoveAlarms(datas);
						if(StringUtils.isNotBlank(datas[1])) {//seqId和ip不为空
							errorSeqIds = errorSeqIds + "," + datas[1];
						}
						logger.info("握手监测超时告警："+datas[9]);
					} catch (Exception e) {
						logger.error("Parsing handshake monitoring timeout anomaly information ", e);
					}
				}
			}else {
				logger.info("当前时间 所有节点握手监测均正常");
			}
//			//握手监测正常,查询握手最新时间的监测是否有异常的
			List<String> seqIds = new ArrayList<String>();
			seqIds = service.searchTimeoutNmsClient(nmsClientSet);				
			for(String seqId:seqIds) {
				if(StringUtils.isNotBlank(seqId) && !(","+errorSeqIds+",").contains((","+seqId+","))) {
					errorSeqIds = errorSeqIds + "," + seqId;
				}
			}
			
			logger.info("超时无握手监测信息节点的seqId："+errorSeqIds);
			
			List<SetInfo> setInfoList = service.getAllSetInfo(1,null);	//查询有效SetInfo信息				
			for(SetInfo setInfo : setInfoList){
				List<String []> alarmInfoList  = service.detectDatasTimeoutCheck(setInfo,startTime,detectDatasTimeoutOthers?errorSeqIds:null);//监测当前监测是否超时无数据
				if(alarmInfoList != null && alarmInfoList.size()>0){
					alarm.addAll(alarmInfoList);
					/*for(String [] datas: alarmInfoList){
						try {
//						System.out.println("--"+JSONArray.fromObject(datas));
							service.resoveAlarms(datas);
						} catch (Exception e) {
							logger.error("Parsing the abnormity of the timeout anomaly information of the monitoring data", e);
						}
					}*/
				}
			}		
			
			int size = alarm.size();
			logger.debug("监测超时告警：共 " + size +" 条，开始批量入库");
			boolean r = service.resoveAlarmsBatch(alarm);
			logger.debug("监测告警批量入库 -> "+ (r?"成功":"失败"));
		} catch (Exception e) {
			logger.error("Monitoring data timeout anomaly",e);
		}finally{
			try {
				if(conn != null){
					conn.close();
				}
			} catch (Exception e2) {
			}
		}
	}
	
	public static void main(String [] args){
		new Thread(new DetectDatasTimeoutAlarmThread()).start();
	}
}
