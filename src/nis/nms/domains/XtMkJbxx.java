package nis.nms.domains;

import java.util.Date;


/**
 * XtMkJbxx entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class XtMkJbxx implements java.io.Serializable {

	// Fields

	private String mkbh;
	private String mkmc;
	private String mkms;
	private String mkurl;
	private String mktb;
	private String zxbz;
	private Date ctime;
	private String isChecked;
	private Long id;
	private Long pid;
	//一级节点的桌面显示图片
	private String iconimage;
	private String handler;
	private Long mktype;
	
	private Long showlevel;
	private Long showorder;
	private Long showarea;

	public String getHandler() {
		return handler;
	}

	public void setHandler(String handler) {
		this.handler = handler;
	}


	public Long getMktype() {
		return mktype;
	}

	public void setMktype(Long mktype) {
		this.mktype = mktype;
	}

	/** default constructor */
	public XtMkJbxx() {
	}

	/** minimal constructor */
	public XtMkJbxx(Long id) {
		this.id = id;
	}

	/** full constructor */
	public XtMkJbxx(String mkbh, String mkmc, String mkms, String mkurl,
			String mktb, String zxbz, Date ctime,Long id,Long pid,String iconimage,Long showlevel,Long showorder) {
		this.mkbh = mkbh;
		this.mkmc = mkmc;
		this.mkms = mkms;
		this.mkurl = mkurl;
		this.mktb = mktb;
		this.zxbz = zxbz;
		this.ctime = ctime;
		this.id = id;
		this.pid = pid;
		this.iconimage=iconimage;
		this.showlevel = showlevel;
		this.showorder = showorder;
	}

	// Property accessors

	public String getMkbh() {
		return this.mkbh;
	}

	public void setMkbh(String mkbh) {
		this.mkbh = mkbh;
	}

	public String getMkmc() {
		return this.mkmc;
	}

	public void setMkmc(String mkmc) {
		this.mkmc = mkmc;
	}

	public String getMkms() {
		return this.mkms;
	}

	public void setMkms(String mkms) {
		this.mkms = mkms;
	}

	public String getMkurl() {
		return this.mkurl;
	}

	public void setMkurl(String mkurl) {
		this.mkurl = mkurl;
	}

	public String getMktb() {
		return this.mktb;
	}

	public void setMktb(String mktb) {
		this.mktb = mktb;
	}

	public String getZxbz() {
		return this.zxbz;
	}

	public void setZxbz(String zxbz) {
		this.zxbz = zxbz;
	}

	public Date getCtime() {
		return this.ctime;
	}

	public void setCtime(Date ctime) {
		this.ctime = ctime;
	}

	public String getIsChecked() {
		return isChecked;
	}

	public void setIsChecked(String isChecked) {
		this.isChecked = isChecked;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getPid() {
		return pid;
	}

	public void setPid(Long pid) {
		this.pid = pid;
	}

	public String getIconimage() {
		return iconimage;
	}

	public void setIconimage(String iconimage) {
		this.iconimage = iconimage;
	}

	public Long getShowlevel() {
		return showlevel;
	}

	public void setShowlevel(Long showlevel) {
		this.showlevel = showlevel;
	}

	public Long getShoworder() {
		return showorder;
	}

	public void setShoworder(Long showorder) {
		this.showorder = showorder;
	}

	public Long getShowarea() {
		return showarea;
	}

	public void setShowarea(Long showarea) {
		this.showarea = showarea;
	}

}