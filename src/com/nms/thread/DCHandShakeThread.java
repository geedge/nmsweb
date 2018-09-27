package com.nms.thread;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.Callable;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.Future;
import java.util.concurrent.Semaphore;

import nis.nms.domains.NmsErrorInfo;
import nis.nms.domains.ServerTable;
import nis.nms.util.ConnectionOracle;
import nis.nms.util.Constant;
import nis.nms.util.IpCovert;
import nis.nms.util.LocalAddress;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.nms.thread.common.ThreadPoolCommon;
import com.nms.thread.pool.ThreadConstants;
import com.nms.thread.socket.SSLClient;

/**
 * DC握手状态及管理节点数据集合解析
 * Map<dcip,Integer[]{state,nodeNum}>
 * dcip		DC通讯IP
 * state	DC状态值1 通讯正常、0通讯失败、-1Ping失败
 * NodeNum	管理节点数量 0表示未分配节点，其他表示已分配节点
 * 
 * 业务操作：
 * 		Web启动时查询数据库 对数据库信息进行统计（未完成）
 * 		对DC进行定期通讯握手测试，最多socket尝试三次，ping一次（已完成）
 * 		情景处理：（已完成）
 * 				DC通讯成功【1】 比较集合中state值比较并变更 [1:变更为1不作操作][0:变更为1做系统告警恢复（通讯正常）][-1:变更为1做系统告警恢复（通讯正常）]
 * 				DC通讯失败ping成功【0】 比较集合中state值并变更 [1:变更为0做系统告警异常（通讯失败）][0:不做操作][-1:变更为0做系统告警异常（Ping恢复，通讯失败）]
 * 				DC通讯失败ping失败【-1】 比较集合中state值并变更 [1:变更为-1做系统告警异常（Ping失败）][0:变更为-1做系统告警异常（Ping失败）][-1:不做操作]
 * 		告警信息及告警恢复入库
 * 		
 *  @date Apr 17, 2013 10:32:39 AM
 *	@author ZhangGang
 *
 */
public class DCHandShakeThread implements Callable<Object>{
	private Logger logger = Logger.getLogger(DCHandShakeThread.class);
	private Map<String,Long> DCIPIDMap = new HashMap<String,Long>();	
	private SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private List<NmsErrorInfo> errorInfoList = new LinkedList<NmsErrorInfo>();

	
	@Override
	public Object call() throws Exception {
		Thread.currentThread().setName("DCHandShakeThread");
		logger.debug("开始执行");
		ConnectionOracle conn = null;
		try {
			conn = ConnectionOracle.getConnection();
			
			/* 获取所有符合握手操作业务的DC
			 * 业务：	1、查询所有DC
			 *		2、对失效DC查询异常校验是否需要再次握手
			 *  */
			List<ServerTable> dclist = getHandShakeDCList(conn);
			
			/* 循环DC并握手通讯 尝试次数3 间隔20秒 */
			int totalCount = dclist.size();
			for(int i=1; i<4; i++){
				CountDownLatch downLatch = new CountDownLatch(dclist.size());
				handShakeForDC(dclist,downLatch);
				downLatch.await();
				pl("第"+i+"次 握手 有效数:"+(totalCount-dclist.size())+" 无效数："+dclist.size());
				
				//判断 最多尝试3次
				if(dclist.size()>0){
					Thread.sleep(20000);
				}else{
					break;
				}
			}
			
			/* 剩余失败DC 进行Ping 握手 判断主机是否存在 */
			CountDownLatch downLatch = new CountDownLatch(dclist.size());
			pingHandshake(dclist,downLatch);
			downLatch.await();
			
			/* 异常DC告警分析 */
			if(errorInfoList!= null && errorInfoList.size()>0){
				String sql = "insert into nms_error_info (error_code,error_time,state_update_time,errort_getip,errort_ip,error_state,error_des) values (?,to_date(?,'yyyy-mm-dd hh24:mi:ss'),to_date(?,'yyyy-mm-dd hh24:mi:ss'),?,?,?,?)";
				List<String[]> paramsList = new LinkedList<String[]>();
				for(NmsErrorInfo nei : errorInfoList){
					String[] params = new String[] {
							nei.getErrorCode(),
							format.format(nei.getErrorTime()),
							format.format(nei.getStateUpdateTime()),
							nei.getErrortGetip(),
							nei.getErrortIp(),
							(nei.getErrorState() == null ? 0 : nei.getErrorState().intValue())+ "",
							nei.getErrorDesc()};
					paramsList.add(params);
				}
				conn.dbUpdateByBatch(sql, paramsList);
			}
//			if(dclist!= null && dclist.size()>0){
//				for(ServerTable st : dclist){
//					Integer [] stData = ThreadPoolCommon.DCStatusMap.get(st.getServerIp());
					/*
					int newState = 
					 * createErrorInfo(dcIp, newState, oldState);
					errorInfoList.add();
					Map<String, String> error = new HashMap<String, String>();
//					error.put("ERROR_CODE", "");	//异常code：非空
					error.put("ERROR_TIME", format.format(Calendar.getInstance().getTime()));	//异常产生时间：非空
					error.put("ERRORT_GETIP", LocalAddress.getRealIp());	//异常信息提供IP：非空
					error.put("ERRORT_IP", st.getServerIp());	//异常信息产生IP：非空
					error.put("ERROR_STATE", "1");	//非空 异常状态：0已解决；1未解决
					 */
					//目标主机不存在
					/*if(stData[0]== ThreadConstants.HAND_SHAKE_RESULT_PING_FAILED){	//ping Failed
						error.put("ERROR_CODE", Constant.ERROR_NET_WORK_ERROR);	//异常code：非空
					}
					else if(stData[0]==null || stData[0]== ThreadConstants.HAND_SHAKE_RESULT_SOCKET_FAILED || stData[0]== ThreadConstants.HAND_SHAKE_RESULT_PING_SUCCESS){	//ping OK socket Down
						error.put("ERROR_CODE", Constant.HANDSHAKE_ERROR);	//异常code：非空
					}
					else if(stData[0]== ThreadConstants.HAND_SHAKE_RESULT_SOCKET_SUCCESS){	//socket success正常
						error.put("ERROR_CODE", Constant.);	//异常code：非空
					}
					else if(stData[0]== ThreadConstants.HAND_SHAKE_RESULT_UNKNOWN_FAILED){	//其他异常
						error.put("ERROR_CODE", Constant.ERROR_UNKNOWN_ERROR);	//异常code：非空
					}
					conn.insertObj("nms_error_info", error);*/
//				}
//			}
					
			//分析告警DC Down
			
			
//			NmsErrorInfo info = new NmsErrorInfo(errorCode, errorTime,
//					errortGetip, errortIp, errorState,
//					stateUpdateTime, stateUpdateUserid);
			
			/* 计算DC变更IP */
//			updateIPSegment(dclist,conn);
			
			/* 将变更后的信息重新发送到 */
			

		} catch (Exception e) {
			logger.error("", e);
		}finally{
			errorInfoList.clear();//清理集合数据
			try {
				if(conn != null){
					conn.close();
				}
			} catch (Exception e2) {
			}
		}
		return null;
	}
	public void pl(Object obj){
		System.out.println(obj==null?null:obj.toString());	
	}
	
	/**
	 * 查询符合握手操作的DCList
	 * 业务：	1、查询所有DC
	 *		2、对失效DC查询异常校验是否需要再次握手
	 * @time Jan 22, 2013-3:23:57 PM
	 * @param serverList
	 * @return
	 */
	public List<ServerTable> getHandShakeDCList(ConnectionOracle conn) throws Exception{
		List<ServerTable> dclist = new ArrayList<ServerTable>();
		String selectSql = "select st.id,st.server_ip,st.server_state from server_table st where st.server_state =0";
		ArrayList<String> fields = new ArrayList<String>();
		fields.add("id");
		fields.add("server_ip");
		fields.add("server_state");
		ArrayList<Map<String, String>> mapsList = conn.dbSelect(selectSql,fields);
		StringBuffer falseDCId = new StringBuffer("0");
		if(mapsList!= null && mapsList.size()>0){
			for(Map<String, String> map : mapsList){
				ServerTable serverTable = new ServerTable();
				serverTable.setId(StringUtils.isBlank(map.get("id"))?null:Long.parseLong(map.get("id")));
				serverTable.setServerIp(map.get("server_ip"));
				serverTable.setServerState(StringUtils.isBlank(map.get("server_state"))?null:Long.parseLong(map.get("server_state")));
				dclist.add(serverTable);
				if(serverTable.getServerState()==1l){//失效DC
					falseDCId.append(","+serverTable.getId());
				}
				DCIPIDMap.put(serverTable.getServerIp(), serverTable.getId());
			}
			//查询校验失效DC 的异常信息，判断是否做再次通讯处理（待完善）
		}
		return dclist;
	}
	/**
	 *  
	 * @time Jan 22, 2013-10:54:57 AM
	 * @param ipList
	 */
	public int handShakeForDC(List<ServerTable> serverList,CountDownLatch downLatch) {
		if(serverList!= null && serverList.size()>0){
			//单线程操作
			Semaphore handShakeSemaphore = new Semaphore(10,true);
			
			for(int i = 0;i<serverList.size();i++){
				ServerTable st = serverList.get(i);
				
				try {
					
					handShakeSemaphore.acquire();		//申请监测信号
//					pl("handshake for:"+st.getServerIp());
					SSLClient  client = new SSLClient(st.getServerIp(),SSLClient.HAND_SHAKE_DC,null);
					
					//-- 启动新线程
					final Future<?> future = ThreadPoolCommon.service.submit(client);
					//-- 获取结果
					Integer val = (Integer) future.get();
					
					//-- 结果保存
					Integer[] data = ThreadPoolCommon.DCStatusMap.get(st.getServerIp());
					if(data==null){	//新DC第一次握手结果不做告警处理
						data = new Integer[]{val,0};
					}else{
						//val值为null 或1 ，1为通讯正常，作通讯恢复判断
						if(val!=null && val.intValue()==1){
							NmsErrorInfo nei = createErrorInfo(st.getServerIp(),val,data[0]);
							if(nei!=null){
								errorInfoList.add(nei);
							}
							data[0] = val;
						}
					}
					ThreadPoolCommon.DCStatusMap.put(st.getServerIp(), data);
					
					//-- 队列处理
					if(val == ThreadConstants.HAND_SHAKE_RESULT_SOCKET_SUCCESS){
						//删除该DC无需再次轮询
						serverList.remove(i);
						i--;
					}
				} catch (Exception e) {
					logger.error("",e);
				}finally{
					handShakeSemaphore.release();
					downLatch.countDown();
				}
			}
		}
		return 1;
	}
	
	
	private NmsErrorInfo createErrorInfo(String dcIp,Integer newState,Integer oldState) throws Exception{
		
		if(dcIp==null
				|| oldState == null
				|| (newState!=null && newState.intValue() == oldState.intValue())){
			return null;
		}
		
		NmsErrorInfo nei = new NmsErrorInfo();
		nei.setErrorCode(Constant.HANDSHAKE_ERROR);
		nei.setErrorTime(Calendar.getInstance().getTime());
		nei.setStateUpdateTime(Calendar.getInstance().getTime());
		//nei.setErrortGetip(LocalAddress.getRealIp());
		nei.setErrortGetip(LocalAddress.getLocalIp());
		nei.setErrortIp(dcIp);
		nei.setErrorDesc("WEB与DC握手");
		
		if(newState!=null && newState == 1){	//正常
			if(oldState != 1){
				nei.setErrorState(2l);	//非空 异常状态：0已解决；1未解决；2已恢复
			}
		}else{	//异常
			if(oldState == 1){
				nei.setErrorState(1l);	//非空 异常状态：0已解决；1未解决；2已恢复
			}
		}
		return nei;
	}
	
	/**
	 * 根据比较新旧DC握手状态
	 * 获取告警描述信息
	 * @time Apr 17, 2013-10:38:15 AM
	 * @param newState
	 * @param oldState
	 * @return
	 */
	private String getErrorInfoDesc(int newState,int oldState){
		if(newState == oldState){
			return null;
		}
		//  情景处理：
		//	DC通讯成功【1】 比较集合中state值比较并变更 [1:变更为1不作操作][0:变更为1做系统告警恢复（通讯恢复）][-1:变更为1做系统告警恢复（通讯恢复）]
		//	DC通讯失败ping成功【0】 比较集合中state值并变更 [1:变更为0做系统告警异常（Ping正常，通讯失败）][0:不做操作][-1:变更为0做系统告警异常（Ping恢复，通讯失败）]
		//	DC通讯失败ping失败【-1】 比较集合中state值并变更 [1:变更为-1做系统告警异常（Ping失败）][0:变更为-1做系统告警异常（Ping失败）][-1:不做操作]

		switch (newState) {
		case -1:
			return "Ping失败";
		case 0:
			if (oldState == 1)
				return "Ping正常，通讯失败";
			else if(oldState ==-1)
				return "Ping恢复，通讯失败";
			break;
		case 1:
			return "通讯恢复";
		default:
			return null;
		}
		return null;
	}
	
	public int pingHandshake(List<ServerTable> serverList,CountDownLatch downLatch) {
		if(serverList!= null && serverList.size()>0){
			//单线程操作
			Semaphore handShakeSemaphore = new Semaphore(5,true);
			
			for(int i = 0;i<serverList.size();i++){
				ServerTable st = serverList.get(i);
				try {
					
					handShakeSemaphore.acquire();		//申请监测信号
					pl("ping for:"+st.getServerIp());
					PingThread pingThread = new PingThread(st.getServerIp());
					//-- 启动新线程
					final Future<?> future = ThreadPoolCommon.service.submit(pingThread);
					//-- 获取结果
					Integer val = (Integer) future.get();
					
					//-- 结果处理
					Integer[] data = ThreadPoolCommon.DCStatusMap.get(st.getServerIp());
					if(data==null){
						data = new Integer[]{val,0};
					}else{
						//val值为null 或3 或4 ，3为Ping正常通讯失败，null 或 4为通讯失败 对节点做最终状态处理
						val = (val==null || val.intValue()==ThreadConstants.HAND_SHAKE_RESULT_PING_FAILED)?-1:0;
						if(val!=null && data[0]!=null){
							NmsErrorInfo nei = createErrorInfo(st.getServerIp(),val,data[0]);
							if(nei!=null){
								errorInfoList.add(nei);
							}
						}
						data[0] = val;
					}
					ThreadPoolCommon.DCStatusMap.put(st.getServerIp(), data);
					
					//-- 队列处理
					/*if(val == ThreadConstants.HAND_SHAKE_RESULT_PING_SUCCESS){
						//删除该DC无需再次轮询
						serverList.remove(i);
						i--;
					}*/
				} catch (Exception e) {
					logger.error("",e);
				}finally{
					handShakeSemaphore.release();
					downLatch.countDown();
				}
			}
		}
		return 1;
	}
	
	/**
	 *  更新各DC管理的IP段
	 * @time Jan 22, 2013-10:54:57 AM
	 * @param ipList
	 */
	public int updateIPSegment(List<ServerTable> errorDCList,ConnectionOracle conn) throws Exception{
		//--查询节点类型
		String selectSql = "select distinct nt.node_type from node_table nt where nt.node_type is not null";
		ArrayList<String> fields = new ArrayList<String>();
		fields.add("node_type");
		ArrayList<Map<String, String>> nTypeMapsList = conn.dbSelect(selectSql,fields);
		StringBuffer falseDCId = new StringBuffer("0");
		LinkedList<String> nTypeList = new LinkedList<String>();
		if(nTypeMapsList!= null && nTypeMapsList.size()>0){
			for(Map<String, String> map : nTypeMapsList){
				nTypeList.add(map.get("node_type"));
			}
		}
		
		//--统计DC状态
		int OKCount = 0;	//有效数
		List<String> OKDCIpList = new ArrayList<String>();	//有效Ip集合
		Iterator<Entry<String, Integer[]>> ite  = ThreadPoolCommon.DCStatusMap.entrySet().iterator();
		while (ite.hasNext()) {
			Map.Entry<java.lang.String,Integer[]> entry = (Map.Entry<java.lang.String,Integer[]>) ite.next();
			if(entry.getValue()[0] == 1){	//有效
				OKCount++;
				OKDCIpList.add(entry.getKey());
			}			
		}
		
		//--正序排序
		Collections.sort(OKDCIpList,new Comparator(){

			@Override
			public int compare(Object o1, Object o2) {
				return o1.toString().compareTo(o2.toString());
			}

		});
		//展示
		for(String ip :OKDCIpList){
			pl("ip>"+ip);
		}
		//--查询有效节点，条件节点类型,节点IP有小到大排序
		if(nTypeList.size()>0){
			for(String nType : nTypeList){
				String nSql = "select distinct nt.ipn from node_table nt where nt.node_state=0 and nt.node_type=? order by nt.ipn asc";
				ArrayList<String> ipnList = conn.dbSelectSingleColumn(nSql,nType);
				int segmentSize  = ipnList.size()%OKCount==0?ipnList.size()%OKCount:(ipnList.size()%OKCount)+1;
				
				//-- 分配操作
				long minIpn=0,maxipn=0,segmentCount=0;
				int i = 0;
				for(String dcIp : OKDCIpList){
					ipnF:for(;i<ipnList.size();i++){
						long ipn = Long.parseLong(ipnList.get(i));
						//最小值
						if(minIpn == 0){
							minIpn = ipn;
						}
						
						//最大值
						if(maxipn<ipn){
							maxipn = ipn;
						}
						segmentCount++;
						
						//跳出判断
						if(segmentCount == segmentSize){
							minIpn = 0;
							maxipn = 0;
							segmentCount = 0;
							break ipnF;
						}
					}
				
					//更新或保存
				saveOrUpdateIPSegment(conn,DCIPIDMap.get(dcIp),dcIp,nType,minIpn,maxipn,segmentCount);
				}
				
			}
		}
		
		return 1;
	}
	
	/**
	 * 插入或保存IPSegment操作
	 * @time Jan 22, 2013-3:49:45 PM
	 * @param conn
	 * @param dcIp
	 * @param nType
	 * @param minIpn
	 * @param maxipn
	 * @param segmentCount
	 */
	public void saveOrUpdateIPSegment(ConnectionOracle conn,Long dcId,String dcIp,String nType,Long minIpn,Long maxipn,Long segmentCount) throws Exception{
		//查询是否存在
//		pl(dcId);
		String selectSql = "select sis.id from server_ip_segment sis where sis.SERVER_ID=? and sis.node_type=?";
		ArrayList<String> fields = new ArrayList<String>();
		fields.add("node_type");
		ArrayList<String> sisIdList = conn.dbSelectSingleColumn(selectSql,dcId,nType);
		if(sisIdList!= null && sisIdList.size()>0){	//update
			conn.dbUpdate("update server_ip_segment set start_ip=? ,start_ipn=?,end_ip=?,end_ipn=?,node_count=? where id=? ", IpCovert.longToIP(minIpn),minIpn,IpCovert.longToIP(maxipn),maxipn,segmentCount,sisIdList.get(0));
		}else{	//insert
			Map<String, String> obj  = new HashMap<String, String>();
			obj.put("SERVER_ID", dcId+"");
			obj.put("start_ip", IpCovert.longToIP(minIpn));
			obj.put("start_ipn", minIpn+"");
			obj.put("end_ip", IpCovert.longToIP(maxipn));
			obj.put("end_ipn", maxipn+"");
			obj.put("segment_state", "1");
			obj.put("node_type", nType+"");
			obj.put("node_count", segmentCount+"");
			conn.insertObj("server_ip_segment", obj);
		}
	}
	
	/**
	 * @time Jan 21, 2013-4:27:33 PM
	 * @param args
	 */
	public static void main(String[] args) {
		ThreadPoolCommon.scheduled.submit(new DCHandShakeThread());
//		ThreadPoolCommon.scheduled.scheduleAtFixedRate(new DCHandShakeManagerThread(),1,10,TimeUnit.SECONDS);
	}
}
