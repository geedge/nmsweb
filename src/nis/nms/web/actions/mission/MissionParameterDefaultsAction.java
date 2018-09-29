package nis.nms.web.actions.mission;

import java.util.ArrayList;
import java.util.List;

import nis.nms.domains.MissionParameterDefaults;
import nis.nms.domains.MissionParameterTable1;
import nis.nms.domains.MissionParameterTable2;
import nis.nms.domains.MissionStateTable;
import nis.nms.domains.NodegroupTable;
import nis.nms.domains.SystemTable;
import nis.nms.domains.XtJsJbxx;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Constant;
import nis.nms.util.Page;

import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;


@SuppressWarnings("unchecked")
@Results( { 
	@Result(name="select", value = "/page/mission/parameterDefaults/defaultsInfoList.jsp"),
	@Result(name="add", value = "/page/mission/parameterDefaults/addDefaultsInfo.jsp"),
	@Result(name="edit", value = "/page/mission/parameterDefaults/updateDefaultsInfo.jsp"),
	@Result(name="view1", value = "/page/mission/parameterDefaults/examineDefaultsInfo1.jsp"),
	@Result(name="view2", value = "/page/mission/parameterDefaults/examineDefaultsInfo2.jsp"),
	@Result(name="error", value ="/error.jsp")
})
public class MissionParameterDefaultsAction  extends BaseAction{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	private int pageNo = 1;
	private int pageSize =this.getDefaultPageSize();		//每页显示的记录条数
//	private MD5 md5 = new MD5();
	private Page page;
	private String action;
	private String MSG;
	private int MSGFlag;		//判断业务系统和任务类型校验唯一的标记[0,1] 1：有效，0：无效
	private MissionStateTable missionState;
	private MissionParameterDefaults parameterDefaults;
	private List<MissionParameterDefaults> list;
	private MissionParameterTable1 missionParameter1;
	private MissionParameterTable2 missionParameter2;
	//--其他
	private Long ckqxDid = new Long(1);	//查看权限字典表ID
	private Long mtDid =  new Long(3);		//任务类型字典表Id
	private Long mtbmDid =  new Long(7);	//任务类型别名字典表ID
	private Long msDid =  new Long(4);		//任务状态字典表ID
	private Long msdsDid =  new Long(5);	//定时任务状态字典表ID
	private Long rwcsDid =  new Long(6);	//任务参数字典表ID
	public String executeAction(){
		missionState = missionState == null? new MissionStateTable() : missionState;
		missionState.setSystemId((Long)this.getRequest().getAttribute(Constant.SESSION_SYSTEM_LOGIN));
		System.out.println("*** executeAction ***");
		String resultpage = "";
		if("select".equals(this.action)){
			resultpage = select();
		}else if("add".equals(this.action)){
			resultpage = add();
		}else if("insert".equals(this.action)){
			resultpage = insert();
		}else if("view".equals(this.action)){
			resultpage = view();
		}else if("delete".equals(this.action)){
			resultpage = delete();
		}else if("check".equals(this.action)){
			resultpage = check();
		}
//		else if("edit".equals(this.action)){
//			resultpage = edit();
//		}
//		else if("update".equals(this.action)){
//			resultpage = update();
//		}
		return resultpage;
	}
	
	private String select(){
//		XtYhJbxx user = this.getUser();
		
		String sysHql = "select st.system_Id,st.system_Name from system_table st where st.system_state = 0";
		
		String ngHql = "select nt.group_Id,nt.group_Name,nt.system_Id from Nodegroup_Table nt";
		String sql = spSql();
		try {
			//查询系统
			List<Object []> sysList = (List<Object []>)this.commonService.executeSQL(sysHql);
			this.getRequest().setAttribute("sysList", sysList);
			//查询节点组
			List<Object []> ngList = (List<Object []>)this.commonService.executeSQL(ngHql);
			this.getRequest().setAttribute("ngList", ngList);
//			//任务状态
//			List<Object []> msList = this.searchParameters(msDid,false);
//			this.getRequest().setAttribute("msList", msList);
			//任务类型
			List<Object []> mtList = this.searchParameters(mtDid,false);
			this.getRequest().setAttribute("mtList", mtList);
//			//查看权限
//			List<Object []> vlList = this.searchParameters(ckqxDid,false);
//			this.getRequest().setAttribute("vlList", vlList);
			page = this.commonService.findByPageForSql(sql, pageNo, pageSize);
			list = (List<MissionParameterDefaults>) page.getResult();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "select";
	}
	//sql拼接
	private String spSql(){
		StringBuffer hql = new StringBuffer();
		hql.append("select mpd.id,mpd.mission_type_name, mpd.mission_type, mpd.system_id, st.system_name, mpd.node_list_id, nt.Group_name from Mission_Parameter_Defaults mpd ");
		hql.append("left join system_table st on st.system_id = mpd.system_id ");
		hql.append("left join nodegroup_table nt on  nt.Group_id = mpd.node_list_id ");
		hql.append("where 1=1 ");
		if(parameterDefaults!=null){
		if(parameterDefaults.getMissionType()!=null && !parameterDefaults.getMissionType().equals(0l)){//应用升级
			hql.append("and mpd.mission_type="+parameterDefaults.getMissionType());
		}
		if(parameterDefaults.getNodeListId()!=null && !parameterDefaults.getNodeListId().equals(0)){
			hql.append(" and mpd.node_List_Id ="+parameterDefaults.getNodeListId());
		}
//		if(parameterDefaults.getNodeListId()!=null && !parameterDefaults.getNodeListId().equals(0)){
//			hql.append(" and mpt.node_List_Id ="+parameterDefaults.getNodeListId());
//		}
//			if(missionState.getMissionName()!=null && !"".equals(missionState.getMissionName().trim())){
//				hql.append(" and st.mission_name like '%"+missionState.getMissionName().trim()+"%' ");
//			}
//			if(missionState.getSystemId()!=null && !missionState.getSystemId().equals(0l)){
//				hql.append(" and st.system_id ="+missionState.getSystemId());
//			}
//			if(missionState.getMissionState()!=null && !missionState.getMissionState().equals(0l)){
//				hql.append(" and st.mission_state ="+missionState.getMissionState());
//			}
//			if(missionState.getViewLevel()!=null && !missionState.getViewLevel().equals(0l)){
//				hql.append(" and st.view_level ="+missionState.getViewLevel());
//			}
//			if(userName!=null && !"".equals(userName.trim())){
//				hql.append(" and xyj.yhbh like '%"+userName.trim()+"%'");
//			}
//			if(startTime!=null && !"".equals(startTime)){
//				hql.append(" and st.create_time >="+startTime);
//			}
//			if(endTime!=null && !"".equals(endTime)){
//				hql.append(" and st.create_time ="+endTime);
//			}
		}
//		hql.append(" and st.mission_Type = "+missionState.getMissionType()+" ");
		hql.append("order by mpd.id desc");
		return hql.toString();
	}
	private String add(){
		System.out.println("跳转到添加页面 操作");
//		XtYhJbxx user = this.getUser();
		String sysSql = "select DISTINCT(st.system_Id),st.system_Name from system_table st where st.system_state = 0";
		String ngSql = "select nt.group_Id,nt.group_Name,nt.system_Id from Nodegroup_Table nt";
		String groupSql = "select xjj.jsbh,xjj.jsmc,st.system_Id from xt_js_jbxx xjj" +
				" left join gorup_system_table gst on gst.user_group_id = xjj.jsbh " +
				" left join system_table st on st.system_id= gst.system_id " +
				" where st.system_state = 0 and xjj.zxbz=0 and xjj.type=1";
		try {
			//查询系统
			List<Object []> sysList = (List<Object []>)this.commonService.executeSQL(sysSql);
			this.getRequest().setAttribute("sysList", sysList);
			//查询节点组
			List<Object []> ngList = (List<Object []>)this.commonService.executeSQL(ngSql);
			this.getRequest().setAttribute("ngList", ngList);
			//查询节点组
			List<Object []> groupList = (List<Object []>)this.commonService.executeSQL(groupSql);
			this.getRequest().setAttribute("groupList", groupList);
			//任务类型
			List<Object []> mtbmList = this.searchParameters(mtbmDid,false);
			this.getRequest().setAttribute("mtList", mtbmList);
			//查看权限
			List<Object []> vlList = this.searchParameters(ckqxDid,false);
			this.getRequest().setAttribute("vlList", vlList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "add";
	}
	
	public List<Object []> searchParameters(Long dId,boolean stateFlag) {
		String sql="select ot.type_code,ot.type_value from option_table ot " +
				"left join dictionary_table dt on dt.id = ot.TYPE_IDENTITY " +
				"where dt.id= "+dId.longValue()+" ";
		if(stateFlag){
			sql +=" and ot.type_state=0 and dt.type_state =0 ";
		}
		try {
			return this.commonService.executeSQL(sql, dId);
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<Object[]>();
		}
	}
	private String check() {
		try {
			List list = this.commonService.find("from MissionParameterDefaults mpd where mpd.systemId=? and mpd.missionType=?", parameterDefaults.getSystemId(), parameterDefaults.getMissionType());
			if(list!=null && list.size()>0){
				MSG = getI18nText("i18n_MissionParameterDefaultsAction.check.configExists_n81i");
				MSGFlag=0;//无效配置
			}else{
				MSGFlag=1;//有效配置
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return add();
	}
	private String  insert() {
		System.out.println("保存 任务及参数信息操作");
		try {
			if(parameterDefaults!=null){
				System.out.println("---"+parameterDefaults.getCheckValue());
				System.out.println("---"+parameterDefaults.getFilterKeyword());
				System.out.println("---"+parameterDefaults.getTargetPath());
				this.commonService.save(parameterDefaults);
				parameterDefaults = new MissionParameterDefaults();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return select();
	}
	private String delete(){
		System.out.println("停用任务操作");
		if(parameterDefaults!=null && parameterDefaults.getId()!=null && !parameterDefaults.getId().equals(0l)){
			try {
//				this.commonService.delete(entityClass, propertyName, propertyValue);
			} catch (Exception e) {
				// TODO: handle exception
			}
		}
		return select();
	}
	private String view() {
		System.out.println("参数信息");
		try {
		if(parameterDefaults!=null && parameterDefaults.getId()!=null && parameterDefaults.getId().equals(0l)){
			parameterDefaults = (MissionParameterDefaults)this.commonService.get(MissionParameterDefaults.class, parameterDefaults.getId());
		}
		//查询系统
		if(parameterDefaults!=null){
			if(parameterDefaults.getSystemId()!=null){
				this.getRequest().setAttribute("sys", this.commonService.get(SystemTable.class, parameterDefaults.getSystemId()));
			}
			if(parameterDefaults.getNodeListId()!=null){
				this.getRequest().setAttribute("nod", this.commonService.get(NodegroupTable.class, parameterDefaults.getNodeListId()));
			}
			if(parameterDefaults.getGroupId()!=null){
				this.getRequest().setAttribute("xtj", this.commonService.get(XtJsJbxx.class, parameterDefaults.getGroupId()));
			}
		}
		//任务类型
		List<Object []> mtbmList = this.searchParameters(mtbmDid,false);
		this.getRequest().setAttribute("mtList", mtbmList);
		//查看权限
		List<Object []> vlList = this.searchParameters(ckqxDid,false);
		this.getRequest().setAttribute("vlList", vlList);
		
		if(parameterDefaults.getMissionType().equals(1l)){
			return "view1" ;
		}else if (parameterDefaults.getMissionType().equals(2l)) {
			return "view2" ;
		}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "view1";
	}
	private String spHql(){
		System.out.println("split HQL");
		StringBuffer hql = new StringBuffer("from MissionStateTable");
		return hql.toString();
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

	public String getMSG() {
		return MSG;
	}

	public void setMSG(String msg) {
		MSG = msg;
	}

	public List<MissionParameterDefaults> getList() {
		return list;
	}

	public void setList(List<MissionParameterDefaults> list) {
		this.list = list;
	}

	public MissionParameterTable1 getMissionParameter1() {
		return missionParameter1;
	}

	public void setMissionParameter1(MissionParameterTable1 missionParameter1) {
		this.missionParameter1 = missionParameter1;
	}

	public MissionParameterTable2 getMissionParameter2() {
		return missionParameter2;
	}

	public void setMissionParameter2(MissionParameterTable2 missionParameter2) {
		this.missionParameter2 = missionParameter2;
	}

	public MissionStateTable getMissionState() {
		return missionState;
	}

	public void setMissionState(MissionStateTable missionState) {
		this.missionState = missionState;
	}

	public MissionParameterDefaults getParameterDefaults() {
		return parameterDefaults;
	}

	public void setParameterDefaults(MissionParameterDefaults parameterDefaults) {
		this.parameterDefaults = parameterDefaults;
	}

	public int getMSGFlag() {
		return MSGFlag;
	}

	public void setMSGFlag(int flag) {
		MSGFlag = flag;
	}
}
