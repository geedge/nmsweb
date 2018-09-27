package com.nms.thread.socket;
import java.io.File;
import java.util.List;

import javax.net.ssl.SSLSocket;
import javax.net.ssl.SSLSocketFactory;

import com.nms.thread.utils.ssl.SocketUtils;

import nis.nms.util.BaseAction;
import nis.nms.util.ExceptionPrintUtils;

/**
 * 安全通讯的客户端
 */

public class SocketClientServeice extends SocketUtils {

	public SocketClientServeice(String ip)throws Exception {
		super(ip,Integer.parseInt(BaseAction.rb.getString("common.single.socket.port")));
	}
	public SocketClientServeice(String ip, int port)throws Exception {
		super(ip, port);
	}

	/**
	 * 创建通讯
	 * 
	 * @time Feb 29, 2012-5:39:01 PM
	 */
	private void init() throws Exception {
		logger.debug("目标通讯:>" + ip + " 创建开始" );
		try {

			// -- create SocketFactory
			SSLSocketFactory ssf = sSLContext.getSocketFactory();

			// -- create socket
			socket = (SSLSocket) ssf.createSocket(ip, port);
			this.in = socket.getInputStream();
			this.out = socket.getOutputStream();
			logger.debug("create socket success.");
			
			//2014-1-23 hyx 如果建立socket成功，但是startHandshake握手失败，且未设置超时时间时，则会一直阻塞
			socket.setSoTimeout(1000*1000);	//1000秒

			// -- handshake 握手
			((SSLSocket) socket).startHandshake();
			logger.debug("handshake success.");

		} catch (Exception e) {

			logger.warn("Target communication:>" + ip + " create failure" + ExceptionPrintUtils.printExceptionStack(e));
			throw e;
		}
	}
	
	public void sendInfoToServer(String cmd,String str) throws Exception{
		try {logger.debug("sendInfoToServer begin："+str );
			init();
			sendMessage(cmd);
			receiveMessage();
			sendMessage(str);
			receiveMessage();
			logger.debug("sendInfoToServer end："+str );
//		} catch (Exception e) {
//			logger.debug("sendInfoToServer 异常："+str );
//			throw e;
		} finally {
			close();
		}
	}
	public String sendInfoToServer2(String cmd,String str) throws Exception{
		try {logger.debug("sendInfoToServer begin："+str );
			init();
			sendMessage(cmd);
			receiveMessage();
			sendMessage(str);
			String result = receiveMessage();
			sendMessage(SUCCESS);
			logger.debug("sendInfoToServer end："+str );
			return result;
//		} catch (Exception e) {
//			logger.debug("sendInfoToServer 异常："+str );
//			throw e;
		} finally {
			close();
		}
	}
	
	public String sendFilesToServer(String cmd, List<File> files) throws Exception {
		try {
			logger.debug("sendFilesToServer begin");
			init();
			sendMessage(cmd);
			receiveMessage();
			this.bpSendFileByBath(files, files.get(0).getParent());
			String result = receiveMessage();
			sendMessage(SUCCESS);
			logger.debug("sendFilesToServer end");
			return result;
		} finally {
			close();
		}
	}
}