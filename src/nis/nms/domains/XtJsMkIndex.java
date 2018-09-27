package nis.nms.domains;

import java.util.Date;

/**
 * XtJsMkIndex entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class XtJsMkIndex implements java.io.Serializable {

	// Fields

	private Long id;
	private Long mkbh;
	private Long jsbh;
	private Date ctime;

	// Constructors

	/** default constructor */
	public XtJsMkIndex() {
	}

	/** minimal constructor */
	public XtJsMkIndex(Long id) {
		this.id = id;
	}

	/** full constructor */
	public XtJsMkIndex(Long id, Long mkbh, Long jsbh, Date ctime) {
		this.id = id;
		this.mkbh = mkbh;
		this.jsbh = jsbh;
		this.ctime = ctime;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getMkbh() {
		return this.mkbh;
	}

	public void setMkbh(Long mkbh) {
		this.mkbh = mkbh;
	}

	public Long getJsbh() {
		return this.jsbh;
	}

	public void setJsbh(Long jsbh) {
		this.jsbh = jsbh;
	}

	public Date getCtime() {
		return this.ctime;
	}

	public void setCtime(Date ctime) {
		this.ctime = ctime;
	}

}