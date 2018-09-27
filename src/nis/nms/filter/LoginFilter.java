/**
 * 
 */
package nis.nms.filter;

import java.io.IOException;
import java.util.ResourceBundle;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nis.nms.domains.XtYhJbxx;
import nis.nms.util.Constant;

import org.apache.log4j.Logger;

/**
 * @author vivian
 *
 */
public class LoginFilter implements Filter {
	private Logger logger = Logger.getLogger(LoginFilter.class);	
	protected FilterConfig filterConfig;
	
	static ResourceBundle rb = ResourceBundle.getBundle("myconfig");
	public void init(FilterConfig config) throws ServletException {
		filterConfig = config;
	}
	
	public void doFilter(ServletRequest servletRequest,	ServletResponse servletResponse, FilterChain chain)	throws IOException, ServletException {
		//设置字符编码为UTF-8
		servletRequest.setCharacterEncoding("UTF-8");
		servletResponse.setCharacterEncoding("UTF-8");
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		//以下为清除页面缓存信息
		response.setHeader("Cache-Control", "no-store");
		response.setDateHeader("Expires", -1);	
		response.setHeader("Pragma", "no-cache");
		
		//读取配置文件中的信息,如果不要求验证的话则直接跳过验证,否则应进行验证
		if(Boolean.parseBoolean(rb.getString("validate_user")) == false){
			chain.doFilter(servletRequest, servletResponse);
			return;
		} else{
			//进行验证
			String rootPath = request.getContextPath();		// 根路径
			String accessPath = request.getRequestURI();	// 请求路径
			System.out.println("请求路径**** "+ request.getRequestURL()+"?action >> "+(request.getParameterValues("action")!=null?request.getParameterValues("action").length>0?request.getParameterValues("action")[0].toString():null:null));
			
			HttpSession session = request.getSession();
			XtYhJbxx user = (XtYhJbxx)session.getAttribute(Constant.SESSION_CZY_NAME);
			
			//如果session中的用户名非空，则表示已登录，放过请求；如果为空，则需进一步判断
			if(user != null){	
				
				chain.doFilter(servletRequest, servletResponse);
				
			} else {//如果用户名为空，但访问路径正好为根、登录页面、登录判断页，也应放过请求
				//不需要过滤的url列表|| (url !=null &&!"".equals(url))
				if(isInputUrl(rootPath, accessPath) ){					
					chain.doFilter(servletRequest, servletResponse);
				}else{
					//跳转至登录页
					session.invalidate();
					System.out.println("跳转至登录页面");
					session=null;
					response.reset();
					response.sendRedirect(rootPath + "/index.jsp");
				}
			}
		}
	}
	
	
	private boolean isInputUrl(String rootPath, String accessPath){

		//如果用户名为空，但访问路径正好为根、登陆页面、登录判断页，也应放过请求
		if(accessPath.equalsIgnoreCase(rootPath + "/") 
				|| accessPath.equalsIgnoreCase(rootPath + "/index.jsp")
				|| accessPath.equalsIgnoreCase(rootPath + "/login.jsp")
				|| accessPath.equalsIgnoreCase(rootPath + "/login.html")
				|| accessPath.equalsIgnoreCase(rootPath + "/error_500.jsp")
				|| accessPath.equalsIgnoreCase(rootPath + "/error.jsp")
				|| accessPath.equalsIgnoreCase(rootPath + "/login!login.do")
				|| accessPath.equalsIgnoreCase(rootPath + "/sysManage/configureTheDiffusion.do")
		){
			return true;
		}
		return false;
	}
	
	
	
	

	public void destroy() {
		this.filterConfig = null;
	}
}
