package nis.nms.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;
import org.springframework.web.util.HtmlUtils;

public class Common {
	public static Date today = new Date();
	public static Date yesterday = new Date(today.getTime()-24*60*60*1000);
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}


	
	public static Long dateToSecond(Date date){
		Long second = date.getTime() / 1000;
		return second;
	}
	
	public static Long stringToSecond(String dateStr){
		Date date = null;
		try {
			date = new SimpleDateFormat().parse(dateStr);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dateToSecond(date);
	}
	/**
	 * 把时间类型转化为字符串类型
	 */
	public static String getDateStr(Date date, String format) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
		return simpleDateFormat.format(date);
	}

	/**
	 * 把字符串类型转化为时间类型
	 */
	public static Date getDateObject(String date, String format) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
		Date temp = null;
		try {
			temp = simpleDateFormat.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return temp;
	}
	/**
	 * 上传文件时，判断该文件是否已存在，如存在，则在后面加入时间戳
	 * 
	 * @param fileName
	 *            单纯的文件名
	 */
	public static String addTimeTagForUploadFileName(String fileName) {
		Calendar calendar = new GregorianCalendar();
		long timestamp = calendar.getTimeInMillis();
		// 去掉后缀的文件名
		String fielType = "";
		if (fileName.lastIndexOf(".") != -1) {
			fielType = fileName.substring(fileName.lastIndexOf("."));
			fileName = fileName.substring(0, fileName.lastIndexOf("."));
		}
		fileName += "_" + timestamp;
		fileName += fielType;
		return fileName;
	}
	/**
	 * 去掉文件名后的时间戳
	 * 
	 * @param fileName
	 *            带时间戳的文件名
	 */
	public static String removeTimeTagForDownLoad(String fileName) {
		if (fileName.contains("_")) {
			String timeTag = fileName.substring(fileName.lastIndexOf("_"),
					fileName.lastIndexOf("."));
			fileName = fileName.replace(timeTag, "");
		}
		return fileName;
	}
	public static Map getModuleName(){
		
		return null;
	}
	/** @description 将菜单的链接中的转译符转换为正常格式 */
	public static String converseToNomal(String href) {
		Map<String, String> transferMap = Constant.getTransferMap();
		Set<String> keySet = transferMap.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			href = href.replace(transferMap.get(key), key);
		}
		return href;
	}
	
	/** 将菜单的链接中的转换为XML文本格式 */
	public static String converseToXMLStr(String href) {
		Map<String, String> transferMap = Constant.getTransferMap();
		Set<String> keySet = transferMap.keySet();
		for (String key : keySet) {
			// 将链接中已有实体引用还原为普通字符，避免和号转换时发生错误
			href = href.replace(transferMap.get(key), key);
		}
		for (String key : keySet) {
			href = href.replace(key, transferMap.get(key));
		}
		return href;
	}
	
	/** 转义字符集：XML预定义实体字符 */
	public static Map<String, String> getTransferMap() {
//		Map<String, String> transferMap = new HashMap<String, String>();
		Map<String, String> transferMap = new LinkedHashMap<String, String>();
		transferMap.put("&", "&amp;"); // 转换为实体引用时，和号最先进行转换
		transferMap.put("<", "&lt;");
		transferMap.put(">", "&gt;");
		transferMap.put("'", "&apos");
		// key 为"
		transferMap.put("\"", "&quot;");
		return transferMap;
	}
	
	/**
	 * 把内容转义为HTML可编译十六进制内容(主要转换特殊字符)
	 * 
	 * @param soruce
	 *            原内容
	 * @return 转义后内容
	 * @author 
	 */
	public static String toHTMLCode(String soruce) {
		return HtmlUtils.htmlEscapeHex(soruce);
	}

	/**
	 * 解决路径中有空格的问题
	 * @param path
	 * @return
	 */
	public static String buildPath(String path) {
		
		if (path==null) {
			
			return "";
		}
		
		path = path.replaceAll("%20", " ");
		
		return path;
	}
}
