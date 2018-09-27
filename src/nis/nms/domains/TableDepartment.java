package nis.nms.domains;

/**
 * TableDepartment entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class TableDepartment implements java.io.Serializable {

	// Fields

	private Long deptid;
	private String deptname;
	private Long upperlayer;
	private String isChecked;
	private String deptstate;

	// Constructors

	public String getIsChecked() {
		return isChecked;
	}

	public void setIsChecked(String isChecked) {
		this.isChecked = isChecked;
	}

	/** default constructor */
	public TableDepartment() {
	}


	/** full constructor */
	public TableDepartment(Long deptid, String deptname, Long deptlayer,
			Long upperlayer,String deptstate) {
		this.deptid = deptid;
		this.deptname = deptname;
		this.upperlayer = upperlayer;
		this.deptstate = deptstate;
	}

	// Property accessors

	public Long getDeptid() {
		return this.deptid;
	}

	public void setDeptid(Long deptid) {
		this.deptid = deptid;
	}

	public String getDeptname() {
		return this.deptname;
	}

	public void setDeptname(String deptname) {
		this.deptname = deptname;
	}

	public Long getUpperlayer() {
		return this.upperlayer;
	}

	public void setUpperlayer(Long upperlayer) {
		this.upperlayer = upperlayer;
	}

	public String getDeptstate() {
		return deptstate;
	}

	public void setDeptstate(String deptstate) {
		this.deptstate = deptstate;
	}

}