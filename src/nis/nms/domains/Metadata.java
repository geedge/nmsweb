package nis.nms.domains;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Metadata entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class Metadata implements java.io.Serializable {

	// Fields

	private Long id;
	private CheckTypeInfo checkTypeInfo;
	private String tableName;
	private String tableComments;
	private String filedName;
	private String filedComments;
	private String filedType;
	private String filedTypeLength;
	private String filedTypeOnly;
	private Date createDate;
	private Long createPerson;
	private String state;
	private Date updateDate;
	private Long updatePerson;
	private String chartState;
	private String oid;
	private Long showNum;
	private Long isNull;
	private String typeId;
	private Long sortSign;
	private Set dataPoliceRelations = new HashSet(0);

	// Constructors

	/** default constructor */
	public Metadata() {
	}

	/** full constructor */
	public Metadata(CheckTypeInfo checkTypeInfo, String tableName,
			String tableComments, String filedName, String filedComments,
			String filedType, Date createDate, Long createPerson, String state,
			Date updateDate, Long updatePerson, String chartState,String oid,
			Long showNum,Long isNull,String typeId,Long sortSign ,Set dataPoliceRelations) {
		this.checkTypeInfo = checkTypeInfo;
		this.tableName = tableName;
		this.tableComments = tableComments;
		this.filedName = filedName;
		this.filedComments = filedComments;
		this.filedType = filedType;
		this.createDate = createDate;
		this.createPerson = createPerson;
		this.state = state;
		this.updateDate = updateDate;
		this.updatePerson = updatePerson;
		this.chartState = chartState;
		this.oid = oid;
		this.showNum = showNum;
		this.isNull = isNull;
		this.typeId = typeId;
		this.sortSign = sortSign;
		this.dataPoliceRelations = dataPoliceRelations;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public CheckTypeInfo getCheckTypeInfo() {
		return this.checkTypeInfo;
	}

	public void setCheckTypeInfo(CheckTypeInfo checkTypeInfo) {
		this.checkTypeInfo = checkTypeInfo;
	}

	public String getTableName() {
		return this.tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getTableComments() {
		return this.tableComments;
	}

	public void setTableComments(String tableComments) {
		this.tableComments = tableComments;
	}

	public String getFiledName() {
		return this.filedName;
	}

	public void setFiledName(String filedName) {
		this.filedName = filedName;
	}

	public String getFiledComments() {
		return this.filedComments;
	}

	public void setFiledComments(String filedComments) {
		this.filedComments = filedComments;
	}

	public String getFiledType() {
		return this.filedType;
	}

	public void setFiledType(String filedType) {
		this.filedType = filedType;
	}

	public Date getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Long getCreatePerson() {
		return this.createPerson;
	}

	public void setCreatePerson(Long createPerson) {
		this.createPerson = createPerson;
	}

	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Date getUpdateDate() {
		return this.updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public Long getUpdatePerson() {
		return this.updatePerson;
	}

	public void setUpdatePerson(Long updatePerson) {
		this.updatePerson = updatePerson;
	}

	public String getChartState() {
		return this.chartState;
	}

	public void setChartState(String chartState) {
		this.chartState = chartState;
	}

	public Long getShowNum() {
		return this.showNum;
	}

	public void setShowNum(Long showNum) {
		this.showNum = showNum;
	}

	public Set getDataPoliceRelations() {
		return this.dataPoliceRelations;
	}

	public void setDataPoliceRelations(Set dataPoliceRelations) {
		this.dataPoliceRelations = dataPoliceRelations;
	}

	public Long getIsNull() {
		return isNull;
	}

	public void setIsNull(Long isNull) {
		this.isNull = isNull;
	}

	
	public String getOid()
	{
		return oid;
	}

	
	public void setOid(String oid)
	{
		this.oid = oid;
	}

	
	public String getTypeId()
	{
		return typeId;
	}

	
	public void setTypeId(String typeId)
	{
		this.typeId = typeId;
	}

	
	public Long getSortSign()
	{
		return sortSign;
	}

	
	public void setSortSign(Long sortSign)
	{
		this.sortSign = sortSign;
	}

	
	public String getFiledTypeLength()
	{
		return filedTypeLength;
	}

	
	public void setFiledTypeLength(String filedTypeLength)
	{
		this.filedTypeLength = filedTypeLength;
	}

	
	public String getFiledTypeOnly()
	{
		return filedTypeOnly;
	}

	
	public void setFiledTypeOnly(String filedTypeOnly)
	{
		this.filedTypeOnly = filedTypeOnly;
	}

}