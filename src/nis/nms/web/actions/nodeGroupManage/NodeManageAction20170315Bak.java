package nis.nms.web.actions.nodeGroupManage;

import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import nis.nms.bean.DiSysteminfo;
import nis.nms.bean.DiSysteminfoDisk;
import nis.nms.bean.DiSysteminfoNet;
import nis.nms.core.Constants;
import nis.nms.core.Resource;
import nis.nms.domains.NodeBoxTable;
import nis.nms.domains.NodeLatticeTable;
import nis.nms.domains.NodePosition;
import nis.nms.domains.NodeTable;
import nis.nms.domains.NodeTableVo;
import nis.nms.domains.NodegroupTable;
import nis.nms.domains.OptionTable;
import nis.nms.domains.SystemTable;
import nis.nms.domains.XtYhJsIndex;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Constant;
import nis.nms.util.ExportUtils;
import nis.nms.util.IpCovert;
import nis.nms.util.Page;
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
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;
import com.nis.util.StringUtil;

@SuppressWarnings("unchecked")
@Results( {
		@Result(name = "queryNodeInfo", value = "/page/systemManage/nodeGroupManage/node/nodeInfoList.jsp"),
		@Result(name = "queryNodeInfoChild", value = "/page/systemManage/nodeGroupManage/node/nodeInfoListIn.jsp"),
		@Result(name = "addNodeInfo", value = "/page/systemManage/nodeGroupManage/node/addNodeInfo.jsp"),
		@Result(name = "updateNodeInfo", value = "/page/systemManage/nodeGroupManage/node/updateNodeInfo.jsp"),
		@Result(name = "detailNodeInfo", value = "/page/systemManage/nodeGroupManage/node/detailNodeInfo.jsp"),
		@Result(name = "showError", value = "/page/systemManage/nodeGroupManage/node/showImportError.jsp") })
public class NodeManageAction20170315Bak extends BaseAction {

	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(NodeManageAction.class);
	private CommonService commonService;
	private int pageNo = 1;
	private int pageSize = this.getDefaultPageSize(); // 每页显示的记录条数
	private Page page;
	private String action;// 系统操作

	private List<NodeTable> nodeList;
	private NodeTable nodeTable;
	private Long nodeId;

	// 查询条件
	private String nodeNameVo;
	private String nodeDescVo;
	private String nodeIpVo;
	private Long nodeGroupId;// 指定组ID查找相应的节点

	private Long mkid;// 节点组ID
	private List<Resource> treeList;// 节点组菜单
	private String isValid;// 节点所属的叶子节点组的有效性

	// 导入节点文件
	private File myFile;
	private String myFileFileName;

	private String oldNodeIp;
	private String isNone;

	private Long boxSPosition;
	private Long boxEPosition;
	private String nodeIp;

	private String fromWhere;
	private String isComplete;
	
	private String showStopNGroup; // 是否显示下线节点组

	// 配置向导标志 type=config标识是从配置向导发出的请求
	private String type;

	// 数据字典 网元节点分类
	private List<OptionTable> optionList = new ArrayList<OptionTable>();

	@Override
	public String executeAction() throws Exception {
		String resultPage = "";
		this.getRequest().setAttribute("fromWhere", fromWhere);
		if ("query".equals(this.action)) {// 管理页面，显示所有节点信息
			resultPage = queryNodeInfo();
		} else if ("queryChild".equals(this.action)) {// 管理页面，显示所有节点信息
			resultPage = queryNodeInfoChild();
		} else if ("openAdd".equals(this.action)) {// 转向添加页面
			this.getRequest().setAttribute("fromWhere", fromWhere);
			resultPage = openAddNodeInfo();
		} else if ("doAdd".equals(this.action)) {// 提交添加信息
			addNodeInfo();
			return null;
		} else if ("openUpdate".equals(this.action)) {// 转向修改页面
			resultPage = openUpdateNodeInfo();
		} else if ("doUpdate".equals(this.action)) {// 提交修改信息
			updateNodeInfo();
			return null;
		} else if ("stop".equals(this.action)) {// 停用
			stopNodeInfo();
			return null;
		} else if ("start".equals(this.action)) {// 启用
			startNodeInfo();
			return null;
		} else if ("detail".equals(this.action)) {// 查看详情
			resultPage = detailNodeInfo();
		} else if ("downloadExample".equals(this.action)) {// 导出模板
			resultPage = this.downloadExample();
		} else if ("importXls".equals(this.action)) {// 导入
			resultPage = this.importXls();
		} else if ("emportCurrentXls".equals(this.action)) {// 导出当前页
			resultPage = this.emportCurrentXls();
		} else if ("emportAllXls".equals(this.action)) {// 导出全部
			resultPage = this.emportAllXls();
		} else if ("queryInfoForAjax".equals(this.action)) {
			// 联想查询 --nodeip 查询下线节点
			resultPage = this.queryInfoForAjax();
		} else {
			resultPage = queryNodeInfo();
		}
		return resultPage;
	}

	// 管理节点信息列表
	public String queryNodeInfo() {
		try {
			// System.out.println("节点 IPN 跟新开始");
			// List<NodeTable> ntList = commonService.find("from NodeTable");
			// for(NodeTable node : ntList){
			// if(StringUtils.isNotEmpty(node.getNodeIp())){
			// node.setIpn(IpCovert.ipToLong(node.getNodeIp()));
			// }else{
			// node.setIpn(0l);
			// }
			// commonService.update(node);
			// }
			// System.out.println("节点 IPN 跟新OK");
			isComplete = this.getRequest().getParameter("isComplete");
			String hql = "from NodeTable where 1=1";
			String sqlCondition = "select * from node_table where 1=1";
			if (nodeIpVo != null && !nodeIpVo.trim().equals("")) {
				hql += " and nodeIp like '%" + nodeIpVo.trim() + "%'";
				sqlCondition += " and node_ip like '%" + nodeIpVo.trim() + "%'";
			}
			if (nodeNameVo != null && !nodeNameVo.trim().equals("")) {
				hql += " and Upper(nodeName) like '%"
						+ nodeNameVo.trim().toUpperCase() + "%'";
				sqlCondition += " and Upper(node_name) like '%"
						+ nodeNameVo.trim().toUpperCase() + "%'";
			}
			if (nodeDescVo != null && !nodeDescVo.trim().equals("")) {
				hql += " and Upper(nodeDesc) like '%"
						+ nodeDescVo.trim().toUpperCase() + "%'";
				sqlCondition += " and Upper(node_desc) like '%"
						+ nodeDescVo.trim().toUpperCase() + "%'";
			}

			if (nodeGroupId != null) {// 指定组ID查找相应的节点
				hql += " and groupId =" + nodeGroupId + "";
			}
			hql += " order by nodeState asc,nodeCreatetime desc";
			sqlCondition += " order by node_state asc,Node_createtime desc";

			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "node_table");

			page = this.commonService.findByPage(hql, pageNo, pageSize);
			nodeList = (List<NodeTable>) page.getResult();

			for (NodeTable node : nodeList) {
				List syslist = this.commonService
						.find("from SystemTable where systemId = "
								+ node.getSystemId());
				if (syslist != null && syslist.size() > 0) {
					node.setSystemIdName(((SystemTable) syslist.get(0))
							.getSystemName());
				}
				NodegroupTable nodegroupTable = (NodegroupTable) this.commonService
						.get(NodegroupTable.class, node.getGroupId());
				if (nodegroupTable != null) {
					node.setGroupIdName(nodegroupTable.getGroupName());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
		return "queryNodeInfo";
	}

	public String queryNodeInfoChild() {
		try {
			isComplete = this.getRequest().getParameter("isComplete");
			String hql = "from NodeTable where 1=1";
			String sqlCondition = "select * from node_table where 1=1";
			String nodeStateVo = this.getRequest().getParameter("nodeStateVo");
			this.getRequest().setAttribute("nodeStateVo", nodeStateVo);
			if (nodeStateVo != null && !nodeStateVo.trim().equals("")) {
				hql += " and nodeState =" + nodeStateVo.trim();
				sqlCondition += " and nodeState =" + nodeStateVo.trim();
			}
			if (nodeIpVo != null && !nodeIpVo.trim().equals("")) {
				hql += " and nodeIp like '%" + nodeIpVo.trim() + "%'";
				sqlCondition += " and node_ip like '%" + nodeIpVo.trim() + "%'";
			}
			if (nodeNameVo != null && !nodeNameVo.trim().equals("")) {
				hql += " and Upper(nodeName) like '%"
						+ nodeNameVo.trim().toUpperCase() + "%'";
				sqlCondition += " and Upper(node_name) like '%"
						+ nodeNameVo.trim().toUpperCase() + "%'";
			}
			if (nodeDescVo != null && !nodeDescVo.trim().equals("")) {
				hql += " and Upper(nodeDesc) like '%"
						+ nodeDescVo.trim().toUpperCase() + "%'";
				sqlCondition += " and Upper(node_desc) like '%"
						+ nodeDescVo.trim().toUpperCase() + "%'";
			}

			if (nodeGroupId != null) {// 指定组ID查找相应的节点
				//@2018-3-9 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
				String groupIdSql = "select group_id from nodegroup_table t where 1=1 ";
				String ids = this.commonService.getGroupIdStartWith(groupIdSql, "t.group_id = " +nodeGroupId);
				/*List nodeGroupList = this.commonService
						.executeSQL("select distinct t.group_Id from nodegroup_table t  start with group_Id ="
								+ nodeGroupId
								+ " connect by prior group_Id = t.parent_group_id");
				if (nodeGroupList != null && nodeGroupList.size() > 0) {
					String str = StringUtils.join(nodeGroupList.toArray(), ",");
					hql += " and groupId in (" + str + ")";
				}*/
				if(!StringUtil.isBlank(ids)){
					hql += " and groupId in (" + ids + ")";
				}
			}

			// 默认显示本系统的节点（不显示新节点：NC自动注册的节点）----start,2013-7-4,hyx
			boolean ADMFlag = this.getAdminMark();
			this.getRequest().setAttribute("ADMFlag", ADMFlag);
			// 当前登录用户非admin时才做查看权限限制
			if (!ADMFlag) {
				// 如果当前登录选择了业务系统，则只做和本业务系统相关的操作
				if (this.getSystemID() != null) {
					hql += " and systemId = " + this.getSystemID();
					sqlCondition += " and system_id=" + this.getSystemID();
				}
			}
			// -------------------------end

			hql += " order by nodeState asc,nodeCreatetime desc";
			sqlCondition += " order by node_state asc,Node_createtime desc";

			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "node_table");

			page = this.commonService.findByPage(hql, pageNo, pageSize);
			nodeList = (List<NodeTable>) page.getResult();

			for (NodeTable node : nodeList) {
				List syslist = this.commonService
						.find("from SystemTable where systemId = "
								+ node.getSystemId());
				if (syslist != null && syslist.size() > 0) {
					node.setSystemIdName(((SystemTable) syslist.get(0))
							.getSystemName());
				}
				NodegroupTable nodegroupTable = (NodegroupTable) this.commonService
						.get(NodegroupTable.class, node.getGroupId());
				if (nodegroupTable != null) {
					node.setGroupIdName(nodegroupTable.getGroupName());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
		return "queryNodeInfoChild";
	}

	// 查询模块名称、描述
	public String queryInfoForAjax() {
		String ajaxProperties = this.getRequest()
				.getParameter("ajaxProperties").trim();
		String ajaxTableName = this.getRequest().getParameter("ajaxTableName")
				.trim();
		String ajaxType = null;
		if (this.getRequest().getParameter("ajaxType") != null) {
			ajaxType = this.getRequest().getParameter("ajaxType").trim();
		}
		String ajaxValue = null;
		if (this.getRequest().getParameter("ajaxValue") != null) {
			ajaxValue = this.getRequest().getParameter("ajaxValue").trim();
		}
		String nodeType = null;
		if (this.getRequest().getParameter("nodeType") != null) {
			nodeType = this.getRequest().getParameter("nodeType").trim();
		}
		String isTableconfig = "";
		String sq1 = "lower(";
		String sq2 = ")";
		if (null != ajaxProperties && !("").equals(ajaxProperties)
				&& null != ajaxTableName && !("").equals(ajaxTableName)
				&& null != ajaxType && !("").equals(ajaxType)) {
			if (("TableConfig").equals(ajaxTableName))
				isTableconfig = " and x.activeflag not in(9,11)";
			if (("Tableconfig").equals(ajaxTableName)
					&& ("subject").equals(ajaxProperties)) {
				sq1 = "";
				sq2 = "";
			}
			try {
				StringBuffer stringBuffer = new StringBuffer();
				if (("String").equals(ajaxType)) {
					String sql = "select distinct trim(x." + ajaxProperties
							+ ") from " + ajaxTableName + " x where 1=1 and x."
							+ ajaxProperties + "!='null' " + " and " + sq1
							+ "x." + ajaxProperties + "" + sq2 + " like ('%"
							+ ajaxValue.toLowerCase() + "%') " + isTableconfig;
					Object systemIdObj = this.getRequest().getSession()
							.getAttribute(Constant.SESSION_SYSTEM_LOGIN);
					if (!StringUtil.isEmpty(systemIdObj)
							&& ajaxProperties.equals("nodeIp")
							&& ajaxTableName.equals("NodeTable")) {
						Long systemId = new Long(systemIdObj.toString());
						// admin 的systemId为-1 管理员可以查看所有系统
						if (systemId != -1l) {
							sql += " and x.systemId = " + systemId;
						}
						if (!StringUtil.isEmpty(nodeType)) {
							sql += " and x.nodeType = " + nodeType;
						}
					}
					// 检测类别联想
					if (ajaxProperties.equals("checkTypeName1")) {
						if (this.getAdminMark()) {
							sql += " and x.isSchedule<>2";
						} else {
							sql += " and x.isSchedule<>2  and (( x.viewLevel=1 and x.userId="
									+ this.getUserID()
									+ "  and x.systemId ="
									+ this.getSystemID()
									+ ")  or ( x.viewLevel=2 and x.groupId in (select  x1.jsbh from  XtYhJsIndex  x1  where x1.yhbh=' "
									+ super.getUser().getYhbh()
									+ "' and x1.type = 1) and x.systemId = "
									+ this.getSystemID()
									+ ") or (x.viewLevel=3 and x.systemId = "
									+ this.getSystemID()
									+ ") or (x.viewLevel=4 ))";
						}
					}
					sql += " order by trim(x." + ajaxProperties + ")";
					System.out.println("lianxiang sql：" + sql);
					List<String> list = this.commonService.find(sql);
					for (String s : list) {
						stringBuffer.append("" + s + ",");
					}
				}
				if (stringBuffer.length() > 0)
					stringBuffer.replace(stringBuffer.length() - 1,
							stringBuffer.length(), "");
				System.out.println(stringBuffer.toString());
				this.getResponse().setCharacterEncoding("utf-8");
				PrintWriter printWriter = this.getResponse().getWriter();
				printWriter.write(stringBuffer.toString());
				printWriter.close();
				printWriter = null;
			} catch (Exception e) {
				e.printStackTrace();
				return "error";
			}
		}
		return null;
	}

	// 打开添加节点页面
	public String openAddNodeInfo() {
		try {
			// 如果没有指定具体的节点组，即不在节点组查看详情页面点击新增
			if (nodeGroupId == null || nodeGroupId.equals("")) {
				// 查询节点组
				treeList = new ArrayList();
				String hql = "from NodegroupTable where isValid=1";// 0是失效，1是生效
				// 1 发布人查看,2 发布人所在组查看,3 系统内全部人员可看
				hql += " and (";
				hql += " (viewLevel=1 and createUserId=" + this.getUserID()
						+ ")";
				hql += " or (viewLevel=2 and createUsergroupId in (select jsbh from XtYhJsIndex "
						+ " where type=1 and yhbh='"
						+ this.getUser().getYhbh()
						+ "') )";
				hql += " or (viewLevel=3 and systemId in"
						+ " (select systemId from GorupSystemTable where userGroupId in"
						+ " (select jsbh from XtYhJsIndex where type=1 and yhbh='"
						+ this.getUser().getYhbh() + "')" + " ) )";
				hql += ")";
				List<NodegroupTable> menuList = this.commonService.find(hql);
				for (int i = 0; i < menuList.size(); i++) {
					Resource resource = new Resource();
					resource.setParRsCode("0");
					resource.setRsCode(menuList.get(i).getGroupId().toString());
					resource.setRsid(menuList.get(i).getGroupId().toString());
					resource.setRsname(menuList.get(i).getGroupName());
					treeList.add(resource);
				}
				this.getRequest().setAttribute("treeList", treeList);
				String sqlCondition = "where is_valid=0";// 将查询条件记录到操作日志中
				// 将查询请求记入到操作日志表中
				this.addDBOperationRpt(commonService, sqlCondition,
						"nodegroup_table");
			}
			// 新增网元节点分类属性
			String sql = "select * from option_table t where t.TYPE_IDENTITY ='netelementtype' ORDER by t.show_num";
			optionList = this.commonService.executeSQL(sql, OptionTable.class);

			if(isAdminRole()){
				this.getRequest().setAttribute("jsbh",true);
			}
			this.addDBOperationRpt(commonService, sql, "option_table");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}

		return "addNodeInfo";
	}

	/**
	 * 新增节点：1、统一同一物理机的机柜位置 2、统一同一物理机的节点U位
	 */
	public void addNodeInfo() {
		try {
			if (nodeGroupId != null && !nodeGroupId.equals("")) {
				mkid = nodeGroupId;
			}
			boxSPosition = nodeTable.getNodeBeginUType();
			boxEPosition = nodeTable.getNodeBeginUType()
					+ nodeTable.getNodeUType() - 1;
			// IP在同一节点组下不重复
			if (!groupNodeIpIsRepeat(nodeTable.getNodeIp(), mkid)) {
				NodegroupTable group = (NodegroupTable) this.commonService.get(
						NodegroupTable.class, mkid);
				if (group != null) {
					long seqId = this.getNodeSeqID(nodeTable.getNodeIp());
					// 保存节点信息
					nodeTable.setSystemId(group.getSystemId());
					nodeTable.setCreateUserId(this.getUserID());
					nodeTable.setNodeCreatetime(new Date());
					nodeTable.setGroupId(group.getGroupId());
					nodeTable.setIpn(IpCovert.ipToLong(nodeTable.getNodeIp()
							.trim()));
					// ----------处理seqId与机柜位置
					// ----------2012-7-13 修改 节点所在机柜及位置由新增修改节点界面维护
					// 查看该机柜从起始位置到结束位置是否放有节点机（SEQID不为空即为存放了节点）
					List<NodeLatticeTable> nltList = this.commonService
							.find(
									"from NodeLatticeTable where nodeSeqId is not null and nodeSeqId<>?"
											+ " and (nodeposition between ? and ?)"
											+ " and nodeBoxId in(select nodeBoxId from NodeBoxTable where ispn='"
											+ nodeTable.getNodeBoxIspn() + "')",
									seqId, boxSPosition, boxEPosition);
					if (nltList != null && nltList.size() > 0) {
						this
								.outHtmlString("<script>alert('该节点的所选机柜位置已放有节点，请重新输入！');history.back();</script>");
						return;
					} else {
						// 首先清空当前节点已有记录的位置情况
						String hql = "update NodeLatticeTable set nodeSeqId=null where nodeSeqId=?";
						this.commonService.updateByHql(hql, seqId);
						// 再更新位置为当前所选机柜位置
						hql = "update NodeLatticeTable set nodeSeqId="
								+ seqId
								+ " where nodeBoxId in(select nodeBoxId from NodeBoxTable where ispn='"
								+ nodeTable.getNodeBoxIspn()
								+ "') and nodeposition between ? and ?";
						this.commonService.updateByHql(hql, boxSPosition,
								boxEPosition);
					}
					// ----------2012-7-13 修改 end
					nodeTable.setSeqId(seqId);
					nodeTable.setNodeSystemType(this.getNodeSystemType(seqId));
					nodeTable.setNodeState(0l);
					// 密码字段加密
					if (nodeTable.getNodePassword() != null
							&& !StringUtil.isBlank(nodeTable.getNodePassword()
									.trim())) {
						BASE64Encoder encoder = new BASE64Encoder();
						String nodePassword = encoder.encode(nodeTable
								.getNodePassword().trim().getBytes());
						nodeTable.setNodePassword(nodePassword);
					}

					this.commonService.save(nodeTable);

					// 2012-7-16 更新所有同一物理机SeqID的U位相同(2012-9-12
					// 同一物理机的起始U位、机柜编号也相同)
					// 2012-12-12 更新所有统一物理机SeqID的snmp.version相同
					// -----NodeTable表中节点U位、起始U位、机柜编号，这三个值未删除是因为方便导出模板时使用，还有就是拓扑图展示时使用。在新增和修改时都未从这里取值，而是从节点位置表中取值。
					// 2013-05-16 IP相同的节点同步更新Mac、节点类型、网元类型 add by jinsj
					/*
					 * this.commonService .updateByHql("update NodeTable set
					 * nodeUType=?,nodeBeginUType=?,nodeBoxIspn=?,snmpVersion=?,nodeMac=?,nodeType=?,networElementType=?
					 * where seqId=?", nodeTable.getNodeUType(),
					 * nodeTable.getNodeBeginUType(),
					 * nodeTable.getNodeBoxIspn(), nodeTable.getSnmpVersion(),
					 * nodeTable.getNodeMac(), nodeTable.getNodeType(),
					 * StringUtil.isEmpty(nodeTable.getNetworElementType())
					 * ?"":nodeTable.getNetworElementType(), seqId);
					 */

					String networElementType = StringUtil.isEmpty(nodeTable
							.getNetworElementType()) ? "" : nodeTable
							.getNetworElementType()
							+ "";
					String sql = "UPDATE node_table t SET t.node_u_type="
							+ nodeTable.getNodeUType() + ",t.node_begin_utype="
							+ nodeTable.getNodeBeginUType()
							+ ",t.node_box_ispn='" + nodeTable.getNodeBoxIspn()
							+ "',t.snmp_version='" + nodeTable.getSnmpVersion()
							+ "',t.node_mac='" + nodeTable.getNodeMac()
							+ "',t.node_type=" + nodeTable.getNodeType()
							+ ",t.network_element_type='" + networElementType
							+ "' WHERE t.seq_id=" + seqId;
					commonService.updateBySql(sql);

					// 拓扑图的数据维护
					if (nltList != null && nltList.size() > 0) {
						String boxId = nltList.get(0).getNodeBoxId() + "";
						// 查找父记录
						List nplist = this.commonService
								.find(
										"from NodePosition where nodeType='nodeGroup' and nodeId=?",
										nodeTable.getGroupId() + "");
						if (nplist != null && nplist.size() > 0) {
							NodePosition parent = (NodePosition) nplist.get(0);
							// 查找是否有相同记录存在，不存在再添加
							nplist = this.commonService
									.find(
											"from NodePosition where nodeType='nodeBox' and nodeId=? and parent_id=?",
											boxId, parent.getId());
							if (nplist == null || nplist.size() == 0) {
								NodePosition np = new NodePosition();
								np.setTableName("node_box_table");
								np.setNodeType("nodeBox");
								np.setNodeId(boxId);
								np.setPositionX(0l);
								np.setPositionY(0l);
								np.setImageUrl("/nmsweb/images/show/nm.png");
								np.setViewTimeMark(new Date());
								np.setViewType(2l);
								np.setParent_id(parent.getId());

								this.commonService.save(np);
								this.addDBOperationRpt(commonService,
										"node_position", "INSERT", np.getId());
							}
						}
					}

					if (new Long(1).equals(group.getIsValid())) { // 节点组有效
						this.sendNodeAndGroupId(nodeTable.getGroupId(),
								nodeTable.getNodeId(), commonService); // 通知NMSServer更新节点组的监控信息
					}

					// 将添加操作写到操作日志中
					this.addDBOperationRpt(commonService, "node_table",
							"INSERT", nodeTable.getNodeId());
				}
				// 记录用户操作用于设置向导
				if (fromWhere != null && !"".equals(fromWhere)) {
					if (fromWhere.equals("formGuide")) {
						outHtmlString("<script type=\"text/javascript\">alert('操作成功');this.location='nodeManage.do?action=query&isComplete=0&nodeGroupId="
								+ mkid + "&isValid=" + isValid + "&showStopNGroup="+showStopNGroup+ "'</script>");
					}
				} else {
					outHtmlString("<script type=\"text/javascript\">alert('操作成功');this.location='nodeManage.do?action=query&nodeGroupId="
							+ mkid + "&isValid=" + isValid + "&showStopNGroup="+showStopNGroup+ "'</script>");
				}
			} else {
				this
						.outHtmlString("<script>alert('该节点组下已经存在该IP，请重新输入！');history.back();</script>");
				return;
			}
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('操作失败');this.location='nodeManage.do?action=query&nodeGroupId="
					+ mkid + "&isValid=" + isValid + "&showStopNGroup="+showStopNGroup+ "'</script>");
		}
	}

	/**
	 * 根据节点的唯一标识判断同一节点的节点类型和U位是否一致
	 * 
	 * @param seqId
	 *            节点唯一标识
	 * @param nodeType
	 *            节点类型
	 * @param uType
	 *            节点U位类型
	 * @return
	 */
	public boolean checkNodeTypeAndU(Long seqId, Long nodeType, Long uType,
			Long nodeId) {
		boolean flag = true;
		try {
			String sql = "from NodeTable where seqId=" + seqId;
			if (nodeId != null && !"".equals(nodeId)) {
				sql += " and nodeId<>" + nodeId;
			}
			sql += " order by nodeUType";
			List list = this.commonService.find(sql);
			if (list != null && list.size() > 0) {
				NodeTable nt = (NodeTable) list.get(0);
				if (nt.getNodeType() != null && nodeType != null
						&& nt.getNodeType().intValue() != nodeType.intValue()) {
					flag = false;
				}
				if (nt.getNodeUType() != null && uType != null
						&& nt.getNodeUType().intValue() != uType.intValue()) {
					flag = false;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			flag = false;
		}

		return flag;
	}

	/**
	 * 根据新旧ip获取节点唯一标识
	 * 
	 * @param nodeIp
	 *            节点ip
	 * @return 节点唯一标识
	 */
	public Long getNodeSeqID(String nodeIp) {
		List<Object> list = new ArrayList();
		try {
			list = this.commonService
					.executeSQL("select nt.seq_id from node_table nt where nt.node_ip = '"
							+ nodeIp + "'");
			if (list != null && list.size() > 0) { // 已存在
				if (list.get(0) != null && !"".equals(list.get(0))) {
					return Long.parseLong(list.get(0).toString());
				} else {
					list = this.commonService
							.executeSQL("select seq_seq_id.nextval seq_id from dual");
					if (list.get(0) != null && !"".equals(list.get(0))) {
						return Long.parseLong(list.get(0).toString());// 跳过
					} else {
						return null;
					}
				}
			} else {
				list = this.commonService
						.executeSQL("select seq_seq_id.nextval seq_id from dual");
				if (list.get(0) != null && !"".equals(list.get(0))) {
					return Long.parseLong(list.get(0).toString());// 跳过
				} else {
					return null;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 根据节点唯一标识seqId获取节点操作系统类型
	 * 
	 * @param seqId
	 *            节点唯一标识
	 * @return 节点操作系统类型
	 */
	public Long getNodeSystemType(Long seqId) {
		try {
			if (seqId != null) {
				List<Object> list = this.commonService
						.executeSQL("select nt.node_system_type from node_table nt where nt.seq_id = "
								+ seqId);
				if (list != null && list.size() > 0) { // 已存在
					if (list.get(0) != null && !"".equals(list.get(0))) {
						return Long.parseLong(list.get(0).toString());
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return null;
	}

	/**
	 * 根据节点ip判断是否是新ip
	 * 
	 * @param nodeIp
	 * @return
	 */
	public boolean nodeIpIsNew(String nodeIp) {
		boolean retFlag = true;
		List<Object[]> list = new ArrayList();
		if (nodeIp != null && !"".equals(nodeIp)) {
			try {
				list = this.commonService
						.executeSQL("select nt.node_ip,nt.seq_id from node_table nt where nt.node_ip = '"
								+ nodeIp + "'");
				if (list != null && list.size() > 0) { // 已存在
					retFlag = false;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return retFlag;
	}

	/**
	 * 根据节点ip判断是否是是多重IP记录
	 * 
	 * @param nodeIp
	 * @return
	 */
	public boolean nodeIpIsRepeat(String nodeIp, Long nodeId) {
		boolean retFlag = false;
		List<Object[]> list = new ArrayList();
		if (nodeIp != null && !"".equals(nodeIp)) {
			try {
				list = this.commonService
						.executeSQL("select nt.node_ip,nt.seq_id from node_table nt where nt.node_ip = '"
								+ nodeIp + "' and nt.node_id <> " + nodeId);
				if (list != null && list.size() > 0) { // 已存在
					retFlag = true;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return retFlag;
	}

	/**
	 * 判断新节点在ip节点组中是否重复
	 * 
	 * @param nodeIp
	 *            节点IP
	 * @param groupId
	 *            节点组ID
	 * @return 是true否false
	 */
	public boolean groupNodeIpIsRepeat(String nodeIp, Long groupId) {
		boolean retFlag = false;
		List<Object[]> list = new ArrayList();
		if (nodeIp != null && !"".equals(nodeIp)) {
			try {
				list = this.commonService
						.executeSQL("select nt.node_id  from node_table nt where nt.node_ip = '"
								+ nodeIp
								+ "' and nt.node_group_id = "
								+ groupId);
				if (list != null && list.size() > 0) { // 已存在
					retFlag = true;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return retFlag;
	}

	/**
	 * 判断新节点在ip节点组中是否重复
	 * 
	 * @param nodeIp
	 *            节点IP
	 * @param groupId
	 *            节点组ID
	 * @return 是true否false
	 */
	public boolean groupNodeIpIsRepeat(String nodeIp, Long groupId, Long nodeId) {
		boolean retFlag = false;
		List<Object[]> list = new ArrayList();
		if (nodeIp != null && !"".equals(nodeIp)) {
			try {
				list = this.commonService
						.executeSQL("select nt.node_id  from node_table nt where nt.node_id <> "
								+ nodeId
								+ " and nt.node_ip = '"
								+ nodeIp
								+ "' and nt.node_group_id = " + groupId);
				if (list != null && list.size() > 0) { // 已存在
					retFlag = true;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return retFlag;
	}

	/**
	 * 根据节点的seqId获取节点的boxId
	 * 
	 * @param seqId
	 *            节点的seqId
	 * @return 节点的boxId
	 */
	/*
	 * public Long getNodeBoxID(Long seqId) { Long boxId = null; List<Object>
	 * list = new ArrayList(); try { list = this.commonService
	 * .executeSQL("select mt.box_id from nodegroup_mem_table mt where mt.box_id
	 * is not null and mt.node_id in (select nt.node_id from node_table nt where
	 * nt.seq_id = " + seqId + ")"); if (list != null && list.size() > 0) { //
	 * 已存在 if (list.get(0) != null && !"".equals(list.get(0))) { boxId =
	 * Long.parseLong(list.get(0).toString()); } } } catch (Exception e) {
	 * e.printStackTrace(); return null; } return boxId; }
	 */

	// 打开修改节点信息页面
	public String openUpdateNodeInfo() {
		try {
			// 新增网元节点分类属性
			String sql = "select * from option_table t where t.TYPE_IDENTITY ='netelementtype' ORDER by t.show_num";
			optionList = this.commonService.executeSQL(sql, OptionTable.class);

			this.addDBOperationRpt(commonService, sql, "option_table");

			List list = this.commonService.find(
					"from NodeTable where nodeId=?", nodeId);
			if (list != null && list.size() > 0) {
				nodeTable = (NodeTable) list.get(0);
				// 密码字段解密
				if (nodeTable.getNodePassword() != null
						&& !StringUtil.isBlank(nodeTable.getNodePassword()
								.trim())) {
					BASE64Decoder decoder = new BASE64Decoder();
					String nodePassword = new String(decoder
							.decodeBuffer(nodeTable.getNodePassword().trim()),
							"utf-8");
					nodeTable.setNodePassword(nodePassword);
				}

				// 判断U位是否为空
				if (!"".equals(nodeTable.getNodeUType())
						&& nodeTable.getNodeUType() != null) {
					isNone = "block";
				} else {
					isNone = "none";
				}
				// 如果没有指定具体的节点组，即不在节点组查看详情页面点击修改
				if (nodeGroupId == null || nodeGroupId.equals("")) {
					// 查询节点组
					treeList = new ArrayList();
					String hql = "from NodegroupTable where isValid=1";// 0是失效，1是生效
					// 1 发布人查看,2 发布人所在组查看,3 系统内全部人员可看
					hql += " and (";
					hql += " (viewLevel=1 and createUserId=" + this.getUserID()
							+ ")";
					hql += " or (viewLevel=2 and createUsergroupId in (select jsbh from XtYhJsIndex "
							+ " where type=1 and yhbh='"
							+ this.getUser().getYhbh() + "') )";
					hql += " or (viewLevel=3 and systemId in"
							+ " (select systemId from GorupSystemTable where userGroupId in"
							+ " (select jsbh from XtYhJsIndex where type=1 and yhbh='"
							+ this.getUser().getYhbh() + "')" + " ) )";
					hql += ")";
					List<NodegroupTable> menuList = this.commonService
							.find(hql);
					for (int i = 0; i < menuList.size(); i++) {
						Resource resource = new Resource();
						// 如果本节点属于这个节点组将其选中
						if (menuList.get(i).getGroupId().equals(nodeGroupId)) {
							resource.setChecked("checked");
						}
						resource.setParRsCode("0");
						resource.setRsCode(menuList.get(i).getGroupId()
								.toString());
						resource.setRsid(menuList.get(i).getGroupId()
								.toString());
						resource.setRsname(menuList.get(i).getGroupName());
						treeList.add(resource);
					}
					this.getRequest().setAttribute("treeList", treeList);
				}
				if(isAdminRole()){
					this.getRequest().setAttribute("jsbh",true);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
		return "updateNodeInfo";
	}
	
	public Boolean isAdminRole() throws Exception{
		String YHBH = (String) this.getRequest().getSession().getAttribute("YHBH");//用户编号
		String hql1 = "from XtYhJsIndex where yhbh = ? and type = null";
		List<XtYhJsIndex> list1 = this.commonService.find(hql1, YHBH);
		for(XtYhJsIndex item : list1){
			if((Constants.ADMIN_ROLE_BH).equals(item.getJsbh().toString())){
				//当前角色拥有管理员的权限
				return true;
			}
		}
		return false;
	}

	/**
	 * 修改节点：1、统一同一物理机的机柜位置 2、统一同一物理机的节点U位
	 */
	public void updateNodeInfo() {
		try {
			if (nodeGroupId != null && !nodeGroupId.equals("")) {
				mkid = nodeGroupId;
			}
			boxSPosition = nodeTable.getNodeBeginUType();
			boxEPosition = nodeTable.getNodeBeginUType()
					+ nodeTable.getNodeUType() - 1;
			// IP在同一节点组下不重复
			if (!groupNodeIpIsRepeat(nodeTable.getNodeIp(), mkid, nodeTable
					.getNodeId())) {
				NodeTable nt = (NodeTable) this.commonService.get(
						NodeTable.class, nodeTable.getNodeId());
				if (nt != null) {
					boolean flag = false;
					Long seqId = nt.getSeqId();
					if (oldNodeIp != null && !"".equals(oldNodeIp)) {
						// 新旧节点IP不一致，节点IP变更
						if (!oldNodeIp.equals(nodeTable.getNodeIp().trim())) {
							// 不是新IP
							if (!nodeIpIsNew(nodeTable.getNodeIp().trim())) {
								seqId = this.getNodeSeqID(nodeTable.getNodeIp()
										.trim());
								nt.setSeqId(seqId);
								nt.setNodeSystemType(this
										.getNodeSystemType(seqId));
							} else if (nodeIpIsRepeat(oldNodeIp, nt.getNodeId())) {
								// 是新IP判断oldNodeIP已存在重复记录
								// 如果oldNodeIP已存在重复记录则需要变更该记录的SEQID
								// 如果oldNodeIP不存在重复记录则无需变更该记录的SEQID
								seqId = this.getNodeSeqID(nodeTable.getNodeIp()
										.trim());
								nt.setSeqId(seqId);
								nt.setNodeSystemType(this
										.getNodeSystemType(seqId));
							}
						}
					}
					// 防止NodeIpInfo为null时判断报错
					if (null == nt.getNodeIpInfo()) {
						nt.setNodeIpInfo("");
					}
					if (!nt.getNodeState().equals(nodeTable.getNodeState())
							|| !nt.getNodeIp().equals(nodeTable.getNodeIp())
							|| !nt.getNodeMac().equals(nodeTable.getNodeMac())
							|| !nt.getNodeType()
									.equals(nodeTable.getNodeType())
							|| !nt.getSnmpVersion().equals(
									nodeTable.getSnmpVersion())
							|| !nt.getNodeIpInfo().equals(
									nodeTable.getNodeIpInfo())
							|| !nt.getSystemId()
									.equals(nodeTable.getSystemId())
							|| !nt.getGroupId().equals(nodeTable.getGroupId())) {
						flag = true;
					}
					nt.setNodeIp(nodeTable.getNodeIp().trim());
					nt.setIpn(IpCovert.ipToLong(nodeTable.getNodeIp().trim()));
					nt.setNodeMac(nodeTable.getNodeMac().trim());
					nt.setNodeName(nodeTable.getNodeName().trim());
					nt.setNodeDesc(nodeTable.getNodeDesc().trim());
					nt.setNodeState(nodeTable.getNodeState());
					nt.setNodeType(nodeTable.getNodeType());
					nt.setNodeUType(nodeTable.getNodeUType());
					nt.setNodeBeginUType(nodeTable.getNodeBeginUType());
					nt.setSnmpVersion(nodeTable.getSnmpVersion());
					nt.setNodeIpInfo(nodeTable.getNodeIpInfo());
					nt.setIpn(IpCovert.ipToLong(nodeTable.getNodeIp().trim()));
					nt.setNodeUserName(nodeTable.getNodeUserName());
					nt.setNetworElementType(nodeTable.getNetworElementType());
					if (nodeTable.getNodePassword() != null
							&& !StringUtil.isBlank(nodeTable.getNodePassword()
									.trim())) {
						BASE64Encoder encoder = new BASE64Encoder();
						String nodePassword = encoder.encode(nodeTable
								.getNodePassword().trim().getBytes());
						nt.setNodePassword(nodePassword);
					} else {
						nt.setNodePassword("");
					}
					// 节点组成员相关操作
					NodegroupTable group = (NodegroupTable) this.commonService
							.get(NodegroupTable.class, mkid);
					if (group != null) {
						// 设置节点信息的系统ID
						nt.setSystemId(group.getSystemId());
						nt.setGroupId(group.getGroupId());
					}
					// ----------2012-7-13 修改 节点所在机柜及位置由新增修改节点界面维护
					// 查看该机柜从起始位置到结束位置是否放有节点机（SEQID不为空即为存放了节点）
					List<NodeLatticeTable> nltList = this.commonService
							.find(
									"from NodeLatticeTable where nodeSeqId is not null and nodeSeqId<>?"
											+ " and (nodeposition between ? and ?)"
											+ " and nodeBoxId in(select nodeBoxId from NodeBoxTable where ispn='"
											+ nodeTable.getNodeBoxIspn() + "')",
									seqId, boxSPosition, boxEPosition);
					if (nltList != null && nltList.size() > 0) {
						this
								.outHtmlString("<script>alert('该节点的所选机柜位置已放有节点，请重新输入！');history.back();</script>");
						return;
					} else {
						// 首先清空当前节点已有记录的位置情况
						String hql = "update NodeLatticeTable set nodeSeqId=null where nodeSeqId=?";
						this.commonService.updateByHql(hql, seqId);
						// 再更新位置为当前所选机柜位置
						hql = "update NodeLatticeTable set nodeSeqId="
								+ seqId
								+ " where nodeBoxId in(select nodeBoxId from NodeBoxTable where ispn='"
								+ nodeTable.getNodeBoxIspn()
								+ "') and nodeposition between ? and ?";
						this.commonService.updateByHql(hql, boxSPosition,
								boxEPosition);
					}
					// ----------2012-7-13 修改 end
					this.commonService.update(nt);

					// 2012-7-16 更新所有同一物理机SeqID的U位相同(2012-9-12
					// 同一物理机的起始U位、机柜编号也相同)
					// 2012-12-12 更新所有统一物理机SeqID的snmp.version相同
					// 2013-05-16 IP相同的节点同步更新Mac、节点类型、网元类型 add by jinsj
					/*
					 * this.commonService .updateByHql("update NodeTable set
					 * nodeUType=?,nodeBeginUType=?,nodeBoxIspn=?,snmpVersion=?,nodeMac=?,nodeType=?,networElementType=?
					 * where seqId=?", nodeTable.getNodeUType(),
					 * nodeTable.getNodeBeginUType(),
					 * nodeTable.getNodeBoxIspn(), nodeTable.getSnmpVersion(),
					 * nodeTable.getNodeMac(), nodeTable.getNodeType(),
					 * StringUtil.isBlank(nodeTable.getNetworElementType()) ?"
					 * ":nodeTable.getNetworElementType(), seqId);
					 * commonService.executeSQL("");
					 */

					String networElementType = StringUtil.isEmpty(nodeTable
							.getNetworElementType()) ? "" : nodeTable
							.getNetworElementType()
							+ "";
					String sql = "UPDATE node_table t SET t.node_u_type="
							+ nodeTable.getNodeUType() + ",t.node_begin_utype="
							+ nodeTable.getNodeBeginUType()
							+ ",t.node_box_ispn='" + nodeTable.getNodeBoxIspn()
							+ "',t.snmp_version='" + nodeTable.getSnmpVersion()
							+ "',t.node_mac='" + nodeTable.getNodeMac()
							+ "',t.node_type=" + nodeTable.getNodeType()
							+ ",t.network_element_type='" + networElementType
							+ "' WHERE t.seq_id=" + seqId;
					commonService.updateBySql(sql);

					if (flag) {
						if (new Long(1).equals(group.getIsValid())) { // 节点组有效
							this.sendNodeAndGroupId(nt.getGroupId(), nt
									.getNodeId(), commonService); // 通知NMSServer更新节点组的监控信息
						}
					}
					// 将更新操作写到操作日志中
					this.addDBOperationRpt(commonService, "node_table",
							"UPDATE", nodeTable.getNodeId());
				}
				outHtmlString("<script type=\"text/javascript\">alert('操作成功');this.location='nodeManage.do?action=query&nodeGroupId="
						+ mkid + "&isValid=" + isValid + "&fromWhere=" + fromWhere + "&type=" + type + "&showStopNGroup=" + showStopNGroup +"&nodeIpVo="+nodeIpVo+"&nodeNameVo="+nodeNameVo+ "'</script>");
			} else {
				this
						.outHtmlString("<script>alert('该节点组下已经存在该IP，请重新输入！');history.back();</script>");
				return;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('操作失败');this.location='nodeManage.do?action=query&nodeGroupId="
					+ mkid + "&isValid=" + isValid + "'</script>");
		}

	}

	// 停用节点
	public void stopNodeInfo() {
		try {
			List noList = this.commonService.find(
					"from NodeTable where nodeId=?", nodeId);

			if (noList != null && noList.size() > 0) {
				NodeTable nd = (NodeTable) noList.get(0);
				nd.setNodeState(1l);
				nd.setStopUserId(this.getUserID());
				nd.setNodeStoptime(new Date());

				this.commonService.update(nd);
				NodegroupTable group = (NodegroupTable) this.commonService.get(
						NodegroupTable.class, nd.getGroupId());
				if (new Long(1).equals(group.getIsValid())) { // 节点组有效
					this.sendNodeAndGroupId(nd.getGroupId(), nd.getNodeId(),
							commonService); // 通知NMSServer更新节点组的监控信息
				}
				mkid = group.getGroupId();
				isValid = group.getIsValid().toString();
				// 将更新操作写到操作日志中
				this.addDBOperationRpt(commonService, "node_table", "UPDATE",
						nd.getNodeId());
				this
						.outHtmlString("<script type=\"text/javascript\">alert('操作成功');this.location='nodeManage.do?action=query&nodeGroupId="
								+ mkid + "&isValid=" + isValid + "&showStopNGroup=" + showStopNGroup +"&nodeIpVo="+nodeIpVo+"&nodeNameVo="+nodeNameVo+ "'</script>");
				// this.outHtmlString("<script
				// type=\"text/javascript\">alert('操作成功');this.location='nodeManage.do?action=query&nodeGroupId="+group.getGroupId()+"&isValid="+group.getIsValid()+"'</script>");
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
			this
					.outHtmlString("<script type=\"text/javascript\">alert('操作失败');this.location='nodeManage.do?action=query&nodeGroupId="
							+ mkid + "&isValid=" + isValid + "&showStopNGroup=" + showStopNGroup + "'</script>");
		}
	}

	// 启用节点
	public void startNodeInfo() {
		try {
			this.commonService.updateByHql(
					"update NodeTable set nodeState=0 where nodeId=?", nodeId);
			NodeTable nd = (NodeTable) this.commonService.get(NodeTable.class,
					nodeId);
			NodegroupTable group = (NodegroupTable) this.commonService.get(
					NodegroupTable.class, nd.getGroupId());
			if (new Long(1).equals(group.getIsValid())) { // 节点组有效
				this.sendNodeAndGroupId(nd.getGroupId(), nd.getNodeId(),
						commonService); // 通知NMSServer更新节点组的监控信息
			}

			mkid = group.getGroupId();
			isValid = group.getIsValid().toString();
			// 将更新操作写到操作日志中
			this.addDBOperationRpt(commonService, "node_table", "UPDATE",
					nodeId);
			this
					.outHtmlString("<script type=\"text/javascript\">alert('操作成功');this.location='nodeManage.do?action=query&nodeGroupId="
							+ mkid + "&isValid=" + isValid + "&showStopNGroup=" + showStopNGroup + "&nodeIpVo="+nodeIpVo+"&nodeNameVo="+nodeNameVo+ "'</script>");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString("<script>alert('操作失败');this.location='nodeManage.do?action=query&nodeGroupId="
					+ mkid + "&isValid=" + isValid + "&showStopNGroup=" + showStopNGroup + "'</script>");
		}
	}

	// 查看节点详情
	public String detailNodeInfo() {
		try {
			List list = this.commonService.find(
					"from NodeTable where nodeId=?", nodeId);
			if (list != null && list.size() > 0) {
				nodeTable = (NodeTable) list.get(0);
				List syslist = this.commonService
						.find("from SystemTable where systemId = "
								+ nodeTable.getSystemId());
				if (syslist != null && syslist.size() > 0) {
					nodeTable.setSystemIdName(((SystemTable) syslist.get(0))
							.getSystemName());
				}
				NodegroupTable ngt = (NodegroupTable) this.commonService.get(
						NodegroupTable.class, nodeTable.getGroupId());
				if (ngt != null) {
					nodeTable.setGroupIdName(ngt.getGroupName());
				}
			}
			String systeminfoType = rb.getString("detec.systeminfo.str");
			if (StringUtils.isBlank(systeminfoType)) {
				systeminfoType = "systeminfo";
			}
			BigDecimal newDetecInfoId = null;
			DiSysteminfo dsinfo = null;
			List<DiSysteminfoDisk> dsiDiskList = null;
			List<DiSysteminfoNet> dsiNetList = null;
			List newDetecInfoIdList = this.commonService
					.executeSQL(
							"select din.detection_info_id  from detection_info_new din  left join detection_set_info dsi on dsi.id = din.detection_set_info_id  left join check_type_info cti on cti.id = dsi.check_type_id  where lower(cti.check_type_name)=lower(?) and din.seq_id=?",
							systeminfoType, nodeTable.getSeqId());
			if (newDetecInfoIdList != null && newDetecInfoIdList.size() > 0) {
				newDetecInfoId = (BigDecimal) newDetecInfoIdList.get(0);
				System.out.println("newDetecInfoId " + newDetecInfoId);
				// newDetecInfoId = new BigDecimal(1651029l);
				// dsinfo = commonService.findSysteminfo("1651029");
				// dsiDiskList = commonService.findSysteminfoDisk("1651029");
				// dsiNetList = commonService.findSysteminfoNet("1651029");
				// 1651029
				dsinfo = commonService
						.findSysteminfo(newDetecInfoId.toString());
				dsiDiskList = commonService.findSysteminfoDisk(newDetecInfoId
						.toString());
				dsiNetList = commonService.findSysteminfoNet(newDetecInfoId
						.toString());
				getRequest().setAttribute("dsinfo", dsinfo);
				getRequest().setAttribute("dsiDiskList", dsiDiskList);
				getRequest().setAttribute("dsiNetList", dsiNetList);
			}
			// throw new Exception("ds");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString("<script>alert('操作失败');this.location='nodeManage.do?action=query&nodeGroupId="
					+ nodeGroupId + "&fromWhere=" + fromWhere + "'</script>");
			// outHtmlString("<script>alert('操作失败');this.location='nodeManage.do?action=query&nodeGroupId="+mkid+"&isValid="+isValid+"'</script>");
		}
		return "detailNodeInfo";
	}

	// 模板下载
	public String downloadExample() {
		try {
			Page p = this.commonService
					.findByPage(
							"from NodeTable where groupId=? order by nodeState asc,nodeCreatetime desc",
							1, 3, nodeGroupId);
			List<NodeTable> st = (List<NodeTable>) p.getResult();
			String[] title = { "节点IP(必填)", "节点MAC(必填)", "节点名称(必填)",
					"节点类型（必填，0:服务器,1:网元（网元类型必填））",
					"网元类型（1：专用设备，2：盘阵，3：封堵路由器，4：其他网元）", "用户名", "密码",
					"节点厚度U位(必填)", "机柜编号(必填)", "机柜起始U位(必填)",
					"SNMP版本（必填，version2c=1  version3=3）",
					"节点状态（必填，0:正常,1:已删除或停用）", "节点IP信息", "节点描述" };

			String[] colu = { "nodeIp", "nodeMac", "nodeName", "nodeType",
					"networElementType", "nodeUserName", "nodePassword",
					"nodeUType", "nodeBoxIspn", "nodeBeginUType",
					"snmpVersion", "nodeState", "nodeIpInfo", "nodeDesc" };
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel("节点表", st, title, colu, "downloadExample");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
		return null;
	}

	// 导入
	public String importXls() {
		String errorInfo = "";
		try {
			NodegroupTable group = null;
			if (nodeGroupId != null && !nodeGroupId.equals("")) {
				group = (NodegroupTable) this.commonService.get(
						NodegroupTable.class, nodeGroupId);
			}
			List<NodeTableVo> list = new ArrayList<NodeTableVo>();

			Workbook workbook = null;
			if (myFileFileName.endsWith(".xlsx")) {
				workbook = new XSSFWorkbook(new FileInputStream(myFile));
			} else {
				// 创建对Excel工作簿文件的引用
				/*
				 * POIFSFileSystem fs = new POIFSFileSystem( new
				 * FileInputStream(myFile));
				 */
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
				NodeTableVo nodeVo = new NodeTableVo();
				Row row = sheet.getRow(i);

				Cell cell_nodeIP = row.getCell((short) 0);// 节点IP
				Cell cell_nodeMac = row.getCell((short) 1);// 节点MAC
				Cell cell_nodeName = row.getCell((short) 2);// 节点名称
				Cell cell_nodeType = row.getCell((short) 3);// 节点类型

				// 新增用户名、密码、网元类型
				Cell cell_networElementType = row.getCell((short) 4);// 网元类型
				Cell cell_nodeUserName = row.getCell((short) 5);// 用户名
				Cell cell_nodePassword = row.getCell((short) 6);// 密码

				Cell cell_nodeUType = row.getCell((short) 7);// 节点U位
				Cell cell_nodeBoxIspn = row.getCell((short) 8);// 机柜编号
				Cell cell_nodeBeginUType = row.getCell((short) 9);// 机柜起始U位
				Cell cell_snmpVersion = row.getCell((short) 10);// SNMP版本
				Cell cell_nodeState = row.getCell((short) 11);// 节点状态
				Cell cell_nodeIpInfo = row.getCell((short) 12);// 节点IP信息
				Cell cell_nodeDesc = row.getCell((short) 13);// 节点描述
				if ((null == cell_nodeIP || 3 == cell_nodeIP.getCellType())
						&& (null == cell_nodeMac || 3 == cell_nodeMac
								.getCellType())
						&& (null == cell_nodeName || 3 == cell_nodeName
								.getCellType())
						&& (null == cell_nodeType || 3 == cell_nodeType
								.getCellType())
						&& (null == cell_nodeUType || 3 == cell_nodeUType
								.getCellType())
						&& (null == cell_nodeBoxIspn || 3 == cell_nodeBoxIspn
								.getCellType())
						&& (null == cell_nodeBeginUType || 3 == cell_nodeBeginUType
								.getCellType())
						&& (null == cell_snmpVersion || 3 == cell_snmpVersion
								.getCellType())
						&& (null == cell_nodeState || 3 == cell_nodeState
								.getCellType())
						&& (null == cell_nodeIpInfo || 3 == cell_nodeIpInfo
								.getCellType())
						&& (null == cell_nodeDesc || 3 == cell_nodeDesc
								.getCellType())) {
					sum--;
				} else {
					// 节点IP
					if (null == cell_nodeIP
							|| cell_nodeIP.getCellType() == Cell.CELL_TYPE_BLANK) {
						errorInfo += i + "行1列不能为空;";
					} else if (cell_nodeIP.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_nodeIP.getStringCellValue())) {
							errorInfo += i + "行1列不能为空;";
						} else {
							String nodeIp = cell_nodeIP.getStringCellValue()
									.trim();
							nodeVo.setNodeIp(nodeIp);

							Pattern patt = Pattern
									.compile("\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}");
							Matcher mat = patt.matcher(nodeIp);
							if (!mat.matches()) {
								errorInfo += i + "行1列的ip地址格式错误;";
							}
						}

					}
					// 节点Mac
					if (null == cell_nodeMac
							|| cell_nodeMac.getCellType() == Cell.CELL_TYPE_BLANK) {
						errorInfo += i + "行2列节点Mac不能为空;";
					} else if (cell_nodeMac.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_nodeMac.getStringCellValue())) {
							errorInfo += i + "行2列节点Mac不能为空;";
						} else {
							String nodeMac = cell_nodeMac.getStringCellValue()
									.trim();
							nodeVo.setNodeMac(nodeMac);
						}
					} else if (cell_nodeMac.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						String nodeMac = String.valueOf(cell_nodeMac
								.getNumericCellValue());
						nodeVo.setNodeMac(nodeMac);
					} else {
						errorInfo += i + "行2列节点Mac类型错误;";
					}

					// 节点名称
					if (null == cell_nodeName
							|| cell_nodeName.getCellType() == Cell.CELL_TYPE_BLANK) {
						errorInfo += i + "行3列节点名称不能为空;";
					} else if (cell_nodeName.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						int nodeName = (int) cell_nodeName
								.getNumericCellValue();
						nodeVo.setNodeName(nodeName + "");
					} else if (cell_nodeName.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_nodeName.getStringCellValue())) {
							errorInfo += i + "行3列节点名称不能为空;";
						} else {
							String nodeName = cell_nodeName
									.getStringCellValue().trim();
							nodeVo.setNodeName(nodeName);
						}
					}

					// 节点类型
					if (null == cell_nodeType
							|| cell_nodeType.getCellType() == Cell.CELL_TYPE_BLANK) {
						errorInfo += i + "行4列节点类型不能为空;";
					} else {
						if (cell_nodeType.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							int nodeType = (int) cell_nodeType
									.getNumericCellValue();
							nodeVo.setNodeType(nodeType + "");
							if ((nodeType + "").equals("")) {
								errorInfo += i + "行4列节点类型错误";
							}
						} else if (cell_nodeType.getCellType() == Cell.CELL_TYPE_STRING) {// ^[0-9]*$
							if ("".equals(cell_nodeType.getStringCellValue())) {
								errorInfo += i + "行4列节点类型不能为空;";
							} else {
								String nodeType = cell_nodeType
										.getStringCellValue().trim();
								nodeVo.setNodeType(nodeType + "");

								Pattern patt = Pattern.compile("^[0-9]*$");
								Matcher mat = patt.matcher(nodeType);
								if (!mat.matches()) {
									errorInfo += i + "行4列的节点类型格式错误;";
								}
								if (!nodeType.equals("0")) {// 目前为止只有一种类型
									errorInfo += i + "行4列节点类型错误;";
								}
							}

						}
					}

					// 网元类型

					if (null == cell_networElementType
							|| cell_networElementType.getCellType() == Cell.CELL_TYPE_BLANK) {
						nodeVo.setNetworElementType("");
					} else {
						if (cell_networElementType.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							int networElementType = (int) cell_networElementType
									.getNumericCellValue();
							if (networElementType > 4 || networElementType < 0) {
								errorInfo += i + "行5列的网元类型为1-4间的数字;";
							}
							nodeVo.setNetworElementType(networElementType + "");
						} else if (cell_networElementType.getCellType() == Cell.CELL_TYPE_STRING) {
							if ("".equals(cell_networElementType
									.getStringCellValue())) {
								nodeVo.setNetworElementType("");
							} else {
								String networElementType = cell_networElementType
										.getStringCellValue().trim();
								nodeVo.setNetworElementType(networElementType
										+ "");

								Pattern patt = Pattern.compile("^[0-9]*$");
								Matcher mat = patt.matcher(networElementType);
								if (!mat.matches()) {
									errorInfo += i + "行5列的网元类型格式错误;";
								}
								if (!networElementType.equals("0")) {// 目前为止只有一种类型
									errorInfo += i + "行5列的网元类型为1-4间的数字;";
								}
							}

						}
					}

					// 当节点类型=1 即网元时 网元类型为必填项
					if (nodeVo.getNodeType().equals("1")) {
						if (StringUtil.isBlank(nodeVo.getNetworElementType())) {
							errorInfo += i + "行4列值为1时5列的网元类型为必填项;";
						}
					}

					// 用户名
					if (null == cell_nodeUserName
							|| cell_nodeUserName.getCellType() == Cell.CELL_TYPE_BLANK) {
						nodeVo.setNodeUserName("");
						// errorInfo += i + "行6列节点名称不能为空;";
					} else if (cell_nodeUserName.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						int nodeUserName = (int) cell_nodeUserName
								.getNumericCellValue();
						nodeVo.setNodeUserName(nodeUserName + "");
					} else if (cell_nodeUserName.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_nodeUserName.getStringCellValue())) {
							nodeVo.setNodeUserName("");
							// errorInfo += i + "行6列节点名称不能为空;";
						} else {
							String nodeUserName = cell_nodeUserName
									.getStringCellValue().trim();
							nodeVo.setNodeUserName(nodeUserName);
						}
					}

					// 密码
					if (null == cell_nodePassword
							|| cell_nodePassword.getCellType() == Cell.CELL_TYPE_BLANK) {
						nodeVo.setNodePassword("");
						// errorInfo += i + "行7列节点名称不能为空;";
					} else if (cell_nodePassword.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						int nodePassword = (int) cell_nodePassword
								.getNumericCellValue();
						nodeVo.setNodePassword(nodePassword + "");
					} else if (cell_nodePassword.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_nodePassword.getStringCellValue())) {
							nodeVo.setNodePassword("");
							// errorInfo += i + "行7列节点名称不能为空;";
						} else {
							String nodePassword = cell_nodePassword
									.getStringCellValue().trim();
							nodeVo.setNodePassword(nodePassword);
						}
					}

					// 节点U位
					if (null == cell_nodeUType
							|| cell_nodeUType.getCellType() == Cell.CELL_TYPE_BLANK) {
						errorInfo += i + "行8列节点U位不能为空;";
					} else {
						if (cell_nodeUType.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							int nodeUType = (int) cell_nodeUType
									.getNumericCellValue();
							nodeVo.setNodeUType(Long.parseLong(nodeUType + ""));
							if (nodeUType < 1) {
								errorInfo += i + "行8列节点U位错误";
							}
						} else {
							errorInfo += i + "行8列节点U位类型错误";
						}
					}

					// 机柜编号
					if (null == cell_nodeBoxIspn
							|| cell_nodeBoxIspn.getCellType() == Cell.CELL_TYPE_BLANK) {
						errorInfo += i + "行9列机柜编号不能为空;";
					} else if (cell_nodeBoxIspn.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						int nodeBoxIspn = (int) cell_nodeBoxIspn
								.getNumericCellValue();
						nodeVo.setNodeBoxIspn(nodeBoxIspn + "");
					} else if (cell_nodeBoxIspn.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_nodeBoxIspn.getStringCellValue())) {
							errorInfo += i + "行9列机柜编号不能为空;";
						} else {
							String nodeBoxIspn = cell_nodeBoxIspn
									.getStringCellValue().trim();
							nodeVo.setNodeBoxIspn(nodeBoxIspn);
						}
					}

					// 机柜起始U位
					if (null == cell_nodeBeginUType
							|| cell_nodeBeginUType.getCellType() == Cell.CELL_TYPE_BLANK) {
						errorInfo += i + "行10列机柜起始U位不能为空;";
					} else {
						if (cell_nodeBeginUType.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							int nodeBeginU = (int) cell_nodeBeginUType
									.getNumericCellValue();
							nodeVo.setNodeBeginUType(Long.parseLong(nodeBeginU
									+ ""));
							if (nodeBeginU < 1) {
								errorInfo += i + "行10列机柜起始U位错误";
							}
						} else {
							errorInfo += i + "行10列机柜起始U位类型错误";
						}
					}

					// SNMP版本
					if (null == cell_snmpVersion
							|| cell_snmpVersion.getCellType() == Cell.CELL_TYPE_BLANK) {
						errorInfo += i + "行11列SNMP版本不能为空;";
					} else {
						if (cell_snmpVersion.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							int snmpVersion = (int) cell_snmpVersion
									.getNumericCellValue();
							nodeVo.setSnmpVersion(Long.parseLong(snmpVersion
									+ ""));
							if (snmpVersion != 1 && snmpVersion != 3) {
								errorInfo += i + "行11列SNMP版本错误";
							}
						} else if (cell_snmpVersion.getCellType() == Cell.CELL_TYPE_STRING) {// ^[0-9]*$
							String snmpVersion = cell_snmpVersion
									.getStringCellValue().trim();
							nodeVo.setSnmpVersion(Long.parseLong(snmpVersion
									+ ""));
							if (!snmpVersion.equals("1")
									&& !snmpVersion.equals("3")) {
								errorInfo += i + "行11列SNMP版本错误;";
							}
						}
					}

					// 节点状态
					if (null == cell_nodeState
							|| cell_nodeState.getCellType() == Cell.CELL_TYPE_BLANK) {
						errorInfo += i + "行12列节点状态不能为空;";
					} else {
						if (cell_nodeState.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							int nodeState = (int) cell_nodeState
									.getNumericCellValue();
							nodeVo.setNodeState(nodeState + "");
							if (nodeState != 0 && nodeState != 1) {
								errorInfo += i + "行12列节点状态错误";
							}
						} else if (cell_nodeState.getCellType() == Cell.CELL_TYPE_STRING) {// ^[0-9]*$
							String nodeState = cell_nodeState
									.getStringCellValue().trim();
							nodeVo.setNodeState(nodeState + "");
							if (!nodeState.equals("0")
									&& !nodeState.equals("1")) {
								errorInfo += i + "行12列节点状态错误;";
							}
						}
					}

					// 节点IP信息
					if (null == cell_nodeIpInfo
							|| cell_nodeIpInfo.getCellType() == Cell.CELL_TYPE_BLANK) {
						nodeVo.setNodeIpInfo("");
					} else if (cell_nodeIpInfo.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						int nodeIpInfo = (int) cell_nodeIpInfo
								.getNumericCellValue();
						nodeVo.setNodeIpInfo(nodeIpInfo + "");
					} else if (cell_nodeIpInfo.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_nodeIpInfo.getStringCellValue())) {
							nodeVo.setNodeIpInfo("");
						} else {
							String nodeIpInfo = cell_nodeIpInfo
									.getStringCellValue().trim();
							nodeVo.setNodeIpInfo(nodeIpInfo);
						}
					}

					// 节点描述
					if (null == cell_nodeDesc
							|| cell_nodeDesc.getCellType() == Cell.CELL_TYPE_BLANK) {
						nodeVo.setNodeDesc("");
					} else if (cell_nodeDesc.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						int nodeDesc = (int) cell_nodeDesc
								.getNumericCellValue();
						nodeVo.setNodeDesc(nodeDesc + "");
					} else if (cell_nodeDesc.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_nodeDesc.getStringCellValue())) {
							nodeVo.setNodeDesc("");
						} else {
							String nodeDesc = cell_nodeDesc
									.getStringCellValue().trim();
							nodeVo.setNodeDesc(nodeDesc);
						}
					}

					if ("".equals(errorInfo)) {// 保存节点
						errorInfo = this.saveNode(nodeVo, group);
					}
					if ("".equals(errorInfo)) {
						count++;
					} else {
						nodeVo.setShowError(errorInfo);
						errorInfo = "";
						list.add(nodeVo);

					}
				}
			}

			this.getRequest().setAttribute("errorList", list);
			if (count == sum && sum > 0) {
				// this.getRequest().setAttribute("MSG", 1);
				// return this.queryNodeInfo();
				outHtmlString("<script type=\"text/javascript\">alert('操作成功');this.location='nodeManage!executeAction.do?action=query&nodeGroupId="
						+ nodeGroupId + "&isValid=1&showStopNGroup=" + showStopNGroup +"'</script>");
				return null;
			} else if (sum == 0) {
				outHtmlString("<script>alert('选择的文件为空，请重新选择！');this.location='nodeManage!executeAction.do?action=query&nodeGroupId="
						+ nodeGroupId + "&isValid=1&showStopNGroup=" + showStopNGroup +"'</script>");
				return null;
			}

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}

		return "showError";

	}

	private String saveNode(NodeTableVo vo, NodegroupTable group) {
		String desc = "";
		// "节点IP", "节点MAC","节点名称","节点类型（0 计算机）",
		// "节点U位","机柜编号","机柜起始U位","SNMP版本",
		// "节点状态（0 正常、1 已删除或停用）","节点IP信息","节点描述"
		try {
			if (group != null) {
				// IP在同一节点组下不重复
				if (!groupNodeIpIsRepeat(vo.getNodeIp(), group.getGroupId())) {
					// 保存节点信息
					NodeTable nodeT = new NodeTable();
					nodeT.setNodeIp(vo.getNodeIp());
					nodeT.setNodeMac(vo.getNodeMac());
					nodeT.setNodeName(vo.getNodeName());
					if (!vo.getNodeType().equals("")) {
						nodeT.setNodeType(new Long(vo.getNodeType()));
					}
					if (!vo.getNodeUType().equals("")) {
						nodeT.setNodeUType(new Long(vo.getNodeUType()));// 节点U位
					}
					nodeT.setNodeBoxIspn(vo.getNodeBoxIspn());// 机柜编号
					if (!vo.getNodeBeginUType().equals("")) {
						nodeT
								.setNodeBeginUType(new Long(vo
										.getNodeBeginUType()));// 起始U位
					}
					if (!vo.getSnmpVersion().equals("")) {
						nodeT.setSnmpVersion(new Long(vo.getSnmpVersion()));
					}
					if (!vo.getNodeState().equals("")) {
						nodeT.setNodeState(new Long(vo.getNodeState()));
					}
					nodeT.setNodeIpInfo(vo.getNodeIpInfo());
					nodeT.setNodeDesc(vo.getNodeDesc());
					nodeT.setSystemId(group.getSystemId());
					nodeT.setCreateUserId(this.getUserID());
					nodeT.setIpn(IpCovert.ipToLong(vo.getNodeIp()));
					nodeT.setNodeCreatetime(new Date());
					nodeT.setSeqId(this.getNodeSeqID(nodeT.getNodeIp()));
					nodeT.setNodeSystemType(this.getNodeSystemType(nodeT
							.getSeqId()));
					nodeT.setGroupId(group.getGroupId());
					nodeT.setNodeUserName(vo.getNodeUserName());
					if (!vo.getNetworElementType().equals("")) {
						nodeT.setNetworElementType(new Long(vo
								.getNetworElementType()));
					}
					// 密码字段加密
					if (vo.getNodePassword() != null
							&& !StringUtil.isBlank(vo.getNodePassword().trim())) {
						BASE64Encoder encoder = new BASE64Encoder();
						String nodePassword = encoder.encode(vo
								.getNodePassword().trim().getBytes());
						nodeT.setNodePassword(nodePassword);
					}

					// ----------2012-10-25 处理seqId与机柜位置: 节点所在机柜及位置
					// 查看机柜是否存在
					List<NodeBoxTable> boxList = this.commonService
							.find("from NodeBoxTable where ispn='"
									+ nodeT.getNodeBoxIspn() + "'");
					if (boxList == null || boxList.size() == 0) {
						return "该节点所选机柜不存在";
					}
					NodeBoxTable box = boxList.get(0);
					// 查看结束位置否在机柜U位范围内
					Long boxEPosition = nodeT.getNodeBeginUType()
							+ nodeT.getNodeUType() - 1;
					if (boxEPosition.longValue() > box.getBoxUType()
							.longValue()) {
						return "该节点所选放置位置超出机柜可放置范围";
					}
					// 查看该机柜从起始位置到结束位置是否放有节点机（SEQID不为空即为存放了节点）
					List<NodeLatticeTable> nltList = this.commonService.find(
							"from NodeLatticeTable where nodeSeqId is not null and nodeSeqId<>?"
									+ " and (nodeposition between ? and ?)"
									+ " and nodeBoxId=" + box.getNodeBoxId(),
							nodeT.getSeqId(), nodeT.getNodeBeginUType(),
							boxEPosition);
					if (nltList != null && nltList.size() > 0) {
						desc = "该节点所选机柜位置已放有节点";
					} else {
						// 首先清空当前节点已有记录的位置情况
						String hql = "update NodeLatticeTable set nodeSeqId=null where nodeSeqId=?";
						this.commonService.updateByHql(hql, nodeT.getSeqId());
						// 再更新位置为当前所选机柜位置
						hql = "update NodeLatticeTable set nodeSeqId="
								+ nodeT.getSeqId() + " where nodeBoxId="
								+ box.getNodeBoxId()
								+ " and nodeposition between ? and ?";
						this.commonService.updateByHql(hql, nodeT
								.getNodeBeginUType(), boxEPosition);

						this.commonService.save(nodeT);
						// 将添加操作写到操作日志中
						this.addDBOperationRpt(commonService, "node_table",
								"INSERT", nodeT.getNodeId());

						// 更新所有同一物理机SeqID的U位、起始U位、机柜编号相同
						this.commonService
								.updateByHql(
										"update NodeTable set nodeUType=?,nodeBeginUType=?,nodeBoxIspn=? where seqId=?",
										nodeT.getNodeUType(), nodeT
												.getNodeBeginUType(), nodeT
												.getNodeBoxIspn(), nodeT
												.getSeqId());
					}
					// ----------2012-10-25 end
				} else {
					desc = "该节点组下已经存在该IP";
				}
			} else {
				desc = "该节点的节点组为空，导入失败";
			}

		} catch (Exception e) {
			e.printStackTrace();
			desc = "该节点信息导入异常";
		}
		return desc;
	}

	// 导出当前页
	public String emportCurrentXls() {
		try {
			String hql = "from NodeTable where groupId=? ";
			String nodeIpVo = this.getRequest().getParameter("nodeIpVo");
			String nodeNameVo = this.getRequest().getParameter("nodeNameVo");
			if(nodeIpVo!=null&&""!=nodeIpVo){
				hql += " and nodeIp like '%"+nodeIpVo+"%'";
			}
			if(nodeNameVo!=null&&""!=nodeNameVo){
				hql += " and nodeName like '"+nodeNameVo+"'";
			}
			hql +=" order by nodeState asc,nodeCreatetime desc";
			Page p = this.commonService
					.findByPage(
							hql,
							pageNo, pageSize, nodeGroupId);
			List<NodeTable> st = (List<NodeTable>) p.getResult();
			String[] title = { "节点IP(必填)", "节点MAC(必填)", "节点名称(必填)",
					"节点类型（必填，0:计算机,1:网元）",
					"网元类型（必填，1：专用设备,2:盘阵,3:封堵路由器,4:其他网元）", "用户名", "密码",
					"节点U位(必填)", "机柜编号(必填)", "机柜起始U位(必填)",
					"SNMP版本（必填，version2c=1  version3=3）",
					"节点状态（必填，0:正常,1:已删除或停用）", "节点IP信息", "节点描述" };

			String[] colu = { "nodeIp", "nodeMac", "nodeName", "nodeType",
					"networElementType", "nodeUserName", "nodePassword",
					"nodeUType", "nodeBoxIspn", "nodeBeginUType",
					"snmpVersion", "nodeState", "nodeIpInfo", "nodeDesc" };
			if(!isAdminRole()){//当前用户没有管理员角色 不能查看密码
				for(NodeTable nt :st){
					if(!StringUtils.isEmpty(nt.getNodePassword())){
						nt.setNodePassword("*****");
					}
				}
			}
			String url="nodeManage!executeAction.do?action=query&nodeIpVo="+nodeIpVo+"&nodeNameVo="+nodeNameVo+"&pageSize="+pageSize+"&pageNo="+pageNo+"&nodeGroupId="+nodeGroupId;
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(url,"节点表", st, title, colu);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
		return null;
	}

	// 导出全部
	public String emportAllXls() {
		try {
			String hql = "from NodeTable where groupId=? ";
			String nodeIpVo = this.getRequest().getParameter("nodeIpVo");
			String nodeNameVo = this.getRequest().getParameter("nodeNameVo");
			if(nodeIpVo!=null&&""!=nodeIpVo){
				hql += " and nodeIp like '%"+nodeIpVo+"%'";
			}
			if(nodeNameVo!=null&&""!=nodeNameVo){
				hql += " and nodeName like '"+nodeNameVo+"'";
			}
			hql +=" order by nodeState asc,nodeCreatetime desc";
			List<NodeTable> st = this.commonService
					.find(
							hql,
							nodeGroupId);
			String[] title = { "节点IP(必填)", "节点MAC(必填)", "节点名称(必填)",
					"节点类型（必填，0:计算机,1:网元）",
					"网元类型（必填，1：专用设备,2:盘阵,3:封堵路由器,4:其他网元）", "用户名", "密码",
					"节点U位(必填)", "机柜编号(必填)", "机柜起始U位(必填)",
					"SNMP版本（必填，version2c=1  version3=3）",
					"节点状态（必填，0:正常,1:已删除或停用）", "节点IP信息", "节点描述" };

			String[] colu = { "nodeIp", "nodeMac", "nodeName", "nodeType",
					"networElementType", "nodeUserName", "nodePassword",
					"nodeUType", "nodeBoxIspn", "nodeBeginUType",
					"snmpVersion", "nodeState", "nodeIpInfo", "nodeDesc" };
			if(!isAdminRole()){//当前用户没有管理员角色 不能查看密码
				for(NodeTable nt :st){
					if(!StringUtils.isEmpty(nt.getNodePassword())){
						nt.setNodePassword("*****");
					}
				}
			}
			String url="nodeManage!executeAction.do?action=query&nodeIpVo="+nodeIpVo+"&nodeNameVo="+nodeNameVo+"&pageSize="+pageSize+"&pageNo="+pageNo+"&nodeGroupId="+nodeGroupId;
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(url,"节点表", st, title, colu);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
		return null;
	}

	/**
	 * Ajax请求，获取机柜的空闲位置
	 * 
	 * @return
	 */
	public String getBoxFreePosition() {
		try {
			String uType = this.getRequest().getParameter("nodeUType");
			String nodeBoxIspn = this.getRequest().getParameter("nodeBoxIspn");
			int nodeUType = 1;
			if (uType != null && !"".equals(uType)) {
				nodeUType = Integer.parseInt(uType);
			}
			long seqId = this.getNodeSeqID(nodeIp);
			String hql = "select nodeposition from NodeLatticeTable"
					+ " where nodeBoxId in(select nodeBoxId from NodeBoxTable where ispn='"
					+ nodeBoxIspn + "') and (nodeSeqId is null or nodeSeqId="
					+ seqId + ") order by nodeposition asc";
			List<Long> allList = (List<Long>) this.commonService.find(hql);
			List<Long> list = new ArrayList<Long>();
			// -- 1、如果list的个数比U位还小，那么肯定所有的都不满足
			if (allList.size() >= nodeUType) {
				// --
				// 2、最后nodeUType-1个不够U位长度的位置肯定是不满足，比如：U位是3，list的个数是10,那么10个中最后两个肯定是不满足的
				int j = 0;
				for (int i = 0; i < allList.size() - nodeUType + 1; i++) {
					// -- 3、连续U位长度个空位置(包含当前的位置)，才是满足的
					for (j = 0; j < nodeUType - 1; j++) {
						if (allList.get(i + j) + 1 != allList.get(i + j + 1)) {
							break;
						}
					}
					if (j == nodeUType - 1) {
						list.add(allList.get(i));
					}
				}
			}
			System.out.println("-----all free utype: "
					+ Arrays.toString(allList.toArray()));
			System.out.println("-------- free utype: "
					+ Arrays.toString(list.toArray()));
			this.outJsonArray(list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * Ajax请求，根据节点IP获取其所在机柜
	 * 
	 * @return
	 */
	public String getNodeBox() {
		try {
			String jsonStr = null;
			long seqId = this.getNodeSeqID(nodeIp);
			// 根据SEQID查看机柜位置
			List list = this.commonService
					.find("from NodeLatticeTable where nodeSeqId=" + seqId
							+ " order by nodeposition asc");
			if (list != null && list.size() > 0) {
				NodeLatticeTable snlt = (NodeLatticeTable) list.get(0);
				NodeLatticeTable enlt = (NodeLatticeTable) list
						.get(list.size() - 1);
				// 根据机柜ID查看机柜
				list = this.commonService
						.find("from NodeBoxTable where nodeBoxId="
								+ snlt.getNodeBoxId());
				if (list != null && list.size() > 0) {
					NodeBoxTable nbt = (NodeBoxTable) list.get(0);
					jsonStr = "{\"nodeBoxIspn\":\""
							+ nbt.getIspn()
							+ "\",\"nodeBoxDesc\":\""
							+ nbt.getDescinfo()
							+ "\",\"nodeUType\":\""
							+ (enlt.getNodeposition() - snlt.getNodeposition() + 1)
							+ "\",\"nodeBeginUType\":\""
							+ snlt.getNodeposition() + "\"}";
				}
			}
			if (jsonStr != null) {
				jsonStr = jsonStr.replaceAll("\\r\\n", "");
			}
			this.outJson(jsonStr);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 
	 * TODO 新增or修改节点时，当输入节点IP时，对IP进行校验 1.ip在该节点组中存在，提示不可再新增
	 * 2.ip存在，但不是同一节点组，取出该节点的信息，填充界面所有信息，
	 * 提交保存后同步更新节点IP、Mac、节点类型、位置（机柜编号、U位、起始U位）、seqId，同时释放源节点的U位 3.节点不存在，新增逻辑
	 * 
	 * @author jinshujuan May 16, 2013
	 * @version 1.0
	 * @return
	 */
	public String checkNodeIp() {
		try {
			if (!StringUtil.isEmpty(nodeGroupId)) {
				// 同一节点组是否存在相同复IP
				boolean isExist = groupNodeIpIsRepeat(nodeIp, nodeGroupId);
				if (isExist) {
					String json = "{'isExist':" + isExist + "}";
					outJson(json);
				} else {
					// 其他节点组是否存在相同IP
					String hql = " from NodeTable where nodeIp ='" + nodeIp
							+ "' and groupId !=" + nodeGroupId;
					nodeList = commonService.find(hql);
					if (nodeList != null && nodeList.size() > 0) {
						if (nodeList.size() == 1) {
							nodeTable = nodeList.get(0);
							outJson(nodeTable);
						} else {
							for (int i = 0; i < nodeList.size(); i++) {
								if (!nodeList.get(i).getNodeName().startsWith(
										"新节点")) {
									nodeTable = nodeList.get(i);
									outJson(nodeTable);
									return null;
								}
							}
						}
					}
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public NodeManageAction20170315Bak() {
		// TODO Auto-generated constructor stub
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

	public List<NodeTable> getNodeList() {
		return nodeList;
	}

	public void setNodeList(List<NodeTable> nodeList) {
		this.nodeList = nodeList;
	}

	public NodeTable getNodeTable() {
		return nodeTable;
	}

	public void setNodeTable(NodeTable nodeTable) {
		this.nodeTable = nodeTable;
	}

	public Long getNodeId() {
		return nodeId;
	}

	public void setNodeId(Long nodeId) {
		this.nodeId = nodeId;
	}

	public String getNodeNameVo() {
		return nodeNameVo;
	}

	public void setNodeNameVo(String nodeNameVo) {
		this.nodeNameVo = nodeNameVo;
	}

	public String getNodeDescVo() {
		return nodeDescVo;
	}

	public void setNodeDescVo(String nodeDescVo) {
		this.nodeDescVo = nodeDescVo;
	}

	public Long getMkid() {
		return mkid;
	}

	public void setMkid(Long mkid) {
		this.mkid = mkid;
	}

	public List<Resource> getTreeList() {
		return treeList;
	}

	public void setTreeList(List<Resource> treeList) {
		this.treeList = treeList;
	}

	public Long getNodeGroupId() {
		return nodeGroupId;
	}

	public void setNodeGroupId(Long nodeGroupId) {
		this.nodeGroupId = nodeGroupId;
	}

	public File getMyFile() {
		return myFile;
	}

	public void setMyFile(File myFile) {
		this.myFile = myFile;
	}

	public String getOldNodeIp() {
		return oldNodeIp;
	}

	public void setOldNodeIp(String oldNodeIp) {
		this.oldNodeIp = oldNodeIp;
	}

	public String getIsNone() {
		return isNone;
	}

	public void setIsNone(String isNone) {
		this.isNone = isNone;
	}

	public String getMyFileFileName() {
		return myFileFileName;
	}

	public void setMyFileFileName(String myFileFileName) {
		this.myFileFileName = myFileFileName;
	}

	public String getIsValid() {
		return isValid;
	}

	public void setIsValid(String isValid) {
		this.isValid = isValid;
	}

	public String getNodeIp() {
		return nodeIp;
	}

	public void setNodeIp(String nodeIp) {
		this.nodeIp = nodeIp;
	}

	public String getNodeIpVo() {
		return nodeIpVo;
	}

	public void setNodeIpVo(String nodeIpVo) {
		this.nodeIpVo = nodeIpVo;
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public String getShowStopNGroup() {
		return showStopNGroup;
	}
	public void setShowStopNGroup(String showStopNGroup) {
		this.showStopNGroup = showStopNGroup;
	}

	public List<OptionTable> getOptionList() {
		return optionList;
	}

	public void setOptionList(List<OptionTable> optionList) {
		this.optionList = optionList;
	}
}
