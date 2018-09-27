package nis.nms.web.actions.nodePosition;

import java.io.File;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import nis.nms.core.Constants;
import nis.nms.domains.NodeGroupPosition;
import nis.nms.domains.NodegroupArrowPosition;
import nis.nms.domains.NodegroupBgimgPosition;
import nis.nms.domains.NodegroupPositionAll;
import nis.nms.domains.NodegroupTable;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Common;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;
import com.nis.util.StringUtil;

@Results( { @Result(name = "showTopo", value = "/page/show/nodeGroup/showTopo.jsp"),
		@Result(name = "configTopo", value = "/page/show/nodeGroup/configTopo.jsp"),
		@Result(name = "error", value = "/error.jsp") })
/**
 * 拓扑图展示 jinsj 2013-06-03
 */
public class NodeGroupPositionAction extends BaseAction
{
	
	private Logger logger = Logger.getLogger(NodeGroupPositionAction.class);
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	private String action;
	private String from;
	
	private List<NodegroupTable> nodeGroupList = new ArrayList<NodegroupTable>();// 节点组列表
	private List<NodeGroupPosition> nodeGroupPositionList = new ArrayList<NodeGroupPosition>();
	private List<NodegroupArrowPosition> nodegroupArrowPositionList = new ArrayList<NodegroupArrowPosition>();
	private List<NodegroupBgimgPosition> nodegroupBgimgPositionList = new ArrayList<NodegroupBgimgPosition>();
	private String svgImagePath;
	private String svgFileName = "showTopo.svg";
	private NodeGroupPosition backgroudImg;
	private String fielSeparator = System.getProperty("file.separator");
	private String filePath;
	private String requestType;
	private String nodeGroupId;
	private String nodegroupBgImgPositions;// 拓扑图配置页面的背景图片信息
	private String nodegroupArrowPositions;// 拓扑图配置页面的箭头连线信息
	
	public String executeAction()
	{
		String resultpage = "error";
		if ("showTopo".equals(this.action))
		{
			resultpage = showNodeGroupTopo();
		} else if ("getNodeList".equals(this.action))
		{
			resultpage = getNodeList();
		} else if ("configTopo".equals(this.action))
		{
			resultpage = configTopo();
		} else if ("saveConfigTopo".equals(this.action))
		{
			resultpage = saveConfigTopo();
		}
		
		return resultpage;
	}
	
	/**
	 * 保存拓扑图配置信息 TODO
	 * 
	 * @author jinshujuan Oct 24, 2013
	 * @version 1.0
	 * @return
	 */
	private String saveConfigTopo()
	{
		try
		{
			System.out.println("nodegroupBgImgPositions:"+nodegroupBgImgPositions);
			System.out.println("nodegroupArrowPositions:"+nodegroupArrowPositions);
			String[] nodegroupBgImgPositionInfos = nodegroupBgImgPositions.split(":");
			for (String nodegroupBgImgPositionInfo: nodegroupBgImgPositionInfos)
			{
				String[] bgImgInfos = nodegroupBgImgPositionInfo.split(",");
				// 1.设置NodegroupBgimgPosition背景图片信息
				NodegroupBgimgPosition nodegroupBgimgPosition = new NodegroupBgimgPosition();
				nodegroupBgimgPosition.setGroupId(Long.parseLong(bgImgInfos[0]));
				nodegroupBgimgPosition.setFigureFill(bgImgInfos[1] + ".png");
				nodegroupBgimgPosition.setFigureX(Long.parseLong(bgImgInfos[2]));
				nodegroupBgimgPosition.setFigureY(Long.parseLong(bgImgInfos[3]));
				nodegroupBgimgPosition.setFigureWidth(Long.parseLong(bgImgInfos[4]));
				nodegroupBgimgPosition.setFigureHeight(Long.parseLong(bgImgInfos[5]));
				
				nodegroupBgimgPosition.setSystemId(getSystemID());
				nodegroupBgimgPosition.setCreateTime(new Date());
				nodegroupBgimgPosition.setCreateUserid(getUserID());
				nodegroupBgimgPositionList.add(nodegroupBgimgPosition);
				
				// 2.设置NodeGroupPosition灯泡信息
				NodeGroupPosition nodeGroupPosition = new NodeGroupPosition();
				NodegroupTable nodeGroup = (NodegroupTable) commonService.get(NodegroupTable.class,
						Long.parseLong(bgImgInfos[0]));
				nodeGroupPosition.setNodeGroup(nodeGroup);
				nodeGroupPosition.setFigureFill("green_bulb.png");
				//根据不同的底图画灯泡的配置偏移量不同
				if (bgImgInfos[1].equals("server"))
				{
					nodeGroupPosition.setFigureX(Long.parseLong(bgImgInfos[2])+22);
					nodeGroupPosition.setFigureY(Long.parseLong(bgImgInfos[3])+26);
				} else if (bgImgInfos[1].equals("core_switch"))
				{
					nodeGroupPosition.setFigureX(Long.parseLong(bgImgInfos[2])+32);
					nodeGroupPosition.setFigureY(Long.parseLong(bgImgInfos[3])+18);
				} else if (bgImgInfos[1].equals("switch"))
				{
					nodeGroupPosition.setFigureX(Long.parseLong(bgImgInfos[2])+20);
					nodeGroupPosition.setFigureY(Long.parseLong(bgImgInfos[3])+15);
				} else if (bgImgInfos[1].equals("device"))
				{
					nodeGroupPosition.setFigureX(Long.parseLong(bgImgInfos[2])+8);
					nodeGroupPosition.setFigureY(Long.parseLong(bgImgInfos[3])-4);
				} else if (bgImgInfos[1].equals("router"))
				{
					nodeGroupPosition.setFigureX(Long.parseLong(bgImgInfos[2])+3);
					nodeGroupPosition.setFigureY(Long.parseLong(bgImgInfos[3]));
				}
				nodeGroupPosition.setFigureWidth(25l);
				nodeGroupPosition.setFigureHeight(25l);
				
				nodeGroupPosition.setSystemId(getSystemID());
				nodeGroupPosition.setPgroupId(0l);
				nodeGroupPosition.setShowLevel(2l);
				nodeGroupPosition.setFigureType("image");
				nodeGroupPosition.setShowStatus(0l);
				nodeGroupPosition.setAddTime(new Date());
				nodeGroupPosition.setAddUserid(getUserID());
				nodeGroupPositionList.add(nodeGroupPosition);
				
			}
			
			// 3.设置NodegroupArrowPosition箭头信息
			String[] nodegroupArrowPositionInfos = nodegroupArrowPositions.split(":");
			for (String nodegroupArrowPositionInfo: nodegroupArrowPositionInfos)
			{
				String[] arrowLineInfos = nodegroupArrowPositionInfo.split(";");
				for (String arrowLineInfo: arrowLineInfos)
				{
					String[] lineInfos = arrowLineInfo.split(",");
					NodegroupArrowPosition nodegroupArrowPosition = new NodegroupArrowPosition();
					NodegroupTable srcNodeGroup = (NodegroupTable) commonService
							.get(NodegroupTable.class, Long.parseLong(lineInfos[0]));
					NodegroupTable descNodeGroup = (NodegroupTable) commonService
							.get(NodegroupTable.class, Long.parseLong(lineInfos[1]));
					nodegroupArrowPosition.setSrcNodeGroup(srcNodeGroup);
					nodegroupArrowPosition.setDescNodeGroup(descNodeGroup);
					nodegroupArrowPosition.setFigureX(Long.parseLong(lineInfos[2]));
					nodegroupArrowPosition.setFigureY(Long.parseLong(lineInfos[3]));
					nodegroupArrowPosition.setFigureWidth(Long.parseLong(lineInfos[4]));
					nodegroupArrowPosition.setFigureHeight(Long.parseLong(lineInfos[5]));
					System.out.println(lineInfos[6]);
					String fillImg = lineInfos[6] == "" ? "" : lineInfos[6].split("/")[2]
							.substring(0, lineInfos[6].split("/")[2].length() - 1);
					nodegroupArrowPosition.setFigureFill(fillImg);
					
					nodegroupArrowPosition.setSystemId(getSystemID());
					nodegroupArrowPosition.setCreateTime(new Date());
					nodegroupArrowPosition.setCreateUserid(getUserID());
					commonService.save(nodegroupArrowPosition);
					nodegroupArrowPositionList.add(nodegroupArrowPosition);
				}
				
			}
			
			// 批量新增拓扑图相关配置信息
			commonService.saveOrUpdate(nodegroupBgimgPositionList);
			commonService.saveOrUpdate(nodeGroupPositionList);
			commonService.saveOrUpdate(nodegroupArrowPositionList);
		} catch (Exception e)
		{
			logger.error("Failed to save topology map configuration information", e);
		}
		return configTopo();
	}
	
	/**
	 * 
	 * TODO 业务逻辑拓扑展示
	 * 
	 * @author jinshujuan Jun 3, 2013
	 * @version 1.0
	 * @return
	 */
	private String showNodeGroupTopo()
	{
		/**
		 * 涉及的3个表说明
		 * 
		 * NODEGROUP_POSITION 对应的实体类 NodeGroupPosition showLevel=1是底图 showLevel=2是灯泡位置信息
		 * NODEGROUP_BGIMG_POSITION 对应的实体类  NodegroupBgimgPosition 节点组对应的图标位置信息
		 * NODEGROUP_ARROW_POSITION 对应的实体类  NodegroupArrowPosition 带箭头的线信息
		 */
		try
		{
			//------------1. 获取底图------------
			String hql = " from NodeGroupPosition where showLevel =1 and systemId="
					+ this.getSystemID();
			nodeGroupPositionList = commonService.find(hql);
			if (nodeGroupPositionList.size() > 0)
			{
				backgroudImg = nodeGroupPositionList.get(0);
			}
			
			//------------2. 获取节点组------------
			hql = " from NodegroupTable where 1=1 ";
			boolean ADMFlag = this.getAdminMark();
			this.getRequest().setAttribute("ADMFlag", ADMFlag);
			if (!ADMFlag)
			{
				// 如果当前登录选择了业务系统，则只做和本业务系统相关的操作
				if (this.getSystemID() != null)
				{
					hql += " and systemId = " + this.getSystemID();
				}
				// 1 发布人查看,2 发布人所在组查看,3 系统内全部人员可看
				hql += " and (";
				hql += " (viewLevel=1 and createUserId=" + this.getUserID() + ")";
				hql += " or (viewLevel=2 and createUsergroupId in (select jsbh from XtYhJsIndex "
						+ " where type=1 and yhbh='" + this.getUser().getYhbh() + "') )";
				if (this.getSystemID() != null)
				{
					hql += " or (viewLevel=3 and systemId=" + this.getSystemID() + ")";
				} else
				{
					hql += " or (viewLevel=3 and systemId in"
							+ " (select systemId from GorupSystemTable where userGroupId in"
							+ " (select jsbh from XtYhJsIndex where type=1 and yhbh='"
							+ this.getUser().getYhbh() + "')" + " ) )";
				}
				hql += ")";
			}
			//查询该用户在业务系统下拥有权限的节点组
			nodeGroupList = this.commonService.find(hql);
			
			// 每次查询前先将箭头表的数据都修改为绿色正常图
			String sql = "UPDATE nodegroup_arrow_position t SET t.figure_fill = replace(t.figure_fill,'red','green') WHERE t.system_id="
					+ this.getSystemID();
			commonService.updateBySql(sql);
			
			//------------3.遍历节点组 设置节点组是否处于异常状态，用红灯、红线标识节点组异常，绿灯、绿线标识节点组正常------------
			for (NodegroupTable nodegroup: nodeGroupList)
			{
				//@2018-3-9 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
				String groupIdSql = "select group_id from nodegroup_table t where 1=1 ";
				String ids = this.commonService.getGroupIdStartWith(groupIdSql, "t.group_id = " +nodegroup.getGroupId());
				// 查询节点组状态 1:如果有紧急告警则为异常状态 2：如果检测设置，但是没有检测数据则为异常状态
				/*String countsql = "select COUNT( distinct nt.node_id) from detection_info_new diw "
						+ "left join node_table nt on diw.seq_id = nt.seq_id where diw.DETECTIONED_STATE<>1  AND diw.valid=1 AND diw.police_emergent=0  "
						+ "and diw.DETECTION_SET_INFO_ID in (select dst.ID from DETECTION_SET_INFO dst where dst.DETECTION_SET_STATE=1) "
						+ "and nt.NODE_STATE = 0 and nt.node_group_id in (select t.group_id from nodegroup_table t start with t.group_id ="
						+ nodegroup.getGroupId()
						+ " connect by prior t.group_id = t.parent_group_id)";*/
				String countsql = "select COUNT( distinct nt.node_id) from detection_info_new diw "
						+ "left join node_table nt on diw.seq_id = nt.seq_id where diw.DETECTIONED_STATE<>1  AND diw.valid=1 AND diw.police_emergent=0  "
						+ "and diw.DETECTION_SET_INFO_ID in (select dst.ID from DETECTION_SET_INFO dst where dst.DETECTION_SET_STATE=1) "
						+ "and nt.NODE_STATE = 0 and nt.node_group_id in ("+ ids +")";
				List countList = commonService.executeSQL(countsql);
				// 显示状态 0：正常 1：异常
				long showStatus = 0l;
				if (countList != null && countList.size() > 0)
				{
					Integer count = Integer.valueOf(countList.get(0).toString());
					//BigDecimal count = (BigDecimal) countList.get(0);
					if (count > 0)
					{
						showStatus = 1l;
					}
				}
				
				String positionHql = " from NodeGroupPosition where systemId=" + this.getSystemID()
						+ " and nodeGroup.groupId = " + nodegroup.getGroupId();
				
				List<NodeGroupPosition> list = commonService.find(positionHql);
				NodeGroupPosition nodeGroupPosition = new NodeGroupPosition();
				if (list != null && list.size() > 0)
				{
					nodeGroupPosition = list.get(0);
					// 更新节点组灯
					updateObj(nodeGroupPosition, showStatus);
					//@2018-3-9 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
//					String gsql = "select group_id from nodegroup_table t where 1=1 ";
//					String gids = this.commonService.getGroupIdStartWith(gsql, "t.group_id = " +nodegroup.getGroupId());
					// 更新箭头
					/*sql = "SELECT din.detectioned_state from detection_info_new din WHERE din.detection_set_info_id IN ( "
							+ "SELECT dsi.id from detection_set_info dsi WHERE dsi.detection_set_state=1 AND dsi.check_type_id IN ("
							+ "SELECT cti.id from check_type_info cti WHERE cti.check_type_name='NMSClient') "
							+ ") AND din.valid=1 AND din.seq_id IN (SELECT t.seq_id from node_table t WHERE t.node_group_id in "
							+ "(select nt.group_id from nodegroup_table nt start with nt.group_id ="
							+ nodegroup.getGroupId()
							+ " connect by prior nt.group_id = nt.parent_group_id)"
							+ " AND t.node_state=0) ORDER by din.data_arrive_time DESC";*/
					sql = "SELECT din.detectioned_state from detection_info_new din WHERE din.detection_set_info_id IN ( "
							+ "SELECT dsi.id from detection_set_info dsi WHERE dsi.detection_set_state=1 AND dsi.check_type_id IN ("
							+ "SELECT cti.id from check_type_info cti WHERE cti.check_type_name='NMSClient') "
							+ ") AND din.valid=1 AND din.seq_id IN (SELECT t.seq_id from node_table t WHERE t.node_group_id in "
							+ "("+ids+")"
							+ " AND t.node_state=0) ORDER by din.data_arrive_time DESC";
					
					List detectionStatusList = commonService.executeSQL(sql);
					if (detectionStatusList.size() > 0)
					{
						String status = detectionStatusList.get(0).toString();
						// 状态1正常，其他都为异常
						if (!status.equals("1"))
						{
							System.out.println("流量异常的节点：" + nodegroup.getGroupId() + "  "
									+ nodegroup.getGroupName());
							sql = "UPDATE nodegroup_arrow_position t SET t.figure_fill = replace(t.figure_fill,'green','red') WHERE t.system_id="
									+ this.getSystemID()
									+ " and t.src_group_id="
									+ nodegroup.getGroupId()
									+ " OR t.desc_group_id="
									+ nodegroup.getGroupId();
							commonService.updateBySql(sql);
						}
					}
				}
				
			}
			
			//------------4. 查询3表信息供jsp页面展示用------------
			
			//------------4.1 查询节点组对应的图标位置信息  并且设置鼠标悬浮在节点组图标上显示该节点组对应的节点信息------------
			hql = " from NodegroupBgimgPosition t WHERE t.systemId=" + getSystemID();
			nodegroupBgimgPositionList = commonService.find(hql);
			
			for (NodegroupBgimgPosition nodegroupBgimgPosition: nodegroupBgimgPositionList)
			{
				String nodeInfo = "";
				if (nodegroupBgimgPosition.getGroupId() != null)
				{
					long groupId = nodegroupBgimgPosition.getGroupId();
					sql = "SELECT distinct t.node_ip,t.node_group_id ,nb.box_id,nr.room_ispn,nrl.lattice_row_position,nrl.lattice_col_position,nb.ispn from node_table t "
							+ "LEFT JOIN node_box_table nb ON t.node_box_ispn = nb.ispn "
							+ "LEFT JOIN node_room_lattice_table nrl ON nrl.node_box_id = nb.box_id"
							+ " LEFT JOIN node_room_table nr ON nr.room_id = nrl.room_id  WHERE t.system_id="
							+ getSystemID()
							+ " AND t.node_state=0 AND t.node_group_id in  "
							+ "(select t1.group_id from nodegroup_table t1 where t1.group_id ="
							+ groupId + ")";
					List<Object> nodeList = commonService.executeSQL(sql);
					
					for (Object object: nodeList)
					{
						Object[] obj = (Object[]) object;
						String nodeBoxInfo = "";
						if (obj[3] != null)
						{
							nodeBoxInfo += getI18nText("i18n_NodeGroupPositionAction.saveConfigTopo.room_n81i")+":" + obj[3].toString() + " ";
						}
						if (obj[4] != null && obj[5] != null)
						{
							nodeBoxInfo += obj[4].toString() + getI18nText("i18n_NodeGroupPositionAction.saveConfigTopo.row_n81i") + obj[5].toString() + getI18nText("i18n_NodeGroupPositionAction.saveConfigTopo.column_n81i");
						}
						if (obj[6] != null)
						{
							nodeBoxInfo += getI18nText("i18n_NodeGroupPositionAction.saveConfigTopo.box_n81i")+":" + obj[6].toString();
						}
						nodeInfo += "<div style='width: 90px;height: 22px;cursor: pointer;' onclick='getNodeBox(&quot;"
								+ obj[1]
								+ "&quot;,&quot;"
								+ obj[2]
								+ "&quot;,&quot;"
								+ nodeBoxInfo
								+ "&quot;,&quot;" + obj[0] + "&quot;)' >" + obj[0] + "</div>";
					}
				}
				if (nodeInfo == "")
				{
					nodeInfo = getI18nText("i18n_NodeGroupPositionAction.saveConfigTopo.groupNoNode_n81i");
				}
				nodegroupBgimgPosition.setNodeInfo(nodeInfo);
			}
			//------------4.2 查询灯泡图标位置信息------------
			sql = "SELECT t.id,t.group_id,t.figure_x,t.figure_y,t.figure_width,t.figure_height,t.figure_fill,t.show_status "
					+ "from nodegroup_position t WHERE t.show_level=2 AND  t.system_id= "
					+ this.getSystemID();
			nodeGroupPositionList = commonService.executeSQL(sql);
			//------------4.3 查询箭头图标位置信息------------
			sql = "SELECT t.id,t.src_group_id,t.desc_group_id,t.figure_x,t.figure_y,t.figure_width,t.figure_height,t.figure_fill "
					+ "from nodegroup_arrow_position t WHERE t.system_id=" + this.getSystemID();
			nodegroupArrowPositionList = commonService.executeSQL(sql);
			
			// 5分钟刷新一次 ajax请求给返回数据
			if (!StringUtil.isBlank(requestType) && requestType.equals("ajax"))
			{
				List<NodegroupPositionAll> nodegroupPositionAllList = new ArrayList<NodegroupPositionAll>();
				NodegroupPositionAll nodegroupPositionAll = new NodegroupPositionAll();
				nodegroupPositionAll.setNodeGroupPositionList(nodeGroupPositionList);
				nodegroupPositionAll.setNodegroupArrowPositionList(nodegroupArrowPositionList);
				nodegroupPositionAllList.add(nodegroupPositionAll);
				outJsonArray(nodegroupPositionAllList);
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return "showTopo";
	}
	
	/**
	 * 
	 * TODO 更新系统节点组位置信息表记录的状态，显示图 同步更新灯泡
	 * 
	 * @author jinshujuan Jun 4, 2013
	 * @version 1.0
	 * @param nodeGroupPosition
	 * @param showStatus
	 */
	private void updateObj(NodeGroupPosition nodeGroupPosition, long showStatus)
	{
		try
		{
			String figureFill = "green_bulb.png";
			if (showStatus == 1)
			{
				figureFill = "alarm.gif";
			}
			nodeGroupPosition.setFigureFill(figureFill);
			nodeGroupPosition.setShowStatus(showStatus);
			nodeGroupPosition.setLastUpdateTime(new Date());
			nodeGroupPosition.setLastUpdateUserid(getUserID());
			commonService.update(nodeGroupPosition);
			
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 
	 * TODO 获取节点组下的所有节点
	 * 
	 * @author jinshujuan Jul 2, 2013
	 * @version 1.0
	 * @return
	 */
	private String getNodeList()
	{
		try
		{
			System.out.println(nodeGroupId);
			if (!StringUtil.isBlank(nodeGroupId))
			{
				String sql = "SELECT distinct t.node_ip from node_table t WHERE t.system_id="
						+ getSystemID() + " AND t.node_state=0 AND t.node_group_id=" + nodeGroupId;
				List nodeIpList = commonService.executeSQL(sql);
				outJsonArray(nodeIpList);
			}
			
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 该方法废弃 根据系统节点组位置信息表创建拓扑图对应的SVG文件
	 * 
	 * @author jinshujuan Jun 3, 2013
	 * @version 1.0
	 * @param nodeGroupPositionList
	 */
	private void createSvgFile(List<NodeGroupPosition> nodeGroupPositionList)
	{
		try
		{
			
			StringBuffer mainInfo = new StringBuffer("");
			svgImagePath = Common.buildPath(getRequest().getContextPath()) + fielSeparator
					+ Constants.TOPO_SVG_IMAGES_PATH;
			for (NodeGroupPosition nodeGroupPosition: nodeGroupPositionList)
			{
				String xmlInfo = getElementInfo(nodeGroupPosition);
				if (!StringUtil.isBlank(xmlInfo))
				{
					mainInfo.append(xmlInfo);
				}
			}
			StringBuffer xml = new StringBuffer("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
			xml.append("\n");
			xml
					.append("<svg version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" "
							+ " xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"100%\" height=\"100%\" >");
			// 底图
			xml.append(" \n <image x=\"" + backgroudImg.getFigureX() + "\" y=\""
					+ backgroudImg.getFigureY() + "\" width=\"" + backgroudImg.getFigureWidth()
					+ "\" height=\"" + backgroudImg.getFigureHeight()
					+ "\" stroke=\"1\" stroke-width=\"1\"  xlink:href=\"" + svgImagePath
					+ backgroudImg.getFigureFill() + "\" /> \n ");
			
			// 获取position方法
			// xml.append(drawImg());
			xml.append(mainInfo.toString());
			xml.append("\n");
			xml.append("</svg>");
			File file = new File(filePath);
			if (file.exists())
			{
				file.delete();
			}
			FileUtils.writeStringToFile(file, xml.toString(), "UTF-8");
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 测试阶段用 定位每个节点组 告警位置 用于开发测试阶段 TODO
	 * 
	 * @author jinshujuan Jun 7, 2013
	 * @version 1.0
	 * @return
	 */
	private String drawImg()
	{
		StringBuffer xml = new StringBuffer();
		// 电信分流交换机
		xml
				.append(" \n <image  x=\"375\"  y=\"50\"  width=\"25\"  height=\"25\"  stroke=\"1\"  stroke-width=\"1\"  xlink:href=\""
						+ svgImagePath + "red_bulb.png\"  />  \n ");
		// 电信一级
		xml
				.append(" \n <image  x=\"452\"  y=\"50\"  width=\"25\"  height=\"25\"  stroke=\"1\"  stroke-width=\"1\"  xlink:href=\""
						+ svgImagePath + "red_bulb.png\"  />  \n ");
		// 电信汇接交换机
		xml
				.append(" \n <image  x=\"523\"  y=\"48\"  width=\"25\"  height=\"25\"  stroke=\"1\"  stroke-width=\"1\"  xlink:href=\""
						+ svgImagePath + "red_bulb.png\"  />  \n ");
		// 电信二级
		xml
				.append(" \n <image  x=\"602\"  y=\"51\"  width=\"25\"  height=\"25\"  stroke=\"1\"  stroke-width=\"1\"  xlink:href=\""
						+ svgImagePath + "green_bulb.png\"  />  \n ");
		// 管控平台后端服务器
		xml
				.append(" \n <image  x=\"858\"  y=\"58\"  width=\"25\"  height=\"25\"  stroke=\"1\"  stroke-width=\"1\"  xlink:href=\""
						+ svgImagePath + "red_bulb.png\"  />  \n ");
		
		// ---------------------------------------------
		
		// 移动铁通共用专业分流交换机
		xml
				.append(" \n <image  x=\"378\"  y=\"240\"  width=\"25\"  height=\"25\"  stroke=\"1\"  stroke-width=\"1\"  xlink:href=\""
						+ svgImagePath + "green_bulb.png\"  />  \n ");
		
		// 移动一级
		xml
				.append(" \n <image  x=\"450\"  y=\"181\"  width=\"25\"  height=\"25\"  stroke=\"1\"  stroke-width=\"1\"  xlink:href=\""
						+ svgImagePath + "green_bulb.png\"  />  \n ");
		// 移动汇接交换机
		xml
				.append(" \n <image  x=\"528\"  y=\"178\"  width=\"23\"  height=\"25\"  stroke=\"1\"  stroke-width=\"1\"  xlink:href=\""
						+ svgImagePath + "green_bulb.png\"  />  \n ");
		
		// 移动二级
		xml
				.append(" \n <image  x=\"606\"  y=\"180\"  width=\"25\"  height=\"25\"  stroke=\"1\"  stroke-width=\"1\"  xlink:href=\""
						+ svgImagePath + "green_bulb.png\"  />  \n ");
		// 管控平台日志库
		xml
				.append(" \n <image  x=\"858\"  y=\"178\"  width=\"25\"  height=\"25\"  stroke=\"1\"  stroke-width=\"1\"  xlink:href=\""
						+ svgImagePath + "green_bulb.png\"  />  \n ");
		
		// 铁通一级
		xml
				.append(" \n <image  x=\"450\"  y=\"312\"  width=\"25\"  height=\"25\"  stroke=\"1\"  stroke-width=\"1\"  xlink:href=\""
						+ svgImagePath + "green_bulb.png\"  />  \n ");
		// 铁通汇接交换机
		xml
				.append(" \n <image  x=\"528\"  y=\"308\"  width=\"25\"  height=\"25\"  stroke=\"1\"  stroke-width=\"1\"  xlink:href=\""
						+ svgImagePath + "green_bulb.png\"  />  \n ");
		// 铁通二级
		xml
				.append(" \n <image  x=\"605\"  y=\"312\"  width=\"25\"  height=\"25\"  stroke=\"1\"  stroke-width=\"1\"  xlink:href=\""
						+ svgImagePath + "green_bulb.png\"  />  \n ");
		// 管控平台核心交换机
		xml
				.append(" \n <image  x=\"732\"  y=\"310\"  width=\"25\"  height=\"25\"  stroke=\"1\"  stroke-width=\"1\"  xlink:href=\""
						+ svgImagePath + "green_bulb.png\"  />  \n ");
		
		// 管控平台邮件加载
		xml
				.append(" \n <image  x=\"858\"  y=\"312\"  width=\"25\"  height=\"25\"  stroke=\"1\"  stroke-width=\"1\"  xlink:href=\""
						+ svgImagePath + "green_bulb.png\"  />  \n ");
		
		// --------------------
		// 联通教育共用专业分流交换机
		xml
				.append(" \n <image  x=\"378\"  y=\"490\"  width=\"25\"  height=\"25\"  stroke=\"1\"  stroke-width=\"1\"  xlink:href=\""
						+ svgImagePath + "green_bulb.png\"  />  \n ");
		
		// 联通教育一级
		xml
				.append(" \n <image  x=\"450\"  y=\"434\"  width=\"25\"  height=\"25\"  stroke=\"1\"  stroke-width=\"1\"  xlink:href=\""
						+ svgImagePath + "green_bulb.png\" /> \n ");
		// 联通教育汇接交换机
		xml
				.append(" \n <image  x=\"530\"  y=\"430\"  width=\"25\"  height=\"25\"  stroke=\"1\"  stroke-width=\"1\"  xlink:href=\""
						+ svgImagePath + "green_bulb.png\"  />  \n ");
		// 联通教育二级 \
		xml
				.append("\n <image x=\"605\" y=\"432\" width=\"25\" height=\"25\" stroke=\"1\" stroke-width=\"1\" xlink:href=\""
						+ svgImagePath + "green_bulb.png\" /> \n ");
		// 087 系统
		xml
				.append(" \n <image  x=\"859\" y=\"429\" width=\"25\" height=\"25\" stroke=\"1\"  stroke-width=\"1\" xlink:href=\""
						+ svgImagePath + "green_bulb.png\" /> \n ");
		
		// 教育一级
		xml
				.append(" \n <image x=\"450\" y=\"558\" width=\"25\" height=\"25\" stroke=\"1\" stroke-width=\"1\" xlink:href=\""
						+ svgImagePath + "green_bulb.png\" /> \n ");
		
		// 分中心
		xml
				.append(" \n <image x=\"859\" y=\"550\" width=\"25\" height=\"25\" stroke=\"1\" stroke-width=\"1\" xlink:href=\""
						+ svgImagePath + "green_bulb.png\" /> \n ");
		
		// 界面服务器
		xml
				.append(" \n <image x=\"944\" y=\"504\" width=\"25\" height=\"25\" stroke=\"1\" stroke-width=\"1\" xlink:href=\""
						+ svgImagePath + "green_bulb.png\" /> \n ");
		
		// 科技一级
		xml
				.append(" \n <image x=\"450\" y=\"665\" width=\"25\" height=\"25\" stroke=\"1\" stroke-width=\"1\" xlink:href=\""
						+ svgImagePath + "green_bulb.png\" /> \n ");
		
		// 科技汇接交换机
		xml
				.append(" \n <image  x=\"532\"  y=\"658\"  width=\"25\"  height=\"25\"  stroke=\"1\"  stroke-width=\"1\"  xlink:href=\""
						+ svgImagePath + "green_bulb.png\"  />  \n ");
		
		// 黑盒服务器
		xml
				.append(" \n <image x=\"859\" y=\"676\" width=\"25\" height=\"25\" stroke=\"1\" stroke-width=\"1\" xlink:href=\""
						+ svgImagePath + "green_bulb.png\" /> \n ");
		
		// 省平台服务器
		xml
				.append(" \n <image x=\"946\" y=\"626\" width=\"25\" height=\"25\" stroke=\"1\" stroke-width=\"1\" xlink:href=\""
						+ svgImagePath + "green_bulb.png\" /> \n ");
		
		return xml.toString();
	}
	
	/**
	 * 该方法废弃 TODO 将每个节点组位置信息转换为svg格式的文本块
	 * 
	 * @author jinshujuan Jun 3, 2013
	 * @version 1.0
	 * @param nodeGroupPosition
	 * @return
	 */
	private String getElementInfo(NodeGroupPosition nodeGroupPosition)
	{
		String elementInfo = "";
		try
		{
			if (!StringUtil.isEmpty(nodeGroupPosition))
			{
				String figureType = nodeGroupPosition.getFigureType();
				if ("image".equals(figureType))
				{
					elementInfo = " \n <image  x=\"" + nodeGroupPosition.getFigureX() + "\"  y=\""
							+ nodeGroupPosition.getFigureY() + "\"  width=\""
							+ nodeGroupPosition.getFigureWidth() + "\"  height=\""
							+ nodeGroupPosition.getFigureHeight() + "\"  stroke=\""
							+ nodeGroupPosition.getFigureStroke() + "\"  stroke-width=\""
							+ nodeGroupPosition.getFigureStrokeWidth() + "\"  xlink:href=\""
							+ svgImagePath + nodeGroupPosition.getFigureFill() + "\"  />  \n ";
				}
			}
			
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return elementInfo;
	}
	
	/**
	 * 
	 * 获取异常信息节点
	 * 
	 * @author jinshujuan Jun 9, 2013
	 * @version 1.0
	 */
	public void getAlarmNode()
	{
		try
		{
			if (!StringUtil.isBlank(nodeGroupId))
			{
				//@2018-3-9 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
				String gsql = "select group_id from nodegroup_table t where t.system_id= "+getSystemID();
				String gids = this.commonService.getGroupIdStartWith(gsql, "t.group_id = " +nodeGroupId);
				/*String sql = "SELECT distinct nt.node_id,nt.node_ip,nt.node_name,nt.node_type,nt.seq_id from detection_info_new diw "
						+ "left join node_table nt on diw.seq_id = nt.seq_id where diw.DETECTIONED_STATE<>1 AND diw.police_emergent=0  "
						+ "and diw.DETECTION_SET_INFO_ID in (select dst.ID from DETECTION_SET_INFO dst where dst.DETECTION_SET_STATE=1) "
						+ "and nt.NODE_STATE = 0 and nt.node_group_id in (select t.group_id from nodegroup_table t WHERE t.system_id="
						+ getSystemID()
						+ " start with t.group_id ="
						+ nodeGroupId
						+ " connect by prior t.group_id = t.parent_group_id)";*/
				String sql = "SELECT distinct nt.node_id,nt.node_ip,nt.node_name,nt.node_type,nt.seq_id from detection_info_new diw "
						+ "left join node_table nt on diw.seq_id = nt.seq_id where diw.DETECTIONED_STATE<>1 AND diw.police_emergent=0  "
						+ "and diw.DETECTION_SET_INFO_ID in (select dst.ID from DETECTION_SET_INFO dst where dst.DETECTION_SET_STATE=1) "
						+ "and nt.NODE_STATE = 0 and nt.node_group_id in ("+gids+")";
				List<Object> nodeList = commonService.executeSQL(sql);
				if (nodeList != null && nodeList.size() > 0)
				{
					outJsonArray(nodeList);
				}
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	/**
	 * 拓扑图配置界面 TODO
	 * 
	 * @author jinshujuan Jul 15, 2013
	 * @version 1.0
	 * @return
	 */
	private String configTopo()
	{
		try
		{
			// 获取底图
			String hql = " from NodeGroupPosition where showLevel =1 and systemId="
					+ this.getSystemID();
			nodeGroupPositionList = commonService.find(hql);
			if (nodeGroupPositionList.size() > 0)
			{
				backgroudImg = nodeGroupPositionList.get(0);
			}
			
			hql = " from NodegroupBgimgPosition t WHERE t.systemId=" + getSystemID()
					+ " and to_char(createTime,'yyyy-MM-dd') >= to_char(Sysdate,'yyyy-MM-dd') ";
			nodegroupBgimgPositionList = commonService.find(hql);
			String sql = "SELECT t.id,t.group_id,t.figure_x,t.figure_y,t.figure_width,t.figure_height,t.figure_fill,t.show_status "
					+ "from nodegroup_position t WHERE t.show_level=2 AND  t.system_id= "
					+ this.getSystemID()
					+ " and to_char(t.add_time,'yyyy-MM-dd') >= to_char(Sysdate,'yyyy-MM-dd')";
			nodeGroupPositionList = commonService.executeSQL(sql);
			sql = "SELECT t.id,t.src_group_id,t.desc_group_id,t.figure_x,t.figure_y,t.figure_width,t.figure_height,t.figure_fill "
					+ "from nodegroup_arrow_position t WHERE t.system_id="
					+ this.getSystemID()
					+ " and to_char(t.create_time,'yyyy-MM-dd') >= to_char(Sysdate,'yyyy-MM-dd')";
			nodegroupArrowPositionList = commonService.executeSQL(sql);
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return "configTopo";
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
	
	public String getFrom()
	{
		return from;
	}
	
	public void setFrom(String from)
	{
		this.from = from;
	}
	
	public List<NodegroupTable> getNodeGroupList()
	{
		return nodeGroupList;
	}
	
	public void setNodeGroupList(List<NodegroupTable> nodeGroupList)
	{
		this.nodeGroupList = nodeGroupList;
	}
	
	public String getSvgImagePath()
	{
		return svgImagePath;
	}
	
	public void setSvgImagePath(String svgImagePath)
	{
		this.svgImagePath = svgImagePath;
	}
	
	public NodeGroupPosition getBackgroudImg()
	{
		return backgroudImg;
	}
	
	public void setBackgroudImg(NodeGroupPosition backgroudImg)
	{
		this.backgroudImg = backgroudImg;
	}
	
	public List<NodeGroupPosition> getNodeGroupPositionList()
	{
		return nodeGroupPositionList;
	}
	
	public void setNodeGroupPositionList(List<NodeGroupPosition> nodeGroupPositionList)
	{
		this.nodeGroupPositionList = nodeGroupPositionList;
	}
	
	public String getRequestType()
	{
		return requestType;
	}
	
	public void setRequestType(String requestType)
	{
		this.requestType = requestType;
	}
	
	public String getNodeGroupId()
	{
		return nodeGroupId;
	}
	
	public void setNodeGroupId(String nodeGroupId)
	{
		this.nodeGroupId = nodeGroupId;
	}
	
	public List<NodegroupArrowPosition> getNodegroupArrowPositionList()
	{
		return nodegroupArrowPositionList;
	}
	
	public void setNodegroupArrowPositionList(
			List<NodegroupArrowPosition> nodegroupArrowPositionList)
	{
		this.nodegroupArrowPositionList = nodegroupArrowPositionList;
	}
	
	public List<NodegroupBgimgPosition> getNodegroupBgimgPositionList()
	{
		return nodegroupBgimgPositionList;
	}
	
	public void setNodegroupBgimgPositionList(
			List<NodegroupBgimgPosition> nodegroupBgimgPositionList)
	{
		this.nodegroupBgimgPositionList = nodegroupBgimgPositionList;
	}
	
	public String getNodegroupBgImgPositions()
	{
		return nodegroupBgImgPositions;
	}
	
	public void setNodegroupBgImgPositions(String nodegroupBgImgPositions)
	{
		this.nodegroupBgImgPositions = nodegroupBgImgPositions;
	}
	
	public String getNodegroupArrowPositions()
	{
		return nodegroupArrowPositions;
	}
	
	public void setNodegroupArrowPositions(String nodegroupArrowPositions)
	{
		this.nodegroupArrowPositions = nodegroupArrowPositions;
	}
}
