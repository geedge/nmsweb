package nis.nms.web.actions.functionManager;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import nis.nms.domains.XtMkJbxx;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Page;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;
import com.nis.util.StringUtil;

@SuppressWarnings("unchecked")
@Results( {
		@Result(name = "ok", value = "/page/function/mkInfoList.jsp")
})
public class FunctionManagerAction extends BaseAction {
	
	private static final long serialVersionUID = -2875856570815151046L;
	
	private String action = "";
	
	private XtMkJbxx module;// 保存模块信息
	
	private  String pmkmc;
	
	private List allMkInfo = new ArrayList();// 保存所有模块信息
	
	private Page page;
	
	private int pageNo = 1;
	
	private int pageSize = this.getDefaultPageSize(); // 每页显示的记录条数
	
	private String mkmc;// 模块名称
	
	private String mkid;// 模块ID
	
	private String mkms;// 模块描述
	
	private CommonService commonService;
	
	private String sort;
	private String pid;
	
	public String executeAction(){
		String result = "ok";
		try {
			if ("update".equals(action)) {
				result = updateMk();
			}
			if("add".equals(this.action)){
				result = addMk();
			}
			if("del".equals(this.action)){
				result = delMk();
			}
			allMkInfo = this.commonService.find("from XtMkJbxx where 1=1 order by showlevel, showorder");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return	result;
	}
	
	// 进行修改模块信息操作
	public String updateMk() {
		XtMkJbxx xt = null;
		List<XtMkJbxx> newFunctionlists = null;
		try {
			// 判断是否是修改排序
			if (sort != null) {
				// 上升
				if ("up".equals(sort)) {
					//更新上一个，将上一个的showOrder set 自己的showOrder
					newFunctionlists = getXtMkJbxxListByParam(null, module.getPid(), module.getShoworder()-1);
					if (!StringUtil.isEmpty(newFunctionlists)) {//判断是否存在上一个，如果不存在不更新自己的序号
						xt = newFunctionlists.get(0);
						// 修改排序
						if (xt.getShoworder()!= null) {
							xt.setShoworder(module.getShoworder());
						}
						commonService.update(xt);
						
						//更新自己，将自己的showOrder-1
						newFunctionlists = getXtMkJbxxListByParam(module.getId(), module.getPid(),null);
						if (!StringUtil.isEmpty(newFunctionlists)) {
							xt = newFunctionlists.get(0);
							// 修改排序
							if (xt.getShoworder()!=null) {
								xt.setShoworder(module.getShoworder()-1);
							}
							commonService.update(xt);
						}
					}else{
						//outHtmlString("<script type=\"text/javascript\">alert('此模块已排在首位，无法上移');this.location='functionManager.do?action=queryMkInfo'</script>");
						outHtmlString("3");
						return null;
					}
				} else {
					// 下降
					//更新下一个，将下一个的showOrder set 自己的showOrder
					newFunctionlists = getXtMkJbxxListByParam(null, module.getPid(), module.getShoworder()+1);
					if (!StringUtil.isEmpty(newFunctionlists)) {
						xt = newFunctionlists.get(0);
						// 修改排序
						if (xt.getShoworder()!= null) {
							xt.setShoworder(module.getShoworder());
						}
						commonService.update(xt);
						
						//更新自己，将自己的showOrder+1
						newFunctionlists = getXtMkJbxxListByParam(module.getId(), module.getPid(),null);
						if (!StringUtil.isEmpty(newFunctionlists)) {
							xt = newFunctionlists.get(0);
							// 修改排序
							if (xt.getShoworder()!=null) {
								xt.setShoworder(module.getShoworder()+1);
							}
							commonService.update(xt);
						}
					}else{
						//outHtmlString("<script type=\"text/javascript\">alert('此模块已排在最后，无法下移');this.location='functionManager.do?action=queryMkInfo'</script>");
						outHtmlString("4");
						return null;
					}
				}
				// 将更新操作写到操作日志中
				this.addDBOperationRpt(commonService, "XT_MK_JBXX", "UPDATE_SHOWORDER",module.getId());
				//outHtmlString("<script type=\"text/javascript\">alert('操作成功,请重新登录'); window.location='<%=path%>/login.do?type=refresh';window.location.reload;</script>");
				outHtmlString("1");
				return null;
			}else{
				updateMKInfo();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("2");	
			//outHtmlString("<script type=\"text/javascript\">alert('操作失败');this.location='functionManager.do?action=queryMkInfo'</script>");
			return null;
		}
		return null;
	}
	
	//根据参数获取功能节点信息,pid父节点,id功能ID,showOrder排序
	public List getXtMkJbxxListByParam(Long id,Long pid,Long showOrder) throws Exception{
		List funList = new ArrayList();
		String sql = "from XtMkJbxx n where 1=1 ";
		
		if(id!=null){
			sql += " and n.id="+id;
		}
		if(pid!=null){
			sql += " and n.pid="+ pid;
		}
//		if(!StringUtil.isBlank(fclevels)){
//			sql += " and n.fclevels='" + fclevels + "'";
//		}
		if(showOrder!=null){
			sql += " and n.showorder='" + showOrder + "'";
		}
		funList = this.commonService.find(sql);
		return funList;
	}
	
	
	public String updateMKInfo(){
		try {
			XtMkJbxx md = (XtMkJbxx) commonService.get(XtMkJbxx.class, module
					.getId());
			md.setMkmc(module.getMkmc());
			if(module.getMktype()!=1){	//菜单
				md.setMkurl(module.getMkurl());
				md.setHandler(null);
			}else{		//按钮
				md.setHandler(module.getHandler());
				md.setMkurl(null);
			}
			md.setMkms(module.getMkms());
			md.setZxbz(module.getZxbz());
			md.setMktype(module.getMktype());//0代表菜单 1代表按钮
			md.setShowlevel(module.getShowlevel());
			md.setShoworder(module.getShoworder());
			
			//更新子模块为无效
			if(module.getZxbz().equals("1")){//无效状态
				List allChildMk = this.commonService.find("from XtMkJbxx where pid="+module.getId());
				if(allChildMk!=null && allChildMk.size()>0){
					for(int i=0;i<allChildMk.size();i++){
						XtMkJbxx mk = (XtMkJbxx)allChildMk.get(i);
						mk.setZxbz("1");
						this.commonService.update(mk);
					}
				}
			}
			
			//更新父模块
			this.commonService.update(md);
			
			// 将更新操作写到操作日志中
			this.addDBOperationRpt(commonService, "XT_MK_JBXX", "UPDATE",module.getId());
			outHtmlString("<script type=\"text/javascript\">alert('i18n_FunctionManagerAction.updateMKInfo.success_n81i');this.location='functionManager.do?action=queryMkInfo'</script>");
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_FunctionManagerAction.updateMKInfo.faild_n81i');this.location='functionManager.do?action=queryMkInfo'</script>");
			return null;
		}
	}
	
	// 添加模块信息操作
	public String addMk() {
		try {
			if(module.getPid()==null){
				module.setPid(0l);
			}
			if(!module.getMktype().equals(1l)){	//菜单
				module.setHandler(null);
			}else{		//按钮
				module.setMkurl(null);
			}
			module.setCtime(new Date());
			module.setShowarea(0l);
			this.commonService.save(module);
			// 将添加操作写到操作日志中
			this.addDBOperationRpt(commonService, "XT_MK_JBXX", "INSERT",module.getId());
			outHtmlString("<script type=\"text/javascript\">alert('i18n_FunctionManagerAction.updateMKInfo.success_n81i');this.location='functionManager.do?action=queryMkInfo'</script>");
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_FunctionManagerAction.updateMKInfo.faild_n81i');this.location='functionManager.do?action=queryMkInfo'</script>");
			return null;
		}
	}
	
	// 注销模块信息操作
	public String delMk() {
		try {
			XtMkJbxx md = (XtMkJbxx) commonService.get(XtMkJbxx.class, module.getId());
			md.setZxbz("1");
			this.commonService.update(md);
			// 将添加操作写到操作日志中
			this.addDBOperationRpt(commonService, "XT_MK_JBXX", "UPDATE",
					module.getId());
			this.addDBOperationRpt(commonService, "XT_MK_JBXX", "INSERT",module.getId());
			outHtmlString("<script type=\"text/javascript\">alert('i18n_FunctionManagerAction.updateMKInfo.success_n81i');this.location='functionManager.do?action=queryMkInfo'</script>");
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_FunctionManagerAction.updateMKInfo.faild_n81i');this.location='functionManager.do?action=queryMkInfo'</script>");
			return null;
		}
	}
	
	public String getMaxShowOrder(){
		String jsonStr = null;
		
		List maxList = null;
		Long maxShow=0l;
		try {
			if("".equals(pid)){//主节点
				pid="0";
			}
			String sql="select max(showorder) from xt_mk_jbxx t where pid="+pid;
			maxList = commonService.executeSQL(sql);
			if(maxList!=null&&maxList.size()>0){
				if(maxList.get(0)!=null){
					maxShow = Long.parseLong(maxList.get(0).toString())+1;
				}else{
					maxShow = 1l;
				}
			}
			jsonStr = "{\"maxShowOrder\":\"" + maxShow + "\"}";
			this.outJson(jsonStr);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	// 查询模块信息
	public String queryMkInfo() {
		try {
			String sql = "from XtMkJbxx where 1=1 ";
			String sqlCondition = "where 1=1";// 将查询条件记录到操作日志中
			if (mkmc != null && !"".equals(mkmc)) {
				sql += " and mkmc like '%" + mkmc + "%'";
				sqlCondition += " and mkmc like '%" + mkmc + "%'";
			}
			if (mkms != null && !"".equals(mkms)) {
				sql += " and mkms like '%" + mkms + "%'";
				sqlCondition += " and mkms like '%" + mkms + "%'";
			}
			if(pmkmc!=null&&!"".equals(pmkmc)){
				sql +=  " and pid in  (select  id  from XtMkJbxx  x   where x.mkmc  like '%"+pmkmc+"%')";
				sqlCondition += " and pid in  (select  id  from XtMkJbxx  x  where x.mkmc  like '%"+pmkmc+"%')";
			}
			sql += "order by showlevel, showorder";
			allMkInfo = this.commonService.find(sql);
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "xt_mk_jbxx");
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return "ok";
	}
	
	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public CommonService getCommonService() {
		return commonService;
	}


	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
	}


	public String getMkmc() {
		return mkmc;
	}


	public void setMkmc(String mkmc) {
		this.mkmc = mkmc;
	}


	public List getAllMkInfo() {
		return allMkInfo;
	}


	public void setAllMkInfo(List allMkInfo) {
		this.allMkInfo = allMkInfo;
	}


	public Page getPage() {
		return page;
	}


	public void setPage(Page page) {
		this.page = page;
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


	public String getMkms() {
		return mkms;
	}


	public void setMkms(String mkms) {
		this.mkms = mkms;
	}


	public String getPmkmc() {
		return pmkmc;
	}


	public void setPmkmc(String pmkmc) {
		this.pmkmc = pmkmc;
	}

	public String getMkid() {
		return mkid;
	}


	public void setMkid(String mkid) {
		this.mkid = mkid;
	}


	public XtMkJbxx getModule() {
		return module;
	}


	public void setModule(XtMkJbxx module) {
		this.module = module;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}
	
}
