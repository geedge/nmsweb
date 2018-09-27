package nis.nms.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import nis.nms.persistence.OracleToMysql;


/**
 * JDBC操作数据库工具类
 * 
 * @date Jul 20, 2011 2:27:04 PM
 * @author ZhangGang
 * 
 */
public class ConnectionOracle {
	private Logger logger = Logger.getLogger(ConnectionOracle.class);
	private Properties myProperties ;
	private Connection dbConnection = null;
	private Statement sta = null;
	private PreparedStatement ps = null;
	private ArrayList<PreparedStatement> psList = new ArrayList<PreparedStatement>();
	private ResultSet dbResultSet = null; // 操作 select 结果集
	private Long seqDetectionInfoCur =  -1l;
	private Long seqDetectionInfoMax = -1l;
	private  String dbType;
	public static void main(String []aregs) {
		ConnectionOracle oracle = new ConnectionOracle();
	}
	public static ConnectionOracle getConnection() throws Exception {
		return new ConnectionOracle();
	}

	public Connection getConn(){
		return dbConnection;
	}
	
	/**
	 * 构造方法实现 加载驱动，创建连接
	 */
	protected ConnectionOracle() {

		InputStream fis = ConnectionOracle.class.getClassLoader().getResourceAsStream("hibernate/jdbc.properties");
	
		myProperties = new Properties();
		try {
			myProperties.load(fis);
		} catch (IOException e) {
			logger.error("Read properties file exception"+"",e);
		}finally{
			try {
				fis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	
		try {
//			System.out.println(myProperties.getProperty("jdbc.driver"));
//			System.out.println(myProperties.getProperty("jdbc.driver"));
//			System.out.println(myProperties.getProperty("jdbc.username"));
//			System.out.println(myProperties.getProperty("jdbc.password"));
			String driver = myProperties.getProperty("jdbc.driver");
			Class.forName(driver).newInstance();
			dbConnection = DriverManager.getConnection(myProperties.getProperty("jdbc.url"),
					myProperties.getProperty("jdbc.username"), myProperties.getProperty("jdbc.password"));
			if(driver.toUpperCase().indexOf("MYSQL") != -1){
				dbType = "mysql";
			}else{
				dbType = "oracle";
			}
			logger.debug("加载数据库驱动成功");
		} catch (Exception e) {
			logger.error("Load database driver failed!" + ExceptionPrintUtils.printExceptionStack(e));
		}
	}

	/**
	 * 使用Statement对象 实现select操作 注意：在selectSql中的字段和fields中的个数、名称要保持一致
	 * 
	 * @param selectSql
	 *            用于执行的select语句
	 * @param fields
	 *            要选择的字段
	 * @return 含有Map的ArrayList，一条记录形成一个Map
	 */
	public ArrayList<Map<String, String>> dbSelect(String selectSql,
			ArrayList<String> fields) throws Exception {
		ArrayList<Map<String, String>> selectResult = new ArrayList<Map<String, String>>(); // 新结果集
		Map<String, String> recordInfo;
		logger.debug("查询SQL> " + selectSql.toString());
		if (sta == null) {
			sta = dbConnection.createStatement(); // 定义Statement对象
		}
		selectSql = OracleToMysql.trans(selectSql);
		dbResultSet = sta.executeQuery(selectSql);
		// 循环取值
		while (dbResultSet.next()) {
			recordInfo = new HashMap<String, String>();
			for (int i = 0; i < fields.size(); ++i)
				recordInfo.put((String) fields.get(i), dbResultSet
						.getString(fields.get(i)));
			selectResult.add(recordInfo);
		}
		dbResultSet.close(); // 断开结果集
		logger.debug("dbSelect success");
		return selectResult;
	}

	/**
	 * 使用PeraredStatement对象 实现select操作 注意：在selectSql中的字段和fields中的个数、名称要保持一致
	 * 
	 * @param selectSql
	 *            用于执行的select语句
	 * @param fields
	 *            要选择的字段
	 * @param params
	 *            参数数组
	 * @return 含有Map的ArrayList，一条记录形成一个Map
	 */
	public ArrayList<Map<String, String>> dbSelect(String selectSql,
			ArrayList<String> fields, Object... params) throws Exception {
		ArrayList<Map<String, String>> selectResult = new ArrayList<Map<String, String>>();
		Map<String, String> recordInfo;
		logger.debug("存储SQL> " + selectSql.toString());
		// 设置参数
		selectSql = OracleToMysql.trans(selectSql);
		psList.add(ps = dbConnection.prepareStatement(selectSql));
		if (params != null && params.length > 0) {
			logger.debug("param:" + Arrays.toString(params));
			for (int i = 0; i < params.length; i++) {
				ps.setString((i + 1), StringUtils.isEmpty(params[i]==null?null:params[i].toString())?"": params[i].toString());
			}
		}
		dbResultSet = ps.executeQuery();
		// 循环取值
		while (dbResultSet.next()) {
			recordInfo = new HashMap<String, String>();
			for (int i = 0; i < fields.size(); ++i)
				recordInfo.put((String) fields.get(i), dbResultSet
						.getString(fields.get(i)));
			selectResult.add(recordInfo);
		}
		dbResultSet.close(); // 断开结果集
		logger.debug("dbSelect success");
		return selectResult;
	}

	/**
	 * 使用PeraredStatement对象 实现select操作 注意：在selectSql中的字段和fields中的个数、名称要保持一致
	 * 
	 * @param selectSql
	 *            用于执行的select语句
	 * @param fields
	 *            要选择的字段
	 * @param params
	 *            参数数组
	 * @return 含有Map的ArrayList，一条记录形成一个Map
	 */
	public ArrayList<String> dbSelectSingleColumn(String selectSql,Object... params) throws Exception {
		ArrayList<String> selectResult = new ArrayList<String>();
		logger.debug("存储SQL> " + selectSql.toString());
		// 设置参数
		selectSql = OracleToMysql.trans(selectSql);
		psList.add(ps = dbConnection.prepareStatement(selectSql));
		if (params != null && params.length > 0) {
			logger.debug("param:" + Arrays.toString(params));
			for (int i = 0; i < params.length; i++) {
				ps.setString((i + 1), StringUtils.isEmpty(params[i]==null?null:params[i].toString())?"": params[i].toString());
			}
		}
		dbResultSet = ps.executeQuery();
		// 循环取值
		while (dbResultSet.next()) {
			selectResult.add(dbResultSet.getString(1));
		}
		dbResultSet.close(); // 断开结果集
		logger.debug("dbSelect success");
		return selectResult;
	}
	
	public Map<Long,Map<Long,String>> dbSelect(String selectSql) throws Exception {
		Map<Long, Map<Long,String>> resu = new HashMap<Long, Map<Long,String>>();
		Map<Long, String> recordInfo = new HashMap<Long, String>();
		logger.debug("查询SQL> " + selectSql.toString());
		if (sta == null) {
			sta = dbConnection.createStatement(); // 定义Statement对象
		}
		selectSql = OracleToMysql.trans(selectSql);
		dbResultSet = sta.executeQuery(selectSql);
		// 循环取值
		while (dbResultSet.next()) {
			//recordInfo = new HashMap<Long, String>();
			Long code = dbResultSet.getLong("trouble_code");
			String troubleDesc = dbResultSet.getString("trouble_descr");
			Long sysId = dbResultSet.getLong("system_id");
			recordInfo.put(code, troubleDesc);
			resu.put(sysId, recordInfo);
		}
		dbResultSet.close(); // 断开结果集
		logger.debug("dbSelect success");
		return resu;
	}
	
	
	
	/**
	 * 使用Statement对象 对数据库执行update，delete或insert操作
	 * 
	 * @param sql
	 *            要执行操作的SQL语句
	 * @return 成功返回true 失败返回false
	 */

	public boolean dbUpdate(String sql) throws Exception {
		logger.debug("更新SQL> " + sql.toString());
		if (sta == null) {
			sta = dbConnection.createStatement(); // 定义Statement对象
		}
		sql = OracleToMysql.trans(sql);
		sta.executeUpdate(sql);
		logger.debug("dbUpdate success");
		return true;
	}
	/**
	 * 插入数据 封装方法
	 * 
	 * @time Jul 27, 2011-4:00:44 PM
	 * @param tableName
	 *            插入表 表名
	 * @param info
	 *            字段和值集合
	 * @return
	 * @throws Exception
	 */
	public boolean insertObj(String tableName, Map<String, String> info)
			throws Exception {
		StringBuffer values_0 =new StringBuffer();
		StringBuffer infoSQL = new StringBuffer("insert into " + tableName
				+ " ("); // SQL
		StringBuffer values = new StringBuffer(); // values
		// SQL拼写
		Iterator<Entry<String, String>> ite = info.entrySet().iterator();
		ArrayList<String> params = new ArrayList<String>();

		while (ite.hasNext()) {
			Entry<String, String> entry = ite.next();
			//logger.debug(entry.getKey()  +": \""+entry.getValue()+"\"" );
			if (StringUtils.isBlank(entry.getValue()))
				continue; // 跳过无效数据
			infoSQL.append(entry.getKey() + ",");
			params.add(entry.getValue());
			if (DateUtil.isDate(entry.getValue(), "yyyy-MM-dd HH:mm:ss")) { // 日期类型
				values.append(" to_date(?,'" + "yyyy-mm-dd hh24:mi:ss"
								+ "'),");
			} else { // 其他类型
				values.append("?,");
			}
			//--
			if (DateUtil.isDate(entry.getValue(), "yyyy-MM-dd HH:mm:ss")) { // 日期类型
				values_0
						.append(" to_date('"+entry.getValue()+"','" + "yyyy-mm-dd hh24:mi:ss"
								+ "'),");
			} else { // 其他类型
				values_0.append("'"+entry.getValue()+"',");
			}
		}

		infoSQL = infoSQL.deleteCharAt(infoSQL.length() - 1);
		values = values.deleteCharAt(values.length() - 1);
		values_0 = values_0.deleteCharAt(values_0.length() - 1);
		//System.out.println(infoSQL+") values ("+values_0+")");
		infoSQL.append(") values (" + values + ")");
		return this.dbUpdate(infoSQL.toString(), params.toArray());
	}
	/**
	 * 使用PeraredStatement对象 对数据库执行update，delete或insert操作
	 * 
	 * @param sql
	 *            要执行操作的SQL语句
	 * @param params
	 *            参数数组
	 * @return 执行成功返回true，失败返回false
	 */
	public boolean dbUpdate(String sql, Object... params) throws SQLException{
		logger.debug("更新SQL> " + sql.toString());
		sql = OracleToMysql.trans(sql);
		psList.add(ps = dbConnection.prepareStatement(sql)); // 定义PrepareStatement对象
		if (params != null && params.length > 0) {
			logger.debug("param:" + Arrays.toString(params));
			for (int i = 0; i < params.length; i++) {
				ps.setString((i + 1), StringUtils.isEmpty(params[i]==null?null:params[i].toString())?"": params[i].toString());
			}
		}
		ps.executeUpdate();
		logger.debug("dbUpdate success");
		return true;
	}
	/**
	 * 使用PeraredStatement对象 对数据库执行update，delete或insert操作
	 * 
	 * @param sql
	 *            要执行操作的SQL语句
	 * @param params
	 *            参数数组
	 * @return 执行成功返回true，失败返回false
	 */
	public boolean dbUpdateByBatch(String sql, List<String[]> params) throws SQLException {
		logger.debug("批量更新SQL> " + sql.toString());
		sql = OracleToMysql.trans(sql);
		psList.add(ps = dbConnection.prepareStatement(sql)); // 定义PrepareStatement对象
		if (params != null && params.size() > 0) {
			for (String [] strs : params) {
				logger.debug("params:" + Arrays.toString(strs));
				for(int i = 0; i <strs.length; i++){
					System.out.println((i+1)+" <> "+(StringUtils.isEmpty(strs[i])?"":strs[i].toString()));
					ps.setString((i+1), StringUtils.isEmpty(strs[i])?"":strs[i].toString());
				}
				ps.addBatch();
			}
			ps.executeBatch();
		}
		logger.debug("dbUpdate success");
		return true;
	}
	/**
	 * 使用PeraredStatement对象 对数据库执行update，delete或insert操作
	 * 
	 * @param sqls
	 *            要执行操作的SQL语句
	 * @param params
	 *            参数数组
	 * @return 执行成功返回true，失败返回false
	 */
	public boolean dbUpdateByBatch(List<String>sqls) throws Exception {
		logger.debug(" 批量更新Sql " + sqls.size());
		if (sta == null) {
			sta = dbConnection.createStatement(); // 定义Statement对象
		}
		for (String str : sqls) {
			str = OracleToMysql.trans(str);
			sta.addBatch(str);
		}
		sta.executeBatch();
		sta.clearBatch();
		logger.debug("dbUpdate By Batch success");
		return true;
	}
	/**
	 * 将设置提交方式
	 */
	public void setAutoCommit(boolean flag) throws Exception {
		dbConnection.setAutoCommit(flag);
	}

	/**
	 * 提交请求
	 */
	public void commit() throws Exception {
		dbConnection.commit();
	}

	/**
	 * 回滚操作
	 */
	public void rollback() throws Exception {
		dbConnection.rollback();
	}

	/**
	 * 关闭数据库连接
	 * 
	 * @return 成功返回true， 失败返回false
	 */
	public boolean clearConn() {
		try {
			if (dbResultSet != null) {
				dbResultSet.close();
				dbResultSet = null;
			} // 断开结果集
			if (sta != null) {
				sta.close();
				sta = null;
			} // 断开Statement对象
			if (psList.size() > 0) // 断开PeraredStatement对象集合
				for (PreparedStatement ps : psList)
					if (ps != null)
						ps.close(); // 断开PeraredStatement对象
			psList.clear();
			logger.debug("数据库链接清理");
			return true;
		} catch (Exception e) {
			logger.error("Clean database connection exception \n" + ExceptionPrintUtils.printExceptionStack(e));
			return false;
		}
	}

	/**
	 * 关闭数据库连接
	 * 
	 * @return 成功返回true， 失败返回false
	 */
	public boolean close() {
		try {
			if (dbResultSet != null) {
				dbResultSet.close();
				dbResultSet = null;
			} // 断开结果集
			if (sta != null) {
				sta.close();
				sta = null;
			} // 断开Statement对象
			if (psList.size() > 0) // 断开PeraredStatement对象集合
				for (PreparedStatement ps : psList)
					if (ps != null)
						ps.close(); // 断开PeraredStatement对象
			psList.clear();
			if (dbConnection != null) {
				dbConnection.close();
				dbConnection = null;
			} // 断开数据库链接
			logger.debug("数据库链接 已关闭");
			return true;
		} catch (Exception e) {
			logger.error("Close database connection exception\n" + ExceptionPrintUtils.printExceptionStack(e));
			return false;
		}
	}

	
	/**
	 * 模拟oracle start with connect by
	 * @param sql select * from table where xxx
	 * @param start 开始条件
	 * @param idName
	 * @param pidName
	 * @return
	 * @throws Exception 
	 */
	public  String startWithConnectBy(String sql ,String start,String idName,String pidName) throws Exception{
		List<String> result = new ArrayList();
		StringBuilder sb = new StringBuilder();
		sb.append(sql);
		sb.append(" and ");
		sb.append(start);
		List<String> temp = this.dbSelectSingleColumn(sb.toString());
		//result.addAll(temp);
		do {
			if(temp == null || temp.size() <1){
				break;
			}else{
				result.addAll(temp);
				StringBuilder tsb = new StringBuilder();
				for(String m : temp){
					tsb.append(",");
					tsb.append(m);
				}
				tsb.deleteCharAt(0);
				start = tsb.toString();
			}
			StringBuilder psb = new StringBuilder();
			psb.append(sql);
			psb.append(" and ");
			psb.append(pidName);
			psb.append(" in ( ");
			psb.append(start);
			psb.append(" )");
			temp = this.dbSelectSingleColumn(psb.toString());
			//result.addAll(temp);
		} while (true);
		StringBuilder r = new StringBuilder();
		for(String s : result){
			r.append(",");
			r.append(s);
		}
		if(r.length() > 0){
			r.deleteCharAt(0);
		}
		return r.toString();
	}
	
	
	public Long getSeqDetectionInfoNextval() throws Exception{
		if(seqDetectionInfoCur != -1 && seqDetectionInfoMax != -1 && seqDetectionInfoCur < seqDetectionInfoMax){
			seqDetectionInfoCur++;
			return seqDetectionInfoCur;
		}else{
			String searchIdSql = null;
			long increment = 0;
			if("mysql".equalsIgnoreCase(dbType)){
				searchIdSql = "select  t.INCREMENT ival from sys_sequence t where t.name = 'SEQ_DETECTION_INFO'";
				ArrayList<String> fields = new ArrayList<String>();
				fields.add("ival");
				List<Map<String, String>> sid = dbSelect(searchIdSql, fields);
				if(sid!=null && sid.size()>0){
					increment = Long.parseLong(sid.get(0).get("ival"));
				}
				searchIdSql = "select  "+Constant.NEXTVAL_FUNCTION_NAME+"('seq_detection_info') val from dual";
				fields = new ArrayList<String>();
				fields.add("val");
				sid = dbSelect(searchIdSql, fields);
				if(sid!=null && sid.size()>0){
					seqDetectionInfoCur = Long.parseLong(sid.get(0).get("val"));
					seqDetectionInfoMax = seqDetectionInfoCur + increment -1;
				}
			}else{
				searchIdSql = "select seq_detection_info.NEXTVAL val, t.increment_by ival from user_sequences t where t.sequence_name = 'SEQ_DETECTION_INFO'";
				ArrayList<String> fields = new ArrayList<String>();
				fields.add("val");
				fields.add("ival");
				List<Map<String, String>> sid = dbSelect(searchIdSql, fields);
				if(sid!=null && sid.size()>0){
					seqDetectionInfoCur = Long.parseLong(sid.get(0).get("val"));
					increment = Long.parseLong(sid.get(0).get("ival"));
					seqDetectionInfoMax = seqDetectionInfoCur + increment -1;
				}
			}
			return seqDetectionInfoCur;
		}
	}
	
}
