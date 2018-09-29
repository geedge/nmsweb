package nis.nms.web.actions.authentication;

import java.io.IOException;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.Enumeration;
import java.util.ResourceBundle;

import com.nis.util.StringUtil;

import net.sf.json.JSONObject;
import nis.nms.util.BaseAction;
import nis.nms.util.MD5;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class IdentificatAction extends BaseAction {
	
	private static final long serialVersionUID = -5399695444475961856L;
	public static ResourceBundle  rb = ResourceBundle.getBundle("myconfig");
	private final String TARGET_SYSTEM_URL=rb.getString("system.url");
	private final String splitStr="@#@";
	private String action;
	private String token;
	@Override
	public String executeAction() throws Exception {
		if("toTargetSys".equals(action)){
			String ip = this.getRequest().getParameter("addr");
			
			Long userId = (Long) this.getRequest().getSession().getAttribute("loginYhid");//获取用户id md5 加密 作为token 
			MD5 md5=new MD5();
			String token = md5.getMD5Code(userId.toString()+System.currentTimeMillis());
			String user=rb.getString("target.system.user");
			String pwd=rb.getString("target.system.pwd");
			BASE64Encoder encoder=new BASE64Encoder();
			String encode = encoder.encode((user+splitStr+pwd).getBytes());
			this.getRequest().getSession().setAttribute(token, encode);
			

			
			StringBuilder sb=new StringBuilder();
			sb.append(TARGET_SYSTEM_URL+"?token="+token);

			sb.append("&ip="+ip);
			
			System.out.println("grafana addr : "+sb.toString());
			this.getResponse().sendRedirect(sb.toString());
		}
		System.err.println("Identificat="+action);
		if("identification".equals(action)){
			String tokenVal = (String) this.getRequest().getSession().getAttribute(token);
			this.getRequest().getSession().removeAttribute(token);
			if(!StringUtil.isBlank(tokenVal)){
				try {
					JSONObject jsonObj=new JSONObject();
					jsonObj.put("jsondata", tokenVal);
					System.out.println("jsonObj:"+jsonObj.toString());
					String jsonpCallback="jsonpCallback("+jsonObj.toString()+")";
					this.getResponse().getWriter().write(jsonpCallback);
				} catch (IOException e) {
					
					e.printStackTrace();
				}	
			}
		}
		return null;
	}
	
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	
}
