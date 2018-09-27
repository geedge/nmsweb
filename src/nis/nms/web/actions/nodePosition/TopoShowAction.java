/**
 * DesktopAction.java 版权所有(C) 2010 北京中科智源育成信息技术有限公司
 * 
 * @author ZhengXi
 * @date 2010-11-19
 * @version V1.0
 */
package nis.nms.web.actions.nodePosition;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import net.sf.json.JSONObject;
import nis.nms.domains.NodeBoxTable;
import nis.nms.domains.NodeLatticeTable;
import nis.nms.domains.NodeRoomLatticeTable;
import nis.nms.domains.NodeRoomTable;
import nis.nms.domains.NodeTable;
import nis.nms.domains.NodegroupTable;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import org.apache.log4j.Logger;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;
import com.nis.util.StringUtil;

@Results( { @Result(name = "showTopo", value = "/page/show/flexTopo.jsp"),
		@Result(name = "showNode", value = "/page/show/showNode.jsp"),
		@Result(name = "show3DRoom", value = "/page/show/show3DRoom.jsp"),
		@Result(name = "showNodeRoom", value = "/page/show/showNodeRoom.jsp"),

		@Result(name = "error", value = "/error.jsp") })
/**
 * 拓扑图左面展示
 */
public class TopoShowAction extends BaseAction
{
	
	private Logger logger = Logger.getLogger(TopoShowAction.class);
	private static final long serialVersionUID = 1L;
	private String action;
	private CommonService commonService;
	private List<NodegroupTable> nodegroupList;
	private List<NodeRoomTable> nodeRoomList;
	private String firstGroupId;
	private String groupId;
	private String nodeBoxId;
	private String nodeBoxIspn;
	
	public String executeAction()
	{
		String resultpage = "showTopo";
		TopoShow.sysID = this.getSystemID();
		TopoShow.user = this.getUser();
		if ("showTopo".equals(this.action))
		{
			resultpage = "showTopo";
		} else if ("showNode".equals(this.action))
		{
			resultpage = showNode();
		} else if ("show3DRoom".equals(this.action))
		{
			resultpage = show3DRoom();
		} else if ("getNodeRoom".equals(this.action))
		{
			resultpage = getNodeRoom();
		} else if ("getNodeBox".equals(this.action))
		{
			resultpage = getNodeBox();
		}
		
		//
		return resultpage;
	}
	
	/**
	 * 3D机房展示 查询节点组
	 * 
	 * @author jinshujuan Jun 24, 2013
	 * @version 1.0
	 * @return
	 */
	private String show3DRoom()
	{
		try
		{
			String sql = null;
			String hql = null;
			if (!this.getAdminMark()) {
				sql = " SELECT NGT.GROUP_ID,NGT.GROUP_NAME,NGT.GROUP_LEVEL,NGT.GROUP_DESC,ngt.leaf_group "
						+ "FROM NODEGROUP_TABLE NGT WHERE NGT.IS_VALID = 1 AND NGT.SYSTEM_ID = "
						+ getSystemID();
				hql = " from NodegroupTable where isValid =1 and systemId = " + getSystemID();
				
				sql += " AND (( NGT.VIEW_LEVEL=1 AND NGT.CREATE_USER_ID=" + getUser().getYhid()
						+ ") OR ( NGT.VIEW_LEVEL=2 AND NGT.CREATE_USERGROUP_ID "
						+ " IN (SELECT X.JSBH FROM Xt_Yh_Js_Index  X  WHERE X.YHBH='"
						+ getUser().getYhbh()
						+ "' AND X.TYPE = 1)) OR (NGT.VIEW_LEVEL=3 AND NGT.SYSTEM_ID = "
						+ getSystemID() + ") OR (NGT.VIEW_LEVEL=4 ))";
				hql += " and (( viewLevel =1 and createUserId = "
						+ getUser().getYhid()
						+ ") "
						+ "or (viewLevel =2 and createUserId in (select t1.jsbh from XtYhJsIndex t1 where t1.yhbh ='"
						+ getUser().getYhbh() + "' and type =1)) "
						+ "or (viewLevel =3 and systemId=" + getSystemID() + ") or (viewLevel =4))";
			}else{
				// 管理员查询sql leaf_group=1父节点 leaf_group=0子节点
				sql = " SELECT NGT.GROUP_ID,NGT.GROUP_NAME,NGT.GROUP_LEVEL,NGT.GROUP_DESC,ngt.leaf_group "
						+ "FROM NODEGROUP_TABLE NGT WHERE NGT.IS_VALID = 1 ";
				//查询该业务系统有效的节点组
				hql = " from NodegroupTable where isValid =1 ";
			}
			sql += " order by NGT.show_index";
			hql += " order by showIndex";
			nodegroupList = commonService.find(hql);
			for (NodegroupTable nodegroupTable: nodegroupList)
			{
				//@2018-3-9 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
				String gsql = "select group_id from nodegroup_table t where 1=1 ";
				String gids = this.commonService.getGroupIdStartWith(gsql, "t.group_id = " +nodegroupTable.getGroupId());
				//获取每个节点组下正常、异常节点的个数
				/*sql = "SELECT * from ("
						+ "select count(distinct nt.node_id) from detection_info_new diw left join node_table nt on diw.seq_id = nt.seq_id "
						+ "where diw.DETECTIONED_STATE<>1 AND diw.police_emergent=0 and diw.DETECTION_SET_INFO_ID in "
						+ "(select dst.ID from DETECTION_SET_INFO dst where dst.DETECTION_SET_STATE=1) and nt.NODE_STATE = 0 "
						+ "and nt.node_group_id in (select t.group_id from nodegroup_table t start with t.group_id ="
						+ nodegroupTable.getGroupId()
						+ " connect by prior t.group_id = t.parent_group_id)" + ") alramNode,"
						+ "(SELECT count(DISTINCT t.node_ip) from node_table t WHERE t.system_id="
						+ getSystemID() + " AND t.node_group_id= " + nodegroupTable.getGroupId()
						+ ")allNode";*/
				if(this.getAdminMark()){
					sql = "SELECT * from ("
							+ "select count(distinct nt.node_id) from detection_info_new diw left join node_table nt on diw.seq_id = nt.seq_id "
							+ "where diw.DETECTIONED_STATE<>1 AND diw.police_emergent=0 and diw.DETECTION_SET_INFO_ID in "
							+ "(select dst.ID from DETECTION_SET_INFO dst where dst.DETECTION_SET_STATE=1) and nt.NODE_STATE = 0 "
							+ "and nt.node_group_id in ("+gids+")" 
							+ ") alramNode,"
							+ "(SELECT count(DISTINCT t.node_ip) from node_table t WHERE "
							+ " t.node_group_id= " + nodegroupTable.getGroupId()
							+ ") allNode";
				}else{
					sql = "SELECT * from ("
							+ "select count(distinct nt.node_id) from detection_info_new diw left join node_table nt on diw.seq_id = nt.seq_id "
							+ "where diw.DETECTIONED_STATE<>1 AND diw.police_emergent=0 and diw.DETECTION_SET_INFO_ID in "
							+ "(select dst.ID from DETECTION_SET_INFO dst where dst.DETECTION_SET_STATE=1) and nt.NODE_STATE = 0 "
							+ "and nt.node_group_id in ("+gids+")" 
							+ ") alramNode,"
							+ "(SELECT count(DISTINCT t.node_ip) from node_table t WHERE t.system_id="
							+ getSystemID() + " AND t.node_group_id= " + nodegroupTable.getGroupId()
							+ ")allNode";
				}
				
				List countList = commonService.executeSQL(sql);
				Object[] countObjs = (Object[]) countList.get(0);
				BigDecimal bigDecimal = new BigDecimal(1);
				int alramNodeSize = Integer.valueOf(countObjs[0].toString());//((BigDecimal) countObjs[0]).intValue();
				int allNodeSize = Integer.valueOf(countObjs[0].toString());//((BigDecimal) countObjs[1]).intValue();
				if (alramNodeSize > 0)
				{
					nodegroupTable.setStatus(1);
				} else
				{
					nodegroupTable.setStatus(0);
				}
				//设置节点组的告警信息，当鼠标放在节点组上显示提示信息
				String alramInfo = "\"" + nodegroupTable.getGroupName() + "\""+getI18nText("i18n_TopoShowAction.show3DRoom.alramInfo1_n81i");
				if (allNodeSize > 0)
				{
					alramInfo += "|"+getI18nText("i18n_TopoShowAction.show3DRoom.nodeNum_n81i")+"：" + allNodeSize + "|"+getI18nText("i18n_TopoShowAction.show3DRoom.normalNode_n81i")+"："
							+ (allNodeSize - alramNodeSize) + "|"+getI18nText("i18n_TopoShowAction.show3DRoom.abnormalNode_n81i")+"：" + alramNodeSize;
				} else
				{
					alramInfo += "|"+getI18nText("i18n_TopoShowAction.show3DRoom.alramInfo3_n81i");
				}
				nodegroupTable.setAlramInfo(alramInfo);
				
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return "show3DRoom";
	}
	
	/**
	 * 获取节点组下的机房 TODO
	 * 
	 * @author jinshujuan Jun 25, 2013
	 * @version 1.0
	 * @return
	 */
	public String getNodeRoom()
	{
		try
		{
			if (!StringUtil.isBlank(groupId))
			{
				// 设置节点组的机房
				String hql = null;
				if(this.getAdminMark()){
					hql = " from NodeRoomTable nr where nr.roomId in (select DISTINCT nrl.roomId from NodeRoomLatticeTable nrl where nrl.nodeBoxId in "
							+ "(select DISTINCT nl.nodeBoxId  from NodeLatticeTable nl where nl.nodeSeqId in "
							+ "(select DISTINCT nt.seqId from NodeTable nt where nt.nodeState=0  and nt.groupId=" + groupId + ")))";
				}else{
					hql = " from NodeRoomTable nr where nr.roomId in (select DISTINCT nrl.roomId from NodeRoomLatticeTable nrl where nrl.nodeBoxId in "
							+ "(select DISTINCT nl.nodeBoxId  from NodeLatticeTable nl where nl.nodeSeqId in "
							+ "(select DISTINCT nt.seqId from NodeTable nt where nt.nodeState=0 and systemId="
							+ getSystemID() + " and nt.groupId=" + groupId + ")))";
				}
				nodeRoomList = commonService.find(hql);
				
				NodegroupTable nodegroupTable = (NodegroupTable) commonService
						.get(NodegroupTable.class, Long.parseLong(groupId));
				getRequest().setAttribute("nodegroupTable", nodegroupTable);
				
				hql = " from NodeRoomLatticeTable where nodeBoxId is not NULL order by latticeRowPosition,latticeColPosition";
				List<NodeRoomLatticeTable> nodeRoomLatticList = commonService.find(hql);
				
				// 设置机房展示
				for (NodeRoomTable nodeRoomTable: nodeRoomList)
				{
					// 机房设置节点组
					//nodeRoomTable.setNodegroupTable(nodegroupTable);
					
					/*hql = " from NodeRoomLatticeTable where roomId = "
							+ nodeRoomTable.getRoomId()
							+ " and nodeBoxId is not NULL order by latticeRowPosition,latticeColPosition";
					List<NodeRoomLatticeTable> nodeRoomLatticList = commonService.find(hql);*/
					Map<String, NodeBoxTable> nodeBoxMap = new HashMap<String, NodeBoxTable>();
					for (NodeRoomLatticeTable nodeRoomLatticeTable: nodeRoomLatticList)
					{
						if (nodeRoomTable.getRoomId().intValue() == nodeRoomLatticeTable.getRoomId().intValue())
						{
							Long row = nodeRoomLatticeTable.getLatticeRowPosition();
							Long col = nodeRoomLatticeTable.getLatticeColPosition();
							Long nodeBoxId = nodeRoomLatticeTable.getNodeBoxId();
							// 获取机柜
							NodeBoxTable nodeBoxTable = (NodeBoxTable) commonService
									.get(NodeBoxTable.class, nodeBoxId);
							if (nodeBoxTable != null)
							{
								nodeBoxTable.setAlarm(boxIsAlarm(nodeBoxId, groupId));
								nodeBoxTable.setHasNode(BoxhasNode(nodeBoxId, groupId));
								nodeBoxTable.setDescinfo(nodeBoxTable.getDescinfo().replaceAll("\\r\\n", ""));
								String key = row.toString() + col.toString();
								nodeBoxMap.put(key, nodeBoxTable);
							}
						}
					}
					// 机房设置机柜放在位置的Map
					String nodeBoxInfo = JSONObject.fromObject(nodeBoxMap).toString();
					nodeRoomTable.setNodeBoxInfo(nodeBoxInfo);
				}
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return "showNodeRoom";
	}
	
	/**
	 * 
	 * 检查机柜下是否所有节点都正常,有一个不正常则改机柜则为异常
	 * 
	 * @author jinshujuan Jun 28, 2013
	 * @version 1.0
	 * @param boxId
	 * @param groupId
	 * @return
	 */
	private boolean boxIsAlarm(Long boxId, String groupId)
	{
		boolean isOk = false;
		String nibSql = null;
		if(this.getAdminMark()){
			nibSql = " select count(distinct diw.seq_id)"
					+ " from detection_info_new diw"
					+ " left join node_table nt on nt.seq_id = diw.seq_id "
					+ " where diw.DETECTIONED_STATE<>1 AND diw.police_emergent=0 "
					+ " and diw.DETECTION_SET_INFO_ID in (select dst.ID from DETECTION_SET_INFO dst where dst.DETECTION_SET_STATE=1)"
					+ " and nt.node_state = 0"
					+ " and nt.node_group_id ="
					+ groupId
					+ " and nt.seq_id in (select distinct nlt.node_seq from node_lattice_table nlt where nlt.node_seq is not null and nlt.node_box_id = "
					+ boxId + ")";
		}else{
			nibSql = " select count(distinct diw.seq_id)"
					+ " from detection_info_new diw"
					+ " left join node_table nt on nt.seq_id = diw.seq_id "
					+ " where diw.DETECTIONED_STATE<>1 AND diw.police_emergent=0 "
					+ " and diw.DETECTION_SET_INFO_ID in (select dst.ID from DETECTION_SET_INFO dst where dst.DETECTION_SET_STATE=1)"
					+ " and nt.node_state = 0"
					+ " and nt.system_id="
					+ getSystemID()
					+ " and nt.node_group_id ="
					+ groupId
					+ " and nt.seq_id in (select distinct nlt.node_seq from node_lattice_table nlt where nlt.node_seq is not null and nlt.node_box_id = "
					+ boxId + ")";
		}
		
		try
		{
			List<Object> falseList = this.commonService.executeSQL(nibSql);
			if (Long.parseLong(falseList.get(0).toString()) > 0)
			{
				isOk = true;
			}
			
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return isOk;
	}
	
	/**
	 * 
	 * TODO 该机柜中是否存在本节点组下的节点
	 * 
	 * @author jinshujuan Jul 4, 2013
	 * @version 1.0
	 * @param nodeBoxId2
	 * @param groupId2
	 * @return
	 */
	private boolean BoxhasNode(Long nodeBoxId, String groupId)
	{
		try
		{
			String sql = null;
			if(this.getAdminMark()){
				sql = "SELECT distinct nl.node_seq  from node_lattice_table nl WHERE nl.node_box_id="
						+ nodeBoxId
						+ " AND nl.node_seq IN (SELECT DISTINCT nt.seq_id from node_table nt WHERE nt.node_state=0  "
						+ " AND nt.node_group_id=" + groupId + ")";
			}else{
				sql = "SELECT distinct nl.node_seq  from node_lattice_table nl WHERE nl.node_box_id="
						+ nodeBoxId
						+ " AND nl.node_seq IN (SELECT DISTINCT nt.seq_id from node_table nt WHERE nt.node_state=0 AND nt.system_id="
						+ getSystemID() + " AND nt.node_group_id=" + groupId + ")";
			}
			List list = commonService.executeSQL(sql);
			if (list.size() > 0)
			{
				return true;
			}
		} catch (Exception e)
		{
			// TODO: handle exception
		}
		return false;
	}
	
	/**
	 * 
	 * TODO 获取机柜的位置信息以及每个位置上的节点机
	 * 
	 * @author jinshujuan Jun 27, 2013
	 * @version 1.0
	 * @return
	 */
	private String getNodeBox()
	{
		try
		{
			if (!StringUtil.isBlank(nodeBoxId))
			{
				// 初始化机柜位置
				String hql = " from NodeLatticeTable where nodeBoxId = " + nodeBoxId
						+ " order by nodeposition desc";
				List<NodeLatticeTable> nodeLatticeList = commonService.find(hql);
				// 每个位置上如果放置了节点机 这设置节点机
				for (NodeLatticeTable nodeLatticeTable: nodeLatticeList)
				{
					Long seqId = nodeLatticeTable.getNodeSeqId();
					if (seqId != null)
					{
						if(this.getAdminMark()){
							hql = " from NodeTable where nodeState = 0 "
							+ " and seqId =" + seqId;
						}else{
							hql = " from NodeTable where nodeState = 0 and systemId = " + getSystemID()
							+ " and seqId =" + seqId;
						}
						List<NodeTable> nodeList = commonService.find(hql);
						
						if (nodeList.size() > 0)
						{
							NodeTable nodeTable = nodeList.get(0);
							for (NodeTable node: nodeList)
							{
								if (node.getGroupId().toString().equals(groupId))
								{
									nodeTable = node;
									break;
								}
							}
							// 该节点是否在当前节点组中
							if (nodeTable.getGroupId().toString().equals(groupId))
							{
								nodeLatticeTable.setGroupNode(true);
							} else
							{
								nodeLatticeTable.setGroupNode(false);
							}
							// 该节点是否正常  DETECTIONED_STATE被监控状态是否正常   1正常   police_emergent 告警是否紧急  0紧急  监测是否有效 1有效
							String sql = null;
							if(this.getAdminMark()){
								sql = "select count(diw.seq_Id) from detection_info_new diw where diw.DETECTIONED_STATE<>1 AND diw.police_emergent=0  and diw.seq_id = "
										+ seqId;
							}else{
								sql = "select count(diw.seq_Id) from detection_info_new diw where diw.DETECTIONED_STATE<>1 AND diw.police_emergent=0  and diw.seq_id = "
										+ seqId
										+ " and diw.DETECTION_SET_INFO_ID in (select dst.ID from DETECTION_SET_INFO dst where dst.DETECTION_SET_STATE=1 "
										+ " and ("
										+ "dst.VIEW_LEVEL=4 "//无限制
										+ "or (dst.VIEW_LEVEL=1 and dst.CREATE_USER_ID = "+this.getUserID()+")"//创建人可查看
										+ "or (dst.VIEW_LEVEL=2 and dst.GROUP_ID in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='"+this.getUser().getYhbh()+"' ))"//创建人所在组可查看
										+ "or (dst.VIEW_LEVEL=3 and dst.SYSTEM_ID="+this.getSystemID()+")"//系统内人员可查看
										+ "))";
							}
									
							List<Object> falseList = this.commonService.executeSQL(sql);
							if (Long.parseLong(falseList.get(0).toString()) > 0)
							{
								nodeTable.setAlarm(true);
							} else
							{
								nodeTable.setAlarm(false);
							}
							
							nodeLatticeTable.setNodeTable(nodeTable);
							if(nodeLatticeTable.getNodepositionTemp()==null)
								nodeLatticeTable.setNodepositionTemp(1l);
							else
								nodeLatticeTable.setNodepositionTemp(nodeLatticeTable.getNodepositionTemp()+1l);
						}
					}
				}
				outJsonArray(nodeLatticeList);
			}
			
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	
	private String showNode()
	{
		return "showNode";
	}
	
	public String getAction()
	{
		return action;
	}
	
	public void setAction(String action)
	{
		this.action = action;
	}
	
	public CommonService getCommonService()
	{
		return commonService;
	}
	
	public void setCommonService(CommonService commonService)
	{
		this.commonService = commonService;
	}
	
	public List<NodegroupTable> getNodegroupList()
	{
		return nodegroupList;
	}
	
	public void setNodegroupList(List<NodegroupTable> nodegroupList)
	{
		this.nodegroupList = nodegroupList;
	}
	
	public String getGroupId()
	{
		return groupId;
	}
	
	public void setGroupId(String groupId)
	{
		this.groupId = groupId;
	}
	
	public List<NodeRoomTable> getNodeRoomList()
	{
		return nodeRoomList;
	}
	
	public void setNodeRoomList(List<NodeRoomTable> nodeRoomList)
	{
		this.nodeRoomList = nodeRoomList;
	}
	
	public String getNodeBoxId()
	{
		return nodeBoxId;
	}
	
	public void setNodeBoxId(String nodeBoxId)
	{
		this.nodeBoxId = nodeBoxId;
	}
	
	public String getFirstGroupId()
	{
		return firstGroupId;
	}
	
	public void setFirstGroupId(String firstGroupId)
	{
		this.firstGroupId = firstGroupId;
	}
	
	public String getNodeBoxIspn()
	{
		return nodeBoxIspn;
	}
	
	public void setNodeBoxIspn(String nodeBoxIspn)
	{
		this.nodeBoxIspn = nodeBoxIspn;
	}
	
}
