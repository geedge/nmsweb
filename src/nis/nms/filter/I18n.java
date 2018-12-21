package nis.nms.filter;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;

public class I18n {

	public static Locale defaultLang;// 默认 语言
	public static final Map<Locale, Properties> langDict = new HashMap<Locale, Properties>();
	public static final List<String> TRANS_CONTENT_TYPE = new ArrayList<String>();// 需要转换的															
	public static Pattern i18nRegex;
	public static Pattern varRegex = Pattern.compile("\\{([,\\w]+)\\}");//国际化参数正则
	public static String split = ",";//参数分割符
	
	
	
	/**
	 * 直接根据 i18n_xxx_n81i 替换
	 * @param key i18n_xxx_n81i
	 * @param locale
	 * @param params 替换参数值
	 * @return
	 */
	public static String trans(String content,Locale locale,String ... params){
		Matcher matcher = I18n.i18nRegex.matcher(content);
		Properties dict = I18n.langDict.get(locale);
		StringBuffer sb = new StringBuffer();
		while(matcher.find()){
			String group = matcher.group(1);
			String replacement = null;
			if(dict != null){
				replacement = dict.getProperty(group);
				if(params != null && replacement != null){
					for(int i = 0,j = params.length;i<j;i++){//参数替换
						replacement = replacement.replaceAll("\\{"+i+"\\}", params[i]);
					}
				}
			}
//			System.out.println(" replace : "+ group +" --> " + replacement);
			matcher.appendReplacement(sb, replacement== null ? group : replacement);
		}
		matcher.appendTail(sb);
		return sb.toString();
	}
	
	
	/**
	 * i18n 替换，key 为  i18n_xxx{params,value}_n81i ,xxx 为 i18n 文件中实际的 key ,{params,value} 为value 的变量替换值
	 * 根据index(从0开始) 替换，如 params 替换 {0} ，value 替换 {1}.
	 * 注意：不要有多余空格等无用字符
	 * @param content
	 * @param locale
	 * @return
	 */
	public static String trans(String content, Locale locale) {
		Matcher matcher = I18n.i18nRegex.matcher(content);
		Properties dict = I18n.langDict.get(locale);
		StringBuffer sb = new StringBuffer();
		while(matcher.find()){
			String group = matcher.group(1);
			String key = group;
			Matcher varMatcher = varRegex.matcher(group);
			String[] vars = null;
			if(varMatcher.find()){//key 中包含参数
				String var = varMatcher.group(1);
				vars = var.split(split);//包含的参数
				key = group.substring(0, group.indexOf("{"));//截取实际的 i18n key
			}
			String replacement = null;
			if(dict != null){
				replacement = dict.getProperty(key);
				if(vars != null && replacement != null){
					for(int i = 0,j = vars.length;i<j;i++){//参数替换
						replacement = replacement.replaceAll("\\{"+i+"\\}", vars[i]);
					}
				}
			}
//			System.out.println(" replace : "+ group +" --> " + replacement);
			matcher.appendReplacement(sb, replacement== null ? group : replacement);
		}
		matcher.appendTail(sb);
		return sb.toString();
	}
	
	public static Properties loadProp(File file,String charset) throws FileNotFoundException, IOException{
		Properties pro = new Properties();
		InputStreamReader isr = null;
		try {
			isr = new InputStreamReader(new FileInputStream(file),StringUtils.isBlank(charset)?"UTF-8":charset);
			pro.load(isr);
		} finally {
			if(isr != null){
				try {
					isr.close();
				} catch (Exception e) {
				}
			}
		}
		return pro;
		
	}
	

}
