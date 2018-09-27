package nis.nms.web.actions.mission;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import nis.nms.domains.LoopmissionStateTable;
import nis.nms.domains.MissionParameterDefaults;
import nis.nms.domains.MissionParameterTable1;
import nis.nms.domains.MissionParameterTable2;
import nis.nms.domains.MissionStateTable;
import nis.nms.domains.XtYhJbxx;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Common;
import nis.nms.util.Constant;
import nis.nms.util.MD5Util;
import nis.nms.util.Page;

import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;


@SuppressWarnings("unchecked")
@Results( { 
	@Result(name="select", value = "/page/mission/smipleMission/missionInfoList.jsp"),
	@Result(name="add", value = "/page/mission/smipleMission/addMissionInfo.jsp"),
	@Result(name="view1", value = "/page/mission/smipleMission/examineMissionInfo1.jsp"),
	@Result(name="view2", value = "/page/mission/smipleMission/examineMissionInfo2.jsp"),
	@Result(name="error", value ="/error.jsp")
})
public class SimpleMissionAction  extends BaseAction{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	//--分页
	private Page page;
	private int pageNo = 1;
	private int pageSize =this.getDefaultPageSize();		//每页显示的记录条数
	//--请求 提示
	private String action;
	private String MSG;
	//--查询时间
	private String startTime;
	private String endTime;
	//--数据集合
	private MissionStateTable missionState;
	private MissionParameterTable1 missionParameter1;
	private MissionParameterTable2 missionParameter2;
	private LoopmissionStateTable loopmissionStateTable;
	private List<MissionStateTable> mstlist;
	private List<Object []> list;
//	private Object [] objs;
	//--文件上传
	private File upload;
	private String uploadFileName;
	//--相关参数
	private Integer nodeId;
	private String userName;
	//--其他
	private Long vlDid = new Long(1);	//查看权限字典表ID
	private Long mtDid =  new Long(3);		//任务类型字典表Id
	private Long mtbmDid =  new Long(7);	//任务类型别名字典表ID
	private Long msDid =  new Long(4);		//任务状态字典表ID
	private Long msdsDid =  new Long(5);	//定时任务状态字典表ID
	private Long rwcsDid =  new Long(6);	//任务参数字典表ID
	public String executeAction(){
		missionState = missionState == null? new MissionStateTable() : missionState;
		missionState.setSystemId((Long)this.getRequest().getSession().getAttribute(Constant.SESSION_SYSTEM_LOGIN));
		String resultpage = "";
		if("select1".equals(this.action)){
			missionState = missionState==null?new MissionStateTable():missionState;
			missionState.setMissionType(1l);
			resultpage = select();
		}else if("select2".equals(this.action)){
			missionState = missionState==null?new MissionStateTable():missionState;
			missionState.setMissionType(2l);
			resultpage = select();
		}else if("select".equals(this.action)){
			resultpage = select();
		}else if("add".equals(this.action)){
			resultpage = add();
		}else if("insert".equals(this.action)){
			resultpage = insert();
		}else if("view".equals(this.action)){
			resultpage = view();
		}else if("changeState".equals(this.action)){
			resultpage = changeState();
		}
		return resultpage;
	}
	
	private String select(){
		XtYhJbxx user = this.getUser();
		//查询业务系统
		String sysHql = "select DISTINCT(st.system_Id),st.system_Name from system_table st " +
				"left join Gorup_System_Table gst on gst.system_Id = st.system_Id " +
				"left join Xt_Yh_Js_Index xyji on xyji.jsbh = gst.user_Group_Id " +
				"where xyji.yhbh='"	+ user.getYhbh() + "' order by st.system_Id";
		//查询节点组
		String ngHql = "select DISTINCT(nt.group_Id),nt.group_Name,nt.system_Id from Nodegroup_Table nt "+
				"left join Gorup_System_Table gst on gst.system_Id = nt.system_Id " +
				"left join Xt_Yh_Js_Index xyji on xyji.jsbh = gst.user_Group_Id " +
				"where xyji.yhbh='"	+ user.getYhbh() + "'";
		String sql = spSql();
		try {
			//查询系统
			List<Object []> sysList = (List<Object []>)this.commonService.executeSQL(sysHql);
			this.getRequest().setAttribute("sysList", sysList);
			//查询节点组
			List<Object []> ngList = (List<Object []>)this.commonService.executeSQL(ngHql);
			this.getRequest().setAttribute("ngList", ngList);
			//任务状态
			List<Object []> msList = this.searchParameters(msDid,false);
			this.getRequest().setAttribute("msList", msList);
			//查看权限
			List<Object []> vlList = this.searchParameters(vlDid,false);
			this.getRequest().setAttribute("vlList", vlList);
			page = this.commonService.findByPageForSql(sql, pageNo, pageSize);
			list = (List<Object []>) page.getResult();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "select";
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
	private String add(){
		System.out.println("跳转到添加页面 操作");
		XtYhJbxx user = this.getUser();
		//查询业务系统
		String sysHql = "select DISTINCT(st.system_Id),st.system_Name from system_table st " +
				"left join Gorup_System_Table gst on gst.system_Id = st.system_Id " +
				"left join Xt_Yh_Js_Index xyji on xyji.jsbh = gst.user_Group_Id " +
				"where xyji.yhbh='"	+ user.getYhbh() + "' and st.system_state=0 order by st.system_Id";
		try {
			List<Object[]> sysList = (List<Object []>)this.commonService.executeSQL(sysHql);
			this.getRequest().setAttribute("sysList", sysList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "add";
	}
	private String  insert() {
		System.out.println("保存 任务及参数信息操作");
		String resultpage="";
		try {
			System.out.println("---getMissionType: "+missionState.getMissionType().intValue());
			if(missionState!=null){
//				Mission_type取值范围[1、5]
				switch (missionState.getMissionType().intValue()) {
				case 1:		//1—文件推送
					resultpage = addMissionParameter1();
					break;
				case 2:		//2—非流文本数据获取
					resultpage = addMissionParameter2();
					break;
				case 3:		//3—流文本数据获取
					break;
				case 4:		//4—命令执行
					break;
				case 5:		//5—shell注册
					break;
				default:
					System.out.println("任务类型错误~ Error");
				break;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultpage;
	}
	private String changeState(){
		System.out.println("停用任务操作");
		String state = this.getRequest().getParameter("state");
		try {
			if(state!=null){
				this.commonService.updateByHql("update MissionStateTable mst set mst.missionState = "+state+" where mst.missionId=?", missionState.getMissionId());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return select();
	}
	private String view() {
		StringBuffer sql = new StringBuffer();
		try {
			if(missionState!=null && missionState.getMissionType().equals(2l)){
				sql.append(" select st.mission_id,st.mission_name,st.create_Time,st.mission_state,otss.type_value,st.view_Level,otvl.type_value,st.user_id,xyj.yhbh,st.group_id,xjj.jsmc,st.system_id,s.system_Name,mpt.node_List_Id,nt.group_Name,IF(mpt.Filter_keyword is null,'不过滤','过滤'),mpt.Filter_keyword,mpt.mission_desc,st.is_loop,mpt.Loop_flag,mpt.Loop_start_date,mpt.Loop_end_date,mpt.Loop_delay");
				sql.append(" from Mission_State_Table st");
				sql.append(" left join Mission_Parameter_Table2 mpt on st.mission_id = mpt.mission_id");
				sql.append(" left join xt_js_jbxx xjj on xjj.jsbh = st.group_id");
				sql.append(" left join xt_yh_jbxx xyj on xyj.Yhid = st.user_id");
				sql.append(" left join Nodegroup_Table nt on nt.group_Id = mpt.node_List_Id ");
				sql.append(" left join system_table s on s.system_Id = st.system_Id");
				sql.append(" left join option_table otss on otss.type_code = st.mission_state");
				sql.append(" left join option_table otvl on otvl.type_code = st.view_Level");
				sql.append(" where otss.TYPE_IDENTITY = "+this.msdsDid+" and otvl.TYPE_IDENTITY ="+this.vlDid+" and  st.mission_id="+missionState.getMissionId());
				list = this.commonService.executeSQL(sql.toString());
				//查看权限
				List<Object []> vlList = this.searchParameters(vlDid,false);
				this.getRequest().setAttribute("vlList", vlList);
				return "view2" ;
			}else{
				sql.append(" select st.mission_id,st.mission_name,st.create_Time,st.mission_state,otss.type_value,st.view_Level,otvl.type_value,st.user_id,xyj.yhbh,st.group_id,xjj.jsmc,st.system_id,s.system_Name,mpt.node_List_Id,nt.group_Name,mpt.target_path,mpt.mission_desc");
				sql.append(" from Mission_State_Table st");
				sql.append(" left join Mission_Parameter_Table1 mpt on st.mission_id = mpt.mission_id");
				sql.append(" left join xt_js_jbxx xjj on xjj.jsbh = st.group_id");
				sql.append(" left join xt_yh_jbxx xyj on xyj.Yhid = st.user_id");
				sql.append(" left join Nodegroup_Table nt on nt.group_Id = mpt.node_List_Id ");
				sql.append(" left join system_table s on s.system_Id = st.system_Id");
				sql.append(" left join option_table otss on otss.type_code = st.mission_state");
				sql.append(" left join option_table otvl on otvl.type_code = st.view_Level");
				sql.append(" where otss.TYPE_IDENTITY = "+this.msdsDid+" and otvl.TYPE_IDENTITY ="+this.vlDid+" and  st.mission_id="+missionState.getMissionId());
				list = this.commonService.executeSQL(sql.toString());
				//查看权限
				List<Object []> vlList = this.searchParameters(vlDid,false);
				this.getRequest().setAttribute("vlList", vlList);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "view1" ;
	}
	//sql拼接
	private String spSql(){
//		System.out.println("split HQL");
		XtYhJbxx user = this.getUser();
		StringBuffer hql = new StringBuffer();
		hql.append("select DISTINCT(st.mission_id) mission_id,st.mission_name,st.system_id,s.system_Name,st.mission_type,st.mission_state,mpt.node_List_Id,nt.group_Name,st.view_Level, xyj.yhid, xyj.yhbh,st.create_Time from Mission_State_Table st ");
		if(missionState.getMissionType().equals(1l)){		//应用升级
			hql.append("left join Mission_Parameter_Table1 mpt on st.mission_id = mpt.mission_id ");
		}else if(missionState.getMissionType().equals(2l)){		//配置正确性验证
			hql.append("left join Mission_Parameter_Table2 mpt on st.mission_id = mpt.mission_id ");
		}
		hql.append("left join Gorup_System_Table gst on gst.system_Id = st.system_Id ");	
		hql.append("left join xt_yh_jbxx xyj on xyj.yhId = st.user_id ");
//		--
		hql.append("left join Xt_Yh_Js_Index xyjig on xyjig.jsbh = gst.user_group_id ");
//		--
		hql.append("left join Xt_Yh_Js_Index xyjis on xyjis.jsbh = st.group_id ");
		hql.append("left join Nodegroup_Table nt on nt.group_Id = mpt.node_List_Id ");
		hql.append("left join system_table s on s.system_Id = st.system_Id ");
		hql.append("where ((st.user_id ="+user.getYhid()+") or (st.view_Level = 2 and xyjis.yhid = "+user.getYhid()+" and xyjis.type=1) or (st.view_Level = 3 and xyjig.yhid = "+user.getYhid()+")) ");
		if(missionState!=null){
			if(nodeId!=null && !nodeId.equals(0)){
				hql.append(" and mpt.node_List_Id ="+nodeId);
			}
			if(missionState.getMissionName()!=null && !"".equals(missionState.getMissionName().trim())){
				hql.append(" and st.mission_name like '%"+missionState.getMissionName().trim()+"%' ");
			}
			if(missionState.getSystemId()!=null && !missionState.getSystemId().equals(0l)){
				hql.append(" and st.system_id ="+missionState.getSystemId());
			}
			if(missionState.getMissionState()!=null && !missionState.getMissionState().equals(0l)){
				hql.append(" and st.mission_state ="+missionState.getMissionState());
			}
			if(missionState.getViewLevel()!=null && !missionState.getViewLevel().equals(0l)){
				hql.append(" and st.view_level ="+missionState.getViewLevel());
			}
			if(userName!=null && !"".equals(userName.trim())){
				hql.append(" and xyj.yhbh like '%"+userName.trim()+"%' ");
			}
			if(startTime!=null && !"".equals(startTime)){
				hql.append(" and st.create_time >="+startTime);
			}
			if(endTime!=null && !"".equals(endTime)){
				hql.append(" and st.create_time ="+endTime);
			}
		}
		hql.append(" and st.mission_name in('"+getI18nText("i18n_SimpleMissionAction.check.appUpdate_n81i")+"','"+getI18nText("i18n_SimpleMissionAction.check.validateConfig_n81i")+"')");
		hql.append(" and st.mission_Type = "+missionState.getMissionType()+" ");
		hql.append("order by st.mission_id desc");
		return hql.toString();
	}
	//应用升级任务添加方法
	@SuppressWarnings("static-access")
	private String addMissionParameter1(){
		try {
			XtYhJbxx user = this.getUser();
			//保存上传文件
			String uploadFilePath = getConfigValue("uploadServerPath");
			Date date = new Date();
			if(uploadFilePath.lastIndexOf(File.separator)==uploadFilePath.length()){//获取保存路径
				uploadFilePath.substring(0,uploadFilePath.length()-File.separator.length());
			}
			File file = new File(uploadFilePath);
			if(!file.exists()){
				file.mkdirs();
			}
			String newName = Common.addTimeTagForUploadFileName(uploadFileName);
			uploadFilePath +=newName;
			this.copy(upload, new File(uploadFilePath));
			//获取默认参数
			String paraHQL = "from MissionParameterDefaults pd where pd.missionType="+missionState.getMissionType()+" and pd.systemId="+missionState.getSystemId();
			List<MissionParameterDefaults> list  = (List<MissionParameterDefaults>)this.commonService.find(paraHQL);
			if(list!=null && list.size()>0){
				MissionParameterDefaults defaults = list.get(0);
				
				missionState.setMissionName(defaults.getMissionTypeName());
				missionState.setMissionState(1l);
				missionState.setMissionType(1l);
				missionState.setStartTime(defaults.getStartTime());
				missionState.setEndTime(defaults.getEndTime());
				missionState.setCreateTime(new Date());
				missionState.setGroupId(defaults.getGroupId());
				missionState.setStartTime(defaults.getStartTime());
				missionState.setEndTime(defaults.getEndTime());
				missionState.setUserId(user.getYhid());
				missionState.setViewLevel(defaults.getViewLevel());
				
				MissionParameterTable1 parameterTable1 = new MissionParameterTable1();
				parameterTable1.setNodeListId(this.missionParameter1.getNodeListId());
				//转换为MD5
				MD5Util md5 = new MD5Util();
				parameterTable1.setCheckValue(md5.getFileMD5String(new File(uploadFilePath)));
				parameterTable1.setSourcePath(newName);
				parameterTable1.setTargetPath(defaults.getTargetPath());
				
				this.commonService.save(missionState);
				parameterTable1.setMissionId(missionState.getMissionId());
				this.commonService.save(parameterTable1);
				MSG = "i18n_SimpleMissionAction.check.saveSuccess_n81i";
				missionState = new MissionStateTable();
				outHtmlString("<script type=\"text/javascript\">alert('"+MSG+"');this.location='simpleMission.do?action=select1'</script>");
			}else{
				MSG = "i18n_SimpleMissionAction.check.message1_n81i";
				outHtmlString("<script type=\"text/javascript\">alert('"+MSG+"');this.history.go(-1);</script>");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	//配置验证任务添加方法
	private String addMissionParameter2(){
		try {
			XtYhJbxx user = this.getUser();
			
//			String uploadFilePath = getConfigValue("uploadServerPath");
//			Date date = new Date();
//			if(uploadFilePath.lastIndexOf(File.separator)==uploadFilePath.length()){//获取保存路径
//				uploadFilePath.substring(0,uploadFilePath.length()-File.separator.length());
//			}
//			File file = new File(uploadFilePath);
//			if(!file.exists()){
//				file.mkdirs();
//			}
//			String newName = Common.addTimeTagForUploadFileName(uploadFileName);
//			uploadFilePath +=newName;
//			this.copy(upload, new File(uploadFilePath));
			String paraHQL = "from MissionParameterDefaults pd where pd.missionType="+missionState.getMissionType()+" and pd.systemId="+missionState.getSystemId();
			List<MissionParameterDefaults> list  = (List<MissionParameterDefaults>)this.commonService.find(paraHQL);
			
			if(list!=null && list.size()>0){
				MissionParameterDefaults defaults = list.get(0);
				missionState.setMissionName(defaults.getMissionTypeName());
				missionState.setStartTime(defaults.getStartTime());
				missionState.setEndTime(defaults.getEndTime());
				missionState.setCreateTime(new Date());
				missionState.setGroupId(defaults.getGroupId());
				missionState.setUserId(user.getYhid());
				missionState.setViewLevel(defaults.getViewLevel());
				missionState.setLoopDelay(defaults.getLoopDelay());
				MissionParameterTable2 parameterTable2 = new MissionParameterTable2();
				if("0".equals(this.getRequest().getParameter("filterFlag"))){
					parameterTable2.setFilterKeyword(defaults.getFilterKeyword());
				}
				parameterTable2.setFilePath(missionParameter2.getFilePath());
				parameterTable2.setNodeListId(defaults.getNodeListId());
				parameterTable2.setStartFlag(missionParameter2.getStartFlag());
				parameterTable2.setEndFlag(missionParameter2.getEndFlag());
//				parameterTable2.setFilterKeyword(this.missionParameter2.getFilterKeyword().trim());
				if(defaults.getLoopFlag()==0){//不是定时任务
					missionState.setMissionState(1l);
					parameterTable2.setLoopFlag(defaults.getLoopFlag());
				}else{//定时任务处理
					missionState.setMissionState(0l);
					parameterTable2.setLoopFlag(defaults.getLoopFlag());
					parameterTable2.setLoopStartDate(defaults.getLoopStartDate());					
					parameterTable2.setLoopEndDate(defaults.getLoopEndDate());
					parameterTable2.setLoopDelay(defaults.getLoopDelay());
				}
				parameterTable2.setMaxReturn(defaults.getMaxReturn());
				parameterTable2.setStartFlag(defaults.getStartFlag());
				parameterTable2.setEndFlag(defaults.getEndFlag());
				this.commonService.save(missionState);
				parameterTable2.setMissionId(missionState.getMissionId());
				this.commonService.save(parameterTable2);
				MSG = "i18n_SimpleMissionAction.check.saveSuccess_n81i";
				missionState = new MissionStateTable();
				outHtmlString("<script type=\"text/javascript\">alert('"+MSG+"');this.location='simpleMission.do?action=select2'</script>");
			}else{
				MSG = "i18n_SimpleMissionAction.check.message2_n81i";
				outHtmlString("<script type=\"text/javascript\">alert('"+MSG+"');this.history.go(-1);</script>");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
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

	public MissionStateTable getMissionState() {
		return missionState;
	}

	public void setMissionState(MissionStateTable missionState) {
		this.missionState = missionState;
	}

	public List<MissionStateTable> getMstlist() {
		return mstlist;
	}

	public void setMstlist(List<MissionStateTable> mstlist) {
		this.mstlist = mstlist;
	}

	public List<Object[]> getList() {
		return list;
	}

	public void setList(List<Object[]> list) {
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

	public String getMSG() {
		return MSG;
	}

	public void setMSG(String msg) {
		MSG = msg;
	}

	public File getUpload() {
		return upload;
	}

	public void setUpload(File upload) {
		this.upload = upload;
	}

	public String getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public Integer getNodeId() {
		return nodeId;
	}

	public void setNodeId(Integer nodeId) {
		this.nodeId = nodeId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public LoopmissionStateTable getLoopmissionStateTable() {
		return loopmissionStateTable;
	}

	public void setLoopmissionStateTable(LoopmissionStateTable loopmissionStateTable) {
		this.loopmissionStateTable = loopmissionStateTable;
	}
//	public static void main(String [] args) {
//		SimpleMissionAction action = new SimpleMissionAction();
//		CommonService service = new CommonService();
//		DetectionSetInfo old;
//		try {
//			old = (DetectionSetInfo) service.get(DetectionSetInfo.class, 5l);
//			DetectionSetInfo news = (DetectionSetInfo) service.get(DetectionSetInfo.class, 5l);
//			action.sendSetInfo(old, news);
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}finally{
//			
//		}
//	}
}
