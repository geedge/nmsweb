package nis.nms.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Properties;
import java.util.ResourceBundle;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

/**
 * 获取和保存myconfig信息的类
 * 
 * @author ZGGG3
 * 
 */
public class ConfigUpdate {
	private static Logger logger = Logger.getLogger(ConfigUpdate.class);
	private static Properties properties;
	private static String url = null;
	public static List<String> proList = new LinkedList<String>();
	public static ConfigUpdate config = ConfigUpdate.getInstance();
	private static ResourceBundle resource;
	/**
	 * 单例 初始化获取实例
	 * 
	 * @return
	 */
	public static ConfigUpdate getInstance() {
		if (config == null)
			return new ConfigUpdate();
		return config;
	}

	/**
	 * 单例 重新读取文件已获取参数
	 * 
	 * @return
	 */
	public static ConfigUpdate reinitialize() {
		config = null;
		return new ConfigUpdate();
	}

	/**
	 * 构造函数私有，用于单例实例
	 */
	private ConfigUpdate() {
//		Thread.currentThread().setName("更新参数");
		resource = ResourceBundle.getBundle(UpdateParams.class.getName());
		
		URL urlObj = ConfigUpdate.class.getClassLoader().getResource("myconfig.properties");
		if(urlObj!= null){
			url = urlObj.getPath().replaceAll("%20", " ");
		}else{
			url = new File(System.getProperty("user.dir")).getParentFile().getAbsolutePath()+"/conf/myconfig.properties";
		}
		logger.info("参数文件："+url);
		BufferedReader reader = null;
		FileInputStream fis = null;
		properties = new Properties();
		
		try {
			File file = new File(url).getAbsoluteFile();
			/*外部资源文件是否已存在*/
			if(file.exists()){	// 存在 则读取已存在的文件信息 ，将内部资源文件参数更新到外部资源文件中
				fis = new FileInputStream(file);
				properties.load(fis);
				
				//判断是否更新properties
				String updateFlag = properties.getProperty(UpdateParams.CONFIG_UPDATE_FLAG,"-1");
				if(updateFlag.equals(resource.getString(UpdateParams.CONFIG_UPDATE_FLAG))){	//配置文件已经更新，退出操作
					return;
				}
			}else{	// 不存在无操作
				return ;
			}
			
			//更新参数
			/*Enumeration<String> en = resource.getKeys();
			while (en.hasMoreElements()) {
				String elem = (String) en.nextElement();
				String value = properties.getProperty(elem);
				if(StringUtils.isBlank(value)){
					properties.setProperty(elem, configRb.getString(elem));
				}
			}
			 */
			fis.close();
			fis = new FileInputStream(file);
			reader = new BufferedReader(new InputStreamReader(fis,Charset.forName("utf-8")));
			String str =null;
			while((str = reader.readLine() )!=null){
				proList.add(str);
			}
			save();
		} catch (Exception e) {
			logger.error("Read properties file error"+"",e);
		}finally{
			try {
				if(reader!= null)reader.close();
				if(fis!= null)fis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 根据name获取value
	 * 
	 * @param name
	 * @return
	 */
	public static Integer getInteger(String name) {
		try {
			return Integer.parseInt(getString(name));
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	/**
	 * 根据name获取value
	 * 
	 * @param name
	 * @return
	 */
	public static String getString(String name) {
		String str = null;
		try {
			str = properties.getProperty(name);
			if(StringUtils.isNotEmpty(str)){
				str = str.trim();
			}else{
				logger.warn("Get value from resource configuration file abnormality>> "+name+" value is empty");
			}
		} catch (Exception e) {
			logger.error("Get value from resource configuration file abnormality", e);
		}
		return str;
	}

	/**
	 * 向资源配置文件中添加或更新一个键值对
	 * 
	 * @time Jul 7, 2011-3:52:45 PM
	 * @param key
	 * @param value
	 */
	public static void setValueByName(String key, String value) {
		// 添加或更新键值对
		String oldValue = properties.getProperty(key);
		properties.setProperty(key, value);
	}

	/**
	 * 保存到文件
	 * @time Jan 6, 2013-1:24:07 PM
	 */
	public static void save() {
		BufferedWriter writer = null;
		try {
			//将properties中的值更新到proList中
			Enumeration<String> en = resource.getKeys();
			while (en.hasMoreElements()) {
				String elem = (String) en.nextElement();
				String value = resource.getString(elem);
				boolean addFlag = true;
				try {
					for (int i = 0; i < proList.size(); i++) {
						String str = proList.get(i);
						if(StringUtils.isEmpty(str)){continue;}
						if(str.split("=", 2)[0].trim().equals(elem)){
							str = elem+" = "+value;
							proList.set(i, str);
							addFlag = false;
							logger.info("参数更新："+elem+" = "+(StringUtils.isBlank(value)?"":value));
							break ;
						}
					}
					
					if(addFlag){
						proList.add(elem+" = "+value);
						logger.info("参数新增："+elem+" = "+(StringUtils.isBlank(value)?"":value));
					}
				} catch (Exception e) {
					logger.error("properties file set value ERROR "+elem,e);
				}
			}
			File file = new File(url).getAbsoluteFile();
			if(!file.exists()){
				if(!file.getParentFile().exists()){
					file.getParentFile().mkdirs();
				}
				file.createNewFile();
			}
			//将文件信息写入到文件中
			writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file),Charset.forName("utf-8")));
			Iterator<String> it = proList.iterator();
			while (it.hasNext()) {
				String elem = (String) it.next();
				writer.write((elem==null?"":elem)+"\r\n");
			}
			writer.flush();
		} catch (Exception e) {
			System.err.println("资源配置文件取值异常");
			e.printStackTrace();
		}finally{
			try {
				if(writer!= null ){
					writer.close();
					writer = null;
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 向资源配置文件host_uuid.properties中更新UUID键值
	 */
	/*public static void saveResource(String value) {
		try {
			Properties properties = new Properties();
			if (uuidUrl != null && !"".equals(uuidUrl)) {
				properties.load(new FileInputStream(uuidUrl));
				// 添加或更新键值对
				properties.setProperty(AGENT_HOST_UUID_KEY, value);
				// 保存到文件
				properties.store(new FileOutputStream(uuidUrl), "");
			}
			properties.clear();
			
			if(value != null && !"".equals(value)){
				Contants.AGENT_HOST_UUID = Long.parseLong(value);
			}
		} catch (Exception e) {
			logger.error(e);
		} 
	}*/
	
/*	public static void pl(Object obj){
		System.out.println(obj==null?null:obj.toString());
	}*/
	
/*	public static void main(String [] args){
//		pl(log4jRb.getString("log4j.appender.logfile.File"));
//		pl(configRb.getString("email.flag"));
	}*/
}
