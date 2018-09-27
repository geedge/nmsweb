package com.nms.servlet.auto.run;

import java.io.File;
import java.util.Map;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpServlet;

import nis.nms.datasql.AntExecSql;
import nis.nms.datasql.KeyXMLTool;
import nis.nms.util.ConnectionOracle;

import org.apache.log4j.Logger;

/**
 *  NMSWeb启动时
 *  
 *  @date Mar 15, 2012 9:31:54 AM
 *	@author ZhangGang
 *
 */
public class AutoGetTroubleCode extends HttpServlet implements ServletContextListener{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 0L;
	private Logger logger = Logger.getLogger(AutoGetTroubleCode.class);
	public Map<Long,Map<Long, String>> maps;
	
	
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		ConnectionOracle conn = null;
		try {
			conn = ConnectionOracle.getConnection();
			String sql = "select t.trouble_code,t.trouble_descr,t.system_id from trouble_state t";
			maps = conn.dbSelect(sql);
			arg0.getServletContext().setAttribute("troubles", maps);
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
		/**/
		/*try{
			AntExecSql antExecSql = new AntExecSql();
			antExecSql.updgradeData();
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}*/
	}

	public Map<Long, Map<Long, String>> getMaps() {
		return maps;
	}

	public void setMaps(Map<Long, Map<Long, String>> maps) {
		this.maps = maps;
	}
	
////	public Long checkOrRegisterNMSWeb(){
////		//获取Port
////		List<Integer> portList = getLocalPort(); 
////		Integer port = portList!=null?portList.size()>0?portList.get(0):null:null;
////		
//		//获取访问IP
////		List<String> hostList = getLocalHost();
////		StringBuffer hostStr = new StringBuffer("'0'");
////		if(hostList!=null && hostList.size()>0){
////			for(String host : hostList){
////				hostStr.append(",'"+host+"'");
////			}
////		}else{
////			return null;
////		}
////		String localIp = getRealIp();
//		//校验已存在或注册
//		ConnectionOracle conn = null;
//		try {
//			String uuid = null;
//			conn = ConnectionOracle.getConnection();
//			ArrayList<String> fields = new ArrayList<String>();
//			fields.add("system_id");
//			String sql = "select st.system_id from system_table st where st.system_ip in ('"+localIp+"') and st.system_port='"+port+"'";
////			String sql = "select st.system_id from system_table st where st.system_ip in ("+hostStr+") and st.system_port='"+port+"'";
//			ArrayList<Map<String, String>> mapsList = conn.dbSelect(sql,fields);
//			
//			if(mapsList!=null && mapsList.size()>0){	//已存在
//				uuid = mapsList.get(0).get("system_id");
//				conn.dbUpdate("update system_table set SYSTEM_START_STATE='0' where system_id='"+uuid+"'");
//			}else{	//注册
//				fields.clear();
//				fields.add("id");
//				ArrayList<Map<String, String>> idMaps = conn.dbSelect("select seq_system_table.nextVal id from dual",fields);
//				uuid = idMaps.get(0).get("id");
//				
//				String date = new SimpleDateFormat("yyyy-MM-dd HH:dd:ss").format(new Date());
////				String insSql = "insert into system_table (system_id,system_name,system_desc,system_createtime,system_state,system_ip,system_ipn,system_port,SYSTEM_START_STATE,is_master)" +
////				" values('"+uuid+"','新Web','新Web',to_date('"+date+"','yyyy-mm-dd hh24:mi:ss'),'0','"+hostList.get(0)+"','"+IpCovert.ipToLong(hostList.get(0))+"','"+port+"','0','2')";
//				String insSql = "insert into system_table (system_id,system_name,system_desc,system_createtime,system_state,system_ip,system_ipn,system_port,SYSTEM_START_STATE,is_master)" +
//				" values('"+uuid+"','新Web','新Web',to_date('"+date+"','yyyy-mm-dd hh24:mi:ss'),'0','"+localIp+"','"+IpCovert.ipToLong(localIp)+"','"+port+"','0','2')";
//				conn.dbUpdate(insSql);
//			}
//			return uuid==null?null:Long.parseLong(uuid);
//		}catch (Exception e) {
//			logger.error("", e);
//		}finally{
//			conn.close();
//		}
//		return null;
//	}
	

//	public static void main(String [] args){
//		URL u = Class.class.getClass().getResource("/");
//		try {
//			System.out.println("---"+(u==null?null:u.toURI().toString()));
//		} catch (URISyntaxException e) {
//			e.printStackTrace();
//		}
//	}
}
