package com.nms.servlet.auto.run;

import java.io.File;
import java.io.IOException;
import java.net.Socket;

import javax.net.ssl.SSLServerSocket;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpServlet;

import nis.nms.util.BaseAction;
import nis.nms.util.Constant;
import nis.nms.util.DateUtil;

import org.apache.log4j.Logger;

import com.nis.util.StringUtil;
import com.nms.thread.NmsPortThread;
import com.nms.thread.NmsRuleThread;
import com.nms.thread.NmsStatusThread;
import com.nms.thread.common.ThreadPoolCommon;
import com.nms.thread.socket.SSLServer;
import com.nms.thread.utils.ssl.SocketUtils;

import java.text.ParseException;
import java.util.Date;
import java.util.concurrent.TimeUnit;

/**
 *  NMSWeb启动时
 *  启动指定监听端口，用于SSL通讯服务
 *  @date Mar 15, 2012 9:31:54 AM
 *	@author ZhangGang
 *
 */
public class AutoRunForSocketServerServlet extends HttpServlet implements ServletContextListener{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5912472395977662214L;
	private Logger logger = Logger.getLogger(AutoRunForSocketServerServlet.class);
	private SSLServerSocket sslServer ;

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		try {
			//关闭通讯服务
			if(sslServer != null ){sslServer.close();sslServer = null;}
			
			//关闭线程池
			if(!ThreadPoolCommon.service.isShutdown()){
				ThreadPoolCommon.service.shutdown();
			}
			
			//关闭定时线程池
			if(!ThreadPoolCommon.scheduled.isShutdown()){
				ThreadPoolCommon.scheduled.shutdown();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		System.out.println(BaseAction.rb.getString("common.ssl.socket.port")+"端口>>SSL通讯监听 已关闭");
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		//-- 初始化参数
		String uploadPath = new String(BaseAction.rb.getString("uploadServerPath"));
		if(!uploadPath.endsWith("\\") && !uploadPath.endsWith("/")){
			uploadPath +=File.separator;
		}
		
		String snmpDir = new String(BaseAction.rb.getString("snmpDir"));
		System.out.println("uploadPath "+uploadPath);
		System.out.println("snmpDir "+snmpDir);
		if(!snmpDir.endsWith("\\") && !snmpDir.endsWith("/")){
			snmpDir +=File.separator;
		}
		
		final Integer port = Integer.parseInt(BaseAction.rb.getString("common.ssl.socket.port"));
		final String upPath = uploadPath;
		final String snmpPath = snmpDir;
		//-- 创建线程池
		ThreadPoolCommon.service.submit(new Runnable(){
			
			public void run() {
				Thread.currentThread().setName("SSL Communication");
				try {  
					sslServer = (SSLServerSocket) SocketUtils.getSSLContext().getServerSocketFactory().createServerSocket(port);
					sslServer.setNeedClientAuth(true);		//客户端是否需要认证
					logger.info("启动 OK");
					while(true){
						Socket socket= sslServer.accept();
						ThreadPoolCommon.service.submit(new SSLServer(socket,upPath,snmpPath));
					}
					
				} catch (IOException e) {
					e.printStackTrace();
				}finally{
					try {
						if(sslServer != null ){sslServer.close();sslServer = null;}
					} catch (IOException e) {
						e.printStackTrace();
					}
				}				
			}});
		System.out.println(port+">>SSL通讯监听 已启动");
		
		
		//nms上报
		String intervalStr = BaseAction.rb.getString("nms.report.interval");
		//nms上报间隔
		long interval = StringUtil.isBlank(intervalStr) ? 300000 : Long.parseLong(intervalStr)*1000;
		//nms初次上报延时
		long now = new Date().getTime();
		long initInterval = 0l;
		if(now%interval > 0) {
			initInterval = interval-(now%interval);
		}
		
		ThreadPoolCommon.scheduled.scheduleAtFixedRate(new NmsStatusThread(), initInterval, interval, TimeUnit.MILLISECONDS);
		ThreadPoolCommon.scheduled.scheduleAtFixedRate(new NmsRuleThread(), initInterval, interval, TimeUnit.MILLISECONDS);
		ThreadPoolCommon.scheduled.scheduleAtFixedRate(new NmsPortThread(), initInterval, interval, TimeUnit.MILLISECONDS);
	}
	
}
