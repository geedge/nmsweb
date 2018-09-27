package nis.nms.datasql;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import nis.nms.util.ConnectionOracle;
import nis.nms.util.FileUtil;

import org.apache.log4j.Logger;
import org.apache.tools.ant.Project;
import org.apache.tools.ant.taskdefs.SQLExec;
import org.apache.tools.ant.types.EnumeratedAttribute;

public class AntExecSql {
	private Logger logger = Logger.getLogger(AntExecSql.class);

	public AntExecSql() {

	}
	/**
	 * 使用默认连接更新数据库
	 * @param sqlpath
	 * @return
	 * @throws Exception
	 */
	public void updgradeData() throws Exception{
		//int a = 0;
		logger.debug("执行数据库更新sql开始");
		String web_inf_Path=new File(KeyXMLTool.class.getResource("/").getPath()).getParent(); 
		FileUtil fileUtil = new FileUtil();		
		try {
			//获取classpath路径，转化路径中的特殊字符为正常显示
			web_inf_Path = java.net.URLDecoder.decode(web_inf_Path,"UTF-8");
			String file3 = web_inf_Path+"\\updgradesql\\sql.out";
			File weFilePathFile = new File(web_inf_Path);
			File[] dataDirs = fileUtil.getDirectoryArray(weFilePathFile+"\\updgradesql","sql");
			if(dataDirs!=null && dataDirs.length>0){
				InputStream fis = ConnectionOracle.class.getClassLoader()
				.getResourceAsStream("hibernate/jdbc.properties");

				Properties myProperties = new Properties();
				try {
					myProperties.load(fis);
				} catch (IOException e) {
					logger.error("读取properties文件错误", e);
					throw e;
				} finally {
					try {
						fis.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				SQLExec sqlExec = new SQLExec();
				//sqlExec.setEncoding("UTF-8");
		
				sqlExec.setDriver(myProperties.getProperty("jdbc.driver"));
		
				sqlExec.setUrl(myProperties.getProperty("jdbc.url"));
		
				sqlExec.setUserid(myProperties.getProperty("jdbc.username"));
		
				sqlExec.setPassword(myProperties.getProperty("jdbc.password"));
				sqlExec.setDelimiter("/");
				file3 = java.net.URLDecoder.decode(file3,"UTF-8");
				File outFile = new File(file3);
				for(File file:dataDirs){
					sqlExec.setSrc(file);

					 /**/sqlExec.setOnerror((SQLExec.OnError)(EnumeratedAttribute.getInstance(SQLExec.OnError.class,
					 "abort")));

					sqlExec.setPrint(true); // 设置是否输出

					// 输出到文件 sql.out 中；不设置该属性，默认输出到控制台					
					sqlExec.setOutput(outFile);
					sqlExec.setProject(new Project()); // 要指定这个属性，不然会出错
					try {
						sqlExec.execute();
						logger.info("升级数据库文件："+file.getName()+"执行完成！");
						com.nms.objectSnmp.util.FileUtil.delDir(file);
						logger.info("删除升级数据库文件："+file.getName()+"执行完成！");
					} catch (Exception e) {
						e.printStackTrace();
						// TODO: handle exception
						logger.info("升级数据库文件："+file.getName()+"执行异常！");
					}
				}
				logger.debug("执行数据库更新sql结束");				
			}else{
				logger.debug("执行数据库更新sql,没有找到指定目录下文件。");
			}
			
		} catch (Exception e) {
			// TODO: handle exception		
			logger.info("执行数据库更新语句异常");
			//e.printStackTrace();
			throw e;
		}
		//return a;
	}
	/**
	 * 使用默认数据库执行sql
	 * 
	 * @param sqlFile
	 *            要执行的sql文件
	 * @param outfile
	 *            信息输出文件
	 * @throws Exception
	 */
	public void execSqlFile(String sqlFile, boolean output, String outfile,boolean delimiter)
			throws Exception {

		InputStream fis = ConnectionOracle.class.getClassLoader()
				.getResourceAsStream("hibernate/jdbc.properties");

		Properties myProperties = new Properties();
		try {
			myProperties.load(fis);
		} catch (IOException e) {
			logger.error("Read properties file error", e);
			throw e;
		} finally {
			try {
				fis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		SQLExec sqlExec = new SQLExec();
		sqlExec.setEncoding("UTF-8");

		sqlExec.setDriver(myProperties.getProperty("jdbc.driver"));

		sqlExec.setUrl(myProperties.getProperty("jdbc.url"));

		sqlExec.setUserid(myProperties.getProperty("jdbc.username"));

		sqlExec.setPassword(myProperties.getProperty("jdbc.password"));
		if(delimiter){
			sqlExec.setDelimiter("/");
		}
		File sqlFile2 = new File(sqlFile);
		if(!sqlFile2.exists()){
			System.out.println("sql文件："+sqlFile+"不存在！");
			logger.info("sql文件："+sqlFile+"不存在！");
			return;
		}
		sqlExec.setSrc(new File(sqlFile));

		 sqlExec.setOnerror((SQLExec.OnError)(EnumeratedAttribute.getInstance(SQLExec.OnError.class,
		 "abort")));

		sqlExec.setPrint(true); // 设置是否输出

		// 输出到文件 sql.out 中；不设置该属性，默认输出到控制台
		if (output) {
			File outFile = new File(outfile);
			if (!outFile.exists()) {
				outFile.mkdir();
			}
			sqlExec.setOutput(outFile);
		}
		sqlExec.setProject(new Project()); // 要指定这个属性，不然会出错
		try {
			sqlExec.execute();
		} catch (Exception e) {
			// TODO: handle exception
			throw e;
		}

	}

	// public static void execSqlFile(String url, String userID, String pwd,

	/**
	 * 初始化指定数据库 支持什么类型数据库要提供相应jar包，目前支持oracle
	 * @param DBType 	数据库类型
	 * @param url		数据库URL
	 * @param userID	用户名
	 * @param pwd		用户密码
	 * @param sqlFile	sql文件
	 * @param output	是否输出文件
	 * @param outfile   输出文件
	 * @throws Exception
	 */

	public void execSqlFile(String DBType, String url, String userID,
			String pwd, String sqlFile, boolean output, String outfile,boolean delimiter)
			throws Exception {

		SQLExec sqlExec = new SQLExec();
		sqlExec.setEncoding("UTF-8");
		Properties myProperties = new Properties();

		// 设置数据库参数
		if ("ORALCE".equals(DBType.toUpperCase())) {
			sqlExec.setDriver("oracle.jdbc.driver.OracleDriver");
		} else if ("SQLSERVER".equals(DBType.toUpperCase())) {
			sqlExec.setDriver("");
		} else if ("MYSQL".equals(DBType.toUpperCase())) {
			sqlExec.setDriver("");
		} else {
			sqlExec.setDriver("oracle.jdbc.driver.OracleDriver");
		}
		sqlExec.setUrl(url);

		sqlExec.setUserid(userID);

		sqlExec.setPassword(pwd);
		//sqlExec.setDelimiterType(";");
		if(delimiter){
			sqlExec.setDelimiter("/");
		}
		sqlExec.setSrc(new File(sqlFile));

		// sqlExec.setOnerror((SQLExec.OnError)(EnumeratedAttribute.getInstance(SQLExec.OnError.class,
		// "abort")));

		// sqlExec.setPrint(true); //设置是否输出
		sqlExec.setPrint(false); //设置是否输出
		// 输出到文件 sql.out 中；不设置该属性，默认输出到控制台
		if (output) {
			File outFile = new File(outfile);
			/*if (!outFile.exists()) {
				outFile.mkdir();
			}*/
			sqlExec.setOutput(outFile);
		}

		sqlExec.setProject(new Project()); // 要指定这个属性，不然会出错
		//sqlExec.setAutocommit(false);
		try {
			sqlExec.execute();
		} catch (Exception e) {
			// TODO: handle exception
			throw e;
		}

	}

	public static void main(String args[]) {
		/*InputStream fis = ConnectionOracle.class.getClassLoader()
				.getResourceAsStream("hibernate/jdbc.properties");

		Properties myProperties = new Properties();
		try {
			myProperties.load(fis);
		} catch (IOException e) {
			System.out.println("读取properties文件错误" + e.toString());
		} finally {
			try {
				fis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}*/
		String url = "jdbc:oracle:thin:@10.0.6.141:1521:orcl";
		String username = "bbmanager";
		String pwd = "bbmanager";// sqlExec.setDriver("oracle.jdbc.driver.OracleDriver");
		String errorMsg = "";
		String file1 = KeyXMLTool.getFileUrl("updateinit.sql");

		String file2 = KeyXMLTool.getFileUrl("updateinittri.sql");
		String file3 = file1.replace("updateinit.sql", "sql.out");
		File file = new File(file3);
		
		AntExecSql antExecSql = new AntExecSql();
		try {
			antExecSql.updgradeData();
			/*antExecSql.execSqlFile(file1, true, file3, false);
			antExecSql.execSqlFile(file2, true, file3, true);*/
			/**/antExecSql.execSqlFile("ORACLE", url, username, pwd, file1, true,
					file3,false);
			antExecSql.execSqlFile("ORACLE", url, username, pwd, file1, true,
					file3,true);
			// AntExecSql.execSqlFile(url,username,pwd,file2);

		} catch (Exception ex) {

			ex.printStackTrace();

			System.out.println("error" + ex.getMessage());

			errorMsg = ex.getMessage();

			errorMsg = errorMsg.substring(errorMsg.indexOf("JDBC]") + 5,
					errorMsg.length() - 1);

			if (errorMsg.equals("Error establishing socket")) {

				errorMsg = "数据库地址错误！";

			}

		}
	}

}
