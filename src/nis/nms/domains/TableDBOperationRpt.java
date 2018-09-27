package nis.nms.domains;

import java.util.Date;

/**
 * TableDBOperationRpt entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class TableDBOperationRpt implements java.io.Serializable {

	
	private static final long serialVersionUID = 1L;
	private Long logid;
	private String username;
	private Date time;
	private String objtable;
	private Long objid;
	private String action;
	private String sqlCondition;

	// Constructors

	/** default constructor */
	public TableDBOperationRpt() {
	}

	/** minimal constructor */
	public TableDBOperationRpt(Long logid, String username) {
		this.logid = logid;
		this.username = username;
	}

	/** full constructor */
	public TableDBOperationRpt(Long logid, String username, Date time,
			String objtable, Long objid, String action,String sqlCondition) {
		this.logid = logid;
		this.username = username;
		this.time = time;
		this.objtable = objtable;
		this.objid = objid;
		this.action = action;
		this.sqlCondition = sqlCondition;
	}

	// Property accessors

	public Long getLogid() {
		return this.logid;
	}

	public void setLogid(Long logid) {
		this.logid = logid;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Date getTime() {
		return this.time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getObjtable() {
		return this.objtable;
	}

	public void setObjtable(String objtable) {
		this.objtable = objtable;
	}

	public Long getObjid() {
		return this.objid;
	}

	public void setObjid(Long objid) {
		this.objid = objid;
	}

	public String getAction() {
		return this.action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public String getSqlCondition() {
		return sqlCondition;
	}

	public void setSqlCondition(String sqlCondition) {
		this.sqlCondition = sqlCondition;
	}

}