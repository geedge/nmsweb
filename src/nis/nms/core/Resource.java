/**
 * 
 */
package nis.nms.core;

import java.io.Serializable;
import java.util.List;

/**
 * @author Administrator
 *
 */
public class Resource implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private String rsid;//主键
    private String rsname;//名称
    private Long number;
    private String iconshow;//图标路径
    private String rsdesc;//描述
    private String rsaddress;//地址
    private String business;
    private String rsCode;
    private String parRsCode;//父id
    private List cRsList;
    private String position;//位置
    private String mktype;//模块类型 type=1 为按钮类型 其他未菜单
    private String checked;
    private Integer isValid; // 是否有效：1有效，0无效
    
    public String getChecked() {
		return checked;
	}

	public void setChecked(String checked) {
		this.checked = checked;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public Resource() {
    }
    
    /** full constructor */
    
	public List getCRsList() {
		return cRsList;
	}
	public void setCRsList(List rsList) {
		cRsList = rsList;
	}
	public String getParRsCode() {
		return parRsCode;
	}

	public void setParRsCode(String parRsCode) {
		this.parRsCode = parRsCode;
	}

	public String getBusiness() {
		return business;
	}
	public void setBusiness(String business) {
		this.business = business;
	}
	public Long getNumber() {
		return number;
	}
	public void setNumber(Long number) {
		this.number = number;
	}
	public String getRsaddress() {
		return rsaddress;
	}
	public void setRsaddress(String rsaddress) {
		this.rsaddress = rsaddress;
	}
	public String getRsCode() {
		return rsCode;
	}
	public void setRsCode(String rsCode) {
		this.rsCode = rsCode;
	}
	public String getRsdesc() {
		return rsdesc;
	}
	public void setRsdesc(String rsdesc) {
		this.rsdesc = rsdesc;
	}
	public String getRsid() {
		return rsid;
	}
	public void setRsid(String rsid) {
		this.rsid = rsid;
	}
	public String getRsname() {
		return rsname;
	}
	public void setRsname(String rsname) {
		this.rsname = rsname;
	}
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO 自动生成方法存根

	}

	public String getIconshow() {
		return iconshow;
	}

	public void setIconshow(String iconshow) {
		this.iconshow = iconshow;
	}

	public String getMktype() {
		return mktype;
	}

	public void setMktype(String mktype) {
		this.mktype = mktype;
	}

	public Integer getIsValid() {
		return isValid;
	}
	public void setIsValid(Integer isValid) {
		this.isValid = isValid;
	}
	
}
