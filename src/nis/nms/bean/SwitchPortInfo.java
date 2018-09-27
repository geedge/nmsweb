package nis.nms.bean;

import java.text.SimpleDateFormat;

import com.zhtelecom.common.snmp.mib.MibIfEntry;

public class SwitchPortInfo extends MibIfEntry{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1046618873706963324L;
	
	private SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private Double ifInOctetsSpeed;
	private Double ifOutOctetsSpeed;
	private String ifInOctetsSpeedStr;//包含单位
	private String ifOutOctetsSpeedStr;//包含单位
	
	private Double ifInOctetsSpeedM;
	private Double ifOutOctetsSpeedM;
	
	private Double ifInErrorsScale;
	private Double ifOutErrorsScale;
	
	private Double outpktsspeed;
	private Double inpktsspeed;
	private Double ifoutdiscardsperc;
	private Double ifindiscardsperc;
	
	
//	private Double ifindiscardsVary;//输入丢包数
//	private Double ifoutdiscardsVary;//输出丢包数
//	private Double ifinerrorsVary;//输入差错数
//	private Double ifouterrorsVary;//输出差错数
	
	private Long ifindiscardsVary;//输入丢包数
	private Long ifoutdiscardsVary;//输出丢包数
	private Long ifinerrorsVary;//输入差错数
	private Long ifouterrorsVary;//输出差错数
	
	
	private Long lastLongTime;
	private String lastStringTime;
	
	private String ifLastChangeStr;
	private String ifTypeStr;
	private String ifSpeedStr;
	private Long ifHighSpeed;//输出差错数
	private String speedStr;//包含单位
	
	
	public String getIfTypeStr()
	{
		return ifTypeStr;
	}

	
	public void setIfTypeStr(String ifTypeStr)
	{
		this.ifTypeStr = ifTypeStr;
	}

	public Long getLastLongTime() {
		return lastLongTime;
	}
	
	public void setLastLongTime(Long lastLongTime) {
		this.lastLongTime = lastLongTime;
		lastStringTime = format.format(lastLongTime);
	}

	public String getLastStringTime() {
		return lastStringTime;
	}
	public void setLastStringTime(String lastStringTime) {
		this.lastStringTime = lastStringTime;
	}
	
	public Double getIfInOctetsSpeed() {
		return ifInOctetsSpeed;
	}
	public void setIfInOctetsSpeed(Double ifInOctetsSpeed) {
		this.ifInOctetsSpeed = ifInOctetsSpeed;
	}
	public Double getIfOutOctetsSpeed() {
		return ifOutOctetsSpeed;
	}
	public void setIfOutOctetsSpeed(Double ifOutOctetsSpeed) {
		this.ifOutOctetsSpeed = ifOutOctetsSpeed;
	}

	public Double getIfInErrorsScale() {
		return ifInErrorsScale;
	}

	public void setIfInErrorsScale(Double ifInErrorsScale) {
		this.ifInErrorsScale = ifInErrorsScale;
	}

	public Double getIfOutErrorsScale() {
		return ifOutErrorsScale;
	}

	public void setIfOutErrorsScale(Double ifOutErrorsScale) {
		this.ifOutErrorsScale = ifOutErrorsScale;
	}

	public Double getOutpktsspeed() {
		return outpktsspeed;
	}

	public void setOutpktsspeed(Double outpktsspeed) {
		this.outpktsspeed = outpktsspeed;
	}

	public Double getInpktsspeed() {
		return inpktsspeed;
	}

	public void setInpktsspeed(Double inpktsspeed) {
		this.inpktsspeed = inpktsspeed;
	}

	public Double getIfoutdiscardsperc() {
		return ifoutdiscardsperc;
	}

	public void setIfoutdiscardsperc(Double ifoutdiscardsperc) {
		this.ifoutdiscardsperc = ifoutdiscardsperc;
	}

	public Double getIfindiscardsperc() {
		return ifindiscardsperc;
	}

	public void setIfindiscardsperc(Double ifindiscardsperc) {
		this.ifindiscardsperc = ifindiscardsperc;
	}

	
	public String getIfLastChangeStr()
	{
		return ifLastChangeStr;
	}

	
	public void setIfLastChangeStr(String ifLastChangeStr)
	{
		this.ifLastChangeStr = ifLastChangeStr;
	}

	
	public Long getIfindiscardsVary()
	{
		return ifindiscardsVary;
	}

	
	public void setIfindiscardsVary(Long ifindiscardsVary)
	{
		this.ifindiscardsVary = ifindiscardsVary;
	}

	
	public Long getIfoutdiscardsVary()
	{
		return ifoutdiscardsVary;
	}

	
	public void setIfoutdiscardsVary(Long ifoutdiscardsVary)
	{
		this.ifoutdiscardsVary = ifoutdiscardsVary;
	}

	
	public Long getIfinerrorsVary()
	{
		return ifinerrorsVary;
	}

	
	public void setIfinerrorsVary(Long ifinerrorsVary)
	{
		this.ifinerrorsVary = ifinerrorsVary;
	}

	
	public Long getIfouterrorsVary()
	{
		return ifouterrorsVary;
	}

	
	public void setIfouterrorsVary(Long ifouterrorsVary)
	{
		this.ifouterrorsVary = ifouterrorsVary;
	}


	
	public String getIfSpeedStr()
	{
		return ifSpeedStr;
	}


	
	public void setIfSpeedStr(String ifSpeedStr)
	{
		this.ifSpeedStr = ifSpeedStr;
	}


	
	public Double getIfInOctetsSpeedM()
	{
		return ifInOctetsSpeedM;
	}


	
	public void setIfInOctetsSpeedM(Double ifInOctetsSpeedM)
	{
		this.ifInOctetsSpeedM = ifInOctetsSpeedM;
	}


	
	public Double getIfOutOctetsSpeedM()
	{
		return ifOutOctetsSpeedM;
	}


	
	public void setIfOutOctetsSpeedM(Double ifOutOctetsSpeedM)
	{
		this.ifOutOctetsSpeedM = ifOutOctetsSpeedM;
	}

	public Long getIfHighSpeed() {
		return ifHighSpeed;
	}


	public void setIfHighSpeed(Long ifHighSpeed) {
		this.ifHighSpeed = ifHighSpeed;
	}


	
	public String getIfInOctetsSpeedStr()
	{
		return ifInOctetsSpeedStr;
	}


	
	public void setIfInOctetsSpeedStr(String ifInOctetsSpeedStr)
	{
		this.ifInOctetsSpeedStr = ifInOctetsSpeedStr;
	}


	
	public String getIfOutOctetsSpeedStr()
	{
		return ifOutOctetsSpeedStr;
	}


	
	public void setIfOutOctetsSpeedStr(String ifOutOctetsSpeedStr)
	{
		this.ifOutOctetsSpeedStr = ifOutOctetsSpeedStr;
	}


	
	public String getSpeedStr()
	{
		return speedStr;
	}


	
	public void setSpeedStr(String speedStr)
	{
		this.speedStr = speedStr;
	}

	
//	public Double getIfindiscardsVary()
//	{
//		return ifindiscardsVary;
//	}
//
//	
//	public void setIfindiscardsVary(Double ifindiscardsVary)
//	{
//		this.ifindiscardsVary = ifindiscardsVary;
//	}
//
//	
//	public Double getIfoutdiscardsVary()
//	{
//		return ifoutdiscardsVary;
//	}
//
//	
//	public void setIfoutdiscardsVary(Double ifoutdiscardsVary)
//	{
//		this.ifoutdiscardsVary = ifoutdiscardsVary;
//	}
//
//	
//	public Double getIfinerrorsVary()
//	{
//		return ifinerrorsVary;
//	}
//
//	
//	public void setIfinerrorsVary(Double ifinerrorsVary)
//	{
//		this.ifinerrorsVary = ifinerrorsVary;
//	}
//
//	
//	public Double getIfouterrorsVary()
//	{
//		return ifouterrorsVary;
//	}
//
//	
//	public void setIfouterrorsVary(Double ifouterrorsVary)
//	{
//		this.ifouterrorsVary = ifouterrorsVary;
//	}

	
	
}
