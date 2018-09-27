package nis.nms.web.actions.sysManage;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import nis.nms.domains.SystemTable;
import nis.nms.domains.TroubleState;
import nis.nms.domains.XtYhJbxx;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.MD5;
import nis.nms.util.Page;
import org.apache.log4j.Logger;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;

import com.nms.servlet.auto.run.AutoGetTroubleCode;

@SuppressWarnings("unchecked")
@Results( {
		@Result(name = "openAddErrorInfo", value = "/page/system/addErrorInfo.jsp"),
		@Result(name = "queryErrorInfo", value = "/page/system/errorInfoList.jsp"),
		@Result(name = "updateErrorInfo", value = "/page/system/updateErrorInfo.jsp")
		})
public class SysErrorManageAction extends BaseAction {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(SysErrorManageAction.class);
	private CommonService commonService;
	private int pageNo = 1;
	private int pageSize = this.getDefaultPageSize(); // 每页显示的记录条数
	private Page page;
	private String action;
	private List allErrorInfo = new ArrayList();
	private String erid;
	private TroubleState troubleState;
	private SystemTable systemTable;
	private XtYhJbxx xtyhxx;
	private List<SystemTable> sysList;
	private String sysId;
	
	@Override
	public String executeAction() throws Exception{
		String resultpage = "";
		try {
			this.getRequest().setAttribute("ADMFlag", this.getAdminMark());
			if ("openAddError".equals(this.action)) {
				querySystemInfo();
				resultpage = "openAddErrorInfo";
			}else 
			if ("addErrorInfo".equals(this.action)) {
				addErrorInfo();
				return null;
			}else 
			if ("openUpdError".equals(this.action)) {
				updateErrorInfo();
				querySystemInfo();
				resultpage = "updateErrorInfo";
			}else 
			if("doUpdError".equals(this.action)){
				doUpdate();
				return null;
			}else if("checkAjax".equals(this.action)){
				checkAjax();
				return null;
			}else 
			if ("query".equals(this.action)) {
				resultpage = queryErrorInfo();
			}else{
				resultpage = queryErrorInfo();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultpage;
	}

	public void checkAjax(){
		Long code = troubleState.getTroubleCode();
		String sql = "select count(*) from trouble_state t where TROUBLE_CODE ="+code+" and SYSTEM_ID ="+this.getSystemID();
		List list;
		try {
			list = this.commonService.executeSQL(sql);
			if(list!=null && list.get(0)!=null){
				int num = Integer.parseInt(list.get(0).toString());
				if(num>0){
					this.outString("error");
					return ;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			this.outString("exception");
		}
		this.outString("success");
	}
	
	public void addErrorInfo() {
		try {
		//	if(checkCode(troubleState.getTroubleCode())){
				SystemTable sys = null;
				if(this.getAdminMark()){//是
					sys = (SystemTable) commonService.get(SystemTable.class, troubleState.getSystem().getSystemId());
				}else{
					sys = (SystemTable) commonService.get(SystemTable.class, this.getSystemID());
				}
				
				XtYhJbxx user =  this.getUser();
				troubleState.setCreateDate(new Date());
				troubleState.setSystem(sys);
				troubleState.setCreateUser(user);
				troubleState.setState("0");
				this.commonService.save(troubleState);
				// 将添加操作写到操作日志中
				this.addDBOperationRpt(commonService, "trouble_state", "INSERT",
						troubleState.getId());
				outHtmlString("<script type=\"text/javascript\">alert('i18n_SysErrorManageAction.addErrorInfo.success_n81i');this.location='sysErrorManage!execute.do?action=query&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
				/*}else{
				this.outHtmlString("<script>alert('故障代码已存在，请重新输入！');history.back();</script>");
				return;
			}*/
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SysErrorManageAction.addErrorInfo.faild_n81i');this.location='sysErrorManage!execute.do?action=query&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
		}
	}

	//管理业务系统列表
	public List<SystemTable> querySystemInfo(){
		try{
			sysList = this.getAllSystemInfo(this.commonService);
		}catch (Exception e){
			e.printStackTrace();
		}
		return sysList;
	}
	
	public boolean checkCode(Long code){
		boolean checkResu = true;
		try {
			String sql = "select count(*) from trouble_state t where TROUBLE_CODE ="+code+" and SYSTEM_ID ="+this.getSystemID();
			List list = this.commonService.executeSQL(sql);
			if(list!=null && list.get(0)!=null){
				int num = Integer.parseInt(list.get(0).toString());
				if(num>0){
					checkResu = false;
				}
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return checkResu;
	}
	
	public String queryErrorInfo() {
		try {
			String sql = "from TroubleState where 1=1 ";
			sql += "order by id";
			page = this.commonService.findByPage(sql, pageNo, pageSize);
			allErrorInfo = (List<TroubleState>) page.getResult();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "queryErrorInfo";
	}

	
	public void updateErrorInfo() {
		try {
			troubleState =(TroubleState) commonService.get(TroubleState.class, Long.parseLong(erid)); 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void doUpdate() {
		try {
			TroubleState md = (TroubleState) commonService.get(TroubleState.class, troubleState
					.getId());
			SystemTable sys = null;
			if(this.getAdminMark()){//是
				sys = (SystemTable) commonService.get(SystemTable.class, troubleState.getSystem().getSystemId());
			}else{
				sys = (SystemTable) commonService.get(SystemTable.class, Long.parseLong(sysId));
			}
			//SystemTable sys = (SystemTable) commonService.get(SystemTable.class, troubleState.getSystem().getSystemId());
			XtYhJbxx user =  (XtYhJbxx) commonService.get(XtYhJbxx.class, troubleState.getCreateUser().getYhid());
			md.setSystem(sys);
			md.setCreateUser(user);
			md.setLastUpDate(new Date());
			md.setLastUpUser(this.getUser());
			md.setTroubleCode(troubleState.getTroubleCode());
			md.setTroubleDescr(troubleState.getTroubleDescr());
			md.setTroubleInfo(troubleState.getTroubleInfo());
			md.setState(troubleState.getState());
			this.commonService.update(md);
			// 将更新操作写到操作日志中
			this.addDBOperationRpt(commonService, "Trouble_State", "UPDATE",
					troubleState.getId());
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SysErrorManageAction.addErrorInfo.success_n81i');this.location='sysErrorManage!execute.do?action=query&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SysErrorManageAction.addErrorInfo.faild_n81i');this.location='sysErrorManage!execute.do?action=query&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
		}
	}
	
	public Logger getLogger() {
		return logger;
	}

	public void setLogger(Logger logger) {
		this.logger = logger;
	}

	public List getAllErrorInfo() {
		return allErrorInfo;
	}

	public void setAllErrorInfo(List allErrorInfo) {
		this.allErrorInfo = allErrorInfo;
	}

	public String getErid() {
		return erid;
	}

	public void setErid(String erid) {
		this.erid = erid;
	}

	public TroubleState getTroubleState() {
		return troubleState;
	}

	public void setTroubleState(TroubleState troubleState) {
		this.troubleState = troubleState;
	}

	public CommonService getCommonService() {
		return commonService;
	}

	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public SystemTable getSystemTable() {
		return systemTable;
	}

	public void setSystemTable(SystemTable systemTable) {
		this.systemTable = systemTable;
	}

	public XtYhJbxx getXtyhxx() {
		return xtyhxx;
	}

	public void setXtyhxx(XtYhJbxx xtyhxx) {
		this.xtyhxx = xtyhxx;
	}

	public List<SystemTable> getSysList() {
		return sysList;
	}

	public void setSysList(List<SystemTable> sysList) {
		this.sysList = sysList;
	}

	public String getSysId() {
		return sysId;
	}

	public void setSysId(String sysId) {
		this.sysId = sysId;
	}
	
}
