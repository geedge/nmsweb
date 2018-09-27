package nis.nms.util;

import java.math.BigDecimal;
import java.math.RoundingMode;

public class MyNumberFormat {
	
	public static String formatStr1(BigDecimal bd) {
		
		if(bd==null){
			return "";
		}
		
		int fix = 0;
		String fixStr = "bps";
		BigDecimal bd0 = bd.multiply(new BigDecimal(1));
		while (bd0.divide(new BigDecimal(1000)).doubleValue()>=1d) {
			fix++;
			bd0 = bd0.divide(new BigDecimal(1000),2, RoundingMode.HALF_UP);
			if(fix>1)break;
		}
		
		bd0 = bd0.setScale(0, RoundingMode.UP);
		
		switch (fix) {
		case 0:
			fixStr="bps";
			break;
		case 1:
			fixStr="Kbps";
			break;
		case 2:
			fixStr="Mbps";
			break;
//		case 3:
//			fixStr="Gbps";
//			break;
//		case 4:
//			fixStr="Tbps";
//			break;
		default:
			fixStr="Mbps";
			break;
		}
		return bd0.longValue()+fixStr;
	} 
	
	/**
	 * 端口流量大数字类型数据 进位格式化
	 * @time Apr 19, 2013-10:41:25 AM
	 * @param bd	需要进位处理的大数字类型数据
	 * @param fix0	进位起始单位
	 * 		[0:bps][1:Kbps][2:Mbps][3:Gbps][4:Tbps][default:Tbps]
	 * @param carry0	进位制值
	 * 			1000（千）进制 或 1024进制
	 * @return
	 */
	public static String formatStr1(BigDecimal bd,int fix0, int carry0) {
		
		if(bd==null){
			return "";
		}
		
		int carry = carry0 > 0 ? carry0 : 1000;
		int fix = fix0 > 0 ? fix0 : 0;
		String fixStr = "bps";
		BigDecimal bd0 = bd.multiply(new BigDecimal(1));
		while (bd0.divide(new BigDecimal(carry)).doubleValue()>=1d) {
			fix++;
			bd0 = bd0.divide(new BigDecimal(carry),2, RoundingMode.HALF_UP);
			if(fix>1)break;
		}
		
		bd0 = bd0.setScale(0, RoundingMode.UP);
		
		switch (fix) {
		case 0:
			fixStr="bps";
			break;
		case 1:
			fixStr="Kbps";
			break;
		case 2:
			fixStr="Mbps";
			break;
//		case 3:
//			fixStr="Gbps";
//			break;
//		case 4:
//			fixStr="Tbps";
//			break;
		default:
			fixStr="Mbps";
			break;
		}
		return bd0.longValue()+fixStr;
	}
	
	/**
	 * 端口流量大数字类型数据 进位格式化
	 * @time Apr 19, 2013-10:41:25 AM
	 * @param bd	需要进位处理的大数字类型数据
	 * @param fix0	进位起始单位
	 * 		[0:bps][1:Kbps][2:Mbps][3:Gbps][4:Tbps][default:Tbps]
	 * @param carry0	进位制值
	 * 			1000（千）进制 或 1024进制
	 * @return
	 */
	public static double formatDecimal(BigDecimal bd,int carry0) {
		
		if(bd==null){
			return 0d;
		}
		
		int carry = carry0 > 0 ? carry0 : 1000;
		int fix = 0;
		String fixStr = "bps";
		BigDecimal bd0 = bd.multiply(new BigDecimal(1));
		while (bd0.divide(new BigDecimal(carry)).doubleValue()>=1d) {
			fix++;
			bd0 = bd0.divide(new BigDecimal(carry),2, RoundingMode.HALF_UP);
			if(fix>1)break;
		}
		
		bd0 = bd0.setScale(0, RoundingMode.UP);
		
		switch (fix) {
		case 0:
			fixStr="bps";
			break;
		case 1:
			fixStr="Kbps";
			break;
		case 2:
			fixStr="Mbps";
			break;
//		case 3:
//			fixStr="Gbps";
//			break;
//		case 4:
//			fixStr="Tbps";
//			break;
		default:
			fixStr="Mbps";
			break;
		}
		return bd0.doubleValue();
	}
	
	/**
	 * @time Apr 18, 2013-8:14:13 PM
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
