package nis.nms.util;

import java.util.Vector;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import nis.nms.domains.XtYhJbxx;

public class OnlineListener implements HttpSessionListener {
	private static int activeSessions = 0;
	private static Vector vOnlineUsers= new Vector();
	private static Vector vector= new Vector();
	public void sessionCreated(HttpSessionEvent hse) {

	}
	public static Vector getVector(){
		
		return vector;
	}
	public static Vector getVOnlineUsers() {
		return vOnlineUsers;
	}
	
	/**
	 * session创建时把用户信息加入在线用户列表中
	 * @param se
	 */
	public static void createsession(HttpSessionEvent se ) {
		XtYhJbxx user1 =(XtYhJbxx)se.getSession().getAttribute(Constant.SESSION_CZY_NAME);
		if(vOnlineUsers.contains(user1.getYhid())==false){
			vOnlineUsers.add(user1.getYhid());
			vector.add(user1.getYhid());
			activeSessions++;
//			System.out.println("===================用户名称=================="+user1.getPersonId());
			//System.out.println("===================用户数量=================="+activeSessions);
		}
	}
	/* session销毁时把当前session中的用户从在线用户列表中删除
	 * （注销用户、session过期时调用此方法，应用服务器设置session过期的时间）
	 * (non-Javadoc)
	 * @see javax.servlet.http.HttpSessionListener#sessionDestroyed(javax.servlet.http.HttpSessionEvent)
	 */
	public void sessionDestroyed(HttpSessionEvent hse) {
		XtYhJbxx user2 =(XtYhJbxx)hse.getSession().getAttribute(Constant.SESSION_CZY_NAME);
		String userid = "";
		if(user2 != null) userid=user2.getYhid().toString();
		//System.out.println("清除人员登录信息="+user2);
		if(vOnlineUsers!=null && !vOnlineUsers.isEmpty() && user2!=null){
			if(vOnlineUsers.contains(user2.getYhid())==true){
				vOnlineUsers.remove(user2.getYhid());
				activeSessions--;
				//System.out.println("===================removed=================="+user2.getCnName());
//				XtYhJbxx.LONGIN_USER.remove(user2.getUserId());by vivian delete
			}
		}		
	}
	/**
	 * 将用户于在线用户列表中删除
	 * @param loginname
	 */
	public static void deleteUser(String loginname){
		if(vOnlineUsers!=null && !vOnlineUsers.isEmpty()){
			if(vOnlineUsers.contains(loginname)==true){
				vOnlineUsers.remove(loginname);
				activeSessions--;
			}
		}
	}
	/**
	 * 判断指定用户是否在线
	 * @param userid 用户账号
	 * @return 在线true，否false
	 */
	public static boolean isOnline(String userid){
		boolean isOnline = false;
		if(vOnlineUsers!=null && !vOnlineUsers.isEmpty()){
			if(vOnlineUsers.contains(userid)==true){
				isOnline = true;
			}
		}
		return isOnline;
	}
}
