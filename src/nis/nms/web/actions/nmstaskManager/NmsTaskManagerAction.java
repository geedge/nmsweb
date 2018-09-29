package nis.nms.web.actions.nmstaskManager;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;

import com.ncs.topology.Node;
import com.ncs.topology.NodeTree;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import nis.nms.bean.Backup;
import nis.nms.bean.CoverUpdate;
import nis.nms.bean.ParamForM1;
import nis.nms.bean.ParamForM4;
import nis.nms.bean.ParamForM6;
import nis.nms.domains.GorupSystemTable;
import nis.nms.domains.LoopmissionStateTable;
import nis.nms.domains.MissionFileInformation;
import nis.nms.domains.MissionParameterDefaults;
import nis.nms.domains.MissionParameterTable1;
import nis.nms.domains.MissionParameterTable4;
import nis.nms.domains.MissionParameterTable6;
import nis.nms.domains.MissionStateTable;
import nis.nms.domains.NodeTable;
import nis.nms.domains.NodegroupTable;
import nis.nms.domains.OrderTable;
import nis.nms.domains.SystemTable;
import nis.nms.domains.XtJsJbxx;
import nis.nms.domains.XtYhJbxx;
import nis.nms.domains.XtYhJsIndex;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Common;
import nis.nms.util.Constant;
import nis.nms.util.DESUtil;
import nis.nms.util.DateUtil;
import nis.nms.util.ExportUtils;
import nis.nms.util.FileUtil;
import nis.nms.util.FormBeanUtil;
import nis.nms.util.MD5Util;
import nis.nms.util.Page;

@SuppressWarnings("unchecked")
@Results({ @Result(name = "ok", value = "/page/system/nmstaskmanager/nmstaskInfoList.jsp"),
		@Result(name = "nmstaskInfoListParent", value = "/page/system/nmstaskmanager/nmstaskInfoListParent.jsp"),
		@Result(name = "nmstaskInfoListChild", value = "/page/system/nmstaskmanager/nmstaskInfoListChild.jsp"),
		@Result(name = "toaddtaskPage", value = "/page/system/nmstaskmanager/addnmstaskInfo.jsp"),
		@Result(name = "editViewLevel", value = "/page/system/nmstaskmanager/editMissionViewLevel.jsp"),
		@Result(name = "toAddSimilarTaskPage", value = "/page/system/nmstaskmanager/addSimilar/addSimilarNmsTaskInfo.jsp"),
		@Result(name = "addFailureNodeTaskInfo", value = "/page/system/nmstaskmanager/addFailureNodeTaskInfo.jsp"),
		@Result(name = "toAddConverseTaskPage", value = "/page/system/nmstaskmanager/addConverse/addConverseNmsTaskInfo.jsp"),
		@Result(name = "toAddConverseSimilarTaskPage", value = "/page/system/nmstaskmanager/addSimilar/addConverseSimilarNmsTaskInfo.jsp"),
		@Result(name = "editnmsparam1", value = "/page/system/nmstaskmanager/editnmstaskInfoparameter1.jsp"),
		@Result(name = "editnmsparam2", value = "/page/system/nmstaskmanager/editnmstaskInfoparameter2.jsp"),
		@Result(name = "missionstateparameter1", value = "/page/system/nmstaskmanager/detail/missionstateparameter1.jsp"),
		@Result(name = "missionstateparameter3", value = "/page/system/nmstaskmanager/detail/missionstateparameter3.jsp"),
		@Result(name = "missionstateparameter4", value = "/page/system/nmstaskmanager/detail/missionstateparameter4.jsp"),
		@Result(name = "missionstateparameter5", value = "/page/system/nmstaskmanager/detail/missionstateparameter5.jsp"),
		@Result(name = "missionstateparameter2", value = "/page/system/nmstaskmanager/detail/missionstateparameter2.jsp"),
		@Result(name = "missionstateparameter6", value = "/page/system/nmstaskmanager/detail/missionstateparameter6.jsp"),
		@Result(name = "converseMissionDetail", value = "/page/system/nmstaskmanager/detail/converseMissionDetail.jsp"),
		@Result(name = "missionResultsList", value = "/page/system/nmstaskmanager/missionResultList.jsp"),
		@Result(name = "missionResultsListChild", value = "/page/system/nmstaskmanager/missionResultListChild.jsp"),
		@Result(name = "statistics", value = "/page/system/nmstaskmanager/missionResultsStatistics.jsp"),
		@Result(name = "statisticsList", value = "/page/system/nmstaskmanager/missionResultsStatisticsList.jsp"),
		@Result(name = "statisticsListChild", value = "/page/system/nmstaskmanager/missionResultsStatisticsListChild.jsp"),
		@Result(name = "toUpdateAgent", value = "/page/system/nmstaskmanager/addnmstaskInfo.jsp"),
		@Result(name = "resultPieChart", value = "/page/system/nmstaskmanager/missionResultPieChart.jsp"),
		@Result(name = "resultBarChart", value = "/page/system/nmstaskmanager/missionResultBarChart.jsp"),
		@Result(name = "resultLineChart", value = "/page/system/nmstaskmanager/missionResultLineChart.jsp") })
public class NmsTaskManagerAction extends BaseAction {
	private static Logger logger = Logger.getLogger(NmsTaskManagerAction.class);
	private static final long serialVersionUID = 3380380695655082843L;
	private static final String PARAM_SEPRATOR = "@&##&@";
	private static final String STR_PARAM_SEPRATOR = ";";

	private String action = "";

	private Page page;

	private int pageNo = 1;

	private int pageSize = this.getDefaultPageSize(); // 每页显示的记录条数

	private String systemid = "";
	// 用户组id
	private String usergroupId = "";

	private MissionParameterTable1 missionparametertable1;

	private NodegroupTable nodegrouptable;

	private XtJsJbxx xtjsjbxx;

	private String shellPathFileName;

	private File shellPath;

	private File sourcePath;

	private String sourcePathFileName;

	List<Object[]> resultObjects;

	private SystemTable systemTable;

	private MissionParameterTable4 missionparameteriable4;

	private MissionParameterTable6 missionparametertable6;
	private MissionFileInformation fileInformation;
	private List<String> fileInfoFileName;
	private List<File> fileInfo;
	private FileUtil fu = new FileUtil();

	private OrderTable orderTable;

	private Date startTimeStr;

	private Date endTimeStr;

	private MissionStateTable missionstatetable;

	private List<MissionStateTable> missionstateTableList = new ArrayList<MissionStateTable>();

	private String ajaxtype = "";
	private List<Long> userEmailIds;

	// private Long osLimits = -1l;
	// private Long version ;
	private Long[] ids;
	private Long nodeListId;// 之前节点组不分多级的时候使用的，现在不适用
	private String nodeGroupsId;
	private String nodeIpsId;
	private String missionDesc;
	private String commandPara;
	private Long tabs;
	// private Date p1StartTime;
	// private String p1StartFile ;
	// private String p1StartProcess;
	private List<XtJsJbxx> usergroupLists = new ArrayList<XtJsJbxx>();

	private List<OrderTable> ordertablelist = new ArrayList<OrderTable>();

	private List<NodegroupTable> nodegrouptables = new ArrayList<NodegroupTable>();

	private List<MissionParameterDefaults> mossionparameterdefaults = new ArrayList<MissionParameterDefaults>();

	private MissionParameterDefaults mossionparameterdefault;

	private Set<SystemTable> systemtablelist = null;
	private CommonService commonService;
	private Long[] pid;// 任务id集合
	private Integer commandParaCheck; // 参数模板校验标识 0不校验 1校验

	private List<ParamForM1> paramM1;
	private List<ParamForM4> paramM4;
	private List<ParamForM6> paramM6;

	// 任务列表查询条件
	private String missionName;
	private String loopFlag;
	private String missionState;
	private String missionType;
	private String curMissionId;
	// 相似和逆向任务，节点组节点有效过滤信息提示
	private String nodeCheckInfo;

	private String fromWhere;
	private String isComplete;

	private String mId;
	private String from;

	private int mypageNo;
	private int mypageSize;

	private String rowN;

	// 任务结果展示折线图增加查询之前轮次信息的功能
	private Integer dataStart;
	private Integer dataEnd;
	private Integer dataRange;
	private Integer sumRound;// 总周期数

	public int getMypageNo() {
		return mypageNo;
	}

	public void setMypageNo(int mypageNo) {
		this.mypageNo = mypageNo;
	}

	public int getMypageSize() {
		return mypageSize;
	}

	public void setMypageSize(int mypageSize) {
		this.mypageSize = mypageSize;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public List<NodegroupTable> getNodegrouptables() {
		return nodegrouptables;
	}

	public void setNodegrouptables(List<NodegroupTable> nodegrouptables) {
		this.nodegrouptables = nodegrouptables;
	}

	public CommonService getCommonService() {
		return commonService;
	}

	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public NmsTaskManagerAction() {
	}

	public String executeAction() throws Exception {
		String resultpage = "";
		this.getRequest().setAttribute("fromWhere", fromWhere);
		if ("query".equals(this.action)) {
			this.getRequest().setAttribute("ADMFlag", this.getAdminMark());
			querymissionStateTable();
			resultpage = "ok";
		}
		if ("queryParent".equals(this.action)) {// 2015-10-27 菜单整理后，此入口暂未使用
			this.getRequest().setAttribute("ADMFlag", this.getAdminMark());
			resultpage = querymissionStateTableParent();
		}
		if ("queryChild".equals(this.action)) {
			querymissionStateTable();
			resultpage = "nmstaskInfoListChild";
		}
		if ("toaddtaskPage".equals(this.action)) {
			getNMSsystem();
			this.getRequest().setAttribute("fromWhere", fromWhere);
			resultpage = "toaddtaskPage";
		}
		if ("editViewLevel".equals(this.action)) {
			getNMSsystem();
			resultpage = editViewLevel();
		}
		if ("updateViewLevel".equals(this.action)) {
			resultpage = updateViewLevel();
		}

		if ("toAddSimilarTaskPage".equals(this.action)) {// 新增相似任务:普通任务的相似任务（相似后仍是普通任务）+逆向任务的相似任务（相似后仍是逆向任务）
			getNMSsystem();
			this.getRequest().setAttribute("fromWhere", fromWhere);
			if (pid.length == 1 && pid[0] != null) {// 只选择了一个任务
				getMissionInfoForSimilar();// 根据所选任务，取得任务的相关信息
				nodeCheckInfo = getI18nText("i18n_NmsTaskManagerAction.executeAction.nodeCheckInfo_n81i");
				if (isConverseMiss(String.valueOf(pid[0]))) {
					resultpage = "toAddConverseSimilarTaskPage";// 逆向任务的相似任务
				} else {
					resultpage = "toAddSimilarTaskPage";// 普通任务的相似任务
				}
			}
		}
		if ("toAddConverseTaskPage".equals(this.action)) {// 新增逆向任务
			nodeCheckInfo =getI18nText("i18n_NmsTaskManagerAction.executeAction.nodeCheckInfo_n81i");
			getNMSsystem();// 查找用户组等信息
			getMissionInfoForConverse();// 根据所选任务，取得任务的相关信息，过滤无备份的命令
			this.getRequest().setAttribute("fromWhere", fromWhere);
			resultpage = "toAddConverseTaskPage";
		}
		if ("queryMissInfoForConverse".equals(this.action)) {// 新增逆向任务前，检查所选任务是否符合逆向任务的条件
			resultpage = this.queryMissInfoForConverse();
		}
		if ("ajax".equals(this.action)) {
			toQueryrefpro(systemid);
			return null;
		}
		/*
		 * if("commond".equals(this.action)){ getCommondnameByType(); return
		 * null; }
		 */
		if ("savetask".equals(this.action)) {// 新增和新增相似任务的保存
			saveTaskbyType();
			return null;
		}
		if ("saveConverseTask".equals(this.action)) {// 新增逆向任务的保存
			saveConverseTask();// 升级部署类型的任务才可逆向
			return null;
		}
		if ("viewMission".equals(this.action)) {
			pl("=============="+getI18nText("i18n_NmsTaskManagerAction.executeAction.viewMission_n81i")+"=============");
			resultpage = getAllMissionInfo();
		}
		if ("statistic".equals(this.action)) {
			pl("=============="+getI18nText("i18n_NmsTaskManagerAction.executeAction.statistic_n81i")+"=============");
			resultpage = getResultInfo();
		}
		if ("statisticList".equals(this.action)) {
			pl("=============="+getI18nText("i18n_NmsTaskManagerAction.executeAction.statisticList_n81i")+"=============");
			statisticalResultList();
			resultpage = "statisticsList";
		}
		if ("statisticListChild".equals(this.action)) {
			pl("=============="+getI18nText("i18n_NmsTaskManagerAction.executeAction.statisticList_n81i")+"=============");
			statisticalResultList();
			resultpage = "statisticsListChild";
		}
		if ("download".equals(this.action)) {
			downloadfile();
			return null;
		}
		if ("toeditedate".equals(this.action)) {
			getNMSsystem();
			resultpage = toEditepage();
		}
		if ("update".equals(this.action)) {
			updateDate();
			return null;
		}
		if ("toUpdateState".equals(this.action)) {
			updateState();
			return null;
		}
		if ("JsonSrc".equals(this.action)) {
			this.showTP();
			return null;
		}
		if ("resultChart".equals(this.action)) {
			resultpage = this.getResultChart();
		}
		if ("queryUserInfo".equals(this.action)) {
			resultpage = this.queryUserInfo();
		}
		// Agent升级特殊处理操作
		if ("toUpdateAgent".equals(this.action)) {
			nodeCheckInfo = getI18nText("i18n_NmsTaskManagerAction.executeAction.nodeCheckInfo_n81i");
			getNMSsystem();
			resultpage = "toUpdateAgent";
		}
		if ("exprotXls".equals(this.action)) {
			resultpage = exprotFailedResultsXls();
		}
		if ("searchResults".equals(this.action)) {
			searchResultsList();
			resultpage = "missionResultsList";
		}
		if ("searchResultsChild".equals(this.action)) {
			searchResultsList();
			resultpage = "missionResultsListChild";
		}
		if ("judgmentFails".equals(this.action)) {
			resultpage = this.judgmentFails();
		}

		if ("upgradeFailedNodes".equals(this.action)) {
			resultpage = this.upgradeFailedNodesAgain();
			nodeCheckInfo =  getI18nText("i18n_NmsTaskManagerAction.executeAction.nodeCheckInfo_n81i");
		}
		if ("saveFailedNodesTask".equals(this.action)) {
			saveFailedNodesTask();
			return null;
		}
		if ("upgradeFailedNodesAsSimilarTask".equals(this.action)) {
			resultpage = this.upgradeFailedNodesAsSimilarTask();
			nodeCheckInfo =  getI18nText("i18n_NmsTaskManagerAction.executeAction.nodeCheckInfo_n81i");
		}
		if ("reverseNodesAgain".equals(this.action)) {
			nodeCheckInfo =  getI18nText("i18n_NmsTaskManagerAction.executeAction.nodeCheckInfo_n81i");
			resultpage = this.reverseNodesAgain();
			String missionIdStr = this.getRequest().getParameter("missionId");
			this.getRequest().setAttribute("missionId", missionIdStr);
			if (pid == null)
				pid = new Long[1];
			pid[0] = Long.parseLong(missionIdStr);
			getNMSsystem();// 查找用户组等信息
			getMissionInfoForConverse();// 根据所选任务，取得任务的相关信息，过滤无备份的命令
		}
		if ("emportCurrentXls".equals(this.action)) {
			resultpage = emportCurrentXls();
		}
		if ("emportAllXls".equals(this.action)) {
			resultpage = emportAllXls();
		}
		if ("misssionInfoDownLoad".equals(this.action)) {
			misssionInfoDownLoad();
			return null;
		}
		if ("batchDownLoadFile".equals(this.action)) {
			batchDownLoadFile();
			return null;
		}
		return resultpage;
	}

	// 当前页导出 程辉 2013-5-8新增
	public String emportCurrentXls() {
		try {
			if (from != null && !"".equals("")) {
				this.getRequest().setAttribute("from", from);
			}

			String mIds = this.getRequest().getParameter("mids");
			if (mIds != null && !"".equals(mIds)) {
				mIds = mIds.substring(0, mIds.length() - 1);
			}

			/*String sqlparam = " t.missionId > 0 "; // 管理员查看权限限制条件
			if (!this.getAdminMark()) { // 非管理员权限查看限制条件
				sqlparam = " (" + " (t.viewLevel=1 and t.userId=" + this.getUserID() + " )"
						+ " or (t.viewLevel=2 and t.groupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='"
						+ this.getUser().getYhbh() + "' and x.type = 1)) " + " or (t.viewLevel=3 and t.systemId= "+this.getSystemID() + ") or t.viewLevel = 4) ";
			}*/
			String sqlparam = this.missionAuthHqlParams("t");//查看权限判断
			String hql = " from MissionStateTable t where " + sqlparam + " ";
			// 查询条件
			if (missionName != null && !"".equals(missionName)) {
				hql += " and Upper(t.missionName) like '%" + missionName.toUpperCase() + "%'";
			}
			if (missionState != null && !"".equals(missionState)) {
				if ("3".equals(missionState)) {
					hql += " and t.missionState like '3%'";
				} else {
					hql += " and t.missionState=" + missionState;
				}
			}
			if (missionType != null && !"0".equals(missionType) && !"".equals(missionType)) {
				hql += " and t.missionType=" + missionType;
			}
			if (loopFlag != null && !"".equals(loopFlag)) {
				hql += " and t.loopFlag=" + loopFlag;
			}

			if (mId != null && !"".equals(mId)) {
				hql += " and t.missionId=" + Long.parseLong(mId);
			}

			/*if (!this.getAdminMark() && this.getSystemID() != null) {
				hql += " and t.systemId=" + this.getSystemID();
			}*/
			if (mIds != null && !"".equals(mIds)) {
				hql += " and t.missionId in (" + mIds + ")";
			}
			if (from != null && from.equals("pp")) {
				hql += " and (t.missionState = 3 or t.missionState = 30 or t.missionState = 31 or t.missionState = 32)"
						+ " and (t.isLook is null or t.isLook ='1' or (t.isLook = '0' and instr(t.lookUserIds,'"
						+ this.getUserID() + "')= 0 "
						+ " and instr(t.lookUserIds,to_char(t.userId))= 0) or (t.isLook ='0' and t.lookUserIds is null))";
			}
			hql += " order by t.createTime desc";
			page = this.commonService.findByPage(hql, pageNo, this.getPageSize());
			List<MissionStateTable> missionstateTableList = (List<MissionStateTable>) page.getResult();

			for (MissionStateTable missonstate : missionstateTableList) {
				XtYhJbxx xtyhjbxx = (XtYhJbxx) this.commonService.get(XtYhJbxx.class, missonstate.getUserId());
				if (xtyhjbxx != null) {
					missonstate.setUserIdName(xtyhjbxx.getYhmc());
				}
				SystemTable systemtable = (SystemTable) this.commonService.get(SystemTable.class,
						missonstate.getSystemId());
				if (systemtable != null) {
					missonstate.setSystemIdName(systemtable.getSystemName());
				}
				if (missonstate.getGroupId() != null && missonstate.getGroupId().intValue() != 0) {
					XtJsJbxx xtjsjbxx = (XtJsJbxx) this.commonService.get(XtJsJbxx.class, missonstate.getGroupId());
					if (xtjsjbxx != null) {
						missonstate.setGroupIdName(xtjsjbxx.getJsmc());
					}
				}
				if (missonstate.getMissionType() == 1) {
					missonstate.setMissionTypeName(getI18nText("i18n_NmsTaskManagerAction.executeAction.pushFile_n81i"));
				}
				if (missonstate.getMissionType() == 2) {
					missonstate.setMissionTypeName(getI18nText("i18n_NmsTaskManagerAction.executeAction.getNotFlowData_n81i"));
				}
				if (missonstate.getMissionType() == 3) {
					missonstate.setMissionTypeName(getI18nText("i18n_NmsTaskManagerAction.executeAction.getFlowData_n81i"));
				}
				if (missonstate.getMissionType() == 5) {
					missonstate.setMissionTypeName(getI18nText("i18n_NmsTaskManagerAction.executeAction.regist_n81i"));
				}
				if (missonstate.getMissionType() == 4) {
					missonstate.setMissionTypeName(getI18nText("i18n_NmsTaskManagerAction.executeAction.execCmd_n81i"));
				}
				if (missonstate.getMissionType() == 6) {
					missonstate.setMissionTypeName(getI18nText("i18n_NmsTaskManagerAction.executeAction.upgrade_n81i"));
				}
				if (missonstate.getLoopFlag() == 0) {
					missonstate.setIsLook(getI18nText("i18n_NmsTaskManagerAction.executeAction.N_n81i"));
				}
				if (missonstate.getLoopFlag() == 1) {
					missonstate.setIsLook(getI18nText("i18n_NmsTaskManagerAction.executeAction.Y_n81i"));
				}
				if (missonstate.getMissionState() == 1) {
					missonstate.setAutoDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.missionHasCreate_n81i"));
				}
				if (missonstate.getMissionState() == 2) {
					missonstate.setAutoDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.missionStart_n81i"));
				}
				if (missonstate.getMissionState() == 3) {
					missonstate.setAutoDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.complete_n81i"));
				}
				if (missonstate.getMissionState() == 4) {
					missonstate.setAutoDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.missionUncomplete_n81i"));
				}
				if (missonstate.getMissionState() == 5) {
					missonstate.setAutoDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.loopMissionPrepareRevoke_n81i"));
				}
				if (missonstate.getMissionState() == 6) {
					missonstate.setAutoDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.revokeLoopMission_n81i"));
				}
				if (missonstate.getMissionState() == 7) {
					missonstate.setAutoDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.revokeLoopMissionComplete_n81i"));
				}
				if (missonstate.getMissionState() == 30) {
					missonstate.setAutoDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.allSuccess_n81i"));
				}
				if (missonstate.getMissionState() == 31) {
					missonstate.setAutoDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.allFaild_n81i"));
				}
				if (missonstate.getMissionState() == 32) {
					missonstate.setAutoDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.someSUccess_n81i"));
				}
				if (missonstate.getViewLevel() == 1) {
					missonstate.setFailDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.createUserCheck_n81i"));
				}
				if (missonstate.getViewLevel() == 2) {
					missonstate.setFailDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.createUserGroupCheck_n81i"));
				}
				if (missonstate.getViewLevel() == 3) {
					missonstate.setFailDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.systemUser_n81i"));
				}
			}

			String[] title = { getI18nText("i18n_NmsTaskManagerAction.executeAction.title.missionName _n81i"), 
								getI18nText("i18n_NmsTaskManagerAction.executeAction.title.missionType_n81i"), 
								getI18nText("i18n_NmsTaskManagerAction.executeAction.title.isLoop_n81i"),
								getI18nText("i18n_NmsTaskManagerAction.executeAction.title.missionState_n81i"), 
								getI18nText("i18n_NmsTaskManagerAction.executeAction.title.missionStateDesc_n81i"),
								getI18nText("i18n_NmsTaskManagerAction.executeAction.title.system_n81i"),
								getI18nText("i18n_NmsTaskManagerAction.executeAction.title.userGroup_n81i"), 
								getI18nText("i18n_NmsTaskManagerAction.executeAction.title.viewPrivilige_n81i"),
								getI18nText("i18n_NmsTaskManagerAction.executeAction.title.creater_n81i"), 
								getI18nText("i18n_NmsTaskManagerAction.executeAction.title.createTime_n81i") };

			String[] colu = { "missionName", "missionTypeName", "isLook", "autoDesc", "missionStateDesc",
					"systemIdName", "groupIdName", "failDesc", "userIdName", "createTime" };
			String flag = this.getRequest().getParameter("flag");
			String url = "";
			if ("taskView".equals(flag)) {
				url = "nmsTaskManager!execute.do?action=query&missionName=" + missionName + "&loopFlag=" + loopFlag
						+ "&missionState=" + missionState + "&missionType=" + missionType + "&pageSize=" + pageSize
						+ "&pageNo=" + pageNo;
			} else if ("taskConfigration".equals(flag)) {
				url = "nmsTaskManager.do?action=query&missionName=" + missionName + "&loopFlag=" + loopFlag
						+ "&missionState=" + missionState + "&missionType=" + missionType + "&pageSize=" + pageSize
						+ "&pageNo=" + pageNo;
			}
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(url, getI18nText("i18n_NmsTaskManagerAction.executeAction.missionManageTable_n81i"), missionstateTableList, title, colu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// 导出全部 程辉 2013-5-8新增
	public String emportAllXls() {
		try {
			if (from != null && !"".equals("")) {
				this.getRequest().setAttribute("from", from);
			}

			String mIds = this.getRequest().getParameter("mids");
			if (mIds != null && !"".equals(mIds)) {
				mIds = mIds.substring(0, mIds.length() - 1);
			}

			/*String sqlparam = " t.missionId > 0 "; // 管理员查看权限限制条件
			if (!this.getAdminMark()) { // 非管理员权限查看限制条件
				sqlparam = " (" + " (t.viewLevel=1 and t.userId=" + this.getUserID() + " )"
						+ " or (t.viewLevel=2 and t.groupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='"
						+ this.getUser().getYhbh() + "' and x.type = 1)) " + " or (t.viewLevel=3 ) " + ") ";
			}*/
			String sqlparam = this.missionAuthHqlParams("t");//查看权限判断
			String hql = " from MissionStateTable t where " + sqlparam + " ";
			// 查询条件
			if (missionName != null && !"".equals(missionName)) {
				hql += " and Upper(t.missionName) like '%" + missionName.toUpperCase() + "%'";
			}
			if (missionState != null && !"".equals(missionState)) {
				if ("3".equals(missionState)) {
					hql += " and t.missionState like '3%'";
				} else {
					hql += " and t.missionState=" + missionState;
				}
			}
			if (missionType != null && !"0".equals(missionType) && !"".equals(missionType)) {
				hql += " and t.missionType=" + missionType;
			}
			if (loopFlag != null && !"".equals(loopFlag)) {
				hql += " and t.loopFlag=" + loopFlag;
			}

			if (mId != null && !"".equals(mId)) {
				hql += " and t.missionId=" + Long.parseLong(mId);
			}

			/*if (!this.getAdminMark() && this.getSystemID() != null) {
				hql += " and t.systemId=" + this.getSystemID();
			}*/
			if (mIds != null && !"".equals(mIds)) {
				hql += " and t.missionId in (" + mIds + ")";
			}
			if (from != null && from.equals("pp")) {
				hql += " and (t.missionState = 3 or t.missionState = 30 or t.missionState = 31 or t.missionState = 32)"
						+ " and (t.isLook is null or t.isLook ='1' or (t.isLook = '0' and instr(t.lookUserIds,'"
						+ this.getUserID() + "')= 0 "
						+ " and instr(t.lookUserIds,to_char(t.userId))= 0) or (t.isLook ='0' and t.lookUserIds is null))";
			}
			hql += " order by t.createTime desc";
			List<MissionStateTable> missionstateTableList = this.commonService.find(hql);

			for (MissionStateTable missonstate : missionstateTableList) {
				XtYhJbxx xtyhjbxx = (XtYhJbxx) this.commonService.get(XtYhJbxx.class, missonstate.getUserId());
				if (xtyhjbxx != null) {
					missonstate.setUserIdName(xtyhjbxx.getYhmc());
				}
				SystemTable systemtable = (SystemTable) this.commonService.get(SystemTable.class,
						missonstate.getSystemId());
				if (systemtable != null) {
					missonstate.setSystemIdName(systemtable.getSystemName());
				}
				if (missonstate.getGroupId() != null && missonstate.getGroupId().intValue() != 0) {
					XtJsJbxx xtjsjbxx = (XtJsJbxx) this.commonService.get(XtJsJbxx.class, missonstate.getGroupId());
					if (xtjsjbxx != null) {
						missonstate.setGroupIdName(xtjsjbxx.getJsmc());
					}
				}
				if (missonstate.getMissionType() == 1) {
					missonstate.setMissionTypeName(getI18nText("i18n_NmsTaskManagerAction.executeAction.pushFile_n81i"));
				}
				if (missonstate.getMissionType() == 2) {
					missonstate.setMissionTypeName(getI18nText("i18n_NmsTaskManagerAction.executeAction.getNotFlowData_n81i"));
				}
				if (missonstate.getMissionType() == 3) {
					missonstate.setMissionTypeName(getI18nText("i18n_NmsTaskManagerAction.executeAction.getFlowData_n81i"));
				}
				if (missonstate.getMissionType() == 5) {
					missonstate.setMissionTypeName(getI18nText("i18n_NmsTaskManagerAction.executeAction.regist_n81i"));
				}
				if (missonstate.getMissionType() == 4) {
					missonstate.setMissionTypeName(getI18nText("i18n_NmsTaskManagerAction.executeAction.execCmd_n81i"));
				}
				if (missonstate.getMissionType() == 6) {
					missonstate.setMissionTypeName(getI18nText("i18n_NmsTaskManagerAction.executeAction.upgrade_n81i"));
				}
				if (missonstate.getLoopFlag() == 0) {
					missonstate.setIsLook(getI18nText("i18n_NmsTaskManagerAction.executeAction.N_n81i"));
				}
				if (missonstate.getLoopFlag() == 1) {
					missonstate.setIsLook(getI18nText("i18n_NmsTaskManagerAction.executeAction.Y_n81i"));
				}
				if (missonstate.getMissionState() == 1) {
					missonstate.setAutoDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.missionHasCreate_n81i"));
				}
				if (missonstate.getMissionState() == 2) {
					missonstate.setAutoDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.missionStart_n81i"));
				}
				if (missonstate.getMissionState() == 3) {
					missonstate.setAutoDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.complete_n81i"));
				}
				if (missonstate.getMissionState() == 4) {
					missonstate.setAutoDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.missionUncomplete_n81i"));
				}
				if (missonstate.getMissionState() == 5) {
					missonstate.setAutoDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.loopMissionPrepareRevoke_n81i"));
				}
				if (missonstate.getMissionState() == 6) {
					missonstate.setAutoDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.revokeLoopMission_n81i"));
				}
				if (missonstate.getMissionState() == 7) {
					missonstate.setAutoDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.revokeLoopMissionComplete_n81i"));
				}
				if (missonstate.getMissionState() == 30) {
					missonstate.setAutoDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.allSuccess_n81i"));
				}
				if (missonstate.getMissionState() == 31) {
					missonstate.setAutoDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.allFaild_n81i"));
				}
				if (missonstate.getMissionState() == 32) {
					missonstate.setAutoDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.someSUccess_n81i"));
				}
				if (missonstate.getViewLevel() == 1) {
					missonstate.setFailDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.createUserCheck_n81i"));
				}
				if (missonstate.getViewLevel() == 2) {
					missonstate.setFailDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.createUserGroupCheck_n81i"));
				}
				if (missonstate.getViewLevel() == 3) {
					missonstate.setFailDesc(getI18nText("i18n_NmsTaskManagerAction.executeAction.systemUser_n81i"));
				}
			}

			String[] title = { getI18nText("i18n_NmsTaskManagerAction.executeAction.title.missionName _n81i"), 
					getI18nText("i18n_NmsTaskManagerAction.executeAction.title.missionType_n81i"), 
					getI18nText("i18n_NmsTaskManagerAction.executeAction.title.isLoop_n81i"),
					getI18nText("i18n_NmsTaskManagerAction.executeAction.title.missionState_n81i"), 
					getI18nText("i18n_NmsTaskManagerAction.executeAction.title.missionStateDesc_n81i"),
					getI18nText("i18n_NmsTaskManagerAction.executeAction.title.system_n81i"),
					getI18nText("i18n_NmsTaskManagerAction.executeAction.title.userGroup_n81i"), 
					getI18nText("i18n_NmsTaskManagerAction.executeAction.title.viewPrivilige_n81i"),
					getI18nText("i18n_NmsTaskManagerAction.executeAction.title.creater_n81i"), 
					getI18nText("i18n_NmsTaskManagerAction.executeAction.title.createTime_n81i") };

			String[] colu = { "missionName", "missionTypeName", "isLook", "autoDesc", "missionStateDesc",
					"systemIdName", "groupIdName", "failDesc", "userIdName", "createTime" };

			String flag = this.getRequest().getParameter("flag");
			String url = "";
			if ("taskView".equals(flag)) {
				url = "nmsTaskManager!execute.do?action=query&missionName=" + missionName + "&loopFlag=" + loopFlag
						+ "&missionState=" + missionState + "&missionType=" + missionType + "&pageSize=" + pageSize
						+ "&pageNo=" + pageNo;
			} else if ("taskConfigration".equals(flag)) {
				url = "nmsTaskManager.do?action=query&missionName=" + missionName + "&loopFlag=" + loopFlag
						+ "&missionState=" + missionState + "&missionType=" + missionType + "&pageSize=" + pageSize
						+ "&pageNo=" + pageNo;
			}
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(url, getI18nText("i18n_NmsTaskManagerAction.executeAction.missionManageTable_n81i"), missionstateTableList, title, colu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public String upgradeFailedNodesAgain() {
		String missionIdStr = this.getRequest().getParameter("missionId");
		String result = this.getRequest().getParameter("result");
		String ip = this.getRequest().getParameter("ip");
		this.getRequest().setAttribute("missionId", missionIdStr);
		this.getRequest().setAttribute("result", result);
		this.getRequest().setAttribute("ip", ip);
		Long missionId = Long.parseLong(missionIdStr);
		try {
			missionstatetable = getMissionStateTableForShow(missionId);
			if (missionstatetable != null) {

				if (missionstatetable.getMissionType() == 1l) { // 推送

					MissionParameterTable1 mpt1 = (MissionParameterTable1) commonService
							.get(MissionParameterTable1.class, missionId);

					String ntIds = selectFailureNodesList(missionId, missionstatetable.getMissionType(),
							missionstatetable.getLoopFlag(), mpt1.getNodeGroupsId(), mpt1.getNodeIpsId());

					if (ntIds.length() > 0) {

						mpt1.setNodeIpsId(ntIds.toString());

						getNMSsystem();

						if (pid == null) {
							pid = new Long[] { missionId };
						} else {
							pid[0] = missionId;
						}
						String nodeGroupIds = mpt1.getNodeGroupsId();
						mpt1.setNodeListName(getNodeGroupNames(nodeGroupIds));

						String nodeIpsStr = mpt1.getNodeIpsId();
						mpt1.setNodeListName2(getNodeNames(nodeIpsStr));
						this.getRequest().setAttribute("missionParamterTable", mpt1);
						/*
						 * getMissionInfoForSimilar();//根据所选任务，取得任务的相关信息
						 * getRequest().setAttribute("nodeLock", "1");
						 */
						return "addFailureNodeTaskInfo";// 失败节点再次升级
					} else {
						outHtmlString(
								"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.noNode_n81i');this.location='nmsTaskManager!executeAction.do?action=searchResults&result="
										+ result + "&ip=" + ip + "&curMissionId=" + curMissionId + "&tabs=" + tabs
										+ "&missionId=" + missionId + "&pageNo=" + pageNo + "&pageSize=" + pageSize
										+ "';</script>");
						return null;
					}

				} else if (missionstatetable.getMissionType() == 4l) { // 命令
					MissionParameterTable4 mpt4 = (MissionParameterTable4) commonService
							.get(MissionParameterTable4.class, missionId);
					String ntIds = selectFailureNodesList(missionId, missionstatetable.getMissionType(),
							missionstatetable.getLoopFlag(), mpt4.getNodeGroupsId(), mpt4.getNodeIpsId());

					if (ntIds.length() > 0) {
						mpt4.setNodeIpsId(ntIds.toString());

						getNMSsystem();

						if (pid == null) {
							pid = new Long[] { missionId };
						} else {
							pid[0] = missionId;
						}

						String nodeGroupIds = mpt4.getNodeGroupsId();
						mpt4.setNodeListName(getNodeGroupNames(nodeGroupIds));

						String nodeIpsStr = mpt4.getNodeIpsId();
						mpt4.setNodeListName2(getNodeNames(nodeIpsStr));
						this.getRequest().setAttribute("missionParamterTable", mpt4);
						/*
						 * getMissionInfoForSimilar();//根据所选任务，取得任务的相关信息
						 * getRequest().setAttribute("nodeLock", "1");
						 */
						return "addFailureNodeTaskInfo";// 失败节点再次升级
					} else {
						if (missionstatetable.getLoopFlag().longValue() == 1l) {
							String dataStartStr = "";
							if (dataStart != null) {
								dataStartStr = dataStart + "";
							}
							String dataEndStr = "";
							if (dataEnd != null) {
								dataEndStr = dataEnd + "";
							}
							String dataRangeStr = "";
							if (dataRange != null) {
								dataRangeStr = dataRange + "";
							}
							outHtmlString(
									"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.noNode_n81i');this.location='nmsTaskManager!executeAction.do?action=searchResults&result="
											+ result + "&ip=" + ip + "&curMissionId=" + curMissionId + "&tabs=" + tabs
											+ "&missionId=" + missionId + "&pageNo=" + pageNo + "&pageSize=" + pageSize
											+ "&dataStart=" + dataStartStr + "&dataEnd=" + dataEndStr + "&dataRange="
											+ dataRangeStr + "';</script>");
							return null;
						} else {
							outHtmlString(
									"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.noNode_n81i');this.location='nmsTaskManager!executeAction.do?action=searchResults&result="
											+ result + "&ip=" + ip + "&curMissionId=" + curMissionId + "&tabs=" + tabs
											+ "&missionId=" + missionId + "&pageNo=" + pageNo + "&pageSize=" + pageSize
											+ "';</script>");
							return null;
						}
					}

				} else if (missionstatetable.getMissionType() == 6l) { // 部署升级
					MissionParameterTable6 mpt6 = (MissionParameterTable6) commonService
							.get(MissionParameterTable6.class, missionId);
					String ntIds = selectFailureNodesList(missionId, missionstatetable.getMissionType(),
							missionstatetable.getLoopFlag(), mpt6.getNodeGroupsId(), mpt6.getNodeIpsId());

					if (ntIds.length() > 0) {
						mpt6.setNodeIpsId(ntIds.toString());

						getNMSsystem();

						if (pid == null) {
							pid = new Long[] { missionId };
						} else {
							pid[0] = missionId;
						}

						String nodeGroupIds = mpt6.getNodeGroupsId();
						mpt6.setNodeListName(getNodeGroupNames(nodeGroupIds));

						String nodeIpsStr = mpt6.getNodeIpsId();
						mpt6.setNodeListName2(getNodeNames(nodeIpsStr));
						this.getRequest().setAttribute("missionParamterTable", mpt6);
						/*
						 * getMissionInfoForSimilar();//根据所选任务，取得任务的相关信息
						 * getRequest().setAttribute("nodeLock", "1");
						 */
						return "addFailureNodeTaskInfo";// 失败节点再次升级
					} else {
						outHtmlString(
								"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.noNode_n81i');this.location='nmsTaskManager!executeAction.do?action=searchResults&result="
										+ result + "&ip=" + ip + "&curMissionId=" + curMissionId + "&tabs=" + tabs
										+ "&missionId=" + missionId + "&pageNo=" + pageNo + "&pageSize=" + pageSize
										+ "';</script>");
						return null;
					}
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			logger.info("失败节点再次执行异常！", e);
			if (missionstatetable.getLoopFlag().longValue() == 1l) {
				String dataStartStr = "";
				if (dataStart != null) {
					dataStartStr = dataStart + "";
				}
				String dataEndStr = "";
				if (dataEnd != null) {
					dataEndStr = dataEnd + "";
				}
				String dataRangeStr = "";
				if (dataRange != null) {
					dataRangeStr = dataRange + "";
				}
				outHtmlString(
						"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.noNode_n81i');this.location='nmsTaskManager!executeAction.do?action=searchResults&result="
								+ result + "&ip=" + ip + "&curMissionId=" + curMissionId + "&tabs=" + tabs
								+ "&missionId=" + missionId + "&pageNo=" + pageNo + "&pageSize=" + pageSize
								+ "&dataStart=" + dataStartStr + "&dataEnd=" + dataEndStr + "&dataRange=" + dataRangeStr
								+ "';</script>");
				return null;
			} else {
				outHtmlString(
						"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.noNode_n81i');this.location='nmsTaskManager!executeAction.do?action=searchResults&result="
								+ result + "&ip=" + ip + "&curMissionId=" + curMissionId + "&tabs=" + tabs
								+ "&missionId=" + missionId + "&pageNo=" + pageNo + "&pageSize=" + pageSize
								+ "';</script>");
			}
		}
		return null;
	}

	/**
	 * 查询任务失败节点
	 * 
	 * @time Dec 19, 2012-1:49:41 PM
	 * @param missionId
	 * @param missionType
	 * @param groupIds
	 * @param nodeIpsId
	 * @return
	 */
	public String selectFailureNodesList(Long missionId, long missionType, long loopFlag, String groupIds,
			String nodeIpsId) {

		/* 查询失败节点 */
		String nodeParamsSql = StringUtils.isEmpty(nodeIpsId) ? "" : " and nt.node_id in (" + nodeIpsId + ") ";
		String missionIdSql = loopFlag != 1 ? missionId + ""
				: " select lmst.cur_mission_id from loopmission_state_table lmst where lmst.mission_id = " + missionId;
		StringBuffer ntIds = new StringBuffer();
		String ntIdsSql = null;
		ntIdsSql = "select nt.node_id from node_table nt where nt.node_state=0 and nt.node_group_id in (" + groupIds
				+ ") " + nodeParamsSql + " and nt.seq_id in (select r.seq_id from mission_result_table" + missionType
				+ " r where r.mission_id in (" + missionIdSql + ") and  r.result in (1,-1))";

		List<BigDecimal> ntIdsList = null;

		try {
			ntIdsList = commonService.executeSQL(ntIdsSql);
		} catch (Exception e) {
			e.printStackTrace();
		}

		/* 拼写ID字符串 */
		if (ntIdsList != null && ntIdsList.size() > 0) {
			for (Iterator<BigDecimal> iterator = ntIdsList.iterator(); iterator.hasNext();) {
				BigDecimal ntid = iterator.next();
				ntIds.append("," + ntid.longValue());
			}
		}

		if (ntIds.length() > 0) {
			ntIds.deleteCharAt(0);
		}
		return ntIds.toString();
	}

	/**
	 * 失败节点到相似任务
	 * 
	 * @time Dec 19, 2012-2:00:16 PM
	 * @return
	 */
	public String upgradeFailedNodesAsSimilarTask() {
		String missionIdStr = this.getRequest().getParameter("oldMissionId");
		Long missionId = Long.parseLong(missionIdStr);
		try {
			missionstatetable = getMissionStateTableForShow(missionId);
			if (missionstatetable != null) {

				if (missionstatetable.getMissionType() == 1l) { // 推送

					MissionParameterTable1 mpt1 = (MissionParameterTable1) commonService
							.get(MissionParameterTable1.class, missionId);

					String ntIds = selectFailureNodesList(missionId, missionstatetable.getMissionType(),
							missionstatetable.getLoopFlag(), mpt1.getNodeGroupsId(), mpt1.getNodeIpsId());

					if (ntIds.length() > 0) {

						mpt1.setNodeIpsId(ntIds.toString());

						getNMSsystem();

						if (pid == null) {
							pid = new Long[] { missionId };
						} else {
							pid[0] = missionId;
						}
						/*
						 * String nodeGroupIds = mpt1.getNodeGroupsId();
						 * mpt1.setNodeListName(getNodeGroupNames(nodeGroupIds))
						 * ;
						 * 
						 * String nodeIpsStr = mpt1.getNodeIpsId();
						 * mpt1.setNodeListName2(getNodeNames(nodeIpsStr));
						 * this.getRequest().setAttribute(
						 * "missionParamterTable", mpt1);
						 */

						getMissionInfoForSimilar();// 根据所选任务，取得任务的相关信息
						// getRequest().setAttribute("nodeLock", "1");
						return "toAddSimilarTaskPage";// 失败节点再次升级
					} else {
						outHtmlString(
								"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.noNode_n81i');window.history.go(-1);</script>");
						return null;
					}

				} else if (missionstatetable.getMissionType() == 4l) { // 命令
					MissionParameterTable4 mpt4 = (MissionParameterTable4) commonService
							.get(MissionParameterTable4.class, missionId);
					String ntIds = selectFailureNodesList(missionId, missionstatetable.getMissionType(),
							missionstatetable.getLoopFlag(), mpt4.getNodeGroupsId(), mpt4.getNodeIpsId());

					if (ntIds.length() > 0) {
						mpt4.setNodeIpsId(ntIds.toString());

						getNMSsystem();

						if (pid == null) {
							pid = new Long[] { missionId };
						} else {
							pid[0] = missionId;
						}

						/*
						 * String nodeGroupIds = mpt4.getNodeGroupsId();
						 * mpt4.setNodeListName(getNodeGroupNames(nodeGroupIds))
						 * ;
						 * 
						 * String nodeIpsStr = mpt4.getNodeIpsId();
						 * mpt4.setNodeListName2(getNodeNames(nodeIpsStr)); //
						 * this.getRequest().setAttribute(
						 * "missionParamterTable", mpt4);
						 */
						getMissionInfoForSimilar();// 根据所选任务，取得任务的相关信息
						// getRequest().setAttribute("nodeLock", "1");
						return "toAddSimilarTaskPage";// 失败节点再次升级
					} else {
						outHtmlString(
								"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.noNode_n81i');window.history.go(-1);</script>");
						return null;
					}

				} else if (missionstatetable.getMissionType() == 6l) { // 部署升级
					MissionParameterTable6 mpt6 = (MissionParameterTable6) commonService
							.get(MissionParameterTable6.class, missionId);
					String ntIds = selectFailureNodesList(missionId, missionstatetable.getMissionType(),
							missionstatetable.getLoopFlag(), mpt6.getNodeGroupsId(), mpt6.getNodeIpsId());

					if (ntIds.length() > 0) {
						mpt6.setNodeIpsId(ntIds.toString());

						getNMSsystem();

						if (pid == null) {
							pid = new Long[] { missionId };
						} else {
							pid[0] = missionId;
						}

						/*
						 * String nodeGroupIds = mpt6.getNodeGroupsId();
						 * mpt6.setNodeListName(getNodeGroupNames(nodeGroupIds))
						 * ;
						 * 
						 * String nodeIpsStr = mpt6.getNodeIpsId();
						 * mpt6.setNodeListName2(getNodeNames(nodeIpsStr));
						 */
						getMissionInfoForSimilar();// 根据所选任务，取得任务的相关信息
						// this.getRequest().setAttribute("missionParamterTable",
						// mpt6);
						// getRequest().setAttribute("nodeLock", "1");
						return "toAddSimilarTaskPage";// 失败节点再次升级
					} else {
						outHtmlString(
								"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.noNode_n81i');window.history.go(-1);</script>");
						return null;
					}
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public String reverseNodesAgain() {
		String missionIdStr = this.getRequest().getParameter("missionId");
		String result = this.getRequest().getParameter("result");
		String ip = this.getRequest().getParameter("ip");
		this.getRequest().setAttribute("result", result);
		this.getRequest().setAttribute("ip", ip);

		try {
			String reverseTypeStr = getRequest().getParameter("reverseType");
			StringBuffer ntIds = new StringBuffer();
			MissionParameterTable6 mpt6 = (MissionParameterTable6) commonService.get(MissionParameterTable6.class,
					Long.parseLong(missionIdStr));
			if (StringUtils.isNotEmpty(reverseTypeStr)) {
				Integer reverseType = Integer.parseInt(reverseTypeStr);
				String resultsql = null;
				if (reverseType != null) {
					switch (reverseType) {
					case 0: // 成功节点逆向，将所有成功节点组成临时节点组，生成逆向任务
						resultsql = " r.result =0 ";
						break;
					case 1: // 失败节点逆向：将所有失败节点组成临时节点组，生成逆向任务
						resultsql = " r.result in (1,-1) ";
						break;
					case -1: // 全部节点逆向 ：获取任务节点组，生成逆向任务即可
						resultsql = " 1=1 ";
						break;
					default:
						break;
					}
				}
				String groupIds = mpt6.getNodeGroupsId();
				String ntIdsSql = "select nt.node_id from node_table nt where nt.node_group_id in (" + groupIds + ") "
						+ " and nt.seq_id in (select r.seq_id from mission_result_table6  r where r.mission_id="
						+ missionIdStr + " and " + resultsql + ")";

				List<BigDecimal> ntIdsList = commonService.executeSQL(ntIdsSql);

				if (ntIdsList != null && ntIdsList.size() > 0) {
					for (Iterator<BigDecimal> iterator = ntIdsList.iterator(); iterator.hasNext();) {
						BigDecimal ntid = iterator.next();
						ntIds.append((ntid).longValue() + ",");
					}
				}
				if (ntIds.length() > 0) {
					ntIds.deleteCharAt(ntIds.length() - 1);
					mpt6.setNodeIpsId(ntIds.toString());
				}
			}

			// 创建逆向任务
			if (ntIds.length() > 0) {

				getNMSsystem();// 查找用户组等信息
				// getMissionInfoForConverse();//根据所选任务，取得任务的相关信息，过滤无备份的命令
				getRequest().setAttribute("nodeLock", "1");
				Long missionId = Long.parseLong(missionIdStr);
				if (missionId != null) {
					missionstatetable = getMissionStateTableForShow(missionId);
					if (mpt6 != null) {
						// OrderTable orderTable = (OrderTable)
						// this.commonService.get(OrderTable.class,
						// mpt6.getCommandId());
						OrderTable orderTable = getOrder(mpt6.getCommandEName());
						mpt6.setCommandName(orderTable != null ? orderTable.getCommandAlias() : null);
						String nodeGroupIds = mpt6.getNodeGroupsId();
						mpt6.setNodeListName(getNodeGroupNames(nodeGroupIds));

						String nodeIpsStr = mpt6.getNodeIpsId();
						mpt6.setNodeListName2(getNodeNames(nodeIpsStr));

					}
					missionparametertable6 = mpt6;
					paramM6 = getParamForM6ForShow(missionparametertable6);// 将升级部署的参数转换为ParamForM1对象列表，以便前台显示相应信息

					// 将没有备份参数的命令删掉
					List<ParamForM6> list = new ArrayList<ParamForM6>();
					for (ParamForM6 p6 : paramM6) {
						if (p6 != null) {
							List<Backup> backUpList = p6.getBackups();
							if (backUpList != null && backUpList.size() > 0) {// 判断是否有备份参数
								list.add(p6);
							}
						}
					}
					paramM6 = list;
				}
				return "toAddConverseTaskPage";

			} else {
				String missionId = this.getRequest().getParameter("missionId");
				outHtmlString(
						"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.noNode_n81i');this.location='nmsTaskManager!executeAction.do?action=searchResults&missionId="
								+ missionId + "&result=" + result + "&ip=" + ip + "&tabs=" + tabs + " ';</script>");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 判定失败操作 限定为升级操作 type=6
	 * 
	 * @time Sep 13, 2012-2:11:09 PM
	 * @return
	 */
	public String judgmentFails() {
		String missionId = this.getRequest().getParameter("missionId");
		String curMissionId = this.getRequest().getParameter("curMissionId");
		String result = this.getRequest().getParameter("result");
		String ip = this.getRequest().getParameter("ip");

		this.getRequest().setAttribute("missionId", missionId);
		this.getRequest().setAttribute("curMissionId", curMissionId);
		this.getRequest().setAttribute("result", result);
		this.getRequest().setAttribute("ip", ip);

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = format.format(Calendar.getInstance().getTime());
		missionstatetable = getMissionStateTableForShow(Long.parseLong(missionId));
		if (ids != null && ids.length > 0) {
			StringBuffer strIds = new StringBuffer("0");
			for (Long long1 : ids) {
				strIds.append("," + long1);
			}

			try {
				String sql = "update mission_result_table" + missionstatetable.getMissionType()
						+ " set result = -1 ,result_desc=?  where 1=1 and seq_id in (" + strIds + ")";
				sql += "and mission_id = " + missionId + "";
				commonService.updateBySql(sql, date + ">>"+getI18nText("i18n_NmsTaskManagerAction.executeAction.toJudgeFaild_n81i")+"\n");
			} catch (Exception e) {
				e.printStackTrace();
				outHtmlString(
						"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');this.location='nmsTaskManager.do?action=query'</script>");
				return null;
			}
		}

		String[] curid_ids = getRequest().getParameterValues("curid_ids");
		if (curid_ids != null && curid_ids.length > 0) {
			try {
				String sql = "update mission_result_table" + missionstatetable.getMissionType()
						+ " set result = -1 ,result_desc=?  where 1=1 and mission_id =? and seq_id = ? ";
				for (String curid_id : curid_ids) {
					String[] strId = curid_id.split("_");// loop表的任务id_节点的seqId
					commonService.updateBySql(sql, date + ">>"+getI18nText("i18n_NmsTaskManagerAction.executeAction.toJudgeFaild_n81i")+"\n", strId[0], strId[1]);
				}
			} catch (Exception e) {
				e.printStackTrace();
				outHtmlString(
						"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');this.location='nmsTaskManager.do?action=query'</script>");
				return null;
			}
		}

		// 2013-3-8 hyx 判定失败后，重新统计当前任务的状态，及任务状态描述
		if ("0".equals(missionstatetable.getLoopFlag().toString())) {// 非周期任务：判断一个任务的多个节点为失败，重新统计当前任务即可
			updateCommonMissionStateAndDescByMissId(missionId, missionstatetable.getMissionType());

		} else if ("1".equals(missionstatetable.getLoopFlag().toString())) {// 周期任务
			updateLoopMissionStateAndDescByMissId(missionId);
		}

		String dataStartStr = "";
		if (dataStart != null) {
			dataStartStr = dataStart + "";
		}
		String dataEndStr = "";
		if (dataEnd != null) {
			dataEndStr = dataEnd + "";
		}
		String dataRangeStr = "";
		if (dataRange != null) {
			dataRangeStr = dataRange + "";
		}
		outHtmlString(
				"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.success_n81i');this.location='nmsTaskManager.do?action=searchResults"
						+ "&missionId=" + missionId + "&curMissionId=" + curMissionId + "&result=" + result + "&ip="
						+ ip + "&tabs=" + tabs + "&dataStart=" + dataStartStr + "&dataEnd=" + dataEndStr + "&dataRange="
						+ dataRangeStr + "'</script>");
		return null;
	}

	/**
	 * 判定失败后，重新统计当前任务的状态，及任务状态描述:非周期任务:
	 * 
	 */
	private void updateCommonMissionStateAndDescByMissId(String missionId, Long missiontype) {

		if (StringUtils.isNotBlank(missionId) && missiontype != null) {
			StringBuffer selectDescSql = new StringBuffer();
			selectDescSql.append(" select  t.ok, t.fail, t.total,mst.mission_state ");
			selectDescSql.append(" from ( ");
			selectDescSql.append(" 		select nvl(sum(decode(mrt.result, 0, 1, 0)) ,0) ok, ");
			selectDescSql.append("        		nvl(sum(decode(mrt.result, 1, 1, -1, 1, 0)),0) fail, ");
			selectDescSql.append("        		count(mrt.seq_id) total");
			selectDescSql.append(" 		from mission_result_table" + missiontype + " mrt   ");
			selectDescSql.append(" 		where mrt.mission_id=" + missionId);
			selectDescSql.append(" ) t");
			selectDescSql.append(" left join mission_state_table mst on mst.mission_id = " + missionId);

			// System.out.println(selectDescSql.toString());
			try {
				List<Object[]> misStateList = commonService.executeSQL(selectDescSql.toString());
				if (misStateList != null && misStateList.size() > 0) {//
					Object[] objs = misStateList.get(0);
					// 更新任务的状态描述
					Long ok = objs[0] == null ? null : Long.parseLong(objs[0].toString());
					Long fail = objs[1] == null ? null : Long.parseLong(objs[1].toString());
					Long total = objs[2] == null ? null : Long.parseLong(objs[2].toString());
					// 完成的任务才需要更新状态，但是对于新录入的任务，需要更改其mission_state_table里的mission_state_desc
//					String sql = "update mission_state_table mst set mst.mission_state_desc = '共" + total
//							+ "个执行节点，</br>" + (total - ok - fail) + "个未执行，</br>" + (ok + fail) + "个已执行【成功" + ok + "个，失败"
//							+ fail + "个】' ";
					String sql=getI18nText("i18n_NmsTaskManagerAction.executeAction.sql1_n81i");
					// 更新任务状态:完成的才需要更新完成状态:total!=0 and ok+fail=total
					if (!total.equals(0l) && total.equals(ok + fail)) {
						String state = objs[3] == null ? "" : objs[3].toString();
						if (!"4".equals(state)) {// state=1,2,30,31,32时可以更新状态，任务未能执行（4）时不更新任务状态
							if (ok.equals(total)) {// 成功
								sql = sql + ", mst.mission_state = 30 ";
							} else if (fail.equals(total)) {// 全部失败
								sql = sql + ", mst.mission_state = 31 ";
							} else if (fail.longValue() > 0 && ok.longValue() > 0) {// 部分成功
								sql = sql + ", mst.mission_state = 32 ";
							}
							// 发送邮件-------------------
							commonService.sendEmailForMission(Long.parseLong(missionId), getI18nText("i18n_NmsTaskManagerAction.executeAction.missionExec_n81i"), getI18nText("i18n_NmsTaskManagerAction.executeAction.missionComplete_n81i"));
						}
					}
					sql = sql + " where mst.mission_id = " + missionId;
					commonService.updateBySql(sql);
				}

			} catch (Exception e) {
				logger.error("After determining failure,the state of the current task is recounted and the status description(non cyclical) exception is described", e);
			}
		}
	}

	/**
	 * 判定失败后，重新统计当前任务的状态，及任务状态描述:周期任务 第一步：更新任务状态描述
	 * 第二步：更新loopmission_state_table表任务状态 第三步：更新mission_state_table表的任务状态
	 */
	private void updateLoopMissionStateAndDescByMissId(String missionId) {
		if (StringUtils.isNotBlank(missionId)) {
			try {
				commonService.beginTransaction();
				// 第一步--更新任务的状态描述
				/*
				 * String selectSql =
				 * " select sumT.ok, sumT.fail, sumT.total,sumT.mission_state" +
				 * "  from (" +
				 * "      select row_number() over(partition by lmst.mission_id order by lmst.cur_mission_id desc) cn,"
				 * + "             lmst.cur_mission_id," +
				 * "             mst.mission_state," +
				 * "             t.ok,  t.fail,  t.total" +
				 * "      from (select mrt.mission_id,"
				 * +//--先统计结果4表中的所有数据--start
				 * "                   nvl(sum(decode(mrt.result, 0, 1, 0)),0) ok,"
				 * +
				 * "                   nvl(sum(decode(mrt.result, 1, 1, -1, 1, 0)),0) fail,"
				 * + "                   count(mrt.seq_id) total" +
				 * "            from mission_result_table4 mrt" +
				 * "            group by mrt.mission_id) t"
				 * +//--先统计结果4表中的所有数据--end
				 * "      left join loopmission_state_table lmst on lmst.cur_mission_id = t.mission_id"
				 * +
				 * "      left join mission_state_table mst on mst.mission_id =lmst.mission_id"
				 * + "      where mst.mission_id=  " + missionId +//
				 * --再取当前任务的统计结果 ") sumT" +
				 * " where sumT.cn = 1";//--再取当前任务统计结果的最新周期
				 */
				// @2018年4月17日18:19:10 重新梳理
				String selectSql = "select t.ok, t.fail, t.total, mst.mission_state\n" +
								"  from (select mrt.mission_id,\n" + 
								"               nvl(sum(decode(mrt.result, 0, 1, 0)), 0) ok,\n" + 
								"               nvl(sum(decode(mrt.result, 1, 1, -1, 1, 0)), 0) fail,\n" + 
								"               count(mrt.seq_id) total\n" + 
								"          from mission_result_table4 mrt\n" + 
								"         group by mrt.mission_id) t\n" + 
								"  left join (select max(lst.cur_mission_id) cur_mission_id, lst.mission_id\n" + 
								"               from  mission_result_table4 mrt4\n" + 
								"               left join  loopmission_state_table lst on mrt4.mission_id = lst.cur_mission_id\n" + 
								"              group by lst.mission_id) lmst\n" + 
								"    on lmst.cur_mission_id = t.mission_id\n" + 
								"  left join mission_state_table mst\n" + 
								"    on mst.mission_id = lmst.mission_id\n" + 
								" where mst.mission_id = " + missionId;

				List<Object[]> misStateList = commonService.executeSQL(selectSql.toString());
				if (misStateList != null && misStateList.size() > 0) {//
					Object[] objs = misStateList.get(0);
					Long ok = objs[0] == null ? null : Long.parseLong(objs[0].toString());
					Long fail = objs[1] == null ? null : Long.parseLong(objs[1].toString());
					Long total = objs[2] == null ? null : Long.parseLong(objs[2].toString());
					// 完成的任务才需要更新状态，但是对于新录入的任务，我会更改其mission_state_table里的mission_state_desc
					String sql = "update mission_state_table mst set mst.mission_state_desc = 'i18n_server.UpgradeService.sql.cycle_n81i&nbsp;" + total
							+ "&nbsp;i18n_server.UpgradeService.sql.executeNode2_n81i，</br>" + (total - ok - fail) + "&nbsp;i18n_server.UpgradeService.sql.unexecute_n81i，</br>" + (ok + fail) + "&nbsp;i18n_server.UpgradeService.sql.execute_n81i【i18n_server.UpgradeService.sql.success_n81i&nbsp;" + ok + "&nbsp;i18n_sserver.UpgradeService.sql.failed_n81i&nbsp;"
							+ fail + "&nbsp;】' where mst.mission_id = " + missionId;
//					String sql=getI18nText("i18n_NmsTaskManagerAction.executeAction.sql2_n81i");
					commonService.updateBySql(sql);
				}

				// 第二步--更新loopmission_state_table表任务状态:完成的才需要更新完成状态（判定失败后，若任务仍未完成，则不需要更新状态）
				String updateLoopState = "select lmst.cur_mission_id mission_id, lmst.mission_state "
						+ " from (select mrt.mission_id,"
						+ "             sum(case when mrt.result = 0 then 1 else 0 end) ok,"
						+ "             sum(case when mrt.result in (1, -1) then 1 else  0 end) fail,"
						+ "             sum(case  when mrt.result = 7 then  1  else 0 end) cxOk,"
						+ "             sum(case  when mrt.result = 6 then  1  else 0 end) cxFail,"
						+ "             count(mrt.seq_id) total" + "       from mission_result_table4 mrt"
						+ "       group by mrt.mission_id" + "  ) t"
						+ " left join loopmission_state_table lmst on lmst.cur_mission_id = t.mission_id"
						+ " where lmst.cur_mission_id is not null" + "      and lmst.mission_id=" + missionId + // 统计当前任务的，所有周期的结果数据
						"      and (t.ok + t.fail = t.total or t.cxOk + t.cxFail = t.total)" + // 表示正常完成或者撤销完成的周期
						"      and lmst.mission_state not in (3, 7)";// loop表：3：周期任务完成；7：周期完成撤销。对于4（未能执行的情况如何处理？？？）
				List<Object[]> loopStateList = commonService.executeSQL(updateLoopState.toString());
				if (loopStateList != null && loopStateList.size() > 0) {//
					StringBuffer missionIds = new StringBuffer("0");
					StringBuffer cancelMissionIds = new StringBuffer("0");
					for (Object[] loopObjs : loopStateList) {
						if (loopObjs[0] != null) {
							if (loopObjs[1] != null && "6".equals(loopObjs[1].toString())) { // 撤销周期
								cancelMissionIds.append("," + loopObjs[0].toString());
							} else { // 正常执行周期
								missionIds.append("," + loopObjs[0].toString());
							}
						}
					}

					// 只针对未完成的进行更新，如果当前任务已经为3或者7（已完成），则不用更新了，因为判定失败不会改变3或7的状态（由成功->判定失败，不会改变mission_state值，由执行中->判定失败，会改变mission_state的值，所以有条件mission_state=2或者=6）
					if (cancelMissionIds.length() > 1) {
						commonService.updateBySql(
								"update loopmission_state_table mst set mst.mission_state = 7 where mst.mission_state = 6 and mst.cur_mission_id in ("
										+ cancelMissionIds.toString() + ")");
						// 撤消完成
						commonService
								.updateBySql("update mission_state_table mst set mst.mission_state = 7,mst.auto_desc='"
										+ DateUtil.format.format(System.currentTimeMillis())
										+ " "+getI18nText("i18n_NmsTaskManagerAction.executeAction.missionRevokeComplete_n81i")+"' where mst.mission_state = 6 and mst.mission_id in ( select lmst.mission_id from loopmission_state_table lmst where lmst.cur_mission_id in ("
										+ cancelMissionIds + "))");
						// 发送邮件-------------------
						commonService.sendEmailForMission(Long.parseLong(missionId), getI18nText("i18n_NmsTaskManagerAction.executeAction.missionExec_n81i"),getI18nText("i18n_NmsTaskManagerAction.executeAction.missionComplete_n81i"));
					}

					if (missionIds.length() > 1) {
						commonService.updateBySql(
								"update loopmission_state_table mst set mst.mission_state = 3 where mst.mission_state = 2 and mst.cur_mission_id in ("
										+ missionIds.toString() + ")");
					}
				}

				// 第三步--更新mission_state_table表的任务状态
				StringBuffer missionSql = new StringBuffer();
				missionSql.append(" select mst.mission_id");
				missionSql.append(" from (");
				missionSql.append("         select lmst.mission_id, ");
				missionSql.append("                sum(decode(lmst.mission_state, 3, 1, 7, 1, 0)) ok,");// 正常执行完成的周期，撤销完成的周期
				missionSql.append("                sum(decode(lmst.mission_state, 4, 1, 0)) fail,");// 未能执行的周期
				missionSql.append("                count(lmst.cur_mission_id) total");// 周期任务，每次执行完一个周期，会再生成一些周期（共有10个未执行？），所以此时的total可能不是总周期数
				missionSql.append("         from loopmission_state_table lmst");
				missionSql.append("         group by lmst.mission_id");// 统计loop表里每个周期执行的结果
				missionSql.append("       ) t");
				missionSql.append(" left join mission_state_table mst on mst.mission_id = t.mission_id");
				missionSql.append(" where mst.mission_id=" + missionId);
				missionSql.append("       and t.ok + t.fail = t.total");// 执行完成的
				missionSql.append("       and mst.mission_state not in (3, 7, 4)");// 不更新：已经是完成、撤消完成、未能执行的

				List<Object[]> missStateList = commonService.executeSQL(missionSql.toString());
				if (missStateList != null && missStateList.size() > 0) {//
					// 撤消完成
					commonService.updateBySql("update mission_state_table mst set mst.mission_state = 7,mst.auto_desc='"
							+ DateUtil.format.format(System.currentTimeMillis())
							+ " 任务撤销完成' where mst.mission_state = 6 and mst.mission_id = " + missionId);
					// 执行完成：只针对完成的周期任务，不包括撤销任务
					commonService.updateBySql("update mission_state_table mst set mst.mission_state = 3,mst.auto_desc='"
							+ DateUtil.format.format(System.currentTimeMillis())
							+ " 任务执行完成' where mst.mission_state = 2 and mst.mission_id = " + missionId);
					// 发送邮件-------------------
					commonService.sendEmailForMission(Long.parseLong(missionId), getI18nText("i18n_NmsTaskManagerAction.executeAction.missionExec_n81i"), getI18nText("i18n_NmsTaskManagerAction.executeAction.missionComplete_n81i"));
				}
				commonService.commit();
			} catch (Exception e) {
				commonService.rollback();
				logger.error("After determining failure,the state of the current task is recounted and the status description(non cyclical) exception is described", e);
			}
		}
	}

	public static void main(String[] args) {
		StringBuffer missionSql = new StringBuffer();
		missionSql.append(" select mst.mission_id");
		missionSql.append(" from (");
		missionSql.append("         select lmst.mission_id, ");
		missionSql.append("                sum(decode(lmst.mission_state, 3, 1, 7, 1, 0)) ok,");// 正常执行完成的周期，撤销完成的周期
		missionSql.append("                sum(decode(lmst.mission_state, 4, 1, 0)) fail,");// 未能执行的周期
		missionSql.append("                count(lmst.cur_mission_id) total");
		missionSql.append("         from loopmission_state_table lmst");
		missionSql.append("         group by lmst.mission_id");
		missionSql.append("       ) t");
		missionSql.append(" left join mission_state_table mst on mst.mission_id = t.mission_id");
		missionSql.append(" where t.ok + t.fail = t.total");
		missionSql.append("       and nvl(mst.mission_id, -1) <> -1");
		missionSql.append("       and mst.is_loop = 1");
		missionSql.append("       and mst.mission_state not in (3, 7, 4)");
		System.out.println(missionSql.toString());
	}

	/**
	 * 
	 * 进入新增相似任务页面：根据选择的任务ID，获得任务的相关信息,包括普通任务和逆向任务的信息获取
	 * 
	 * @author hyx Mar 9, 2012
	 * @version 1.0
	 * @return
	 */
	public void getMissionInfoForSimilar() {
		if (pid.length == 1) {// 新增相似任务时只能选中一条记录
			try {
				// 查询任务
				Long missionId = pid[0];
				if (missionId != null) {
					missionstatetable = getMissionStateTableForShow(missionId);
					// -- 多推送文件
					List<MissionFileInformation> filesList = null;
					if (missionstatetable != null) {
						switch (missionstatetable.getMissionType().intValue()) {
						case 1:// 推送文件
							missionparametertable1 = getMissionParameterTable1ForShow(missionId, false);

							paramM1 = getParamForM1ForShow(missionparametertable1);// 将文件推送的参数转换为ParamForM1对象列表，以便前台显示相应信息
							// -- 多推送文件
							filesList = this.commonService.find("from MissionFileInformation t where t.missionId=?",
									Long.valueOf(missionId));
							this.getRequest().setAttribute("filesList", filesList);
							break;
						case 4:// 命令执行
							missionparameteriable4 = getMissionParameterTable4ForShow(missionId, false);
							paramM4 = getParamForM4ForShow(missionparameteriable4);// 将命令执行的参数转换为ParamForM1对象列表，以便前台显示相应信息
							break;
						case 6:// 升级部署
							missionparametertable6 = getMissionParameterTable6ForShow(missionId, false);
							paramM6 = getParamForM6ForShow(missionparametertable6);// 将升级部署的参数转换为ParamForM1对象列表，以便前台显示相应信息
							// -- 多推送文件
							filesList = this.commonService.find("from MissionFileInformation t where t.missionId=?",
									Long.valueOf(missionId));
							this.getRequest().setAttribute("filesList", filesList);
							break;
						default:
							break;
						}
					}
				}
			} catch (Exception e) {
				outHtmlString(
						"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');this.location='nmsTaskManager.do?action=query'</script>");
				e.printStackTrace();
			}
		}
	}

	/**
	 * 
	 * 进入新增逆向任务页面：根据选择的任务ID，获得任务的相关信息，并将没有备份参数的命令去掉 ,只针对升级部署任务 ，和新增逆向任务的相似任务不同
	 * 
	 * @author hyx Mar 21, 2012
	 * @version 1.0
	 */
	public void getMissionInfoForConverse() {
		try {
			// 查询任务
			Long missionId = pid[0];
			if (missionId != null) {
				missionstatetable = getMissionStateTableForShow(missionId);
				missionparametertable6 = getMissionParameterTable6ForShow(missionId, false);
				paramM6 = getParamForM6ForShow(missionparametertable6);// 将升级部署的参数转换为ParamForM1对象列表，以便前台显示相应信息

				// 将没有备份参数的命令删掉
				List<ParamForM6> list = new ArrayList<ParamForM6>();
				for (ParamForM6 p6 : paramM6) {
					if (p6 != null) {
						List<Backup> backUpList = p6.getBackups();
						if (backUpList != null && backUpList.size() > 0) {// 判断是否有备份参数
							list.add(p6);
						}

					}
				}
				paramM6 = list;
			}

		} catch (Exception e) {
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');this.location='nmsTaskManager.do?action=query'</script>");
			e.printStackTrace();
		}
	}

	/**
	 * 
	 * 根据任务id得到任务信息，且将业务系统、用户组等的名称查询出来，用于前台的显示
	 * 
	 * @author hyx Mar 13, 2012
	 * @version 1.0
	 * @param missionId
	 * @return
	 */
	private MissionStateTable getMissionStateTableForShow(Long missionId) {
		MissionStateTable mission = null;
		try {
			mission = (MissionStateTable) this.commonService.get(MissionStateTable.class, missionId);
			// 补全系统名称、节点组名称信息
			if (mission != null) {
				if (mission.getSystemId() != null) {
					if(mission.getSystemId() == -1){
						mission.setSystemIdName("ALL");
					}else{
						SystemTable systemTable = (SystemTable) this.commonService.get(SystemTable.class,
								mission.getSystemId());
						if (systemTable != null) {
							mission.setSystemIdName(systemTable.getSystemName());
						}
						if (mission.getGroupId() != null) {
							XtJsJbxx xtJsJbxx = (XtJsJbxx) this.commonService.get(XtJsJbxx.class, mission.getGroupId());
							if (xtJsJbxx != null) {
								mission.setGroupIdName(xtJsJbxx.getJsmc());
							}
						}
					}
				}
				// 补全用户组信息
				XtYhJbxx xtyhjbxx = (XtYhJbxx) this.commonService.get(XtYhJbxx.class, mission.getUserId());
				if (xtyhjbxx != null) {
					mission.setUserIdName(xtyhjbxx.getYhmc());
				}
			}
		} catch (Exception e) {
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');this.location='nmsTaskManager.do?action=query'</script>");
			e.printStackTrace();
		}
		return mission;
	}

	private String getNodeGroupNames(String nodeGroupIds) {
		String nodeGroupNames = "";
		if (nodeGroupIds != null && !"".equals(nodeGroupIds.trim())) {
			try {
				NodegroupTable nodegroupTable = null;
				String[] idGroup = nodeGroupIds.split(",");
				for (String nodeId : idGroup) {
					nodegroupTable = (NodegroupTable) this.commonService.get(NodegroupTable.class,
							Long.valueOf(nodeId));
					if (nodegroupTable != null) {
						nodeGroupNames += nodegroupTable.getGroupName() + ",";
					}
				}
				if (nodeGroupNames.endsWith(",")) {
					nodeGroupNames = nodeGroupNames.substring(0, nodeGroupNames.length() - 1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return nodeGroupNames;
	}

	private String getNodeNames(String nodeIds) {
		String nodeGroupNames = "";
		if (nodeIds != null && !"".equals(nodeIds.trim())) {
			try {
				NodeTable nodeTable = null;
				String[] idGroup = nodeIds.split(",");
				for (String nodeId : idGroup) {
					nodeTable = (NodeTable) this.commonService.get(NodeTable.class, Long.valueOf(nodeId));
					if (nodeTable != null) {
						// nodeGroupNames += nodeTable.getNodeName()+",";
						nodeGroupNames += nodeTable.getNodeIp() + ",";
					}
				}
				if (nodeGroupNames.endsWith(",")) {
					nodeGroupNames = nodeGroupNames.substring(0, nodeGroupNames.length() - 1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return nodeGroupNames;
	}

	/**
	 * 
	 * 文件推送：根据任务id，获得任务参数，并取得节点组名称，用于前台显示
	 * 
	 * @author hyx Mar 13, 2012
	 * @version 1.0
	 * @param missionId
	 * @return
	 */
	private MissionParameterTable1 getMissionParameterTable1ForShow(Long missionId, boolean isView) {
		MissionParameterTable1 param1 = null;
		try {
			param1 = (MissionParameterTable1) this.commonService.get(MissionParameterTable1.class, missionId);
			if (param1 != null) {

				if (!isView) {
					// 校验节点组和节点的有效性
					List<Object> ngtList1 = this.commonService
							.find("select ngt.groupId from NodegroupTable ngt where ngt.isValid=1 and ngt.groupId in ("
									+ param1.getNodeGroupsId() + ")");
					if (ngtList1.size() > 0) {
						StringBuffer groupIds = new StringBuffer();
						for (int i = 0; i < ngtList1.size(); i++) {
							groupIds.append(ngtList1.get(i) + ",");
						}
						groupIds.deleteCharAt(groupIds.length() - 1);
						param1.setNodeGroupsId(groupIds.toString());
					} else {
						param1.setNodeGroupsId(null);
						param1.setNodeIpsId(null);
					}

					if (param1.getNodeIpsId() != null && param1.getNodeIpsId().length() > 0) {

						List<Object> ntList = this.commonService
								.find("select nt.nodeId from NodeTable nt where nt.nodeState=0 and nt.groupId in ("
										+ param1.getNodeGroupsId() + ") and nt.nodeId in (" + param1.getNodeIpsId()
										+ ")");
						if (ntList.size() > 0) {
							StringBuffer nodeIds = new StringBuffer();
							for (int i = 0; i < ntList.size(); i++) {
								nodeIds.append(ntList.get(i) + ",");
							}
							nodeIds.deleteCharAt(nodeIds.length() - 1);
							param1.setNodeIpsId(nodeIds.toString());
						} else {
							param1.setNodeIpsId(null);
						}
					}

				}

				String nodeGroupIds = param1.getNodeGroupsId();
				param1.setNodeListName(getNodeGroupNames(nodeGroupIds));

				String nodeIpsStr = param1.getNodeIpsId();
				param1.setNodeListName2(getNodeNames(nodeIpsStr));
			}

		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');this.location='nmsTaskManager.do?action=query'</script>");
		}
		return param1;
	}

	/**
	 * 
	 * 命令执行：根据任务id ，取得任务参数信息，并取得命令名称、节点组名称，便于前台显示
	 * 
	 * @author hyx Mar 13, 2012
	 * @version 1.0
	 * @param missionId
	 * @return
	 */
	private MissionParameterTable4 getMissionParameterTable4ForShow(Long missionId, boolean isView) {
		MissionParameterTable4 param4 = null;
		OrderTable ordertable = null;
		try {
			param4 = (MissionParameterTable4) this.commonService.get(MissionParameterTable4.class, missionId);
			if (param4 != null) {
				if (!isView) {
					// 校验节点组和节点的有效性
					List<Object> ngtList4 = this.commonService
							.find("select ngt.groupId from NodegroupTable ngt where ngt.isValid=1 and ngt.groupId in ("
									+ param4.getNodeGroupsId() + ")");
					if (ngtList4.size() > 0) {
						StringBuffer groupIds = new StringBuffer();
						for (int i = 0; i < ngtList4.size(); i++) {
							groupIds.append(ngtList4.get(i) + ",");
						}
						groupIds.deleteCharAt(groupIds.length() - 1);
						param4.setNodeGroupsId(groupIds.toString());
					} else {
						param4.setNodeGroupsId(null);
						param4.setNodeIpsId(null);
					}

					if (param4.getNodeIpsId() != null && param4.getNodeIpsId().length() > 0) {

						List<Object> ntList = this.commonService
								.find("select nt.nodeId from NodeTable nt where nt.nodeState=0 and nt.groupId in ("
										+ param4.getNodeGroupsId() + ") and nt.nodeId in (" + param4.getNodeIpsId()
										+ ")");
						if (ntList.size() > 0) {
							StringBuffer nodeIds = new StringBuffer();
							for (int i = 0; i < ntList.size(); i++) {
								nodeIds.append(ntList.get(i) + ",");
							}
							nodeIds.deleteCharAt(nodeIds.length() - 1);
							param4.setNodeIpsId(nodeIds.toString());
						} else {
							param4.setNodeIpsId(null);
						}
					}
				}

				// ordertable = (OrderTable)
				// this.commonService.get(OrderTable.class,
				// param4.getCommandId());
				ordertable = getOrder(param4.getCommandEName());
				param4.setCommandName(ordertable != null ? ordertable.getCommandAlias() : null);
				param4.setCommandEName(ordertable != null ? ordertable.getCommandName() : null);// 12.26
																								// 新增
																								// 用于判断
				String nodeGroupIds = param4.getNodeGroupsId();
				param4.setNodeListName(getNodeGroupNames(nodeGroupIds));

				String nodeIpsStr = param4.getNodeIpsId();
				param4.setNodeListName2(getNodeNames(nodeIpsStr));

			}
		} catch (Exception e) {
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');this.location='nmsTaskManager.do?action=query'</script>");
			e.printStackTrace();
		}
		return param4;
	}

	/**
	 * 
	 * 升级部署：根据任务id，取得任务参数信息，并取得命令名称、节点组名称，便于前台显示
	 * 
	 * @author hyx Mar 13, 2012
	 * @version 1.0
	 * @param missionId
	 * @return
	 */
	private MissionParameterTable6 getMissionParameterTable6ForShow(Long missionId, boolean isView) {
		MissionParameterTable6 param6 = null;
		OrderTable ordertable = null;
		try {
			param6 = (MissionParameterTable6) this.commonService.get(MissionParameterTable6.class, missionId);
			if (param6 != null) {
				if (!isView) {
					// 校验节点组和节点的有效性
					List<Object> ngtList6 = this.commonService
							.find("select ngt.groupId from NodegroupTable ngt where ngt.isValid=1 and ngt.groupId in ("
									+ param6.getNodeGroupsId() + ")");
					if (ngtList6.size() > 0) {
						StringBuffer groupIds = new StringBuffer();
						for (int i = 0; i < ngtList6.size(); i++) {
							groupIds.append(ngtList6.get(i) + ",");
						}
						groupIds.deleteCharAt(groupIds.length() - 1);
						param6.setNodeGroupsId(groupIds.toString());
					} else {
						param6.setNodeGroupsId(null);
						param6.setNodeIpsId(null);
					}

					if (param6.getNodeIpsId() != null && param6.getNodeIpsId().length() > 0) {

						List<Object> ntList = this.commonService
								.find("select nt.nodeId from NodeTable nt where nt.nodeState=0 and nt.groupId in ("
										+ param6.getNodeGroupsId() + ") and nt.nodeId in (" + param6.getNodeIpsId()
										+ ")");
						if (ntList.size() > 0) {
							StringBuffer nodeIds = new StringBuffer();
							for (int i = 0; i < ntList.size(); i++) {
								nodeIds.append(ntList.get(i) + ",");
							}
							nodeIds.deleteCharAt(nodeIds.length() - 1);
							param6.setNodeIpsId(nodeIds.toString());
						} else {
							param6.setNodeIpsId(null);
						}
					}
				}

				// ordertable = (OrderTable)
				// this.commonService.get(OrderTable.class,
				// param6.getCommandId());
				ordertable = getOrder(param6.getCommandEName());
				param6.setCommandName(ordertable != null ? ordertable.getCommandAlias() : null);
				param6.setCommandEName(ordertable != null ? ordertable.getCommandName() : null);// 12.26新增
																								// 用于判断
				String nodeGroupIds = param6.getNodeGroupsId();
				param6.setNodeListName(getNodeGroupNames(nodeGroupIds));

				String nodeIpsStr = param6.getNodeIpsId();
				param6.setNodeListName2(getNodeNames(nodeIpsStr));
			}
		} catch (Exception e) {
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');this.location='nmsTaskManager.do?action=query'</script>");
			e.printStackTrace();
		}
		return param6;
	}

	/**
	 * 
	 * 将文件推送的参数转换为ParamForM1对象列表，以便前台显示相应信息
	 * 
	 * @author hyx Mar 14, 2012
	 * @version 1.0
	 * @param misParamTab1
	 * @return
	 */
	private List<ParamForM1> getParamForM1ForShow(MissionParameterTable1 misParamTab1) throws Exception {
		List<ParamForM1> paramM1 = new ArrayList<ParamForM1>();
		if (misParamTab1 != null) {
			String missComd = misParamTab1.getCommandPara();
			if (StringUtils.isNotEmpty(missComd)) {
				String[] params = missComd.split(PARAM_SEPRATOR);
				paramM1 = new ArrayList<ParamForM1>();
				for (String param : params) {
					if (StringUtils.isEmpty(param.trim())) {
						continue;
					}
					param = param.replaceAll("\n", "");
					param = param.replaceAll("\r", "");
					param = param.replaceAll("\t", "");

					ParamForM1 paramForM1 = (ParamForM1) JSONObject.toBean(JSONObject.fromObject(param.trim()),
							ParamForM1.class);
					if (paramForM1.getParam1() != null && paramForM1.getParam1().trim().length() > 0) {// 密码解密
						paramForM1.setParam1(DESUtil.desDecrypt(paramForM1.getParam1().trim()));
					}
					paramM1.add(paramForM1);
				}
			}
		}
		return paramM1;
	}

	/**
	 * 
	 * 将命令执行的参数转换为ParamForM1对象列表，以便前台显示相应信息
	 * 
	 * @author hyx Mar 14, 2012
	 * @version 1.0
	 * @param misParamTab4
	 * @return
	 */
	private List<ParamForM4> getParamForM4ForShow(MissionParameterTable4 misParamTab4) throws Exception {
		List<ParamForM4> paramM4 = new ArrayList<ParamForM4>();
		if (misParamTab4 != null) {
			String missComd = misParamTab4.getCommandPara();
			if (StringUtils.isNotEmpty(missComd)) {
				String[] params = missComd.split(PARAM_SEPRATOR);
				paramM4 = new ArrayList<ParamForM4>();
				for (String param : params) {
					if (StringUtils.isEmpty(param.trim())) {
						continue;
					}
					param = param.replaceAll("\n", "");
					param = param.replaceAll("\r", "");
					param = param.replaceAll("\t", "");
					// Long commandId = missionparameteriable4.getCommandId();
					String commandEnameString = missionparameteriable4.getCommandEName();
					ParamForM4 paramForM4 = new ParamForM4();
					// if(commandId.intValue()!=2)
					// {//非停用进程命令，因为停用进程命令在数据库中存储的方式是a;b;c，其它命令是{"name":"hyx"};{};
					// 要求不使用commandid，使用commandname作为关联标识使用sequence
					if (!"upgrade_kill_process".equals(commandEnameString)) {// 非停用进程命令，因为停用进程命令在数据库中存储的方式是a;b;c，其它命令是{"name":"hyx"};{};
						paramForM4 = (ParamForM4) JSONObject.toBean(JSONObject.fromObject(param.trim()),
								ParamForM4.class);
					} else {
						paramForM4.setPidFile(param);
					}

					// 将字符串数组用分号连接成一个字符串，便于前台显示
					paramForM4.setExceptTmpStr(StringUtils.join(paramForM4.getExcept(), STR_PARAM_SEPRATOR));// 备份操作：排除文件字符串
					paramForM4.setExecParamsTmpStr(StringUtils.join(paramForM4.getExecParams(), STR_PARAM_SEPRATOR));// 启动和可执行命令操作：启动参数字符串
					paramForM4.setDeleteTmpStr(StringUtils.join(paramForM4.getDelete(), STR_PARAM_SEPRATOR));// 覆盖更新和恢复操作：删除文件字符串

					if (paramForM4.getParam1() != null && paramForM4.getParam1().trim().length() > 0) {// 密码解密
						paramForM4.setParam1(DESUtil.desDecrypt(paramForM4.getParam1().trim()));
					}

					paramM4.add(paramForM4);
				}
			}
		}
		return paramM4;
	}

	/**
	 * 
	 * 将升级部署的参数转换为ParamForM1对象列表，以便前台显示相应信息
	 * 
	 * @author hyx Mar 14, 2012
	 * @version 1.0
	 * @param misParamTab4
	 * @return
	 */
	private List<ParamForM6> getParamForM6ForShow(MissionParameterTable6 misParamTab6) throws Exception {
		List<ParamForM6> paramM6 = new ArrayList<ParamForM6>();
		if (misParamTab6 != null) {
			String missComd = misParamTab6.getCommandPara();
			if (StringUtils.isNotEmpty(missComd)) {
				String[] params = missComd.split(PARAM_SEPRATOR);
				paramM6 = new ArrayList<ParamForM6>();
				for (String param : params) {
					if (StringUtils.isEmpty(param.trim())) {
						continue;
					}
					param = param.replaceAll("\n", "");
					param = param.replaceAll("\r", "");
					param = param.replaceAll("\t", "");

					ParamForM6 paramForM6 = (ParamForM6) JSONObject.toBean(JSONObject.fromObject(param.trim()),
							ParamForM6.class);
					// 转换Backup对象
					List<Backup> backUps = paramForM6.getBackups();
					if (backUps != null) {
						List<Backup> backUpsCopy = new ArrayList<Backup>();
						for (Object bp : backUps) {
							Backup backup = (Backup) JSONObject.toBean(JSONObject.fromObject(bp), Backup.class);
							if (backup != null) {
								backup.setExceptTmpStr(StringUtils.join(backup.getExcept(), STR_PARAM_SEPRATOR));// 将备份的排除文件数组转换为用分号连接的字符串
								backUpsCopy.add(backup);
							}

						}
						paramForM6.getBackups().clear();
						paramForM6.getBackups().addAll(backUpsCopy);
					}
					// 转换CoverUpdate对象
					List<CoverUpdate> recoverys = paramForM6.getRecoverys();
					if (recoverys != null) {
						List<CoverUpdate> recoverysCopy = new ArrayList<CoverUpdate>();
						for (Object recovery : recoverys) {
							CoverUpdate cover = (CoverUpdate) JSONObject.toBean(JSONObject.fromObject(recovery),
									CoverUpdate.class);
							if (cover != null) {
								cover.setDeleteTmpStr(StringUtils.join(cover.getDelete(), STR_PARAM_SEPRATOR));// 将恢复的删除文件数组转换为用分号连接的字符串
								recoverysCopy.add(cover);
							}
						}
						paramForM6.getRecoverys().clear();
						paramForM6.getRecoverys().addAll(recoverysCopy);
					}

					paramForM6.setDeleteTmpStr(StringUtils.join(paramForM6.getDelete(), STR_PARAM_SEPRATOR));// 将-删除文件-转换为有分号隔开的字符串，赋值给deleteTmpStr
					paramForM6.setExecParamsTmpStr(StringUtils.join(paramForM6.getExecParams(), STR_PARAM_SEPRATOR));// 启动参数字符串

					if (paramForM6.getParam1() != null && paramForM6.getParam1().trim().length() > 0) {// 密码解密
						paramForM6.setParam1(DESUtil.desDecrypt(paramForM6.getParam1().trim()));
					}

					paramM6.add(paramForM6);
				}
			}
		}
		return paramM6;
	}

	/*
	 * public String getCommondnameByType(){ StringBuilder out = new
	 * StringBuilder(); String commontype =
	 * this.getRequest().getParameter("commontype"); // 查询命令 try {
	 * ordertablelist = this.commonService
	 * .find("from OrderTable  o  where  o.commandType="+commontype);
	 * out.append("<response>"); for(OrderTable ordertable:ordertablelist){
	 * out.append("<commond>"); out.append("<id>" + ordertable.getCommandId() +
	 * "</id>"); out.append("<name>" + ordertable.getCommandName() + "</name>");
	 * out.append("</commond>"); } out.append("</response>"); // ajax的输出
	 * this.getResponse().setContentType("application/xml");
	 * this.getResponse().setCharacterEncoding("utf-8");
	 * this.getResponse().setHeader("Cache-Control", "no-cache"); PrintWriter pw
	 * = this.getResponse().getWriter(); pw.write(out.toString()); pw.close(); }
	 * catch (Exception e) { e.printStackTrace(); } return null; }
	 */

	public void showTP() throws IOException {
		NodeTree nt = new NodeTree();

		Node n1 = new Node();

		n1.setId("1");

		n1.setFatherId("0");

		n1.setName(getI18nText("i18n_NmsTaskManagerAction.executeAction.root_n81i"));

		n1.setState(0);

		n1.setUrl("images/topic.gif");

		nt.getNodeList().add(n1);

		// --------------------------------------

		Node n2 = new Node();

		n2.setId("2");

		n2.setFatherId("1");

		n2.setName(getI18nText("i18n_NmsTaskManagerAction.executeAction.secondNode_n81i"));

		n2.setState(0);

		n2.setUrl("images/nm.gif");

		nt.getNodeList().add(n2);

		// --------------------------------------

		Node n3 = new Node();

		n3.setId("3");

		n3.setFatherId("1");

		n3.setName(getI18nText("i18n_NmsTaskManagerAction.executeAction.secondNode_n81i"));

		n3.setState(0);

		n3.setUrl("images/nm.gif");

		nt.getNodeList().add(n3);

		// --------------------------------------

		Node n4 = new Node();

		n4.setId("4");

		n4.setFatherId("2");

		n4.setName(getI18nText("i18n_NmsTaskManagerAction.executeAction.thirdNode_n81i"));

		n4.setState(0);

		n4.setUrl("images/sensor.gif");

		nt.getNodeList().add(n4);

		// --------------------------------------

		Node n5 = new Node();

		n5.setId("5");

		n5.setFatherId("2");

		n5.setName(getI18nText("i18n_NmsTaskManagerAction.executeAction.thirdNode_n81i"));

		n5.setState(1);

		n5.setUrl("images/sensor.gif");

		nt.getNodeList().add(n5);

		Node n6 = new Node();

		n6.setId("6");

		n6.setFatherId("3");

		n6.setName(getI18nText("i18n_NmsTaskManagerAction.executeAction.thirdNode_n81i"));

		n6.setState(1);

		n6.setUrl("images/sensor.gif");

		nt.getNodeList().add(n6);

		// ------------------------------------------------
		HttpServletResponse response = getResponse();
		response.reset();
		response.setCharacterEncoding("UTF-8");

		response.setContentType("application/json");

		response.getWriter().print(JSONObject.fromObject(nt).toString());
	}

	public void updateDate() {
		try {
			commonService.beginTransaction();
			if (missionstatetable.getMissionType() == 1) {// 文件推送
				MissionStateTable missionstate = (MissionStateTable) this.commonService.get(MissionStateTable.class,
						missionstatetable.getMissionId());
				MissionParameterTable1 parameter = (MissionParameterTable1) this.commonService
						.get(MissionParameterTable1.class, missionstatetable.getMissionId());
				if (missionstatetable.getMissionName() != null) {
					missionstate.setMissionName(missionstatetable.getMissionName());
				}
				if (missionstatetable.getSystemId() != null) {
					missionstate.setSystemId(missionstatetable.getSystemId());
				}
				if (missionstatetable.getViewLevel() != null) {
					missionstate.setViewLevel(missionstatetable.getViewLevel());
				}
				if (missionstatetable.getGroupId() != null) {
					missionstate.setGroupId(missionstatetable.getGroupId());
				}
				// 更新任务
				this.commonService.update(missionstate);

				// 将更新操作写到操作日志中
				this.addDBOperationRpt(commonService, "mission_state_table", "UPDATE",
						missionstatetable.getMissionId());

				if (this.sourcePath != null) {
					String uploadFilePath = getConfigValue("uploadServerPath");
					String urlPath = getConfigValue("downLoadPath");
					sourcePathFileName = Common.addTimeTagForUploadFileName(sourcePathFileName);
					String fileName = uploadFilePath + File.separator + sourcePathFileName;
					urlPath += sourcePath;
					String fenString = System.getProperty("file.encoding");
					System.out.println(fenString);
					fileName = new String(fileName.getBytes(), fenString);
					// 将文件从临时文件夹复制到指定目录下
					this.copy(sourcePath, new File(fileName));
					parameter.setSourcePath(sourcePathFileName);
				}
				if (missionparametertable1.getTargetPath() != null) {
					parameter.setTargetPath(missionparametertable1.getTargetPath());
				}
				if (missionparametertable1.getNodeListId() != null) {
					parameter.setNodeListId(missionparametertable1.getNodeListId());
				}
				if (missionparametertable1.getMissionDesc() != null) {
					parameter.setMissionDesc(missionparametertable1.getMissionDesc());
				}
				// 更新参数
				this.commonService.update(parameter);
				// 将更新操作写到操作日志中
				this.addDBOperationRpt(commonService, "mission_parameter_table1", "UPDATE",
						missionstatetable.getMissionId());
			}
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');this.location='nmsTaskManager.do?action=query'</script>");
		}
		outHtmlString(
				"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.success_n81i');this.location='nmsTaskManager.do?action=query'</script>");
	}

	/**
	 * <p>
	 * 改变任务状态（启用停用定时任务）
	 * <p>
	 * 状态 1 ： 已创建
	 * <p>
	 * 状态 5 ： 准备撤销
	 * <p>
	 * 状态 6 ： 撤销中
	 * <p>
	 * 状态 7 ： 撤销完成
	 * 
	 * @time Mar 21, 2012-9:58:39 AM
	 * @return
	 */
	public String updateState() {
		try {
			commonService.beginTransaction();
			// - 状态变更操作标识 1(已创建) <--> (准备撤销)5
			String curstate = this.getRequest().getParameter("curstate");

			// - 校验操作标识 标识为空无法操作
			if (StringUtils.isEmpty(curstate)) {
				outHtmlString(
						"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.missionStateError_n81i');this.location='nmsTaskManager.do?action=query&pageNo="
								+ pageNo + "&pageSize=" + pageSize + "'</script>");
				return null;
			}

			// - 区分停用启用操作 1启动 5 停用
			long changeState = Long.parseLong(curstate); // 变更状态

			// - 变更各任务状态 并整理任务信息
			if (pid != null && pid.length > 0) {

				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

				for (int i = 0; i < pid.length; i++) {

					// -- 获取旧任务信息
					MissionStateTable table = (MissionStateTable) this.commonService.get(MissionStateTable.class,
							pid[i]);

					// -- 检查任务是否变更
					if ((table.getMissionState().longValue() >= 5 && changeState == 5)
							|| (table.getMissionState().longValue() < 5 && changeState == 1)) {
						continue;
					}
					// -- 检查任务变更是否有效
					if (table.getEndTime().getTime() < System.currentTimeMillis()) {
						outHtmlString("<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.missionExpire_n81i');"
								+ "this.location='nmsTaskManager.do?action=query&pageNo=" + pageNo + "&pageSize="
								+ pageSize + "'</script>");
						return null;
					}

					// -- 任务状态变更
					String datePoint = dateFormat.format(System.currentTimeMillis());
					table.setMissionState(changeState);
					System.out.println("-------------------0 " + datePoint);
					table.setAutoDesc(datePoint + getI18nText("i18n_NmsTaskManagerAction.executeAction.miessionState_n81i") + (changeState == 5l ? getI18nText("i18n_NmsTaskManagerAction.executeAction.stop_n81i") : getI18nText("i18n_NmsTaskManagerAction.executeAction.alive_n81i")));

					this.commonService.update(table);
					// -- 任务周期 任务结果信息清理
					if (changeState == 5l) { // 任务置为停用

						// - 将正在进行（2）的任务周期设置为已完成（3）
						this.commonService.updateByHql(
								"update LoopmissionStateTable lmst set lmst.missionState ='3' where lmst.missionState='2' and lmst.missionId=? ",
								pid[i]);

					} else { // 任务置为启用

						// - 重置任务启动时间
						this.commonService.updateByHql(
								"update MissionStateTable mst set mst.startTime = sysdate where mst.missionId=? ",
								pid[i]);

						// - 检查当前时间点的周期，变更该周期的结束时间为当前时间点
						// - 将撤销周期的周期状态设置为已撤销（7）
						this.commonService.updateByHql(
								"update LoopmissionStateTable lmst set lmst.endTime = sysdate  where lmst.startTime<=sysdate and lmst.endTime>sysdate and lmst.missionId=? ",
								pid[i]);
						this.commonService.updateByHql(
								"update LoopmissionStateTable lmst set lmst.missionState ='7' where lmst.missionState in (5,6) and lmst.missionId=? ",
								pid[i]);
					}

					// 将更新操作写到操作日志中
					this.addDBOperationRpt(commonService, "mission_state_table", "UPDATE", pid[i]);
					commonService.commit();
					sendMissionInfoId(pid[i], 0l, commonService);
					// sendMissionInfoId(missionstatetable.getMissionId(),1l);
				}
				outHtmlString("<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.success_n81i');"
						+ "this.location='nmsTaskManager.do?action=query&pageNo=" + pageNo + "&pageSize=" + pageSize
						+ "'</script>");
			} else {
				outHtmlString("<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.selectMission_n81i');"
						+ "this.location='nmsTaskManager.do?action=query&pageNo=" + pageNo + "&pageSize=" + pageSize
						+ "'</script>");
			}
			
		} catch (Exception e) {
			commonService.rollback();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');"
					+ "this.location='nmsTaskManager.do?action=query&pageNo=" + pageNo + "&pageSize=" + pageSize
					+ "'</script>");
			e.printStackTrace();
			return "error";
		}
		return null;
	}

	// public void updateStateold() {
	// String curstate = this.getRequest().getParameter("curstate");
	// String missionId = this.getRequest().getParameter("missionId");
	// if (curstate == null || "".equals(curstate)) {
	// outHtmlString("<script
	// type=\"text/javascript\">alert('任务状态异常！');this.location='nmsTaskManager.do?action=query'</script>");
	// }
	// if (missionId == null || "".equals(missionId)) {
	// outHtmlString("<script
	// type=\"text/javascript\">alert('任务不存在！');this.location='nmsTaskManager.do?action=query'</script>");
	// }
	// try {
	// missionstatetable = (MissionStateTable) this.commonService.get(
	// MissionStateTable.class, Long.valueOf(missionId));
	// // missionstatetable.setloopFlag(Long.valueOf(curstate));
	// if ("5".equals(curstate)) {
	// missionstatetable.setMissionState(0L);
	// } else {
	// missionstatetable.setMissionState(5L);
	// }
	// // 更新任务状态
	// this.commonService.update(missionstatetable);
	// } catch (Exception e) {
	// e.printStackTrace();
	// outHtmlString("<script
	// type=\"text/javascript\">alert('操作失败！');this.location='nmsTaskManager.do?action=query'</script>");
	// }
	// outHtmlString("<script
	// type=\"text/javascript\">alert('操作成功！');this.location='nmsTaskManager.do?action=query'</script>");
	// }

	public String toEditepage() {
		String returnpage = null;
		String type = this.getRequest().getParameter("type");
		String missionId = this.getRequest().getParameter("missionId");
		try {
			missionstatetable = (MissionStateTable) this.commonService.get(MissionStateTable.class,
					Long.valueOf(missionId));
			// 推送文件
			if ("1".equals(type)) {
				// 查询参数
				missionparametertable1 = (MissionParameterTable1) this.commonService.get(MissionParameterTable1.class,
						Long.valueOf(missionId));
				if (missionparametertable1.getSourcePath() != null
						&& missionparametertable1.getSourcePath().split("_").length > 0) {
					missionparametertable1.setSourcePath(missionparametertable1.getSourcePath().split("_")[0]);
				}
				if (missionparametertable1 != null) {
					nodegrouptable = (NodegroupTable) this.commonService.get(NodegroupTable.class,
							missionparametertable1.getNodeListId());
					xtjsjbxx = (XtJsJbxx) this.commonService.get(XtJsJbxx.class, missionstatetable.getGroupId());
				}
				returnpage = "editnmsparam1";
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');this.location='nmsTaskManager.do?action=query'</script>");
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');this.location='nmsTaskManager.do?action=query'</script>");
		}
		return returnpage;
	}

	public void downloadfile() {
		String downloadfileName = this.getRequest().getParameter("loadfileName");
		String missionId = this.getRequest().getParameter("missionId");
		String roundId = this.getRequest().getParameter("curMissionId");
		String tabs = this.getRequest().getParameter("tabs");
		String result = this.getRequest().getParameter("result");
		String strPath = "nmsTaskManager!executeAction.do?action=searchResults&missionId=" + missionId
				+ "&curMissionId=" + roundId + "&tabs=" + tabs + "&result=" + result;
		this.downLoad(downloadfileName, strPath);
	}

	public void misssionInfoDownLoad() {
		String downloadfileName = this.getRequest().getParameter("loadfileName");
		String missionId = this.getRequest().getParameter("missionId");
		String strPath = "nmsTaskManager.do?action=viewMission&missionType=" + missionType + "&missionState="
				+ missionState + "&loopFlag=" + loopFlag + "&missionName=" + missionName + "&missionId=" + missionId
				+ "&pageNo=" + pageNo + "&pageSize=" + pageSize;
		this.downLoad(downloadfileName, strPath);
	}

	// 查看结果
	public String getResultInfo() {
		String returnpage = null;
		String missionId = this.getRequest().getParameter("missionId");
		this.getRequest().setAttribute("from", from);
		try {
			if (StringUtils.isNotEmpty(missionId)) {
				// 查询任务
				missionstatetable = (MissionStateTable) this.commonService.get(MissionStateTable.class,
						Long.valueOf(missionId));
				// 补全系统名称、节点组名称信息
				if (missionstatetable != null) {
					if (missionstatetable.getSystemId() != null) {
						SystemTable systemTable = (SystemTable) this.commonService.get(SystemTable.class,
								missionstatetable.getSystemId());
						if (systemTable != null) {
							missionstatetable.setSystemIdName(systemTable.getSystemName());
						}
						if (missionstatetable.getGroupId() != null) {
							XtJsJbxx xtJsJbxx = (XtJsJbxx) this.commonService.get(XtJsJbxx.class,
									missionstatetable.getGroupId());
							if (xtJsJbxx != null) {
								missionstatetable.setGroupIdName(xtJsJbxx.getJsmc());
							}
						}
					}
					// 补全用户组信息
					XtYhJbxx xtyhjbxx = (XtYhJbxx) this.commonService.get(XtYhJbxx.class,
							missionstatetable.getUserId());
					if (xtyhjbxx != null) {
						missionstatetable.setUserIdName(xtyhjbxx.getYhmc());
					}
				}

				MissionStateTable mm = (MissionStateTable) this.commonService.get(MissionStateTable.class,
						Long.valueOf(missionId));
				String lookUser = "";
				if (mm.getLookUserIds() == null || "".equals(mm.getLookUserIds())) {
					lookUser = this.getUserID() + "";
				} else if (!mm.getLookUserIds().equals(this.getUserID() + "")
						&& !mm.getLookUserIds().startsWith(this.getUserID() + ",")
						&& !mm.getLookUserIds().endsWith("," + this.getUserID())
						&& !mm.getLookUserIds().contains("," + this.getUserID() + ",")) {
					lookUser = mm.getLookUserIds() + "," + this.getUserID();
				} else {
					lookUser = mm.getLookUserIds();
				}

				// 更新是否查看状态
				String sql = "";
				if (mm.getUserId().equals(this.getUserID())) {
					sql = "update mission_state_table t set t.is_look = '0', t.look_user_id = '" + lookUser
							+ "' where t.mission_id = " + missionId;
				} else {
					sql = "update mission_state_table t set t.look_user_id = '" + lookUser + "' where t.mission_id = "
							+ missionId;
				}
				this.commonService.updateBySql(sql);
			}
			returnpage = "statistics";
		} catch (Exception e) {
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');this.location='nmsTaskManager.do?action=query'</script>");
			e.printStackTrace();
			logger.info("查看结果失败", e);
		}
		return returnpage;
	}

	/**
	 * 
	 * 查看所有类型的任务信息（普通任务：文件推送、命令执行、升级部署，逆向任务）
	 * 
	 * @author hyx Mar 22, 2012
	 * @version 1.0
	 * @return
	 */
	public String getAllMissionInfo() {
		String returnPage = "";
		// 根据任务Id及类型，如果是升级部署，且是逆向任务，则一个方法，否则用另一个方法
		String missionId = this.getRequest().getParameter("missionId");
		this.getRequest().setAttribute("missionId", missionId);
		if (StringUtils.isNotEmpty(missionId)) {
			if (isConverseMiss(missionId)) {// 逆向任务的查看
				getConverseMissInfo(missionId);
				returnPage = "converseMissionDetail";
			} else {// 普通任务的查看
				returnPage = getmissionInfo();
			}
		}
		return returnPage;
	}

	/**
	 * 
	 * 判断任务是否为逆向任务：升级部署+version字段非空
	 * 
	 * @author hyx Mar 22, 2012
	 * @version 1.0
	 * @param missionId
	 * @return
	 */
	private boolean isConverseMiss(String missionId) {
		boolean isConverse = false;
		if (StringUtils.isNotEmpty(missionId)) {
			MissionStateTable miss = getMissionStateTableForShow(Long.valueOf(missionId));
			if (miss != null && miss.getMissionType().intValue() == 6) {// 是否升级部署
				MissionParameterTable6 missParam6 = getMissionParameterTable6ForShow(Long.valueOf(missionId), true);
				if (missParam6 != null) {
					Long version = missParam6.getVersion();
					if (version != null) {
						isConverse = true;
					}
				}
			}
		}
		return isConverse;
	}

	/**
	 * 
	 * 得到逆向任务的详细信息
	 * 
	 * @author hyx Mar 22, 2012
	 * @version 1.0
	 */
	public void getConverseMissInfo(String missionId) {
		try {
			if (StringUtils.isNotEmpty(missionId)) {
				missionstatetable = getMissionStateTableForShow(Long.valueOf(missionId));
				missionparametertable6 = getMissionParameterTable6ForShow(Long.valueOf(missionId), true);
				paramM6 = getParamForM6ForShow(missionparametertable6);// 将升级部署的参数转换为ParamForM1对象列表，以便前台显示相应信息
			}
		} catch (Exception e) {
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');this.location='nmsTaskManager.do?action=query'</script>");
			e.printStackTrace();
		}
	}

	// 查看任务
	public String getmissionInfo() {
		String returnpage = null;
		String missionId = this.getRequest().getParameter("missionId");
		try {
			if (StringUtils.isNotEmpty(missionId)) {
				// 查询任务
				missionstatetable = getMissionStateTableForShow(Long.valueOf(missionId));
				/*
				 * //查询周期任务轮次信息 if(missionstatetable.getLoopFlag() != null &&
				 * missionstatetable.getLoopFlag().longValue()== 1l){ //周期任务操作
				 * StringBuffer sql = new StringBuffer(); sql.
				 * append("select lmst.mission_id,lmst.cur_mission_id,to_char(lmst.start_time,'yyyy-mm-dd hh24:mi:ss'),to_char(lmst.end_time,'yyyy-mm-dd hh24:mi:ss'),lmst.mission_state,lmst.fail_desc, "
				 * ); sql.
				 * append("sum(case when mrt4.result = 0 then 1 else 0 end) ok, "
				 * ); sql.
				 * append("sum(case when mrt4.result = 1 then 1 else 0 end) fail, "
				 * ); sql.
				 * append("sum(case when mrt4.result = 3 then 1 else 0 end) push, "
				 * ); sql.
				 * append("sum(case when mrt4.result = 40 then 1 else 0 end) run, "
				 * ); sql.append("sum(1) total ");
				 * sql.append("from mission_result_table4 mrt4 "); sql.
				 * append("left join loopmission_state_table lmst on lmst.cur_mission_id = mrt4.mission_id "
				 * ); sql.append("where 1=1 "); sql.
				 * append("and mrt4.mission_id in(select t.cur_mission_id from loopmission_state_table t where t.mission_id = ?) "
				 * ); sql.
				 * append("group by  lmst.mission_id,lmst.cur_mission_id,lmst.start_time,lmst.end_time,lmst.mission_state,lmst.fail_desc"
				 * ); List<Object []> loopInfolist = (List<Object[]>)
				 * commonService.findByPageForSql(sql.toString(), pageNo,
				 * pageSize, new
				 * Object[]{missionstatetable.getMissionId()}).getResult();
				 * this.getRequest().setAttribute("loopInfolist", loopInfolist);
				 * }
				 */
			}

			// -- 多推送文件
			List<MissionFileInformation> filesList = null;
			if (missionstatetable != null) {
				switch (missionstatetable.getMissionType().intValue()) {
				case 1: // 推送文件
					missionparametertable1 = getMissionParameterTable1ForShow(Long.valueOf(missionId), true);
					paramM1 = getParamForM1ForShow(missionparametertable1);// 将文件推送的参数转换为ParamForM1对象列表，以便前台显示相应信息

					// -- 多推送文件
					filesList = this.commonService.find("from MissionFileInformation t where t.missionId=?",
							Long.valueOf(missionId));
					this.getRequest().setAttribute("filesList", filesList);
					returnpage = "missionstateparameter1";
					break;
				case 4:// 命令执行
					missionparameteriable4 = getMissionParameterTable4ForShow(Long.valueOf(missionId), true);
					paramM4 = getParamForM4ForShow(missionparameteriable4);// 将命令执行的参数转换为ParamForM1对象列表，以便前台显示相应信息

					returnpage = "missionstateparameter4";
					break;
				case 6:// 升级部署
					missionparametertable6 = getMissionParameterTable6ForShow(Long.valueOf(missionId), true);
					paramM6 = getParamForM6ForShow(missionparametertable6);// 将升级部署的参数转换为ParamForM1对象列表，以便前台显示相应信息

					// -- 多推送文件
					filesList = this.commonService.find("from MissionFileInformation t where t.missionId=?",
							Long.valueOf(missionId));
					this.getRequest().setAttribute("filesList", filesList);
					returnpage = "missionstateparameter6";
					break;
				default:
					break;
				}
			}

		} catch (Exception e) {
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');this.location='nmsTaskManager.do?action=query'</script>");
			e.printStackTrace();
		}
		return returnpage;
	}

	// 查看任务执行结果图表
	public String getResultChart() {
		String returnpage = null;
		String missionId = this.getRequest().getParameter("missionId");
		this.getRequest().setAttribute("missionId", missionId);
		String type = this.getRequest().getParameter("type");
		try {
			if (missionId != null && !"".equals(missionId)) {
				// 查询任务
				// missionstatetable = (MissionStateTable)
				// this.commonService.get(
				// MissionStateTable.class, Long.valueOf(missionId));
				if (type.equals("line")) {
					this.getResultLineAndColumnChart();
					returnpage = "resultLineChart";
				} else if (type.equals("column")) {
					this.getResultLineAndColumnChart();
					returnpage = "resultBarChart";
				} else {
					this.getResultPieChart();
					returnpage = "resultPieChart";
				}
			}
		} catch (Exception e) {
			// outHtmlString("<script
			// type=\"text/javascript\">alert('操作失败');self.parent.location='nmsTaskManager.do?action=query'</script>");
			e.printStackTrace();
			logger.info("查看任务执行结果图失败！", e);
		}
		return returnpage;
	}

	// 任务结果统计列表
	public void statisticalResultList() {
		String missionId = this.getRequest().getParameter("missionId");
		try {
			if (StringUtils.isNotEmpty(missionId)) {

				missionstatetable = (MissionStateTable) this.commonService.get(MissionStateTable.class,
						Long.valueOf(missionId));

				if (missionstatetable != null) {
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					// 周期任务查询统计信息
					if (missionstatetable.getLoopFlag() != null && missionstatetable.getLoopFlag().longValue() == 1l) {
						StringBuffer sql = new StringBuffer();
						sql.append(
								"select lmst.mission_id,lmst.cur_mission_id,to_char(lmst.start_time,'yyyy-mm-dd hh24:mi:ss'),to_char(lmst.end_time,'yyyy-mm-dd hh24:mi:ss'),lmst.mission_state,lmst.fail_desc, ");
						sql.append("sum(decode(mrt4.result,0,1,7,1,0)) ok, ");
						sql.append("sum(decode(mrt4.result,1,1,-1,1,6,1,0)) fail, ");
						sql.append("sum(decode(mrt4.result,3,1,5,1,0)) noPush, ");
						sql.append("sum(decode(mrt4.result,40,1,0)) noRelay, ");
						sql.append("count(mrt4.result) total ");// 统计的是结果总数
						sql.append("from loopmission_state_table lmst ");
						sql.append("left join mission_result_table4 mrt4  on lmst.cur_mission_id = mrt4.mission_id ");
						sql.append("where 1=1 ");
						if (startTimeStr != null) {
							sql.append("and lmst.start_time >= to_date('" + format.format(startTimeStr)
									+ "','yyyy-mm-dd hh24:mi:ss') ");
						}
						if (endTimeStr != null) {
							sql.append("and lmst.end_time < to_date('" + format.format(endTimeStr)
									+ "','yyyy-mm-dd hh24:mi:ss') ");
						}
						sql.append("and  lmst.mission_state<>0 and lmst.mission_state<>4 and lmst.mission_id = ? ");
						sql.append(
								"group by  lmst.mission_id,lmst.cur_mission_id,lmst.start_time,lmst.end_time,lmst.mission_state,lmst.fail_desc ");
						sql.append("order by  lmst.cur_mission_id desc, lmst.start_time desc ");// 2015-11-12
																								// 修改：增加按lmst.cur_mission_id
																								// desc,
																								// 排序，因为有数据的cur_mission_id不同，但是开始时间一样（起始不该产生这样的数据，原因有待查找），为了与折线图统计一致

						page = commonService.findByPageForSql(sql.toString(), pageNo, pageSize,
								new Object[] { missionstatetable.getMissionId() });
						List<Object[]> loopInfolist = (List<Object[]>) page.getResult();
						this.getRequest().setAttribute("loopInfolist", loopInfolist);
					}
				} else {
					outHtmlString(
							"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.checkMissionResultFaild_n81i');this.location='nmsTaskManager.do?action=statistic&missionId="
									+ missionId + "'</script>");
					return;
				}
			} else {
				outHtmlString(
						"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');window.parent.location='nmsTaskManager.do?action=statistic&missionId="
								+ missionId + "'</script>");
				return;
			}
		} catch (Exception e) {
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');window.parent.location='nmsTaskManager.do?action=statistic&missionId="
							+ missionId + "'</script>");
			e.printStackTrace();
			logger.info("任务结果统计列表异常！", e);
		}

	}

	// 查看任务执行结果图表
	public void searchResultsList() {
		String missionId = this.getRequest().getParameter("missionId");
		String curMissionId = this.getRequest().getParameter("curMissionId");
		String result = this.getRequest().getParameter("result");
		String ip = this.getRequest().getParameter("ip");

		// String roundId = this.getRequest().getParameter("round");
		this.getRequest().setAttribute("missionId", missionId);
		this.getRequest().setAttribute("curMissionId", curMissionId);
		this.getRequest().setAttribute("result", result);
		this.getRequest().setAttribute("ip", ip);
		// pl("oooo "+roundId);
		try {
			if (StringUtils.isNotEmpty(missionId)) {
				// 查询任务
				missionstatetable = (MissionStateTable) this.commonService.get(MissionStateTable.class,
						Long.valueOf(missionId));
				// 推送文件
				if (new Long(1).equals(missionstatetable.getMissionType())) {
					// 查询参数
					// 根据任务id查询执行结果的信息
					NmstaskManagerHelper help = new NmstaskManagerHelper();
					String sql = "select m.mission_name,nt.node_ip,r.Result,r.result_desc,nt.node_system_type,nt.node_type,r.seq_id from mission_result_table1 r "
							+ "left join mission_state_table m on m.mission_id=r.mission_id "
							+ "left join (select distinct node_ip,seq_id,node_system_type,node_type from node_table n ) nt on nt.seq_id=r.seq_id "
							+ "where r.mission_id=" + missionId + " ";
					if (StringUtils.isNotEmpty(result)) {
						if ("1".equals(result)) {
							sql += " and r.result in (1,-1)";
						} else
							sql += " and r.result=" + result;
					}
					if (StringUtils.isNotEmpty(ip)) {
						sql += " and nt.node_ip like '%" + ip + "%'";
					}
					sql += " order by nt.node_ip asc,r.mission_id asc";
					// resultObjects = help.getTaskResult(this.commonService,
					// sql);
					page = this.commonService.findByPageForSql(sql, pageNo, pageSize);
					resultObjects = (ArrayList<Object[]>) page.getResult();
					missionparametertable1 = (MissionParameterTable1) this.commonService
							.get(MissionParameterTable1.class, Long.valueOf(missionId));
					// if(missionparametertable1 != null){
					// NodegroupTable nodegroupTable = (NodegroupTable)
					// this.commonService.get(NodegroupTable.class,missionparametertable1.getNodeListId());
					// missionparametertable1.setNodeListName(nodegroupTable.getGroupName());
					// }
				} else if (new Long(4).equals(missionstatetable.getMissionType())) {
					// 根据任务id查询执行结果的信息
					String sql = "";
					if (missionstatetable.getLoopFlag() != null && missionstatetable.getLoopFlag().longValue() == 1l) { // 周期任务
						sql = "select m.mission_name, n.node_ip, r.result, r.result_desc, n.node_system_type,n.node_type,r.seq_id, r.file_info,r.mission_id from mission_result_table4 r  "
								+ "left join loopmission_state_table l on l.cur_mission_id = r.mission_id "
								+ "left join mission_state_table m on m.mission_id = l.mission_id  "
								+ "left join mission_parameter_table4 mpt4 on m.mission_id = mpt4.mission_id "
								+ "left join (select distinct node_ip,seq_id,node_system_type,node_type from node_table n ) n on n.seq_id=r.seq_id "
								+ "where 1=1  " + " and l.mission_id =" + missionId + " ";
						if (StringUtils.isNotEmpty(result)) {
							if ("1".equals(result)) {
								sql += " and r.result in (1,-1)";
							} else {
								sql += " and r.result=" + result;
							}
						}
						if (StringUtils.isNotEmpty(curMissionId)) {
							sql += " and r.mission_Id='" + curMissionId + "' ";
						}
						if (StringUtils.isNotEmpty(ip)) {
							sql += " and n.node_ip like '%" + ip + "%'";
						}
						sql += " order by n.node_ip asc,r.mission_id asc";
						if (StringUtils.isNotEmpty(curMissionId)) {
							LoopmissionStateTable loopmissionStateTable = (LoopmissionStateTable) this.commonService
									.get(LoopmissionStateTable.class, Long.parseLong(curMissionId));
							this.getRequest().setAttribute("loopmissionStateTable", loopmissionStateTable);
						}
					} else { // 非周期任务
						sql = "select m.mission_name,nt.node_ip,r.result,r.result_desc, nt.node_system_type,nt.node_type,r.seq_id, r.file_info from mission_result_table4  r "
								+ "left join mission_state_table m on m.mission_id=r.mission_id "
								+ "left join (select distinct node_ip,seq_id,node_system_type,node_type from node_table n ) nt on nt.seq_id=r.seq_id "
								+ "where r.mission_id=" + missionId + " ";
						if (StringUtils.isNotEmpty(result)) {
							if ("1".equals(result)) {
								sql += " and r.result in (1,-1)";
							} else {
								sql += " and r.result=" + result;
							}
						}
						if (StringUtils.isNotEmpty(ip)) {
							sql += " and nt.node_ip like '%" + ip + "%'";
						}
						sql += " order by nt.node_ip asc,r.mission_id asc";
					}
					page = this.commonService.findByPageForSql(sql, pageNo, pageSize);
					resultObjects = (ArrayList<Object[]>) page.getResult();
					missionparameteriable4 = (MissionParameterTable4) this.commonService
							.get(MissionParameterTable4.class, Long.valueOf(missionId));
					if (missionparameteriable4 != null) {
						// OrderTable ordertable = (OrderTable)
						// this.commonService.get(OrderTable.class,
						// missionparameteriable4.getCommandId());
						OrderTable ordertable = getOrder(missionparameteriable4.getCommandEName());
						missionparameteriable4.setCommandName(ordertable.getCommandAlias());
						// NodegroupTable nodegroupTable = (NodegroupTable)
						// this.commonService.get(NodegroupTable.class,missionparameteriable4.getNodeListId());
						// missionparameteriable4.setNodeListName(nodegroupTable.getGroupName());
					}
				} else if (new Long(6).equals(missionstatetable.getMissionType())) {
					// 根据任务id查询执行结果的信息
					NmstaskManagerHelper help = new NmstaskManagerHelper();
					String sql = "select m.mission_name,nt.node_ip,r.result,r.result_desc, nt.node_system_type,nt.node_type,r.seq_id from mission_result_table6  r "
							+ "left join mission_state_table m on m.mission_id=r.mission_id "
							+ "left join (select distinct node_ip,seq_id,node_system_type,node_type from node_table n ) nt on nt.seq_id=r.seq_id "
							+ "where r.mission_id=" + missionId + " ";
					if (StringUtils.isNotEmpty(result)) {
						if ("1".equals(result)) {
							sql += " and r.result in (1,-1)";
						} else {
							sql += " and r.result=" + result;
						}

					}
					if (StringUtils.isNotEmpty(ip)) {
						sql += " and nt.node_ip like '%" + ip + "%'";
					}
					sql += " order by nt.node_ip asc,r.mission_id asc";
					page = this.commonService.findByPageForSql(sql, pageNo, pageSize);
					resultObjects = (ArrayList<Object[]>) page.getResult();
					missionparametertable6 = (MissionParameterTable6) this.commonService
							.get(MissionParameterTable6.class, Long.valueOf(missionId));
					if (missionparametertable6 != null) {
						// OrderTable ordertable = (OrderTable)
						// this.commonService.get(OrderTable.class,
						// missionparametertable6.getCommandId());
						OrderTable ordertable = getOrder(missionparametertable6.getCommandEName());
						missionparametertable6.setCommandName(ordertable.getCommandAlias());
						// NodegroupTable nodegroupTable = (NodegroupTable)
						// this.commonService.get(NodegroupTable.class,missionparametertable6.getNodeListId());
						// missionparametertable6.setNodeListName(nodegroupTable.getGroupName());
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("查看任务执行结果异常！", e);
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');this.location='nmsTaskManager!execute.do?action=query'</script>");
		}
	}

	public void getResultPieChart() throws Exception {
		String missionId = this.getRequest().getParameter("missionId");

		// select * from mission_state_table where mission_id = ?
		missionstatetable = (MissionStateTable) this.commonService.get(MissionStateTable.class,
				Long.parseLong(missionId));

		if (missionstatetable == null || missionstatetable.getMissionType() == null) {
			throw new Exception();
		}

		String sql1 = ""; // 原生SQL语句，基于Oracle数据库
		String sql2 = "";
		Long missionType = missionstatetable.getMissionType();

		NmstaskManagerHelper help = new NmstaskManagerHelper();

		// 周期任务获取最新任务编号
		Long currMissionId = Long.parseLong(missionId);
		if (ObjectUtils.equals(missionstatetable.getLoopFlag(), 1L)) {
			/*
			 * sql1 = "select cur_mission_id from " +
			 * " (select l.cur_mission_id, to_char(l.start_time,'yyyy-mm-dd hh24:mi:ss') start_time"
			 * + " from loopmission_state_table l, mission_result_table4 m" +
			 * " where l.cur_mission_id = m.mission_id" + " and l.mission_id ="
			 * + missionId + " order by start_time desc" + ") where rownum = 1";
			 */
			// @2018年4月10日18:29:38 fang 修改rownum 适配mysql
			sql1 = "select max(cur_mission_id) from "
					+ " (select l.cur_mission_id, to_char(l.start_time,'yyyy-mm-dd hh24:mi:ss') start_time"
					+ " from loopmission_state_table l, mission_result_table4 m"
					+ " where l.cur_mission_id = m.mission_id" + " and l.mission_id =" + missionId + ") mm";
			resultObjects = help.getTaskResult(this.commonService, sql1);
			Object obj = resultObjects.get(0);
			if(obj != null){
				currMissionId = Long.valueOf(obj.toString()); //((BigDecimal) obj).longValue();
				this.getRequest().setAttribute("currMissionId", currMissionId);
			}
		}

		// loopFlag is 1 周期任务
		if (ObjectUtils.equals(missionstatetable.getLoopFlag(), 1L)) {
			// 周期任务总体比例
			sql2 = "select decode(r.Result,-1,1,r.Result) as Result, count(r.mission_id) as Count"
					+ " from mission_result_table" + missionType + " r" + " where r.mission_id in ("
					+ " select l.Cur_mission_id from loopmission_state_table l" + " where l.mission_id = " + missionId
					+ ")" + " group by decode(r.Result, -1, 1, r.Result)";
			// 周期任务最新周期
			sql1 = "select decode(r.Result,-1,1,r.Result) as Result, count(r.mission_id) as Count"
					+ " from mission_result_table" + missionType + " r" + " where r.mission_id = " + currMissionId
					+ " group by decode(r.Result, -1, 1, r.Result)";
		} else { // loopFlag is 0 or null 非周期任务
			sql1 = "select decode(r.Result,-1,1,r.Result) as Result, count(r.mission_id) as Count"
					+ " from mission_result_table" + missionType + " r" + " where r.mission_id = " + missionId
					+ " group by decode(r.Result, -1, 1, r.Result)";
		}

		/*
		 * missionResultPieChart.jsp 柱图 columnData: 非周期任务比例/周期任务最新比例 [ [result,
		 * number, percent], ... ] 数组元素：结果状态,节点数目,节点百分比 totalData: 周期任务总体比例 [
		 * [result, number, percent], ... ] 数组元素：结果状态,节点数目,节点百分比
		 */
		// 非周期任务状态比例，周期任务最新状态比例
		resultObjects = help.getTaskResult(this.commonService, sql1);

		// 计算最新任务执行节点数目
		// BigDecimal totalNum = BigDecimal.ZERO;
		Long totalNum = 0l;
		for (Object[] dataColumn : resultObjects) {
			totalNum += Long.valueOf(dataColumn[1].toString());
			// totalNum = totalNum.add((BigDecimal) dataColumn[1]); //
			// count(mission_id)
		}

		JSONArray jsonColumnData = new JSONArray();
		for (Object[] dataColumn : resultObjects) {
			/*
			 * Long result = ((BigDecimal) dataColumn[0]).longValue(); Long
			 * count = ((BigDecimal) dataColumn[1]).longValue();
			 */
			Long result = Long.valueOf(dataColumn[0].toString());
			Long count = Long.valueOf(dataColumn[1].toString());
			JSONArray colData = new JSONArray();
			colData.add(result); // 结果状态
			colData.add(count); // 节点数目
			BigDecimal percent = new BigDecimal(count * 100);
			percent = percent.divide(new BigDecimal(totalNum), 2, RoundingMode.HALF_UP);
			colData.add(percent.doubleValue()); // 节点百分比
			jsonColumnData.add(colData);
		}
		this.getRequest().setAttribute("columnData", jsonColumnData);

		// 周期任务,总体比例
		if (ObjectUtils.equals(missionstatetable.getLoopFlag(), 1L)) {
			resultObjects = help.getTaskResult(this.commonService, sql2);
			JSONArray jsonTotalData = new JSONArray();

			// 计算总体任务执行节点数目
			BigDecimal totalNum1 = BigDecimal.ZERO;
			for (Object[] dataColumn : resultObjects) {
				totalNum1 = totalNum1.add((BigDecimal) dataColumn[1]); // count(mission_id)
			}
			// 最新周期比例
			for (Object[] dataColumn : resultObjects) {
				Long result = ((BigDecimal) dataColumn[0]).longValue();
				Long count = ((BigDecimal) dataColumn[1]).longValue();
				JSONArray colData = new JSONArray();
				colData.add(result); // 结果状态
				colData.add(count); // 节点数目
				BigDecimal percent = new BigDecimal(count * 100);
				percent = percent.divide(totalNum1, 2, RoundingMode.HALF_UP);
				colData.add(percent.doubleValue()); // 节点百分比
				jsonTotalData.add(colData);
			}
			this.getRequest().setAttribute("totalData", jsonTotalData);
		}

		/*
		 * missionResultPieChart.jsp 表格 tableData: [[IP地址, 任务状态, 位置信息], ...]
		 */
		// 配置表格节点超过一页时的叠加单位，默认为5或通过myconfig.properties文件nmstaskmanager.resultchart.foldunit属性自行配置
		String foldUnit = "5";
		String foldUnitConf = "nmstaskmanager.resultchart.foldunit";
		if (BaseAction.rb.containsKey(foldUnitConf)) {
			String temp = BaseAction.rb.getString(foldUnitConf);
			if (StringUtils.isNotEmpty(temp) && temp.matches("\\d+")) {
				foldUnit = temp;
			}
		}
		this.getRequest().setAttribute("foldUnit", Integer.parseInt(foldUnit));

		// 据IPN排序，查询当前任务的IPN、node_ip、result
		/*sql1 = "select distinct ipn, node_ip," + " b.room_ispn||' '||b.ispn||' '||n.node_begin_utype,"
				+ " decode(m.Result,-1,1,m.Result) as Result"
				+ " from node_table n, node_box_table b, mission_result_table" + missionType + " m"
				+ " where n.node_box_ispn = b.ispn and n.seq_id = m.seq_id" + " and m.mission_id = " + currMissionId // 非周期任务为任务ID,周期任务为最新ID
				+ " order by ipn";*/
		if(Constant.IS_MYSQL){
			sql1 = "select distinct ipn, node_ip, concat(b.room_ispn,' ',b.ispn,' ',n.node_begin_utype),"
					+ " decode(m.Result,-1,1,m.Result) as Result"
					+ " from node_table n, node_box_table b, mission_result_table" + missionType + " m"
					+ " where n.node_box_ispn = b.ispn and n.seq_id = m.seq_id" + " and m.mission_id = " + currMissionId // 非周期任务为任务ID,周期任务为最新ID
					+ " order by ipn";
		}else{
			sql1 = "select distinct ipn, node_ip," + " b.room_ispn||' '||b.ispn||' '||n.node_begin_utype,"
					+ " decode(m.Result,-1,1,m.Result) as Result"
					+ " from node_table n, node_box_table b, mission_result_table" + missionType + " m"
					+ " where n.node_box_ispn = b.ispn and n.seq_id = m.seq_id" + " and m.mission_id = " + currMissionId // 非周期任务为任务ID,周期任务为最新ID
					+ " order by ipn";
		}
		resultObjects = help.getTaskResult(this.commonService, sql1);
		JSONArray jsonTableData = new JSONArray();
		for (Object[] columnData : resultObjects) {
			JSONArray column = new JSONArray();
			column.add((String) columnData[1]); // IP
			column.add(((BigDecimal) columnData[3]).longValue()); // Result
			column.add((String) columnData[2]); //
			jsonTableData.add(column);
		}
		this.getRequest().setAttribute("tableData", jsonTableData);
	}

	public String exprotFailedResultsXls() {
		String missionId = this.getRequest().getParameter("missionId");
		String result = this.getRequest().getParameter("result");
		String ip = this.getRequest().getParameter("ip");
		String tabs = this.getRequest().getParameter("tabs");

		String[] nameList = { getI18nText("i18n_NmsTaskManagerAction.executeAction.missionName_n81i"), 
								getI18nText("i18n_NmsTaskManagerAction.executeAction.nodeIp_n81i"),
								getI18nText("i18n_NmsTaskManagerAction.executeAction.resultReturn_n81i"),
								getI18nText("i18n_NmsTaskManagerAction.executeAction.resultCause_n81i") };
		String[] colu = { "0", "1", "2", "3" };
		ExportUtils m = new ExportUtils();
		m.setAutoSizeColumn(true);

		try {
			if (StringUtils.isNotEmpty(missionId)) {
				missionstatetable = (MissionStateTable) this.commonService.get(MissionStateTable.class,
						Long.valueOf(missionId));
				// 补全系统名称、节点组名称信息
				if (missionstatetable != null) {
					if (missionstatetable.getSystemId() != null) {
						SystemTable systemTable = (SystemTable) this.commonService.get(SystemTable.class,
								missionstatetable.getSystemId());
						if (systemTable != null) {
							missionstatetable.setSystemIdName(systemTable.getSystemName());
						}
					}
				}
				String resultTitle = getI18nText("i18n_NmsTaskManagerAction.executeAction.all_n81i");
				if (StringUtils.isNotEmpty(result)) {
					switch (Integer.parseInt(result)) {
					case 0:
						resultTitle = getI18nText("i18n_NmsTaskManagerAction.executeAction.ok_n81i");
						break;
					case 1:
						resultTitle = getI18nText("i18n_NmsTaskManagerAction.executeAction.err_n81i");
						break;
					case -1:
						resultTitle = getI18nText("i18n_NmsTaskManagerAction.executeAction.validFaild_n81i");
						break;
					case 3:
						resultTitle = getI18nText("i18n_NmsTaskManagerAction.executeAction.lssue_n81i");
						break;
					case 40:
						resultTitle = getI18nText("i18n_NmsTaskManagerAction.executeAction.lssueSuccess_n81i");
						break;
					case 50:
						resultTitle = getI18nText("i18n_NmsTaskManagerAction.executeAction.processStop_n81i");
						break;
					case 60:
						resultTitle = getI18nText("i18n_NmsTaskManagerAction.executeAction.fileBackup_n81i");
						break;
					case 70:
						resultTitle = getI18nText("i18n_NmsTaskManagerAction.executeAction.fileUpdate_n81i");
						break;
					case 80:
						resultTitle = getI18nText("i18n_NmsTaskManagerAction.executeAction.startSuccess_n81i");
						break;
					case 81:
						resultTitle = getI18nText("i18n_NmsTaskManagerAction.executeAction.startFaild_n81i");
						break;
					default:
						resultTitle = "";
						break;
					}
				}
				StringBuffer idsStr = new StringBuffer("0");
				if (ids != null && ids.length > 0) {
					for (Long id : ids) {
						idsStr.append("," + id);
					}
				}
				// 推送文件
				if (missionstatetable.getMissionType().intValue() == 1) {

					// 查询参数
					// 根据任务id查询执行结果的信息
					NmstaskManagerHelper help = new NmstaskManagerHelper();
					String sql = "select m.mission_name,nt.node_ip,decode(r.Result,0,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.ok_n81i")+"',1,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.err_n81i")+"',-1,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.validFaild_n81i")+"',3,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.lssue_n81i")+"',40,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.lssueSuccess_n81i")+"',50,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.processStop_n81i")+"',60,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.fileBackup_n81i")+"',70,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.fileUpdate_n81i")+"',80,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.startSuccess_n81i")+"',81,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.startFaild_n81i")+"','"+getI18nText("i18n_NmsTaskManagerAction.executeAction.unknowState_n81i")+"') result,r.result_desc from mission_result_table1 r "
							+ "left join mission_state_table m on m.mission_id=r.mission_id "
							+ "left join (select distinct node_ip,seq_id from node_table n where n.node_state=0) nt on nt.seq_id=r.seq_id "
							+ "where r.mission_id=" + missionId + "";
					if (StringUtils.isNotEmpty(result)) {
						if ("1".equals(result)) {
							sql += " and r.result in (1,-1)";
						} else {
							sql += " and r.result=" + result + "";
						}
					}
					if (StringUtils.isNotEmpty(ip)) {
						sql += " and nt.node_ip like '%" + ip + "%'";
					}
					if (idsStr.length() > 1) {
						sql += " and r.seq_id in(" + idsStr + ")";
					}
					sql += " order by nt.node_ip asc";
					resultObjects = help.getTaskResult(this.commonService, sql);
					if (resultObjects == null || resultObjects.size() == 0) {
						outHtmlString(
								"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.noResultToExport_n81i');this.location='nmsTaskManager!executeAction.do?action=statistic&missionId="
										+ missionId + "&result=" + result + "&tabs=" + tabs + "&ip=" + ip
										+ "';</script>");
						return null;
					}
					m.exportExcel(getI18nText("i18n_NmsTaskManagerAction.executeAction.filePush_n81i")+"————" + resultTitle + getI18nText("i18n_NmsTaskManagerAction.executeAction.resultExport_n81i"), resultObjects, nameList, colu);
					return null;
				}
				if (missionstatetable.getMissionType().intValue() == 4) {
					// 根据任务id查询执行结果的信息
					NmstaskManagerHelper help = new NmstaskManagerHelper();
					String sql = "";
					String cur_idStr = "";
					if (missionstatetable.getLoopFlag() != null && missionstatetable.getLoopFlag() == 1) { // 周期任务
						sql = "select m.mission_name, nt.node_ip, decode(r.Result,0,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.ok_n81i")+"',1,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.err_n81i")+"',-1,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.validFaild_n81i")+"',3,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.lssue_n81i")+"',5,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.prepareRevoke_n81i")+"',6,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.revoke_n81i")+"',7,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.revokSuccess_n81i")+"',40,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.lssueSuccess_n81i")+"',50,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.processStop_n81i")+"',60,'文件备份成功',70,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.fileUpdate_n81i")+"',80,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.startSuccess_n81i")+"',81,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.startFaild_n81i")+"','"+getI18nText("i18n_NmsTaskManagerAction.executeAction.unknowState_n81i")+"') result, r.result_desc from mission_result_table4 r  "
								+ "left join (select distinct node_ip,seq_id from node_table n where n.node_state=0) nt on nt.seq_id=r.seq_id, loopmission_state_table l  "
								+ "left join mission_state_table m on m.mission_id = l.mission_id  "
								+ "where l.Cur_mission_id = r.mission_id   and l.mission_id =" + missionId + "";
						if (StringUtils.isNotEmpty(result)) {
							if ("1".equals(result)) {
								sql += " and r.result in (1,-1)";
							} else {
								sql += " and r.result=" + result + "";
							}
						}
						if (StringUtils.isNotEmpty(ip)) {
							sql += " and nt.node_ip like '%" + ip + "%'";
						}

						String[] curid_ids = this.getRequest().getParameterValues("curid_ids");
						String curMissionId = this.getRequest().getParameter("curMissionId");
						StringBuffer curIdsStr = new StringBuffer("(0,0)");
						if (curid_ids != null && curid_ids.length > 0) {
							for (String curId : curid_ids) {
								String[] id = curId.split("_");
								curIdsStr.append(",(" + id[0] + "," + id[1] + ")");
							}
						} else if (curMissionId != null && curMissionId != "") {
							sql += " and r.mission_id = " + curMissionId;
						}
						if (curIdsStr.length() > 6) {
							sql += " and (r.mission_id,r.seq_id) in(" + curIdsStr + ")";
						}
						sql += " order by nt.node_ip asc";

						cur_idStr = "&curMissionId=" + curMissionId;
					} else { // 非周期任务
						sql = "select m.mission_name,nt.node_ip,decode(r.Result,0,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.ok_n81i")+"',1,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.err_n81i")+"',-1,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.validFaild_n81i")+"',3,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.lssue_n81i")+"',40,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.lssueSuccess_n81i")+"',50,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.processStop_n81i")+"',60,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.fileBackup_n81i")+"',70,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.fileUpdate_n81i")+"',80,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.startSuccess_n81i")+"',81,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.startFaild_n81i")+"','"+getI18nText("i18n_NmsTaskManagerAction.executeAction.unknowState_n81i")+"') result,r.result_desc from mission_result_table4  r "
								+ "left join mission_state_table m on m.mission_id=r.mission_id "
								+ "left join (select distinct node_ip,seq_id from node_table n where n.node_state=0) nt on nt.seq_id=r.seq_id "
								+ "where r.mission_id=" + missionId + "";
						if (StringUtils.isNotEmpty(result)) {
							if ("1".equals(result)) {
								sql += " and r.result in (1,-1)";
							} else {
								sql += " and r.result=" + result + "";
							}
						}
						if (StringUtils.isNotEmpty(ip)) {
							sql += " and nt.node_ip like '%" + ip + "%'";
						}
						if (idsStr.length() > 1) {
							sql += " and r.seq_id in(" + idsStr + ")";
						}
						sql += " order by nt.node_ip asc";
					}

					resultObjects = help.getTaskResult(this.commonService, sql);
					if (resultObjects == null || resultObjects.size() == 0) {
						outHtmlString(
								"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.noResultToExport_n81i');this.location='nmsTaskManager!executeAction.do?action=statistic&missionId="
										+ missionId + "&result=" + result + "&tabs=" + tabs + "&ip=" + ip
										+ "';</script>");
						return null;
					}
					m.exportExcel(getI18nText("i18n_NmsTaskManagerAction.executeAction.execCmd_n81i")+"————" + resultTitle + getI18nText("i18n_NmsTaskManagerAction.executeAction.resultExport_n81i"), resultObjects, nameList, colu);
					return null;
				}
				if (missionstatetable.getMissionType().intValue() == 6) {
					// 根据任务id查询执行结果的信息
					NmstaskManagerHelper help = new NmstaskManagerHelper();
					String sql = "select m.mission_name,nt.node_ip,decode(r.Result,0,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.ok_n81i")+"',1,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.err_n81i")+"',-1,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.validFaild_n81i")+"',3,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.lssue_n81i")+"',40,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.lssueSuccess_n81i")+"',50,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.processStop_n81i")+"',60,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.fileBackup_n81i")+"',70,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.fileUpdate_n81i")+"',80,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.startSuccess_n81i")+"',81,'"+getI18nText("i18n_NmsTaskManagerAction.executeAction.startFaild_n81i")+"','"+getI18nText("i18n_NmsTaskManagerAction.executeAction.unknowState_n81i")+"') result,r.result_desc from mission_result_table6  r "
							+ "left join mission_state_table m on m.mission_id=r.mission_id "
							+ "left join (select distinct node_ip,seq_id from node_table n where n.node_state=0) nt on nt.seq_id=r.seq_id "
							+ "where r.mission_id=" + missionId + "";
					if (StringUtils.isNotEmpty(result)) {
						if ("1".equals(result)) {
							sql += " and r.result in (1,-1)";
						} else {
							sql += " and r.result=" + result + "";
						}
					}
					if (StringUtils.isNotEmpty(ip)) {
						sql += " and nt.node_ip like '%" + ip + "%'";
					}
					sql += " order by nt.node_ip asc";
					resultObjects = help.getTaskResult(this.commonService, sql);
					if (resultObjects == null || resultObjects.size() == 0) {
						outHtmlString(
								"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.noResultToExport_n81i');this.location='nmsTaskManager!executeAction.do?action=statistic&missionId="
										+ missionId + "&result=" + result + "&tabs=" + tabs + "&ip=" + ip
										+ "';</script>");
						return null;
					}
					m.exportExcel(getI18nText("i18n_NmsTaskManagerAction.executeAction.upgrade_n81i")+"————" + resultTitle + getI18nText("i18n_NmsTaskManagerAction.executeAction.resultExport_n81i"), resultObjects, nameList, colu);
					return null;
				}
			}
		} catch (Exception e) {
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');this.location='nmsTaskManager!executeAction.do?action=statistic&missionId="
							+ missionId + "&result=" + result + "&tabs=" + tabs + "&ip=" + ip + "';</script>");
			e.printStackTrace();
		}
		return null;
	}

	public void batchDownLoadFile() throws IOException {
		String fileNames = this.getRequest().getParameter("names");
		String ip = this.getRequest().getParameter("ip");
		String[] arr = fileNames.split(",");
		List<File> files = new ArrayList<File>();
		String urlPath = getConfigValue("uploadServerPath");
		for (int i = 0; i < arr.length; i++) {
			String path = urlPath + File.separator + arr[i];
			File file = new File(path);
			if (file.exists()) {
				files.add(file);
			}
		}
		if (files.size() == 0) {
			String missionId = this.getRequest().getParameter("missionId");
			String roundId = this.getRequest().getParameter("curMissionId");
			String tabs = this.getRequest().getParameter("tabs");
			String result = this.getRequest().getParameter("result");
			String strPath = "nmsTaskManager!executeAction.do?action=searchResults&missionId=" + missionId
					+ "&curMissionId=" + roundId + "&tabs=" + tabs + "&result=" + result + "&ip=" + ip;
			this.outHtmlString("<script>alert('i18n_NmsTaskManagerAction.executeAction.selectFileIsNotExists_n81i');this.location='" + strPath + "';</script>");
			return;
		}
		ZipOutputStream zos = new ZipOutputStream(this.getResponse().getOutputStream());
		zipFile(files, zos);
		zos.flush();
		zos.close();
	}

	private void zipFile(List<File> subs, ZipOutputStream zos) throws IOException {
		HttpServletResponse response = this.getResponse();
		HttpServletRequest request = this.getRequest();
		response.setContentType("APPLICATION/OCTET-STREAM");
		String missionName = this.getRequest().getParameter("missionName");
		String userAgent = request.getHeader("User-Agent");
		String fileName = this.getZipFilename(missionName);
		byte[] bytes = userAgent.contains("MSIE") ? fileName.getBytes() : fileName.getBytes("utf-8");
		fileName = new String(bytes, "ISO-8859-1");
		response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
		for (File f : subs) {
			zos.putNextEntry(new ZipEntry(f.getName()));
			FileInputStream fis = new FileInputStream(f);
			byte[] buffer = new byte[1024];
			int r = 0;
			while ((r = fis.read(buffer)) != -1) {
				zos.write(buffer, 0, r);
			}
			zos.setEncoding("gbk");
			fis.close();
		}
	}

	private String getZipFilename(String missionName) {
		Date date = new Date();
		String s = missionName + "_" + date.getTime() + ".zip";
		return s;
	}

	public void getResultLineAndColumnChart() throws Exception {
		String missionId = this.getRequest().getParameter("missionId");
		if (StringUtils.isEmpty(missionId)) {
			return;
		}
		missionstatetable = (MissionStateTable) this.commonService.get(MissionStateTable.class,
				Long.parseLong(missionId));
		if (missionstatetable != null && missionstatetable.getMissionType() != null) {
			// 定时任务
			if (missionstatetable.getMissionType().longValue() == 4l && missionstatetable.getLoopFlag() != null
					&& missionstatetable.getLoopFlag().longValue() == 1l) {// 根据任务id查询执行结果的信息

				// 此处应该以loopmission_state_table为主表，否则对于结果还没入库的周期，就不能正确的显示（排除预置及未能执行周期，其它状态的周期都进行统计）
				String fromStr = " from loopmission_state_table lmst  left join mission_result_table4 mrt on lmst.cur_mission_id = mrt.mission_id ";

				// 需要对cur_mission_id去重
				List loopSumList = this.commonService.executeSQL("select count(distinct(lmst.cur_mission_id)) "
						+ fromStr + " where lmst.mission_state <>0 and lmst.mission_state<>4 and lmst.mission_id = '"
						+ missionstatetable.getMissionId() + "' ");
				int loopSum = 0;// 任务周期总数
				if (loopSumList != null && loopSumList.size() > 0) {
					try {
						loopSum = Integer.parseInt(loopSumList.get(0) + "");
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				sumRound = loopSum;

				// 查询周期任务的id序列和对应的轮次序列
				// 2015-11-12 修改：1.只查询状态非0,4的周期任务mission_state <>0 and
				// mission_state<>4
				// ,对于预置周期及未能执行的周期不进行展示；2.轮次编号查询有误，将rownum的查询提到从里面数的第二层的select中;3.修改为以结果表为主表（周期数取决于结果，而不是loop表，因为loop表中有的周期没有执行结果，且状态还不是0或者4--这可能是数据或者其他原因），且要对周期任务ID进行去重，因为结果表中一个周期会有多个节点的结果
				List roundIdList = new ArrayList();
				if (loopSum != 0) {
					if (dataRange == null) {// 默认取最新的20个周期
						dataEnd = loopSum;
						if (loopSum >= 20) {
							dataStart = loopSum - 19;
						} else {
							dataStart = 1;
						}
					} else if (dataRange == -1) {// 查询前20个周期
						if (dataStart != null && dataStart != 1) {// 已经是第一页,则不改变数据,只对dataStart不是第一页的情况进行处理
							dataEnd = dataStart - 1;
							dataStart = dataStart - 20;
							if (dataStart <= 0) {
								dataStart = 1;
							}
						}
					} else if (dataRange == 1) {// 查询后20个周期
						if (dataEnd != null && dataEnd != loopSum) {// 已经是最后一页，不改变数据,只对dataEnd不是最后一页的情况进行处理
							dataStart = dataEnd + 1;
							dataEnd = dataEnd + 20;
							if (dataEnd > loopSum) {
								dataEnd = loopSum;
							}
						}
					}
					if (dataStart != null && dataEnd != null) {
						// @2018年4月11日09:06:42 fang 修改rownum 通过
						// limit配合java代码实现rownum
						if (Constant.IS_MYSQL) {
							String missionIdStr = " select distinct(lmst.cur_mission_id) cur_mission_id ,1 rw" + fromStr
									+ " where lmst.mission_state <>0 and lmst.mission_state<>4 and lmst.mission_id = '"
									+ missionstatetable.getMissionId() + "' " + " order by cur_mission_id asc limit "
									+ (dataStart - 1) + ", " + (dataEnd - dataStart + 1);
							roundIdList = this.commonService.executeSQL(missionIdStr);
							if (roundIdList != null && roundIdList.size() > 0) {
								int b = dataStart;
								for (int i = 0; i < roundIdList.size(); i++) {
									Object[] oa = (Object[]) roundIdList.get(i);
									oa[1] = b;
									b++;
								}
							}
						} else {
							String missionIdStr = " select * from(" + " select * from("
									+ " select cur_mission_id,rownum rw " + " from ("
									+ " select distinct(lmst.cur_mission_id) " + fromStr
									+ " where lmst.mission_state <>0 and lmst.mission_state<>4 and lmst.mission_id = '"
									+ missionstatetable.getMissionId() + "' " + " order by cur_mission_id asc" + " )t "
									+ " order by cur_mission_id desc" + " )" + " where rw<=" + dataEnd + " and rw >="
									+ dataStart + ") " + " order by cur_mission_id asc";
							roundIdList = this.commonService.executeSQL(missionIdStr);
						}
					}
				}

				StringBuffer xValue = new StringBuffer();
				StringBuffer idValue = new StringBuffer();
				Map<Long, Long> idsMap = new HashMap<Long, Long>();
				if (roundIdList != null && roundIdList.size() > 0) {
					for (Object obj : roundIdList) {
						idsMap.put(Long.parseLong(((Object[]) obj)[0].toString()),
								Long.parseLong(((Object[]) obj)[1].toString()));
						idValue.append("," + ((Object[]) obj)[0].toString());
						xValue.append("," + ((Object[]) obj)[1].toString());
					}
					xValue.deleteCharAt(0);
					idValue.deleteCharAt(0);
				} else {
					return;
				}
				this.getRequest().setAttribute("xValue", xValue.toString());
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

				// 2015-11-12
				// 修改：1.去掉按result分组（不然同一个周期任务的节点会分多个组，统计的数据就不对了）；2.以mission_result_table4表为主表（与界面的周期统计表一样），否则预置周期及未能执行的周期也会查出来，而这两种周期在结果表无对应记录；
				resultObjects = new ArrayList();
				// 统计 结果为0
				List cntList = this.commonService
						.executeSQL("select lmst.cur_mission_id,lmst.start_time ,0,sum(decode(mrt.Result,0,1,0)) "
								+ fromStr + "where lmst.cur_mission_id in (" + idValue + ") " // 去掉所有的预置周期内容
								+ "group by lmst.cur_mission_id,lmst.start_time "
								+ "order by lmst.cur_mission_id asc,lmst.start_time asc");
				if (cntList != null && cntList.size() > 0) {
					for (Object[] objs : (List<Object[]>) cntList) {
						String[] result = new String[] { objs[0] + "", sdf.format(objs[1]), objs[2] + "", objs[3] + "",
								idsMap.get(Long.parseLong(objs[0].toString())).longValue() + "" };
						resultObjects.add(result);
					}
				}
				cntList.clear();

				// 统计 结果为1或-1
				cntList = this.commonService
						.executeSQL("select lmst.cur_mission_id,lmst.start_time ,1,sum(decode(mrt.Result,1,1,-1,1,0)) "
								+ fromStr + "where lmst.cur_mission_id in (" + idValue + ") " // 去掉所有的预置周期内容
								+ "group by lmst.cur_mission_id,lmst.start_time "
								+ "order by lmst.cur_mission_id asc,lmst.start_time asc");
				if (cntList != null && cntList.size() > 0) {
					// resultObjects = new ArrayList();
					for (Object[] objs : (List<Object[]>) cntList) {
						String[] result = new String[] { objs[0] + "", sdf.format(objs[1]), objs[2] + "", objs[3] + "",
								idsMap.get(Long.parseLong(objs[0].toString())).longValue() + "" };
						resultObjects.add(result);
					}
				}
				cntList.clear();
				// 统计 结果为3
				cntList = this.commonService
						.executeSQL("select lmst.cur_mission_id,lmst.start_time ,3,sum(decode(mrt.Result,3,1,0)) "
								+ fromStr + "where lmst.cur_mission_id in (" + idValue + ") " // 去掉所有的预置周期内容
								+ "group by lmst.cur_mission_id,lmst.start_time "
								+ "order by lmst.cur_mission_id asc,lmst.start_time asc");
				if (cntList != null && cntList.size() > 0) {

					// resultObjects = new ArrayList();
					for (Object[] objs : (List<Object[]>) cntList) {
						String[] result = new String[] { objs[0] + "", sdf.format(objs[1]), objs[2] + "", objs[3] + "",
								idsMap.get(Long.parseLong(objs[0].toString())).longValue() + "" };
						resultObjects.add(result);
					}
				}
				cntList.clear();
				// 统计 结果为40
				cntList = this.commonService
						.executeSQL("select lmst.cur_mission_id,lmst.start_time ,40,sum(decode(mrt.Result,40,1,0)) "
								+ fromStr + "where lmst.cur_mission_id in (" + idValue + ") " // 去掉所有的预置周期内容
								+ "group by lmst.cur_mission_id,lmst.start_time "
								+ "order by lmst.cur_mission_id asc,lmst.start_time asc");
				if (cntList != null && cntList.size() > 0) {
					// resultObjects = new ArrayList();
					for (Object[] objs : (List<Object[]>) cntList) {
						String[] result = new String[] { objs[0] + "", sdf.format(objs[1]), objs[2] + "", objs[3] + "",
								idsMap.get(Long.parseLong(objs[0].toString())).longValue() + "" };
						resultObjects.add(result);
					}
				}

				cntList.clear();
				// 统计 结果为50
				cntList = this.commonService
						.executeSQL("select lmst.cur_mission_id,lmst.start_time ,50,sum(decode(mrt.Result,50,1,0)) "
								+ fromStr + "where lmst.cur_mission_id in (" + idValue + ") " // 去掉所有的预置周期内容
								+ "group by lmst.cur_mission_id,lmst.start_time "
								+ "order by lmst.cur_mission_id asc,lmst.start_time asc");
				if (cntList != null && cntList.size() > 0) {
					// resultObjects = new ArrayList();
					for (Object[] objs : (List<Object[]>) cntList) {
						String[] result = new String[] { objs[0] + "", sdf.format(objs[1]), objs[2] + "", objs[3] + "",
								idsMap.get(Long.parseLong(objs[0].toString())).longValue() + "" };
						resultObjects.add(result);
					}
				}

				cntList.clear();
				// 统计 结果为60
				cntList = this.commonService
						.executeSQL("select lmst.cur_mission_id,lmst.start_time ,60,sum(decode(mrt.Result,60,1,0)) "
								+ fromStr + "where lmst.cur_mission_id in (" + idValue + ") " // 去掉所有的预置周期内容
								+ "group by lmst.cur_mission_id,lmst.start_time "
								+ "order by lmst.cur_mission_id asc,lmst.start_time asc");
				if (cntList != null && cntList.size() > 0) {
					// resultObjects = new ArrayList();
					for (Object[] objs : (List<Object[]>) cntList) {
						String[] result = new String[] { objs[0] + "", sdf.format(objs[1]), objs[2] + "", objs[3] + "",
								idsMap.get(Long.parseLong(objs[0].toString())).longValue() + "" };
						resultObjects.add(result);
					}
				}
				cntList.clear();
				// 统计 结果为70
				cntList = this.commonService
						.executeSQL("select lmst.cur_mission_id,lmst.start_time ,70,sum(decode(mrt.Result,70,1,0)) "
								+ fromStr + "where lmst.cur_mission_id in (" + idValue + ") " // 去掉所有的预置周期内容
								+ "group by lmst.cur_mission_id,lmst.start_time "
								+ "order by lmst.cur_mission_id asc,lmst.start_time asc");
				if (cntList != null && cntList.size() > 0) {
					// resultObjects = new ArrayList();
					for (Object[] objs : (List<Object[]>) cntList) {
						String[] result = new String[] { objs[0] + "", sdf.format(objs[1]), objs[2] + "", objs[3] + "",
								idsMap.get(Long.parseLong(objs[0].toString())).longValue() + "" };
						resultObjects.add(result);
					}
				}
				cntList.clear();
				// 统计 结果为80
				cntList = this.commonService
						.executeSQL("select lmst.cur_mission_id,lmst.start_time ,80,sum(decode(mrt.Result,80,1,0)) "
								+ fromStr + "where lmst.cur_mission_id in (" + idValue + ") " // 去掉所有的预置周期内容
								+ "group by lmst.cur_mission_id,lmst.start_time "
								+ "order by lmst.cur_mission_id asc,lmst.start_time asc");
				if (cntList != null && cntList.size() > 0) {
					// resultObjects = new ArrayList();
					for (Object[] objs : (List<Object[]>) cntList) {
						String[] result = new String[] { objs[0] + "", sdf.format(objs[1]), objs[2] + "", objs[3] + "",
								idsMap.get(Long.parseLong(objs[0].toString())).longValue() + "" };
						resultObjects.add(result);
					}
				}
				cntList.clear();
				// 统计 结果为81
				cntList = this.commonService
						.executeSQL("select lmst.cur_mission_id,lmst.start_time ,81,sum(decode(mrt.Result,81,1,0)) "
								+ fromStr + "where lmst.cur_mission_id in (" + idValue + ") " // 去掉所有的预置周期内容
								+ "group by lmst.cur_mission_id,lmst.start_time "
								+ "order by lmst.cur_mission_id asc,lmst.start_time asc");
				if (cntList != null && cntList.size() > 0) {
					// resultObjects = new ArrayList();
					for (Object[] objs : (List<Object[]>) cntList) {
						String[] result = new String[] { objs[0] + "", sdf.format(objs[1]), objs[2] + "", objs[3] + "",
								idsMap.get(Long.parseLong(objs[0].toString())).longValue() + "" };
						resultObjects.add(result);
					}
				}
				cntList.clear();
				// 统计 结果为5
				cntList = this.commonService
						.executeSQL("select lmst.cur_mission_id,lmst.start_time ,5,sum(decode(mrt.Result,5,1,0)) "
								+ fromStr + "where lmst.cur_mission_id in (" + idValue + ") " // 去掉所有的预置周期内容
								+ "group by lmst.cur_mission_id,lmst.start_time "
								+ "order by lmst.cur_mission_id asc,lmst.start_time asc");
				if (cntList != null && cntList.size() > 0) {
					// resultObjects = new ArrayList();
					for (Object[] objs : (List<Object[]>) cntList) {
						String[] result = new String[] { objs[0] + "", sdf.format(objs[1]), objs[2] + "", objs[3] + "",
								idsMap.get(Long.parseLong(objs[0].toString())).longValue() + "" };
						resultObjects.add(result);
					}
				}
				cntList.clear();
				// 统计 结果为6
				cntList = this.commonService
						.executeSQL("select lmst.cur_mission_id,lmst.start_time ,6,sum(decode(mrt.Result,6,1,0)) "
								+ fromStr + "where lmst.cur_mission_id in (" + idValue + ") " // 去掉所有的预置周期内容
								+ "group by lmst.cur_mission_id,lmst.start_time "
								+ "order by lmst.cur_mission_id asc,lmst.start_time asc");
				if (cntList != null && cntList.size() > 0) {
					// resultObjects = new ArrayList();
					for (Object[] objs : (List<Object[]>) cntList) {
						String[] result = new String[] { objs[0] + "", sdf.format(objs[1]), objs[2] + "", objs[3] + "",
								idsMap.get(Long.parseLong(objs[0].toString())).longValue() + "" };
						resultObjects.add(result);
					}
				}
				cntList.clear();
				// 统计 结果为7
				cntList = this.commonService
						.executeSQL("select lmst.cur_mission_id,lmst.start_time ,7,sum(decode(mrt.Result,7,1,0)) "
								+ fromStr + "where lmst.cur_mission_id in (" + idValue + ") " // 去掉所有的预置周期内容
								+ "group by lmst.cur_mission_id,lmst.start_time "
								+ "order by lmst.cur_mission_id asc,lmst.start_time asc");
				if (cntList != null && cntList.size() > 0) {
					// resultObjects = new ArrayList();
					for (Object[] objs : (List<Object[]>) cntList) {
						String[] result = new String[] { objs[0] + "", sdf.format(objs[1]), objs[2] + "", objs[3] + "",
								idsMap.get(Long.parseLong(objs[0].toString())).longValue() + "" };
						resultObjects.add(result);
					}
				}
			}
		}
	}

	public void getLineByAjax() throws Exception {
		getResultLineAndColumnChart();
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();

		// 开始和结束周期
		Map<String, Object> result1 = new HashMap();
		result1.put("dataStart", dataStart);
		result1.put("dataEnd", dataEnd);
		returnList.add(result1);

		// x轴周期数据
		Object xValueObj = this.getRequest().getAttribute("xValue");
		String xValueTmp = xValueObj == null ? "" : xValueObj.toString();
		String[] xValueArr = xValueTmp.split(",");
		Map<String, Object> loopData = new HashMap();
		loopData.put("xValue", xValueArr);
		returnList.add(loopData);

		// 折现数据
		List<Object[]> resultObjects = (List<Object[]>) this.getRequest().getAttribute("resultObjects");

		String[][] lines = new String[][] { { "0", getI18nText("i18n_NmsTaskManagerAction.executeAction.ok_n81i"), "#62C462" }, { "1", getI18nText("i18n_NmsTaskManagerAction.executeAction.err_n81i"), "#EE5F5B" },
				{ "3", getI18nText("i18n_NmsTaskManagerAction.executeAction.lssue_n81i"), "#F8B551" }, { "40", getI18nText("i18n_NmsTaskManagerAction.executeAction.missionLssueSuccess_n81i"), "#3399CC" }, { "50", getI18nText("i18n_NmsTaskManagerAction.executeAction.processStop_n81i"), "#13b5b1" },
				{ "60", getI18nText("i18n_NmsTaskManagerAction.executeAction.fileBackup_n81i"), "#E5B2FF" }, { "70", getI18nText("i18n_NmsTaskManagerAction.executeAction.fileUpdate_n81i"), "#FF9966" }, { "80", getI18nText("i18n_NmsTaskManagerAction.executeAction.cmdExecSuccess_n81i"), "#CCCC33" },
				{ "81", getI18nText("i18n_NmsTaskManagerAction.executeAction.cmdExecFaild_n81i"), "#FF9999" }, { "5",getI18nText("i18n_NmsTaskManagerAction.executeAction.prepareRevoke_n81i"), "#7ecef4" }, { "6", getI18nText("i18n_NmsTaskManagerAction.executeAction.revoke_n81i"), "#844284" },
				{ "7", getI18nText("i18n_NmsTaskManagerAction.executeAction.revokSuccess_n81i"), "#AEAE5F" } };
		StringBuffer roundStrAll = new StringBuffer();
		List roundAllList = new ArrayList();
		List<Map<String, Object>> lineList = new ArrayList<Map<String, Object>>();
		if (resultObjects != null) {
			boolean dFlag = false;
			for (String[] line : lines) {
				Map<String, Object> lineTmp = new HashMap();
				boolean viewFlag = false;
				// StringBuffer datas = new StringBuffer();
				List<Integer> dataList = new ArrayList<Integer>();
				StringBuffer roundStr = new StringBuffer();
				List roundList = new ArrayList();
				for (Object[] objs : resultObjects) {
					if (line[0].equals(objs[2].toString())) {
						viewFlag = true;
						// datas.append(","+objs[3].toString());
						dataList.add(Integer.parseInt(objs[3].toString()));
						roundStr.append(",[" + objs[4].toString() + "," + objs[0].toString() + "]");// 轮次，周期任务ID
						roundList.add("[" + objs[4].toString() + "," + objs[0].toString() + "]");
					} else {
						// break;
					}
				}
				// if(datas.length()>0){
				// datas.deleteCharAt(0);
				// }
				if (roundStr.length() > 0) {
					roundStr.deleteCharAt(0);
					roundStrAll.append(",[" + roundStr + "]");
					roundAllList.add(roundList.toArray());
				}
				if (viewFlag) {
					lineTmp.put("nameTmp", line[1]);
					lineTmp.put("colorTmp", line[2]);
					lineTmp.put("dataTmp", dataList.toArray());
					lineList.add(lineTmp);
				}
			}
		}
		if (roundStrAll.length() > 0) {// 轮次和任务id的对应关系，用于点击折线图进入对应周期的结果列表
			roundStrAll.deleteCharAt(0);
		}

		// Map<String, Object> result = new HashMap();
		// List<Map<String, Object>> line = new ArrayList<Map<String,
		// Object>>();

		// specialchart1.put("name", linStrings[i].toString() + " 平均值");
		// specialchart1.put("data", objs != null ? objs[0] : null);
		// result.put("lines", line);
		// returnList.add(result);
		Map<String, Object> result = new HashMap();
		result.put("lines", lineList);
		returnList.add(result);

		// 周期轮次与周期任务ID的对应
		Map<String, Object> roundIdMap = new HashMap();
		roundIdMap.put("roundStrAll", roundAllList.toArray());
		returnList.add(roundIdMap);

		// 总周期数
		Map<String, Object> suRoundMap = new HashMap();
		suRoundMap.put("sumRound", sumRound);
		returnList.add(suRoundMap);

		String jsonStr = JSONArray.fromObject(returnList).toString();
		System.out.println(jsonStr);
		this.getResponse().setCharacterEncoding("utf-8");
		PrintWriter printWriter = this.getResponse().getWriter();
		printWriter.write(jsonStr);
		printWriter.close();
		printWriter = null;
	}

	public String querymissionStateTableParent() {
		try {
			systemtablelist = new HashSet<SystemTable>();

			if (from != null && !"".equals("")) {
				this.getRequest().setAttribute("from", from);
			}

			String mIds = this.getRequest().getParameter("mids");
			if (mIds != null && !"".equals(mIds)) {
				mIds = mIds.substring(0, mIds.length() - 1);
			}
			// 获取当前业务系统的信息
			systemTable = (SystemTable) this.commonService.get(SystemTable.class, this.getSystemID());
			Long loginUserId = this.getUserID();
			this.getRequest().setAttribute("loginUserId", loginUserId);
			// 查询任务

			/*String sqlparam = " t.missionId > 0 "; // 管理员查看权限限制条件
			if (!this.getAdminMark()) { // 非管理员权限查看限制条件
				// sqlparam = " and ("
				sqlparam = " (" + " (t.viewLevel=1 and t.userId=" + this.getUserID() + " )"
						+ " or (t.viewLevel=2 and t.groupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='"
						+ this.getUser().getYhbh() + "' and x.type = 1)) " + " or (t.viewLevel=3 and t.systemId= "+this.getSystemID() + ") or t.viewLevel = 4) ";
			}*/
			String sqlparam = this.missionAuthHqlParams("t");//查看权限判断
			// String hql = " from MissionStateTable t where
			// t.missionName<>'应用升级' and t.missionName<>'配置正确性验证' " + sqlparam +
			// " ";
			String hql = " from MissionStateTable t where " + sqlparam + " ";
			// 查询条件
			// if (missionstatetable != null){
			if (missionName != null && !"".equals(missionName)) {
				hql += " and Upper(t.missionName) like '%" + missionName.toUpperCase() + "%'";
			}
			if (missionState != null && !"".equals(missionState)) {
				if ("3".equals(missionState)) {
					hql += " and t.missionState like '3%'";
				} else {
					hql += " and t.missionState=" + missionState;
				}
			}
			if (missionType != null && !"0".equals(missionType) && !"".equals(missionType)) {
				hql += " and t.missionType=" + missionType;
			}
			if (loopFlag != null && !"".equals(loopFlag)) {
				hql += " and t.loopFlag=" + loopFlag;
			}

			if (mId != null && !"".equals(mId)) {
				hql += " and t.missionId=" + Long.parseLong(mId);
			}

			if (mIds != null && !"".equals(mIds)) {
				hql += " and t.missionId in (" + mIds + ")";
			}
			if (from != null && from.equals("pp")) {
				hql += " and (t.missionState = 3 or t.missionState = 30 or t.missionState = 31 or t.missionState = 32)"
						+ " and (t.isLook is null or t.isLook ='1' or (t.isLook = '0' and instr(t.lookUserIds,'"
						+ this.getUserID() + "')= 0 "
						+ " and instr(t.lookUserIds,to_char(t.userId))= 0) or (t.isLook ='0' and t.lookUserIds is null))";
			}
			hql += " order by t.createTime desc";
			page = this.commonService.findByPage(hql, pageNo, this.getPageSize());
			missionstateTableList = (List<MissionStateTable>) page.getResult();

			for (MissionStateTable missonstate : missionstateTableList) {
				XtYhJbxx xtyhjbxx = (XtYhJbxx) this.commonService.get(XtYhJbxx.class, missonstate.getUserId());
				if (xtyhjbxx != null) {
					missonstate.setUserIdName(xtyhjbxx.getYhmc());
				}
				SystemTable systemtable = (SystemTable) this.commonService.get(SystemTable.class,
						missonstate.getSystemId());
				if (systemtable != null) {
					missonstate.setSystemIdName(systemtable.getSystemName());
				}
				if (missonstate.getGroupId() != null && missonstate.getGroupId().intValue() != 0) {
					XtJsJbxx xtjsjbxx = (XtJsJbxx) this.commonService.get(XtJsJbxx.class, missonstate.getGroupId());
					if (xtjsjbxx != null) {
						missonstate.setGroupIdName(xtjsjbxx.getJsmc());
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "nmstaskInfoListParent";
	}

	public String querymissionStateTableNew() {
		try {
			systemtablelist = new HashSet<SystemTable>();

			if (from != null && !"".equals("")) {
				this.getRequest().setAttribute("from", from);
			}

			String mIds = this.getRequest().getParameter("mids");
			if (mIds != null && !"".equals(mIds)) {
				mIds = mIds.substring(0, mIds.length() - 1);
			}
			// 获取当前业务系统的信息
			systemTable = (SystemTable) this.commonService.get(SystemTable.class, this.getSystemID());
			Long loginUserId = this.getUserID();
			this.getRequest().setAttribute("loginUserId", loginUserId);
			// 查询任务
			// String sqlparam = "and 1=1 "; //管理员查看权限限制条件
			/*String sqlparam = " t.missionId > 0 "; // 管理员查看权限限制条件
			if (!this.getAdminMark()) { // 非管理员权限查看限制条件
				// sqlparam = " and ("
				sqlparam = " (" + " (t.viewLevel=1 and t.userId=" + this.getUserID() + " )"
						+ " or (t.viewLevel=2 and t.groupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='"
						+ this.getUser().getYhbh() + "' and x.type = 1)) " + " or (t.viewLevel=3 ) " + ") ";
			}*/
			String sqlparam = this.missionAuthHqlParams("t");//查看权限判断
			// String hql = " from MissionStateTable t where
			// t.missionName<>'应用升级' and t.missionName<>'配置正确性验证' " + sqlparam +
			// " ";
			String hql = " from MissionStateTable t where " + sqlparam + " ";
			// 查询条件
			// if (missionstatetable != null){
			if (missionName != null && !"".equals(missionName)) {
				hql += " and Upper(t.missionName) like '%" + missionName.toUpperCase() + "%'";
			}
			if (missionState != null && !"".equals(missionState)) {
				if ("3".equals(missionState)) {
					hql += " and t.missionState like '3%'";
				} else {
					hql += " and t.missionState=" + missionState;
				}
			}
			if (missionType != null && !"0".equals(missionType) && !"".equals(missionType)) {
				hql += " and t.missionType=" + missionType;
			}
			if (loopFlag != null && !"".equals(loopFlag)) {
				hql += " and t.loopFlag=" + loopFlag;
			}

			if (mId != null && !"".equals(mId)) {
				hql += " and t.missionId=" + Long.parseLong(mId);
			}

			/*if (!this.getAdminMark() && this.getSystemID() != null) {
				hql += " and t.systemId=" + this.getSystemID();
			}*/
			if (mIds != null && !"".equals(mIds)) {
				hql += " and t.missionId in (" + mIds + ")";
			}
			if (from != null && from.equals("pp")) {
				hql += " and (t.missionState = 3 or t.missionState = 30 or t.missionState = 31 or t.missionState = 32)"
						+ " and (t.isLook is null or t.isLook ='1' or (t.isLook = '0' and instr(t.lookUserIds,'"
						+ this.getUserID() + "')= 0 "
						+ " and instr(t.lookUserIds,to_char(t.userId))= 0) or (t.isLook ='0' and t.lookUserIds is null))";
			}
			hql += " order by t.createTime desc";
			page = this.commonService.findByPage(hql, pageNo, this.getPageSize());
			missionstateTableList = (List<MissionStateTable>) page.getResult();
			for (MissionStateTable missonstate : missionstateTableList) {
				XtYhJbxx xtyhjbxx = (XtYhJbxx) this.commonService.get(XtYhJbxx.class, missonstate.getUserId());
				if (xtyhjbxx != null) {
					missonstate.setUserIdName(xtyhjbxx.getYhmc());
				}
				SystemTable systemtable = (SystemTable) this.commonService.get(SystemTable.class,
						missonstate.getSystemId());
				if (systemtable != null) {
					missonstate.setSystemIdName(systemtable.getSystemName());
				}
				if (missonstate.getGroupId() != null && missonstate.getGroupId().intValue() != 0) {
					XtJsJbxx xtjsjbxx = (XtJsJbxx) this.commonService.get(XtJsJbxx.class, missonstate.getGroupId());
					if (xtjsjbxx != null) {
						missonstate.setGroupIdName(xtjsjbxx.getJsmc());
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "nmstaskInfoListChild";
	}

	public void querymissionStateTable() {
		if (mypageNo > 0 && mypageSize > 0) {
			pageNo = mypageNo;
			pageSize = mypageSize;
		}
		try {
			systemtablelist = new HashSet<SystemTable>();
			// -- 准备查询条件

			// List<XtYhJsIndex> usergrouplist = this.commonService
			// .find(" from XtYhJsIndex t where t.yhbh like '%"
			// + this.getUser().getYhbh() + "%'");
			// // 根据用户组的id查找用户在和系统关系表
			// for (XtYhJsIndex usergroupref : usergrouplist) {
			// List<GorupSystemTable> groupsystemtable = this.commonService
			// .findByProperty(GorupSystemTable.class, "userGroupId",
			// usergroupref.getJsbh());
			// // 根据用户组查询系统
			// for (GorupSystemTable group : groupsystemtable) {
			// List<SystemTable> systables = this.commonService
			// .find(" from SystemTable s where s.systemState=0 and s.id="
			// + group.getSystemId());
			// if (systables != null && systables.size() > 0) {
			// systemtablelist.add(systables.get(0));
			// }
			// }
			// }

			if (from != null && !"".equals("")) {
				this.getRequest().setAttribute("from", from);
			}

			String mIds = this.getRequest().getParameter("mids");
			if (mIds != null && !"".equals(mIds)) {
				mIds = mIds.substring(0, mIds.length() - 1);
			}
			// 获取当前业务系统的信息
			systemTable = (SystemTable) this.commonService.get(SystemTable.class, this.getSystemID());
			Long loginUserId = this.getUserID();
			this.getRequest().setAttribute("loginUserId", loginUserId);
			// 查询任务
			// String sqlparam = "and 1=1 "; //管理员查看权限限制条件
			/*String sqlparam = " t.missionId > 0 "; // 管理员查看权限限制条件
			if (!this.getAdminMark()) { // 非管理员权限查看限制条件
				// sqlparam = " and ("
				sqlparam = " (" + " (t.viewLevel=1 and t.userId=" + this.getUserID() + " )"
						+ " or (t.viewLevel=2 and t.groupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='"
						+ this.getUser().getYhbh() + "' and x.type = 1)) " + " or (t.viewLevel=3 ) " + ") ";
			}*/
			String sqlparam = this.missionAuthHqlParams("t");//查看权限判断
			// String hql = " from MissionStateTable t where
			// t.missionName<>'应用升级' and t.missionName<>'配置正确性验证' " + sqlparam +
			// " ";
			String hql = " from MissionStateTable t where " + sqlparam + " ";
			// 查询条件
			// if (missionstatetable != null){
			if (missionName != null && !"".equals(missionName)) {
				hql += " and Upper(t.missionName) like '%" + missionName.toUpperCase() + "%'";
			}
			if (missionState != null && !"".equals(missionState)) {
				if ("3".equals(missionState)) {
					hql += " and t.missionState like '3%'";
				} else {
					hql += " and t.missionState=" + missionState;
				}
			}
			if (missionType != null && !"0".equals(missionType) && !"".equals(missionType)) {
				hql += " and t.missionType=" + missionType;
			}
			if (loopFlag != null && !"".equals(loopFlag)) {
				hql += " and t.loopFlag=" + loopFlag;
			}

			if (mId != null && !"".equals(mId)) {
				hql += " and t.missionId=" + Long.parseLong(mId);
			}

			/*if (!this.getAdminMark() && this.getSystemID() != null) {
				hql += " and t.systemId=" + this.getSystemID();
			}*/
			if (mIds != null && !"".equals(mIds)) {
				hql += " and t.missionId in (" + mIds + ")";
			}
			if (from != null && from.equals("pp")) {
				hql += " and (t.missionState = 3 or t.missionState = 30 or t.missionState = 31 or t.missionState = 32)"
						+ " and (t.isLook is null or t.isLook ='1' or (t.isLook = '0' and instr(t.lookUserIds,'"
						+ this.getUserID() + "')= 0 "
						+ " and instr(t.lookUserIds,to_char(t.userId))= 0) or (t.isLook ='0' and t.lookUserIds is null))";
			}
			hql += " order by t.createTime desc";
			page = this.commonService.findByPage(hql, pageNo, this.getPageSize());
			missionstateTableList = (List<MissionStateTable>) page.getResult();
			for (MissionStateTable missonstate : missionstateTableList) {
				XtYhJbxx xtyhjbxx = (XtYhJbxx) this.commonService.get(XtYhJbxx.class, missonstate.getUserId());
				if (xtyhjbxx != null) {
					missonstate.setUserIdName(xtyhjbxx.getYhmc());
				}
				if(missonstate.getSystemId() == -1){
					missonstate.setSystemIdName("ALL");
				}else{
					SystemTable systemtable = (SystemTable) this.commonService.get(SystemTable.class,
							missonstate.getSystemId());
					if (systemtable != null) {
						missonstate.setSystemIdName(systemtable.getSystemName());
					}
				}
				
				
				if (missonstate.getGroupId() != null && missonstate.getGroupId().intValue() != 0) {
					XtJsJbxx xtjsjbxx = (XtJsJbxx) this.commonService.get(XtJsJbxx.class, missonstate.getGroupId());
					if (xtjsjbxx != null) {
						missonstate.setGroupIdName(xtjsjbxx.getJsmc());
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 查询已完成但未查看的任务
	public List getTaskOfUnLook() {
		List unLookList = null;
		try {
			/*String sqlparam = " t.missionId > 0 ";
			if (!this.getAdminMark()) { // 非管理员权限查看限制条件
				sqlparam = " (" + " (t.viewLevel=1 and t.userId=" + this.getUserID() + " )"
						+ " or (t.viewLevel=2 and t.groupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='"
						+ this.getUser().getYhbh() + "' and x.type = 1)) " + " or (t.viewLevel=3 ) " + ") ";
			}*/
			String sqlparam = this.missionAuthHqlParams("t");//查看权限判断
			String hql = " from MissionStateTable t where  " + sqlparam + " ";
			hql += " and (t.missionState = 3 or t.missionState = 30 or t.missionState = 31 or t.missionState = 32) "
					+ " and (t.isLook is null or t.isLook ='1') and ((t.lookUserIds!='" + this.getUserID() + "' and "
					+ " instr(t.lookUserIds,'" + this.getUserID() + ",')!=1  and " + " t.lookUserIds not like '%,"
					+ this.getUserID() + "' and " + " instr(t.lookUserIds,'," + this.getUserID() + ",')=0 "
					+ " ) or t.lookUserIds is null )";
			/*if (!this.getAdminMark() && this.getSystemID() != null) {
				hql += " and t.systemId=" + this.getSystemID();
			}*/
			hql += " order by t.createTime desc ";
			page = this.commonService.findByPage(hql, pageNo, this.getPageSize());
			unLookList = (List<MissionStateTable>) page.getResult();

			StringBuffer out = new StringBuffer();
			out.append("<response>");
			if (unLookList != null && unLookList.size() > 0) {
				for (int i = 0; i < unLookList.size(); i++) {
					MissionStateTable objs = (MissionStateTable) unLookList.get(i);
					addTaskXmlDate(objs.getMissionName(), // name
							objs.getMissionId().toString(), // id
							objs.getMissionState().toString(),
							"/nmstaskManager/nmsTaskManager.do?action=query&from=pp&mId=" + objs.getMissionId(), // url
							out);
				}
			}
			out.append("</response>");
			outAjaxString(out.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	private void addTaskXmlDate(String name, String taskId, String mState, String url, StringBuffer out)
			throws Exception {
		String bathPath = getRequest().getContextPath();
		if (name != null && !name.equals("")) {
			out.append("<alarms>");
			out.append("<task_name>" + Common.toHTMLCode(name) + "</task_name>");
			out.append("<task_id>" + Common.toHTMLCode(taskId) + "</task_id>");
			out.append("<task_state>" + Common.toHTMLCode(mState) + "</task_state>");
			out.append("<url>" + Common.toHTMLCode(bathPath + url) + "</url>");
			out.append("</alarms>");
		}
	}

	public void saveFailedNodesTask() {
		try {
			commonService.beginTransaction();
			String oldMissionIdStr = this.getRequest().getParameter("oldMissionId");
			Long oldMissionId = Long.parseLong(oldMissionIdStr);
			MissionStateTable missionStateTable0 = (MissionStateTable) this.commonService.get(MissionStateTable.class,
					oldMissionId);
			if (missionStateTable0 == null) {
				outHtmlString(
						"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.noLinkInfo_n81i');window.history.go(-1);'</script>");
				return;
			}
			MissionStateTable stateTable = new MissionStateTable();
			BeanUtils.copyProperties(stateTable, missionStateTable0);

			stateTable.setMissionId(null);
			stateTable.setMissionName(missionstatetable.getMissionName());
			stateTable.setViewLevel(missionstatetable.getViewLevel());
			stateTable.setGroupId(missionstatetable.getGroupId());

			stateTable.setMissionState(1l);
			stateTable.setUserId(this.getUserID());
			stateTable.setCreateTime(new Date());

			stateTable.setMissionStateDesc("");// 清空任务结果具体信息描述 2013-3-8 hyx

			if (userEmailIds != null && userEmailIds.size() > 0) {
				StringBuffer ids = new StringBuffer();
				for (Long userId : userEmailIds) {
					ids.append("," + userId);
				}
				stateTable.setContactUserIds(ids.deleteCharAt(0).toString());
			} else {
				stateTable.setContactUserIds(null);
			}
			this.commonService.save(stateTable);// 提交任务状态
			this.addDBOperationRpt(commonService, "mission_state_table", "INSERT", stateTable.getMissionId());
			switch (stateTable.getMissionType().intValue()) {
			case 1:
				MissionParameterTable1 mpt1 = (MissionParameterTable1) this.commonService
						.get(MissionParameterTable1.class, oldMissionId);
				MissionParameterTable1 mpt10 = new MissionParameterTable1();
				BeanUtils.copyProperties(mpt10, mpt1);
				mpt10.setMissionId(stateTable.getMissionId());
				mpt10.setNodeGroupsId(nodeGroupsId);
				mpt10.setNodeIpsId(nodeIpsId);
				mpt10.setMissionDesc(missionDesc);
				this.commonService.save(mpt10);
				List<MissionFileInformation> mfi1List = this.commonService
						.find("from MissionFileInformation mfi where mfi.missionId = ?", oldMissionId);
				if (mfi1List != null && mfi1List.size() > 0) {
					for (MissionFileInformation mfi : mfi1List) {
						MissionFileInformation mfi0 = new MissionFileInformation();
						BeanUtils.copyProperties(mfi0, mfi);
						mfi0.setId(0);
						mfi0.setMissionId(stateTable.getMissionId());
						mfi0.setCreateTime(new Date());
						this.commonService.save(mfi0);
					}
				}
				break;
			case 4:
				MissionParameterTable4 mpt4 = (MissionParameterTable4) this.commonService
						.get(MissionParameterTable4.class, oldMissionId);
				MissionParameterTable4 mpt40 = new MissionParameterTable4();
				BeanUtils.copyProperties(mpt40, mpt4);
				mpt40.setMissionId(stateTable.getMissionId());
				mpt40.setNodeGroupsId(nodeGroupsId);
				mpt40.setNodeIpsId(nodeIpsId);
				mpt40.setMissionDesc(missionDesc);
				this.commonService.save(mpt40);
				break;
			case 6:
				MissionParameterTable6 mpt6 = (MissionParameterTable6) this.commonService
						.get(MissionParameterTable6.class, oldMissionId);
				MissionParameterTable6 mpt60 = new MissionParameterTable6();
				BeanUtils.copyProperties(mpt60, mpt6);
				mpt60.setMissionId(stateTable.getMissionId());
				mpt60.setNodeGroupsId(nodeGroupsId);
				mpt60.setNodeIpsId(nodeIpsId);
				mpt60.setMissionDesc(mpt6.getMissionDesc());
				mpt60.setOldTaskId(oldMissionId);
				mpt60.setVersion(null);
				this.commonService.save(mpt60);
				List<MissionFileInformation> mfi6List = this.commonService
						.find("from MissionFileInformation mfi where mfi.missionId = ?", oldMissionId);
				if (mfi6List != null && mfi6List.size() > 0) {
					for (MissionFileInformation mfi : mfi6List) {
						MissionFileInformation mfi0 = new MissionFileInformation();
						BeanUtils.copyProperties(mfi0, mfi);
						mfi0.setId(0);
						mfi0.setMissionId(stateTable.getMissionId());
						mfi0.setCreateTime(new Date());
						this.commonService.save(mfi0);
					}
				}
				break;
			default:
				break;
			}
			commonService.commit();
			sendMissionInfoId(stateTable.getMissionId(), 0l, commonService);
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');window.history.go(-1);</script>");
		}
		outHtmlString(
				"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.success_n81i');this.location='nmsTaskManager.do?action=query'</script>");
	}

	@SuppressWarnings("static-access")
	public void saveTaskbyType() {
		try {
			commonService.beginTransaction();
			// -- 命令参数格式校验
			// -- 2012-3-7 修改界面参数显示形式后不在进行格式校验，默认设置值为0
			commandParaCheck = 0;
			if (commandParaCheck != null && commandParaCheck.intValue() == 1) { // 执行校验
				String params = commandPara;
				try {
					if (StringUtils.isNotEmpty(params)) {
						String[] param = params.split(PARAM_SEPRATOR);
						for (String cp : param) {
							if (StringUtils.isEmpty(cp.trim())) {
								continue;
							}
							cp = cp.replaceAll("\n", "");
							cp = cp.replaceAll("\r", "");
							cp = cp.replaceAll("\t", "");
							if (missionstatetable != null && missionstatetable.getMissionType() != null) {
								switch (missionstatetable.getMissionType().intValue()) {
								case 1:
									ParamForM1 cfuo1 = (ParamForM1) JSONObject.toBean(JSONObject.fromObject(cp.trim()),
											ParamForM1.class);
									break;
								case 4:
									ParamForM4 cfuo2 = (ParamForM4) JSONObject.toBean(JSONObject.fromObject(cp.trim()),
											ParamForM4.class);
									break;
								case 6:
									ParamForM6 cfuo6 = (ParamForM6) JSONObject.toBean(JSONObject.fromObject(cp.trim()),
											ParamForM6.class);
									break;
								default:
									break;
								}
							}
						}
					} else {
						outHtmlString(
								"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.cmdFormatErr_n81i');window.history.go(-1);</script>");
						return;
					}
				} catch (Exception e) {
					e.printStackTrace();
					outHtmlString(
							"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.cmdFormatErrToDo_n81i');window.history.go(-1);</script>");
					return;
				}
			}
			// -- 2012-3-9
			// 修改界面参数显示形式后相应参数的处理：为有文件推送的List列表的各对象设置文件名，并将各对象转换为JSon字符串
			StringBuffer sb = new StringBuffer();
			Iterator<String> fileIterator = null;
			switch (missionstatetable.getMissionType().intValue()) {
			case 1:
				if (fileInfoFileName != null) {
					fileIterator = fileInfoFileName.iterator();
					for (int i = 0; i < paramM1.size(); i++) {
						ParamForM1 m1 = paramM1.get(i);
						if (m1 != null && fileIterator.hasNext()) {
							m1.setFileName(fileIterator.next());
							if (m1.getParam1() != null && m1.getParam1().trim().length() > 0) {// 密码加密保存
								m1.setParam1(DESUtil.desEncrypt(m1.getParam1().trim()));
							}
							FormBeanUtil.stripStringProperty(m1);
							sb.append(JSONObject.fromObject(m1).toString());
							sb.append(PARAM_SEPRATOR);
						}
					}
				}
				break;
			case 4:
				for (ParamForM4 m4 : paramM4) {
					if (m4 != null) {
						if (m4.getExecParamsTmpStr() != null && m4.getExecParamsTmpStr().trim().length() > 0) {
							// 将\r,\n,\t字符替换为空
							String execParamsTmpStr = m4.getExecParamsTmpStr().trim();
							execParamsTmpStr = execParamsTmpStr.replaceAll("[\n,\r,\t]", "");
							if (execParamsTmpStr.contains(STR_PARAM_SEPRATOR)) {
								m4.setExecParams(execParamsTmpStr.split(STR_PARAM_SEPRATOR));
							} else {
								m4.setExecParams(new String[] { execParamsTmpStr });
							}
							m4.setExecParamsTmpStr(null);
						}
						if (m4.getExceptTmpStr() != null && m4.getExceptTmpStr().trim().length() > 0) {
							// 将\r,\n,\t字符替换为空
							String exceptTmpStr = m4.getExceptTmpStr().trim();
							exceptTmpStr = exceptTmpStr.replaceAll("[\n,\r,\t]", "");
							if (exceptTmpStr.contains(STR_PARAM_SEPRATOR)) {
								m4.setExcept(exceptTmpStr.split(STR_PARAM_SEPRATOR));
							} else {
								m4.setExcept(new String[] { exceptTmpStr });
							}

							m4.setExceptTmpStr(null);
						}
						if (m4.getDeleteTmpStr() != null && m4.getDeleteTmpStr().trim().length() > 0) {
							// 将\r,\n,\t字符替换为空
							String deleteTmpStr = m4.getDeleteTmpStr().trim();
							deleteTmpStr = deleteTmpStr.replaceAll("[\n,\r,\t]", "");
							if (deleteTmpStr.contains(STR_PARAM_SEPRATOR)) {
								m4.setDelete(deleteTmpStr.split(STR_PARAM_SEPRATOR));
							} else {
								m4.setDelete(new String[] { deleteTmpStr });
							}
							m4.setDeleteTmpStr(null);
						}
						if (m4.getParam1() != null && m4.getParam1().trim().length() > 0) {// 密码加密保存
							m4.setParam1(DESUtil.desEncrypt(m4.getParam1().trim()));
						}
						FormBeanUtil.stripStringProperty(m4);// 去空格
						if (m4.getPidFile() != null && m4.getPidFile().trim().length() > 0) {// 停用进程特殊处理
							sb.append(m4.getPidFile());
							sb.append(PARAM_SEPRATOR);
						} else {
							JSONObject object = this.handleJSonObjectRemoveEmpty(JSONObject.fromObject(m4));
							sb.append(object.toString());
							sb.append(PARAM_SEPRATOR);
						}
					}
				}
				break;
			case 6:
				if (fileInfoFileName != null) {
					fileIterator = fileInfoFileName.iterator();
					for (int i = 0; i < paramM6.size(); i++) {
						ParamForM6 m6 = paramM6.get(i);
						if (m6 != null && fileIterator.hasNext()) {
							m6.setFileName(fileIterator.next());// 设置推送文件名
							if (m6.getExecParamsTmpStr() != null && m6.getExecParamsTmpStr().trim().length() > 0) {
								String execParamsTmpStr = m6.getExecParamsTmpStr().trim();
								// 将\r,\n,\t字符替换为空
								execParamsTmpStr = execParamsTmpStr.replaceAll("[\n,\r,\t]", "");
								if (execParamsTmpStr.contains(STR_PARAM_SEPRATOR)) {
									m6.setExecParams(execParamsTmpStr.split(STR_PARAM_SEPRATOR));
								} else {
									m6.setExecParams(new String[] { execParamsTmpStr });
								}
								m6.setExecParamsTmpStr(null);
							}
							if (m6.getDeleteTmpStr() != null && m6.getDeleteTmpStr().trim().length() > 0) {
								// 将\r,\n,\t字符替换为空
								String deleteTmpStr = m6.getDeleteTmpStr().trim();
								deleteTmpStr = deleteTmpStr.replaceAll("[\n,\r,\t]", "");
								if (deleteTmpStr.contains(STR_PARAM_SEPRATOR)) {
									m6.setDelete(deleteTmpStr.split(STR_PARAM_SEPRATOR));
								} else {
									m6.setDelete(new String[] { deleteTmpStr });
								}
								m6.setDeleteTmpStr(null);
							}
							if (m6.getBackups() != null) {
								List<Backup> backUpCopy = new ArrayList<Backup>();
								for (Backup backup : m6.getBackups()) {
									if (backup != null) {
										if (backup.getExceptTmpStr() != null
												&& backup.getExceptTmpStr().trim().length() > 0) {
											// 将\r,\n,\t字符替换为空
											String exceptTmpStr = backup.getExceptTmpStr().trim();
											exceptTmpStr = exceptTmpStr.replaceAll("[\n,\r,\t]", "");
											if (exceptTmpStr.contains(STR_PARAM_SEPRATOR)) {
												backup.setExcept(exceptTmpStr.split(STR_PARAM_SEPRATOR));
											} else {
												backup.setExcept(new String[] { exceptTmpStr });
											}
											backup.setExceptTmpStr(null);
										}
										FormBeanUtil.stripStringProperty(backup);
										backUpCopy.add(backup);
									}
								}
								m6.getBackups().clear();
								m6.getBackups().addAll(backUpCopy);
							}
							if (m6.getParam1() != null && m6.getParam1().trim().length() > 0) {// 密码加密保存
								m6.setParam1(DESUtil.desEncrypt(m6.getParam1().trim()));
							}
							FormBeanUtil.stripStringProperty(m6);
							JSONObject object = this.handleJSonObjectRemoveEmpty(JSONObject.fromObject(m6));
							sb.append(object.toString());
							sb.append(PARAM_SEPRATOR);
						}
					}
				}
				break;
			default:
				break;
			}
			commandPara = sb.toString();
			// 根据用户和业务系统确定一个,missionType 1—文件推送,2—非流文本数据获取
			if (missionstatetable != null && missionstatetable.getMissionType() == 1) {// 文件推送
				// -- 保存上传文件
				List<MissionFileInformation> fileList = new LinkedList<MissionFileInformation>();
				MD5Util md5 = new MD5Util();
				// -- 获取上传路径
				String uploadFilePath = getConfigValue("uploadServerPath");
				// -- 上传目录不存在则创建
				File f = new File(uploadFilePath);
				if (!f.exists()) {
					f.mkdirs();
				}
				// -- 文件上传操作
				StringBuffer oneFileInfo = new StringBuffer("");
				if (fileInfoFileName != null && fileInfoFileName.size() > 0) {
					File inputfile = null;
					long onefile = 0l;
					String size = "";
					long sum = 0l;
					for (int i = 0; i < fileInfoFileName.size(); i++) {
						// -- 文件名称处理
						String fileName0 = Common.addTimeTagForUploadFileName(fileInfoFileName.get(i));
						// -- 上传路径设置
						String filePath = uploadFilePath + File.separator + fileName0;
						String fenString = System.getProperty("file.encoding");
						filePath = new String(filePath.getBytes(), fenString);
						// -- 拷贝文件
						this.copy(fileInfo.get(i), new File(filePath));
						pl(getI18nText("i18n_NmsTaskManagerAction.executeAction.uploadOk_n81i")+"：" + fileInfoFileName.get(i));
						oneFileInfo.append(getI18nText("i18n_NmsTaskManagerAction.executeAction.fileName_n81i")+"：" + fileName0);
						inputfile = new File(filePath);
						// 附件大小字节
						onefile = fu.getFileSizes(inputfile);
						// 附件大小（K/M/G）
						size = fu.FormetFileSize(onefile);
						pl(getI18nText("i18n_NmsTaskManagerAction.executeAction.fileSize_n81i")+":" + onefile + "-----" + size);
						oneFileInfo.append(getI18nText("i18n_NmsTaskManagerAction.executeAction.fileSize_n81i")+"：" + size);
						// 计算总大小
						sum = sum + onefile;
						MissionFileInformation fileInformation = new MissionFileInformation();
						fileInformation.setFileName(fileName0);
						fileInformation.setCreateTime(new Date());
						fileInformation.setMd5Value(md5.getFileMD5String(new File(filePath)));
						fileList.add(fileInformation);
					}

					size = fu.FormetFileSize(sum);
					oneFileInfo.append(getI18nText("i18n_NmsTaskManagerAction.executeAction.fileTotalSize_n81i")+"：" + size);
					// System.out.println("附件总大小:"+size);

				} else {
					outHtmlString(
							"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.addPushFile_n81i');window.history.go(-1);</script>");
					return;
				}
				// -- 保存任务
				missionstatetable.setMissionState(1l);
				missionstatetable.setUserId(this.getUserID());
				missionstatetable.setCreateTime(new Date());
				missionstatetable.setLoopFlag(0L);

				StringBuffer userEmailIdsStr = new StringBuffer();
				if (userEmailIds != null && userEmailIds.size() > 0) {
					for (Iterator eIte = userEmailIds.iterator(); eIte.hasNext();) {
						Long id = (Long) eIte.next();
						userEmailIdsStr.append("," + id);
					}
					userEmailIdsStr.delete(0, 1);
				}
				missionstatetable.setContactUserIds(userEmailIdsStr.toString());

				missionstatetable.setMissionStateDesc("");// 清空任务结果具体信息描述
															// 2013-3-8 hyx

				this.commonService.save(missionstatetable);// 提交任务状态

				// 将更新操作写到操作日志中
				this.addDBOperationRpt(commonService, "mission_state_table", "INSERT", missionstatetable.getMissionId(),
						oneFileInfo.toString());

				if (missionparametertable1 == null) {
					missionparametertable1 = new MissionParameterTable1();
				}
				// -- 保存任务参数
				missionparametertable1.setMissionId(missionstatetable.getMissionId());
				missionparametertable1.setNodeGroupsId(nodeGroupsId);
				missionparametertable1.setNodeIpsId(getRequest().getParameter("nodeIpsId"));
				missionparametertable1.setMissionDesc(missionDesc);
				missionparametertable1.setCommandPara(commandPara);
				this.commonService.save(missionparametertable1);// 提交文件推送的参数
				// 将更新操作写到操作日志中
				this.addDBOperationRpt(commonService, "mission_parameter_table1", "INSERT",
						missionstatetable.getMissionId());
				// -- 保存上传文件信息
				for (Iterator iterator = fileList.iterator(); iterator.hasNext();) {
					MissionFileInformation missionFileInformation = (MissionFileInformation) iterator.next();
					missionFileInformation.setMissionId(missionstatetable.getMissionId());
					this.commonService.save(missionFileInformation);
				}
				// 将更新操作写到操作日志中
				this.addDBOperationRpt(commonService, "mission_File_Information", "INSERT",
						missionstatetable.getMissionId());
				// 通知NMSServer 启动任务下发
				// sendInfo(missionstatetable.getMissionId(),0l,new
				// File(fileName));
				sendMissionInfoId(missionstatetable.getMissionId(), 0l, commonService);
			}
			if (missionstatetable != null && missionstatetable.getMissionType() == 4) {
				// 保存任务
				missionstatetable.setUserId(this.getUserID());
				missionstatetable.setCreateTime(new Date());
				// if (missionstatetable != null
				// && missionstatetable.getLoopFlag() == 1) { //周期任务状态保存0
				// missionstatetable.setMissionState(0l);
				// } else {
				// }
				missionstatetable.setMissionState(1l);

				StringBuffer userEmailIdsStr = new StringBuffer();
				if (userEmailIds != null && userEmailIds.size() > 0) {
					for (Iterator eIte = userEmailIds.iterator(); eIte.hasNext();) {
						Long id = (Long) eIte.next();
						userEmailIdsStr.append("," + id);
					}
					userEmailIdsStr.delete(0, 1);
				}
				missionstatetable.setContactUserIds(userEmailIdsStr.toString());

				missionstatetable.setMissionStateDesc("");// 清空任务结果具体信息描述
															// 2013-3-8 hyx

				this.commonService.save(missionstatetable);// 提交任务状态
				// 将更新操作写到操作日志中
				this.addDBOperationRpt(commonService, "mission_state_table", "INSERT",
						missionstatetable.getMissionId());
				missionparameteriable4.setMaxReturn(1024l);
				missionparameteriable4.setNodeGroupsId(nodeGroupsId);
				missionparameteriable4.setNodeIpsId(getRequest().getParameter("nodeIpsId"));
				missionparameteriable4.setMissionDesc(missionDesc);
				missionparameteriable4.setCommandPara(commandPara);
				// 保存时间
				missionparameteriable4.setMissionId(missionstatetable.getMissionId());
				this.commonService.save(missionparameteriable4);
				// 将更新操作写到操作日志中
				this.addDBOperationRpt(commonService, "mission_parameter_table4", "INSERT",
						missionstatetable.getMissionId());

				sendMissionInfoId(missionstatetable.getMissionId(), 0l, commonService);
			}
			if (missionstatetable != null && missionstatetable.getMissionType() == 6) {
				// -- 保存上传文件
				List<MissionFileInformation> fileList = new LinkedList<MissionFileInformation>();
				MD5Util md5 = new MD5Util();
				// -- 获取上传路径
				String uploadFilePath = getConfigValue("uploadServerPath");
				// -- 上传目录不存在则创建
				File f = new File(uploadFilePath);
				if (!f.exists()) {
					f.mkdirs();
				}
				// -- 文件上传操作
				StringBuffer oneFileInfo = new StringBuffer("");
				if (fileInfoFileName != null && fileInfoFileName.size() > 0) {
					File inputfile = null;
					long onefile = 0l;
					String size = "";
					long sum = 0l;
					for (int i = 0; i < fileInfoFileName.size(); i++) {
						// -- 文件名称处理
						String fileName0 = Common.addTimeTagForUploadFileName(fileInfoFileName.get(i));
						// -- 上传路径设置
						String filePath = uploadFilePath + File.separator + fileName0;
						String fenString = System.getProperty("file.encoding");
						filePath = new String(filePath.getBytes(), fenString);
						// -- 拷贝文件
						this.copy(fileInfo.get(i), new File(filePath));
						pl("上传 ok ：" + fileInfoFileName.get(i));
						oneFileInfo.append(getI18nText("i18n_NmsTaskManagerAction.executeAction.fileName_n81i")+"：" + fileName0);
						inputfile = new File(filePath);
						// 附件大小
						onefile = fu.getFileSizes(inputfile);
						size = fu.FormetFileSize(onefile);
						oneFileInfo.append(getI18nText("i18n_NmsTaskManagerAction.executeAction.fileSize_n81i")+"：" + size);
						// 计算总大小
						sum = sum + onefile;
						MissionFileInformation fileInformation = new MissionFileInformation();
						fileInformation.setFileName(fileName0);
						fileInformation.setCreateTime(new Date());
						fileInformation.setMd5Value(md5.getFileMD5String(new File(filePath)));
						fileList.add(fileInformation);
					}
					size = fu.FormetFileSize(sum);
					oneFileInfo.append(getI18nText("i18n_NmsTaskManagerAction.executeAction.fileTotalSize_n81i")+"：" + size);
					// System.out.println(size);
				} else {
					outHtmlString(
							"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.addPushFile_n81i');window.history.go(-1);</script>");
					return;
				}
				// -- 保存任务
				missionstatetable.setMissionState(1l);
				missionstatetable.setUserId(this.getUserID());
				missionstatetable.setCreateTime(new Date());
				missionstatetable.setLoopFlag(0L);

				StringBuffer userEmailIdsStr = new StringBuffer();
				if (userEmailIds != null && userEmailIds.size() > 0) {
					for (Iterator eIte = userEmailIds.iterator(); eIte.hasNext();) {
						Long id = (Long) eIte.next();
						userEmailIdsStr.append("," + id);
					}
					userEmailIdsStr.delete(0, 1);
				}
				missionstatetable.setContactUserIds(userEmailIdsStr.toString());
				missionstatetable.setMissionStateDesc("");// 清空任务结果具体信息描述
															// 2013-3-8 hyx

				this.commonService.save(missionstatetable);// 提交任务状态
				// 将更新操作写到操作日志中
				this.addDBOperationRpt(commonService, "mission_state_table", "INSERT", missionstatetable.getMissionId(),
						oneFileInfo.toString());
				if (missionparametertable6 == null) {
					missionparametertable6 = new MissionParameterTable6();
				}
				// -- 保存任务参数
				missionparametertable6.setMissionId(missionstatetable.getMissionId());
				missionparametertable6.setNodeGroupsId(nodeGroupsId);
				missionparametertable6.setNodeIpsId(getRequest().getParameter("nodeIpsId"));
				missionparametertable6.setMissionDesc(missionDesc);
				// 校验值，设置为MD5加密后文件
				// missionparametertable6.setCommandId(missionparameteriable4.getCommandId());
				missionparametertable6.setCommandEName(missionparameteriable4.getCommandEName());
				missionparametertable6.setCommandPara(commandPara);
				missionparametertable6.setCommandType(missionparameteriable4.getCommandType());
				// missionparametertable6.setVersion(getMaxVersion());//升级部署的逆向任务将version字段作为原任务的任务Id字段
				this.commonService.save(missionparametertable6);// 提交文件推送的参数
				// 将更新操作写到操作日志中
				this.addDBOperationRpt(commonService, "mission_parameter_table6", "INSERT",
						missionstatetable.getMissionId());
				// -- 保存上传文件信息
				for (Iterator iterator = fileList.iterator(); iterator.hasNext();) {
					MissionFileInformation missionFileInformation = (MissionFileInformation) iterator.next();
					missionFileInformation.setMissionId(missionstatetable.getMissionId());
					this.commonService.save(missionFileInformation);
				}
				// 将更新操作写到操作日志中
				this.addDBOperationRpt(commonService, "mission_File_Information", "INSERT",
						missionstatetable.getMissionId());
				// sendInfo(missionstatetable.getMissionId(),0l,new
				// File(fileName));
				commonService.commit();
				logger.debug("开始发送任务信息，任务id：" + missionstatetable.getMissionId());
				sendMissionInfoId(missionstatetable.getMissionId(), 0l, commonService);
			}

			// 记录用户操作用于设置向导
			if (fromWhere != null && !"".equals(fromWhere)) {
				if (fromWhere.equals("formGuide")) {
					outHtmlString(
							"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.success_n81i');this.location='nmsTaskManager.do?action=query&isComplete=0'</script>");
				}
			} else {
				outHtmlString(
						"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.success_n81i');this.location='nmsTaskManager.do?action=query'</script>");
			}
			
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');this.location='nmsTaskManager.do?action=query'</script>");
		}
	}

	/**
	 * 
	 * 保存逆向任务：升级部署类型的任务才可逆向
	 * 
	 * @author hyx Mar 21, 2012
	 * @version 1.0
	 */
	public void saveConverseTask() {
		try {
			commonService.beginTransaction();
			// -- 2012-3-9
			// 修改界面参数显示形式后相应参数的处理：为有文件推送的List列表的各对象设置文件名，并将各对象转换为JSon字符串？？

			// 命令参数--循环处理,合并成json字符串-开始
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < paramM6.size(); i++) {
				ParamForM6 m6 = paramM6.get(i);
				if (m6 != null) {
					// 启动参数临时字符串处理，生成字符数组
					if (m6.getExecParamsTmpStr() != null && m6.getExecParamsTmpStr().trim().length() > 0) {
						// 将\r,\n,\t字符替换为空
						String execParamsTmpStr = m6.getExecParamsTmpStr().trim();
						execParamsTmpStr = execParamsTmpStr.replaceAll("[\n,\r,\t]", "");
						if (execParamsTmpStr.contains(STR_PARAM_SEPRATOR)) {
							m6.setExecParams(execParamsTmpStr.split(STR_PARAM_SEPRATOR));
						} else {
							m6.setExecParams(new String[] { execParamsTmpStr });
						}
						m6.setExecParamsTmpStr(null);
					}
					// 恢复参数处理，恢复参数对象为空的去掉
					if (m6.getRecoverys() != null) {
						List<CoverUpdate> recoveryCopy = new ArrayList<CoverUpdate>();
						for (CoverUpdate recovery : m6.getRecoverys()) {
							if (recovery != null) {
								// 将恢复的"删除文件"临时字符串处理，生成字符数组
								if (recovery != null && recovery.getDeleteTmpStr() != null
										&& recovery.getDeleteTmpStr().trim().length() > 0) {
									// 将\r,\n,\t字符替换为空
									String deleteTmpStr = recovery.getDeleteTmpStr().trim();
									deleteTmpStr = deleteTmpStr.replaceAll("[\n,\r,\t]", "");
									if (deleteTmpStr.contains(STR_PARAM_SEPRATOR)) {
										recovery.setDelete(deleteTmpStr.split(STR_PARAM_SEPRATOR));
									} else {
										recovery.setDelete(new String[] { deleteTmpStr });
									}
									recovery.setDeleteTmpStr(null);
								}
								FormBeanUtil.stripStringProperty(recovery);
								recoveryCopy.add(recovery);
							}
						}
						m6.getRecoverys().clear();
						m6.getRecoverys().addAll(recoveryCopy);
					}

					// 备份参数处理，备份参数对象为空的去掉
					if (m6.getBackups() != null) {
						List<Backup> backUpCopy = new ArrayList<Backup>();
						for (Backup backup : m6.getBackups()) {
							if (backup != null) {
								// 将备份的"排除文件"临时字符串处理，生成字符数组
								if (backup != null && backup.getExceptTmpStr() != null
										&& backup.getExceptTmpStr().trim().length() > 0) {
									// 将\r,\n,\t字符替换为空
									String exceptTmpStr = backup.getExceptTmpStr().trim();
									exceptTmpStr = exceptTmpStr.replaceAll("[\n,\r,\t]", "");
									if (exceptTmpStr.contains(STR_PARAM_SEPRATOR)) {// 多个排除文件
										backup.setExcept(exceptTmpStr.split(STR_PARAM_SEPRATOR));
									} else {// 一个排除文件
										backup.setExcept(new String[] { exceptTmpStr });
									}
									backup.setExceptTmpStr(null);
								}
								FormBeanUtil.stripStringProperty(backup);
								backUpCopy.add(backup);
							}
						}
						m6.getBackups().clear();
						m6.getBackups().addAll(backUpCopy);
					}
					FormBeanUtil.stripStringProperty(m6);
					JSONObject object = this.handleJSonObjectRemoveEmpty(JSONObject.fromObject(m6));
					sb.append(object.toString());
					sb.append(PARAM_SEPRATOR);
				}
			}
			commandPara = sb.toString();
			// 命令参数--循环处理,合并成json字符串-结束

			// -- 设置任务相关信息-保存任务-开始
			missionstatetable.setMissionState(1l);
			missionstatetable.setUserId(this.getUserID());
			missionstatetable.setCreateTime(new Date());
			missionstatetable.setLoopFlag(0L);
			// 设置任务联系人Id
			StringBuffer userEmailIdsStr = new StringBuffer();
			if (userEmailIds != null && userEmailIds.size() > 0) {
				for (Iterator eIte = userEmailIds.iterator(); eIte.hasNext();) {
					Long id = (Long) eIte.next();
					userEmailIdsStr.append("," + id);
				}
				userEmailIdsStr.delete(0, 1);
			}
			missionstatetable.setContactUserIds(userEmailIdsStr.toString());
			missionstatetable.setMissionStateDesc("");// 清空任务结果具体信息描述 2013-3-8
														// hyx
			this.commonService.save(missionstatetable);// 提交任务状态
			// -- 设置任务相关信息-保存任务-结束
			// 将更新操作写到操作日志中
			this.addDBOperationRpt(commonService, "mission_state_table", "INSERT", missionstatetable.getMissionId());
			// -- 保存任务参数
			if (missionparametertable6 == null) {
				missionparametertable6 = new MissionParameterTable6();
			}
			missionparametertable6.setMissionId(missionstatetable.getMissionId());// 怎么获得的
			missionparametertable6.setNodeGroupsId(nodeGroupsId);
			missionparametertable6.setNodeIpsId(getRequest().getParameter("nodeIpsId"));
			missionparametertable6.setMissionDesc(missionDesc);
			missionparametertable6.setCommandPara(commandPara);
			this.commonService.save(missionparametertable6);// 提交文件推送的参数
			// 将更新操作写到操作日志中
			this.addDBOperationRpt(commonService, "mission_parameter_table6", "INSERT",
					missionstatetable.getMissionId());
			// 给Server端发送信息
			sendMissionInfoId(missionstatetable.getMissionId(), 0l, commonService);

			// 记录用户操作用于设置向导
			if (fromWhere != null && !"".equals(fromWhere)) {
				if (fromWhere.equals("formGuide")) {
					outHtmlString(
							"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.success_n81i');this.location='nmsTaskManager.do?action=query&isComplete=0'</script>");
				}
			} else {
				outHtmlString(
						"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.success_n81i');this.location='nmsTaskManager.do?action=query'</script>");
			}
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			outHtmlString(
					"<script type=\"text/javascript\">alert('操作失败');this.location='nmsTaskManager.do?action=query'</script>");
		}
	}

	private void pl(Object ss) {
		System.out.println("" + ss == null ? null : ss.toString());
	}

	private void p(Object ss) {
		System.out.print("" + ss.toString());
	}

	/*
	 * 查询系统下面的节点组
	 */
	@SuppressWarnings("unchecked")
	public String toQueryrefpro(String systemid) {
		try {
			systemid = "1";
			StringBuilder out = new StringBuilder();

			out.append("<response>");
			if ("1".equals(this.ajaxtype)) {
				nodegrouptables = this.commonService
						.find(" from NodegroupTable n where n.isValid=1 and n.systemId=" + systemid);
				nodegrouptables = this.commonService.findByProperty(NodegroupTable.class, "systemId",
						Long.valueOf(systemid));
				for (NodegroupTable nodegroup : nodegrouptables) {
					out.append("<filed>");
					out.append("<id>" + nodegroup.getGroupId() + "</id>");
					out.append("<name>" + nodegroup.getGroupName() + "</name>");
					out.append("</filed>");
				}
				mossionparameterdefaults = this.commonService.findByProperty(MissionParameterDefaults.class, "systemId",
						Long.valueOf(systemid));
				for (MissionParameterDefaults mossionparameterdefault : mossionparameterdefaults) {
					out.append("<paramfiled>");
					out.append("<id>" + mossionparameterdefault.getId() + "</id>");
					out.append("<name>" + mossionparameterdefault.getMissionTypeName() + "</name>");
					out.append("</paramfiled>");
				}
				// 根据当前用户查找用户组
				List<XtYhJsIndex> userrefgroups = this.commonService
						.find(" from XtYhJsIndex where type=1 and yhId=" + this.getUserID());
				HashSet<XtJsJbxx> setxtjs = new HashSet<XtJsJbxx>();
				for (XtYhJsIndex xt : userrefgroups) {
					// 根据系统和当前用户组查找用户组关系
					List<GorupSystemTable> groupsystables = this.commonService
							.find("from GorupSystemTable g where g.userGroupId=" + xt.getJsbh() + " and g.systemId="
									+ Long.valueOf(systemid));
					// 添加到页面用户组
					for (GorupSystemTable grouptable : groupsystables) {
						@SuppressWarnings("unused")
						List<XtJsJbxx> grouplist = this.commonService
								.find("from XtJsJbxx x   where  x.type=1 and  x.jsbh=" + grouptable.getUserGroupId());
						XtJsJbxx xtjs = (XtJsJbxx) this.commonService.get(XtJsJbxx.class, grouptable.getUserGroupId());
						setxtjs.add(xtjs);
					}
				}
				for (XtJsJbxx jbxx : setxtjs) {
					out.append("<usergroupfiled>");
					out.append("<id>" + jbxx.getJsbh() + "</id>");
					out.append("<name>" + jbxx.getJsmc() + "</name>");
					out.append("</usergroupfiled>");
				}
			}
			if ("2".equals(this.ajaxtype)) {
				// 用户组和用户的关系表和角色和用户关系表相同。角色表中type=1表示是用户组
				List<XtYhJsIndex> tempref = this.commonService.findByProperty(XtYhJsIndex.class, "jsbh",
						Long.valueOf(systemid));
				for (XtYhJsIndex xtyhjsjndex : tempref) {
					XtYhJbxx xtyhjbxx = null;
					List<XtYhJbxx> xtyhjbxxs = (List<XtYhJbxx>) this.commonService.findByProperty(XtYhJbxx.class,
							"yhbh", xtyhjsjndex.getYhbh());
					if (xtyhjbxxs != null && xtyhjbxxs.size() > 0) {
						xtyhjbxx = xtyhjbxxs.get(0);
					}
					out.append("<filed>");
					out.append("<id>" + xtyhjbxx.getYhid() + "</id>");
					out.append("<name>" + xtyhjbxx.getYhmc() + "</name>");
					out.append("</filed>");
				}
			}
			out.append("</response>");
			// ajax的输出
			this.getResponse().setContentType("application/xml");
			this.getResponse().setCharacterEncoding("utf-8");
			this.getResponse().setHeader("Cache-Control", "no-cache");
			PrintWriter pw = this.getResponse().getWriter();
			pw.write(out.toString());
			pw.close();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');this.location='nmsTaskManager.do?action=query'</script>");
		}
		return null;
	}

	public String editViewLevel() {
		Long loginUserId = this.getUserID();
		String missionId = this.getRequest().getParameter("missionId");
		try {
			missionstatetable = (MissionStateTable) this.commonService.get(MissionStateTable.class,
					Long.parseLong(missionId));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.getRequest().setAttribute("loginUserId", loginUserId);
		return "editViewLevel";
	}

	public String updateViewLevel() {
		// String missionIdStr = this.getRequest().getParameter("missionId");
		// String missionViewLevelStr =
		// this.getRequest().getParameter("missionViewLevel");
		try {
			if (missionstatetable != null && missionstatetable.getMissionId() != null
					&& StringUtils.isNotBlank(missionstatetable.getMissionName())
					&& missionstatetable.getViewLevel() != null) {
				String hql = "update MissionStateTable mst set mst.missionName='" + missionstatetable.getMissionName()
						+ "',mst.viewLevel=" + missionstatetable.getViewLevel() + ",mst.groupId="
						+ missionstatetable.getGroupId() + " where mst.missionId=" + missionstatetable.getMissionId();
				commonService.updateByHql(hql);
				// commonService.updateByHql("update MissionStateTable mst set
				// mst.missionName=?,mst.viewLevel=? where mst.missionId=?",
				// missionstatetable.getMissionName(),missionstatetable.getViewLevel(),missionstatetable.getMissionId());
				outHtmlString(
						"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.success_n81i');this.location='nmsTaskManager.do?action=query'</script>");
			} else {
				outHtmlString(
						"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');this.location='nmsTaskManager!execute.do?action=query&pageNo="
								+ pageNo + "&pageSize=" + pageSize + "';</script>");
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("任务查看修改信息失败", e);
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');this.location='nmsTaskManager!execute.do?action=query&pageNo="
							+ pageNo + "&pageSize=" + pageSize + "';</script>");
		}
		return null;
	}

	// 查询业务系统和用户组信息等等
	public void getNMSsystem() {
		// 查询没有被删除的业务系统
		try {
			// 查询当前用户所在的用户组
			List<XtYhJsIndex> usergrouplist = this.commonService
					.find("from XtYhJsIndex t  where type=1 and  t.yhId = " + this.getUserID());
			// 根据用户组的id查找用户在和系统关系表
			// systemtablelist = new HashSet<SystemTable>();
			// for (XtYhJsIndex usergroupref : usergrouplist) {
			// List<GorupSystemTable> groupsystemtable = this.commonService
			// .findByProperty(GorupSystemTable.class, "userGroupId",
			// usergroupref.getJsbh());
			// // 根据用户组查询系统
			// for (GorupSystemTable group : groupsystemtable) {
			// List<SystemTable> systables = this.commonService
			// .find(" from SystemTable s where s.systemState=0 and s.id="
			// + group.getSystemId());
			// if (systables != null && systables.size() > 0) {
			// systemtablelist.add(systables.get(0));
			// }
			// }
			// }
			// 获取当前业务系统的信息
			if(this.getAdminMark()){
				systemTable = new SystemTable();
				systemTable.setSystemId(-1L);
				systemTable.setSystemName("ALL");
			}else{
				systemTable = (SystemTable) this.commonService.get(SystemTable.class, this.getSystemID());
			}
			
			// nodegrouptables = this.commonService
			// .findByProperty(NodegroupTable.class,
			// "systemId",systemTable.getSystemId());
			queryNodeGroupInfo();
			// 查找用户组
			usergroupLists = this.commonService.findByProperty(XtJsJbxx.class, "type", 1l);
			// 根据当前用户查找用户组
			List<XtYhJsIndex> userrefgroups = this.commonService
					.find(" from XtYhJsIndex where type=1 and yhId=" + this.getUserID());
			HashSet<XtJsJbxx> setxtjs = new HashSet<XtJsJbxx>();
			for (XtYhJsIndex xt : userrefgroups) {
				// 根据系统和当前用户组查找用户组关系
				List<GorupSystemTable> groupsystables = this.commonService
						.find("from GorupSystemTable g where g.userGroupId=" + xt.getJsbh() + " and g.systemId="
								+ this.getSystemID());
				// 添加到页面用户组
				for (GorupSystemTable grouptable : groupsystables) {
					@SuppressWarnings("unused")
					List<XtJsJbxx> grouplist = this.commonService
							.find("from XtJsJbxx x   where  x.type=1 and  x.jsbh=" + grouptable.getUserGroupId());
					XtJsJbxx xtjs = (XtJsJbxx) this.commonService.get(XtJsJbxx.class, grouptable.getUserGroupId());
					setxtjs.add(xtjs);
				}
			}
			this.getRequest().setAttribute("setxtjs", setxtjs);
			// 查询命令
			ordertablelist = this.commonService.find("from OrderTable  o  where  o.isValid=1");
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');this.location='nmsTaskManager.do?action=query'</script>");
		}
	}

	public void queryNodeGroupInfo() {
		try {
			String hql = "from NodegroupTable where 1=1";
			String sqlCondition = "where 1=1";
			if (!this.getAdminMark()) {
				// 如果当前登录选择了业务系统，则只做和本业务系统相关的操作
				if (this.getSystemID() != null) {
					hql += " and systemId = " + this.getSystemID();
					sqlCondition += " and system_id=" + this.getSystemID();
				}
				// 1 发布人查看,2 发布人所在组查看,3 系统内全部人员可看
				hql += " and (";
				hql += " (viewLevel=1 and createUserId=" + this.getUserID() + ")";
				hql += " or (viewLevel=2 and createUsergroupId in (select jsbh from XtYhJsIndex "
						+ " where type=1 and yhbh='" + this.getUser().getYhbh() + "') )";
				if (this.getSystemID() != null) {
					hql += " or (viewLevel=3 and systemId=" + this.getSystemID() + ")";
				} else {
					hql += " or (viewLevel=3 and systemId in"
							+ " (select systemId from GorupSystemTable where userGroupId in"
							+ " (select jsbh from XtYhJsIndex where type=1 and yhbh='" + this.getUser().getYhbh() + "')"
							+ " ) )";
				}
				hql += ")";
			}
			hql += " and nvl(isValid,0)=1";
			hql += " order by isValid desc,groupCreatetime desc";
			sqlCondition += " order by is_valid asc,Group_createtime desc";

			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "nodegroup_table");

			nodegrouptables = (List<NodegroupTable>) this.commonService.find(hql);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 查询用户联系信息
	 * 
	 * @time Feb 3, 2012-3:50:28 PM
	 * @return
	 */
	private String queryUserInfo() {
		String viewType = this.getRequest().getParameter("viewType");
		String userGroupId = this.getRequest().getParameter("userGroupId");
		pl(viewType + " ********** " + userGroupId);
		List<XtYhJbxx> usersLists = new ArrayList<XtYhJbxx>();
		if (StringUtils.isNotEmpty(viewType)) {
			int type0 = Integer.parseInt(viewType);
			if (type0 == 4) { // 无限制 无需查询
				return null;
			} else if (type0 == 1) { // 个人
				usersLists.add(this.getUser());
			} else { // 用户组 或 系统下用户
				/*
				 * select xyj.yhid,xyj.yhmc,xyj.email from xt_yh_jbxx xyj left
				 * join xt_yh_js_index xyji on xyji.yhid = xyj.yhid left join
				 * xt_js_jbxx xjj on xjj.jsbh = xyji.jsbh left join
				 * gorup_system_table gst on gst.user_group_id = xjj.jsbh where
				 * xyji.jsbh = 9 and gst.system_id = 3 and xyj.zxbz = 0 --用户
				 * 有效标识 and xjj.type = 1 --业务维护组标识 and xjj.zxbz = 0 --业务维护组有效状态
				 */
				StringBuffer sql = new StringBuffer();
				sql.append("select distinct xyj.yhid,xyj.yhmc,xyj.email ");
				sql.append("from xt_yh_jbxx xyj ");
				sql.append("left join xt_yh_js_index xyji on xyji.yhid = xyj.yhid ");
				sql.append("left join xt_js_jbxx xjj on xjj.jsbh = xyji.jsbh ");
				sql.append("left join gorup_system_table gst on gst.user_group_id = xjj.jsbh ");
				sql.append("where 1=1 ");
				if (StringUtils.isNotEmpty(userGroupId)) {
					sql.append("and xyji.jsbh = '" + userGroupId + "' ");
				}
				if (this.getSystemID() != null) {
					sql.append("and gst.system_id = '" + this.getSystemID() + "' ");
				}
				sql.append("and xyj.zxbz = 0 "); // --用户 有效标识
				sql.append("and xjj.type = 1 "); // --业务维护组标识
				sql.append("and xjj.zxbz = 0 "); // --业务维护组有效状态
				try {
					List<Object[]> list = this.commonService.executeSQL(sql.toString());
					if (list != null && list.size() > 0) {
						for (Object[] objects : list) {
							XtYhJbxx yhJbxx = new XtYhJbxx();
							yhJbxx.setYhid(objects[0] == null ? null : Long.parseLong(objects[0].toString()));
							yhJbxx.setYhmc(objects[1] == null ? null : objects[1].toString());
							yhJbxx.setEmail(objects[2] == null ? null : objects[2].toString());
							usersLists.add(yhJbxx);
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}

			}
		}
		// pl(usersLists.size());
		// String jsonStr = JSONArray.fromObject(usersLists).toString();
		// pl(jsonStr);
		this.outJsonArray(usersLists);
		return null;
	}

	/**
	 * 
	 * 检查选中的任务是否符合逆向任务的条件：是否升级部署+非逆向任务+是否任务完成+是否有备份（从大到小判断，先任务类型，再完成，再备份）
	 * 
	 * @author hyx Mar 20, 2012
	 * @version 1.0
	 * @return
	 */
	private String queryMissInfoForConverse() {
		String missId = this.getRequest().getParameter("missId");
		Long missionId = Long.valueOf(missId);
		StringBuffer jsonStr = new StringBuffer();
		String canConverse = "false";// 是否可逆：一下三个只要有一个为false，即为false
		String isUpdate = "false";// 是否升级部署任务
		String finished = "false";// 是否完成
		String haveBackUp = "false";// 是否有备份
		String isConverse = "false";// 判断当前任务是否是逆向任务（由其它升级部署任务逆向得到的）
		try {
			// 查询任务
			if (missId != null && !"".equals(missId)) {
				missionstatetable = getMissionStateTableForShow(missionId);
				Long missType = missionstatetable.getMissionType();// 任务类型：1：文件推送，4：命令执行，6：升级部署
				Long missState = missionstatetable.getMissionState();// 任务状态：3：完成
				if (missType == 6) {// 是升级部署才有必要进行下面的判断
					isUpdate = "true";
					missionparametertable6 = getMissionParameterTable6ForShow(missionId, true);
					Long version = missionparametertable6.getVersion();// 逆向任务的原任务Id
					if (version != null) {
						isConverse = "true";// 是逆向任务,则不可再新建逆向任务
					} else {
						paramM6 = getParamForM6ForShow(missionparametertable6);// 将升级部署的参数转换为ParamForM1对象列表，以便前台显示相应信息
						if (missState == 30 || missState == 31 || missState == 32 || missState == 3) {// 任务是否完成
							finished = "true";
							for (ParamForM6 p6 : paramM6) {
								if (p6 != null) {
									List<Backup> backUpList = p6.getBackups();
									if (backUpList != null && backUpList.size() > 0) {
										haveBackUp = "true";
										break;
									}

								}
							}
						}
					}
				}
				if (isUpdate == "true" && finished == "true" && haveBackUp == "true" && isConverse == "false") {
					canConverse = "true";
				}
			}

			jsonStr.append("{\"canConverse\":\"");
			jsonStr.append(canConverse);
			jsonStr.append("\",\"isUpdate\":\"");
			jsonStr.append(isUpdate);
			jsonStr.append("\",\"isConverse\":\"");
			jsonStr.append(isConverse);
			jsonStr.append("\",\"finished\":\"");
			jsonStr.append(finished);
			jsonStr.append("\",\"haveBackUp\":\"");
			jsonStr.append(haveBackUp);
			jsonStr.append("\"}");
		} catch (Exception e) {
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_NmsTaskManagerAction.executeAction.faild_n81i');this.location='nmsTaskManager.do?action=query'</script>");
			e.printStackTrace();
		}
		System.out.println(jsonStr + "=====jsonStr");
		this.outJsonString(jsonStr.toString());
		return null;
	}

	private JSONObject handleJSonObjectRemoveEmpty(JSONObject object) {
		if (object == null) {
			return null;
		}
		List<String> keyList = new ArrayList<String>();
		Iterator<String> iterator = object.keySet().iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			Object value = object.get(key);
			if (value == null || "".equals(value) || (value instanceof JSONArray && ((JSONArray) value).size() <= 0)) {
				keyList.add(key);
			}
		}
		for (String key : keyList) {
			object.remove(key);
		}
		return object;
	}

	public OrderTable getOrder(String commandEName) throws Exception {
		OrderTable orderTable = null;
		// OrderTable orderTable =
		// (OrderTable)this.commonService.executeSQL("select
		// COMMAND_ID,COMMAND_NAME,COMMAND_DESC,COMMAND_TYPE,COMMAND_FLAG,SHELL_PATH,SHELL_CHECK,IS_VALID,COMMAND_MODEL,COMMAND_ALIAS,COMMAND_MODELNEW
		// from ORDER_TABLE where COMMAND_NAME = ?",mpt6.getCommandEName());
		List orderList = (List<OrderTable>) this.commonService.find("from OrderTable where commandName = ?",
				commandEName);
		if (orderList != null && orderList.size() > 0) {
			orderTable = (OrderTable) orderList.get(0);
		} else {
			throw new Exception(getI18nText("i18n_NmsTaskManagerAction.executeAction.noCommandToExec_n81i"));
		}
		return orderTable;
	}

	public String getSystemid() {
		return systemid;
	}

	public void setSystemid(String systemid) {
		this.systemid = systemid;
	}

	public List<XtJsJbxx> getUsergroupLists() {
		return usergroupLists;
	}

	public void setUsergroupLists(List<XtJsJbxx> usergroupLists) {
		this.usergroupLists = usergroupLists;
	}

	public String getAjaxtype() {
		return ajaxtype;
	}

	public void setAjaxtype(String ajaxtype) {
		this.ajaxtype = ajaxtype;
	}

	public MissionParameterTable1 getMissionparametertable1() {
		return missionparametertable1;
	}

	public void setMissionparametertable1(MissionParameterTable1 missionparametertable1) {
		this.missionparametertable1 = missionparametertable1;
	}

	// public MissionParameterTable2 getMissionparameteriable2() {
	// return missionparameteriable2;
	// }

	// public void setMissionparameteriable2(
	// MissionParameterTable2 missionparameteriable2) {
	// this.missionparameteriable2 = missionparameteriable2;
	// }

	public MissionStateTable getMissionstatetable() {
		return missionstatetable;
	}

	public void setMissionstatetable(MissionStateTable missionstatetable) {
		this.missionstatetable = missionstatetable;
	}

	public List<MissionParameterDefaults> getMossionparameterdefaults() {
		return mossionparameterdefaults;
	}

	public void setMossionparameterdefaults(List<MissionParameterDefaults> mossionparameterdefaults) {
		this.mossionparameterdefaults = mossionparameterdefaults;
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

	public File getSourcePath() {
		return sourcePath;
	}

	public void setSourcePath(File sourcePath) {
		this.sourcePath = sourcePath;
	}

	public String getSourcePathFileName() {
		return sourcePathFileName;
	}

	public void setSourcePathFileName(String sourcePathFileName) {
		this.sourcePathFileName = sourcePathFileName;
	}

	public List<MissionStateTable> getMissionstateTableList() {
		return missionstateTableList;
	}

	public void setMissionstateTableList(List<MissionStateTable> missionstateTableList) {
		this.missionstateTableList = missionstateTableList;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public String getUsergroupId() {
		return usergroupId;
	}

	public void setUsergroupId(String usergroupId) {
		this.usergroupId = usergroupId;
	}

	public NodegroupTable getNodegrouptable() {
		return nodegrouptable;
	}

	public void setNodegrouptable(NodegroupTable nodegrouptable) {
		this.nodegrouptable = nodegrouptable;
	}

	public XtJsJbxx getXtjsjbxx() {
		return xtjsjbxx;
	}

	public void setXtjsjbxx(XtJsJbxx xtjsjbxx) {
		this.xtjsjbxx = xtjsjbxx;
	}

	public MissionParameterDefaults getMossionparameterdefault() {
		return mossionparameterdefault;
	}

	public void setMossionparameterdefault(MissionParameterDefaults mossionparameterdefault) {
		this.mossionparameterdefault = mossionparameterdefault;
	}

	public Set<SystemTable> getSystemtablelist() {
		return systemtablelist;
	}

	public void setSystemtablelist(Set<SystemTable> systemtablelist) {
		this.systemtablelist = systemtablelist;
	}

	public Long[] getPid() {
		return pid;
	}

	public void setPid(Long[] pid) {
		this.pid = pid;
	}

	public List<Object[]> getResultObjects() {
		return resultObjects;
	}

	public void setResultObjects(List<Object[]> resultObjects) {
		this.resultObjects = resultObjects;
	}

	// public MissionParameterTable3 getMissionparameteriable3() {
	// return missionparameteriable3;
	// }

	// public void setMissionparameteriable3(
	// MissionParameterTable3 missionparameteriable3) {
	// this.missionparameteriable3 = missionparameteriable3;
	// }

	public MissionParameterTable4 getMissionparameteriable4() {
		return missionparameteriable4;
	}

	public void setMissionparameteriable4(MissionParameterTable4 missionparameteriable4) {
		this.missionparameteriable4 = missionparameteriable4;
	}

	// public MissionParameterTable5 getMissionparameteriable5() {
	// return missionparameteriable5;
	// }

	// public void setMissionparameteriable5(
	// MissionParameterTable5 missionparameteriable5) {
	// this.missionparameteriable5 = missionparameteriable5;
	// }

	public Date getStartTimeStr() {
		return startTimeStr;
	}

	public void setStartTimeStr(Date startTimeStr) {
		this.startTimeStr = startTimeStr;
	}

	public Date getEndTimeStr() {
		return endTimeStr;
	}

	public void setEndTimeStr(Date endTimeStr) {
		this.endTimeStr = endTimeStr;
	}

	public OrderTable getOrderTable() {
		return orderTable;
	}

	public void setOrderTable(OrderTable orderTable) {
		this.orderTable = orderTable;
	}

	public List<OrderTable> getOrdertablelist() {
		return ordertablelist;
	}

	public void setOrdertablelist(List<OrderTable> ordertablelist) {
		this.ordertablelist = ordertablelist;
	}

	public String getShellPathFileName() {
		return shellPathFileName;
	}

	public void setShellPathFileName(String shellPathFileName) {
		this.shellPathFileName = shellPathFileName;
	}

	public File getShellPath() {
		return shellPath;
	}

	public void setShellPath(File shellPath) {
		this.shellPath = shellPath;
	}

	public SystemTable getSystemTable() {
		return systemTable;
	}

	public void setSystemTable(SystemTable systemTable) {
		this.systemTable = systemTable;
	}
	// public Long getVersion() {
	// return version;
	// }
	//
	// public void setVersion(Long version) {
	// this.version = version;
	// }

	public Long getNodeListId() {
		return nodeListId;
	}

	public void setNodeListId(Long nodeListId) {
		this.nodeListId = nodeListId;
	}

	public String getMissionDesc() {
		return missionDesc;
	}

	public void setMissionDesc(String missionDesc) {
		this.missionDesc = missionDesc;
	}

	public MissionParameterTable6 getMissionparametertable6() {
		return missionparametertable6;
	}

	public void setMissionparametertable6(MissionParameterTable6 missionparametertable6) {
		this.missionparametertable6 = missionparametertable6;
	}

	public Integer getCommandParaCheck() {
		return commandParaCheck;
	}

	public void setCommandParaCheck(Integer commandParaCheck) {
		this.commandParaCheck = commandParaCheck;
	}

	public MissionFileInformation getFileInformation() {
		return fileInformation;
	}

	public void setFileInformation(MissionFileInformation fileInformation) {
		this.fileInformation = fileInformation;
	}

	public List<String> getFileInfoFileName() {
		return fileInfoFileName;
	}

	public void setFileInfoFileName(List<String> fileInfoFileName) {
		this.fileInfoFileName = fileInfoFileName;
	}

	public List<File> getFileInfo() {
		return fileInfo;
	}

	public void setFileInfo(List<File> fileInfo) {
		this.fileInfo = fileInfo;
	}

	public String getCommandPara() {
		return commandPara;
	}

	public void setCommandPara(String commandPara) {
		this.commandPara = commandPara;
	}

	public List<Long> getUserEmailIds() {
		return userEmailIds;
	}

	public void setUserEmailIds(List<Long> userEmailIds) {
		this.userEmailIds = userEmailIds;
	}

	public Long getTabs() {
		return tabs;
	}

	public void setTabs(Long tabs) {
		this.tabs = tabs;
	}

	public List<ParamForM1> getParamM1() {
		return paramM1;
	}

	public void setParamM1(List<ParamForM1> paramM1) {
		this.paramM1 = paramM1;
	}

	public List<ParamForM4> getParamM4() {
		return paramM4;
	}

	public void setParamM4(List<ParamForM4> paramM4) {
		this.paramM4 = paramM4;
	}

	public List<ParamForM6> getParamM6() {
		return paramM6;
	}

	public void setParamM6(List<ParamForM6> paramM6) {
		this.paramM6 = paramM6;
	}

	public String getMissionName() {
		return missionName;
	}

	public void setMissionName(String missionName) {
		this.missionName = missionName;
	}

	public String getLoopFlag() {
		return loopFlag;
	}

	public void setLoopFlag(String loopFlag) {
		this.loopFlag = loopFlag;
	}

	public String getMissionState() {
		return missionState;
	}

	public void setMissionState(String missionState) {
		this.missionState = missionState;
	}

	public String getMissionType() {
		return missionType;
	}

	public void setMissionType(String missionType) {
		this.missionType = missionType;
	}

	public String getNodeGroupsId() {
		return nodeGroupsId;
	}

	public void setNodeGroupsId(String nodeGroupsId) {
		this.nodeGroupsId = nodeGroupsId;
	}

	public Long[] getIds() {
		return ids;
	}

	public void setIds(Long[] ids) {
		this.ids = ids;
	}

	public String getNodeCheckInfo() {
		return nodeCheckInfo;
	}

	public void setNodeCheckInfo(String nodeCheckInfo) {
		this.nodeCheckInfo = nodeCheckInfo;
	}

	public String getNodeIpsId() {
		return nodeIpsId;
	}

	public void setNodeIpsId(String nodeIpsId) {
		this.nodeIpsId = nodeIpsId;
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

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public String getRowN() {
		return rowN;
	}

	public void setRowN(String rowN) {
		this.rowN = rowN;
	}

	public String getCurMissionId() {
		return curMissionId;
	}

	public void setCurMissionId(String curMissionId) {
		this.curMissionId = curMissionId;
	}

	public Integer getDataStart() {
		return dataStart;
	}

	public void setDataStart(Integer dataStart) {
		this.dataStart = dataStart;
	}

	public Integer getDataEnd() {
		return dataEnd;
	}

	public void setDataEnd(Integer dataEnd) {
		this.dataEnd = dataEnd;
	}

	public Integer getDataRange() {
		return dataRange;
	}

	public void setDataRange(Integer dataRange) {
		this.dataRange = dataRange;
	}

	public Integer getSumRound() {
		return sumRound;
	}

	public void setSumRound(Integer sumRound) {
		this.sumRound = sumRound;
	}

}
