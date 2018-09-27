package com.nms.thread.socket;
import nis.nms.util.BaseAction;

import org.apache.log4j.Logger;

import com.nms.thread.common.ThreadPoolCommon;
import com.nms.thread.pool.ThreadConstants;
import com.nms.thread.utils.ssl.SSLSocketCallable;

/**
 * 安全通讯的客户端
 */

public class SSLClient extends SSLSocketCallable {
	private Logger logger = Logger.getLogger(SSLClient.class);
	private String cmd  = null;
	private String content = null; 
	
	public static final String HAND_SHAKE_DC = "char:handshake";
	public static final String UPDATE_CONFIG_DC = "char:updateConfig";
	public static final String INSERT_DETECT = "char:insertDetect";
	public static final String RELEASE_DETECT = "char:releaseDetect";
	//dc server 端口
	public static final Integer DC_PORT = Integer.parseInt(BaseAction.rb.getString("common.single.socket.port"));
	
	public SSLClient(String ip,String cmd,String content){
		super(ip,Integer.parseInt(BaseAction.rb.getString("common.single.socket.port")));
		this.cmd = cmd;
		this.content = content;
	}
	
	public SSLClient(String ip,int port,String cmd){
		super(ip, port);
		this.cmd = cmd;
	}
	
	public SSLClient(String ip, int port)throws Exception {
		super(ip, port);
	}

	@Override
	protected Object toDo() throws Exception {
//		Thread.currentThread().setName("通信线程 TO:>"+ip);
		Thread.currentThread().setName("Communication Thread TO:>"+ip);
		logger.debug("通讯命令:>"+cmd);
		if(HAND_SHAKE_DC.equals(cmd)){
			/*通讯内容 */
			sendMessage(cmd);
			String str =  receiveMessage();
			return ThreadConstants.HAND_SHAKE_RESULT_SOCKET_SUCCESS;
		}else if(UPDATE_CONFIG_DC.equals(cmd)){
			sendMessage(cmd);
			receiveMessage();
			sendMessage(content);
			receiveMessage();
			return 1;
		}else if(INSERT_DETECT.equalsIgnoreCase(cmd)){
			/**
			 * 通知dc 入库 监测数据
			 */
			sendMessage(cmd);
			String msg = receiveMessage();//当前缓存 监测内容 条数
			Integer size = Integer.valueOf(msg);//-1:dc升级中，0 ：没有监测数据，>0：监测数据条数，-2监测数据上传web -4 dc主动入库 
			return size;
		}else if(RELEASE_DETECT.equalsIgnoreCase(cmd)){
			/**
			 * 通知 dc 取消 入库监测数据
			 */
			sendMessage(cmd);
			String msg = receiveMessage();
			logger.debug(RELEASE_DETECT + " -> " + msg);
		}
		return null;
	}
	
	public static void main(String [] args){
	SSLClient client = new SSLClient("10.0.6.113",HAND_SHAKE_DC,null);
	ThreadPoolCommon.service.submit(client);
	}
}