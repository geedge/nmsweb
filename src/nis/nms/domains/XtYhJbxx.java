package nis.nms.domains;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * XtYhJbxx entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class XtYhJbxx implements java.io.Serializable {

	// Fields

	
	private static final long serialVersionUID = 1L;
	private Long yhid;
	private String yhbh;	//用户名
	private String yhmm;	//密码
	private String yhmc;	//名称
	private String gcdbh;	//
	private String yhbbh;
	private String dh;
	private String fjhm;
	private String isbz;
	private String email;
	private String pwdState;
	private String zxbz;	//状态
	private Date ctime;//创建时间
	private String rightMenuItems;
	private String bgColor;
	public static ArrayList  LONGIN_USER=new ArrayList();//存储登录用户
	public static Map LOGIN_SESSION=new HashMap();//存储登录用户的session
	private String userRole;//用户角色信息
	private String userDept;//用户部门信息
	private List<XtJsJbxx> userRoleList = new ArrayList();
	private List<TableDepartment> userDeptList = new ArrayList();
	private String isReceiveEmail;	//是否接收邮件
	private String language;//用户使用的语言
	// Constructors

	public String getIsReceiveEmail() {
		return isReceiveEmail;
	}

	public void setIsReceiveEmail(String isReceiveEmail) {
		this.isReceiveEmail = isReceiveEmail;
	}

	public String getUserDept() {
		return userDept;
	}

	public void setUserDept(String userDept) {
		this.userDept = userDept;
	}

	public String getUserRole() {
		return userRole;
	}

	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}

	/** default constructor */
	public XtYhJbxx() {
	}

	/** minimal constructor */
	public XtYhJbxx(Long yhid, String yhbh, String yhmm, String yhmc) {
		this.yhid = yhid;
		this.yhbh = yhbh;
		this.yhmm = yhmm;
		this.yhmc = yhmc;
	}

	/** full constructor */
	public XtYhJbxx(Long yhid, String yhbh, String yhmm, String yhmc,
			String gcdbh, String yhbbh, String dh, String fjhm, String isbz,
			String zxbz, Date ctime,String rightMenuItems,String pwdState) {
		this.yhid = yhid;
		this.yhbh = yhbh;
		this.yhmm = yhmm;
		this.yhmc = yhmc;
		this.gcdbh = gcdbh;
		this.yhbbh = yhbbh;
		this.dh = dh;
		this.fjhm = fjhm;
		this.isbz = isbz;
		this.zxbz = zxbz;
		this.ctime = ctime;
		this.rightMenuItems = rightMenuItems;
		this.pwdState = pwdState;
	}

	// Property accessors

	public Long getYhid() {
		return this.yhid;
	}

	public void setYhid(Long yhid) {
		this.yhid = yhid;
	}

	public String getYhbh() {
		return this.yhbh;
	}

	public void setYhbh(String yhbh) {
		this.yhbh = yhbh;
	}

	public String getYhmm() {
		return this.yhmm;
	}

	public void setYhmm(String yhmm) {
		this.yhmm = yhmm;
	}

	public String getYhmc() {
		return this.yhmc;
	}

	public void setYhmc(String yhmc) {
		this.yhmc = yhmc;
	}

	public String getGcdbh() {
		return this.gcdbh;
	}

	public void setGcdbh(String gcdbh) {
		this.gcdbh = gcdbh;
	}

	public String getYhbbh() {
		return this.yhbbh;
	}

	public void setYhbbh(String yhbbh) {
		this.yhbbh = yhbbh;
	}

	public String getDh() {
		return this.dh;
	}

	public void setDh(String dh) {
		this.dh = dh;
	}

	public String getFjhm() {
		return this.fjhm;
	}

	public void setFjhm(String fjhm) {
		this.fjhm = fjhm;
	}

	public String getIsbz() {
		return this.isbz;
	}

	public void setIsbz(String isbz) {
		this.isbz = isbz;
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

	public List getUserRoleList() {
		return userRoleList;
	}

	public void setUserRoleList(List userRoleList) {
		this.userRoleList = userRoleList;
	}

	public List getUserDeptList() {
		return userDeptList;
	}

	public void setUserDeptList(List userDeptList) {
		this.userDeptList = userDeptList;
	}

	public String getRightMenuItems() {
		return rightMenuItems;
	}

	public void setRightMenuItems(String rightMenuItems) {
		this.rightMenuItems = rightMenuItems;
	}

	public String getBgColor() {
		return bgColor;
	}

	public void setBgColor(String bgColor) {
		this.bgColor = bgColor;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPwdState() {
		return pwdState;
	}

	public void setPwdState(String pwdState) {
		this.pwdState = pwdState;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

}