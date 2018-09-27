package nis.nms.bean;

import java.text.SimpleDateFormat;

import com.zhtelecom.common.snmp.mib.MibSystem;

public class SwitchInfo extends MibSystem{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2180134682630033989L;
	
	private SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private Long detectionInfoId;
	private Long checkedTime;
	private String checkedTimeStr;
	private Long arrivedTime;
	private String arrivedTimeStr;
	private String upTimeStr0;
	private String upTimeStr;
	public Long getDetectionInfoId() {
		return detectionInfoId;
	}
	public void setDetectionInfoId(Long detectionInfoId) {
		this.detectionInfoId = detectionInfoId;
	}
	public Long getCheckedTime() {
		return checkedTime;
	}
	public void setCheckedTime(Long checkedTime) {
		this.checkedTime = checkedTime;
		this.checkedTimeStr = format.format(checkedTime);
	}

	public Long getArrivedTime() {
		return arrivedTime;
	}
	public void setArrivedTime(Long arrivedTime) {
		this.arrivedTime = arrivedTime;
		this.arrivedTimeStr = format.format(arrivedTime);
	}
	public String getCheckedTimeStr() {
		return checkedTimeStr;
	}
	
	public String getArrivedTimeStr() {
		return arrivedTimeStr;
	}
	public String getUpTimeStr() {
		long time = super.getSysUpTime();
		if(time==0){
			return upTimeStr0;
		}
		String timeStr = "";
		
		timeStr = "."+((time%1000)/10);		//毫秒
		time = time/1000;
		timeStr= ":"+(time%60)+timeStr;		//秒
		time = time/60;
		timeStr= ":"+(time%60)+timeStr;		//分钟
		time = time/60;
		timeStr= " days, "+(time%24)+timeStr;		//小时
		time = time/24;
		timeStr= time+timeStr;	//天
		upTimeStr = timeStr;
		return upTimeStr;
	}
	public String getUpTimeStr0() {
		return upTimeStr0;
	}
	public void setUpTimeStr0(String upTimeStr0) {
		this.upTimeStr0 = upTimeStr0;
	}
}
