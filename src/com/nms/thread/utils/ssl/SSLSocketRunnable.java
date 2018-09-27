package com.nms.thread.utils.ssl;

import java.net.Socket;

import javax.net.ssl.SSLSocket;
import javax.net.ssl.SSLSocketFactory;

import nis.nms.util.ExceptionPrintUtils;

import org.apache.commons.lang.StringUtils;

/**
 * 	SSL 通讯 工具类
 *  @date Feb 29, 2012 10:05:50 AM
 *	@author ZhangGang
 *
 */
public abstract class SSLSocketRunnable extends SocketUtils implements Runnable{
	
	
	/**
	 * 通讯成功标识
	 */
	protected static final String SOCKET_SUCCESS_FLAG ="success";		//成功通信
	/**
	 * 通讯失败标识
	 */
	protected static final String SOCKET_FAIL_FLAG ="fail";			//失败通信

    /**
     * 通讯创建
     * @param client	目标通讯实例
	 */
    public SSLSocketRunnable(Socket client) {
    	super(client);
    }
	
	/**
	 * 通讯线程执行方法 默认格式
	 * @return
	 * @throws Exception
	 */
	@Override
	public void run() {
		
		//- 校验 是否创建新通讯连接
		if(socket==null && (StringUtils.isNotEmpty(ip) && port != null)){
			
			try {
				
				//-- create SocketFactory
				SSLSocketFactory ssf = sSLContext.getSocketFactory();
				
				//-- create socket
				socket=(SSLSocket)ssf.createSocket(ip,port);
				logger.debug("create socket success.");
				
				//2014-1-23 hyx 如果建立socket成功，但是startHandshake握手失败，且未设置超时时间时，则会一直阻塞
				socket.setSoTimeout(1000*1000);	//1000秒
				
				//-- handshake 握手
				((SSLSocket) socket).startHandshake();
				logger.debug("handshake success.");
				
			} catch (Exception e) {
				
				logger.warn("Target communication:>"+ip+" create failure"+ExceptionPrintUtils.printExceptionStack(e));
				close();
				return ;
				
			}
		}
		
		//- socket 不为空 执行通讯操作
		if(socket!=null){
			
			try {
				
				//-- 获取通讯IO流
				out = socket.getOutputStream();
				in = socket.getInputStream();
				
				//-- 自定义通讯操作
				toDo();
				
			}catch (Exception e) {
				logger.error(ExceptionPrintUtils.printExceptionStack(e));
			} finally {
				
				logger.info("--- 通信关闭 ---");
				close();
			}
			
		}
		return ;
	}
	
	/**
	 * 待实现的通信操作
	 * @time Aug 28, 2011-9:04:46 PM
	 * @param out
	 * @param in
	 * @throws Exception
	 */

	protected abstract void toDo()throws Exception;
}
