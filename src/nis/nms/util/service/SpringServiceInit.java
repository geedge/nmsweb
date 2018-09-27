package nis.nms.util.service;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;

import nis.nms.util.ConfigUpdate;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

/*
 * 系统启动时初始化spring服务
 */
public class SpringServiceInit extends HttpServlet {

	public void init() {
		//参数更新
		ConfigUpdate.getInstance();
		WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());
		ServiceUtil.setApplicatonContext(wac);
		
		ServletContext servletContext = super.getServletContext();
	}
}
