package com.nms.servlet.auto.run;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpServlet;

import nis.nms.util.BaseAction;
import nis.nms.util.ConnectionOracle;
import nis.nms.util.IpCovert;
import nis.nms.util.LocalAddress;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

/**
 *  NMSWeb启动时
 *  @date Mar 15, 2012 9:31:54 AM
 *	@author ZhangGang
 *
 */
public class AutoRegisterForNMSWeb extends HttpServlet implements ServletContextListener{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 0L;
	private Logger logger = Logger.getLogger(AutoRegisterForNMSWeb.class);
	private Long uuid = null;
	
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		ConnectionOracle conn = null;
		try {
			//关闭服务
			conn = ConnectionOracle.getConnection();
			conn.dbUpdate("update system_table set system_start_state = '1' where system_id='"+uuid+"'");
		} catch (Exception e) {
			logger.error("", e);
		}finally{
			try {
				if(conn != null){
					conn.close();
				}
			} catch (Exception e2) {
			}
		}
		System.out.println("Web服务状态为 已关闭");
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		try {
			//获取web唯一标识
			String sourcePath = this.getClass().getClassLoader().getResource("").getPath();
			String uuidPath = URLDecoder.decode(sourcePath,"utf-8")+"uuid.properties";
			System.out.println(""+uuidPath);
			File uuidFile = new File(uuidPath);
			if(!uuidFile.exists()){
				if(!uuidFile.getParentFile().exists()){
					uuidFile.getParentFile().mkdirs();
				}
				uuidFile.createNewFile();
			}
			FileInputStream fis = new FileInputStream(uuidFile);
			Properties properties = new Properties();
			properties.load(fis);
			String uuidStr = properties.getProperty("uuid");
			uuid = StringUtils.isEmpty(uuidStr)?null:Long.parseLong(StringUtils.trim(uuidStr));
			
			if(uuid==null){	//物理标识不存在 通过IP端口匹配进行校验 
				uuid = checkOrRegisterNMSWeb();
				properties.setProperty("uuid", uuid==null?"":uuid+"");
				FileOutputStream fos = new FileOutputStream(uuidFile);
				properties.store(fos, uuidFile.getName());
				fos.close();
			}else{	//UUID 查询校验
				boolean flag = checkOrUpdateNMSWeb(uuid);
				if(!flag){
					logger.warn("Web startup information monitoring anomaly!");
				}
			}
			
			fis.close();
		} catch (Exception e) {
			logger.error("", e);
		}finally{

		}
	}
	
	public Long checkOrRegisterNMSWeb(){
		//获取Port
		List<Integer> portList = getLocalPort(); 
		Integer port = portList!=null?portList.size()>0?portList.get(0):null:null;
		
		//获取访问IP
//		List<String> hostList = getLocalHost();
//		StringBuffer hostStr = new StringBuffer("'0'");
//		if(hostList!=null && hostList.size()>0){
//			for(String host : hostList){
//				hostStr.append(",'"+host+"'");
//			}
//		}else{
//			return null;
//		}
		//校验已存在或注册
		ConnectionOracle conn = null;
		try {
			//String localIp = LocalAddress.getRealIp();
			String localIp = LocalAddress.getLocalIp();
			String uuid = null;
			conn = ConnectionOracle.getConnection();
			ArrayList<String> fields = new ArrayList<String>();
			fields.add("system_id");
			String sql = "select st.system_id from system_table st where st.system_ip in ('"+localIp+"') and st.system_port='"+port+"'";
//			String sql = "select st.system_id from system_table st where st.system_ip in ("+hostStr+") and st.system_port='"+port+"'";
			ArrayList<Map<String, String>> mapsList = conn.dbSelect(sql,fields);
			
			if(mapsList!=null && mapsList.size()>0){	//已存在
				uuid = mapsList.get(0).get("system_id");
				conn.dbUpdate("update system_table set SYSTEM_START_STATE='0' where system_id='"+uuid+"'");
			}else{	//注册
				fields.clear();
				fields.add("id");
				ArrayList<Map<String, String>> idMaps = conn.dbSelect("select seq_system_table.nextVal id from dual",fields);
				uuid = idMaps.get(0).get("id");
				
				String date = new SimpleDateFormat("yyyy-MM-dd HH:dd:ss").format(new Date());
				//如果库里（SYSTEM_TABLE表）已经有主控系统了，则新注册的系统则为子系统，否则，注册的为主控系统
				String searchMasterSystemSql = "select st.system_id from system_table st where st.is_master=1";
				fields.clear();
				fields.add("system_id");
				ArrayList<Map<String, String>> systemsList = conn.dbSelect(searchMasterSystemSql,fields);
				String insSql = "";
				if(systemsList!=null && systemsList.size()>0) {
	//				String insSql = "insert into system_table (system_id,system_name,system_desc,system_createtime,system_state,system_ip,system_ipn,system_port,SYSTEM_START_STATE,is_master)" +
	//				" values('"+uuid+"','新Web','新Web',to_date('"+date+"','yyyy-mm-dd hh24:mi:ss'),'0','"+hostList.get(0)+"','"+IpCovert.ipToLong(hostList.get(0))+"','"+port+"','0','2')";
					insSql = "insert into system_table (system_id,system_name,system_desc,system_createtime,system_state,system_ip,system_ipn,system_port,SYSTEM_START_STATE,is_master)" +
					" values('"+uuid+"','"+"New Web"+"','"+"New Web"+"',to_date('"+date+"','yyyy-mm-dd hh24:mi:ss'),'0','"+localIp+"','"+IpCovert.ipToLong(localIp)+"','"+port+"','0','2')";
				}else {
					insSql = "insert into system_table (system_id,system_name,system_desc,system_createtime,system_state,system_ip,system_ipn,system_port,SYSTEM_START_STATE,is_master)" +
					" values('"+uuid+"','"+"New Web"+"','"+"New Web"+"',to_date('"+date+"','yyyy-mm-dd hh24:mi:ss'),'0','"+localIp+"','"+IpCovert.ipToLong(localIp)+"','"+port+"','0','1')";
				}
				conn.dbUpdate(insSql);			
			}
			return uuid==null?null:Long.parseLong(uuid);
		}catch (Exception e) {
			logger.error("", e);
		}finally{
			try {
				if(conn != null){
					conn.close();
				}
			} catch (Exception e2) {
			}
		}
		return null;
	}
	
	public boolean checkOrUpdateNMSWeb(Long uuid){
		//获取Port
		List<Integer> portList = getLocalPort(); 
		Integer port = portList!=null?portList.get(0):null;
		
		//获取可访问IP
//		List<String> hostList = getLocalHost();
//		StringBuffer hostStr = new StringBuffer("'0'");
//		if(hostList!=null && hostList.size()>0){
//			for(String host : hostList){
//				hostStr.append(",'"+host+"'");
//			}
//		}
		//校验已存在 或更新信息
		ConnectionOracle conn = null;
		try {
			//String localIp = LocalAddress.getRealIp();
			String localIp = LocalAddress.getLocalIp();
			conn = ConnectionOracle.getConnection();
			ArrayList<String> fields = new ArrayList<String>();
			fields.add("system_id");
//			String sql = "select system_id from system_table st where st.system_ip in ("+hostStr+") and st.system_port='"+port+"' and st.system_id='"+uuid+"'";
			String sql = "select system_id from system_table st where st.system_ip in ('"+localIp+"') and st.system_port='"+port+"' and st.system_id='"+uuid+"'";
			logger.warn(sql);
			ArrayList<Map<String, String>> mapsList = conn.dbSelect(sql,fields);
			//信息不存在时校验 更新IP信息
			String updateIP = "";
			if(mapsList==null || mapsList.size()==0){
//				updateIP = ",system_ip='"+hostList.get(0)+"',system_port='"+port+"'";
				updateIP = ",system_ip='"+localIp+"',system_port='"+port+"'";
			}
			conn.dbUpdate("update system_table set SYSTEM_START_STATE='0' "+updateIP+" where system_id='"+uuid+"'");
			return true;
		}catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				if(conn != null){
					conn.close();
				}
			} catch (Exception e2) {
			}
		}
		return false;
	}
	
//	public List<String> getLocalHost(){
//		List<String> hostList = new ArrayList<String>();
//		try {
//			Enumeration<NetworkInterface>  addresses = NetworkInterface.getNetworkInterfaces();
//			while(addresses.hasMoreElements()){
//				NetworkInterface address = addresses.nextElement();
//				Enumeration<InetAddress> enumeration = address.getInetAddresses();
//				while(enumeration.hasMoreElements()){
//					InetAddress address2 =enumeration.nextElement();
//					if("localhost,127.0.0.1".indexOf(address2.getHostName())<0){
//						System.out.println(address2.getHostName());
//						hostList.add(address2.getHostName());
//					}
//				}
//			}
//		} catch (SocketException e) {
//			e.printStackTrace();
//		}
//		return hostList;
//	}
	
	public List<Integer> getLocalPort(){
		String sourcePath = this.getClass().getClassLoader().getResource("/../../").getPath();
		System.out.println("--"+sourcePath);
//		String serverXMLPath = new File(System.getProperty("user.dir")).getParent()+File.separator+"conf"+File.separator+"server.xml";
		String serverXMLPath = new File(sourcePath).getParentFile().getParent()+File.separator+"conf"+File.separator+"server.xml";
		try {
			serverXMLPath = URLDecoder.decode(serverXMLPath,"utf-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		System.out.println("--"+serverXMLPath);
		 List<Integer> portList = new ArrayList<Integer>();
		
		try {
			SAXReader reader = new SAXReader();
			Document document = reader.read(new File(serverXMLPath));
			Element  root = document.getRootElement();
			Iterator<Element> serviceIte = root.elementIterator("Service");
			if(serviceIte!=null && serviceIte.hasNext()){
				Element service = serviceIte.next();
//				System.out.println("service name  "+service.elements());
				Iterator<Element> connectorIte = service.elementIterator("Connector");
				while(connectorIte.hasNext()){
					Element connector = connectorIte.next();
					String protocol = connector.attributeValue("protocol");
//					System.out.println("protocol  "+protocol);
					//String protocolTitle = protocol==null?null:protocol.length()>4?protocol.substring(0,4):protocol;
					//String protocolTitle = protocol==null?null:protocol.length()>4?protocol.substring(0,4):protocol;
					String protocolTitle = protocol==null?null:protocol.toUpperCase().indexOf("HTTP".toUpperCase())>-1?protocol.substring(0,4):protocol;
//					System.out.println((protocolTitle+"  "+"HTTP".equalsIgnoreCase(protocolTitle)));
					//if("HTTP".equalsIgnoreCase(protocolTitle)){
					if(protocol!=null && protocol.toUpperCase().indexOf("HTTP".toUpperCase())>-1){
						String protStr = connector.attributeValue("port");
						System.out.println("port  "+protStr);
						portList.add(Integer.parseInt(protStr));
					}
				}
			}
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		return portList;	
	}
	/*
	public static void main(String [] args){
	}*/
}
