package nis.nms.web.actions.sysManage;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.DefaultHttpMethodRetryHandler;
import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.params.HttpClientParams;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;

import com.mchange.v2.sql.filter.SynchronizedFilterCallableStatement;
import com.opensymphony.xwork2.ActionContext;

import nis.nms.domains.XtYhJbxx;
import nis.nms.util.BaseAction;
import nis.nms.util.Constant;
/**
 * httpclient请求其它服务 单点登录
 * @author th
 *
 */

@SuppressWarnings("unchecked")
@Results( { 
	@Result(name="error", value = "/error.jsp"),
})
public class ConfigureTheDiffusionAction extends BaseAction{
	private Logger logger =Logger.getLogger(this.getClass());
	private static Map map=new HashMap();
	private static final long serialVersionUID = 822071111080809529L;
	private final String CONSUL_SYSTEM_URL=rb.getString("consul.system.url");
	private String action;// 系统操作
	@Override
	public String executeAction() throws Exception {
		try {
			if (action.equals("query")) {// 
				queryConfig();
			}else if(action.contains("checkToken")){
				checkTokenInfo();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return null;
	}
	
	//重定向consul服务项目
	public void queryConfig(){
		try {
			HttpServletRequest request = getRequest();
			StringBuilder str=new StringBuilder();
			str.append("http://");
			str.append(getRequest().getServerName());
			str.append(":");
			str.append(getRequest().getServerPort());
			str.append(getRequest().getContextPath());
			str.append("/sysManage/configureTheDiffusion.do?action=checkToken");
			getRequest().getServerPort();
			Locale i18nLang = (Locale) getRequest().getSession().getAttribute("i18n_lang");
			XtYhJbxx user = (XtYhJbxx) getRequest().getSession().getAttribute(Constant.SESSION_CZY_NAME);
			
			//生成验证信息的key值
			String uuid = UUID.randomUUID().toString().replace("-", "").toLowerCase();
			StringBuilder sb=new StringBuilder();
			sb.append(CONSUL_SYSTEM_URL);
			logger.info("request third project path is "+CONSUL_SYSTEM_URL);
			sb.append("?_locale="+i18nLang);
			sb.append("&userName="+user.getYhbh());
			sb.append("&token="+str.toString()+"&uuid="+uuid);
			sb.append("&projectName=nms");
			logger.info("request third project is full path "+sb.toString());
			//存入标记以备验证
			map.put(uuid, "true");
			/*getRequest().getSession().setAttribute("consulToken", "true");*/			
			getResponse().sendRedirect(sb.toString());
		} catch (IOException e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('error');</script>");
		}
	}

	//认证token
	public void checkTokenInfo(){
		String consulToken = getRequest().getParameter("consulToken");
		System.out.println("consulToken-------------------------"+consulToken);
		String object = (String) map.get(consulToken);
		System.out.println("result-------------------------"+object);
		//移除标记
		map.remove(consulToken);
		try {
			getResponse().getWriter().write(object);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}
}
