package nis.nms.util;

import java.io.IOException;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.Enumeration;

public class LocalAddress {

	public static String getRealIp()  throws SocketException{
		String localip = null;// 本地IP，如果没有配置外网IP则返回它
		String netip = null;// 外网IP
			Enumeration<NetworkInterface> netInterfaces = NetworkInterface
					.getNetworkInterfaces();
			InetAddress ip = null;
			boolean finded = false;// 是否找到外网IP
			while (netInterfaces.hasMoreElements() && !finded) {
				NetworkInterface ni = netInterfaces.nextElement();
				Enumeration<InetAddress> address = ni.getInetAddresses();
				while (address.hasMoreElements()) {
					ip = address.nextElement();
					if (!ip.isSiteLocalAddress() && !ip.isLoopbackAddress()
							&& ip.getHostAddress().indexOf(":") == -1) {
						netip = ip.getHostAddress();
						finded = true;
						break;
					} else if (ip.isSiteLocalAddress()
							&& !ip.isLoopbackAddress()
							&& ip.getHostAddress().indexOf(":") == -1) {
						localip = ip.getHostAddress();
					}
				}
			}
//		System.out.println("IP们  "+netip+"   <--->   "+localip);
		if (netip != null && !"".equals(netip)) {
			return netip;
		} else {
			return localip;
		}
	}
	/**
	 * 获得本机IP
	 */
	public static String getLocalIp() throws Exception {
		String nativeip = "";
		//根据操作系统确定获取进程ID的方式
		String os = System.getProperty("os.name");
		if (os.startsWith("Windows")) {
			InetAddress ipv4 = InetAddress.getLocalHost();
			nativeip = ipv4.getHostAddress().toString();
		} else if (os.startsWith("Linux")) {
			InetAddress ip = null;
			boolean findIp = false;
			// 根据网卡取本机配置的IP
			Enumeration<NetworkInterface> netInterfaces = NetworkInterface
					.getNetworkInterfaces();
			while (netInterfaces.hasMoreElements()) {
				if (findIp) {
					break;
				}
				NetworkInterface ni = netInterfaces.nextElement();
				Enumeration<InetAddress> ips = ni.getInetAddresses();
				while (ips.hasMoreElements())
					ip = ips.nextElement();
				if (ip.isSiteLocalAddress() && !ip.isLoopbackAddress()
						&& ip.getHostAddress().indexOf(":") == -1) {
					findIp = true;
					break;
				}
			}
			if (ip != null) {
				nativeip = ip.getHostAddress();
			}
		} else {
			throw new IOException("unknown operating system: " + os);
		}

		return nativeip;
	}
	
	public static void main(String [] args) {
		try {
			try {
				System.out.println(LocalAddress.getLocalIp());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
