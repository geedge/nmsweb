package nis.nms.bean;

import java.text.SimpleDateFormat;

public class SwitchPortInfoSource{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1046618873706963324L;
	
	private SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private Double ifInOctetsSpeed;
	private Double ifOutOctetsSpeed;
	private Double ifInOctetsSpeedM;
	private Double ifOutOctetsSpeedM;
	
	private Double ifInErrorsScale;
	private Double ifOutErrorsScale;
	
	private Double outpktsspeed;
	private Double inpktsspeed;
	private Double ifoutdiscardsperc;
	private Double ifindiscardsperc;
	
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
	private int data64Flag;		//64位数据标识 1是 0否
	// Field descriptor #6 I
	private int ifIndex;
	  
	// Field descriptor #8 Ljava/lang/String;
	private java.lang.String ifDescr;

	// Field descriptor #6 I
	private int ifType;

	// Field descriptor #6 I
	private int ifMtu;

	// Field descriptor #12 J
	private long ifSpeed;

	// Field descriptor #8 Ljava/lang/String;
	private java.lang.String ifPhysAddress;

	// Field descriptor #6 I
	private int ifAdminStatus;

	// Field descriptor #6 I
	private int ifOperStatus;

	// Field descriptor #12 J
	private long ifLastChange;

	// Field descriptor #12 J
	private Double ifInOctets;

	// Field descriptor #12 J
	private Double ifInUcastPkts;

	// Field descriptor #12 J
	private Double ifInNUcastPkts;

	// Field descriptor #12 J
	private Double ifInDiscards;

	// Field descriptor #12 J
	private Double ifInErrors;

	// Field descriptor #12 J
	private Double ifInUnknownProtos;

	// Field descriptor #12 J
	private Double ifOutOctets;

	// Field descriptor #12 J
	private Double ifOutUcastPkts;

	// Field descriptor #12 J
	private Double ifOutNUcastPkts;

	// Field descriptor #12 J
	private Double ifOutDiscards;

	// Field descriptor #12 J
	private Double ifOutErrors;

	// Field descriptor #12 J
	private Double ifOutQLen;

	// Field descriptor #8 Ljava/lang/String;
	private java.lang.String ifSpecific;
	
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


	public int getIfIndex() {
		return ifIndex;
	}


	public void setIfIndex(int ifIndex) {
		this.ifIndex = ifIndex;
	}


	public java.lang.String getIfDescr() {
		return ifDescr;
	}


	public void setIfDescr(java.lang.String ifDescr) {
		this.ifDescr = ifDescr;
	}


	public int getIfType() {
		return ifType;
	}


	public void setIfType(int ifType) {
		this.ifType = ifType;
	}


	public int getIfMtu() {
		return ifMtu;
	}


	public void setIfMtu(int ifMtu) {
		this.ifMtu = ifMtu;
	}


	public long getIfSpeed() {
		return ifSpeed;
	}


	public void setIfSpeed(long ifSpeed) {
		this.ifSpeed = ifSpeed;
	}


	public java.lang.String getIfPhysAddress() {
		return ifPhysAddress;
	}


	public void setIfPhysAddress(java.lang.String ifPhysAddress) {
		this.ifPhysAddress = ifPhysAddress;
	}


	public int getIfAdminStatus() {
		return ifAdminStatus;
	}


	public void setIfAdminStatus(int ifAdminStatus) {
		this.ifAdminStatus = ifAdminStatus;
	}


	public int getIfOperStatus() {
		return ifOperStatus;
	}


	public void setIfOperStatus(int ifOperStatus) {
		this.ifOperStatus = ifOperStatus;
	}


	public long getIfLastChange() {
		return ifLastChange;
	}


	public void setIfLastChange(long ifLastChange) {
		this.ifLastChange = ifLastChange;
	}


	public Double getIfInOctets() {
		return ifInOctets;
	}


	public void setIfInOctets(Double ifInOctets) {
		this.ifInOctets = ifInOctets;
	}


	public Double getIfInUcastPkts() {
		return ifInUcastPkts;
	}


	public void setIfInUcastPkts(Double ifInUcastPkts) {
		this.ifInUcastPkts = ifInUcastPkts;
	}


	public Double getIfInNUcastPkts() {
		return ifInNUcastPkts;
	}


	public void setIfInNUcastPkts(Double ifInNUcastPkts) {
		this.ifInNUcastPkts = ifInNUcastPkts;
	}


	public Double getIfInDiscards() {
		return ifInDiscards;
	}


	public void setIfInDiscards(Double ifInDiscards) {
		this.ifInDiscards = ifInDiscards;
	}


	public Double getIfInErrors() {
		return ifInErrors;
	}


	public void setIfInErrors(Double ifInErrors) {
		this.ifInErrors = ifInErrors;
	}


	public Double getIfInUnknownProtos() {
		return ifInUnknownProtos;
	}


	public void setIfInUnknownProtos(Double ifInUnknownProtos) {
		this.ifInUnknownProtos = ifInUnknownProtos;
	}


	public Double getIfOutOctets() {
		return ifOutOctets;
	}


	public void setIfOutOctets(Double ifOutOctets) {
		this.ifOutOctets = ifOutOctets;
	}


	public Double getIfOutUcastPkts() {
		return ifOutUcastPkts;
	}


	public void setIfOutUcastPkts(Double ifOutUcastPkts) {
		this.ifOutUcastPkts = ifOutUcastPkts;
	}


	public Double getIfOutNUcastPkts() {
		return ifOutNUcastPkts;
	}


	public void setIfOutNUcastPkts(Double ifOutNUcastPkts) {
		this.ifOutNUcastPkts = ifOutNUcastPkts;
	}


	public Double getIfOutDiscards() {
		return ifOutDiscards;
	}


	public void setIfOutDiscards(Double ifOutDiscards) {
		this.ifOutDiscards = ifOutDiscards;
	}


	public Double getIfOutErrors() {
		return ifOutErrors;
	}


	public void setIfOutErrors(Double ifOutErrors) {
		this.ifOutErrors = ifOutErrors;
	}


	public Double getIfOutQLen() {
		return ifOutQLen;
	}


	public void setIfOutQLen(Double ifOutQLen) {
		this.ifOutQLen = ifOutQLen;
	}


	public java.lang.String getIfSpecific() {
		return ifSpecific;
	}


	public void setIfSpecific(java.lang.String ifSpecific) {
		this.ifSpecific = ifSpecific;
	}


	public int getData64Flag() {
		return data64Flag;
	}


	public void setData64Flag(int data64Flag) {
		this.data64Flag = data64Flag;
	}


}
