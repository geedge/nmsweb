package nis.nms.web.actions.nmsError;

import java.util.Calendar;
import java.util.List;
import nis.nms.domains.NmsErrorCode;
import nis.nms.domains.NmsErrorInfo;
import nis.nms.domains.XtYhJbxx;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.DateUtil;
import nis.nms.util.Page;
import org.apache.commons.lang.StringUtils;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;

@SuppressWarnings("unchecked")
@Results( {
		@Result(name = "errorInfoList", value = "/page/system/nmsError/nmsErrorInfoList.jsp"),
		@Result(name = "errorInfoDetail", value = "/page/system/nmsError/errorInfoDetail.jsp") })
public class NmsErrorInfoAction extends BaseAction {
	
	/* 公用基本参数 */
	private CommonService commonService;
	private int pageNo = 1;
	private int pageSize = this.getDefaultPageSize(); // 每页显示的记录条数
	private Page page;
	private String action;// 系统操作
	private String position;
	private Long[] ids;//业务系统id集合
	
	/* 自定义参数 */
	private NmsErrorInfo errorInfo ;
	private NmsErrorCode errorCode ;
	private Long eiId;
	private Long eiState;
	private String errorIp;
	private String errorCodeStr;
	private List<NmsErrorInfo> eiList ;
	private List objsList;
	
	@Override
	public String executeAction() throws Exception {
		String returnPage = "";
		try {
            // NMSServer管理
			if ("query".equals(this.action)) {// 查看NMSServer列表
				returnPage = query();
			}else 
			if ("detail".equals(this.action)) {//打开添加页面
				returnPage = detail();
			}else 
			if ("checkState".equals(this.action)) {//保存添加信息
				returnPage = changeState();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnPage;
	}

	private String query(){
		try {
			StringBuffer sql = new StringBuffer("select nei.id, nei.error_code, nec.error_name,nei.error_des, to_char(nei.error_time,'yyyy-mm-dd hh24:mi:ss'), nei.errort_ip,nei.error_state, nei.errort_getip,nei.state_update_userid,xyj.yhmc, to_char(nei.state_update_time,'yyyy-mm-dd hh24:mi:ss') " +
			"from Nms_Error_Info nei left join nms_error_code nec on nec.error_code = nei.error_code left join xt_yh_jbxx xyj on xyj.YHID = nei.state_update_userid where " +
			//去除nvl(nei.error_des,'-1')过滤条件//"and (nei.error_code,nvl(nei.error_des,'-1'),nei.errort_ip,nei.errort_getip,nei.error_time) in (select t.error_code,nvl(t.error_des,'-1'),t.errort_ip,t.errort_getip,max(t.error_time) from nms_error_info t group by t.error_code,t.error_des,t.errort_ip,t.errort_getip)");
			"(nei.error_code,nei.errort_ip,nei.errort_getip,nei.error_time) in (select t.error_code,t.errort_ip,t.errort_getip,max(t.error_time) from nms_error_info t group by t.error_code,t.errort_ip,t.errort_getip)");
			System.out.println(sql);
			if(eiId != null){
				sql.append("and nei.id ='"+eiId+"' ");
			}
			if (eiState != null)
			{
				sql.append("and nei.error_State ='"+eiState+"' ");
			}
			if(StringUtils.isNotEmpty(errorIp) ){
				sql.append("and nei.errort_Ip like '%"+errorIp+"%' ");
			}
			if(StringUtils.isNotEmpty(errorCodeStr)){
				sql.append("and nec.error_name like '%"+errorCodeStr+"%' ");
			}
			sql.append("order by nei.state_update_time desc ");
			page = this.commonService.findByPageForSql(sql.toString(), pageNo, pageSize);
			objsList = (List) page.getResult();
			return "errorInfoList";
		} catch (Exception e) {
			e.printStackTrace();
			this.outHtmlString("<script>alert('i18n_NmsErrorInfoAction.query.queryFaild_n81i');history.back();</script>");
			return null;
		}
	}
	
	private String detail(){
		if(eiId != null){
			try {
				errorInfo = (NmsErrorInfo) this.commonService.get(NmsErrorInfo.class, eiId);
				if(errorInfo!= null){
					if(StringUtils.isNotEmpty(errorInfo.getErrorCode())){
						List<NmsErrorCode> necList = this.commonService.findByProperty(NmsErrorCode.class, "errorCode", errorInfo.getErrorCode());
						if(necList!=null && necList.size()>0){
							errorCode = (NmsErrorCode) necList.get(0);
						}
					}
					
					if(errorInfo.getStateUpdateUserid() != null){
						List<XtYhJbxx> necList = this.commonService.findByProperty(XtYhJbxx.class, "yhid", errorInfo.getStateUpdateUserid());
						if(necList!=null && necList.size()>0){
							XtYhJbxx jbxx = necList.get(0);
							getRequest().setAttribute("yhJbxx", jbxx);
						}
					}
					return "errorInfoDetail";
				}else{
					this.outHtmlString("<script>alert('i18n_NmsErrorInfoAction.query.noResultReturn_n81i');history.back();</script>");
					return null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				this.outHtmlString("<script>alert('i18n_NmsErrorInfoAction.query.queryFaild_n81i');history.back();</script>");
				return null;
			}
			
		}else{
			this.outHtmlString("<script>alert('i18n_NmsErrorInfoAction.query.invalidId_n81i');history.back();</script>");
			return null;
		}
	}
	
	private String changeState(){
		if(ids != null){
			try {
				/* 当前用户ID */
				this.getUserID();
				/* 当前用户ID */
				String dateStr = DateUtil.longToDate(Calendar.getInstance().getTimeInMillis(), "yyyy-MM-dd HH:mm:ss");
				
				/**
				 * 已解决业务：查询出该类异常的所有状态为1 的数据ID，置为0 ，其增加操作者和操作时间
				 * 未解决业务：更新ID为指定值的数据状态为1，更新操作者和更新状态变更时间
				 * */
				String state = getRequest().getParameter("state");
				if(StringUtils.isNotEmpty(state) && "0".equals(state)){	//状态置为已解决
					for(long id : ids){
						this.commonService.updateBySql("update nms_error_info nei set nei.error_state=?,nei.STATE_UPDATE_USERID=?,nei.STATE_UPDATE_TIME=to_date(?,'yyyy-MM-dd HH24:mi:ss') " +
								"where (nei.error_code, nei.errort_ip, nei.errort_getip) in (select t.error_code, t.errort_ip, t.errort_getip from nms_error_info t where id = ?) and nei.error_state = 1 and nei.id <= ?", 0,this.getUserID(),dateStr,id,id);
					}
				}else if(StringUtils.isNotEmpty(state) && "1".equals(state)){	//状态置为未解决
					//拼写id串
					StringBuffer idBuffer = new StringBuffer("0");
					for(long id : ids){
						idBuffer.append(","+id);
					}
					this.commonService.updateBySql("update nms_error_info nei set nei.error_state=?,nei.STATE_UPDATE_USERID=?,nei.STATE_UPDATE_TIME=to_date(?,'yyyy-MM-dd HH24:mi:ss') where nei.id in ("+idBuffer+")", 1,this.getUserID(),dateStr);
				}else{
					this.outHtmlString("<script>alert('i18n_NmsErrorInfoAction.query.getParamsFaild_n81i');history.back();</script>");
					return null;
				}
				
				outHtmlString("<script type=\"text/javascript\">alert('i18n_NmsErrorInfoAction.query.faild_n81i');"
						+ "this.location='nmsErrorInfo.do?action=query&pageNo="
						+ pageNo + "&pageSize=" + pageSize + "&position=" + position + "&errorCodeStr=" + errorCodeStr + "&errorIp=" + errorIp + "&eiState=" + (eiState==null?"":eiState) + "'</script>");
				return null;
			} catch (Exception e) {
				e.printStackTrace();
				this.outHtmlString("<script>alert('i18n_NmsErrorInfoAction.query.queryFaild_n81i');history.back();</script>");
				return null;
			}
		}else{
			this.outHtmlString("<script>alert('i18n_NmsErrorInfoAction.query.invalidId_n81i');history.back();</script>");
			return null;
		}
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

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public Long[] getIds() {
		return ids;
	}

	public void setIds(Long[] ids) {
		this.ids = ids;
	}

	public NmsErrorInfo getErrorInfo() {
		return errorInfo;
	}

	public void setErrorInfo(NmsErrorInfo errorInfo) {
		this.errorInfo = errorInfo;
	}

	public Long getEiId() {
		return eiId;
	}

	public void setEiId(Long eiId) {
		this.eiId = eiId;
	}

	public List<NmsErrorInfo> getEiList() {
		return eiList;
	}

	public void setEiList(List<NmsErrorInfo> eiList) {
		this.eiList = eiList;
	}

	public List getObjsList() {
		return objsList;
	}

	public void setObjsList(List objsList) {
		this.objsList = objsList;
	}

	public Long getEiState() {
		return eiState;
	}

	public void setEiState(Long eiState) {
		this.eiState = eiState;
	}

	public String getErrorIp() {
		return errorIp;
	}

	public void setErrorIp(String errorIp) {
		this.errorIp = errorIp;
	}

	public String getErrorCodeStr() {
		return errorCodeStr;
	}

	public void setErrorCodeStr(String errorCode) {
		this.errorCodeStr = errorCode;
	}

	public NmsErrorCode getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(NmsErrorCode errorCode) {
		this.errorCode = errorCode;
	}
	
}
