package nis.nms.web.actions.nodeGroupManage;

import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import net.sf.json.JSONArray;
import nis.nms.core.Resource;
import nis.nms.domains.NodePosition;
import nis.nms.domains.NodeTable;
import nis.nms.domains.NodegroupTable;
import nis.nms.domains.SystemTable;
import nis.nms.domains.XtJsJbxx;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.ExportUtils;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;


@SuppressWarnings("unchecked")
@Results( {
		@Result(name = "queryNodeGroupInfo", value = "/page/systemManage/nodeGroupManage/nodegroupInfoList.jsp"),		
		@Result(name="nodeMgmtList", value = "/page/systemManage/nodeGroupManage/nodeMgmtList.jsp"),
		@Result(name = "toSelectNodeGroup", value = "/page/systemManage/nodeGroupManage/toSelectNodeGroup.jsp"),
		@Result(name = "toSelectNodeAndNodeGroup", value = "/page/systemManage/nodeGroupManage/toSelectNodeAndNodeGroup.jsp"),
		@Result(name = "showError", value = "/page/systemManage/nodeGroupManage/showImportError.jsp"),
		@Result(name = "error", value = "/error.jsp") })
public class NodeGroupManageAction extends BaseAction {
	
	private Logger logger = Logger.getLogger(NodeGroupManageAction.class);
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	
//	private int pageNo = 1;
//	private int pageSize = this.getDefaultPageSize(); // 每页显示的记录条数
//	private Page page;
	
	private String action;// 系统操作
	private String position;
	//===========================
	private List<NodegroupTable> nodeGroupList;//节点组列表
	private NodegroupTable nodeGroup;//节点组
	private Long nodeGroupId;
	private Long[] ids;//节点组id集合
	private Set<String> selectedNodeGroupIds = new HashSet<String>();//停用或启用时选中的节点及所有子节点
	private Set<String> leafNodeGroupIdsByPar = new HashSet<String>();//根据父节点组id得到所有叶子节点组id：从给的父节点组id，找到对应的叶子节点组id
	private Set<String> nodeIds = new HashSet<String>();//停用或启用时叶子节点组下的节点id
	private Map<String,String> nodeGroupMap = new HashMap<String,String>();//停用或启用时叶子节点组下的叶子节点组id和节点组下的节点id的map
	private Set<String> leafNodeGroupIds = new HashSet<String>();//停用或启用时选中的节点中的所有叶子节点组的id：从所给的节点组id中筛选叶子节点组
	private List<XtJsJbxx> allUserGroup;//当前用户有权限的用户组
	private String isStartSubNodeGroup;//启用节点组的时候是否同时启用子节点组，1：是，0：否
	
	//查询条件
	private String nameVo;
	private String descVo;
	
	private String showStopNGroup;	// 是否显示下线节点组
	
	private List<Resource> treeList;//当前用户有权限的业务系统
	private SystemTable system;//当前登录选择的业务系统
	private List<SystemTable> systemList;
	
	private List<NodeTable> nodeList;//节点列表
	private String groupId;//当前选中的节点组id，用于查询此节点组下的所有节点
	
	private String fromWhere;
	private String isComplete;
	//配置向导标志 type=config标识是从配置向导发出的请求
	private String type;
	
	// 导入节点文件
	private File myFile;
	private String myFileFileName;

	public File getMyFile() {
		return myFile;
	}

	public void setMyFile(File myFile) {
		this.myFile = myFile;
	}

	public String getMyFileFileName() {
		return myFileFileName;
	}

	public void setMyFileFileName(String myFileFileName) {
		this.myFileFileName = myFileFileName;
	}
	
	public String executeAction() {
		String resultPage = "";
		try {
			getInitInfo();//获取用户组及业务系统信息
			this.getRequest().setAttribute("fromWhere", fromWhere);
			// 节点组管理
			if (action.equals("queryNodeGroupInfo")) {// 查询部门信息
				resultPage = queryNodeGroupInfo();
			}else if(action.equals("updateNodeGroup")){//提交修改节点组信息,之后返回列表
				resultPage = updateNodeGroupInfo();
			}else if(action.equals("addNodeGroup")){//提交添加节点组信息
				resultPage = addNodeGroupInfo();
			}else if(action.equals("stopNodeGroup")){//停用节点组
				resultPage=stopNodeGroupInfo();
			}else if(action.equals("startNodeGroup")){//启用节点组
				resultPage = startNodeGroupInfo();
			}else if(action.equals("nodeMgmt")){//节点管理:转向节点管理页面
				resultPage = nodeMgmtList();
			}else if(action.equals("toSelectNodeGroup")) {//新增任务：节点组选择
				resultPage = toSelectNodeGroup();
			}else if(action.equals("toSelectNodeAndNodeGroup")) {//新增监测设置：节点组、节点选择
				resultPage = toSelectNodeAndNodeGroup();
			}else if ("downloadExample".equals(this.action)) {
				resultPage = downloadExample();
			}else if ("importXls".equals(this.action)) {
				resultPage = importXls();
			}else if ("emportXls".equals(this.action)) {
				resultPage = emportXls();
			}else if(action.equals("getNodesByNodeGroupId")) {//根据节点组获得节点
				resultPage = getNodesByNodeGroupId();
			}

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
		return resultPage;
	}

	// 模板下载   程辉 2013-5-13新增
	public String downloadExample() {
		try {
			String hql = "select groupName,groupDesc,parentGroupId from NodegroupTable";			
			List st= (List)this.commonService.findByPage(hql, 1, 3).getResult();
			
			List<NodegroupTable> NodegroupTablelist = commonService.find("from NodegroupTable");
			
			for (int j = 0; j < st.size(); j++) {
				boolean isHave = false;
				for (int i = 0; i < NodegroupTablelist.size(); i++) {
					if (NodegroupTablelist.get(i).getGroupId().equals(
							((Object[]) st.get(j))[2])) {
						((Object[]) st.get(j))[2] = NodegroupTablelist.get(i)
								.getGroupName();
						isHave=true;
					}
				}
				if(!isHave){
					((Object[]) st.get(j))[2] = "";
				}
			}
			
			String[] title = { getI18nText("i18n_NodeGroupManageAction.downloadExample.title.nodeGroupName_n81i"), 
								getI18nText("i18n_NodeGroupManageAction.downloadExample.title.groupDesc_n81i"),
								getI18nText("i18n_NodeGroupManageAction.downloadExample.title.parentGroup_n81i") };
	
			String[] colu = { "0", "1","2" };
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(getI18nText("i18n_NodeGroupManageAction.downloadExample.nodeGroupInfo_n81i"), st, title, colu,"downloadExample");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	// 导入 程辉 2013-5-8新增
	public String importXls() {
		String errorInfo = "";
		try {
			List<String> headerList = new ArrayList<String>();
			List<List<String>> rowList = new ArrayList<List<String>>();

			Workbook workbook = null;
			if (myFileFileName.endsWith(".xlsx")) {
				workbook = new XSSFWorkbook(new FileInputStream(myFile));
			} else {
				// 创建对Excel工作簿文件的引用
				workbook = new HSSFWorkbook(new FileInputStream(myFile));
			}

			// 创建对工作表的引用，得到表的第一页
			Sheet sheet = workbook.getSheetAt(0);
			// 读取左上端单元

			// 记录存储数据条数
			int count = 0;
			// 记录读入excel数据条数
			int sum = (sheet.getLastRowNum());
			for (short i = 1; i <= sheet.getLastRowNum(); i++) {
				String groupName ="";
				String groupDesc ="";
				String parentGroupName ="";
				List<String> errorList = new ArrayList<String>();
				Row row = sheet.getRow(i);
				Cell cell_1 = row.getCell((short) 0);
				Cell cell_2 = row.getCell((short) 1);
				Cell cell_3 = row.getCell((short) 2);
				if ((null == cell_1 || 3 == cell_1.getCellType())
						&& (null == cell_2 || 3 == cell_2.getCellType())
						&& (null == cell_3 || 3 == cell_3.getCellType())) {
					sum--;
				}else {
					// 节点组名称
					if (null == cell_1||cell_1.getCellType()==Cell.CELL_TYPE_BLANK) {
						errorInfo +=  getI18nText("i18n_NodeGroupManageAction.downloadExample.errorInfo1_n81i",i+"");
					} else if (cell_1.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_1.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_NodeGroupManageAction.downloadExample.errorInfo1_n81i",i+"");
						} else {
							groupName = cell_1.getStringCellValue().trim();
						}
					} else {
						errorInfo +=  getI18nText("i18n_NodeGroupManageAction.downloadExample.errorInfo2_n81i",i+"");
					}

					// 组描述
					if (null == cell_2||cell_2.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_2.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_2.getStringCellValue())) {
						} else {
							groupDesc = cell_2.getStringCellValue()
									.trim();
							if(groupDesc.length()>128){
								errorInfo +=  getI18nText("i18n_NodeGroupManageAction.downloadExample.errorInfo3_n81i",i+"");
							}
						}
					}
					// 父级组
					if(null == cell_3||cell_3.getCellType()==Cell.CELL_TYPE_BLANK){
					}else if (cell_3.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						parentGroupName =String.valueOf((int)cell_3.getNumericCellValue());
					}else if (cell_3.getCellType() == Cell.CELL_TYPE_STRING) {
						parentGroupName =cell_3.getStringCellValue().trim();
					} else {
						errorInfo +=  getI18nText("i18n_NodeGroupManageAction.downloadExample.errorInfo4_n81i",i+"");
					}
					
					if ("".equals(errorInfo)) {// 保存节点
						errorInfo = this.saveNode(groupName,groupDesc,parentGroupName);
					}
					if ("".equals(errorInfo)) {
						count++;
					} else {
						errorList.add(groupName);
						errorList.add(groupDesc);
						errorList.add(parentGroupName);
						errorList.add(errorInfo);
						rowList.add(errorList);
						errorInfo = "";

					}
				}
			}
			headerList.add(getI18nText("i18n_NodeGroupManageAction.downloadExample.nodeGroupName_n81i"));
			headerList.add(getI18nText("i18n_NodeGroupManageAction.downloadExample.groupDesc_n81i"));
			headerList.add(getI18nText("i18n_NodeGroupManageAction.downloadExample.parentGroupId_n81i"));
			headerList.add(getI18nText("i18n_NodeGroupManageAction.downloadExample.errorInfo_n81i"));
			this.getRequest().setAttribute("rowList", rowList);
			this.getRequest().setAttribute("headerList", headerList);
			if (count == sum && sum > 0) {
//				this.getRequest().setAttribute("MSG", 1);
//				return this.queryNodeGroupInfo();
				outHtmlString("<script type=\"text/javascript\">alert('i18n_NodeGroupManageAction.downloadExample.success_n81i');this.location='nodeGroupManage!execute.do?action=queryNodeGroupInfo&showStopNGroup="+showStopNGroup+"'</script>");
				return null;
			} else if (sum == 0) {
				outHtmlString("<script>alert('i18n_NodeGroupManageAction.downloadExample.fileIsNull_n81i');this.location='nodeGroupManage!execute.do?action=queryNodeGroupInfo&showStopNGroup="+showStopNGroup+"'</script>");
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "showError";
	}

	private String saveNode(String groupName,String groupDesc,String parentGroupName) {
		String desc = "";
		NodegroupTable nodegroupTable=new NodegroupTable();
		try {
			commonService.beginTransaction();
			// 保存节点信息
			nodegroupTable.setGroupName(groupName);
			nodegroupTable.setViewLevel(3l);
			nodegroupTable.setCreateUserId(getUserID());
			nodegroupTable.setGroupType(0l);
			nodegroupTable.setGroupDesc(groupDesc);
			nodegroupTable.setSystemId(getSystemID());
			nodegroupTable.setIsValid(1l);
			nodegroupTable.setGroupCreatetime(new Date());
			List<NodegroupTable> NodegroupTablelist = commonService.find("from NodegroupTable");
			
			for (int i = 0; i < NodegroupTablelist.size(); i++) {
				if(parentGroupName.equals(NodegroupTablelist.get(i).getGroupName())){
					nodegroupTable.setParentGroupId(NodegroupTablelist.get(i).getGroupId());
				}
			}			
			if(parentGroupName.equals("")){
				nodegroupTable.setParentGroupId(0l);
			}
			
			nodegroupTable.setLeafGroup(1l);

			//创建子节点组（父节点id!=0）时有节点的节点组不能添加子节点组			
			if(nodegroupTable.getParentGroupId()!=0) {
				List subNodeList = this.commonService.find("from NodeTable where groupId=?", nodegroupTable.getParentGroupId());
				if(subNodeList!=null&&subNodeList.size()>0) { 
					return getI18nText("i18n_NodeGroupManageAction.downloadExample.subNodeList_n81i")+";";
				}
				//上一级节点组
				NodegroupTable groupParent = (NodegroupTable) this.commonService.get(NodegroupTable.class, nodegroupTable.getParentGroupId());
				//如果比父级节点组权限大
				if(nodegroupTable.getViewLevel()>groupParent.getViewLevel()){
					return getI18nText("i18n_NodeGroupManageAction.downloadExample.nodegroupTable_n81i");
				}
				nodegroupTable.setGroupLevel(groupParent.getGroupLevel()+1);
			}else{
				nodegroupTable.setGroupLevel(1l);
			}
			
			//同一系统的同一父节点组下是否重名
			List list = this.commonService.find("from NodegroupTable where groupName=? and parentGroupId=? and systemId=?", nodegroupTable.getGroupName(),nodegroupTable.getParentGroupId(),this.getSystemID());
			if(list!=null && list.size()>0){
				return getI18nText("i18n_NodeGroupManageAction.downloadExample.nodeGroupExists_n81i");
			}
			
			//获得新增节点组的显示序号
			Long showNum = new Long(0l);
			/*String indexSql = "SELECT SHOW_INDEX FROM (SELECT SHOW_INDEX FROM NODEGROUP_TABLE WHERE PARENT_GROUP_ID=" + 
						nodegroupTable.getParentGroupId() + 
						" ORDER BY SHOW_INDEX DESC) WHERE ROWNUM<=1";*/
			//@2018年4月10日18:26:20 fang 修改rownum 适配mysql
			String indexSql = "SELECT nvl(max(SHOW_INDEX),0) SHOW_INDEX FROM NODEGROUP_TABLE WHERE PARENT_GROUP_ID=" + nodegroupTable.getParentGroupId();
			List subNodeGroup =  this.commonService.executeSQL(indexSql);
			if(subNodeGroup.size()>0) {
				Object showNumTemp = subNodeGroup.get(0);
				if(showNumTemp!=null) {
					showNum =  new Long(showNumTemp.toString())+3l;
				}
			}
			nodegroupTable.setShowIndex(showNum);//显示序号			
			this.commonService.save(nodegroupTable);
			
			//将新节点组的父节点组修改为非叶子节点组：一级节点除外
			if(nodegroupTable.getParentGroupId()!=0) {
				NodegroupTable pNode = (NodegroupTable)this.commonService.get(NodegroupTable.class, nodegroupTable.getParentGroupId());
				pNode.setLeafGroup(new Long("0"));
			}
			
			//拓扑图的数据维护
			List nplist = new ArrayList();				
			if(nodegroupTable.getGroupLevel()==1) {//一级节点组：根据业务系统ID查找当前业务系统的NodePostion：nodeType='system'表示为业务系统节点
				nplist = this.commonService.find(
							"from NodePosition where nodeType='system' and nodeId=?",
							nodegroupTable.getSystemId()+"");
			}else {//非一级节点组:根据新增节点组的父节点组ID查找父节点组对应的NodePostion：nodeType='nodeGroup'表示为节点组
				nplist = this.commonService.find(
							"from NodePosition where nodeType='nodeGroup' and nodeId=?",
							nodegroupTable.getParentGroupId()+"");
			}			
			if (nplist != null && nplist.size() > 0) {
				NodePosition parent = (NodePosition) nplist.get(0);
				Long parentId = parent.getId();//NodePostion中新增节点组的parentId
				//查找是否有相同记录存在，不存在再添加
				nplist = this.commonService
						.find(
								"from NodePosition where nodeType='nodeGroup' and nodeId=? and parent_id=?",
								nodegroupTable.getGroupId()+"", parentId);//nodeType='nodeGroup'表示为节点组
				if (nplist == null || nplist.size() == 0) {
					NodePosition np = new NodePosition();
					np.setTableName("nodegroup_table");
					np.setNodeType("nodeGroup");
					np.setNodeId(nodegroupTable.getGroupId() + "");
					np.setPositionX(0l);
					np.setPositionY(0l);
					np.setImageUrl("/nmsweb/images/show/topic.png");
					np.setViewTimeMark(new Date());
					np.setViewType(1l);
					np.setParent_id(parentId);
					this.commonService.save(np);
					this.addDBOperationRpt(commonService, "node_position", "INSERT",np.getId());
				}
			}
			
			//将添加操作写到操作日志中
			this.addDBOperationRpt(commonService, "nodegroup_table", "INSERT", nodegroupTable.getGroupId());
			commonService.commit();
			// 用来实现即时向客户端发送脚本文件
			this.sendPluginFile(nodegroupTable.getGroupId(), null,commonService);
						
			this.sendNodeAndGroupId(nodegroupTable.getGroupId(), null,commonService);//通知NMSServer更新节点组的监控信息
			
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			desc = getI18nText("i18n_NodeGroupManageAction.downloadExample.nodeInfoExportErr_n81i");
		}
		return desc;
	}
	// 导出   程辉 2013-5-8新增
	public String emportXls() {
		try {
			String hql = "select groupName,groupDesc,parentGroupId from NodegroupTable";
			if (!Boolean.parseBoolean(showStopNGroup)) {
				hql += " where isValid = 1";
			}
			List st= this.commonService.find(hql);
			
			List<NodegroupTable> NodegroupTablelist = commonService.find("from NodegroupTable");
			
			for (int j = 0; j < st.size(); j++) {
				boolean isHave = false;
				for (int i = 0; i < NodegroupTablelist.size(); i++) {
					if (NodegroupTablelist.get(i).getGroupId().equals(
							((Object[]) st.get(j))[2])) {
						((Object[]) st.get(j))[2] = NodegroupTablelist.get(i)
								.getGroupName();
						isHave=true;
					}
				}
				if(!isHave){
					((Object[]) st.get(j))[2] = "";
				}
			}
			
			String[] title = { getI18nText("i18n_NodeGroupManageAction.downloadExample.nodeGroupNameRequired_n81i"),
								getI18nText("i18n_NodeGroupManageAction.downloadExample.title.groupDesc_n81i"),
								getI18nText("i18n_NodeGroupManageAction.downloadExample.title.parentGroup_n81i") };
	
			String[] colu = { "0", "1","2" };
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(getI18nText("i18n_NodeGroupManageAction.downloadExample.nodeGroupInfo_n81i"), st, title, colu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//查询节点组信息列表
	public String queryNodeGroupInfo(){
		try{
			isComplete = this.getRequest().getParameter("isComplete");
			String hql = "from NodegroupTable where 1=1";
			String sqlCondition = "where 1=1";
			boolean ADMFlag = this.getAdminMark();
			this.getRequest().setAttribute("ADMFlag", ADMFlag);
			//当前登录用户非admin时才做查看权限限制
			if(!ADMFlag){
				//权限控制----------------------------------------------------begin
				//如果当前登录选择了业务系统，则只做和本业务系统相关的操作
				if(this.getSystemID()!=null){
					hql += " and systemId = " + this.getSystemID();
					sqlCondition += " and system_id=" + this.getSystemID();
				}
				//1 发布人查看,2 发布人所在组查看,3 系统内全部人员可看
				hql += " and (";
				hql += " (viewLevel=1 and createUserId=" + this.getUserID() + ")";
				hql += " or (viewLevel=2 and createUsergroupId in (select jsbh from XtYhJsIndex " +
									" where type=1 and yhbh='" + this.getUser().getYhbh() + "') )" ;
				if(this.getSystemID()!=null){
					hql += " or (viewLevel=3 and systemId=" + this.getSystemID() + ")";
				}else{
					hql += " or (viewLevel=3 and systemId in" +
						" (select systemId from GorupSystemTable where userGroupId in" +
							" (select jsbh from XtYhJsIndex where type=1 and yhbh='" + this.getUser().getYhbh() + "')" +
						" ) )";
				}
				hql += ")";
				//权限控制----------------------------------------------------end
			}
			if(nameVo!=null && !nameVo.trim().equals("")){
				hql += " and groupName like '%" + nameVo.trim() + "%'"; 
				sqlCondition += " and group_name like '%" + nameVo.trim() + "%'";
			}
			if(descVo!=null && !descVo.trim().equals("")){
				hql += " and groupDesc like '%" + descVo.trim() + "%'"; 
				sqlCondition += " and group_desc like '%" + descVo.trim() + "%'";
			}
			if (!Boolean.parseBoolean(showStopNGroup)) {
				hql += " and isValid = 1";
				sqlCondition += " and isValid = 1";
			}
//			hql += " order by isValid desc,groupCreatetime desc";
//			sqlCondition += " order by is_valid asc,Group_createtime desc";
			hql += " order by groupLevel asc,showIndex asc";
			sqlCondition += " order by groupLevel asc,showIndex asc";
			
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "nodegroup_table");
			
//			page = this.commonService.findByPage(hql, pageNo, pageSize);
//			nodeGroupList = (List<NodegroupTable>)page.getResult();
			nodeGroupList = (List<NodegroupTable>)this.commonService.find(hql);
			
			//获取业务系统名称
			for(NodegroupTable nodeGroup:nodeGroupList) {
				if(nodeGroup.getSystemId()!=null){
					List syslist = this.commonService.find("from SystemTable where systemId=?", nodeGroup.getSystemId());
					if(syslist!=null && syslist.size()>0){
						SystemTable sys = (SystemTable)syslist.get(0);
						nodeGroup.setSystemIdName(sys.getSystemName());
					}
				}	
			}	
			
			//获得树对象列表
			List treeList = new ArrayList();
			String sql = "select parentGroupId,groupId,groupName,groupLevel,isValid " + hql;
			List menuList = this.commonService.find(sql);
			
			for (int i = 0; i < menuList.size(); i++) {
				Object[] obj = (Object[]) menuList.get(i);// 0为pid,1为id,2为deptname,3为级别,4是否生效				
				Resource resource = new Resource();
				if(obj[0]!=null&&obj[1]!=null&&obj[4]!=null&&obj[2]!=null&&obj[3]!=null) {
					resource.setParRsCode(obj[0].toString());
					resource.setRsCode(obj[1].toString());
					resource.setRsid(obj[1].toString());
					resource.setIsValid(Integer.parseInt(obj[4].toString()));
					if("0".equals(obj[4].toString())) {//0:失效
						resource.setRsname("<font color=\"gray\">"+obj[2].toString()+"</font>");
					} else if ("1".equals(obj[4].toString())){//1:生效
						resource.setRsname(obj[2].toString());
					}
					treeList.add(resource);
				}
			}
			
			this.getRequest().setAttribute("treeList", treeList);
		}catch (Exception e){
			logger.error(e.getStackTrace());
			e.printStackTrace();
			return null;
		}
		return "queryNodeGroupInfo";
	}
	
	//查找所有有效的节点组信息，并组成树对象集合
	public void selectNodeGroup() {
		try{
			String hql = "from NodegroupTable where 1=1";
			String sqlCondition = "where 1=1";
			if(!this.getAdminMark()){// admin 用户 有 超级查看权限
				//如果当前登录选择了业务系统，则只做和本业务系统相关的操作
				if(this.getSystemID()!=null){
					hql += " and systemId = " + this.getSystemID();
					sqlCondition += " and system_id=" + this.getSystemID();
				}
				//1 发布人查看,2 发布人所在组查看,3 系统内全部人员可看
				hql += " and (";
				hql += " (viewLevel=1 and createUserId=" + this.getUserID() + ")";
				hql += " or (viewLevel=2 and createUsergroupId in (select jsbh from XtYhJsIndex " +
				" where type=1 and yhbh='" + this.getUser().getYhbh() + "') )" ;
				if(this.getSystemID()!=null){
					hql += " or (viewLevel=3 and systemId=" + this.getSystemID() + ")";
				}else{
					hql += " or (viewLevel=3 and systemId in" +
					" (select systemId from GorupSystemTable where userGroupId in" +
					" (select jsbh from XtYhJsIndex where type=1 and yhbh='" + this.getUser().getYhbh() + "')" +
					" ) )";
				}
				hql += ")";
			}
			hql += " and nvl(isValid,0)=1";
			hql += " order by isValid desc,groupCreatetime desc";
			sqlCondition += " order by is_valid asc,Group_createtime desc";
			
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "nodegroup_table");
			
			nodeGroupList = (List<NodegroupTable>) this.commonService.find(hql);
			
			//获取业务系统名称
			for(NodegroupTable nodeGroup:nodeGroupList) {
				if(nodeGroup.getSystemId()!=null){
					List syslist = this.commonService.find("from SystemTable where systemId=?", nodeGroup.getSystemId());
					if(syslist!=null && syslist.size()>0){
						SystemTable sys = (SystemTable)syslist.get(0);
						nodeGroup.setSystemIdName(sys.getSystemName());
					}
				}
			}	
			
			//获得树对象列表
			List treeList = new ArrayList();
			String sql = "select parentGroupId,groupId,groupName,groupLevel,isValid " + hql;
			List menuList = this.commonService.find(sql);
			
			for (int i = 0; i < menuList.size(); i++) {
				Object[] obj = (Object[]) menuList.get(i);// 0为pid,1为id,2为deptname,3为级别,4是否生效				
				Resource resource = new Resource();
				if(obj[0]!=null&&obj[1]!=null&&obj[4]!=null&&obj[2]!=null&&obj[3]!=null) {
					resource.setParRsCode(obj[0].toString());
					resource.setRsCode(obj[1].toString());
					resource.setRsid(obj[1].toString());
					if("0".equals(obj[4].toString())) {//0:失效
						resource.setRsname("<font color=\"gray\">"+obj[2].toString()+"</font>");
					} else if ("1".equals(obj[4].toString())){//1:生效
						resource.setRsname(obj[2].toString());
					}
					treeList.add(resource);
				}
			}
			
			this.getRequest().setAttribute("treeList", treeList);
			
		}catch (Exception e){
			e.printStackTrace();
		}
	}
	
	//新增任务时：查询可供选择的节点组
	public String toSelectNodeGroup() {
			try{
				selectNodeGroup();//查询节点组
				//获得当前选中的节点组id集合,传递给节点组选择页面
				String nodeGroupIds = this.getRequest().getParameter("nodeGroupIds");
				this.getRequest().setAttribute("nodeGroupIds", nodeGroupIds);
			}catch (Exception e){
				e.printStackTrace();
				logger.error(e.getStackTrace());
			}
		return "toSelectNodeGroup";
	}
	
	//新增监测设置时：查询可供选择的节点组、节点
	public String toSelectNodeAndNodeGroup() {
		try {
			selectNodeGroup();//查询节点组
			//获得当前选中的节点组id集合,传递给节点组选择页面
			String groupId = this.getRequest().getParameter("groupId");
			this.getRequest().setAttribute("groupId", groupId);
			//获得当前选中的节点ip集合,传递给节点组选择页面
			String nodeId = this.getRequest().getParameter("nodeId");
			this.getRequest().setAttribute("nodeId", nodeId);
			//查询选中节点组对应的所有节点
			List<NodeTable> nodeList = new ArrayList<NodeTable>();
			List<NodeTable> noInNodeList = new ArrayList<NodeTable>();
			if(groupId!=null&&!"".equals(groupId.trim())) {
				//String tString ="select * from node_table where 1=1 and node_state = 0 and node_group_id in( "+groupId+") order by node_group_id,node_id";
				//过滤掉未包含在DC分管IP中的节点
				String tString ="select distinct ttt.*"+
						" from node_table ttt"+
						" right join (select sis.start_ipn as star, sis.end_ipn as end"+
		                " from server_ip_segment sis"+
		                " left join server_table t on sis.server_id = t.id"+
		                " where t.server_state = 0"+
		                " and (sis.segment_state is null or sis.segment_state <> -1)) tempTable"+
		                " on ttt.ipn >= tempTable.Star and ttt.ipn <= tempTable.end"+
		                " where node_state = 0"+
		                " and node_group_id in ("+groupId+") order by node_group_id, node_id";
				nodeList =this.commonService.executeSQL(tString,NodeTable.class);
				
				//获取未包含在分管IP中的节点
				String notIn ="select * from node_table where node_id not in (select distinct ttt.node_id from node_table ttt "+
						"right join (select sis.start_ipn as star, sis.end_ipn as end "+
						"from server_ip_segment sis "+
						"left join server_table t on sis.server_id = t.id "+
						"where t.server_state = 0 "+
						"and (sis.segment_state is null or sis.segment_state <> -1)) tempTable "+
						"on ttt.ipn >= tempTable.Star and ttt.ipn <= tempTable.end ) "+
						"and node_state = 0 and node_group_id in ("+groupId+")";
				noInNodeList =this.commonService.executeSQL(notIn,NodeTable.class);
				if(noInNodeList.size()>0){
					this.getRequest().setAttribute("noInNodeList", noInNodeList);
				}
			}
			this.getRequest().setAttribute("nodeList", nodeList);
			
		}catch(Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
		return "toSelectNodeAndNodeGroup";
	}
	
	/**
	 * 
	 * 思路： 
	 * 1.groupId：经过前台的过滤，groupId为前台选中节点组中最底层的节点组id：叶子节点组+无子孙被选中的非叶子节点组
	 * 2.leafNodeGroupIds：根据groupId，得到groupId中的叶子节点组id
	 * 3.leafNodeGroupIdsByPar：根据groupId，通过getAllLeafNodeGroupIds方法，得到groupId中无子孙被选中的非叶子节点组对应的所有的叶子节点组
	 * 4.在节点表中根据leafNodeGroupIds+leafNodeGroupIdsByPar，得到所对应的节点的ip，并返回到前台用于显示
	 * @author hyx May 3, 2012
	 * @version 1.0 
	 * @return
	 * @throws Exception
	 */
	public String getNodesByNodeGroupId()throws Exception {
		List<NodeTable> nodeList = new ArrayList<NodeTable>();
		List<NodeTable> noInNodeList = new ArrayList<NodeTable>();
		List resuInList = new ArrayList();
		List resuNoInList = new ArrayList();
		List resuList = new ArrayList();
		String nodeGroup = "";
		try {
			if(groupId!=null && !"".equals(groupId)){//查询有效节点
				//获得所选节点组对应的所有的叶子节点组（非叶子节点组下对应的所有的叶子节点组）
				String[] nodeGroupIds = groupId.split(",");
				String leafNodeGroupIds = getLeafNodeGroupId(groupId);//获得所选节点组中的所有叶子节点组
				for(int i=0; i<nodeGroupIds.length; i++){
					getAllLeafNodeGroupIds(Long.valueOf(nodeGroupIds[i]));//获得非叶子节点组对应的叶子节点组
				}
				if(leafNodeGroupIdsByPar.size()>0) {
					nodeGroup = StringUtils.join(selectedNodeGroupIds.toArray(), ",");
					leafNodeGroupIds = leafNodeGroupIds+","+nodeGroup;
				}
				
				if(leafNodeGroupIds!=null&&!"".equals(leafNodeGroupIds.trim())) {				
					//String tString ="select * from node_table where 1=1 and node_state = 0 and node_group_id in( "+leafNodeGroupIds+") order by node_group_id,node_id";
					//过滤掉未包含在DC分管IP中的节点
					String tString ="select distinct ttt.*"+
							" from node_table ttt"+
							" right join (select sis.start_ipn as star, sis.end_ipn as end"+
			                " from server_ip_segment sis"+
			                " left join server_table t on sis.server_id = t.id"+
			                " where t.server_state = 0"+
			                " and (sis.segment_state is null or sis.segment_state <> -1)) tempTable"+
			                " on ttt.ipn >= tempTable.Star and ttt.ipn <= tempTable.end"+
			                " where node_state = 0"+
			                " and node_group_id in ("+leafNodeGroupIds+") order by node_group_id, node_id";
					//System.out.println(tString);
					nodeList =this.commonService.executeSQL(tString,NodeTable.class);
					
					//获取未包含在分管IP中的节点
					String notIn ="select * from node_table where node_id not in (select distinct ttt.node_id from node_table ttt "+
							"right join (select sis.start_ipn as star, sis.end_ipn as end "+
							"from server_ip_segment sis "+
							"left join server_table t on sis.server_id = t.id "+
							"where t.server_state = 0 "+
							"and (sis.segment_state is null or sis.segment_state <> -1)) tempTable "+
							"on ttt.ipn >= tempTable.Star and ttt.ipn <= tempTable.end ) "+
							"and node_state = 0 and node_group_id in ("+leafNodeGroupIds+")";
					noInNodeList =this.commonService.executeSQL(notIn,NodeTable.class);
				}
						
				if(nodeList!=null && nodeList.size()>0){
					for(int i=0;i<nodeList.size();i++){
						NodeTable nTable = nodeList.get(i);
						Object[] obj = new Object[5];//节点id、节点ip、节点所属节点组id、节点类型(0：服务器 1：交换机)
						obj[0]= nTable.getNodeId();
						obj[1]= nTable.getNodeIp();
						obj[2]= nTable.getGroupId();
						obj[3]= nTable.getNodeType();
						obj[4]=nTable.getNodeSystemType();
						resuInList.add(obj);
					}
				}
				resuList.add(resuInList);
				
				if(noInNodeList!=null && noInNodeList.size()>0){
					for(int i=0;i<noInNodeList.size();i++){
						NodeTable nTable = noInNodeList.get(i);
						Object[] obj = new Object[5];//节点名称、节点ip、节点所属节点组id、节点类型(0：服务器 1：交换机)
						obj[0]= nTable.getNodeName();
						obj[1]= nTable.getNodeIp();
						obj[2]= nTable.getGroupId();
						obj[3]= nTable.getNodeType();
						obj[4]=nTable.getNodeSystemType();
						resuNoInList.add(obj);
					}
				}
				resuList.add(resuNoInList);
			}
			String jsonStr = JSONArray.fromObject(resuList).toString();
			this.getResponse().setCharacterEncoding("utf-8");
			PrintWriter printWriter = this.getResponse().getWriter();
			printWriter.write(jsonStr);
			printWriter.close();
			printWriter = null;
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
		return null;
	}
	
	//添加节点组
	public String addNodeGroupInfo(){
		try{
			commonService.beginTransaction();
			//创建子节点组（父节点id!=0）时有节点的节点组不能添加子节点组			
			if(nodeGroup.getParentGroupId()!=0) {
				List subNodeList = this.commonService.find("from NodeTable where groupId=?", nodeGroup.getParentGroupId());
				if(subNodeList!=null&&subNodeList.size()>0) { 
					this.outHtmlString("<script>alert('i18n_NodeGroupManageAction.downloadExample.subNodeList_n81i！');history.back();</script>");
					return null;
				}
			}
			
			//同一系统的同一父节点组下是否重名
			List list = this.commonService.find("from NodegroupTable where groupName=? and parentGroupId=? and systemId=?", nodeGroup.getGroupName(),nodeGroup.getParentGroupId(),this.getSystemID());
			if(list!=null && list.size()>0){
				this.outHtmlString("<script>alert('i18n_NodeGroupManageAction.downloadExample.nodeGroupIsExists_n81i');history.back();</script>");
				return null;
			}
			
			//判断其父级是否为系统(0)
			if(nodeGroup.getParentGroupId() !=null && !nodeGroup.getParentGroupId().equals(new Long(0))){
				//上一级节点组
				NodegroupTable groupParent = (NodegroupTable) this.commonService.get(NodegroupTable.class, nodeGroup.getParentGroupId());
				//如果比父级节点组权限大
				if(nodeGroup.getViewLevel()>groupParent.getViewLevel()){
					this.outHtmlString("<script>alert('i18n_NodeGroupManageAction.downloadExample.viewLevleTooBig_n81i');history.back();</script>");
					return null;
				}
			}
			
			//保存
			nodeGroup.setCreateUserId(this.getUserID());
			nodeGroup.setGroupCreatetime(new Date());
			nodeGroup.setLeafGroup(new Long(1l));//是否叶子节点:新增时均为叶子节点组
			//获得新增节点组的显示序号
			Long showNum = new Long(0l);
			/*String indexSql = "SELECT SHOW_INDEX FROM (SELECT SHOW_INDEX FROM NODEGROUP_TABLE WHERE PARENT_GROUP_ID=" + 
						nodeGroup.getParentGroupId() + 
						" ORDER BY SHOW_INDEX DESC) WHERE ROWNUM<=1";*/
			//@2018年4月10日18:26:20 fang 修改rownum 适配mysql
			String indexSql = "SELECT nvl(max(SHOW_INDEX),0) SHOW_INDEX FROM NODEGROUP_TABLE WHERE PARENT_GROUP_ID=" + nodeGroup.getParentGroupId();
			List subNodeGroup =  this.commonService.executeSQL(indexSql);
			if(subNodeGroup.size()>0) {
				Object showNumTemp = subNodeGroup.get(0);
				if(showNumTemp!=null) {
					showNum =  new Long(showNumTemp.toString())+3l;
				}
			}
			nodeGroup.setShowIndex(showNum);//显示序号			
			this.commonService.save(nodeGroup);
			
			//将新节点组的父节点组修改为非叶子节点组：一级节点除外
			if(nodeGroup.getParentGroupId()!=0) {
				NodegroupTable pNode = (NodegroupTable)this.commonService.get(NodegroupTable.class, nodeGroup.getParentGroupId());
				pNode.setLeafGroup(new Long("0"));
			}
			
			//拓扑图的数据维护
			List nplist = new ArrayList();				
			if(nodeGroup.getGroupLevel()==1) {//一级节点组：根据业务系统ID查找当前业务系统的NodePostion：nodeType='system'表示为业务系统节点
				nplist = this.commonService.find(
							"from NodePosition where nodeType='system' and nodeId=?",
							nodeGroup.getSystemId()+"");
			}else {//非一级节点组:根据新增节点组的父节点组ID查找父节点组对应的NodePostion：nodeType='nodeGroup'表示为节点组
				nplist = this.commonService.find(
							"from NodePosition where nodeType='nodeGroup' and nodeId=?",
							nodeGroup.getParentGroupId()+"");
			}			
			if (nplist != null && nplist.size() > 0) {
				NodePosition parent = (NodePosition) nplist.get(0);
				Long parentId = parent.getId();//NodePostion中新增节点组的parentId
				//查找是否有相同记录存在，不存在再添加
				nplist = this.commonService
						.find(
								"from NodePosition where nodeType='nodeGroup' and nodeId=? and parent_id=?",
								nodeGroup.getGroupId()+"", parentId);//nodeType='nodeGroup'表示为节点组
				if (nplist == null || nplist.size() == 0) {
					NodePosition np = new NodePosition();
					np.setTableName("nodegroup_table");
					np.setNodeType("nodeGroup");
					np.setNodeId(nodeGroup.getGroupId() + "");
					np.setPositionX(0l);
					np.setPositionY(0l);
					np.setImageUrl("/nmsweb/images/show/topic.png");
					np.setViewTimeMark(new Date());
					np.setViewType(1l);
					np.setParent_id(parentId);
					this.commonService.save(np);
					this.addDBOperationRpt(commonService, "node_position", "INSERT",np.getId());
				}
			}
			
			//将添加操作写到操作日志中
			this.addDBOperationRpt(commonService, "nodegroup_table", "INSERT", nodeGroup.getGroupId());
			commonService.commit();
			// 用来实现即时向客户端发送脚本文件
			this.sendPluginFile(nodeGroup.getGroupId(), null,commonService);
			
			this.sendNodeAndGroupId(nodeGroup.getGroupId(), null,commonService);//通知NMSServer更新节点组的监控信息
			
			//记录用户操作用于设置向导
			if(fromWhere!=null && !"".equals(fromWhere)){
				if(fromWhere.equals("formGuide")){
					this.outHtmlString("<script>alert('i18n_NodeGroupManageAction.downloadExample.success_n81i');this.location='nodeGroupManage!execute.do?action=queryNodeGroupInfo&isComplete=0&showStopNGroup="+showStopNGroup+"'</script>");
				}
			}else{
				this.outHtmlString("<script>alert('i18n_NodeGroupManageAction.downloadExample.success_n81i');this.location='nodeGroupManage!execute.do?action=queryNodeGroupInfo&showStopNGroup="+showStopNGroup+"'</script>");
			}
			
		}catch (Exception e){
			commonService.rollback();
			logger.error(e.getStackTrace());
			e.printStackTrace();
			this.outHtmlString("<script>alert('i18n_NodeGroupManageAction.downloadExample.faild_n81i');this.location='nodeGroupManage!execute.do?action=queryNodeGroupInfo&showStopNGroup="+showStopNGroup+"'</script>");
			return null;
		}
		return null;
	}
	
	//修改节点组
	public String updateNodeGroupInfo(){
		try{
			commonService.beginTransaction();
			//判断同一父亲节点组下的子节点组是否重名
			List list = this.commonService.find("from NodegroupTable where groupName=? and parentGroupId=? and systemId =? and groupId <>?", 
					nodeGroup.getGroupName(),nodeGroup.getParentGroupId(),this.getSystemID(),nodeGroup.getGroupId());
			if(list!=null && list.size()>0){
				this.outHtmlString("<script>alert('i18n_NodeGroupManageAction.downloadExample.nodeGroupIsExists_n81i');history.back();</script>");
				return null;
			}
			
			NodegroupTable group = (NodegroupTable) this.commonService.get(NodegroupTable.class, nodeGroup.getGroupId());
			boolean flag = false;
			if(group != null){
				//下一级节点组
				List listSub = this.commonService.find("from NodegroupTable where parentGroupId=?",nodeGroup.getGroupId());
				//判断其父级是否为系统(0)
				if(nodeGroup.getParentGroupId().equals(new Long(0))){
					//如果是系统则直接判断其下一级
					if(listSub!=null && listSub.size()>0){
						NodegroupTable groupSub = (NodegroupTable)listSub.get(0);
						if(nodeGroup.getViewLevel()<groupSub.getViewLevel()){
							this.outHtmlString("<script>alert('i18n_NodeGroupManageAction.downloadExample.viewLevleTooSmall_n81i');history.back();</script>");
							return null;
						}
					}
				}else{
					//上一级节点组
					NodegroupTable groupParent = (NodegroupTable) this.commonService.get(NodegroupTable.class, nodeGroup.getParentGroupId());
					//如果比父级节点组权限大
					if(nodeGroup.getViewLevel()>groupParent.getViewLevel()){
						this.outHtmlString("<script>alert('i18n_NodeGroupManageAction.downloadExample.viewLevleTooBig_n81i');history.back();</script>");
						return null;
					}else{//不大，再判断其下一级节点组
						if(listSub!=null && listSub.size()>0){
							NodegroupTable groupSub = (NodegroupTable)listSub.get(0);
							if(nodeGroup.getViewLevel()<groupSub.getViewLevel()){
								this.outHtmlString("<script>alert('i18n_NodeGroupManageAction.downloadExample.viewLevleTooSmall_n81i');history.back();</script>");
								return null;
							}
						}
					}
				}
				
				if(!group.getIsValid().equals(nodeGroup.getIsValid())){
					flag = true;
				}
				group.setGroupName(nodeGroup.getGroupName());
				group.setGroupType(nodeGroup.getGroupType());
				group.setGroupDesc(nodeGroup.getGroupDesc());
				group.setIsValid(nodeGroup.getIsValid());
				group.setViewLevel(nodeGroup.getViewLevel());
				group.setCreateUsergroupId(nodeGroup.getCreateUsergroupId());//查看权限的用户组
				
				group.setSystemId(nodeGroup.getSystemId());//业务系统可以修改吗？:admin可以修改？
//				group.setParentGroupId(nodeGroup.getParentGroupId());//不可以改吧？？
//				group.setGroupLevel(nodeGroup.getGroupLevel());//不可以改吧？？
//				group.setLeafGroup(nodeGroup.getLeafGroup());//是否叶子节点组
//				group.setShowIndex(nodeGroup.getShowIndex());//显示序号，不可改？
				this.commonService.update(group);
				
				//将更新操作写到操作日志中
				this.addDBOperationRpt(commonService, "nodegroup_table", "UPDATE", nodeGroup.getGroupId());
				commonService.commit();
				this.outHtmlString("<script>alert('i18n_NodeGroupManageAction.downloadExample.success_n81i');this.location='nodeGroupManage!execute.do?action=queryNodeGroupInfo&showStopNGroup="+showStopNGroup+"'</script>");
			}
			if(flag){
				// 用来实现即时向客户端发送脚本文件
				this.sendPluginFile(group.getGroupId(), null,commonService);
				
				this.sendNodeAndGroupId(group.getGroupId(), null,commonService);	//通知NMSServer更新节点组的监控信息
				this.getRequest().setAttribute("MSG","2");
			}
			
		}catch (Exception e){
			commonService.rollback();
			logger.error(e.getStackTrace());
			e.printStackTrace();
			this.outHtmlString("<script>alert('i18n_NodeGroupManageAction.downloadExample.faild_n81i');this.location='nodeGroupManage!execute.do?action=queryNodeGroupInfo&showStopNGroup="+showStopNGroup+"'</script>");
			return null;
		}
		return null;
	}
	
	//根据父节点组id：获取父节点组id及所有子节点组id
	private String getAllSubNodeGroupIds(Long id) {
		selectedNodeGroupIds.add(String.valueOf(id));
		String hql = "select groupId from NodegroupTable where parentGroupId = " + id;
		try
		{
			List list = this.commonService.find(hql);
			for(Object obj:list) {
				if(obj!=null) {
					selectedNodeGroupIds.add(obj.toString());
					getAllSubNodeGroupIds(Long.valueOf(obj.toString()));
				}
			}			
			
		} catch (Exception e)
		{
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		return StringUtils.join(selectedNodeGroupIds.toArray(), ",");
	}
	//根据父节点组id：获取所有叶子节点组id
	private String getAllLeafNodeGroupIds(Long id) {
		String hql = "select groupId ,leafGroup from NodegroupTable where parentGroupId = " + id;
		try
		{
			List<Object []> list = this.commonService.find(hql);
			for(Object[] obj:list) {
				if(obj!=null) {
					if(obj[1]!=null&&"1".equals(obj[1])&&obj[0]!=null) {//是叶子节点组
						leafNodeGroupIdsByPar.add(obj[0].toString());						
					} else if(obj[0]!=null) {
						getAllLeafNodeGroupIds(Long.valueOf(obj[0].toString()));
					}
				}
			}		
			
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return StringUtils.join(leafNodeGroupIdsByPar.toArray(), ",");
	}
	
	//停用节点组:
	public String stopNodeGroupInfo(){
		try{
			commonService.beginTransaction();
			if(ids!=null && ids.length>0){
				String allIds = "";
				//获得所有节点组及子节点组的id
				for(int i=0; i<ids.length; i++){
					getAllSubNodeGroupIds(ids[i]);
				}
				//整体更新
				if(selectedNodeGroupIds.size()>0) {
					allIds = StringUtils.join(selectedNodeGroupIds.toArray(), ",");
					this.commonService.updateBySql("update NODEGROUP_TABLE set IS_VALID=0 where GROUP_ID in (" + allIds + ")");
					String sqlCondition = "where GROUP_ID in (" + allIds + ")";
					//将更新操作写到操作日志中
					this.addDBOperationRpt(commonService, sqlCondition, "NODEGROUP_TABLE");
				}
				stopNode(allIds);
			}
			this.outHtmlString("<script>alert('i18n_NodeGroupManageAction.downloadExample.success_n81i');this.location='nodeGroupManage!execute.do?action=queryNodeGroupInfo&showStopNGroup="+showStopNGroup+"'</script>");
			commonService.commit();
		}catch (Exception e){ 
			commonService.rollback();
			logger.error(e.getStackTrace());
			e.printStackTrace();
			this.outHtmlString("<script>alert('i18n_NodeGroupManageAction.downloadExample.faild_n81i');this.location='nodeGroupManage!execute.do?action=queryNodeGroupInfo&showStopNGroup="+showStopNGroup+"'</script>");
			return null;
		}
		return null;
	}
	
	//从所给的节点组中筛选出所有叶子节点组的id
	private String getLeafNodeGroupId(String allIds) {
		String hql = "select groupId from NodegroupTable where leafGroup=1 and groupId in ( " + allIds +")";
		try
		{
			List list = this.commonService.find(hql);
			for(Object obj:list) {
				if(obj!=null) {
					leafNodeGroupIds.add(obj.toString());
				}
			}			
			
		} catch (Exception e)
		{
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		return StringUtils.join(leafNodeGroupIds.toArray(), ",");
	}
	//获取所有子节点id
	private String getAllSubNodeIds(Long id) {
		String hql = "select nodeId from NodeTable where groupId = " + id;
		try
		{
			List list = this.commonService.find(hql);
			for(Object obj:list) {
				if(obj!=null) {
					nodeIds.add(obj.toString());
				}
			}			
			
		} catch (Exception e)
		{
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		return StringUtils.join(nodeIds.toArray(), ",");
	}
	//得到叶子节点和节点的对应map
	private String getNodeGroupMapNode(Long id) {
		try
		{
			String nodeIds = getAllSubNodeIds(id);
			nodeGroupMap.put(String.valueOf(id), nodeIds);
		} catch (Exception e)
		{
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		return nodeGroupMap.toString();
	}
	
	// 停用节点：先找出叶子节点，再找出所有叶子节点的节点id，再进行更新. NODE_STATE=1表示节点为下线（停用）状态，此时显示可以的操作为上线
	private String stopNode(String allIds) {
		try {	
			commonService.beginTransaction();
			String leafNodeGroupIds = getLeafNodeGroupId(allIds);
			String[] leafNodeGroupArray = leafNodeGroupIds.split(",");//所有叶子节点
			for(int i=0;i<leafNodeGroupArray.length;i++) {
				getAllSubNodeIds(Long.valueOf(leafNodeGroupArray[i]));//获取所有叶子节点组下的所有节点的id
			//	getNodeGroupMapNode(Long.valueOf(leafNodeGroupArray[i]));//得到叶子节点和节点的对应map
			}
			//整体更新
			StringBuffer strb = new StringBuffer();
			if(nodeIds.size()>0) {//所有节点
				int ii=0;
				for(String str : nodeIds){
					if(ii!=0&&ii%1000==0){
						strb.deleteCharAt(strb.length() - 1);
						strb.append(") or NODE_ID in ( "+ str +","); 
					}else{
						strb.append(str+ ",");
					}
					ii++;
				}
				if(strb.length()>0){
					strb.deleteCharAt(strb.length() -1);
				}
				String sql = "update NODE_TABLE set NODE_STATE=1,STOP_USER_ID="+
						this.getUserID()+",NODE_STOPTIME=sysdate where NODE_ID in (" + strb + ")";
				this.commonService.updateBySql(sql);
				String sqlCondition = "where NODE_ID in (" + allIds + ")";
				//将更新操作写到操作日志中
				this.addDBOperationRpt(commonService, sqlCondition, "NODE_TABLE");
			}
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			logger.error(e.getStackTrace());
			e.printStackTrace();
			return null;
		}
		return null;
	}
	
	//启用节点组
	public String startNodeGroupInfo(){
		try{
			commonService.beginTransaction();
			if(ids!=null && ids.length>0){
				if(isStartSubNodeGroup!=null&&"1".equals(isStartSubNodeGroup)) {//启用节点组的同时启用子节点组？？
					String allIds = "";
					//获得所有节点组及子节点组的id
					for(int i=0; i<ids.length; i++){
						getAllSubNodeGroupIds(ids[i]);
					}
					//整体更新
					if(selectedNodeGroupIds.size()>0) {
						allIds = StringUtils.join(selectedNodeGroupIds.toArray(), ",");
						this.commonService.updateBySql("update NODEGROUP_TABLE set IS_VALID=1 where GROUP_ID in (" + allIds + ")");
						String sqlCondition = "where GROUP_ID in (" + allIds + ")";
						//将更新操作写到操作日志中
						this.addDBOperationRpt(commonService, sqlCondition, "NODEGROUP_TABLE");
					}				
					startNode(allIds);//启用所有节点
				} else {//启用节点组的同时，不启用子节点组
					String allIds = StringUtils.join(ids,",");
					//整体更新
					if(allIds.length()>0) {
						this.commonService.updateBySql("update NODEGROUP_TABLE set IS_VALID=1 where GROUP_ID in (" + allIds + ")");
						String sqlCondition = "where GROUP_ID in (" + allIds + ")";
						//将更新操作写到操作日志中
						this.addDBOperationRpt(commonService, sqlCondition, "NODEGROUP_TABLE");
					}
				}
				this.outHtmlString("<script>alert('i18n_NodeGroupManageAction.downloadExample.success_n81i');this.location='nodeGroupManage!execute.do?action=queryNodeGroupInfo&showStopNGroup="+showStopNGroup+"'</script>");
			}
			commonService.commit();
		}catch (Exception e){ 
			commonService.rollback();
			logger.error(e.getStackTrace());
			e.printStackTrace();
			this.outHtmlString("<script>alert('i18n_NodeGroupManageAction.downloadExample.faild_n81i');this.location='nodeGroupManage!execute.do?action=queryNodeGroupInfo&showStopNGroup="+showStopNGroup+"'</script>");
			return null;
		}
		return null;
	}
	
	// 启用节点: NODE_STATE=0表示节点为上线（启用）状态，此时显示可以的操作为下线
	public String startNode(String allIds) {
		try {
			commonService.beginTransaction();
			String leafNodeGroupIds = getLeafNodeGroupId(allIds);//获取所有叶子节点组id
			String[] leafNodeGroupArray = leafNodeGroupIds.split(",");//所有叶子节点
			for(int i=0;i<leafNodeGroupArray.length;i++) {
				getAllSubNodeIds(Long.valueOf(leafNodeGroupArray[i]));//获取所有叶子节点组下的所有节点的id
				getNodeGroupMapNode(Long.valueOf(leafNodeGroupArray[i]));//得到叶子节点和节点的对应map
			}
			
			//整体更新
			if(nodeIds.size()>0) {//所有节点
				StringBuffer strb = new StringBuffer();
				int ii=0;
				for(String str : nodeIds){
					if(ii!=0&&ii%1000==0){
						strb.deleteCharAt(strb.length() - 1);
						strb.append(") or NODE_ID in ( "+ str +","); 
					}else{
						strb.append(str+ ",");
					}
					ii++;
				}
				if(strb.length()>0){
					strb.deleteCharAt(strb.length() -1);
				}
				this.commonService.updateBySql("update NODE_TABLE set NODE_STATE=0 where NODE_ID in (" + strb + ")");
				String sqlCondition = "where NODE_ID in (" + allIds + ")";
				//将更新操作写到操作日志中
				this.addDBOperationRpt(commonService, sqlCondition, "NODE_TABLE");
				commonService.commit();
				//通知NMSServer更新节点组的监控信息
				for(String str : leafNodeGroupArray){
					// 用来实现即时向客户端发送脚本文件
					this.sendPluginFile(Long.valueOf(str), null,commonService);
					
					this.sendNodeAndGroupId(Long.valueOf(str), null,commonService);
				}
			}
			
			//this.outHtmlString("<script>alert('操作成功！');this.location='"+path+"/nodeGroupManage/nodeGroupManage.do?action=queryNodeGroupInfo'</script>");
		} catch (Exception e) {
			commonService.rollback();
			logger.error(e.getStackTrace());
			e.printStackTrace();
			//this.outHtmlString("<script>alert('操作失败！');this.location='"+path+"/nodeGroupManage/nodeGroupManage.do?action=queryNodeGroupInfo'</script>");
			return null;
		}
		return null;
	}
	
	
	//获取业务系统信息(当前业务系统及所有业务系统列表)+
	public String getInitInfo(){
		try {
			//查询系统
			boolean ADMFlag = this.getAdminMark();
			this.getRequest().setAttribute("ADMFlag", ADMFlag);
			if(ADMFlag){//如果是admin登陆则无限制
				String hql = "from SystemTable where systemState='0'";
				systemList = this.commonService.find(hql);//获取所有业务系统信息
			}else{
				system = (SystemTable)this.commonService.get(SystemTable.class, this.getSystemID());//获取当前业务系统信息
			}
			//查询当前用户所在的有效用户组
			this.queryAllUserGroup();
			
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		return "addNodeGroupInfo";
	}
	
	
	
	//打开修改节点组信息页面
	public String openUpdateNodeGroupInfo(){
		try{
			if(ids!=null && ids.length>0){
				nodeGroupId = ids[0];
			}
			
			List list = this.commonService.find(
					"from NodegroupTable where groupId=?", nodeGroupId);
			if(list!=null && list.size()>0){
				nodeGroup = (NodegroupTable)list.get(0);
			}
			
			boolean ADMFlag = this.getAdminMark();
			this.getRequest().setAttribute("ADMFlag", ADMFlag);
			if(ADMFlag){//如果是admin登陆则无限制
				String hql = "from SystemTable where systemState='0'";
				systemList = this.commonService.find(hql);
			}else{
				system = (SystemTable)this.commonService.get(SystemTable.class, this.getSystemID());
			}
			
			//查询当前用户所在的有效用户组
			this.queryAllUserGroup();
			
		}catch (Exception e){
			logger.error(e.getStackTrace());
			e.printStackTrace();
			return null;
		}
		return "updateNodeGroupInfo";
	}
	
	
	
	
	
	//查看节点组详情
	public String detailNodeGroupInfo(){
		try{
			List list = this.commonService.find(
					"from NodegroupTable where groupId=?", nodeGroupId);
			if(list!=null && list.size()>0){
				nodeGroup = (NodegroupTable)list.get(0);
				List syslist = this.commonService.find("from SystemTable where systemId=?", nodeGroup.getSystemId());
				if(syslist!=null && syslist.size()>0){
					SystemTable sys = (SystemTable)syslist.get(0);
					nodeGroup.setSystemIdName(sys.getSystemName());
				}
				if (nodeGroup.getCreateUsergroupId()!=null && nodeGroup.getCreateUsergroupId().intValue()!=0) {
					XtJsJbxx xtjsjbxx = (XtJsJbxx) this.commonService.get(
							XtJsJbxx.class, nodeGroup.getCreateUsergroupId());
					if (xtjsjbxx != null) {
						nodeGroup.setUserGroupIdName(xtjsjbxx.getJsmc());
					}
				}
				
				String hql = "from NodeTable where groupId = " + nodeGroup.getGroupId() + "";
				nodeList = (List<NodeTable>)this.commonService.find(hql);
			}
			
		}catch (Exception e){
			logger.error(e.getStackTrace());
			e.printStackTrace();
			return null;
		}
		return "detailNodeGroupInfo";
	}
	

	//查询当前用户所在的用户组,如果是admin的话，则获取所有有效的用户组
	private void queryAllUserGroup(){
		try {
			//查询当前用户所在的有效用户组
			String hql2 = "from XtJsJbxx where zxbz=0 and jsbh in" +//zxbz注销标志，0是有效，1是无效
					" (select jsbh from XtYhJsIndex where type=1 and yhbh='" + this.getUser().getYhbh() + "')";
			if(this.getAdminMark()){//如果是admin的话查询所有用户组
				hql2 = "from XtJsJbxx where zxbz=0 and type=1";//zxbz注销标志，0是有效，1是无效
			}
			allUserGroup = this.commonService.find(hql2);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
/**==========================================节点操作开始=========================	==========**/
	//打开节点管理页面
	public String nodeMgmtList(){
		try{
			String isValid = this.getRequest().getParameter("isValid");//叶子节点组的有效性
			this.getRequest().setAttribute("fromWhere", fromWhere);
			this.getRequest().setAttribute("isValid", isValid);
			if(ids!=null && ids.length>0){
				nodeGroupId = ids[0];
			}
			if (nodeGroupId != null)
			{
				List list = this.commonService.find(
						"from NodegroupTable where groupId=?", nodeGroupId);
				if(list!=null && list.size()>0){
					nodeGroup = (NodegroupTable)list.get(0);
				}
			}
			
		}catch (Exception e){
			logger.error(e.getStackTrace());
			e.printStackTrace();
			return null;
		}
		return "nodeMgmtList";
	}
	/**
	 * 
	 * 任务配置向导页面，节点下一步时验证节点组中的节点至少一个 
	 * @author jsj May 6, 2013
	 * @version 1.0 
	 * @return
	 */
	public String getNodeSize(){
		try
		{
			if (nodeGroupId != null)
			{
				List list = this.commonService.find(
						"from NodeTable where groupId=?", nodeGroupId);
				if(list!=null && list.size()>0){
					outJsonString(""+list.size());
				}
			}
			
		} catch (Exception e)
		{
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		return null;
		
	}
	
	public CommonService getCommonService()
	{
		return commonService;
	}
	
	public void setCommonService(CommonService commonService)
	{
		this.commonService = commonService;
	}
	
	public String getAction()
	{
		return action;
	}

	public void setAction(String action)
	{
		this.action = action;
	}

	public String getPosition()
	{
		return position;
	}

	public void setPosition(String position)
	{
		this.position = position;
	}

	public List<NodegroupTable> getNodeGroupList()
	{
		return nodeGroupList;
	}

	public void setNodeGroupList(List<NodegroupTable> nodeGroupList)
	{
		this.nodeGroupList = nodeGroupList;
	}
	
	public NodegroupTable getNodeGroup()
	{
		return nodeGroup;
	}
	
	public void setNodeGroup(NodegroupTable nodeGroup)
	{
		this.nodeGroup = nodeGroup;
	}
	
	public Long getNodeGroupId()
	{
		return nodeGroupId;
	}
	
	public void setNodeGroupId(Long nodeGroupId)
	{
		this.nodeGroupId = nodeGroupId;
	}
	
	public Long[] getIds()
	{
		return ids;
	}
	
	public void setIds(Long[] ids)
	{
		this.ids = ids;
	}
	
	public List<XtJsJbxx> getAllUserGroup()
	{
		return allUserGroup;
	}
	
	public void setAllUserGroup(List<XtJsJbxx> allUserGroup)
	{
		this.allUserGroup = allUserGroup;
	}
	
	public String getNameVo()
	{
		return nameVo;
	}
	
	public void setNameVo(String nameVo)
	{
		this.nameVo = nameVo;
	}
	
	public String getDescVo()
	{
		return descVo;
	}

	public void setDescVo(String descVo)
	{
		this.descVo = descVo;
	}

	public String getShowStopNGroup() {
		return showStopNGroup;
	}
	
	public void setShowStopNGroup(String showStopNGroup) {
		this.showStopNGroup = showStopNGroup;
	}
	
	public List<Resource> getTreeList()
	{
		return treeList;
	}
	
	public void setTreeList(List<Resource> treeList)
	{
		this.treeList = treeList;
	}
	
	public SystemTable getSystem()
	{
		return system;
	}
	
	public void setSystem(SystemTable system)
	{
		this.system = system;
	}
	
	public List<SystemTable> getSystemList()
	{
		return systemList;
	}
	
	public void setSystemList(List<SystemTable> systemList)
	{
		this.systemList = systemList;
	}
	
	public List<NodeTable> getNodeList()
	{
		return nodeList;
	}
	
	public void setNodeList(List<NodeTable> nodeList)
	{
		this.nodeList = nodeList;
	}
	
	public String getIsStartSubNodeGroup()
	{
		return isStartSubNodeGroup;
	}
	
	public void setIsStartSubNodeGroup(String isStartSubNodeGroup)
	{
		this.isStartSubNodeGroup = isStartSubNodeGroup;
	}
	
	public String getGroupId()
	{
		return groupId;
	}

	public void setGroupId(String groupId)
	{
		this.groupId = groupId;
	}
	
	public Set<String> getLeafNodeGroupIdsByPar()
	{
		return leafNodeGroupIdsByPar;
	}
	
	public void setLeafNodeGroupIdsByPar(Set<String> leafNodeGroupIdsByPar)
	{
		this.leafNodeGroupIdsByPar = leafNodeGroupIdsByPar;
	}

	public String getFromWhere() {
		return fromWhere;
	}

	public void setFromWhere(String fromWhere) {
		this.fromWhere = fromWhere;
	}

	public String getIsComplete() {
		return isComplete;
	}

	public void setIsComplete(String isComplete) {
		this.isComplete = isComplete;
	}

	
	public String getType()
	{
		return type;
	}

	
	public void setType(String type)
	{
		this.type = type;
	}
}
