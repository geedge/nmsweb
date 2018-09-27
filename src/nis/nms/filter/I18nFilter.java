package nis.nms.filter;

import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import nis.nms.util.Common;

/**
 * i18n国际化filter使用 正则表达式 replace 替换
 * 
 * @author dell
 *
 */
public class I18nFilter implements Filter {
	private static final Logger logger = Logger.getLogger(I18nFilter.class);

	
	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		I18nResponseWrapper rw = new I18nResponseWrapper(response);
		String lang = request.getParameter("i18n_lang");
		Locale locale ;
		if(StringUtils.isNotBlank(lang)){
			String[] split = lang.split("_");
			locale = new Locale(split[0],split[1]);
		}else{
			locale = (Locale)request.getSession().getAttribute("i18n_lang");
			if(locale == null){
				locale = I18n.defaultLang;
			}
		}
		request.getSession().setAttribute("i18n_lang", locale);
		Locale temp = locale;
		chain.doFilter(servletRequest, rw);
		if (rw.isTrans()) {// 字符流输出
			locale = (Locale)request.getSession().getAttribute("i18n_lang");
			if(locale==null){
				locale=temp;
			}
			String content = rw.getContent();
			content = I18n.trans(content, locale);
			// 输出转换后的内容
			response.setContentLength(content.getBytes("utf-8").length);
			ServletOutputStream superOut = rw.getSuperOut();
			superOut.write(content.getBytes("utf-8"));
			superOut.flush();
		}
	}

	/**
	 * i18n 正则替换
	 * 
	 * @param content
	 * @param lang
	 * @return
	 */
	

	@Override
	public void init(FilterConfig config) throws ServletException {
		// 文本 content-type 类型
		I18n.TRANS_CONTENT_TYPE.add("application/xml");
		I18n.TRANS_CONTENT_TYPE.add("application/json");
		String dl = config.getInitParameter("defaultLang");
		String reg = config.getInitParameter("i18nRegex");
		String varSplit = config.getInitParameter("varSplit");//参数分隔符
		String varRegex = config.getInitParameter("varRegex");//参数正则
		if(StringUtils.isNotBlank(dl)){
			String[] split = dl.split("_");
			if(split.length>1){
				I18n.defaultLang = new Locale(split[0],split[1]);
			}else{
				I18n.defaultLang = new Locale(dl);
			}
		}else{
			I18n.defaultLang = new Locale("en","US");
		}
		
		if(StringUtils.isNotBlank(reg)){
			I18n.i18nRegex = Pattern.compile(reg);
		}else{
			I18n.i18nRegex = Pattern.compile("i18n_([\\w\\.]+?)_n81i",Pattern.CASE_INSENSITIVE);//默认正则匹配规则
		}
		
		if(StringUtils.isNotBlank(varSplit)){
			I18n.split = varSplit;
		}
		
		if(StringUtils.isNotBlank(varRegex)){
			I18n.varRegex = Pattern.compile(varRegex,Pattern.CASE_INSENSITIVE);
		}
		// 初始化加载 国际化 资源文件
		String i18nFile = config.getInitParameter("i18nFile");
		String i18nFileCharset = config.getInitParameter("i18nFileCharset");
		logger.debug("i18nFile: " + i18nFile);
		if (StringUtils.isNotBlank(i18nFile)) {
			String parentPath = i18nFile.substring(0, i18nFile.lastIndexOf("/"));
			final String fileStart = i18nFile.substring(i18nFile.lastIndexOf("/")+1);
			if (!i18nFile.trim().startsWith("/")) {// 绝对路径
				ServletContext sc = config.getServletContext();
				String path = sc.getRealPath("/");
				parentPath = path + parentPath;
			}
			File pf = new File(parentPath);
			if (pf.exists() && pf.isDirectory()) {
				File[] listFiles = pf.listFiles(new FileFilter() {
					public boolean accept(File pathname) {
						return pathname.getName().startsWith(fileStart);
					}
				});
				if (listFiles != null) {
					for (File f : listFiles) {
						String filename = f.getName();
						if(filename.indexOf(".")>0){
							filename = filename.substring(0,filename.indexOf("."));
						}
						String[] split = filename.split("_");
						if (split.length > 2) {
							Locale locale = new Locale(split[1], split[2]);
							try {
								Properties prop = I18n.loadProp(f,i18nFileCharset);
								I18n.langDict.put(locale, prop);
							} catch (Exception e) {
								e.printStackTrace();
								logger.error("filename : " + filename, e);
							}
						} else {
							logger.warn("i18n file naming is wrong，" + filename);
						}
					}
				}
			}
		}
	}

	@Override
	public void destroy() {

	}
}
