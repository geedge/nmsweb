package nis.nms.util;


import java.io.Serializable;

public class ButtonBean implements Serializable{
	private static final long serialVersionUID = -6172423074289313311L;
	//	按钮显示的名称
    private String fext;
    //    去的action
    private String fsrc;
    //    1提交页面2链接页面
    public String ftype;
    //  调用的自定义js函数
    private String func;
    //  true用户自定义了js函数
    private boolean istype;
    public ButtonBean(){
    	
    }
	public String getFext() {
		return fext;
	}
	public void setFext(String fext) {
		this.fext = fext;
	}
	public String getFsrc() {
		return fsrc;
	}
	public void setFsrc(String fsrc) {
		this.fsrc = fsrc;
	}

	public String getFtype() {
		return ftype;
	}
	public void setFtype(String ftype) {
		this.ftype = ftype;
	}
	public String getFunc() {
		return func;
	}
	public void setFunc(String func) {
		this.func = func;
	}
	public boolean isIstype() {
		return istype;
	}
	public void setIstype(boolean istype) {
		this.istype = istype;
	}

    
}
