package nis.nms.domains;

import java.util.Date;

/**
 * CheckTypeInfo entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class CheckTypeInfo implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long id;
	private String checkTypeName;//监测用的类别
	private String checkTypeName1;//展示给用户看的类别名
	private String checkParamValue;
	private String checkRemark;
	private String tableName;
	private String tableComments;
	private String creteState;
	private String isSchedule;
	private Date createTime;
	private Long viewLevel;
	private Long systemId;
	private Long groupId;
	private Long userId;
	private Long isSnmp;
	private String snmpOID;

	// Constructors

	/** default constructor */
	public CheckTypeInfo() {
	}

	/** full constructor */
	public CheckTypeInfo(String checkTypeName, String checkParamValue,
			String checkRemark, String tableName,String tableComments,
			String creteState,String isSchedule,Long viewLevel,
			Long systemId,Long groupId,Long userId,Long isSnmp,String snmpOID) {
		this.checkTypeName = checkTypeName;
		this.checkParamValue = checkParamValue;
		this.checkRemark = checkRemark;
		this.tableName = tableName;
		this.tableComments = tableComments;
		this.creteState = creteState;
		this.isSchedule = isSchedule;
		this.viewLevel = viewLevel;
		this.systemId = systemId;
		this.groupId = groupId;
		this.userId = userId;
		this.isSnmp = isSnmp;
		this.snmpOID = snmpOID;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCheckTypeName() {
		return this.checkTypeName;
	}

	public void setCheckTypeName(String checkTypeName) {
		this.checkTypeName = checkTypeName;
	}

	public String getCheckParamValue() {
		return this.checkParamValue;
	}

	public void setCheckParamValue(String checkParamValue) {
		this.checkParamValue = checkParamValue;
	}

	public String getCheckRemark() {
		return this.checkRemark;
	}

	public void setCheckRemark(String checkRemark) {
		this.checkRemark = checkRemark;
	}

	public String getTableName() {
		return this.tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getTableComments() {
		return tableComments;
	}

	public void setTableComments(String tableComments) {
		this.tableComments = tableComments;
	}

	public String getCreteState() {
		return creteState;
	}

	public void setCreteState(String creteState) {
		this.creteState = creteState;
	}
	public String getIsSchedule() {
		return isSchedule;
	}

	public void setIsSchedule(String isSchedule) {
		this.isSchedule = isSchedule;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Long getViewLevel() {
		return viewLevel;
	}

	public void setViewLevel(Long viewLevel) {
		this.viewLevel = viewLevel;
	}

	public Long getGroupId() {
		return groupId;
	}

	public void setGroupId(Long groupId) {
		this.groupId = groupId;
	}

	public Long getSystemId() {
		return systemId;
	}

	public void setSystemId(Long systemId) {
		this.systemId = systemId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	
	public Long getIsSnmp()
	{
		return isSnmp;
	}

	
	public void setIsSnmp(Long isSnmp)
	{
		this.isSnmp = isSnmp;
	}

	public String getSnmpOID() {
		return snmpOID;
	}

	public void setSnmpOID(String snmpOID) {
		this.snmpOID = snmpOID;
	}

	public String getCheckTypeName1() {
		return checkTypeName1;
	}

	public void setCheckTypeName1(String checkTypeName1) {
		this.checkTypeName1 = checkTypeName1;
	}
	
}