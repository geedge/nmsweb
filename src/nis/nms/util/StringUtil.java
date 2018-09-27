package nis.nms.util;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.apache.commons.lang.StringUtils;

public class StringUtil {
	
	
	private static boolean flag = true;

	/**
	 * 判断对象是否为空�����пղ�������
	 */
	public static boolean objectIsNUll(Object object) {
		if (object == null) {
			flag = true;
		} else {
			if (object instanceof String) {
				flag = stringIsNull((String) object);
			} else if (object instanceof Collection) {
				flag = collectionIsNull((Collection) object);
			} else if (object instanceof Map) {
				flag = mapIsNull((Map) object);

			} else {
				flag = false;
			}

		}

		return flag;
	}

	/**
	 * �ж��ַ��Ƿ�Ϊ��
	 */
	private static boolean stringIsNull(String str) {
		if (str.trim() != "" && str.trim().length() > 0) {
			return false;
		}
		return true;
	}

	/**
	 * �жϼ����Ƿ�Ϊ��
	 */
	private static boolean collectionIsNull(Collection collection) {
		if (collection.size() > 0) {
			return false;
		}

		return true;
	}

	/**
	 * mapIsNull
	 */
	private static boolean mapIsNull(Map map) {
		if (map.size() > 0) {
			return false;
		}

		return true;
	}

	
	
	/** List order maintained **/  

	public static List removeDuplicateWithOrder(List arlList) {
		Set set = new HashSet();
		List newList = new ArrayList();
		for (Iterator iter = arlList.iterator(); iter.hasNext();) {
			Object element = iter.next();
			if(null==element){
				continue;
			}
			if (set.add(element)){
				newList.add(element);
			}
				
		}
		// arlList.clear();
		// arlList.addAll(newList);
		return newList;
	}
	
	//获得各种Code 方式
	public static Map<String,String> getTableCodeMap(){
		Map<String,String> tableCodeMap = new HashMap<String, String>();
		tableCodeMap.put("PROTOCOL", BaseAction.getI18nText("i18n_StringUtil.getTableCodeMap.PROTOCOL_n81i"));
		tableCodeMap.put("SERVER_IP", BaseAction.getI18nText("i18n_StringUtil.getTableCodeMap.SERVER_IP_n81i"));
		tableCodeMap.put("CLIENT_IP", BaseAction.getI18nText("i18n_StringUtil.getTableCodeMap.CLIENT_IP_n81i"));
		tableCodeMap.put("SERVER_PORT",BaseAction.getI18nText("i18n_StringUtil.getTableCodeMap.SERVER_PORT_n81i"));
		tableCodeMap.put("CLIENT_PORT", BaseAction.getI18nText("i18n_StringUtil.getTableCodeMap.CLIENT_PORT_n81i"));
		tableCodeMap.put("PROXY", BaseAction.getI18nText("i18n_StringUtil.getTableCodeMap.PROXY_n81i"));
		tableCodeMap.put("USER", BaseAction.getI18nText("i18n_StringUtil.getTableCodeMap.USER_n81i"));
		tableCodeMap.put("PASS", BaseAction.getI18nText("i18n_StringUtil.getTableCodeMap.PASS_n81i"));
		tableCodeMap.put("URL", BaseAction.getI18nText("i18n_StringUtil.getTableCodeMap.URL_n81i"));
		tableCodeMap.put("FROM", BaseAction.getI18nText("i18n_StringUtil.getTableCodeMap.FROM_n81i"));
		tableCodeMap.put("TO", BaseAction.getI18nText("i18n_StringUtil.getTableCodeMap.TO_n81i"));
		tableCodeMap.put("SUBJECT", BaseAction.getI18nText("i18n_StringUtil.getTableCodeMap.SUBJECT_n81i"));
		tableCodeMap.put("CALLER", BaseAction.getI18nText("i18n_StringUtil.getTableCodeMap.CALLER_n81i"));
		tableCodeMap.put("CALLEE", BaseAction.getI18nText("i18n_StringUtil.getTableCodeMap.CALLEE_n81i"));
		tableCodeMap.put("IPP_ENCODING", BaseAction.getI18nText("i18n_StringUtil.getTableCodeMap.IPP_ENCODING_n81i"));
		tableCodeMap.put("IPP_DATATYPE", BaseAction.getI18nText("i18n_StringUtil.getTableCodeMap.IPP_DATATYPE_n81i"));
		tableCodeMap.put("IPP_RECOG_RESULT", BaseAction.getI18nText("i18n_StringUtil.getTableCodeMap.IPP_RECOG_RESULT_n81i"));
		tableCodeMap.put("SMS_SRC_CENTER", BaseAction.getI18nText("i18n_StringUtil.getTableCodeMap.SMS_SRC_CENTER_n81i"));
		tableCodeMap.put("SMS_DST_CENTER", BaseAction.getI18nText("i18n_StringUtil.getTableCodeMap.SMS_DST_CENTER_n81i"));
		tableCodeMap.put("count", BaseAction.getI18nText("i18n_StringUtil.getTableCodeMap.count_n81i"));
		
		return tableCodeMap;
	}

	//过滤结果文件名
	public static List<String> splitResultFileString(String splitString){
		List list  = new ArrayList();
		if(objectIsNUll(splitString)){
			return null;
		}
		String[] splitArrays =splitString.split(",");
		
		for(String str:splitArrays){
			//String[] file = str.split(":");
			list.add(str);
			
		}
		return list;
	}
	
	//过滤时间为文件路径
	public static String splitRevTimeToFilePath(String splitString){
		StringBuilder filePath = new StringBuilder();
		if(objectIsNUll(splitString)){
			return null;
		}
		String[] splitArrays =splitString.split(" ");
		filePath.append(splitArrays[0]);
		String[] timeArray = splitArrays[1].split(":");
		for(String time :timeArray){
			filePath.append("/").append(time);
		}
		
		
		return filePath.toString();
	}
	/**
	 * 获取字符串的长度，如果有中文，则每个中文字符记为2个长度
	 * @param value 指定字符串
	 * @return 		指定字符串长度
	 */
	public static int chineseLength(String value){
		int valueLen = 0;
		String  chinese = "[\u0391-\uFFE5]";
		/* 获取字段值的长度，如果含有中文字符，则每个中文字符按2个长度，否则为1*/
		for(int i = 0; i < value.length(); i++ ){
			//获取一个字符
			String temp = value.substring(i , i + 1);
			//判断是否为中文字符
			if(temp.matches(chinese)){
				//中文字符长度为2
				valueLen += 2;
			}else{
				//其他字符长度为1
				valueLen += 1;
			}
		}
		return valueLen;
	}
	
	/**
	 * 获取字符串的指定长度内容，如果有中文，则每个中文字符记为2个长度。
	 * 如果开始和截取长度碰到半个汉字时：截取开始位置顺序往后推一个长度；截取字符串长度顺序往前一个长度；以保证汉字完整
	 * @param value 	指定字符串
	 * @param getLength 截取开始位置
	 * @param getLength 截取字符串长度
	 * @return 			截取字符串长度
	 */
	public static String getChineseByLength(String value,int startPosion,int getLength){
		String retStr = "";
		int valueLen = 0;
		int retLen = 0;
		if(getLength<1){
			return retStr;
		}
		String  chinese = "[\u0391-\uFFE5]";
		/* 获取字段值的长度，如果含有中文字符，则每个中文字符按2个长度，否则为1*/
		for(int i = 0; i < value.length(); i++ ){
			//获取一个字符
			String temp = value.substring(i , i + 1);
			//判断是否为中文字符
			if(temp.matches(chinese)){
				//中文字符长度为2
				valueLen += 2;
				if(valueLen > startPosion+1){
					if(retLen < getLength-1){
						retStr +=temp;
					}
					retLen += 2;
					//retLen += StringUtil.chineseLength(retStr);
				}
			}else{
				//其他字符长度为1
				valueLen += 1;

				if(valueLen >= startPosion){
					if(retLen <= getLength){
						retStr +=temp;
					}
					retLen += 1;
					//retLen += StringUtil.chineseLength(retStr);
				}
			}
		}
		return retStr;
	}
	
	/**
     * 将map中的key所对应的值用linkSymbol拼接,并在每个值的两边加mark，如'a','d','v'
     * @param strGroup
     * @param linkSymbol
     * @param mark:添加到每一个值两边的，如单引号
     * @return
     */
	public static String linkToString(String[] strGroup,String linkSymbol,String mark) {
		
		StringBuffer str = new StringBuffer();
		String linkedStr = "";
		for(String strTmp:strGroup) {
			if(StringUtils.isNotBlank(strTmp)) {
				str.append(mark).append(strTmp).append(mark).append(linkSymbol);
			}
		}
		if(str.toString().contains(linkSymbol)) {
			linkedStr = str.substring(0, str.length()-linkSymbol.length());
		}
		
		System.out.println("连接后的字符串：" + linkedStr);
		return linkedStr;
	}
	
	/**  
     * 判断是否是一个中文汉字  
     *   
     * @param c  
     *            字符  
     * @return true表示是中文汉字，false表示是英文字母  
     * @throws UnsupportedEncodingException  
     *             使用了JAVA不支持的编码格式  
     */  
    public static boolean isChineseChar(char c){   
        // 如果字节数大于1，是汉字   
        // 以这种方式区别英文字母和中文汉字并不是十分严谨，但在这个题目中，这样判断已经足够了   
        try {
		   return String.valueOf(c).getBytes("GBK").length > 1;
		} catch (Exception e) {
		   e.printStackTrace();
		   return false;
		}   
    }   
  
    /**  
     * 按字节截取字符串  
     *   
     * @param orignal  
     *            原始字符串  
     * @param count  
     *            截取位数  
     * @return 截取后的字符串  
     * @throws UnsupportedEncodingException  
     *             使用了JAVA不支持的编码格式  
     */  
    public static String substring(String orignal, int count) { 
        // 原始字符不为null，也不是空字符串   
        if (null != orignal && !"".equals(orignal)) {
            // 将原始字符串转换为GBK编码格式   
            try {
			    orignal = new String(orignal.getBytes("GBK"), "GBK");
			    if (count >= 0 && count < orignal.getBytes("GBK").length) {  
	                 StringBuffer buff = new StringBuffer();   
	                 char c;   
	                 int subByteNum = 0;
	                 for (int i = 0;subByteNum<count; i++) {
                    	  c = orignal.charAt(i);//每次取一个字符：中文2个字节，字符1个字节
                    	  if (isChineseChar(c)) {   
 	                         // 遇到中文汉字，截取字节总数减2
                    		  subByteNum = subByteNum + 2;   // 一般汉字在utf-8中为3个字节长度
 	                      }else {
 	                    	  subByteNum = subByteNum + 1;
 	                      }
                    	  if(subByteNum<=count) {
                    		  buff.append(c);
                    	  }
	                 }   
	                 return buff.toString(); 
			     }   
			 } catch (Exception e) {
			    e.printStackTrace();
			 }   
			            // 要截取的字节数大于0，且小于原始字符串的字节数   
		 }   
		 return orignal;   
	}
    
}
