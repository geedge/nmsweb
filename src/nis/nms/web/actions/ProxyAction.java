package nis.nms.web.actions;

import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;
import org.nutz.http.Header;
import org.nutz.http.Http;
import org.nutz.http.Request;
import org.nutz.http.Request.METHOD;
import org.nutz.http.Response;
import org.nutz.http.Sender;

import nis.nms.util.BaseAction;

@SuppressWarnings("all")
@Results({ 
			@Result(name = "ok", value = "/main.jsp")
		})
public class ProxyAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	
	public String executeAction() throws Exception {
		InputStream is = null;
		try {
			String url = null;
			HttpServletRequest request = this.getRequest();
			Enumeration headerNames = request.getHeaderNames();
			Map<String,String> headerMap = new LinkedHashMap<String,String>();
			for(;headerNames.hasMoreElements();) {
				String element = (String) headerNames.nextElement();
				String value = request.getHeader(element);
				headerMap.put(element,value);
			}
			url = headerMap.get("realurl");
			Map parameterMap = request.getParameterMap();
			Header header = Header.create(headerMap);
			header = null;
			Request req = Request.create(url, getMethod(request.getMethod()), parameterMap, header);
			Response res = Sender.create(req).send();
			is = res.getStream();
			
			HttpServletResponse response = this.getResponse();
			response.setStatus(res.getStatus());
			Header resHeader = res.getHeader();
			Set<Entry<String,String>> all = resHeader.getAll();
			for(Entry<String,String> entry : all) {
				String key = entry.getKey();
				if(key != null) {
					response.setHeader(key, entry.getValue());
				}
			}
			IOUtils.copy(is, response.getOutputStream());
		} finally {
			if(is != null) {
				is.close();
			}
		}
		return null;
	}

	//GET, POST, OPTIONS, PUT, DELETE, TRACE, CONNECT, HEAD
	public static METHOD getMethod(String method) {
		METHOD result = null;
		switch (method.toUpperCase()) {
		case "GET":
			result = METHOD.GET; break;
		case "POST":
			result = METHOD.POST; break;
		case "OPTIONS":
			result = METHOD.OPTIONS; break;
		case "PUT":
			result = METHOD.PUT; break;
		case "DELETE":
			result = METHOD.DELETE; break;
		case "TRACE":
			result = METHOD.TRACE; break;
		case "CONNECT":
			result = METHOD.CONNECT; break;
		case "HEAD":
			result = METHOD.HEAD; break;
		default:
			result = METHOD.GET; break;
		}
		return result;
	}
	
}
