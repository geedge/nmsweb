package nis.nms.bean;


public class EmailInfo {
	private Long id;		//接收地址
	private String toAddress;		//接收地址
	private Integer actionType;		//事件类型 值10监测恢复，11监测信息异常，13:监测结果超时，20主动告警恢复，21主动告警异常，31结果失败，32任务状态变更，40系统运行异常恢复，41系统运行异常
	private String actionDesc;
	private String actionIp;		//事件地点
	private String actionDate;		//事件时间
	private String content;			//事件内容及结果
	private Integer sendFlag;		//0未发送 1已发送
	private Integer sendLevel;		//0紧急 1非紧急
	public EmailInfo (){
		
	}
	
	public EmailInfo (EmailInfo info){
		this.toAddress = info.getToAddress();
		this.actionType = info.getActionType();
		this.actionDesc = info.getActionDesc();
		this.actionIp = info.getActionIp();
		this.actionDate = info.getActionDate();
		this.content = info.getContent();
		this.sendFlag = info.getSendFlag();
		this.sendLevel = info.getSendLevel();
	}
	
	public EmailInfo (Integer actionType,String actionDesc,String actionIp,String actionDate,String content,Integer sendFlag,Integer sendLevel){
		this.actionType = actionType;
		this.actionDesc = actionDesc;
		this.actionIp = actionIp;
		this.actionDate = actionDate;
		this.content = content;
		this.sendFlag = sendFlag;
		this.sendLevel = sendLevel;
	}
	
	public String getToAddress() {
		return toAddress;
	}
	public void setToAddress(String toAddress) {
		this.toAddress = toAddress;
	}
	
	public Integer getActionType() {
		return actionType;
	}
	public void setActionType(Integer actionType) {
		this.actionType = actionType;
	}
	public String getActionIp() {
		return actionIp;
	}
	public void setActionIp(String actionIp) {
		this.actionIp = actionIp;
	}
	public String getActionDate() {
		return actionDate;
	}
	public void setActionDate(String actionDate) {
		this.actionDate = actionDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getSendFlag() {
		return sendFlag;
	}
	public void setSendFlag(Integer sendFlag) {
		this.sendFlag = sendFlag;
	}
	public String getActionDesc() {
		return actionDesc;
	}
	public void setActionDesc(String actionDesc) {
		this.actionDesc = actionDesc;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Integer getSendLevel() {
		return sendLevel;
	}

	public void setSendLevel(Integer sendLevel) {
		this.sendLevel = sendLevel;
	}
	

}
