package nis.nms.domains;

import java.util.Date;

/**
 * XtJsMkGnIndex entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class XtJsMkGnIndex implements java.io.Serializable {

	// Fields

	private Long id;
	private String mkbh;
	private String jsbh;
	private String gnbh;
	private Date ctime;

	// Constructors

	/** default constructor */
	public XtJsMkGnIndex() {
	}

	/** minimal constructor */
	public XtJsMkGnIndex(Long id) {
		this.id = id;
	}

	/** full constructor */
	public XtJsMkGnIndex(Long id, String mkbh, String jsbh, String gnbh,
			Date ctime) {
		this.id = id;
		this.mkbh = mkbh;
		this.jsbh = jsbh;
		this.gnbh = gnbh;
		this.ctime = ctime;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getMkbh() {
		return this.mkbh;
	}

	public void setMkbh(String mkbh) {
		this.mkbh = mkbh;
	}

	public String getJsbh() {
		return this.jsbh;
	}

	public void setJsbh(String jsbh) {
		this.jsbh = jsbh;
	}

	public String getGnbh() {
		return this.gnbh;
	}

	public void setGnbh(String gnbh) {
		this.gnbh = gnbh;
	}

	public Date getCtime() {
		return this.ctime;
	}

	public void setCtime(Date ctime) {
		this.ctime = ctime;
	}

}