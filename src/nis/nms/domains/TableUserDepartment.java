package nis.nms.domains;

/**
 * TableUserDepartment entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class TableUserDepartment implements java.io.Serializable {

	// Fields

	private Long id;
	private Long userid;
	private Long deptid;

	// Constructors

	/** default constructor */
	public TableUserDepartment() {
	}

	/** full constructor */
	public TableUserDepartment(Long id, Long userid, Long deptid) {
		this.id = id;
		this.userid = userid;
		this.deptid = deptid;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getUserid() {
		return this.userid;
	}

	public void setUserid(Long userid) {
		this.userid = userid;
	}

	public Long getDeptid() {
		return this.deptid;
	}

	public void setDeptid(Long deptid) {
		this.deptid = deptid;
	}

}