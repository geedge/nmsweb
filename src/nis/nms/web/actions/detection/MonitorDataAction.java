package nis.nms.web.actions.detection;

import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;

import com.nis.util.StringUtil;

import net.sf.json.JSONArray;
import nis.nms.bean.DiSysteminfo;
import nis.nms.bean.DiSysteminfoDisk;
import nis.nms.bean.DiSysteminfoNet;
import nis.nms.core.Constants;
import nis.nms.domains.CheckTypeInfo;
import nis.nms.domains.DataPoliceRelation;
import nis.nms.domains.DetectionInfoNew;
import nis.nms.domains.DetectionInfoWarning;
import nis.nms.domains.DetectionSetInfo;
import nis.nms.domains.Metadata;
import nis.nms.domains.MetadataDictionaryVO;
import nis.nms.domains.NodeTable;
import nis.nms.domains.NodegroupTable;
import nis.nms.domains.OptionTable;
import nis.nms.domains.VDetectionInfoNew;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Constant;
import nis.nms.util.DateUtil;
import nis.nms.util.ExportUtils;
import nis.nms.util.Page;

@SuppressWarnings("unchecked")
@Results({ @Result(name = "queryMonitorDataInfo", value = "/page/detection/monitorData/monitorInfoList.jsp"),
		@Result(name = "vqueryMonitorDataInfo", value = "/page/detection/monitorData/vmonitorInfoList.jsp"),
		@Result(name = "queryMonitorDataInfoNew", value = "/page/detection/monitorData/monitorInfoListNew.jsp"),
		@Result(name = "queryMonitorDataInfoNewTopo", value = "/page/detection/monitorData/monitorInfoListNewTopo.jsp"),
		@Result(name = "queryMonitorDataInfoChild", value = "/page/detection/monitorData/monitorInfoListNewChild.jsp"),
		@Result(name = "queryServerMonitorDataInfoNew", value = "/page/detection/monitorData/serverMonitorInfoListNew.jsp"),
		@Result(name = "queryServerMonitorDataInfoChild", value = "/page/detection/monitorData/serverMonitorInfoListChild.jsp"),
		@Result(name = "queryAbnormalSet", value = "/page/detection/monitorData/monitorInfoList_abnormalSet.jsp"),
		@Result(name = "queryAbnormalSetChild", value = "/page/detection/monitorData/monitorInfoList_abnormalSetChild.jsp"),
		@Result(name = "detailMonitorDataInfo", value = "/page/detection/monitorData/detailMonitor.jsp"),
		@Result(name = "drawMonitorInfo", value = "/page/detection/monitorData/drawMonitorInfo.jsp"),
		@Result(name = "drawSnmpMonitorInfo", value = "/page/detection/monitorData/drawSnmpMonitorInfo.jsp"),
		@Result(name = "drawSpecialMonitorInfo", value = "/page/detection/monitorData/drawSpecialMonitorInfo.jsp"),
		@Result(name = "drawSwitchportMonitorInfo", value = "/page/detection/monitorData/drawSwitchportMonitorInfo.jsp"),
		@Result(name = "queryNE", value = "/page/detection/monitorData/monitorNEList.jsp"),
		@Result(name = "queryNEChild", value = "/page/detection/monitorData/monitorNEListChild.jsp"),
		@Result(name = "showDetectionInfo", value = "/page/detection/monitorData/detectionInfoList.jsp"),
		@Result(name = "showDetectionInfoChild", value = "/page/detection/monitorData/detectionInfoListChild.jsp"),
		@Result(name = "detailWarning", value = "/page/detection/monitorData/detailWarning.jsp"),
		@Result(name = "queryEmergent", value = "/page/detection/monitorData/queryEmergent.jsp"),
		@Result(name = "queryEmergentNew", value = "/page/detection/monitorData/queryEmergentNew.jsp"),
		@Result(name = "queryEmergentChild", value = "/page/detection/monitorData/queryEmergentChild.jsp"),
		@Result(name = "select_plug", value = "/page/detection/monitorData/select_plug.jsp") })
public class MonitorDataAction extends BaseAction {

	private Logger logger = Logger.getLogger(MonitorDataAction.class);
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	private int pageNo = 1;
	private int pageSize = getDefaultPageSize(); // 每页显示的记录条数
	private Page page;
	private int pageNoSub = 1;
	private int pageSizeSub = this.getDefaultPageSize(); // 每页显示的记录条数
	private Page pageSub;
	private String action;
	private List<DetectionInfoNew> detectionInfoNewList;
	private Long[] ids;
	private DetectionInfoNew detectionInfoNew;
	private VDetectionInfoNew vdetectionInfoNew;
	private String dsiId;
	private String ctId;
	// private CheckTypeInfo checkTypeInfo;
	private String jsonStr;
	private List<List> vnodeIpGroupList;
	private List<List> nodeIpGroupListNew;
	private List<CheckTypeInfo> allCheckTypeInfo;
	private List<Metadata> metadataList;
	private String metaId;
	private String nodeIp;
	private String sqId;
	// 查询条件
	private String cip;
	private String nodeIpRange;// IP段
	private String nodeGroupStr;// 节点组 名称
	private List<NodegroupTable> allNodeGroupInfo = new ArrayList<NodegroupTable>();
	private String ctn;
	private Integer checkType;
	private String stateInfo;
	private String startTime;
	private String endTime;
	private String sTime;
	private String eTime;
	private String status;
	private String flag;
	private String lineNames;
	private List dataList;
	private String drIndex;
	private NodeTable nodeTable;
	// 请求类型为topo 表示来源于拓扑图展示时点击灯泡查询节点组下的节点检测情况
	private String requestType;
	private String nodeGroupId;
	private String nodeGroupName = "";
	private String nodeId;
	// 监测数据与异常设备公用详情页面、曲线图页面，返回时的标识。
	// type为空：服务器检测，type=1：网元检测 type=2:异常网元
	private String type;
	private String showHistory;

	private List<Object[]> detectionInfoWarningList;
	private DetectionInfoWarning detectionInfoWarning;

	// 进入告警信息列表的入口：switch，表示从监测网元信息进入，空则从告警菜单进入
	private String entry;
	private String detectId;
	private String seqId;
	private String ip;
	private String pid;

	private String nameFlag;
	private String isLeaf;
	private String picId;
	private String queryParConditionDisplay;
	private String queryChildConditionDisplay;
	private String nodeType;
	private String tableName;
	private String pIden;
	private String dct;
	private String police_emergent;
	private String police_level;
	
	private int mypageNo;
	private int mypageSize;

	private String queryNEChild;
	
	private String detectionSetInfoId;
	/**
	 * 入口，action=(query queryNE queryAbnormalSet)几乎是统一业务逻辑，修改时同步修改
	 */
	@Override
	public String executeAction() throws Exception {
		String resultpage = "";
		if ("query".equals(this.action)) {
			queryCheckTypeInfo();
			// 如果是拓扑图过来的请求 走queryMonitorDataInfoNewForTopo逻辑
			if (!StringUtil.isBlank(requestType) && requestType.equals("topo")) {
				queryMonitorDataInfoNewForTopo();
				resultpage = "queryMonitorDataInfoNew";
			} else if(!StringUtil.isBlank(requestType) && requestType.equals("newTopo")){
				queryMonitorDataInfoNewForTopoDetail();
				resultpage = "queryMonitorDataInfoNewTopo";
			} else {
				this.queryServerMonitorDataInfoNew();// 服务器监测
				resultpage = "queryServerMonitorDataInfoNew";
			}
		} else if ("queryChild".equals(this.action)) {
			queryCheckTypeInfo();
			if (!StringUtil.isBlank(requestType) && requestType.equals("topo")) {
				queryMonitorDataInfoNewForTopo();
				resultpage = "queryMonitorDataInfoChild";
			} else {
				this.queryServerMonitorDataInfoNew();// 服务器监测-自动加载
				resultpage = "queryServerMonitorDataInfoChild";
			}
		} else if ("detail".equals(this.action)) {
			resultpage = this.detailMonitorDataInfo();
		} else if ("drawPic".equals(this.action)) {
			resultpage = this.ajaxDrawDateSource();
		} else if ("queryAbnormalSet".equals(this.action)) {
			// 详情、时序图页面标识监测数据与异常设备菜单
			type = "2";
			queryCheckTypeInfo();
			resultpage = this.queryAbnormalSet();// 异常服务器监测查询
		} else if ("queryChildForAbnormalSet".equals(this.action)) {
			type = "2";
			queryCheckTypeInfo();
			resultpage = this.queryAbnormalSetChild();// 异常服务器拖动滚动条，动态加载数据
		} else if ("queryNE".equals(this.action)) {
			// 详情、时序图页面标识监测数据与异常设备菜单
			type = "1";
			queryCheckTypeInfo();
			this.queryNE();
			resultpage = "queryNE";
		} else if ("queryNEChild".equals(this.action)) {
			type = "1";
			queryCheckTypeInfo();
			this.queryNE();
			resultpage = "queryNEChild";
		} else if ("showDetectionInfo".equals(this.action)) {
			if ("warning".equals(flag) || "queryAllConfigLevel".equals(flag)) {
				tableName = "detection_info_warning";
			} else {
				tableName = "detection_info";
			}
			showHistory = "history";
			queryCheckTypeInfo();
			this.showDetectionInfo();
			resultpage = "showDetectionInfo";
		} else if ("showDetectionInfoChild".equals(this.action)) {
			if ("warning".equals(flag) || "queryAllConfigLevel".equals(flag)) {
				tableName = "detection_info_warning";
			} else {
				tableName = "detection_info";
			}
			showHistory = "history";
			queryCheckTypeInfo();
			this.showDetectionInfo();
			resultpage = "showDetectionInfoChild";
		} else if ("detailWarning".equals(this.action)) {
			queryCheckTypeInfo();
			resultpage = this.detailWarning();
		} else if ("emportCurrentXls".equals(this.action)) {
			resultpage = emportCurrentXls();// 服务器监测：导出当前页
		} else if ("emportAllXls".equals(this.action)) {
			resultpage = emportAllXls();// 服务器监测：导出所有
		} else if ("emportCurrentXlsAbnormalSet".equals(this.action)) {
			resultpage = emportCurrentXlsAbnormalSet();
		} else if ("emportAllXlsAbnormalSet".equals(this.action)) {
			resultpage = emportAllXlsAbnormalSet();
		} else if ("queryEmergent".equals(this.action)) {
			// 拓扑图，查询紧急告警
			queryEmergent();
			resultpage = "queryEmergent";
		} else if ("queryEmergentDetail".equals(this.action)) {
			// 拓扑图，查询紧急告警  modify 2018/07/18 th
			queryEmergentDetail();
			resultpage = "queryEmergentNew";
		} else if ("queryEmergentChild".equals(this.action)) {
			queryEmergent();// 拓扑图，查询紧急告警子页面
			resultpage = "queryEmergentChild";
		}else if("queryEmergentChildDetail".equals(this.action)){
			queryEmergentDetail();// 拓扑图，查询紧急告警子页面 modify 2018/07/18 th
			resultpage = "queryEmergentNew";
		}
		  else if ("emportCurrentXlsForTopo".equals(this.action)) {
			resultpage = emportCurrentXlsForTopo();
		} else if ("emportAllXlsForTopo".equals(this.action)) {
			resultpage = emportAllXlsForTopo();
		}
		/*
		 * else { queryCheckTypeInfo(); resultpage =
		 * queryServerMonitorDataInfoNew(); }
		 */
		return resultpage;
	}

	// 当前页导出 程辉 2013-5-8新增
	public String emportCurrentXlsAbnormalSet() {
		try {
			StringBuffer sqlBuffer = new StringBuffer();

			sqlBuffer.append(
					" select distinct din.id,nt.node_ip,cti.check_type_name1,dsi.PROCESS_IDEN_NAME,din.detectioned_state");
			sqlBuffer.append(
					",to_char(din.data_check_time,'yyyy-MM-dd HH24:mi:Ss'),'',din.current_times,replace(din.detection_state_info,'$@$',''),to_char(din.status_change_time,'yyyy-MM-dd HH24:mi:Ss')");
			sqlBuffer.append(
					",dsi.id dsiiId,cti.id ctiId,din.seq_id sqId,nt.node_system_type nodeSysType,nvl(checkTypeCharState.charStateNum,0) charStateNum,nt.node_type nodeType,nt.ipn ipn");

			sqlBuffer.append(" from DETECTION_INFO_NEW din");
			sqlBuffer.append(" left join DETECTION_SET_INFO dsi");
			sqlBuffer.append(" on din.detection_set_info_id = dsi.id");
			sqlBuffer.append(" left join check_type_info cti");
			sqlBuffer.append(" on dsi.check_type_id = cti.id");
			sqlBuffer.append(
					" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id,ipn from  NODE_TABLE) nt");
			sqlBuffer.append(" on din.seq_id = nt.seq_id");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------start
			sqlBuffer.append(" left join ");
			sqlBuffer.append(
					"  (select md.check_type_id as ctId,count(*) as charStateNum  from metadata md  where md.chart_state=0  group by md.check_type_id) checkTypeCharState ");
			sqlBuffer.append(" on checkTypeCharState.ctId=cti.id ");
			sqlBuffer.append(
					" where nt.node_ip is not null and nt.node_state = 0 and dsi.detection_set_state ='1'  and cti.crete_state=0  and din.valid=1 AND din.detectioned_state in('0','-1') ");// 只显示有效的数据：din.valid=1
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and nt.system_id = ");
				sqlBuffer.append(this.getSystemID());
			}
			if (cip != null && !"".equals(cip) && !"null".equals(cip)) {
				sqlBuffer.append(" and nt.node_ip = '" + cip + "'");
			}
			if (ctn != null && !"".equals(ctn)) {
				sqlBuffer.append(" and cti.id =" + ctn);
			}
			if(checkType!=null&&checkType!=-1){
				sqlBuffer.append(" and cti.id="+checkType);
			}
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and (((( cti.view_level=1 and cti.user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( cti.view_level=2 and cti.group_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or cti.view_level=3 ) and cti.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (cti.view_level=4 )");
				sqlBuffer.append(") ");

				sqlBuffer.append("and (((( dsi.view_level=1 and dsi.create_user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( dsi.view_level=2 and dsi.create_usergroup_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or dsi.view_level=3 ) and dsi.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (dsi.view_level=4 )");
				sqlBuffer.append(") and dsi.detection_set_state=1 and cti.crete_state=0  ");
			}
			sqlBuffer.append(" order by ipn ASC,cti.id ASC, dsi.id ASC");
			System.out.println("sqlBuffer:" + sqlBuffer.toString());
			page = this.commonService.findByPageForSql(sqlBuffer.toString(), pageNo, pageSize);
			List<Object[]> detectionInfoList; // 最新状态信息集合
			detectionInfoList = (List<Object[]>) page.getResult();
			detectionInfoList = changeValue(detectionInfoList, false);
			for (int j = 0; j < detectionInfoList.size(); j++) {
				if (detectionInfoList.get(j)[5] != null && detectionInfoList.get(j)[9] != null) {
					detectionInfoList.get(j)[6] = this.getPersistTime(
							DateUtil.getDateD(detectionInfoList.get(j)[5].toString()),
							DateUtil.getDateD(detectionInfoList.get(j)[9].toString()));
				}

				if (detectionInfoList.get(j)[4] != null && detectionInfoList.get(j)[4].equals("-1")) {
					detectionInfoList.get(j)[4] = getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.exception_n81i");
				}
				if (detectionInfoList.get(j)[4] != null && detectionInfoList.get(j)[4].equals("0")) {
					detectionInfoList.get(j)[4] = getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.unnormal_n81i");
				}
				if (detectionInfoList.get(j)[4] != null && detectionInfoList.get(j)[4].equals("1")) {
					detectionInfoList.get(j)[4] = getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.normal_n81i");
				}
			}

			String[] title = { getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.hostname_n81i"), 
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.checkType_n81i"),
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.setName_n81i"), 
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.state_n81i"), 
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.lastCheckTime_n81i"), 
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.duration_n81i"), 
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.attempt_n81i"), 
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.stateInfo_n81i") };

			String[] colu = { "1", "2", "3", "4", "5", "6", "7", "8" };
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.deviceException_n81i"), detectionInfoList, title, colu);
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		return null;
	}

	// 导出全部 程辉 2013-5-8新增
	public String emportAllXlsAbnormalSet() {
		try {
			StringBuffer sqlBuffer = new StringBuffer();

			sqlBuffer.append(
					" select distinct din.id,nt.node_ip,cti.check_type_name1,dsi.PROCESS_IDEN_NAME,din.detectioned_state");
			sqlBuffer.append(
					",to_char(din.data_check_time,'yyyy-MM-dd HH24:mi:Ss'),'',din.current_times,replace(din.detection_state_info,'$@$',''),to_char(din.status_change_time,'yyyy-MM-dd HH24:mi:Ss')");
			sqlBuffer.append(
					",dsi.id dsiiId,cti.id ctiId,din.seq_id sqId,nt.node_system_type nodeSysType,nvl(checkTypeCharState.charStateNum,0) charStateNum,nt.node_type nodeType,nt.ipn ipn");

			sqlBuffer.append(" from DETECTION_INFO_NEW din");
			sqlBuffer.append(" left join DETECTION_SET_INFO dsi");
			sqlBuffer.append(" on din.detection_set_info_id = dsi.id");
			sqlBuffer.append(" left join check_type_info cti");
			sqlBuffer.append(" on dsi.check_type_id = cti.id");
			sqlBuffer.append(
					" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id,ipn from  NODE_TABLE) nt");
			sqlBuffer.append(" on din.seq_id = nt.seq_id");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------start
			sqlBuffer.append(" left join ");
			sqlBuffer.append(
					"  (select md.check_type_id as ctId,count(*) as charStateNum  from metadata md  where md.chart_state=0  group by md.check_type_id) checkTypeCharState ");
			sqlBuffer.append(" on checkTypeCharState.ctId=cti.id ");
			sqlBuffer.append(
					" where nt.node_ip is not null and nt.node_state = 0 and dsi.detection_set_state ='1'  and cti.crete_state=0  and din.valid=1 AND din.detectioned_state in('0','-1') ");// 只显示有效的数据：din.valid=1
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and nt.system_id = ");
				sqlBuffer.append(this.getSystemID());
			}
			if (cip != null && !"".equals(cip) && !"null".equals(cip)) {
				sqlBuffer.append(" and nt.node_ip = '" + cip + "'");
			}
			if (ctn != null && !"".equals(ctn)) {
				sqlBuffer.append(" and cti.id =" + ctn);

			}
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and (((( cti.view_level=1 and cti.user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( cti.view_level=2 and cti.group_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or cti.view_level=3 ) and cti.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (cti.view_level=4 )");
				sqlBuffer.append(") ");

				sqlBuffer.append("and (((( dsi.view_level=1 and dsi.create_user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( dsi.view_level=2 and dsi.create_usergroup_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or dsi.view_level=3 ) and dsi.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (dsi.view_level=4 )");
				sqlBuffer.append(") and dsi.detection_set_state=1 and cti.crete_state=0  ");
			}
			sqlBuffer.append(" order by ipn ASC,cti.id ASC, dsi.id ASC");
			List<Object[]> detectionInfoList = this.commonService.executeSQL(sqlBuffer.toString());
			detectionInfoList = changeValue(detectionInfoList, false);
			for (int j = 0; j < detectionInfoList.size(); j++) {
				if (detectionInfoList.get(j)[5] != null && detectionInfoList.get(j)[9] != null) {
					detectionInfoList.get(j)[6] = this.getPersistTime(
							DateUtil.getDateD(detectionInfoList.get(j)[5].toString()),
							DateUtil.getDateD(detectionInfoList.get(j)[9].toString()));
				}

				if (detectionInfoList.get(j)[4] != null && detectionInfoList.get(j)[4].equals("-1")) {
					detectionInfoList.get(j)[4] = getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.exception_n81i");
				}
				if (detectionInfoList.get(j)[4] != null && detectionInfoList.get(j)[4].equals("0")) {
					detectionInfoList.get(j)[4] = getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.unnormal_n81i");
				}
				if (detectionInfoList.get(j)[4] != null && detectionInfoList.get(j)[4].equals("1")) {
					detectionInfoList.get(j)[4] = getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.normal_n81i");
				}
			}

			String[] title = { getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.hostname_n81i"),
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.checkType_n81i"), 
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.setName_n81i"),
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.state_n81i"), 
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.lastCheckTime_n81i"),
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.duration_n81i"),
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.attempt_n81i"), 
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.stateInfo_n81i") };

			String[] colu = { "1", "2", "3", "4", "5", "6", "7", "8" };
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.deviceException_n81i"), detectionInfoList, title, colu);
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		return null;
	}

	// topo导出当前页面
	public String emportCurrentXlsForTopo() {
		try {
			StringBuffer sqlBuffer = new StringBuffer();
			sqlBuffer.append(
					" select distinct din.id,nt.node_ip,cti.check_type_name1,dsi.PROCESS_IDEN_NAME,din.detectioned_state detectioned_state");
			sqlBuffer.append(
					",to_char(din.data_check_time,'yyyy-MM-dd HH24:mi:Ss'),'',din.current_times,din.detection_state_info,to_char(din.status_change_time,'yyyy-MM-dd HH24:mi:Ss')");
			sqlBuffer.append(
					",dsi.id dsiiId,cti.id ctiId,din.seq_id sqId,nt.node_system_type nodeSysType,nvl(checkTypeCharState.charStateNum,0) charStateNum,nt.node_type nodeType,nt.ipn ipn");
			sqlBuffer.append(",din.police_emergent police_emergent,din.police_level police_level");
			sqlBuffer.append(" from DETECTION_INFO_NEW din");
			sqlBuffer.append(" left join DETECTION_SET_INFO dsi");
			sqlBuffer.append(" on din.detection_set_info_id = dsi.id");
			sqlBuffer.append(" left join check_type_info cti");
			sqlBuffer.append(" on dsi.check_type_id = cti.id");
			// @2018-3-9 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
			String groupIdSql = "select group_id from nodegroup_table t where 1=1 ";
			String ids = this.commonService.getGroupIdStartWith(groupIdSql, "t.group_id = " + nodeGroupId);
			/*
			 * sqlBuffer.
			 * append(" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id ,ipn from  NODE_TABLE WHERE node_group_id in"
			 * +
			 * "(select t.group_id from nodegroup_table t start with t.group_id ="
			 * + nodeGroupId +
			 * " connect by prior t.group_id = t.parent_group_id)) nt");
			 */
			sqlBuffer
					.append(" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id ,ipn from  NODE_TABLE WHERE node_group_id in"
							+ "(" + ids + ")) nt");
			sqlBuffer.append(" on din.seq_id = nt.seq_id");
			sqlBuffer.append(" left join ");
			sqlBuffer.append(
					"  (select md.check_type_id as ctId,count(*) as charStateNum  from metadata md  where md.chart_state=0  group by md.check_type_id) checkTypeCharState ");
			sqlBuffer.append(" on checkTypeCharState.ctId=cti.id ");
			sqlBuffer.append(
					" where nt.node_ip is not null and nt.node_state = 0 and dsi.detection_set_state ='1'  and cti.crete_state=0  and din.valid=1");// 只显示有效的数据：din.valid=1
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and nt.system_id = ");
				sqlBuffer.append(this.getSystemID());
			}
			if (cip != null && !"".equals(cip) && !"null".equals(cip)) {
				sqlBuffer.append(" and nt.node_ip like '%" + cip + "%'");
			}
			if (ctn != null && !"".equals(ctn)) {
				sqlBuffer.append(" and Upper(cti.Check_Type_Name1) like '%" + ctn.toUpperCase() + "%'");

			}
			if(checkType!=null&&checkType!=-1){
				sqlBuffer.append(" and cti.id="+checkType);
			}
			if (StringUtils.isNotBlank(stateInfo)) {
				sqlBuffer.append(" and din.detection_state_info like '%" + stateInfo + "%'");
			}
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and (((( cti.view_level=1 and cti.user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( cti.view_level=2 and cti.group_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or cti.view_level=3 ) and cti.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (cti.view_level=4 )");
				sqlBuffer.append(") ");

				sqlBuffer.append("and (((( dsi.view_level=1 and dsi.create_user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( dsi.view_level=2 and dsi.create_usergroup_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or dsi.view_level=3 ) and dsi.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (dsi.view_level=4 )");
				sqlBuffer.append(") and dsi.detection_set_state=1 and cti.crete_state=0  ");
			}
			sqlBuffer.append(" ORDER by  detectioned_state, police_emergent, police_level");
			System.out.println("sqlBuffer:" + sqlBuffer.toString());
			page = this.commonService.findByPageForSql(sqlBuffer.toString(), pageNo, pageSize, null);
			List<Object[]> detectionInfoList; // 最新状态信息集合
			detectionInfoList = (List<Object[]>) page.getResult();
			detectionInfoList = changeValue(detectionInfoList, false);
			for (int j = 0; j < detectionInfoList.size(); j++) {
				if (detectionInfoList.get(j)[5] != null && detectionInfoList.get(j)[9] != null) {
					detectionInfoList.get(j)[6] = this.getPersistTime(
							DateUtil.getDateD(detectionInfoList.get(j)[5].toString()),
							DateUtil.getDateD(detectionInfoList.get(j)[9].toString()));
				}

				if (detectionInfoList.get(j)[4] != null && detectionInfoList.get(j)[4].equals("-1")) {
					detectionInfoList.get(j)[4] = getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.exception_n81i");
				}
				if (detectionInfoList.get(j)[4] != null && detectionInfoList.get(j)[4].equals("0")) {
					detectionInfoList.get(j)[4] = getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.unnormal_n81i");
				}
				if (detectionInfoList.get(j)[4] != null && detectionInfoList.get(j)[4].equals("1")) {
					detectionInfoList.get(j)[4] = getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.normal_n81i");
				}
			}
			String[] title = { getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.hostname_n81i"),
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.checkType_n81i"),
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.setName_n81i"),
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.state_n81i"), 
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.lastCheckTime_n81i"),
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.duration_n81i"), 
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.attempt_n81i"),
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.stateInfo_n81i") };
			String[] colu = { "1", "2", "3", "4", "5", "6", "7", "8" };
			String url = "monitorData.do?action=query&cip=" + cip + "&ctn=" + ctn + "&stateInfo=" + stateInfo
					+ "&pageSize=" + pageSize + "&pageNo=" + pageNo + "&requestType=topo&nodeGroupId=" + nodeGroupId;
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(url, getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.detecateData_n81i"), detectionInfoList, title, colu);
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.faild_n81i');</script>");
		}
		return null;
	}

	// 当前页导出 程辉 2013-5-8新增
	public String emportCurrentXls() {
		try {
			StringBuffer sqlBuffer = new StringBuffer();
			sqlBuffer.append(
					" select distinct din.id,nt.node_ip,cti.check_type_name1,dsi.PROCESS_IDEN_NAME,din.detectioned_state");
			sqlBuffer.append(
					",to_char(din.data_check_time,'yyyy-MM-dd HH24:mi:Ss'),'',din.current_times,replace(din.detection_state_info,'$@$',''),to_char(din.status_change_time,'yyyy-MM-dd HH24:mi:Ss')");
			sqlBuffer.append(
					",dsi.id dsiiId,cti.id ctiId,din.seq_id sqId,nt.node_system_type nodeSysType,nvl(checkTypeCharState.charStateNum,0) charStateNum,nt.node_type nodeType,nt.ipn ipn,decode(cti.check_type_name,'NMSClient',-1,cti.id) ctiId1");

			sqlBuffer.append(" from DETECTION_INFO_NEW din");
			sqlBuffer.append(" left join DETECTION_SET_INFO dsi");
			sqlBuffer.append(" on din.detection_set_info_id = dsi.id");
			sqlBuffer.append(" left join check_type_info cti");
			sqlBuffer.append(" on dsi.check_type_id = cti.id");
			sqlBuffer.append(
					" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id ,ipn from  NODE_TABLE ");
			if (nodeGroupStr != null && !"".equals(nodeGroupStr) && !"null".equals(nodeGroupStr)) {
				// 节点组模糊名称不为空，则根据节点组名称，模糊查询所有节点组，再依次查找其下面的节点，得到节点id
				// @2018-3-9 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
				String groupIdSql = "select  group_id from nodegroup_table t where 1=1 ";
				String ids = this.commonService.getGroupIdStartWith(groupIdSql,
						"lower(group_name) like lower('%" + nodeGroupStr + "%')");
				/*
				 * sqlBuffer.
				 * append(" right join (select  distinct ngt.group_id from nodegroup_table ngt start with lower(ngt.group_name) like lower('%"
				 * + nodeGroupStr +
				 * "%')  connect by prior group_id=parent_group_id ) ngt on node_group_id=ngt.group_id"
				 * );
				 */
				sqlBuffer
						.append(" right join (select  distinct ngt.group_id from nodegroup_table ngt where ngt.group_id in ("
								+ ids + ") ) ngt on node_group_id=ngt.group_id");
			}
			sqlBuffer.append(") nt on din.seq_id = nt.seq_id");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------start
			sqlBuffer.append(" left join ");
			sqlBuffer.append(
					"  (select md.check_type_id as ctId,count(*) as charStateNum  from metadata md  where md.chart_state=0  group by md.check_type_id) checkTypeCharState ");
			sqlBuffer.append(" on checkTypeCharState.ctId=cti.id ");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------end

			sqlBuffer.append(" where nt.node_ip is not null AND nt.node_type =" + nodeType
					+ " and nt.node_state = 0 and dsi.detection_set_state ='1'  and cti.crete_state=0  and din.valid=1");// 只显示有效的数据：din.valid=1
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and nt.system_id = ");
				sqlBuffer.append(this.getSystemID());
			}
			if (cip != null && !"".equals(cip) && !"null".equals(cip)) {
				sqlBuffer.append(" and nt.node_ip like '%" + cip.trim() + "%'");
			}
			if(checkType!=null&&checkType!=-1){
				sqlBuffer.append(" and cti.id="+checkType);
			}
			if (nodeIpRange != null && !"".equals(nodeIpRange) && !"null".equals(nodeIpRange)) {
				sqlBuffer.append(" and nt.node_ip like '" + nodeIpRange + "%'");
			}
			if (ctn != null && !"".equals(ctn)) {
				// sqlBuffer.append(" and cti.id =" + ctn);
				sqlBuffer.append(" and Upper(cti.Check_Type_Name1) like '%" + ctn.toUpperCase() + "%'");
			}
			if (StringUtils.isNotBlank(stateInfo)) {
				sqlBuffer.append(" and din.detection_state_info like '%" + stateInfo + "%'");
			}
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and (((( cti.view_level=1 and cti.user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( cti.view_level=2 and cti.group_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or cti.view_level=3 ) and cti.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (cti.view_level=4 )");
				sqlBuffer.append(") ");

				sqlBuffer.append("and (((( dsi.view_level=1 and dsi.create_user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( dsi.view_level=2 and dsi.create_usergroup_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or dsi.view_level=3 ) and dsi.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (dsi.view_level=4 )");
				sqlBuffer.append(") and dsi.detection_set_state=1 and cti.crete_state=0  ");
			}
			sqlBuffer.append(" order by ipn ASC,ctiId1 ASC, dsi.id ASC");

			page = this.commonService.findByPageForSql(sqlBuffer.toString(), pageNo, pageSize);
			List<Object[]> detectionInfoList; // 最新状态信息集合
			detectionInfoList = (List<Object[]>) page.getResult();
			detectionInfoList = changeValue(detectionInfoList, false);

			for (int j = 0; j < detectionInfoList.size(); j++) {
				if (detectionInfoList.get(j)[5] != null && detectionInfoList.get(j)[9] != null) {
					detectionInfoList.get(j)[6] = this.getPersistTime(
							DateUtil.getDateD(detectionInfoList.get(j)[5].toString()),
							DateUtil.getDateD(detectionInfoList.get(j)[9].toString()));
				}

				if (detectionInfoList.get(j)[4] != null && detectionInfoList.get(j)[4].equals("-1")) {
					detectionInfoList.get(j)[4] = getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.exception_n81i");
				}
				if (detectionInfoList.get(j)[4] != null && detectionInfoList.get(j)[4].equals("0")) {
					detectionInfoList.get(j)[4] = getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.unnormal_n81i");
				}
				if (detectionInfoList.get(j)[4] != null && detectionInfoList.get(j)[4].equals("1")) {
					detectionInfoList.get(j)[4] = getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.normal_n81i");
				}
			}

			String[] title = { getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.hostname_n81i"),
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.checkType_n81i"), 
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.setName_n81i"),
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.state_n81i"),
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.lastCheckTime_n81i"),
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.duration_n81i"), 
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.attempt_n81i"), 
								getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.stateInfo_n81i") };

			String[] colu = { "1", "2", "3", "4", "5", "6", "7", "8" };
			String pageType = this.getRequest().getParameter("pageType");
			String url = "";
			if ("query".equals(pageType)) {
				url = "monitorData.do?action=query&cip=" + cip + "&nodeGroupStr=" + nodeGroupStr + "&ctn=" + ctn
						+ "&stateInfo=" + stateInfo + "&pageSize=" + pageSize + "&pageNo=" + pageNo;
			} else if ("queryNE".equals(pageType)) {
				url = "monitorData.do?action=queryNE&cip=" + cip + "&ctn=" + ctn + "&stateInfo=" + stateInfo
						+ "&pageSize=" + pageSize + "&pageNo=" + pageNo;
			}
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(url, getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.detecateData_n81i"), detectionInfoList, title, colu);
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		return null;
	}

	public String emportAllXlsForTopo() {
		try {
			StringBuffer sqlBuffer = new StringBuffer();
			sqlBuffer.append(
					" select distinct din.id,nt.node_ip,cti.check_type_name1,dsi.PROCESS_IDEN_NAME,din.detectioned_state detectioned_state");
			sqlBuffer.append(
					",to_char(din.data_check_time,'yyyy-MM-dd HH24:mi:Ss'),'',din.current_times,din.detection_state_info,to_char(din.status_change_time,'yyyy-MM-dd HH24:mi:Ss')");
			sqlBuffer.append(
					",dsi.id dsiiId,cti.id ctiId,din.seq_id sqId,nt.node_system_type nodeSysType,nvl(checkTypeCharState.charStateNum,0) charStateNum,nt.node_type nodeType,nt.ipn ipn");
			sqlBuffer.append(",din.police_emergent police_emergent,din.police_level police_level");
			sqlBuffer.append(" from DETECTION_INFO_NEW din");
			sqlBuffer.append(" left join DETECTION_SET_INFO dsi");
			sqlBuffer.append(" on din.detection_set_info_id = dsi.id");
			sqlBuffer.append(" left join check_type_info cti");
			sqlBuffer.append(" on dsi.check_type_id = cti.id");
			// @2018-3-9 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
			String groupIdSql = "select group_id from nodegroup_table t where 1=1 ";
			String ids = this.commonService.getGroupIdStartWith(groupIdSql, "t.group_id = " + nodeGroupId);
			/*
			 * sqlBuffer.
			 * append(" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id ,ipn from  NODE_TABLE WHERE node_group_id in"
			 * +
			 * "(select t.group_id from nodegroup_table t start with t.group_id ="
			 * + nodeGroupId +
			 * " connect by prior t.group_id = t.parent_group_id)) nt");
			 */
			sqlBuffer
					.append(" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id ,ipn from  NODE_TABLE WHERE node_group_id in"
							+ "(" + ids + ")) nt");

			sqlBuffer.append(" on din.seq_id = nt.seq_id");
			sqlBuffer.append(" left join ");
			sqlBuffer.append(
					"  (select md.check_type_id as ctId,count(*) as charStateNum  from metadata md  where md.chart_state=0  group by md.check_type_id) checkTypeCharState ");
			sqlBuffer.append(" on checkTypeCharState.ctId=cti.id ");
			sqlBuffer.append(
					" where nt.node_ip is not null and nt.node_state = 0 and dsi.detection_set_state ='1'  and cti.crete_state=0  and din.valid=1");// 只显示有效的数据：din.valid=1
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and nt.system_id = ");
				sqlBuffer.append(this.getSystemID());
			}
			if (cip != null && !"".equals(cip) && !"null".equals(cip)) {
				sqlBuffer.append(" and nt.node_ip like '%" + cip + "%'");
			}
			if (ctn != null && !"".equals(ctn)) {
				sqlBuffer.append(" and Upper(cti.Check_Type_Name1) like '%" + ctn.toUpperCase() + "%'");
			}
			if (StringUtils.isNotBlank(stateInfo)) {
				sqlBuffer.append(" and din.detection_state_info like '%" + stateInfo + "%'");
			}
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and (((( cti.view_level=1 and cti.user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( cti.view_level=2 and cti.group_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or cti.view_level=3 ) and cti.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (cti.view_level=4 )");
				sqlBuffer.append(") ");

				sqlBuffer.append("and (((( dsi.view_level=1 and dsi.create_user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( dsi.view_level=2 and dsi.create_usergroup_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or dsi.view_level=3 ) and dsi.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (dsi.view_level=4 )");
				sqlBuffer.append(") and dsi.detection_set_state=1 and cti.crete_state=0  ");
			}
			sqlBuffer.append(" ORDER by  detectioned_state, police_emergent, police_level");
			System.out.println("sqlBuffer:" + sqlBuffer.toString());
			List<Object[]> detectionInfoList = this.commonService.executeSQL(sqlBuffer.toString());
			detectionInfoList = changeValue(detectionInfoList, false);
			for (int j = 0; j < detectionInfoList.size(); j++) {
				if (detectionInfoList.get(j)[5] != null && detectionInfoList.get(j)[9] != null) {
					detectionInfoList.get(j)[6] = this.getPersistTime(
							DateUtil.getDateD(detectionInfoList.get(j)[5].toString()),
							DateUtil.getDateD(detectionInfoList.get(j)[9].toString()));
				}
				if (detectionInfoList.get(j)[4] != null && detectionInfoList.get(j)[4].equals("-1")) {
					detectionInfoList.get(j)[4] = getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.exception_n81i");
				}
				if (detectionInfoList.get(j)[4] != null && detectionInfoList.get(j)[4].equals("0")) {
					detectionInfoList.get(j)[4] = getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.unnormal_n81i");
				}
				if (detectionInfoList.get(j)[4] != null && detectionInfoList.get(j)[4].equals("1")) {
					detectionInfoList.get(j)[4] = getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.normal_n81i");
				}
			}
			String[] title =  { getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.hostname_n81i"),
					getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.checkType_n81i"), 
					getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.setName_n81i"),
					getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.state_n81i"),
					getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.lastCheckTime_n81i"),
					getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.duration_n81i"), 
					getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.attempt_n81i"), 
					getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.stateInfo_n81i") };
			String[] colu = { "1", "2", "3", "4", "5", "6", "7", "8" };
			String url = "monitorData.do?action=query&cip=" + cip + "&ctn=" + ctn + "&stateInfo=" + stateInfo
					+ "&pageSize=" + pageSize + "&pageNo=" + pageNo + "&requestType=topo&nodeGroupId=" + nodeGroupId;
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(url, getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.detecateData_n81i"), detectionInfoList, title, colu);
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.faild_n81i');</script>");
		}
		return null;
	}

	// 导出全部 程辉 2013-5-8新增
	public String emportAllXls() {
		try {
			StringBuffer sqlBuffer = new StringBuffer();
			sqlBuffer.append(
					" select distinct din.id,nt.node_ip,cti.check_type_name1,dsi.PROCESS_IDEN_NAME,din.detectioned_state");
			sqlBuffer.append(
					",to_char(din.data_check_time,'yyyy-MM-dd HH24:mi:Ss'),'',din.current_times,replace(din.detection_state_info,'$@$',''),to_char(din.status_change_time,'yyyy-MM-dd HH24:mi:Ss')");
			sqlBuffer.append(
					",dsi.id dsiiId,cti.id ctiId,din.seq_id sqId,nt.node_system_type nodeSysType,nvl(checkTypeCharState.charStateNum,0) charStateNum,nt.node_type nodeType,nt.ipn ipn");

			sqlBuffer.append(" from DETECTION_INFO_NEW din");
			sqlBuffer.append(" left join DETECTION_SET_INFO dsi");
			sqlBuffer.append(" on din.detection_set_info_id = dsi.id");
			sqlBuffer.append(" left join check_type_info cti");
			sqlBuffer.append(" on dsi.check_type_id = cti.id");
			sqlBuffer.append(
					" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id ,ipn from  NODE_TABLE ");
			if (nodeGroupStr != null && !"".equals(nodeGroupStr) && !"null".equals(nodeGroupStr)) {
				// 节点组模糊名称不为空，则根据节点组名称，模糊查询所有节点组，再依次查找其下面的节点，得到节点id
				// @2018-3-9 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
				String groupIdSql = "select  group_id from nodegroup_table t where 1=1 ";
				String ids = this.commonService.getGroupIdStartWith(groupIdSql,
						"lower(group_name) like lower('%" + nodeGroupStr + "%')");
				/*
				 * sqlBuffer.
				 * append(" right join (select  distinct ngt.group_id from nodegroup_table ngt start with lower(ngt.group_name) like lower('%"
				 * + nodeGroupStr +
				 * "%')  connect by prior group_id=parent_group_id ) ngt on node_group_id=ngt.group_id"
				 * );
				 */
				sqlBuffer
						.append(" right join (select  distinct ngt.group_id from nodegroup_table ngt where ngt.group_id in ("
								+ ids + ") ) ngt on node_group_id=ngt.group_id");
			}
			sqlBuffer.append(") nt on din.seq_id = nt.seq_id");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------start
			sqlBuffer.append(" left join ");
			sqlBuffer.append(
					"  (select md.check_type_id as ctId,count(*) as charStateNum  from metadata md  where md.chart_state=0  group by md.check_type_id) checkTypeCharState ");
			sqlBuffer.append(" on checkTypeCharState.ctId=cti.id ");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------end

			sqlBuffer.append(" where nt.node_ip is not null AND nt.node_type =" + nodeType
					+ " and nt.node_state = 0 and dsi.detection_set_state ='1'  and cti.crete_state=0  and din.valid=1");// 只显示有效的数据：din.valid=1
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and nt.system_id = ");
				sqlBuffer.append(this.getSystemID());
			}
			if (cip != null && !"".equals(cip) && !"null".equals(cip)) {
				sqlBuffer.append(" and nt.node_ip like '%" + cip.trim() + "%'");
			}
			if (nodeIpRange != null && !"".equals(nodeIpRange) && !"null".equals(nodeIpRange)) {
				sqlBuffer.append(" and nt.node_ip like '" + nodeIpRange + "%'");
			}
			if (ctn != null && !"".equals(ctn)) {
				// sqlBuffer.append(" and cti.id =" + ctn);
				sqlBuffer.append(" and Upper(cti.Check_Type_Name1) like '%" + ctn.toUpperCase() + "%'");
			}
			if (StringUtils.isNotBlank(stateInfo)) {
				sqlBuffer.append(" and din.detection_state_info like '%" + stateInfo + "%'");
			}
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and (((( cti.view_level=1 and cti.user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( cti.view_level=2 and cti.group_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or cti.view_level=3 ) and cti.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (cti.view_level=4 )");
				sqlBuffer.append(") ");

				sqlBuffer.append("and (((( dsi.view_level=1 and dsi.create_user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( dsi.view_level=2 and dsi.create_usergroup_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or dsi.view_level=3 ) and dsi.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (dsi.view_level=4 )");
				sqlBuffer.append(") and dsi.detection_set_state=1 and cti.crete_state=0  ");
			}
			sqlBuffer.append(" order by ipn");
			List<Object[]> detectionInfoList = this.commonService.executeSQL(sqlBuffer.toString());
			detectionInfoList = changeValue(detectionInfoList, false);

			for (int j = 0; j < detectionInfoList.size(); j++) {
				if (detectionInfoList.get(j)[5] != null && detectionInfoList.get(j)[9] != null) {
					detectionInfoList.get(j)[6] = this.getPersistTime(
							DateUtil.getDateD(detectionInfoList.get(j)[5].toString()),
							DateUtil.getDateD(detectionInfoList.get(j)[9].toString()));
				}

				if (detectionInfoList.get(j)[4] != null && detectionInfoList.get(j)[4].equals("-1")) {
					detectionInfoList.get(j)[4] = getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.exception_n81i");
				}
				if (detectionInfoList.get(j)[4] != null && detectionInfoList.get(j)[4].equals("0")) {
					detectionInfoList.get(j)[4] = getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.unnormal_n81i");
				}
				if (detectionInfoList.get(j)[4] != null && detectionInfoList.get(j)[4].equals("1")) {
					detectionInfoList.get(j)[4] = getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.normal_n81i");
				}
			}

			String[] title = { getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.hostname_n81i"),
					getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.checkType_n81i"), 
					getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.setName_n81i"),
					getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.state_n81i"),
					getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.lastCheckTime_n81i"),
					getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.duration_n81i"), 
					getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.attempt_n81i"), 
					getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.stateInfo_n81i") };

			String[] colu = { "1", "2", "3", "4", "5", "6", "7", "8" };
			String pageType = this.getRequest().getParameter("pageType");
			String url = "";
			if ("query".equals(pageType)) {
				url = "monitorData.do?action=query&cip=" + cip + "&nodeGroupStr=" + nodeGroupStr + "&ctn=" + ctn
						+ "&stateInfo=" + stateInfo + "&pageSize=" + pageSize + "&pageNo=" + pageNo;
			} else if ("queryNE".equals(pageType)) {
				url = "monitorData.do?action=queryNE&cip=" + cip + "&ctn=" + ctn + "&stateInfo=" + stateInfo
						+ "&pageSize=" + pageSize + "&pageNo=" + pageNo;
			}
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(url, getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.detecateData_n81i"), detectionInfoList, title, colu);
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		return null;
	}

	public String[] checkLins(Metadata metadata, CheckTypeInfo checkTypeInfo, Object[] sortFiledType, String dsiId,
			String seqId, String lines) {
		String[] retu = new String[2];
		try {
			String[] linStrings = lines.split(",");// 选择的端口，可能是多个
			String temp = "";
			String source = "select max(to_char(data_check_time,'yyyy-mm-dd HH24:mi')) maxTime," + sortFiledType[0]
					+ " from " + checkTypeInfo.getTableName() + " t where " + metadata.getFiledName() + " is not null"
					// +" and t.data_check_time >= trunc(sysdate-30)"
					+ " and t.detection_info_id in "
					+ "(select d.id from detection_info d  where d.detection_set_info_id=" + dsiId + " and d.seq_id = "
					+ seqId + ")";

			if (null != startTime && !startTime.equals("") && null != endTime && !endTime.equals("")) {
				source += " and to_char(data_check_time,'yyyy-mm-dd')>= '" + startTime
						+ "' and to_char(data_check_time,'yyyy-mm-dd')<='" + endTime + "'";
			} else {
				source += " and t.data_check_time >= trunc(sysdate-1) ";
			}
			if (sortFiledType[1].toString().equals("NUMBER") || sortFiledType[1].toString().equals("Number")) {
				temp = lines.substring(0, lines.length() - 1);
				source += " and " + sortFiledType[0] + " in (" + temp + ") group by " + sortFiledType[0]
						+ " order by maxTime desc";
			} else if (sortFiledType[1].toString().indexOf("VARCHAR2") != -1) {
				for (int i = 0; i < linStrings.length; i++) {
					temp += "'" + linStrings[i] + "',";
				}
				temp = temp.substring(0, temp.length() - 1);
				source += " and " + sortFiledType[0] + " in (" + temp + ") group by " + sortFiledType[0]
						+ " order by maxTime desc";
			}

			List lastList = this.commonService.executeSQL(source);
			// ------------------以上确定最后一个数据点----------------------------
			if (lastList != null && lastList.size() > 0) {
				Object[] row = (Object[]) lastList.get(0);
				String lastSource = "select * from ( select to_char(data_check_time,'yyyy-mm-dd HH24:mi'),"
						+ metadata.getFiledName() + " from " + checkTypeInfo.getTableName() + " t where "
						+ metadata.getFiledName() + " is not null"
						// +" and t.data_check_time >= trunc(sysdate-30)"
						+ " and t.detection_info_id in "
						+ "(select d.id from detection_info d  where d.detection_set_info_id=" + dsiId
						+ " and d.seq_id = " + seqId + ")";

				if (null != startTime && !startTime.equals("") && null != endTime && !endTime.equals("")) {
					lastSource += " and to_char(data_check_time,'yyyy-mm-dd')>= '" + startTime
							+ "' and to_char(data_check_time,'yyyy-mm-dd')<='" + endTime + "'";
				} else {
					lastSource += " and t.data_check_time >= trunc(sysdate-1) ";
				}
				if (sortFiledType[1].toString().equals("NUMBER") || sortFiledType[1].toString().equals("Number")) {
					lastSource += " and " + sortFiledType[0] + " = " + row[1] + " order by data_check_time desc) ttt ";
				} else if (sortFiledType[1].toString().indexOf("VARCHAR2") != -1) {
					lastSource += " and " + sortFiledType[0] + " = '" + row[1] + "' order by data_check_time desc) ttt ";
				}
				/* lastSource += " where rownum < 21"; */

				// @2018年4月10日18:45:00 fang 修改rownum 适配 mysql
//				if (Constant.IS_MYSQL) {
//					lastSource = lastSource + "  limit 20";
//				} else {
//					lastSource += " where rownum < 21 ";
//				}
				// System.out.println("------NoFirstInSource--------sql:" +
				// lastSource);
				List lineSourceList = this.commonService.executeSQL(lastSource);
				Object[] rowLast = (Object[]) lineSourceList.get(lineSourceList.size() - 1);// 最后一个
				// 返回的格式为：第一个：name(分类标志) 2：最小时间
				retu[0] = row[1].toString();
				retu[1] = rowLast[0].toString();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return retu;
	}
	

	public String getSnmpSource() {
		String mId = this.getRequest().getParameter("metaId");
		String dsiId = this.getRequest().getParameter("dId");
		String ctId = this.getRequest().getParameter("cId");
		String seqId = this.getRequest().getParameter("seqId");
		String lines = this.getRequest().getParameter("lns");
		String type = this.getRequest().getParameter("type");
		String detectionSetInfoId=this.getRequest().getParameter("detectionSetInfoId");
		System.out.println("mId:" + mId);
		System.out.println("dsiId:" + dsiId);
		System.out.println("ctId:" + ctId);
		System.out.println("seqId:" + seqId);
		System.out.println("lines:" + lines);
		System.out.println("type:" + type);

		String policeValSQL = "";
		List policeValue = null;
		Map<String, Object> result1 = new HashMap();
		// 预警值
		int policeVal = 0;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();
		NodeTable nt = null;
		try {

			CheckTypeInfo checkTypeInfo = (CheckTypeInfo) this.commonService.get(CheckTypeInfo.class,
					Long.parseLong(ctId));
			Metadata metadata = (Metadata) this.commonService.get(Metadata.class, Long.parseLong(mId));
			List<NodeTable> nts = this.commonService.find("from NodeTable where seqId=" + Long.parseLong(seqId));
			if (nts != null && nts.size() > 0) {
				nt = nts.get(0);
			}

			// 判断是否是特殊统计字段

			DetectionSetInfo dsi = (DetectionSetInfo) this.commonService.get(DetectionSetInfo.class,
					Long.parseLong(dsiId));
			// public part---------------------------begin--------------------
			// 预警线
			policeValSQL = "select police_value from data_police_relation where detection_set_info_id=" + dsiId
					+ " and metadata_id=" + metadata.getId();

			policeValue = this.commonService.executeSQL(policeValSQL);
			if (policeValue != null && policeValue.size() > 0) {
				// policeVal=((BigDecimal)policeValue.get(0)).intValue();
				policeVal = Integer.parseInt(policeValue.get(0).toString());
			}
			// 如果预警值不等于0则画预警线
			if (policeVal != 0) {
				result1.put("policeVal", policeVal);
			}

			if (metadata.getFiledComments() != null && !"".equals(metadata.getFiledComments())) {
				if (nt != null) {
					result1.put("xtitle", nt.getNodeIp() + "_" + dsi.getProcessIdenName() + " "
							+ checkTypeInfo.getCheckTypeName1() + "：" + metadata.getFiledComments() + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.cartogram_n81i"));
				} else {
					result1.put("xtitle", dsi.getProcessIdenName() + " " + checkTypeInfo.getCheckTypeName1() + "："
							+ metadata.getFiledComments() + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.cartogram_n81i"));
				}

				result1.put("ytitle", metadata.getFiledComments());
			} else {
				if (nt != null) {
					result1.put("xtitle",
							nt.getNodeIp() + "_" + dsi.getProcessIdenName() + " " + checkTypeInfo.getCheckTypeName()
									+ "：" + metadata.getFiledName().replace("_", " ") + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.cartogram_n81i"));
				} else {
					result1.put("xtitle", dsi.getProcessIdenName() + " " + checkTypeInfo.getCheckTypeName() + "："
							+ metadata.getFiledName().replace("_", " ") + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.cartogram_n81i"));
				}
				result1.put("ytitle", metadata.getFiledName().replace("_", " "));
			}

			returnList.add(result1);
			// public part---------------------------end----------------------

			// 得到分类标识字段
			String sort_sign = "select  t.filed_name,t.filed_type  from metadata t where t.check_type_id =" + ctId
					+ " and t.sort_sign =0";
			List sortList = this.commonService.executeSQL(sort_sign);

			if (sortList != null && sortList.size() > 0) {
				Object[] sortFiledType = (Object[]) sortList.get(0);
				Map<String, Object> result = new HashMap();
				List<Map<String, Object>> line = new ArrayList<Map<String, Object>>();
				// 选择checkBox画图
				if (lines != null && !lines.equals("")) {
					String[] linStrings = lines.split(",");
					for (int i = 0; i < linStrings.length; i++) {
						String[] cbStrings = checkLins(metadata, checkTypeInfo, sortFiledType, dsiId, seqId, linStrings[i]);
						String source = "";
						if (linStrings[i].equals(cbStrings[0])) {// 这是最后的那个
							source = "select * from ( select to_char(data_check_time,'yyyy-mm-dd HH24:mi') checkTime,"
									+ metadata.getFiledName() + " from " + checkTypeInfo.getTableName() + " t where "
									+ metadata.getFiledName() + " is not null"
									// +
									// " and t.data_check_time >=
									// to_date(to_char((sysdate-4),'yyyy-mm-dd'),'yyyy-mm-dd
									// hh24:mi')"+
									// +" and t.data_check_time >=
									// trunc(sysdate-30)"
									// + " and rownum <= 20"
									+ " and t.detection_info_id in "
									+ "(select d.id from detection_info d  where d.detection_set_info_id=" + dsiId
									+ " and d.seq_id = " + seqId + ")";

							if (null != startTime && !startTime.equals("") && null != endTime && !endTime.equals("")) {
								source += " and to_char(data_check_time,'yyyy-mm-dd')>= '" + startTime
										+ "' and to_char(data_check_time,'yyyy-mm-dd')<='" + endTime + "'";
							} else {
								source += " and t.data_check_time >= trunc(sysdate-0) ";
							}
							if (sortFiledType[1].toString().equals("NUMBER")
									|| sortFiledType[1].toString().equals("Number")) {
								source += " and " + sortFiledType[0] + " = " + linStrings[i].toString()
										+ " ) tttt order by checkTime desc";
							} else if (sortFiledType[1].toString().indexOf("VARCHAR2") != -1) {
								source += " and " + sortFiledType[0] + " = '" + linStrings[i].toString()
										+ "' ) tttt order by checkTime desc";
							}
							/* source += " where rownum < 21"; */
							// @2018年4月10日18:45:00 fang 修改rownum 适配 mysql
//							if (Constant.IS_MYSQL) {
//								source = source + " limit 20";
//							} else {
//								source += " where rownum < 21 ";
//							}
						} else {
							source = "select * from ( select to_char(data_check_time,'yyyy-mm-dd HH24:mi') checkTime,"
									+ metadata.getFiledName() + " from " + checkTypeInfo.getTableName() + " t where "
									+ metadata.getFiledName() + " is not null"
									// +" and t.data_check_time >=
									// trunc(sysdate-30)"
									+ " and t.detection_info_id in "
									+ "(select d.id from detection_info d  where d.detection_set_info_id=" + dsiId
									+ " and d.seq_id = " + seqId + ")";

							if (null != startTime && !startTime.equals("") && null != endTime && !endTime.equals("")) {
								source += " and to_char(data_check_time,'yyyy-mm-dd')>= '" + startTime
										+ "' and to_char(data_check_time,'yyyy-mm-dd')<='" + endTime + "'";
							} else {
								source += " and t.data_check_time >= trunc(sysdate-0) ";
							}
							if (sortFiledType[1].toString().equals("NUMBER")
									|| sortFiledType[1].toString().equals("Number")) {
								source += " and " + sortFiledType[0] + " = " + linStrings[i].toString();
							} else if (sortFiledType[1].toString().indexOf("VARCHAR2") != -1) {
								source += " and " + sortFiledType[0] + " = '" + linStrings[i].toString() + "'";
							}
							// 判断是否有返回 如果有则加入查询条件 如果无 则不加
							if (null != cbStrings[1] && !cbStrings[1].equals("")) {
								/*
								 * source +=
								 * " and t.data_check_time >= to_date('" +
								 * cbStrings[1] +
								 * "','yyyy-mm-dd HH24:mi') order by data_check_time desc) where rownum < 21"
								 * ;
								 */
								source += " and t.data_check_time >= to_date('" + cbStrings[1]
										+ "','yyyy-mm-dd HH24:mi') ) tttt order by checkTime desc";
								// @2018年4月10日18:45:00 fang 修改rownum 适配 mysql
//								if (Constant.IS_MYSQL) {
//									source = source + " limit 20";
//								} else {
//									source += " where rownum < 21 ";
//								}
							} else {
								/*
								 * source +=
								 * " order by data_check_time desc) where rownum < 21"
								 * ;
								 */
								source += " order by data_check_time desc) tttt ";
								// @2018年4月10日18:45:00 fang 修改rownum 适配 mysql
//								if (Constant.IS_MYSQL) {
//									source = source + " limit 20";
//								} else {
//									source += " where rownum < 21 ";
//								}
							}
						}
						System.out.println("------NoFirstInSource--------sql:" + source);
						List lineSourceList = this.commonService.executeSQL(source);

						List<Object[]> data = new ArrayList<Object[]>();

						// 封装一条拆线
						Map<String, Object> chart = new HashMap();

						if (lineSourceList.size() > 0) {
							for (int j = 0; j < lineSourceList.size(); j++) {
								Object[] row = (Object[]) lineSourceList.get(j);
								Object[] tmp = new Object[2];
								tmp[0] = (sdf.parse((String) row[0])).getTime();
								if (row[1] instanceof BigDecimal) {
									tmp[1] = ((BigDecimal) row[1]).setScale(2, BigDecimal.ROUND_HALF_UP);
								} else {
									tmp[1] = row[1];

								}
								data.add(tmp);
							}

						}
						// 封装一条折线--------------------------------------2013 1.23
						chart.put("name", linStrings[i].toString());
						chart.put("data", data);
						line.add(chart);
						result.put("lines", line);
					}
				} else {
					// 封装一条拆线
					Map<String, Object> chart = new HashMap();
					// 得到数据表中所有该分类标识的值
					String getAllSort = "select distinct " + sortFiledType[0].toString() + " from "
							+ checkTypeInfo.getTableName() + " where " + sortFiledType[0].toString()
							+ " is not null and seq_id=" + seqId + " and DETECTION_SET_INFO_ID= "+dsiId+" order by " + sortFiledType[0].toString();
					dataList = this.commonService.executeSQL(getAllSort);
					if (dataList != null && dataList.size() > 0) {
						String source = "select * from (select to_char(data_check_time,'yyyy-mm-dd HH24:mi') checkTime,"
								+ metadata.getFiledName() + " from " + checkTypeInfo.getTableName() + " t where "
								+ metadata.getFiledName() + " is not null"
								// + " and t.data_check_time >=
								// trunc(sysdate-30)"
								+ " and t.detection_info_id in "
								+ "(select d.id from detection_info d  where d.detection_set_info_id=" + dsiId
								+ " and d.seq_id = " + seqId + ")";

						if (null != startTime && !startTime.equals("") && null != endTime && !endTime.equals("")) {
							source += " and to_char(data_check_time,'yyyy-mm-dd')>= '" + startTime
									+ "' and to_char(data_check_time,'yyyy-mm-dd')<='" + endTime + "'";
						} else {
							source += " and t.data_check_time >= trunc(sysdate-0) ";
						}
						if (sortFiledType[1].toString().equals("NUMBER")
								|| sortFiledType[1].toString().equals("Number")) {
							source += " and " + sortFiledType[0] + " = " + dataList.get(0).toString()
									+ " ) order by checkTime desc";
						} else if (sortFiledType[1].toString().indexOf("VARCHAR2") != -1) {
							source += " and " + sortFiledType[0] + " = '" + dataList.get(0).toString()
									+ "' ) ttt order by checkTime desc";
						}
						/* source += " where rownum < 21"; */
						// @2018年4月10日18:45:00 fang 修改rownum 适配 mysql
//						if (Constant.IS_MYSQL) {
//							source = source + "  limit 20";
//						} else {
//							source += " where rownum < 21 ";
//						}
						System.out.println("------source--------sql:" + source);
						List lineSourceList = this.commonService.executeSQL(source);

						List<Object[]> data = new ArrayList<Object[]>();

						if (lineSourceList.size() > 0) {
							for (int j = 0; j < lineSourceList.size(); j++) {
								Object[] row = (Object[]) lineSourceList.get(j);
								Object[] tmp = new Object[2];
								tmp[0] = (sdf.parse((String) row[0])).getTime();
								if (row[1] instanceof BigDecimal) {
									tmp[1] = ((BigDecimal) row[1]).setScale(2, BigDecimal.ROUND_HALF_UP);
								} else {
									tmp[1] = row[1];

								}
								data.add(tmp);
							}

						}
						// 封装一条折线--------------------------------------2013 1.23
						chart.put("name", dataList.get(0).toString());
						chart.put("data", data);
						line.add(chart);
						result.put("lines", line);
					} else {
						// 封装一条折线--------------------------------------2013 1.23
						chart.put("name", "");
						chart.put("data", "");
						line.add(chart);
						result.put("lines", line);
					}

				}
				returnList.add(result);
			}

			// for (int i = 0; i < dataList.size(); i++) {
			// String source = "select to_char(data_check_time,'yyyy-mm-dd
			// HH24:mi'),"
			// + metadata.getFiledName()
			// + " from "
			// + checkTypeInfo.getTableName()
			// + " t where "
			// + metadata.getFiledName()
			// + " is not null"
			// +
			// // " and t.data_check_time >=
			// to_date(to_char((sysdate-4),'yyyy-mm-dd'),'yyyy-mm-dd hh24:mi')"+
			// " and t.data_check_time >= trunc(sysdate-30)"
			// + " and rownum <= 20"
			// + " and t.detection_info_id in "
			// + "(select d.id from detection_info d where
			// d.detection_set_info_id="
			// + dsiId + " and d.seq_id = " + seqId + ")";
			//
			// if (sortFiledType[1].toString().equals("NUMBER") ||
			// sortFiledType[1].toString().equals("Number")) {
			// source += " and " + sortFiledType[0] + " = "
			// + dataList.get(i).toString()
			// + " order by data_check_time desc";
			// } else if (sortFiledType[1].toString().indexOf("VARCHAR2") != -1)
			// {
			// source += " and " + sortFiledType[0] + " = '"
			// + dataList.get(i).toString()
			// + "' order by data_check_time desc";
			// } else {
			//
			// }
			// System.out.println("------source--------sql:" + source);
			// List lineSourceList = this.commonService.executeSQL(source);
			//
			// List<Object[]> data = new ArrayList<Object[]>();
			//
			// // 封装一条拆线
			// Map<String, Object> chart = new HashMap();
			//
			// if (lineSourceList.size() > 0) {
			// for (int j = 0; j < lineSourceList.size(); j++) {
			// Object[] row = (Object[]) lineSourceList.get(j);
			// Object[] tmp = new Object[2];
			// tmp[0] = (sdf.parse((String) row[0])).getTime();
			// if(row[1] instanceof BigDecimal) {
			// tmp[1] = ((BigDecimal) row[1]).setScale(2,
			// BigDecimal.ROUND_HALF_UP);
			// }else {
			// tmp[1] = row[1];
			//
			// }
			// data.add(tmp);
			// }
			//
			// }
			// // 封装一条折线--------------------------------------2013 1.23
			// chart.put("name", dataList.get(i).toString());
			// chart.put("data", data);
			// line.add(chart);
			// result.put("lines", line);
			// }
			//
			// returnList.add(result);
			//
			// }
			String jsonStr = JSONArray.fromObject(returnList).toString();
			System.out.println(jsonStr);
			this.getResponse().setCharacterEncoding("utf-8");
			PrintWriter printWriter = this.getResponse().getWriter();
			printWriter.write(jsonStr);
			printWriter.close();
			printWriter = null;
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			if (!StringUtil.isBlank(type) && type.equals("1")) {
				outHtmlString(
						"<script type=\"text/javascript\">alert('操作失败');this.location='monitorData.do?action=queryAbnormalSet'</script>");
			} else {
				outHtmlString(
						"<script type=\"text/javascript\">alert('操作失败');this.location='monitorData.do?action=query'</script>");
			}

		}
		return null;
	}

	private void queryMonitorDataInfoNewForTopo() {
		if (mypageNo > 0 && mypageSize > 0) {
			pageNo = mypageNo;
			pageSize = mypageSize;
		}
		try {
			StringBuffer sqlBuffer = new StringBuffer();

			sqlBuffer.append(
					" select distinct din.id,nt.node_ip,cti.check_type_name1,dsi.PROCESS_IDEN_NAME,din.detectioned_state detectioned_state");
			sqlBuffer.append(
					",to_char(din.data_check_time,'yyyy-MM-dd HH24:mi:Ss'),'',din.current_times,din.detection_state_info,to_char(din.status_change_time,'yyyy-MM-dd HH24:mi:Ss')");
			sqlBuffer.append(
					",dsi.id dsiiId,cti.id ctiId,din.seq_id sqId,nt.node_system_type nodeSysType,nvl(checkTypeCharState.charStateNum,0) charStateNum,nt.node_type nodeType,nt.ipn ipn");
			sqlBuffer.append(",din.police_emergent police_emergent,din.police_level police_level");
			sqlBuffer.append(" from DETECTION_INFO_NEW din");
			sqlBuffer.append(" left join DETECTION_SET_INFO dsi");
			sqlBuffer.append(" on din.detection_set_info_id = dsi.id");
			sqlBuffer.append(" left join check_type_info cti");
			sqlBuffer.append(" on dsi.check_type_id = cti.id");
			// @2018-3-9 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
			String groupIdSql = "select group_id from nodegroup_table t where 1=1 ";
			String ids = this.commonService.getGroupIdStartWith(groupIdSql, "t.group_id = " + nodeGroupId);
			/*
			 * sqlBuffer.
			 * append(" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id ,ipn from  NODE_TABLE WHERE node_group_id in"
			 * +
			 * "(select t.group_id from nodegroup_table t start with t.group_id ="
			 * + nodeGroupId +
			 * " connect by prior t.group_id = t.parent_group_id)) nt");
			 */
			sqlBuffer
					.append(" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id ,ipn from  NODE_TABLE WHERE node_group_id in"
							+ "(" + ids + ")) nt");
			sqlBuffer.append(" on din.seq_id = nt.seq_id");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------start
			sqlBuffer.append(" left join ");
			sqlBuffer.append(
					"  (select md.check_type_id as ctId,count(*) as charStateNum  from metadata md  where md.chart_state=0  group by md.check_type_id) checkTypeCharState ");
			sqlBuffer.append(" on checkTypeCharState.ctId=cti.id ");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------end

			// sqlBuffer.append("");
			sqlBuffer.append(
					" where nt.node_ip is not null and nt.node_state = 0 and dsi.detection_set_state ='1'  and cti.crete_state=0  and din.valid=1");// 只显示有效的数据：din.valid=1
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and nt.system_id = ");
				sqlBuffer.append(this.getSystemID());
			}
			if (cip != null && !"".equals(cip) && !"null".equals(cip)) {
				sqlBuffer.append(" and nt.node_ip like '%" + cip.trim() + "%'");
			}
			if (ctn != null && !"".equals(ctn)) {
				sqlBuffer.append(" and Upper(cti.Check_Type_Name1) like '%" + ctn.toUpperCase() + "%'");
			}
			if (StringUtils.isNotBlank(stateInfo)) {
				sqlBuffer.append(" and din.detection_state_info like '%" + stateInfo + "%'");
			}
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and (((( cti.view_level=1 and cti.user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( cti.view_level=2 and cti.group_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or cti.view_level=3 ) and cti.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (cti.view_level=4 )");
				sqlBuffer.append(") ");

				sqlBuffer.append("and (((( dsi.view_level=1 and dsi.create_user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( dsi.view_level=2 and dsi.create_usergroup_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or dsi.view_level=3 ) and dsi.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (dsi.view_level=4 )");
				sqlBuffer.append(") and dsi.detection_set_state=1 and cti.crete_state=0  ");
			}
			sqlBuffer.append(" ORDER by  detectioned_state, police_emergent, police_level");
			System.out.println("sqlBuffer:" + sqlBuffer.toString());
			page = this.commonService.findByPageForSql(sqlBuffer.toString(), pageNo, pageSize, null);
			List<Object[]> detectionInfoList; // 最新状态信息集合
			detectionInfoList = (List<Object[]>) page.getResult();
			detectionInfoList = changeValue(detectionInfoList, false);
			// 检测类别查询条件不为空时 查询出来的结果，先判断握手是否成功，如果握手状态异常则查出来的状态也是异常
			if (!StringUtil.isBlank(ctn)) {
				changeStatus(detectionInfoList, ctn);
			}
			nodeIpGroupListNew = changeShowList(detectionInfoList, false);
			if (StringUtils.isNotBlank(nodeGroupId)) {
				NodegroupTable ngt = (NodegroupTable) this.commonService.get(NodegroupTable.class,
						Long.parseLong(nodeGroupId.trim()));
				nodeGroupName = ngt == null ? "" : ngt.getGroupName();
			}
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.faild_n81i');</script>");
		}

	}

	private String queryMonitorDataInfoNewForTopoChild() {

		try {
			StringBuffer sqlBuffer = new StringBuffer();

			sqlBuffer.append(
					" select distinct din.id,nt.node_ip,cti.check_type_name1,dsi.PROCESS_IDEN_NAME,din.detectioned_state detectioned_state");
			sqlBuffer.append(
					",to_char(din.data_check_time,'yyyy-MM-dd HH24:mi:Ss'),'',din.current_times,din.detection_state_info,to_char(din.status_change_time,'yyyy-MM-dd HH24:mi:Ss')");
			sqlBuffer.append(
					",dsi.id dsiiId,cti.id ctiId,din.seq_id sqId,nt.node_system_type nodeSysType,nvl(checkTypeCharState.charStateNum,0) charStateNum,nt.node_type nodeType,nt.ipn ipn");
			sqlBuffer.append(",din.police_emergent police_emergent,din.police_level police_level");
			sqlBuffer.append(" from DETECTION_INFO_NEW din");
			sqlBuffer.append(" left join DETECTION_SET_INFO dsi");
			sqlBuffer.append(" on din.detection_set_info_id = dsi.id");
			sqlBuffer.append(" left join check_type_info cti");
			sqlBuffer.append(" on dsi.check_type_id = cti.id");
			// @2018-3-9 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
			String groupIdSql = "select group_id from nodegroup_table t where 1=1 ";
			String ids = this.commonService.getGroupIdStartWith(groupIdSql, "t.group_id = " + nodeGroupId);
			/*
			 * sqlBuffer.
			 * append(" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id ,ipn from  NODE_TABLE WHERE node_group_id in "
			 * +
			 * "(select t.group_id from nodegroup_table t start with t.group_id ="
			 * + nodeGroupId +
			 * " connect by prior t.group_id = t.parent_group_id)) nt");
			 */
			sqlBuffer
					.append(" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id ,ipn from  NODE_TABLE WHERE node_group_id in "
							+ "(" + ids + ")) nt");
			sqlBuffer.append(" on din.seq_id = nt.seq_id");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------start
			sqlBuffer.append(" left join ");
			sqlBuffer.append(
					"  (select md.check_type_id as ctId,count(*) as charStateNum  from metadata md  where md.chart_state=0  group by md.check_type_id) checkTypeCharState ");
			sqlBuffer.append(" on checkTypeCharState.ctId=cti.id ");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------end

			// sqlBuffer.append("");
			sqlBuffer.append(
					" where nt.node_ip is not null and nt.node_state = 0 and dsi.detection_set_state ='1'  and cti.crete_state=0  and din.valid=1");// 只显示有效的数据：din.valid=1
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and nt.system_id = ");
				sqlBuffer.append(this.getSystemID());
			}

			if (cip != null && !"".equals(cip) && !"null".equals(cip)) {
				sqlBuffer.append(" and nt.node_ip = '" + cip + "'");
			}
			if (ctn != null && !"".equals(ctn)) {
				sqlBuffer.append(" and Upper(cti.Check_Type_Name1) like '%" + ctn.toUpperCase() + "%'");

			}
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and (((( cti.view_level=1 and cti.user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( cti.view_level=2 and cti.group_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or cti.view_level=3 ) and cti.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (cti.view_level=4 )");
				sqlBuffer.append(") ");

				sqlBuffer.append("and (((( dsi.view_level=1 and dsi.create_user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( dsi.view_level=2 and dsi.create_usergroup_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or dsi.view_level=3 ) and dsi.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (dsi.view_level=4 )");
				sqlBuffer.append(") and dsi.detection_set_state=1 and cti.crete_state=0  ");
			}
			sqlBuffer.append(" ORDER by  detectioned_state, police_emergent, police_level");
			System.out.println("sqlBuffer:" + sqlBuffer.toString());
			page = this.commonService.findByPageForSql(sqlBuffer.toString(), pageNo, pageSize, null);
			List<Object[]> detectionInfoList; // 最新状态信息集合
			detectionInfoList = (List<Object[]>) page.getResult();
			detectionInfoList = changeValue(detectionInfoList, false);
			// 检测类别查询条件不为空时 查询出来的结果，先判断握手是否成功，如果握手状态异常则查出来的状态也是异常
			if (!StringUtil.isBlank(ctn)) {
				changeStatus(detectionInfoList, ctn);
			}
			nodeIpGroupListNew = changeShowList(detectionInfoList, false);
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.faild_n81i');</script>");
		}
		return "queryMonitorDataInfoChild";

	}

	/**
	 * 
	 * 拓扑图来源，查询紧急告警-服务器
	 * 
	 * @author jinshujuan Jun 18, 2013
	 * @version 1.0
	 * @return
	 */
	private void queryEmergent() {
		if (mypageNo > 0 && mypageSize > 0) {
			pageNo = mypageNo;
			pageSize = mypageSize;
		}
		try {
			StringBuffer sqlBuffer = new StringBuffer();

			sqlBuffer.append(
					" select distinct din.id,nt.node_ip,cti.check_type_name1,dsi.PROCESS_IDEN_NAME,din.detectioned_state detectioned_state");
			sqlBuffer.append(
					",to_char(din.data_check_time,'yyyy-MM-dd HH24:mi:Ss'),'',din.current_times,din.detection_state_info,to_char(din.status_change_time,'yyyy-MM-dd HH24:mi:Ss')");
			sqlBuffer.append(
					",dsi.id dsiiId,cti.id ctiId,din.seq_id sqId,nt.node_system_type nodeSysType,nvl(checkTypeCharState.charStateNum,0) charStateNum,nt.node_type nodeType,nt.ipn ipn");
			sqlBuffer.append(",din.police_emergent police_emergent,din.police_level police_level");
			sqlBuffer.append(" from DETECTION_INFO_NEW din");
			sqlBuffer.append(" left join DETECTION_SET_INFO dsi");
			sqlBuffer.append(" on din.detection_set_info_id = dsi.id");
			sqlBuffer.append(" left join check_type_info cti");
			sqlBuffer.append(" on dsi.check_type_id = cti.id");
			// @2018-3-9 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
			String groupIdSql = "select group_id from nodegroup_table t where 1=1 ";
			String ids = this.commonService.getGroupIdStartWith(groupIdSql, "t.group_id = " + nodeGroupId);
			/*
			 * sqlBuffer.
			 * append(" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id ,ipn from  NODE_TABLE WHERE node_group_id in "
			 * +
			 * "(select t.group_id from nodegroup_table t start with t.group_id ="
			 * + nodeGroupId +
			 * " connect by prior t.group_id = t.parent_group_id)) nt");
			 */
			sqlBuffer
					.append(" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id ,ipn from  NODE_TABLE WHERE node_group_id in "
							+ "(" + ids + ")) nt");
			sqlBuffer.append(" on din.seq_id = nt.seq_id");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------start
			sqlBuffer.append(" left join ");
			sqlBuffer.append(
					"  (select md.check_type_id as ctId,count(*) as charStateNum  from metadata md  where md.chart_state=0  group by md.check_type_id) checkTypeCharState ");
			sqlBuffer.append(" on checkTypeCharState.ctId=cti.id ");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------end

			sqlBuffer.append(
					" where nt.node_ip is not null and nt.node_state = 0 and dsi.detection_set_state ='1'  and cti.crete_state=0  and din.valid=1 and din.DETECTIONED_STATE<>1 AND din.POLICE_EMERGENT=0");// 只显示有效的数据：din.valid=1
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and nt.system_id = ");
				sqlBuffer.append(this.getSystemID());
			}
			if (cip != null && !"".equals(cip) && !"null".equals(cip)) {
				sqlBuffer.append(" and nt.node_ip like '%" + cip.trim() + "%'");
			}
			if (ctn != null && !"".equals(ctn)) {
				sqlBuffer.append(" and Upper(cti.Check_Type_Name1) like '%" + ctn.toUpperCase() + "%'");

			}
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and (((( cti.view_level=1 and cti.user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( cti.view_level=2 and cti.group_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or cti.view_level=3 ) and cti.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (cti.view_level=4 )");
				sqlBuffer.append(") ");

				sqlBuffer.append("and (((( dsi.view_level=1 and dsi.create_user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( dsi.view_level=2 and dsi.create_usergroup_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or dsi.view_level=3 ) and dsi.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (dsi.view_level=4 )");
				sqlBuffer.append(") and dsi.detection_set_state=1 and cti.crete_state=0  ");
			}
			sqlBuffer.append(" ORDER by  detectioned_state, police_emergent, police_level");
			System.out.println("sqlBuffer:" + sqlBuffer.toString());
			page = this.commonService.findByPageForSql(sqlBuffer.toString(), pageNo, pageSize, null);
			List<Object[]> detectionInfoList; // 最新状态信息集合
			detectionInfoList = (List<Object[]>) page.getResult();
			detectionInfoList = changeValue(detectionInfoList, false);
			// 检测类别查询条件不为空时 查询出来的结果，先判断握手是否成功，如果握手状态异常则查出来的状态也是异常
			if (!StringUtil.isBlank(ctn)) {
				changeStatus(detectionInfoList, ctn);
			}
			nodeIpGroupListNew = changeShowList(detectionInfoList, false);
			// if(StringUtils.isNotBlank(nodeGroupId)) {
			// NodegroupTable ngt =
			// (NodegroupTable)this.commonService.get(NodegroupTable.class,
			// Long.parseLong(nodeGroupId.trim()));
			// nodeGroupName = ngt==null?"":ngt.getGroupName();
			// }else {
			// nodeGroupName = "";
			// }
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.faild_n81i');</script>");
		}
	}

	/**
	 * 
	 * TODO 为了共用页面 将结果转换为 List<List>格式
	 * 
	 * @author jinshujuan Jun 18, 2013
	 * @version 1.0
	 * @param detectionInfoList
	 * @param b
	 * @return
	 */
	private List<List> changeShowList(List<Object[]> detectionInfoList, boolean b) {
		List<List> detecInfoGroupListNew = new ArrayList<List>();
		try {
			for (Object[] objects : detectionInfoList) {
				List<Object[]> listSoNews = new ArrayList<Object[]>();
				objects[6] = this.getPersistTime(DateUtil.getDateD(objects[5].toString()),
						DateUtil.getDateD(objects[9].toString()));
				listSoNews.add(objects);
				detecInfoGroupListNew.add(listSoNews);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return detecInfoGroupListNew;
	}

	private void queryNodeGroupInfo() {
		try {
			String hql = "from NodegroupTable where 1=1 ";
			if (!this.getAdminMark()) {// 非admin登录时才进行权限控制
																		// 权限控制----------------------------------------------------begin
																		// 如果当前登录选择了业务系统，则只做和本业务系统相关的操作
				if (this.getSystemID() != null) {
					hql += " and systemId = " + this.getSystemID();
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
				// 权限控制----------------------------------------------------end
			}
			hql += " order by groupLevel asc,showIndex asc";
			allNodeGroupInfo = this.commonService.find(hql.toString());
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
	}

	private void queryCheckTypeInfo() {
		try {
			/*
			 * String hql = ""; if (this.getAdminMark())
			 * {// 如果是admin登陆则无限制 hql = "from CheckTypeInfo where 1=1 and
			 * isSchedule<>2"; } else { // 权限控制--------begin String sqlparam = "
			 * or (t.viewLevel=4 )"; hql = "from CheckTypeInfo t where 1=1 and
			 * isSchedule<>2 and (( t.viewLevel=1 and t.userId=" +
			 * this.getUserID() + ")" + " or ( t.viewLevel=2 and t.groupId in
			 * (select x.jsbh from XtYhJsIndex x where x.yhbh='" +
			 * this.getUser().getYhbh() + "' and x.type = 1)) or (t.viewLevel=3
			 * and t.systemId = " + this.getSystemID() + ")" + sqlparam + ") ";
			 * // ----------------end } hql += " and creteState = 0 order by
			 * isSchedule asc , createTime asc";
			 * 
			 * allCheckTypeInfo = this.commonService.find(hql);
			 */
			StringBuffer hql = new StringBuffer();
			if (this.getAdminMark()) {// 如果是admin登陆则无限制
				hql.append("from CheckTypeInfo where isSchedule<>2 ");
			} else {
				// 权限控制--------begin
				hql.append("from CheckTypeInfo t where isSchedule<>2 and (( t.viewLevel=1 and t.userId=");
				hql.append(this.getUserID());
				
				hql.append(" and t.systemId =" + this.getSystemID() + ")");
				hql.append(" or ( t.viewLevel=2 and t.groupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='");
				hql.append(this.getUser().getYhbh());
				hql.append("' and x.type = 1) and t.systemId = " + this.getSystemID()
						+ ") or (t.viewLevel=3 and t.systemId = " + this.getSystemID() + ")");
				hql.append(" or (t.viewLevel=4 )");
				hql.append(") ");
				hql.append(" and t.id in (select dst.checkTypeInfo from DetectionSetInfo  dst where dst.detectionSetState=1)");
				// ----------------end
			}
			hql.append(
					" and creteState = 0 order by decode(isSchedule,0,0,2,0,1,1,2) asc ,decode(isSnmp,2,0,null,0,1) asc, ID asc");
			allCheckTypeInfo = this.commonService.find(hql.toString());
			System.out.println("...");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
	}

	// 添加此方法主要考虑使用HQL查询会因为表之间的关联关系而导致一条记录多次查询，故修改为sql查询。
	public void queryServerMonitorDataInfoNew() {
		if (mypageNo > 0 && mypageSize > 0) {
			pageNo = mypageNo;
			pageSize = mypageSize;
		}
		try {
			StringBuffer sqlBuffer = new StringBuffer();
			sqlBuffer.append(
					" select distinct din.id,nt.node_ip,cti.check_type_name1,dsi.PROCESS_IDEN_NAME,din.detectioned_state");
			sqlBuffer.append(
					",to_char(din.data_check_time,'yyyy-MM-dd HH24:mi:Ss'),'',din.current_times,din.detection_state_info,to_char(din.status_change_time,'yyyy-MM-dd HH24:mi:Ss')");
			
			sqlBuffer.append(
					",dsi.id dsiiId,cti.id ctiId,din.seq_id sqId,nt.node_system_type nodeSysType,nvl(checkTypeCharState.charStateNum,0) charStateNum,nt.node_type nodeType,nt.ipn ipn,decode(cti.check_type_name,'NMSClient',-1,cti.id) ctiId1,nt.special_server_type");

			sqlBuffer.append(" from DETECTION_INFO_NEW din");
			sqlBuffer.append(" left join DETECTION_SET_INFO dsi");
			sqlBuffer.append(" on din.detection_set_info_id = dsi.id");
			sqlBuffer.append(" left join check_type_info cti");
			sqlBuffer.append(" on dsi.check_type_id = cti.id");
			sqlBuffer.append(
					" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id ,ipn,special_server_type from  NODE_TABLE ");
			if (nodeGroupStr != null && !"".equals(nodeGroupStr) && !"null".equals(nodeGroupStr)) {
				// 节点组模糊名称不为空，则根据节点组名称，模糊查询所有节点组，再依次查找其下面的节点，得到节点id
				// @2018-3-9 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
				String groupIdSql = "select  group_id from nodegroup_table t where 1=1 ";
				String ids = this.commonService.getGroupIdStartWith(groupIdSql,
						"lower(group_name) like lower('%" + nodeGroupStr + "%')");
				/*
				 * sqlBuffer.
				 * append(" right join (select  distinct ngt.group_id from nodegroup_table ngt start with lower(ngt.group_name) like lower('%"
				 * + nodeGroupStr +
				 * "%')  connect by prior group_id=parent_group_id ) ngt on node_group_id=ngt.group_id"
				 * );
				 */
				sqlBuffer
						.append(" right join (select  distinct ngt.group_id from nodegroup_table ngt where ngt.group_id in ("
								+ ids + ")) ngt on node_group_id=ngt.group_id");
			}
			sqlBuffer.append(") nt on din.seq_id = nt.seq_id");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------start
			sqlBuffer.append(" left join ");
			sqlBuffer.append(
					"  (select md.check_type_id as ctId,count(*) as charStateNum  from metadata md  where md.chart_state=0  group by md.check_type_id) checkTypeCharState ");
			sqlBuffer.append(" on checkTypeCharState.ctId=cti.id ");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------end

			// sqlBuffer.append("");
			sqlBuffer.append(
					" where nt.node_ip is not null AND nt.node_type =0 and nt.node_state = 0 and dsi.detection_set_state ='1'  and cti.crete_state=0  and din.valid=1");// 只显示有效的数据：din.valid=1
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and nt.system_id = ");
				sqlBuffer.append(this.getSystemID());
			}
			if (cip != null && !"".equals(cip) && !"null".equals(cip)) {
				sqlBuffer.append(" and nt.node_ip like '%" + cip.trim() + "%'");
			}
			if (ctn != null && !"".equals(ctn)) {
				// sqlBuffer.append(" and cti.id =" + ctn);
				sqlBuffer.append(" and Upper(cti.Check_Type_Name1) like '%" + ctn.toUpperCase() + "%'");
			}
			if (checkType != null && checkType != -1) {
				sqlBuffer.append(" and cti.id =" + checkType);
			}
			if (StringUtils.isNotBlank(stateInfo)) {
				sqlBuffer.append(" and din.detection_state_info like '%" + stateInfo + "%'");
			}
			if (!this.getAdminMark()) {
				// 权限控制------begin
				// String sqlparam = " or (cti.view_level=4 )";
				/*
				 * sqlBuffer .append("and (( cti.view_level=1 and cti.user_id="
				 * + this.getUserID() + ")" + " or ( cti.view_level=2 and
				 * cti.group_id in (select x.jsbh from Xt_Yh_Js_Index x where
				 * x.yhbh='" + this.getUser().getYhbh() + "' and x.type = 1)) or
				 * (cti.view_level=3 and cti.system_id = " + this.getSystemID()
				 * + ")" + sqlparam + ") ");
				 */
				// -------------end
				sqlBuffer.append(" and (((( cti.view_level=1 and cti.user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( cti.view_level=2 and cti.group_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or cti.view_level=3 ) and cti.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (cti.view_level=4 )");
				sqlBuffer.append(") ");

				sqlBuffer.append("and (((( dsi.view_level=1 and dsi.create_user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( dsi.view_level=2 and dsi.create_usergroup_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or dsi.view_level=3 ) and dsi.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (dsi.view_level=4 )");
				sqlBuffer.append(") and dsi.detection_set_state=1 and cti.crete_state=0  ");
			}
			sqlBuffer.append(" order by ipn ASC,ctiId1 ASC, dsi.id ASC");
			System.out.println("sqlBuffer:" + sqlBuffer.toString());
			page = this.commonService.findByPageForSql(sqlBuffer.toString(), pageNo, pageSize, null);
			List<Object[]> detectionInfoList; // 最新状态信息集合
			detectionInfoList = (List<Object[]>) page.getResult();
			detectionInfoList = changeValue(detectionInfoList, false);
			// 检测类别查询条件不为空时 查询出来的结果，先判断握手是否成功，如果握手状态异常则查出来的状态也是异常
			if (!StringUtil.isBlank(ctn)) {
				changeStatus(detectionInfoList, ctn);
			}
			nodeIpGroupListNew = getNodeIpGroupListNew(detectionInfoList, false);
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.faild_n81i');this.location='monitorData.do?action=query'</script>");
		}
	}

	/**
	 * 
	 * 检测类别查询条件不为空时 对查询结果的状态特殊处理
	 * 
	 * @author jinshujuan May 30, 2013
	 * @version 1.0
	 * @param detectionInfoList
	 * @param ctn2
	 */
	private void changeStatus(List<Object[]> detectionInfoList, String checkType) {
		try {
			// 如果checkType 是握手检测则跳过
			String hql = " from CheckTypeInfo where checkTypeName1 like '%" + checkType + "%'";
			List<CheckTypeInfo> checkTypeInfos = commonService.find(hql);
			if (checkTypeInfos == null || checkTypeInfos.size() == 0) {
				return;
			}
			// 如果是握手检测跳过
			if (checkTypeInfos.get(0).getCheckTypeName().equals("NMSClient")) {
				return;
			}
			// 获取握手检测类别的ID
			hql = "select id from CheckTypeInfo where checkTypeName='NMSClient'";
			List idsList = commonService.find(hql);
			if (idsList == null || idsList.size() == 0) {
				return;
			}
			long checkTypeId = Long.parseLong(idsList.get(0).toString());
			for (Object[] objects : detectionInfoList) {
				String seqId = objects[12].toString();
				String sql = "SELECT t1.detectioned_state from DETECTION_INFO_NEW t1 WHERE t1.seq_id=" + seqId
						+ " AND t1.detection_set_info_id IN (SELECT t.id from DETECTION_SET_INFO t WHERE t.check_type_id="
						+ checkTypeId + " AND t.detection_set_state=1 ) ORDER BY t1.data_arrive_time DESC";
				List<Object> statusList = commonService.executeSQL(sql);
				if (statusList != null && statusList.size() > 0) {
					// status = 1说明握手正常
					String status = statusList.get(0) == null ? "" : statusList.get(0).toString();
					// 握手状态不正常status in (0 -1) 修改检测状态、持续时间
					if (!status.equals("1")) {
						// 3是界面展示的临时状态 存在于用检测类别查询时，该节点的握手检测异常状态时，其状态设置为3 页面不展示
						objects[4] = "3";
					}
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public String queryServerMonitorDataInfoChild() {
		try {
			StringBuffer sqlBuffer = new StringBuffer();
			sqlBuffer.append(
					" select distinct din.id,nt.node_ip,cti.check_type_name1,dsi.PROCESS_IDEN_NAME,din.detectioned_state");
			sqlBuffer.append(
					",to_char(din.data_check_time,'yyyy-MM-dd HH24:mi:Ss'),'',din.current_times,din.detection_state_info,to_char(din.status_change_time,'yyyy-MM-dd HH24:mi:Ss')");
			sqlBuffer.append(
					",dsi.id dsiiId,cti.id ctiId,din.seq_id sqId,nt.node_system_type nodeSysType,nvl(checkTypeCharState.charStateNum,0) charStateNum,nt.node_type nodeType,nt.ipn ipn ,decode(cti.check_type_name,'NMSClient',-1,cti.id) ctiId1");

			sqlBuffer.append(" from DETECTION_INFO_NEW din");
			sqlBuffer.append(" left join DETECTION_SET_INFO dsi");
			sqlBuffer.append(" on din.detection_set_info_id = dsi.id");
			sqlBuffer.append(" left join check_type_info cti");
			sqlBuffer.append(" on dsi.check_type_id = cti.id");
			sqlBuffer.append(
					" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id ,ipn from  NODE_TABLE ");
			if (nodeGroupStr != null && !"".equals(nodeGroupStr) && !"null".equals(nodeGroupStr)) {
				// 节点组模糊名称不为空，则根据节点组名称，模糊查询所有节点组，再依次查找其下面的节点，得到节点id
				// @2018-3-9 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
				String groupIdSql = "select  group_id from nodegroup_table t where 1=1 ";
				String ids = this.commonService.getGroupIdStartWith(groupIdSql,
						"lower(group_name) like lower('%" + nodeGroupStr + "%')");
				sqlBuffer
						.append(" right join (select  distinct ngt.group_id from nodegroup_table ngt where ngt.group_id in ("
								+ ids + ") ) ngt on node_group_id=ngt.group_id");
			}
			sqlBuffer.append(") nt on din.seq_id = nt.seq_id");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------start
			sqlBuffer.append(" left join ");
			sqlBuffer.append(
					"  (select md.check_type_id as ctId,count(*) as charStateNum  from metadata md  where md.chart_state=0  group by md.check_type_id) checkTypeCharState ");
			sqlBuffer.append(" on checkTypeCharState.ctId=cti.id ");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------end

			// sqlBuffer.append("");
			sqlBuffer.append(
					" where nt.node_ip is not null AND nt.node_type =0 and nt.node_state = 0 and dsi.detection_set_state ='1'  and cti.crete_state=0  and din.valid=1");// 只显示有效的数据：din.valid=1
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and nt.system_id = ");
				sqlBuffer.append(this.getSystemID());
			}
			// sqlBuffer.append("");
			// sqlBuffer.append(" ");
			if (cip != null && !"".equals(cip) && !"null".equals(cip)) {
				sqlBuffer.append(" and nt.node_ip = '" + cip + "'");
				// sqlBuffer.append(" and instr(nt.node_ip,'"+cip.trim()+"')
				// <> 0");
			}
			if (nodeIpRange != null && !"".equals(nodeIpRange) && !"null".equals(nodeIpRange)) {
				sqlBuffer.append(" and nt.node_ip like '" + nodeIpRange + "%'");
			}

			if (ctn != null && !"".equals(ctn)) {
				// sqlBuffer.append(" and cti.id =" + ctn);
				sqlBuffer.append(" and Upper(cti.Check_Type_Name1) like '%" + ctn.toUpperCase() + "%'");
			}
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and (((( cti.view_level=1 and cti.user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( cti.view_level=2 and cti.group_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or cti.view_level=3 ) and cti.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (cti.view_level=4 )");
				sqlBuffer.append(") ");

				sqlBuffer.append("and (((( dsi.view_level=1 and dsi.create_user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( dsi.view_level=2 and dsi.create_usergroup_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or dsi.view_level=3 ) and dsi.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (dsi.view_level=4 )");
				sqlBuffer.append(") and dsi.detection_set_state=1 and cti.crete_state=0  ");
			}
			sqlBuffer.append("  order by ipn ASC,ctiId1 ASC, dsi.id ASC");
			System.out.println("sqlBuffer:" + sqlBuffer.toString());
			page = this.commonService.findByPageForSql(sqlBuffer.toString(), pageNo, pageSize, null);
			List<Object[]> detectionInfoList; // 最新状态信息集合
			detectionInfoList = (List<Object[]>) page.getResult();
			detectionInfoList = changeValue(detectionInfoList, false);
			// 检测类别查询条件不为空时 查询出来的结果，先判断握手是否成功，如果握手状态异常则查出来的状态也是异常
			if (!StringUtil.isBlank(ctn)) {
				changeStatus(detectionInfoList, ctn);
			}
			nodeIpGroupListNew = getNodeIpGroupListNew(detectionInfoList, false);
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.faild_n81i');this.location='monitorData.do?action=query'</script>");
		}
		return "queryServerMonitorDataInfoChild";
	}

	public List<Object[]> changeValue(List<Object[]> list, boolean falg) throws Exception {
		Map<Long, Map<Long, String>> maps = (Map<Long, Map<Long, String>>) this.getRequest().getSession()
				.getServletContext().getAttribute("troubles");
		int index = 8;
		if (falg) {
			index++;
		}
		if (maps != null && maps.size() > 0) {
			if (maps.containsKey(this.getSystemID())) {// 判断系统id
				Map<Long, String> mapCode = maps.get(this.getSystemID());// key:
				// code
				// value:
				// desc
				Set<Long> keys = mapCode.keySet();
				for (int j = 0; j < list.size(); j++) {
					for (Iterator it = keys.iterator(); it.hasNext();) {
						if (list.get(j)[index] != null && !"".equals(list.get(j)[index])) {
							if (it.next().toString().equals(list.get(j)[index].toString())) {
								list.get(j)[index] = mapCode.get(it.next());
								break;
							}
						} else {
							list.get(j)[index] = "";
							break;
						}
					}
				}
			}
		}

		return list;
	}

	public String getDrawDateSource() {
		return "drawMonitorInfo";
	}

	public String ajaxDrawDateSource() {
		String resu = "";
		try {

			String dsiId = this.getRequest().getParameter("dsiId");
			// String ctId = this.getRequest().getParameter("checkTypeId");
			// String seqId = this.getRequest().getParameter("sqId");
			sqId = this.getRequest().getParameter("sqId");
			ctId = this.getRequest().getParameter("checkTypeId");
			detectionSetInfoId=this.getRequest().getParameter("detectionSetInfoId");
			System.out.println("dsiId:" + dsiId);
			System.out.println("ctId:" + ctId);
			System.out.println("seqId:" + sqId);
			CheckTypeInfo checkTypeInfo = (CheckTypeInfo) this.commonService.get(CheckTypeInfo.class,
					Long.parseLong(ctId));

			String tString = "select * from metadata where table_name = "
					+ "(select table_name from check_type_info where id="
					+ "(select check_type_id from detection_set_info where id=" + dsiId + ")) "
					+ " and chart_state = '0'";
			// " and chart_state = '0'
			// or id in(select metadata_id from data_police_relation
			// where police_state = '0' and detection_set_info_id="+dsiId+")";

			System.out.println("huatu:" + tString);

			metadataList = this.commonService.executeSQL(tString, Metadata.class);
			// 针对多项监测都使用分类标识，所以取消判断是否为snmp监控
			// if (checkTypeInfo.getIsSnmp() != null
			// && (checkTypeInfo.getIsSnmp() == 0 || checkTypeInfo
			// .getIsSnmp() == 1)) {
			// return this.checkLineNum(ctId,dsiId,seqId);
			// 得到分类标识字段
			String sort_sign = "select t.filed_name,t.filed_type  from metadata t where t.check_type_id =" + ctId
					+ " and t.sort_sign =0";
			List sortList = this.commonService.executeSQL(sort_sign);

			if (sortList != null && sortList.size() > 0) {
				Object[] sortFiledType = (Object[]) sortList.get(0);
				// 得到数据表中所有该分类标识的值
				String getAllSort = "select distinct " + sortFiledType[0].toString() + " from "
						+ checkTypeInfo.getTableName() + " where " + sortFiledType[0].toString()
						+ " is not null and seq_id =" + sqId + " and DETECTION_SET_INFO_ID="+dsiId+" order by " + sortFiledType[0].toString();
				// List sortValues = this.commonService.executeSQL(getAllSort);
				dataList = this.commonService.executeSQL(getAllSort);
				if (checkTypeInfo.getCheckTypeName().toLowerCase().equals("net")) {
					resu = "drawSpecialMonitorInfo";
				} else if (checkTypeInfo.getCheckTypeName().toLowerCase().equals("switchport")) {// 交换机监测：端口
					resu = "drawSwitchportMonitorInfo";// drawSwitchportMonitorInfo:选择多个端口时，显示多个端口之和的一条曲线
				} else {
					resu = "drawSnmpMonitorInfo";
				}
			} else {
				resu = "drawMonitorInfo";
			}

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.faild_n81i');this.location='detectionSet.do?action=query&pageNo="
							+ pageNo + "&pageSize=" + pageSize + "'</script>");
		}
		return resu;

	}

	public String getSpecialSource() {
		String mId = this.getRequest().getParameter("metaId");
		String dsiId = this.getRequest().getParameter("dId");
		String ctId = this.getRequest().getParameter("cId");
		String seqId = this.getRequest().getParameter("seqId");
		String lines = this.getRequest().getParameter("lns");
		String type = this.getRequest().getParameter("type");

		String policeValSQL = "";
		List policeValue = null;
		Map<String, Object> result1 = new HashMap();
		// 预警值
		int policeVal = 0;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();
		NodeTable nt = null;
		try {

			CheckTypeInfo checkTypeInfo = (CheckTypeInfo) this.commonService.get(CheckTypeInfo.class,
					Long.parseLong(ctId));
			Metadata metadata = (Metadata) this.commonService.get(Metadata.class, Long.parseLong(mId));
			List<NodeTable> nts = this.commonService.find("from NodeTable where seqId=" + Long.parseLong(seqId));
			if (nts != null && nts.size() > 0) {
				nt = nts.get(0);
			}

			int specialFlag = 0; // 0 非特殊数据 1字节速度特殊数据 2包速度特殊数据
			String specialColumn = "";
			if (checkTypeInfo != null && StringUtils.isNotBlank(checkTypeInfo.getCheckTypeName())) {
				if (checkTypeInfo.getCheckTypeName().toLowerCase().equals("switchport")) { // net监测类别
					if (metadata.getFiledName().toLowerCase().equals("inoctetsspeed")) {
						specialFlag = 1;
						specialColumn = "Data_64_FLag,decode(Ifhighspeed,null,ifspeed,0,ifspeed,ifhighspeed*1024*1024) ifhighspeedbps,"
								+ metadata.getFiledName() + ",ifInOctets";
					} else if (metadata.getFiledName().toLowerCase().equals("outoctetsspeed")) {
						specialFlag = 1;
						specialColumn = "Data_64_FLag,decode(Ifhighspeed,null,ifspeed,0,ifspeed,ifhighspeed*1024*1024) ifhighspeedbps,"
								+ metadata.getFiledName() + ",ifOutOctets";
					} else if (metadata.getFiledName().toLowerCase().equals("inpktsspeed")) {
						specialFlag = 2;
						specialColumn = "Data_64_FLag,decode(Ifhighspeed,null,ifspeed,0,ifspeed,ifhighspeed*1024*1024) ifhighspeedbps,"
								+ metadata.getFiledName() + ",ifInUcastPkts,ifInNUcastPkts,IFINOCTETS";
					} else if (metadata.getFiledName().toLowerCase().equals("outpktsspeed")) {
						specialFlag = 2;
						specialColumn = "Data_64_FLag,decode(Ifhighspeed,null,ifspeed,0,ifspeed,ifhighspeed*1024*1024) ifhighspeedbps,"
								+ metadata.getFiledName() + ",ifOutUcastPkts,ifOutNUcastPkts,IFOUTOCTETS";
					} else {
						specialFlag = 0;
						specialColumn = metadata.getFiledName();
					}
				} else if (checkTypeInfo.getCheckTypeName().toLowerCase().equals("net")) {// switchport
																							// 监测类别
					if (metadata.getFiledName().toLowerCase().equals("rx_bps")) { // 输入bps（单位：bps）
						specialFlag = 1;
						specialColumn = "0 data64flag,decode(speed,0,0,null,0,speed*1024*1024),"
								+ metadata.getFiledName() + ",rx_bytes";
					} else if (metadata.getFiledName().toLowerCase().equals("tx_bps")) { // 输出bps（单位：bps）
						specialFlag = 1;
						specialColumn = "0 data64flag,decode(speed,0,0,null,0,speed*1024*1024),"
								+ metadata.getFiledName() + ",tx_bytes";
					} else if (metadata.getFiledName().toLowerCase().equals("rx_pps")) { // 输入pps（每秒接收包数）
						specialFlag = 2;
						specialColumn = "0 data64flag,decode(speed,0,0,null,0,speed*1024*1024),"
								+ metadata.getFiledName() + ",rx_packets,0,RX_BYTES";
					} else if (metadata.getFiledName().toLowerCase().equals("tx_pps")) { // 输出pps（每秒发出包数）
						specialFlag = 2;
						specialColumn = "0 data64flag,decode(speed,0,0,null,0,speed*1024*1024),"
								+ metadata.getFiledName() + ",tx_packets,0,TX_BYTES ";
					} else {
						specialFlag = 0;
						specialColumn = metadata.getFiledName();
					}
				}
			}

			DetectionSetInfo dsi = (DetectionSetInfo) this.commonService.get(DetectionSetInfo.class,
					Long.parseLong(dsiId));

			// public part---------------------------begin--------------------
			// 预警线
			policeValSQL = "select police_value from data_police_relation where detection_set_info_id=" + dsiId
					+ " and metadata_id=" + metadata.getId();

			policeValue = this.commonService.executeSQL(policeValSQL);
			if (policeValue != null && policeValue.size() > 0) {
				// policeVal=((BigDecimal)policeValue.get(0)).intValue();
				policeVal = Integer.parseInt(policeValue.get(0).toString());
			}
			// 如果预警值不等于0则画预警线
			if (policeVal != 0) {
				result1.put("policeVal", policeVal);
			}

			if (metadata.getFiledComments() != null && !"".equals(metadata.getFiledComments())) {
				if (nt != null) {
					result1.put("xtitle", nt.getNodeIp() + "_" + dsi.getProcessIdenName() + " "
							+ checkTypeInfo.getCheckTypeName1() + "：" + metadata.getFiledComments() + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.cartogram_n81i"));
				} else {
					result1.put("xtitle", dsi.getProcessIdenName() + " " + checkTypeInfo.getCheckTypeName1() + "："
							+ metadata.getFiledComments() + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.cartogram_n81i"));
				}

				result1.put("ytitle", metadata.getFiledComments());
			} else {
				if (nt != null) {
					result1.put("xtitle",
							nt.getNodeIp() + "_" + dsi.getProcessIdenName() + " " + checkTypeInfo.getCheckTypeName()
									+ "：" + metadata.getFiledName().replace("_", " ") + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.cartogram_n81i"));
				} else {
					result1.put("xtitle", dsi.getProcessIdenName() + " " + checkTypeInfo.getCheckTypeName() + "："
							+ metadata.getFiledName().replace("_", " ") + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.cartogram_n81i"));
				}
				result1.put("ytitle", metadata.getFiledName().replace("_", " "));
			}

			returnList.add(result1);
			// public part---------------------------end----------------------

			// 得到分类标识字段
			String sort_sign = "select  t.filed_name,t.filed_type  from metadata t where t.check_type_id =" + ctId
					+ " and t.sort_sign =0";
			List sortList = this.commonService.executeSQL(sort_sign);

			Object[] objs = null;
			List<Object[]> dataPoint = new ArrayList<Object[]>();

			if (sortList != null && sortList.size() > 0) {
				Object[] sortFiledType = (Object[]) sortList.get(0);
				Map<String, Object> result = new HashMap();
				List<Map<String, Object>> line = new ArrayList<Map<String, Object>>();
				// 选择checkBox画图
				if (lines != null && !lines.equals("")) {
					String[] linStrings = lines.split(",");
					for (int i = 0; i < linStrings.length; i++) {
						String[] cbStrings = checkLins(metadata, checkTypeInfo, sortFiledType, dsiId, seqId, linStrings[i]);
						String source = "";
						if (linStrings[i].equals(cbStrings[0])) {// 这是最后的那个
							source = "select * from ( select data_check_time_digital ," + specialColumn + " from "
									+ checkTypeInfo.getTableName() + " t where " + metadata.getFiledName()
									+ " is not null"
									// +
									// " and t.data_check_time >=
									// to_date(to_char((sysdate-4),'yyyy-mm-dd'),'yyyy-mm-dd
									// hh24:mi')"+
									// +" and t.data_check_time >=
									// trunc(sysdate-30)"
									// + " and rownum <= 20"
									+ " and t.detection_set_info_id=" + dsiId + " and t.seq_id = " + seqId + " ";

							if (null != startTime && !startTime.equals("") && null != endTime && !endTime.equals("")) {
								source += " and to_char(data_check_time,'yyyy-mm-dd')>= '" + startTime
										+ "' and to_char(data_check_time,'yyyy-mm-dd')<='" + endTime + "'";
							} else {
								source += " and t.data_check_time >= trunc(sysdate-0) ";
							}
							if (sortFiledType[1].toString().equals("NUMBER")
									|| sortFiledType[1].toString().equals("Number")) {
								source += " and " + sortFiledType[0] + " = " + linStrings[i].toString()
										+ " ) ttt ";
							} else if (sortFiledType[1].toString().indexOf("VARCHAR2") != -1) {
								source += " and " + sortFiledType[0] + " = '" + linStrings[i].toString()
										+ "' ) ttt ";
							}
							/*
							 * source +=
							 * " where rownum < 21 order by data_check_time_digital asc"
							 * ;
							 */
							// @2018年4月10日18:45:00 fang 修改rownum 适配 mysql
							if (Constant.IS_MYSQL) {
//								source = source + " order by data_check_time_digital desc limit 20";
								source = source + " order by data_check_time_digital desc ";
							} else {
//								source += " where rownum < 21 order by data_check_time_digital desc";
								source += " order by data_check_time_digital desc";
							}
						} else {
							source = "select * from ( select data_check_time_digital," + specialColumn + " from "
									+ checkTypeInfo.getTableName() + " t where " + metadata.getFiledName()
									+ " is not null"
									// +" and t.data_check_time >=
									// trunc(sysdate-30)"
									+ " and t.Detection_Set_Info_Id =" + dsiId + " and t.seq_id = " + seqId + " ";

							if (null != startTime && !startTime.equals("") && null != endTime && !endTime.equals("")) {
								source += " and to_char(data_check_time,'yyyy-mm-dd')>= '" + startTime
										+ "' and to_char(data_check_time,'yyyy-mm-dd')<='" + endTime + "'";
							} else {
								source += " and t.data_check_time >= trunc(sysdate-0) ";
							}
							if (sortFiledType[1].toString().equals("NUMBER")
									|| sortFiledType[1].toString().equals("Number")) {
								source += " and " + sortFiledType[0] + " = " + linStrings[i].toString();
							} else if (sortFiledType[1].toString().indexOf("VARCHAR2") != -1) {
								source += " and " + sortFiledType[0] + " = '" + linStrings[i].toString() + "'";
							}
							// 判断是否有返回 如果有则加入查询条件 如果无 则不加
							if (null != cbStrings[1] && !cbStrings[1].equals("")) {
								/*
								 * source +=
								 * " and t.data_check_time >= to_date('" +
								 * cbStrings[1] +
								 * "','yyyy-mm-dd HH24:mi') order by data_check_time_digital desc) where rownum < 21 order by data_check_time_digital asc"
								 * ;
								 */
								source += " and t.data_check_time >= to_date('" + cbStrings[1]
										+ "','yyyy-mm-dd HH24:mi') ) ttt ";
								// @2018年4月10日18:45:00 fang 修改rownum 适配 mysql
								if (Constant.IS_MYSQL) {
//									source = source + " order by data_check_time_digital desc limit 20";
									source = source + " order by data_check_time_digital desc ";
								} else {
//									source += " where rownum < 21 order by data_check_time_digital desc";
									source += " order by data_check_time_digital desc";
								}
							} else {
								/*
								 * source +=
								 * " order by data_check_time_digital desc) where rownum < 21 order by data_check_time_digital asc"
								 * ;
								 */
								source += " ) ttt ";
								// @2018年4月10日18:45:00 fang 修改rownum 适配 mysql
								if (Constant.IS_MYSQL) {
//									source = source + " order by data_check_time_digital desc limit 20";
									source = source + " order by data_check_time_digital desc ";
								} else {
//									source += " where rownum < 21 order by data_check_time_digital desc";
									source += " order by data_check_time_digital desc";
								}
							}
						}
						source = "select * from ("+source+") tt order by data_check_time_digital";
						System.out.println("------NoFirstInSource--------sql:" + source);
						List lineSourceList = this.commonService.executeSQL(source);

						// 展示数据封装处理
						if (specialFlag == 1) { // 字节特殊数据 再次处理
							objs = commonService.bitSpeedSourceList(lineSourceList, dsi.getCheckGap() * 60 * 1000);

						} else if (specialFlag == 2) { // 包特殊数据 再次处理
							objs = commonService.pktSpeedSourceList(lineSourceList, dsi.getCheckGap() * 60 * 1000);

						} else { // 整理为数据格式

							if (lineSourceList.size() > 0) {
								for (int j = 0; j < lineSourceList.size(); j++) {
									Object[] row = (Object[]) lineSourceList.get(j);
									Object[] tmp = new Object[2];
									tmp[0] = ((BigDecimal) row[0]).longValue();
									if (row[1] instanceof BigDecimal) {
										tmp[1] = ((BigDecimal) row[1]).setScale(2, BigDecimal.ROUND_HALF_UP);
									} else {
										tmp[1] = row[1];

									}
									dataPoint.add(tmp);
								}

							}
						}
						this.getRequest().setAttribute("lineStr", linStrings[i].toString());
						// 封装一条拆线
						Map<String, Object> specialchart1 = new HashMap();
						specialchart1.put("name", linStrings[i].toString() + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.avg_n81i"));
						specialchart1.put("data", objs != null ? objs[0] : null);
						// 封装一条拆线
						Map<String, Object> specialchart2 = new HashMap();
						specialchart2.put("name", getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.moment_n81i"));
						specialchart2.put("data", objs != null ? objs[1] : null);
						// 封装一条拆线
						Map<String, Object> chart = new HashMap();
						// 封装一条折线--------------------------------------2013 1.23
						chart.put("name", linStrings[i].toString());
						chart.put("data", dataPoint);
						line.add(specialchart1);
						line.add(specialchart2);
						line.add(chart);
						result.put("lines", line);
					}
				} else {
					// 封装一条拆线
					Map<String, Object> chart = new HashMap();
					// 得到数据表中所有该分类标识的值
					String getAllSort = "select distinct " + sortFiledType[0].toString() + " from "
							+ checkTypeInfo.getTableName() + " where " + sortFiledType[0].toString()
							+ " is not null and seq_id=" + seqId + " and DETECTION_SET_INFO_ID="+dsiId+" order by " + sortFiledType[0].toString();
					dataList = this.commonService.executeSQL(getAllSort);
					if (dataList != null && dataList.size() > 0) {
						String source = "select * from (select data_check_time_digital," + specialColumn + " from "
								+ checkTypeInfo.getTableName() + " t where " + metadata.getFiledName() + " is not null"
								// + " and t.data_check_time >=
								// trunc(sysdate-30)"
								+ " and t.Detection_Set_Info_Id = " + dsiId + " and t.seq_id = " + seqId;

						if (null != startTime && !startTime.equals("") && null != endTime && !endTime.equals("")) {
							source += " and to_char(data_check_time,'yyyy-mm-dd')>= '" + startTime
									+ "' and to_char(data_check_time,'yyyy-mm-dd')<='" + endTime + "'";
						} else {
							source += " and t.data_check_time >= trunc(sysdate-0) ";
						}
						if (sortFiledType[1].toString().equals("NUMBER")
								|| sortFiledType[1].toString().equals("Number")) {
							source += " and " + sortFiledType[0] + " = " + dataList.get(0).toString()
									+ " )";
						} else if (sortFiledType[1].toString().indexOf("VARCHAR2") != -1) {
							source += " and " + sortFiledType[0] + " = '" + dataList.get(0).toString()
									+ "' )";
						}
						/*
						 * source +=
						 * " where rownum < 21 order by data_check_time_digital asc"
						 * ;
						 */
						// @2018年4月10日18:45:00 fang 修改rownum 适配 mysql
						if (Constant.IS_MYSQL) {
//							source = source + " order by data_check_time_digital asc limit 20";
							source = source + " order by data_check_time_digital asc ";
						} else {
//							source += " where rownum < 21 order by data_check_time_digital asc";// 查询最近时间的21条数据
							source += " order by data_check_time_digital asc";// 查询最近时间的21条数据
						}
						
						source = "select * from ("+source+") tt order by data_check_time_digital";
						System.out.println("------source--------sql:" + source);
						
						List lineSourceList = this.commonService.executeSQL(source);
						
						// 展示数据封装处理
						if (specialFlag == 1) { // 字节特殊数据 再次处理
							objs = commonService.bitSpeedSourceList(lineSourceList, dsi.getCheckGap() * 60 * 1000);

						} else if (specialFlag == 2) { // 包特殊数据 再次处理
							objs = commonService.pktSpeedSourceList(lineSourceList, dsi.getCheckGap() * 60 * 1000);

						} else { // 整理为数据格式

							for (int j = 0; j < lineSourceList.size(); j++) {
								Object[] row = (Object[]) lineSourceList.get(j);
								Object[] tmp = new Object[2];
								tmp[0] = ((BigDecimal) row[0]).longValue();
								if (row[1] instanceof BigDecimal) {
									tmp[1] = ((BigDecimal) row[1]).setScale(2, BigDecimal.ROUND_HALF_UP);
								} else {
									tmp[1] = row[1];

								}
								dataPoint.add(tmp);
							}
						}
						this.getRequest().setAttribute("lineStr", dataList.get(0).toString());
						// 封装一条拆线
						Map<String, Object> specialchart1 = new HashMap();
						specialchart1.put("name", dataList.get(0).toString() + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.avg_n81i"));
						specialchart1.put("data", objs != null ? objs[0] : null);
						// 封装一条拆线
						Map<String, Object> specialchart2 = new HashMap();
						specialchart2.put("name", getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.moment_n81i"));
						specialchart2.put("data", objs != null ? objs[1] : null);
						// 封装一条折线--------------------------------------2013 1.23
						chart.put("name", dataList.get(0).toString());
						chart.put("data", dataPoint);
						line.add(specialchart1);
						line.add(specialchart2);
						line.add(chart);
						result.put("lines", line);
					} else {
						// 封装一条折线--------------------------------------2013 1.23
						chart.put("name", "");
						chart.put("data", "");
						line.add(chart);
						result.put("lines", line);
					}

				}

				returnList.add(result);
			}

			// for (int i = 0; i < dataList.size(); i++) {
			// String source = "select to_char(data_check_time,'yyyy-mm-dd
			// HH24:mi'),"
			// + metadata.getFiledName()
			// + " from "
			// + checkTypeInfo.getTableName()
			// + " t where "
			// + metadata.getFiledName()
			// + " is not null"
			// +
			// // " and t.data_check_time >=
			// to_date(to_char((sysdate-4),'yyyy-mm-dd'),'yyyy-mm-dd hh24:mi')"+
			// " and t.data_check_time >= trunc(sysdate-30)"
			// + " and rownum <= 20"
			// + " and t.detection_info_id in "
			// + "(select d.id from detection_info d where
			// d.detection_set_info_id="
			// + dsiId + " and d.seq_id = " + seqId + ")";
			//
			// if (sortFiledType[1].toString().equals("NUMBER") ||
			// sortFiledType[1].toString().equals("Number")) {
			// source += " and " + sortFiledType[0] + " = "
			// + dataList.get(i).toString()
			// + " order by data_check_time desc";
			// } else if (sortFiledType[1].toString().indexOf("VARCHAR2") != -1)
			// {
			// source += " and " + sortFiledType[0] + " = '"
			// + dataList.get(i).toString()
			// + "' order by data_check_time desc";
			// } else {
			//
			// }
			// System.out.println("------source--------sql:" + source);
			// List lineSourceList = this.commonService.executeSQL(source);
			//
			// List<Object[]> data = new ArrayList<Object[]>();
			//
			// // 封装一条拆线
			// Map<String, Object> chart = new HashMap();
			//
			// if (lineSourceList.size() > 0) {
			// for (int j = 0; j < lineSourceList.size(); j++) {
			// Object[] row = (Object[]) lineSourceList.get(j);
			// Object[] tmp = new Object[2];
			// tmp[0] = (sdf.parse((String) row[0])).getTime();
			// if(row[1] instanceof BigDecimal) {
			// tmp[1] = ((BigDecimal) row[1]).setScale(2,
			// BigDecimal.ROUND_HALF_UP);
			// }else {
			// tmp[1] = row[1];
			//
			// }
			// data.add(tmp);
			// }
			//
			// }
			// // 封装一条折线--------------------------------------2013 1.23
			// chart.put("name", dataList.get(i).toString());
			// chart.put("data", data);
			// line.add(chart);
			// result.put("lines", line);
			// }
			//
			// returnList.add(result);
			//
			// }
			this.getRequest().setAttribute("specialFlag", specialFlag); // 0
			// 非特殊字段
			// 1
			// 特殊字段

			String jsonStr = JSONArray.fromObject(returnList).toString();
			System.out.println(jsonStr);
			this.getResponse().setCharacterEncoding("utf-8");
			PrintWriter printWriter = this.getResponse().getWriter();
			printWriter.write(jsonStr);
			printWriter.close();
			printWriter = null;
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			if (!StringUtil.isBlank(type) && type.equals("1")) {
				outHtmlString(
						"<script type=\"text/javascript\">alert('i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.faild_n81i');this.location='monitorData.do?action=queryAbnormalSet'</script>");
			} else {
				outHtmlString(
						"<script type=\"text/javascript\">alert('i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.faild_n81i');this.location='monitorData.do?action=query'</script>");
			}

		}
		return null;

	}

	public static void main(String[] args) {
		Date a = new Date(1381383780091l);
		System.out.println(a);
		Date b = new Date(1381384080092l);
		System.out.println(b);
	}

	/**
	 * 逻辑：网元监测列表，只针对switchport监测 一个节点 + 一个监测类别 + 一个监测设置 + 一个字段 + 一个分类标识的多个值
	 * 1.根据当前字段，组织查询的内容 2.告警线:查询当前字段是否有告警值，如果有，且不为0，则画告警线 3.查询分类字段（只有一个字段）：端口名
	 * 
	 * returnList：result1(告警线) + result（数据线）
	 * 
	 * @author hyx Sep 23, 2013
	 */
	public String getSwitchportSource() {
		String mId = this.getRequest().getParameter("metaId");
		String dsiId = this.getRequest().getParameter("dId");
		String ctId = this.getRequest().getParameter("cId");
		String seqId = this.getRequest().getParameter("seqId");
		String lines = this.getRequest().getParameter("lns");// 选中端口：未选中端口时，为undefined
		if ("undefined".equalsIgnoreCase(lines) || "null".equalsIgnoreCase(lines)) {
			lines = "";
		}

		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();// 最终返回的数据
		try {
			CheckTypeInfo checkTypeInfo = (CheckTypeInfo) this.commonService.get(CheckTypeInfo.class,
					Long.parseLong(ctId));// 监测类别
			DetectionSetInfo dsi = (DetectionSetInfo) this.commonService.get(DetectionSetInfo.class,
					Long.parseLong(dsiId));
			Metadata metadata = (Metadata) this.commonService.get(Metadata.class, Long.parseLong(mId));// 展示的字段
			List<NodeTable> nts = this.commonService.find("from NodeTable where seqId=" + Long.parseLong(seqId));// 当前节点
			NodeTable nt = (nts != null && nts.size() > 0) ? nts.get(0) : null;

			if (checkTypeInfo != null && dsi != null && metadata != null && nt != null) {
				// 根据当前展示曲线的字段，组织查询的内容
				int specialFlag = 0; // 0 非特殊数据 1字节速度特殊数据 2包速度特殊数据
				String specialColumn = "";
				if (StringUtils.isNotBlank(metadata.getFiledName())) {
					if (metadata.getFiledName().toLowerCase().equals("inoctetsspeed")) {// 输入速度
						specialFlag = 1;
						specialColumn = "Data_64_FLag,sum(decode(Ifhighspeed,null,ifspeed,0,ifspeed,ifhighspeed*1024*1024)) ifhighspeedbps,sum("
								+ metadata.getFiledName() + "),sum(ifInOctets)";
					} else if (metadata.getFiledName().toLowerCase().equals("outoctetsspeed")) {// 输出速度
						specialFlag = 1;
						specialColumn = "Data_64_FLag,sum(decode(Ifhighspeed,null,ifspeed,0,ifspeed,ifhighspeed*1024*1024)) ifhighspeedbps,sum("
								+ metadata.getFiledName() + "),sum(ifOutOctets)";
					} else if (metadata.getFiledName().toLowerCase().equals("inpktsspeed")) {// 收包速率
						specialFlag = 2;
						specialColumn = "Data_64_FLag,sum(decode(Ifhighspeed,null,ifspeed,0,ifspeed,ifhighspeed*1024*1024)) ifhighspeedbps,sum("
								+ metadata.getFiledName() + "),sum(ifInUcastPkts),sum(ifInNUcastPkts),sum(IFINOCTETS)";
					} else if (metadata.getFiledName().toLowerCase().equals("outpktsspeed")) {// 发包速率
						specialFlag = 2;
						specialColumn = "Data_64_FLag,sum(decode(Ifhighspeed,null,ifspeed,0,ifspeed,ifhighspeed*1024*1024)) ifhighspeedbps,sum("
								+ metadata.getFiledName()
								+ "),sum(ifOutUcastPkts),sum(ifOutNUcastPkts),sum(IFOUTOCTETS)";
					} else {
						specialFlag = 0;
						specialColumn = "sum(" + metadata.getFiledName() + ")";
					}
				}

				// 预警线 public
				// part---------------------------begin--------------------
				String policeValSQL = "select police_value from data_police_relation where detection_set_info_id="
						+ dsiId + " and metadata_id=" + metadata.getId();
				List policeValue = this.commonService.executeSQL(policeValSQL);
				Map<String, Object> result1 = new HashMap();// 预警线数据
				if (policeValue != null && policeValue.size() > 0) {
					int policeVal = Integer.parseInt(policeValue.get(0).toString());
					result1.put("policeVal", policeVal);// 之前为什么预警值为0的时候不画线？如果设置的值就是0呢？
				}

				if (metadata.getFiledComments() != null && !"".equals(metadata.getFiledComments())) {
					if (nt != null) {
						result1.put("xtitle", nt.getNodeIp() + "_" + dsi.getProcessIdenName() + " "
								+ checkTypeInfo.getCheckTypeName1() + "：" + metadata.getFiledComments() + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.cartogram_n81i"));
					} else {
						result1.put("xtitle", dsi.getProcessIdenName() + " " + checkTypeInfo.getCheckTypeName1() + "："
								+ metadata.getFiledComments() + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.cartogram_n81i"));
					}

					result1.put("ytitle", metadata.getFiledComments());
				} else {
					if (nt != null) {
						result1.put("xtitle",
								nt.getNodeIp() + "_" + dsi.getProcessIdenName() + " " + checkTypeInfo.getCheckTypeName()
										+ "：" + metadata.getFiledName().replace("_", " ") + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.cartogram_n81i"));
					} else {
						result1.put("xtitle", dsi.getProcessIdenName() + " " + checkTypeInfo.getCheckTypeName() + "："
								+ metadata.getFiledName().replace("_", " ") + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.cartogram_n81i"));
					}
					result1.put("ytitle", metadata.getFiledName().replace("_", " "));
				}
				returnList.add(result1);
				// 预警线 public
				// part---------------------------end----------------------

				// 得到分类标识字段
				String sort_sign = "select  t.filed_name,t.filed_type  from metadata t where t.check_type_id =" + ctId
						+ " and t.sort_sign =0";
				List sortList = this.commonService.executeSQL(sort_sign);

				Object[] objs = null;
				List<Object[]> dataPoint = new ArrayList<Object[]>();

				if (sortList != null && sortList.size() > 0) {
					Object[] sortFiledType = (Object[]) sortList.get(0);
					Map<String, Object> result = new HashMap();
					List<Map<String, Object>> line = new ArrayList<Map<String, Object>>();
					// 选择checkBox画图
					if (lines != null && !lines.equals("")) {
						if (lines.endsWith(",")) {
							lines = lines.substring(0, lines.length() - 1);
						}
						String[] linStrings = lines.split(",");
						// 其实就是为了统一多条曲线时，曲线的起始时间点:先找到监测时间最新的端口，再找到这个端口的一天内的21条数据内的最小时间，其它端口的起始时间取自于这个最小时间
						String[] cbStrings = checkLins(metadata, checkTypeInfo, sortFiledType, dsiId, seqId, lines);// 选中端口的最新的监测时间的端口的，最远的监测时间

						String linesLink = linkToString(linStrings, ",", "'");// lines要在checkLins方法后再做加单引号的处理，因为checkLins方法里单个处理了
						// for (int i = 0; i < linStrings.length; i++) {
						String source = "";
						source = "select * from ( select data_check_time_digital ," + specialColumn + " from "
								+ checkTypeInfo.getTableName() + " t where " + metadata.getFiledName() + " is not null"
								+ " and t.detection_set_info_id=" + dsiId + " and t.seq_id = " + seqId + " ";

						if (null != startTime && !startTime.equals("") && null != endTime && !endTime.equals("")) {
							source += " and to_char(data_check_time,'yyyy-mm-dd')>= '" + startTime
									+ "' and to_char(data_check_time,'yyyy-mm-dd')<='" + endTime + "'";
						} else {
							source += " and t.data_check_time >= trunc(sysdate-1) ";
						}
						if (sortFiledType[1].toString().equals("NUMBER")
								|| sortFiledType[1].toString().equals("Number")) {
							source += " and " + sortFiledType[0] + " in( " + linesLink + ")";
						} else if (sortFiledType[1].toString().indexOf("VARCHAR2") != -1) {
							source += " and " + sortFiledType[0] + " in (" + linesLink + ")";
						}
						// -------------------
						// 判断是否有返回 如果有则加入查询条件 如果无 则不加；其实就是为了统一多条曲线时，曲线的起始时间点
						if (null != cbStrings[1] && !cbStrings[1].equals("")) {
							source += " and t.data_check_time >= to_date('" + cbStrings[1] + "','yyyy-mm-dd HH24:mi')";
						}
						if (specialFlag == 1 || specialFlag == 2) {
							source += " group by t.data_check_time_digital,t.data_64_flag ";
						} else if (specialFlag == 0) {
							source += " group by t.data_check_time_digital ";
						}
						/*
						 * source +=
						 * " order by data_check_time_digital desc) where rownum < 21 order by data_check_time_digital asc"
						 * ;
						 */
						source += " order by data_check_time_digital desc) tttt   ";

						// @2018年4月10日18:45:00 fang 修改rownum 适配 mysql
						if (Constant.IS_MYSQL) {
							source = source + " order by data_check_time_digital asc limit 20";
						} else {
							source += " where rownum < 21 order by data_check_time_digital asc";// 查询最近时间的21条数据
						}
						System.out.println("------NoFirstInSource--------sql:" + source);
						List lineSourceList = this.commonService.executeSQL(source);

						// 展示数据封装处理
						if (specialFlag == 1) { // 字节特殊数据 再次处理
							objs = commonService.bitSpeedSourceList(lineSourceList, dsi.getCheckGap() * 60 * 1000);

						} else if (specialFlag == 2) { // 包特殊数据 再次处理
							objs = commonService.pktSpeedSourceList(lineSourceList, dsi.getCheckGap() * 60 * 1000);

						} else { // 整理为数据格式

							if (lineSourceList.size() > 0) {
								for (int j = 0; j < lineSourceList.size(); j++) {
									Object[] row = (Object[]) lineSourceList.get(j);
									Object[] tmp = new Object[2];
									tmp[0] = ((BigDecimal) row[0]).longValue();
									if (row[1] instanceof BigDecimal) {
										tmp[1] = ((BigDecimal) row[1]).setScale(2, BigDecimal.ROUND_HALF_UP);
									} else {
										tmp[1] = row[1];
									}
									dataPoint.add(tmp);
								}
							}
						}
						this.getRequest().setAttribute("lineStr", lines);
						// 封装一条拆线
						Map<String, Object> specialchart1 = new HashMap();
						if (lines.length() > 80) {
							lines = lines.substring(0, lines.indexOf(",", 50)) + "...";
						}
						String avgStr = "";
						String pointStr = "";
						String charStr = "";
						if (lines.contains(",")) {// 多个端口
							avgStr = getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.avgStr_n81i");
							pointStr = getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.pointStr_n81i");
							charStr = getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.charStr_n81i");
						} else {
							avgStr = getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.avg_n81i");
							pointStr = getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.moment_n81i");
						}
						specialchart1.put("name", lines + avgStr);
						specialchart1.put("data", objs != null ? objs[0] : null);
						// 封装一条拆线
						Map<String, Object> specialchart2 = new HashMap();
						specialchart2.put("name", pointStr);
						specialchart2.put("data", objs != null ? objs[1] : null);
						// 封装一条拆线
						Map<String, Object> chart = new HashMap();
						// 封装一条折线--------------------------------------2013 1.23
						chart.put("name", lines + charStr);
						chart.put("data", dataPoint);
						line.add(specialchart1);
						line.add(specialchart2);
						line.add(chart);
						result.put("lines", line);
						// }
					} else {// 界面未选择多选框时，默认取第一个端口的曲线图
						// 封装一条拆线
						Map<String, Object> chart = new HashMap();
						// 得到数据表中所有该分类标识的值:对于交换机端口监测，即所有的端口名称
						String getAllSort = "select distinct " + sortFiledType[0].toString() + " from "
								+ checkTypeInfo.getTableName() + " where " + sortFiledType[0].toString()
								+ " is not null and seq_id=" + seqId + " and DETECTION_SET_INFO_ID="+dsiId+" order by " + sortFiledType[0].toString();
						dataList = this.commonService.executeSQL(getAllSort);
						if (dataList != null && dataList.size() > 0) {
							String source = "select * from (select data_check_time_digital," + specialColumn + " from "
									+ checkTypeInfo.getTableName() + " t where " + metadata.getFiledName()
									+ " is not null" + " and t.Detection_Set_Info_Id = " + dsiId + " and t.seq_id = "
									+ seqId;

							if (null != startTime && !startTime.equals("") && null != endTime && !endTime.equals("")) {
								source += " and to_char(data_check_time,'yyyy-mm-dd')>= '" + startTime
										+ "' and to_char(data_check_time,'yyyy-mm-dd')<='" + endTime + "'";
							} else {
								source += " and t.data_check_time >= trunc(sysdate-1) ";// 默认查询一天的数据
							}
							if (sortFiledType[1].toString().equals("NUMBER")
									|| sortFiledType[1].toString().equals("Number")) {
								source += " and " + sortFiledType[0] + " = " + dataList.get(0).toString();
							} else if (sortFiledType[1].toString().indexOf("VARCHAR2") != -1) {
								source += " and " + sortFiledType[0] + " = '" + dataList.get(0).toString() + "' ";
							}
							if (specialFlag == 1 || specialFlag == 2) {
								source += " group by t.data_check_time_digital,t.data_64_flag ";
							} else if (specialFlag == 0) {
								source += " group by t.data_check_time_digital ";
							}
							source += " order by data_check_time_digital desc) ";
							/*
							 * source +=
							 * " where rownum < 21 order by data_check_time_digital asc"
							 * ;//查询最近时间的21条数据
							 */
							// @2018年4月10日18:45:00 fang 修改rownum 适配 mysql
							if (Constant.IS_MYSQL) {
								source = source + " order by data_check_time_digital asc limit 20";
							} else {
								source += " where rownum < 21 order by data_check_time_digital asc";// 查询最近时间的21条数据
							}
							System.out.println("------source--------sql:" + source);
							List lineSourceList = this.commonService.executeSQL(source);

							// 展示数据封装处理
							if (specialFlag == 1) { // 字节特殊数据 再次处理
								objs = commonService.bitSpeedSourceList(lineSourceList, dsi.getCheckGap() * 60 * 1000);

							} else if (specialFlag == 2) { // 包特殊数据 再次处理
								objs = commonService.pktSpeedSourceList(lineSourceList, dsi.getCheckGap() * 60 * 1000);

							} else { // 整理为数据格式
								for (int j = 0; j < lineSourceList.size(); j++) {
									Object[] row = (Object[]) lineSourceList.get(j);
									Object[] tmp = new Object[2];
									tmp[0] = ((BigDecimal) row[0]).longValue();
									if (row[1] instanceof BigDecimal) {
										tmp[1] = ((BigDecimal) row[1]).setScale(2, BigDecimal.ROUND_HALF_UP);
									} else {
										tmp[1] = row[1];
									}
									dataPoint.add(tmp);
								}
							}
							this.getRequest().setAttribute("lineStr", dataList.get(0).toString());
							// 封装一条拆线
							Map<String, Object> specialchart1 = new HashMap();
							specialchart1.put("name", dataList.get(0).toString() + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.avg_n81i"));
							specialchart1.put("data", objs != null ? objs[0] : null);
							// 封装一条拆线
							Map<String, Object> specialchart2 = new HashMap();
							specialchart2.put("name", getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.moment_n81i"));
							specialchart2.put("data", objs != null ? objs[1] : null);
							// 封装一条折线--------------------------------------2013
							// 1.23
							chart.put("name", dataList.get(0).toString());
							chart.put("data", dataPoint);
							line.add(specialchart1);
							line.add(specialchart2);
							line.add(chart);
							result.put("lines", line);
						} else {
							// 封装一条折线--------------------------------------2013
							// 1.23
							chart.put("name", "");
							chart.put("data", "");
							line.add(chart);
							result.put("lines", line);
						}
					}

					returnList.add(result);
				}
				this.getRequest().setAttribute("specialFlag", specialFlag); // 0
																			// 非特殊字段，
																			// 1
																			// 特殊字段
			}

			String jsonStr = JSONArray.fromObject(returnList).toString();
			System.out.println(jsonStr);
			this.getResponse().setCharacterEncoding("utf-8");
			PrintWriter printWriter = this.getResponse().getWriter();
			printWriter.write(jsonStr);
			printWriter.close();
			printWriter = null;
		} catch (Exception e) {
			logger.error(e.getStackTrace(), e);
		}
		return null;
	}

	/**
	 * 将map中的key所对应的值用linkSymbol拼接,并在每个值的两边加mark，如'a','d','v'
	 * 
	 * @param strGroup
	 * @param linkSymbol
	 * @param mark:添加到每一个值两边的，如单引号
	 * @return
	 */
	private String linkToString(String[] strGroup, String linkSymbol, String mark) {

		StringBuffer str = new StringBuffer();
		String linkedStr = "";
		for (String strTmp : strGroup) {
			if (StringUtils.isNotBlank(strTmp)) {
				str.append(mark).append(strTmp).append(mark).append(linkSymbol);
			}
		}
		if (str.toString().contains(linkSymbol)) {
			linkedStr = str.substring(0, str.length() - linkSymbol.length());
		}

		System.out.println("连接后的字符串：" + linkedStr);
		return linkedStr;
	}

	public String getSource() {
		String mId = this.getRequest().getParameter("metaId");
		String dsiId = this.getRequest().getParameter("dId");
		String ctId = this.getRequest().getParameter("cId");
		String seqId = this.getRequest().getParameter("seqId");
		// System.out.println("mId:" + mId);
		// System.out.println("dsiId:" + dsiId);
		// System.out.println("ctId:" + ctId);
		// System.out.println("seqId:" + seqId);
		List sourceList = null;
		String driwSQL = "";
		String policeValSQL = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();
		NodeTable nt = null;
		try {

			CheckTypeInfo checkTypeInfo = (CheckTypeInfo) this.commonService.get(CheckTypeInfo.class,
					Long.parseLong(ctId));

			Metadata metadata = (Metadata) this.commonService.get(Metadata.class, Long.parseLong(mId));

			List<NodeTable> nts = this.commonService.find("from NodeTable where seqId=" + Long.parseLong(seqId));
			if (nts != null && nts.size() > 0) {
				nt = nts.get(0);
			}

			DetectionSetInfo dsi = (DetectionSetInfo) this.commonService.get(DetectionSetInfo.class,
					Long.parseLong(dsiId));

			Map<String, Object> result = new HashMap();
			List<Object[]> data = new ArrayList<Object[]>();
			List<Map<String, Object>> line = new ArrayList<Map<String, Object>>();
			// 封装一条拆线
			Map<String, Object> chart = new HashMap();
			List policeValue = null;
			// 预警值
			int policeVal = 0;

			driwSQL = "select to_char(data_check_time,'yyyy-mm-dd HH24:mi') ctime," + metadata.getFiledName() + " from "
					+ metadata.getTableName() + " t where " + metadata.getFiledName() + " is not null"
					// " and t.data_check_time >=
					// to_date(to_char((sysdate-4),'yyyy-mm-dd'),'yyyy-mm-dd
					// hh24:mi')"+
					// + " and t.data_check_time >= trunc(sysdate-30)"
					+ " and t.detection_info_id in "
					+ "(select d.id from detection_info d  where d.detection_set_info_id=" + dsiId + " and d.seq_id = "
					+ seqId + ")";
			// + " order by data_check_time";

			if (null != startTime && !startTime.equals("") && null != endTime && !endTime.equals("")) {
				driwSQL += " and to_char(data_check_time,'yyyy-mm-dd')>= '" + startTime
						+ "' and to_char(data_check_time,'yyyy-mm-dd')<='" + endTime + "'";
			} else {
				driwSQL += " and t.data_check_time >= trunc(sysdate-1) ";
			}

			driwSQL += " order by data_check_time";
			// System.out.println("driwSQL:" + driwSQL);
			sourceList = this.commonService.executeSQL(driwSQL);

			/* 2013-03-04 绘制展示图增加图断点判断 Edit by zg begin */
			long gapTime = dsi.getCheckGap(); // 单位： 分钟
			gapTime = gapTime * 60 * 1000; // 分钟 变毫秒
			long pointTime = 0;
			/* 2013-03-04 绘制展示图增加图断点判断 Edit by zg end */
			if (sourceList.size() > 0) {
				for (int i = 0; i < sourceList.size(); i++) {
					Object[] row = (Object[]) sourceList.get(i);
					Object[] tmp = new Object[2];
					/* 2013-03-04 绘制展示图增加图断点判断 Edit by zg begin */
					long rowTime = (sdf.parse((String) row[0])).getTime();
					if (pointTime == 0) {
						pointTime = rowTime;
					}

					if (pointTime + gapTime * 2 < rowTime) { // 即上一时间点数据到当前时间点数据时间间隔超过两个周期
																// 增加断
						Object[] tmp0 = new Object[] { pointTime + gapTime * 2, null };
						data.add(tmp0);
					}
					pointTime = rowTime;
					tmp[0] = rowTime;
					// tmp[0] = (sdf.parse((String) row[0])).getTime();
					/* 2013-03-04 绘制展示图增加图断点判断 Edit by zg end */

					// tmp[1] = ((BigDecimal) row[1]).intValue();
					if (row[1] instanceof BigDecimal) {
						tmp[1] = ((BigDecimal) row[1]).setScale(2, BigDecimal.ROUND_HALF_UP);
					} else {
						tmp[1] = row[1];

					}
					data.add(tmp);
				}
				// 封装一条折线
				chart.put("name", metadata.getFiledComments());
				chart.put("data", data);
				line.add(chart);

				// 预警线
				policeValSQL = "select police_value from data_police_relation where detection_set_info_id=" + dsiId
						+ " and metadata_id=" + metadata.getId();
				policeValue = this.commonService.executeSQL(policeValSQL);
				if (policeValue != null && policeValue.size() > 0) {
					// policeVal=((BigDecimal)policeValue.get(0)).intValue();
					policeVal = Integer.parseInt(policeValue.get(0).toString());
				}
				// 如果预警值不等于0则画预警线
				if (policeVal != 0) {
					result.put("policeVal", policeVal);
				}
				result.put("lines", line);
				if (metadata.getFiledComments() != null && !"".equals(metadata.getFiledComments())) {
					if (nt != null) {
						result.put("xtitle", nt.getNodeIp() + "_" + dsi.getProcessIdenName() + " "
								+ checkTypeInfo.getCheckTypeName1() + "：" + metadata.getFiledComments() + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.cartogram_n81i"));
					} else {
						result.put("xtitle", dsi.getProcessIdenName() + " " + checkTypeInfo.getCheckTypeName1() + "："
								+ metadata.getFiledComments() + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.cartogram_n81i"));
					}
					result.put("ytitle", metadata.getFiledComments());
				} else {
					if (nt != null) {
						result.put("xtitle",
								nt.getNodeIp() + "_" + dsi.getProcessIdenName() + " "
										+ checkTypeInfo.getCheckTypeName1() + "："
										+ metadata.getFiledName().replace("_", " ") + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.cartogram_n81i"));
					} else {
						result.put("xtitle", dsi.getProcessIdenName() + " " + checkTypeInfo.getCheckTypeName1() + "："
								+ metadata.getFiledName().replace("_", " ") + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.cartogram_n81i"));
					}
					result.put("ytitle", metadata.getFiledName().replace("_", " "));
				}
				returnList.add(result);

				String jsonStr = JSONArray.fromObject(returnList).toString();
				// System.out.println(jsonStr);
				this.getResponse().setCharacterEncoding("utf-8");
				PrintWriter printWriter = this.getResponse().getWriter();
				printWriter.write(jsonStr);
				printWriter.close();
				printWriter = null;
			}

		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			if (!StringUtil.isBlank(type) && type.equals("1")) {
				outHtmlString(
						"<script type=\"text/javascript\">alert('i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.faild_n81i');this.location='monitorData.do?action=queryAbnormalSet'</script>");
			} else {
				outHtmlString(
						"<script type=\"text/javascript\">alert('i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.faild_n81i');this.location='monitorData.do?action=query'</script>");
			}
		}
		return null;
	}

	public String getSnmpLineSource() {
		metaId = this.getRequest().getParameter("metaId");
		dsiId = this.getRequest().getParameter("dId");
		ctId = this.getRequest().getParameter("cId");
		sqId = this.getRequest().getParameter("seqId");
		drIndex = this.getRequest().getParameter("drIndex");
		try {
			CheckTypeInfo checkTypeInfo = (CheckTypeInfo) this.commonService.get(CheckTypeInfo.class,
					Long.parseLong(ctId));
			// 得到分类标识字段
			String sort_sign = "select  t.filed_name,t.filed_type  from metadata t where t.check_type_id =" + ctId
					+ " and t.sort_sign =0";
			List sortList = this.commonService.executeSQL(sort_sign);

			if (sortList != null && sortList.size() > 0) {

				Object[] sortFiledType = (Object[]) sortList.get(0);

				// 得到数据表中所有该分类标识的值
				String getAllSort = "select distinct " + sortFiledType[0].toString() + " from "
						+ checkTypeInfo.getTableName() + " where " + sortFiledType[0].toString() + " is not null ";
				// List sortValues = this.commonService.executeSQL(getAllSort);
				dataList = this.commonService.executeSQL(getAllSort);
				// for (int i = 0; i < dataList.size(); i++) {
				// Object[] obj = new
				// Object[]{dataList.get(i).toString(),dataList.get(i).toString()};
				// dataList.set(i, obj);
				// }
				// String jsonStr = JSONArray.fromObject(sortValues).toString();
				// System.out.println(jsonStr);
				// this.getResponse().setCharacterEncoding("utf-8");
				// PrintWriter printWriter = this.getResponse().getWriter();
				// printWriter.write(jsonStr);
				// printWriter.close();
				// printWriter = null;
			}

		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.faild_n81i');this.location='monitorData.do?action=query'</script>");
		}
		return "select_plug";

	}

	public String detailMonitorDataInfo() {
		String findFiledSql = "";
		String filedComm = "";
		List mapList = new ArrayList();
		String ctId = this.getRequest().getParameter("cId");// 监测类别Id
		try {
			if (ids != null && ids.length > 0) {
				// 根据id获得最新监控数据
				List list = this.commonService.find("from DetectionInfoNew where id=?", ids[0]);
				if (list != null && list.size() > 0) {
					detectionInfoNew = (DetectionInfoNew) list.get(0);
				}
				String tempDSInfo=truncateInfo(detectionInfoNew.getDetectionStateInfo());
				detectionInfoNew.setDetectionStateInfo(tempDSInfo);
				String tempPD=truncateInfo(detectionInfoNew.getPerformaceData());
				detectionInfoNew.setPerformaceData(tempPD);
				// 根据seq_id获得节点详细信息
				Long seqIdLong = detectionInfoNew.getSeqId();
				String ipSql = "select distinct nt.node_ip from node_table nt where nt.seq_id = " + seqIdLong;
				List ipList = this.commonService.executeSQL(ipSql);
				if (ipList != null && ipList.size() > 0) {
					nodeIp = ipList.get(0).toString();
				}

				List not = this.commonService.findByProperty(NodeTable.class, "seqId", seqIdLong);
				if (not != null && not.size() > 0) {
					nodeTable = (NodeTable) not.get(0);
				}
				// 根据监测类别，获得当前类别的独有的监测项
				CheckTypeInfo cti = (CheckTypeInfo) this.commonService.get(CheckTypeInfo.class,
						detectionInfoNew.getDetectionSetInfo().getCheckTypeInfo().getId());
				List<Metadata> mList = this.commonService.find("from Metadata where checkTypeInfo.id=? and state =0",
						cti.getId());
				String sql = "";
				Map<String, MetadataDictionaryVO> mapDictionaryMap = new HashMap<String, MetadataDictionaryVO>();
				if (mList != null && mList.size() > 0) {
					for (int j = 0; j < mList.size(); j++) {
						Metadata metadata = (Metadata) mList.get(j);
						if (metadata.getTypeId() != null) {
							sql = "select * from option_table t where t.TYPE_IDENTITY = (select mt.type_id from metadata mt where mt.id="
									+ metadata.getId() + ")";
							List<OptionTable> optionList = this.commonService.executeSQL(sql, OptionTable.class);
							MetadataDictionaryVO mdv = new MetadataDictionaryVO();
							mdv.setListOT(optionList);
							mdv.setmId(metadata.getId());
							mdv.setFiledComments(metadata.getFiledComments());
							mapDictionaryMap.put(metadata.getFiledComments(), mdv);
						}

						if (j != mList.size() - 1) {
							findFiledSql += metadata.getFiledName() + ",";
							if (metadata.getFiledComments() != null && !"".equals(metadata.getFiledComments())) {
								filedComm += metadata.getFiledComments() + ",";
							} else {
								filedComm += metadata.getFiledName() + ",";
							}
						} else {
							findFiledSql += metadata.getFiledName();
							if (metadata.getFiledComments() != null && !"".equals(metadata.getFiledComments())) {
								filedComm += metadata.getFiledComments();
							} else {
								filedComm += metadata.getFiledName();
							}
						}
					}
					if (StringUtils.isNotBlank(findFiledSql)) {
						Metadata md = new Metadata();
						md.setFiledComments(getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.state_n81i"));
						mList.add(md);
						findFiledSql += ",decode(detectioned_state,1,'"+getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.normal_n81i")+"',0,'"+getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.exception_n81i")+"',-1,'"+getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.doFaild_n81i")+"','') detectioned_state";
					}
					if (StringUtils.isNotBlank(filedComm)) {
						filedComm += ","+getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.state_n81i");
					}
				}

				// --------2013-4-12 hyx------start
				// 由于每个详细监测信息表添加了ID字段，且一个detection_info_id对应多条记录，所以可以直接从detection_info_new表获取detection_info表对应的id，修改如下
				// 获得监测类别、监测对象唯一标识、监测数据获取时间
				// Long detectionSetInfoId = detectionInfoNew
				// .getDetectionSetInfo().getId();
				// Long seqId = detectionInfoNew.getSeqId();
				// Date checkTime = detectionInfoNew.getDatacheckTime();
				// String checkTimeStr = new SimpleDateFormat(
				// "yyyy-MM-dd HH:mm:ss").format(checkTime);// 日期转换为字符串

				// 根据获得的监测类别、监测对象唯一标识、监测数据获取时间，在detection_info表中找出所有记录（可能为一条或多条）的id---sql语句
				// String detectionInfoIds = "select ID from DETECTION_INFO
				// where
				// DETECTION_SET_INFO_ID="
				// + detectionSetInfoId
				// + " and SEQ_ID="
				// + seqId
				// + " and DATA_CHECK_TIME=to_date('"
				// + checkTimeStr
				// + "','yyyy-MM-dd HH24:mi:ss')";

				Long detectionInfoId = detectionInfoNew.getDetectionInfoId();
				String detectionInfoIds = detectionInfoId == null ? "" : detectionInfoId.toString();
				// --------2013-4-12 hyx------end

				// 从当前监测类别对应的表中取出自己独有的信息
				String tableName = cti.getTableName();
				// 判断数据表是否存在
				/*
				 * String sql2 =
				 * "SELECT COUNT(*) from user_tables where table_name = '" +
				 * tableName.trim().toUpperCase() + "'"; List list2 =
				 * this.commonService.executeSQL(sql2); int num2 =
				 * Integer.parseInt(list2.get(0).toString());
				 */
				// @2018-3-8 11:22:10 mysql适配
				int num2 = this.commonService.isTableExist(tableName);
				if (num2 == 0) {
					outHtmlString(
							"<script type=\"text/javascript\">alert('i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.noTable_n81i');this.location='monitorData.do?action=query'</script>");
					return null;
				}

				String serchSql = "select " + findFiledSql + " from " + tableName + " t where t.detection_info_id  in ("
						+ detectionInfoIds + ") order by t.detection_info_id desc";
				// List listInfo=this.commonService.executeSQL(serchSql);
				System.out.println(serchSql);
				/*
				 * pageSub = this.commonService.findByPageForSql(serchSql,
				 * pageNoSub, pageSizeSub, null);
				 */
				List listInfo = this.commonService.executeSQL(serchSql);
				String[] filedCommArr = filedComm.split(",");
				// this.getRequest().setAttribute("titleList", filedCommArr);
				this.getRequest().setAttribute("titleList", mList);

				if (listInfo != null && listInfo.size() > 0) {
					for (int i = 0; i < listInfo.size(); i++) {
						Object[] resu = (Object[]) listInfo.get(i);
						if (resu != null && filedCommArr != null && resu.length >= filedCommArr.length) {
							Map mapTemp = new LinkedHashMap();
							for (int k = 0; k < filedCommArr.length; k++) {
								mapTemp.put(filedCommArr[k], resu[k]);
							}
							// for (int k = 0; k < mList.size(); k++) {
							// if(mapDictionaryMap.containsKey(mList.get(k).getId())){//如果包含meta
							// List<OptionTable> lOp =
							// mapDictionaryMap.get(mList.get(k).getId()).getListOT();
							// for(int o =0;o<lOp.size();o++){
							// if(lOp.get(o).getTypeCode().equals(resu[k])){//如果typeCode等于resu[k],则将resu[k]变成typeValue
							// resu[k]= lOp.get(o).getTypeValue();
							// }else{
							// continue;
							// }
							// }
							// }
							// mapTemp.put(filedCommArr[k], resu[k]);
							// }
							mapList.add(mapTemp);
						}
					}
				}

				// 将取出的监测信息和告警值进行比较，看是否为告警信息
				List policeList = this.commonService.find("from DataPoliceRelation where detectionSetInfo.id=?",
						detectionInfoNew.getDetectionSetInfo().getId());
				if (policeList != null && policeList.size() > 0) {
					for (int j = 0; j < policeList.size(); j++) {
						DataPoliceRelation dpr = (DataPoliceRelation) policeList.get(j);
						String keyString = "";
						if (dpr.getMetadata().getFiledComments() != null
								&& !"".equals(dpr.getMetadata().getFiledComments())) {
							keyString = dpr.getMetadata().getFiledComments().toUpperCase();
						} else {
							keyString = dpr.getMetadata().getFiledName().toUpperCase();
						}
						String filedType = dpr.getMetadata().getFiledType();
						if(filedType == null || !"NUMBER".equalsIgnoreCase(filedType) || keyString == null){
							continue;
						}
						for (int k = 0; k < mapList.size(); k++) {
							Map map = (LinkedHashMap) mapList.get(k);
							if (map.containsKey(keyString)) {
								Float num = new Float(0.0);
								try {
									Object key = map.get(keyString);
									String value = dpr.getPoliceValue();
									//System.out.println(key+" -- > " + value);
									num = Float.parseFloat(key.toString())- Float.parseFloat(value);
								} catch (Exception e) {
									logger.error("", e);
								}

								if (num > 0) {
									map.put(keyString, map.get(keyString)
											+ "&nbsp&nbsp&nbsp&nbsp<font color='#FF0000'>i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.outWarning_n81i" + num + "</font>");
								}
							}
							mapList.set(k, map);// ?????????????
						}
					}
				}
				this.getRequest().setAttribute("checkId", ctId);
				this.getRequest().setAttribute("infoMapList", mapList);
				this.getRequest().setAttribute("dictionMap", mapDictionaryMap);

				// 判断监测类别是否为系统基础信息
				if (ctId.equals("0")) {
					String didString = detectionInfoNew.getDetectionInfoId().toString();
					DiSysteminfo dsinfo = commonService.findSysteminfo(didString);
					List<DiSysteminfoDisk> dsiDiskList = commonService.findSysteminfoDisk(didString);
					List<DiSysteminfoNet> dsiNetList = commonService.findSysteminfoNet(didString);
					this.getRequest().setAttribute("dsinfo", dsinfo);
					this.getRequest().setAttribute("dsiDiskList", dsiDiskList);
					this.getRequest().setAttribute("dsiNetList", dsiNetList);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.faild_n81i');this.location='monitorData.do?action=query'</script>");
		}

		return "detailMonitorDataInfo";
	}

	private String truncateInfo(String truncateStr) {
		if(!StringUtil.isBlank(truncateStr)){
			int i18nIndex = truncateStr.lastIndexOf("i18n");
			int n81iIndex = truncateStr.lastIndexOf("n81i");
			if(n81iIndex<i18nIndex){
				return truncateStr.substring(0, i18nIndex);
			}
		}
		
		return truncateStr;
	}

	/**
	 * 
	 * 检测设置历史记录的详细信息
	 * 
	 * @author jinshujuan Jun 18, 2013
	 * @version 1.0
	 * @return
	 */
	private String detailWarning() {

		String findFiledSql = "";
		String filedComm = "";
		List mapList = new ArrayList();
		String ctId = this.getRequest().getParameter("cId");// 监测类别Id
		try {
			if (ids != null && ids.length > 0) {
				// 根据id获得最新监控数据
				List list = this.commonService.find("from DetectionInfoWarning where id=?", ids[0]);
				if (list != null && list.size() > 0) {
					detectionInfoWarning = (DetectionInfoWarning) list.get(0);
				}

				// 根据seq_id获得节点详细信息
				Long seqIdLong = detectionInfoWarning.getSeqId();
				String ipSql = "select distinct nt.node_ip from node_table nt where nt.seq_id = " + seqIdLong;
				List ipList = this.commonService.executeSQL(ipSql);
				if (ipList != null && ipList.size() > 0) {
					nodeIp = ipList.get(0).toString();
				}

				List not = this.commonService.findByProperty(NodeTable.class, "seqId", seqIdLong);
				if (not != null && not.size() > 0) {
					nodeTable = (NodeTable) not.get(0);
				}
				// 根据监测类别，获得当前类别的独有的监测项
				CheckTypeInfo cti = (CheckTypeInfo) this.commonService.get(CheckTypeInfo.class,
						detectionInfoWarning.getDetectionSetInfo().getCheckTypeInfo().getId());
				List<Metadata> mList = this.commonService.find("from Metadata where checkTypeInfo.id=? and state =0",
						cti.getId());
				String sql = "";
				Map<String, MetadataDictionaryVO> mapDictionaryMap = new HashMap<String, MetadataDictionaryVO>();
				if (mList != null && mList.size() > 0) {
					for (int j = 0; j < mList.size(); j++) {
						Metadata metadata = (Metadata) mList.get(j);
						if (metadata.getTypeId() != null) {
							sql = "select * from option_table t where t.TYPE_IDENTITY = (select mt.type_id from metadata mt where mt.id="
									+ metadata.getId() + ")";
							List<OptionTable> optionList = this.commonService.executeSQL(sql, OptionTable.class);
							MetadataDictionaryVO mdv = new MetadataDictionaryVO();
							mdv.setListOT(optionList);
							mdv.setmId(metadata.getId());
							mdv.setFiledComments(metadata.getFiledComments());
							mapDictionaryMap.put(metadata.getFiledComments(), mdv);
						}

						if (j != mList.size() - 1) {
							findFiledSql += metadata.getFiledName() + ",";
							if (metadata.getFiledComments() != null && !"".equals(metadata.getFiledComments())) {
								filedComm += metadata.getFiledComments() + ",";
							} else {
								filedComm += metadata.getFiledName() + ",";
							}
						} else {
							findFiledSql += metadata.getFiledName();
							if (metadata.getFiledComments() != null && !"".equals(metadata.getFiledComments())) {
								filedComm += metadata.getFiledComments();
							} else {
								filedComm += metadata.getFiledName();
							}
						}
					}
					if (StringUtils.isNotBlank(findFiledSql)) {
						Metadata md = new Metadata();
						md.setFiledComments(getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.state_n81i"));
						mList.add(md);
						findFiledSql += ",decode(detectioned_state,1,'"+getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.normal_n81i")+"',0,'"+getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.exception_n81i")+"',-1,'"+getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.doFaild_n81i")+"','') detectioned_state";
					}
					if (StringUtils.isNotBlank(filedComm)) {
						filedComm += ","+getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.title.state_n81i");
					}
				}
				this.getRequest().setAttribute("titleList", mList);
				// --------2013-4-12 hyx------start
				// 由于每个详细监测信息表添加了ID字段，且一个detection_info_id对应多条记录，所以可以直接从detection_info_new表获取detection_info表对应的id，修改如下
				// 获得监测类别、监测对象唯一标识、监测数据获取时间

				Long detectionInfoId = detectionInfoWarning.getDetectionInfoId();
				String detectionInfoIds = detectionInfoId == null ? "" : detectionInfoId.toString();
				// --------2013-4-12 hyx------end
				if (!StringUtil.isBlank(detectionInfoIds)) {
					// 从当前监测类别对应的表中取出自己独有的信息
					String tableName = cti.getTableName();
					// 判断数据表是否存在
					/*
					 * String sql2 =
					 * "SELECT COUNT(*) from user_tables where table_name = '" +
					 * tableName.trim().toUpperCase() + "'"; List list2 =
					 * this.commonService.executeSQL(sql2); int num2 =
					 * Integer.parseInt(list2.get(0).toString());
					 */
					// @2018-3-8 11:22:10 mysql适配
					int num2 = this.commonService.isTableExist(tableName);
					if (num2 == 0) {
						outHtmlString(
								"<script type=\"text/javascript\">alert('i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.noTable_n81i');this.location='monitorData.do?action=showDetectionInfo'</script>");
						return null;
					}

					String serchSql = "select " + findFiledSql + " from " + tableName
							+ " t where t.detection_info_id  in (" + detectionInfoIds
							+ ") order by t.detection_info_id desc";
					System.out.println(serchSql);
					pageSub = this.commonService.findByPageForSql(serchSql, pageNoSub, pageSizeSub, null);
					List listInfo = (List<Object[]>) pageSub.getResult();
					String[] filedCommArr = filedComm.split(",");

					if (listInfo != null && listInfo.size() > 0) {
						for (int i = 0; i < listInfo.size(); i++) {
							Object[] resu = (Object[]) listInfo.get(i);
							if (resu != null && filedCommArr != null && resu.length >= filedCommArr.length) {
								Map mapTemp = new LinkedHashMap();
								for (int k = 0; k < filedCommArr.length; k++) {
									mapTemp.put(filedCommArr[k], resu[k]);
								}
								mapList.add(mapTemp);
							}
						}
					}

				}

				// 将取出的监测信息和告警值进行比较，看是否为告警信息
				List policeList = this.commonService.find("from DataPoliceRelation where detectionSetInfo.id=?",
						detectionInfoWarning.getDetectionSetInfo().getId());
				if (policeList != null && policeList.size() > 0) {
					for (int j = 0; j < policeList.size(); j++) {
						DataPoliceRelation dpr = (DataPoliceRelation) policeList.get(j);
						String keyString = "";
						if (dpr.getMetadata().getFiledComments() != null
								&& !"".equals(dpr.getMetadata().getFiledComments())) {
							keyString = dpr.getMetadata().getFiledComments().toUpperCase();
						} else {
							keyString = dpr.getMetadata().getFiledName().toUpperCase();
						}
						for (int k = 0; k < mapList.size(); k++) {
							Map map = (LinkedHashMap) mapList.get(k);
							if (map.containsKey(keyString)) {
								Float num = Float.parseFloat(map.get(keyString).toString())
										- Float.parseFloat(String.valueOf(dpr.getPoliceValue()));
								if (num > 0) {
									map.put(keyString, map.get(keyString)
											+ "&nbsp&nbsp&nbsp&nbsp<font color='#FF0000'>i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.outWarning_n81i" + num + "</font>");
								}
							}
							mapList.set(k, map);// ?????????????
						}
					}
				}
				this.getRequest().setAttribute("checkId", ctId);
				this.getRequest().setAttribute("infoMapList", mapList);
				this.getRequest().setAttribute("dictionMap", mapDictionaryMap);

				// 判断监测类别是否为系统基础信息
				if (ctId.equals("0")) {
					String didString = detectionInfoWarning.getDetectionInfoId().toString();
					DiSysteminfo dsinfo = commonService.findSysteminfo(didString);
					List<DiSysteminfoDisk> dsiDiskList = commonService.findSysteminfoDisk(didString);
					List<DiSysteminfoNet> dsiNetList = commonService.findSysteminfoNet(didString);
					this.getRequest().setAttribute("dsinfo", dsinfo);
					this.getRequest().setAttribute("dsiDiskList", dsiDiskList);
					this.getRequest().setAttribute("dsiNetList", dsiNetList);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.faild_n81i');this.location='monitorData.do?action=showDetectionInfo'</script>");
		}

		return "detailWarning";
	}

	public List<List> getNodeIpGroupList() throws Exception {
		List<List> detecInfoGroupList = new ArrayList<List>();
		String nip1 = "";
		String nip2 = "";
		for (int i = 0; i < detectionInfoNewList.size(); i++) {
			List<DetectionInfoNew> listSoNews = new ArrayList<DetectionInfoNew>();
			for (int j = i; j < detectionInfoNewList.size(); j++) {
				nip1 = detectionInfoNewList.get(i).getNodeIp();
				nip2 = detectionInfoNewList.get(j).getNodeIp();
				if (nip1 == null)
					nip1 = "";
				if (nip2 == null)
					nip2 = "";
				if (nip1.equals(nip2)) {
					listSoNews.add(detectionInfoNewList.get(j));
					i = j;
				} else {
					i = j - 1;
					break;
				}
			}
			detecInfoGroupList.add(listSoNews);
		}

		return detecInfoGroupList;
	}

	public List<List> vgetNodeIpGroupList(List<VDetectionInfoNew> vdetectionInfoNewList) throws Exception {
		List<List> vdetecInfoGroupList = new ArrayList<List>();
		String nip1 = "";
		String nip2 = "";
		if (vdetectionInfoNewList != null && vdetectionInfoNewList.size() > 0) {
			for (int i = 0; i < vdetectionInfoNewList.size(); i++) {
				List<VDetectionInfoNew> listSoNews = new ArrayList<VDetectionInfoNew>();
				for (int j = i; j < vdetectionInfoNewList.size(); j++) {
					vdetectionInfoNewList.get(j)
							.setPersistTime(this.getPersistTime(vdetectionInfoNewList.get(j).getDatacheckTime(),
									vdetectionInfoNewList.get(j).getStartTime()));
					nip1 = vdetectionInfoNewList.get(i).getNodeIp();
					nip2 = vdetectionInfoNewList.get(j).getNodeIp();
					if (nip1 == null)
						nip1 = "";
					if (nip2 == null)
						nip2 = "";
					if (nip1.equals(nip2)) {
						listSoNews.add(vdetectionInfoNewList.get(j));
						i = j;
					} else {
						i = j - 1;
						break;
					}
				}
				vdetecInfoGroupList.add(listSoNews);
			}
		}

		return vdetecInfoGroupList;
	}

	/**
	 * 
	 * @author jinshujuan May 30, 2013
	 * @version 1.0
	 * @param detectionInfoList
	 * @param flag
	 *            true 代表获取最新检测数据，在数据多一列最新判断，index 都需要+1
	 * @return
	 * @throws Exception
	 */
	public List<List> getNodeIpGroupListNew(List<Object[]> detectionInfoList, boolean flag) throws Exception {
		// List<Object[]>
		// sqlBuffer.append(" select
		// din.id,nt.node_ip,cti.check_type_name,dsi.PROCESS_IDEN,din.detectioned_state");
		// sqlBuffer.append("'',din.data_check_time,din.current_times,din.detection_state_info,din.start_time");
		int index1 = 1;// ip
		int index2 = 2;// check_type_name
		int index4 = 4;// detectioned_state
		int index5 = 5;
		int index6 = 6;
		int index9 = 9;
		if (flag) {
			index1++;
			index2++;
			index4++;
			index5++;
			index6++;
			index9++;
		}
		List<List> detecInfoGroupListNew = new ArrayList<List>();
		String nip1 = "";
		String nip2 = "";
		if (detectionInfoList != null && detectionInfoList.size() > 0) {
			for (int i = 0; i < detectionInfoList.size(); i++) {
				List<Object[]> listSoNews = new ArrayList<Object[]>();
				for (int j = i; j < detectionInfoList.size(); j++) {
					if (detectionInfoList.get(j)[index5] != null && detectionInfoList.get(j)[index9] != null) {
						detectionInfoList.get(j)[index6] = this.getPersistTime(
								DateUtil.getDateD(detectionInfoList.get(j)[index5].toString()),
								DateUtil.getDateD(detectionInfoList.get(j)[index9].toString()));
					}
					if (detectionInfoList.get(i)[index1] != null) {
						nip1 = detectionInfoList.get(i)[index1].toString();
					}
					if (detectionInfoList.get(j)[index1] != null) {
						nip2 = detectionInfoList.get(j)[index1].toString();
					}
					if (nip1 == null)
						nip1 = "";
					if (nip2 == null)
						nip2 = "";
					if (nip1.equals(nip2)) {
						if (detectionInfoList.get(j)[index2] != null
								&& detectionInfoList.get(j)[index2].toString().equals(getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.shakehands_n81i"))) {
							listSoNews.add(0, detectionInfoList.get(j));
						} else {
							listSoNews.add(detectionInfoList.get(j));
						}

						i = j;
					} else {
						i = j - 1;
						break;
					}
				}

				// ------20130618---hyx---由于分页导致监测状态显示有误
				if (listSoNews.size() > 0) {// 因为order by ctiId1
											// ASC，且握手的citId1为-1，所以如果有握手的话，会排在第0个
					Object[] objs = listSoNews.get(0);
					String ip = objs[index1] == null ? "" : objs[index1].toString();
					String nmsClientStr = objs[index2] == null ? "" : objs[index2].toString();
					String state = "";
					int initK = 1;// 默认第一个为握手监测，其它监测从1开始取
					if (!"i18n_check_type_info.NMSClient.CHECK_TYPE_NAME1_n81i".equals(nmsClientStr) && StringUtils.isNotBlank(ip)) {// 如果ip没有握手监测，则从数据库中进行查询
						String sql = "select din.detectioned_state" + " from DETECTION_INFO_NEW din  "
								+ " left join DETECTION_SET_INFO dsi on din.detection_set_info_id = dsi.id"
								+ " left join check_type_info cti on dsi.check_type_id = cti.id"
								+ " where  lower(cti.check_type_name)='nmsclient'"
								+ " and din.seq_id = (select distinct seq_id from node_table where node_ip='" + ip
								+ "') " + " and dsi.DETECTION_SET_STATE=1"
								+ " and (dsi.system_id=-1 or dsi.view_level=4 or (node_groups_id is null and node_ips_id is null))"
								+ // 此行条件目的就是找到全局的握手监测：握手监测只允许有一个监测设置（全局的）,admin新建的，或者查看权限为全局
								" order by dsi.id asc";
						List stateList = this.commonService.executeSQL(sql);
						if (stateList != null && stateList.size() > 0) {
							state = stateList.get(0).toString();// 查询握手监测的状态-----------?和直接在数据库查询得到的值不同---使用的数据库不同，呵呵
						}
						initK = 1;
					} else {
						state = objs[index4] == null ? "" : objs[index4].toString();
					}
					if (!"1".equals(state)) {// 握手监测异常，则其它监测的state为空
						for (int k = initK; k < listSoNews.size(); k++) {
							Object[] tmpObj = listSoNews.get(k);
							tmpObj[index4] = "";// 清空state后，jsp页面不显示状态图标
						}
					}
				}
				// ------20130618---hyx---由于分页导致监测状态显示有误
				detecInfoGroupListNew.add(listSoNews);
			}

		}

		return detecInfoGroupListNew;
	}

	public int getCheckTypeNum() throws Exception {
		String sql = "select count(*) from check_type_info";
		List l = this.commonService.executeSQL(sql);
		return Integer.parseInt(l.get(0).toString());
	}

	// 得到持续时间
	public String getPersistTime(Date datacheckTime, Date startTime) throws Exception {
		StringBuffer dateStr = new StringBuffer();
		if (datacheckTime != null && startTime != null) {
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			datacheckTime = simpleDateFormat.parse(simpleDateFormat.format(datacheckTime));
			startTime = simpleDateFormat.parse(simpleDateFormat.format(startTime));

			if (datacheckTime.getTime() - startTime.getTime() > 0) {
				long l = datacheckTime.getTime() - startTime.getTime();
				long day = l / (24 * 60 * 60 * 1000);
				long hour = (l / (60 * 60 * 1000) - day * 24);
				long min = ((l / (60 * 1000)) - day * 24 * 60 - hour * 60);
				long s = (l / 1000 - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60);

				if (day != 0) {
					dateStr.append(day+ " " + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.day_n81i")+ " ");
				}
				if (hour != 0) {
					dateStr.append(hour+ " " + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.hour_n81i")+ " ");
				}
				if (min != 0) {
					dateStr.append(min+ " " + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.minute_n81i")+ " ");
				}
				if (s != 0) {
					dateStr.append(s + " "+ getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.second_n81i")+ " ");
				}
			}
		}
		return dateStr.toString();
	}

	// 得到持续时间
	public void getPersistTime() throws Exception {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date datacheckTime = null;
		Date startTime = null;

		for (int i = 0; i < detectionInfoNewList.size(); i++) {
			StringBuffer dateStr = new StringBuffer();
			if (detectionInfoNewList.get(i).getDatacheckTime() != null
					&& detectionInfoNewList.get(i).getStatusChangeTime() != null) {
				datacheckTime = simpleDateFormat
						.parse(simpleDateFormat.format(detectionInfoNewList.get(i).getDatacheckTime()));
				startTime = simpleDateFormat
						.parse(simpleDateFormat.format(detectionInfoNewList.get(i).getStatusChangeTime()));

				if (datacheckTime.getTime() - startTime.getTime() > 0) {
					long l = datacheckTime.getTime() - startTime.getTime();
					long day = l / (24 * 60 * 60 * 1000);
					long hour = (l / (60 * 60 * 1000) - day * 24);
					long min = ((l / (60 * 1000)) - day * 24 * 60 - hour * 60);
					long s = (l / 1000 - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60);

					if (day != 0) {
						dateStr.append(day+ " " + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.day_n81i")+ " ");
					}
					if (hour != 0) {
						dateStr.append(hour+ " " + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.hour_n81i")+ " ");
					}
					if (min != 0) {
						dateStr.append(min+ " " + getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.minute_n81i")+ " ");
					}
					if (s != 0) {
						dateStr.append(s + " "+ getI18nText("i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.second_n81i")+ " ");
					}
				}
			} else {
				dateStr.append("");
			}
			detectionInfoNewList.get(i).setPersistTime(dateStr.toString());
		}

	}

	/**
	 * 
	 * 获取异常设备监测信息
	 * 
	 * @author jinshujuan May 13, 2013
	 * @version 1.0
	 * @return
	 */
	private String queryAbnormalSet() {

		try {
			/*StringBuffer sqlBuffer = new StringBuffer();
			sqlBuffer.append(" select * from   (select row_number() over (PARTITION BY newTable.ip,newTable.iden order by newTable.dctime desc, newTable.ip) LEV, newTable.* FROM (");
			sqlBuffer.append(" select distinct  din.id,nt.node_ip ip,cti.check_type_name1,dsi.PROCESS_IDEN_NAME iden,din.detectioned_state");
			sqlBuffer.append(",to_char(din.data_check_time,'yyyy-MM-dd HH24:mi:Ss') dctime,'',din.current_times,din.detection_state_info,to_char(din.status_change_time,'yyyy-MM-dd HH24:mi:Ss')");
			sqlBuffer.append(",dsi.id dsiiId,cti.id ctiId,din.seq_id sqId,nt.node_system_type nodeSysType,nvl(checkTypeCharState.charStateNum,0) charStateNum,nt.node_type nodeType,nt.ipn ipn, din.police_level police_level,decode(cti.check_type_name,'NMSClient',-1,cti.id) ctiId1");
			sqlBuffer.append(" from DETECTION_INFO_NEW din");
			sqlBuffer.append(" left join DETECTION_SET_INFO dsi");
			sqlBuffer.append(" on din.detection_set_info_id = dsi.id");
			sqlBuffer.append(" left join check_type_info cti");
			sqlBuffer.append(" on dsi.check_type_id = cti.id");
			sqlBuffer.append(" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id,ipn from  NODE_TABLE) nt");
			sqlBuffer.append(" on din.seq_id = nt.seq_id");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------start
			sqlBuffer.append(" left join ");
			sqlBuffer.append("  (select md.check_type_id as ctId,count(*) as charStateNum  from metadata md  where md.chart_state=0  group by md.check_type_id) checkTypeCharState ");
			sqlBuffer.append(" on checkTypeCharState.ctId=cti.id ");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------end

			// sqlBuffer.append("");
			// 99表示告警恢复，但是有的告警，没有设置告警级别，默认就会是99，但是监测状态异常，此时要显示：police_level!=99
			// or police_level=99 and detectioned_state!=1
			sqlBuffer.append(" where (police_level!=99 or police_level=99 and detectioned_state!=1) and nt.node_ip is not null AND nt.node_type =1 and nt.node_state = 0 and dsi.detection_set_state ='1'  and cti.crete_state=0  and din.valid=1 AND din.detectioned_state in('0','-1') ");// 只显示有效的数据：din.valid=1
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and nt.system_id = ");
				sqlBuffer.append(this.getSystemID());
			}
			// sqlBuffer.append("");
			// sqlBuffer.append(" ");
			if (cip != null && !"".equals(cip) && !"null".equals(cip)) {
				sqlBuffer.append(" and nt.node_ip = '" + cip + "'");
				// sqlBuffer.append(" and instr(nt.node_ip,'"+cip.trim()+"')
				// <> 0");
			}
			if (ctn != null && !"".equals(ctn)) {
				sqlBuffer.append(" and cti.id =" + ctn);
			}
			if (!this.getAdminMark()) {
				// 权限控制------begin
				// String sqlparam = " or (cti.view_level=4 )";
				// -------------end
				sqlBuffer.append(" and (((( cti.view_level=1 and cti.user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or ( cti.view_level=2 and cti.group_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or cti.view_level=3 ) and cti.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (cti.view_level=4 )");
				sqlBuffer.append(") ");
				sqlBuffer.append("and (((( dsi.view_level=1 and dsi.create_user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or ( dsi.view_level=2 and dsi.create_usergroup_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or dsi.view_level=3 ) and dsi.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (dsi.view_level=4 )");
				sqlBuffer.append(") and dsi.detection_set_state=1 and cti.crete_state=0  ");
			}
			sqlBuffer.append(" order by police_level ASC, ipn ASC,ctiId1 ASC, dsi.id ASC");
			sqlBuffer.append(" ) newTable ) WHERE LEV =1");
			System.out.println("sqlBuffer:" + sqlBuffer.toString());
*/
			
			StringBuffer sqlBuffer = new StringBuffer();
			sqlBuffer.append(" select distinct 1 LEV, din.id,nt.node_ip ip,cti.check_type_name1,dsi.PROCESS_IDEN_NAME iden,din.detectioned_state");
			sqlBuffer.append(",to_char(din.data_check_time,'yyyy-MM-dd HH24:mi:Ss') dctime,'',din.current_times,din.detection_state_info,to_char(din.status_change_time,'yyyy-MM-dd HH24:mi:Ss')");
			sqlBuffer.append(",dsi.id dsiiId,cti.id ctiId,din.seq_id sqId,nt.node_system_type nodeSysType,nvl(checkTypeCharState.charStateNum,0) charStateNum,nt.node_type nodeType,nt.ipn ipn, din.police_level police_level,decode(cti.check_type_name,'NMSClient',-1,cti.id) ctiId1");
			sqlBuffer.append(" from (select seq_id,detection_set_info_id,max(data_check_time) data_check_time from DETECTION_INFO_NEW d where d.valid = 1 group by seq_id,detection_set_info_id) dmax ");
			sqlBuffer.append(" left join DETECTION_INFO_NEW din on din.seq_id = dmax.seq_id and din.detection_set_info_id = dmax.detection_set_info_id and din. data_check_time = dmax.data_check_time ");
			sqlBuffer.append(" left join DETECTION_SET_INFO dsi");
			sqlBuffer.append(" on din.detection_set_info_id = dsi.id");
			sqlBuffer.append(" left join check_type_info cti");
			sqlBuffer.append(" on dsi.check_type_id = cti.id");
			sqlBuffer.append(" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id,ipn from  NODE_TABLE) nt");
			sqlBuffer.append(" on din.seq_id = nt.seq_id");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------start
			sqlBuffer.append(" left join ");
			sqlBuffer.append("  (select md.check_type_id as ctId,count(*) as charStateNum  from metadata md  where md.chart_state=0  group by md.check_type_id) checkTypeCharState ");
			sqlBuffer.append(" on checkTypeCharState.ctId=cti.id ");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------end

			// sqlBuffer.append("");
			// 99表示告警恢复，但是有的告警，没有设置告警级别，默认就会是99，但是监测状态异常，此时要显示：police_level!=99
			// or police_level=99 and detectioned_state!=1
			sqlBuffer.append(" where (police_level!=99 or police_level=99 and detectioned_state!=1) and nt.node_ip is not null AND nt.node_type =1 and nt.node_state = 0 and dsi.detection_set_state ='1'  and cti.crete_state=0  and din.valid=1 AND din.detectioned_state in('0','-1') ");// 只显示有效的数据：din.valid=1
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and nt.system_id = ");
				sqlBuffer.append(this.getSystemID());
			}
			if (cip != null && !"".equals(cip) && !"null".equals(cip)) {
				sqlBuffer.append(" and nt.node_ip = '" + cip + "'");
			}
			if (ctn != null && !"".equals(ctn)) {
				sqlBuffer.append(" and cti.id =" + ctn);
			}
			if (!this.getAdminMark()) {
				// 权限控制------begin
				sqlBuffer.append(" and (((( cti.view_level=1 and cti.user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or ( cti.view_level=2 and cti.group_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or cti.view_level=3 ) and cti.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (cti.view_level=4 )");
				sqlBuffer.append(") ");
				sqlBuffer.append("and (((( dsi.view_level=1 and dsi.create_user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or ( dsi.view_level=2 and dsi.create_usergroup_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or dsi.view_level=3 ) and dsi.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (dsi.view_level=4 )");
				sqlBuffer.append(") and dsi.detection_set_state=1 and cti.crete_state=0  ");
			}
			sqlBuffer.append(" order by police_level ASC, ipn ASC,ctiId1 ASC, dsi.id ASC");
			System.out.println("sqlBuffer:" + sqlBuffer.toString());
			page = this.commonService.findByPageForSql(sqlBuffer.toString(), pageNo, pageSize, null);
			List<Object[]> detectionInfoList; // 最新状态信息集合
			detectionInfoList = (List<Object[]>) page.getResult();
			detectionInfoList = changeValue(detectionInfoList, true);
			nodeIpGroupListNew = getNodeIpGroupListNew(detectionInfoList, true);
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.faild_n81i');this.location='monitorData.do?action=query'</script>");
		}
		return "queryAbnormalSet";

	}

	/**
	 * 
	 * 异常设备的动态刷新方法
	 * 
	 * @author jinshujuan May 13, 2013
	 * @version 1.0
	 * @return
	 */
	private String queryAbnormalSetChild() {

		try {
			/*
			 * StringBuffer sqlBuffer = new StringBuffer(); sqlBuffer.
			 * append(" select * from   (select row_number() over (PARTITION BY newTable.ip,newTable.iden order by newTable.dctime desc, newTable.ip) LEV, newTable.* FROM ("
			 * ); sqlBuffer.
			 * append(" select distinct din.id,nt.node_ip ip,cti.check_type_name1,dsi.PROCESS_IDEN_NAME iden,din.detectioned_state"
			 * ); sqlBuffer.
			 * append(",to_char(din.data_check_time,'yyyy-MM-dd HH24:mi:Ss') dctime,'',din.current_times,din.detection_state_info,to_char(din.status_change_time,'yyyy-MM-dd HH24:mi:Ss')"
			 * ); sqlBuffer.
			 * append(",dsi.id dsiiId,cti.id ctiId,din.seq_id sqId,nt.node_system_type nodeSysType,nvl(checkTypeCharState.charStateNum,0) charStateNum,nt.node_type nodeType,nt.ipn ipn, din.police_level police_level,decode(cti.check_type_name,'NMSClient',-1,cti.id) ctiId1"
			 * ); sqlBuffer.append(" from DETECTION_INFO_NEW din");
			 * sqlBuffer.append(" left join DETECTION_SET_INFO dsi");
			 * sqlBuffer.append(" on din.detection_set_info_id = dsi.id");
			 * sqlBuffer.append(" left join check_type_info cti");
			 * sqlBuffer.append(" on dsi.check_type_id = cti.id"); sqlBuffer.
			 * append(" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id,ipn from  NODE_TABLE) nt"
			 * ); sqlBuffer.append(" on din.seq_id = nt.seq_id"); //
			 * 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------start
			 * sqlBuffer.append(" left join "); sqlBuffer.
			 * append("  (select md.check_type_id as ctId,count(*) as charStateNum  from metadata md  where md.chart_state=0  group by md.check_type_id) checkTypeCharState "
			 * ); sqlBuffer.append(" on checkTypeCharState.ctId=cti.id "); //
			 * 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------end
			 * 
			 * // sqlBuffer.append(""); sqlBuffer.
			 * append(" where (police_level!=99 or police_level=99 and detectioned_state!=1) and nt.node_ip is not null AND nt.node_type =1 and nt.node_state = 0 and dsi.detection_set_state ='1'  and cti.crete_state=0  and din.valid=1 AND din.detectioned_state in('0','-1') "
			 * );// 只显示有效的数据：din.valid=1 if
			 * (!this.getAdminMark()) {
			 * sqlBuffer.append(" and nt.system_id = ");
			 * sqlBuffer.append(this.getSystemID()); } if (cip != null &&
			 * !"".equals(cip) && !"null".equals(cip)) {
			 * sqlBuffer.append(" and nt.node_ip = '" + cip + "'"); } if (ctn !=
			 * null && !"".equals(ctn)) { sqlBuffer.append(" and cti.id =" +
			 * ctn);
			 * 
			 * } if (!this.getAdminMark()) {
			 * sqlBuffer.append(" and (((( cti.view_level=1 and cti.user_id=");
			 * sqlBuffer.append(this.getUserID()); sqlBuffer.append(")");
			 * sqlBuffer.
			 * append(" or ( cti.view_level=2 and cti.group_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='"
			 * ); sqlBuffer.append(this.getUser().getYhbh()); sqlBuffer.
			 * append("' and x.type = 1)) or cti.view_level=3 ) and cti.system_id = "
			 * ); sqlBuffer.append(this.getSystemID()); sqlBuffer.append(")");
			 * sqlBuffer.append(" or (cti.view_level=4 )");
			 * sqlBuffer.append(") ");
			 * 
			 * sqlBuffer.
			 * append("and (((( dsi.view_level=1 and dsi.create_user_id=");
			 * sqlBuffer.append(this.getUserID()); sqlBuffer.append(")");
			 * sqlBuffer.
			 * append(" or ( dsi.view_level=2 and dsi.create_usergroup_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='"
			 * ); sqlBuffer.append(this.getUser().getYhbh()); sqlBuffer.
			 * append("' and x.type = 1)) or dsi.view_level=3 ) and dsi.system_id = "
			 * ); sqlBuffer.append(this.getSystemID()); sqlBuffer.append(")");
			 * sqlBuffer.append(" or (dsi.view_level=4 )"); sqlBuffer.
			 * append(") and dsi.detection_set_state=1 and cti.crete_state=0  "
			 * ); } sqlBuffer.
			 * append(" order by police_level ASC,ipn ASC,ctiId1 ASC, dsi.id ASC"
			 * ); sqlBuffer.append(" ) newTable ) WHERE LEV =1");
			 * System.out.println("sqlBuffer:" + sqlBuffer.toString());
			 */
			// @ 2018年4月10日 fang 经对比 与 queryAbnormalSet() 方法中 sql 语句一致，以上注释为
			// 修改之前语句
			StringBuffer sqlBuffer = new StringBuffer();
			sqlBuffer.append(" select distinct 1 LEV, din.id,nt.node_ip ip,cti.check_type_name1,dsi.PROCESS_IDEN_NAME iden,din.detectioned_state");
			sqlBuffer.append(",to_char(din.data_check_time,'yyyy-MM-dd HH24:mi:Ss') dctime,'',din.current_times,din.detection_state_info,to_char(din.status_change_time,'yyyy-MM-dd HH24:mi:Ss')");
			sqlBuffer.append(",dsi.id dsiiId,cti.id ctiId,din.seq_id sqId,nt.node_system_type nodeSysType,nvl(checkTypeCharState.charStateNum,0) charStateNum,nt.node_type nodeType,nt.ipn ipn, din.police_level police_level,decode(cti.check_type_name,'NMSClient',-1,cti.id) ctiId1");
			sqlBuffer.append(" from (select seq_id,detection_set_info_id,max(data_check_time) data_check_time from DETECTION_INFO_NEW d where d.valid = 1 group by seq_id,detection_set_info_id) dmax ");
			sqlBuffer.append(" left join DETECTION_INFO_NEW din on din.seq_id = dmax.seq_id and din.detection_set_info_id = dmax.detection_set_info_id and din. data_check_time = dmax.data_check_time ");
			sqlBuffer.append(" left join DETECTION_SET_INFO dsi");
			sqlBuffer.append(" on din.detection_set_info_id = dsi.id");
			sqlBuffer.append(" left join check_type_info cti");
			sqlBuffer.append(" on dsi.check_type_id = cti.id");
			sqlBuffer.append(" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id,ipn from  NODE_TABLE) nt");
			sqlBuffer.append(" on din.seq_id = nt.seq_id");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------start
			sqlBuffer.append(" left join ");
			sqlBuffer.append("  (select md.check_type_id as ctId,count(*) as charStateNum  from metadata md  where md.chart_state=0  group by md.check_type_id) checkTypeCharState ");
			sqlBuffer.append(" on checkTypeCharState.ctId=cti.id ");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------end

			// sqlBuffer.append("");
			// 99表示告警恢复，但是有的告警，没有设置告警级别，默认就会是99，但是监测状态异常，此时要显示：police_level!=99
			// or police_level=99 and detectioned_state!=1
			sqlBuffer.append(" where (police_level!=99 or police_level=99 and detectioned_state!=1) and nt.node_ip is not null AND nt.node_type =1 and nt.node_state = 0 and dsi.detection_set_state ='1'  and cti.crete_state=0  and din.valid=1 AND din.detectioned_state in('0','-1') ");// 只显示有效的数据：din.valid=1
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and nt.system_id = ");
				sqlBuffer.append(this.getSystemID());
			}
			if (cip != null && !"".equals(cip) && !"null".equals(cip)) {
				sqlBuffer.append(" and nt.node_ip = '" + cip + "'");
			}
			if (ctn != null && !"".equals(ctn)) {
				sqlBuffer.append(" and cti.id =" + ctn);
			}
			if (!this.getAdminMark()) {
				// 权限控制------begin
				sqlBuffer.append(" and (((( cti.view_level=1 and cti.user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or ( cti.view_level=2 and cti.group_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or cti.view_level=3 ) and cti.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (cti.view_level=4 )");
				sqlBuffer.append(") ");
				sqlBuffer.append("and (((( dsi.view_level=1 and dsi.create_user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or ( dsi.view_level=2 and dsi.create_usergroup_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or dsi.view_level=3 ) and dsi.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (dsi.view_level=4 )");
				sqlBuffer.append(") and dsi.detection_set_state=1 and cti.crete_state=0  ");
			}
			sqlBuffer.append(" order by police_level ASC, ipn ASC,ctiId1 ASC, dsi.id ASC");
			System.out.println("sqlBuffer:" + sqlBuffer.toString());
			page = this.commonService.findByPageForSql(sqlBuffer.toString(), pageNo, pageSize, null);
			List<Object[]> detectionInfoList; // 最新状态信息集合
			detectionInfoList = (List<Object[]>) page.getResult();
			detectionInfoList = changeValue(detectionInfoList, true);
			nodeIpGroupListNew = getNodeIpGroupListNew(detectionInfoList, true);
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.faild_n81i');this.location='monitorData.do?action=queryAbnormalSet'</script>");
		}
		return "queryAbnormalSetChild";

	}

	/**
	 * 
	 * 网元检测菜单
	 * 
	 * @author jinshujuan Jun 17, 2013
	 * @version 1.0
	 * @return
	 */
	private String queryNE() {
		if (mypageNo > 0 && mypageSize > 0) {
			pageNo = mypageNo;
			pageSize = mypageSize;
		}
		try {
			StringBuffer sqlBuffer = new StringBuffer();

			sqlBuffer.append(
					" select distinct din.id,nt.node_ip,cti.check_type_name1,dsi.PROCESS_IDEN_NAME,din.detectioned_state");
			sqlBuffer.append(
					",to_char(din.data_check_time,'yyyy-MM-dd HH24:mi:Ss'),'',din.current_times,din.detection_state_info,to_char(din.status_change_time,'yyyy-MM-dd HH24:mi:Ss')");
			sqlBuffer.append(
					",dsi.id dsiiId,cti.id ctiId,din.seq_id sqId,nt.node_system_type nodeSysType,nvl(checkTypeCharState.charStateNum,0) charStateNum,nt.node_type nodeType,nt.ipn ipn,decode(cti.check_type_name,'NMSClient',-1,cti.id) ctiId1");

			sqlBuffer.append(" from DETECTION_INFO_NEW din");
			sqlBuffer.append(" left join DETECTION_SET_INFO dsi");
			sqlBuffer.append(" on din.detection_set_info_id = dsi.id");
			sqlBuffer.append(" left join check_type_info cti");
			sqlBuffer.append(" on dsi.check_type_id = cti.id");
			sqlBuffer.append(
					" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id ,ipn from  NODE_TABLE) nt");
			sqlBuffer.append(" on din.seq_id = nt.seq_id");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------start
			sqlBuffer.append(" left join ");
			sqlBuffer.append(
					"  (select md.check_type_id as ctId,count(*) as charStateNum  from metadata md  where md.chart_state=0  group by md.check_type_id) checkTypeCharState ");
			sqlBuffer.append(" on checkTypeCharState.ctId=cti.id ");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------end

			sqlBuffer.append(
					" where nt.node_ip is not null AND nt.node_type =1 and nt.node_state = 0 and dsi.detection_set_state ='1'  and cti.crete_state=0  and din.valid=1");// 只显示有效的数据：din.valid=1
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and nt.system_id = ");
				sqlBuffer.append(this.getSystemID());
			}
			if (cip != null && !"".equals(cip) && !"null".equals(cip)) {
				sqlBuffer.append(" and nt.node_ip like '%" + cip.trim() + "%'");
			}
			if (ctn != null && !"".equals(ctn)) {
				sqlBuffer.append(" and Upper(cti.Check_Type_Name1) like '%" + ctn.toUpperCase() + "%'");
			}
			if (checkType != null && !"".equals(checkType)&&checkType>=0) {
				sqlBuffer.append(" and cti.id=" + checkType);
			}
			if (StringUtils.isNotBlank(stateInfo)) {
				sqlBuffer.append(" and din.detection_state_info like '%" + stateInfo + "%'");
			}
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and (((( cti.view_level=1 and cti.user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( cti.view_level=2 and cti.group_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or cti.view_level=3 ) and cti.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (cti.view_level=4 )");
				sqlBuffer.append(") ");

				sqlBuffer.append("and (((( dsi.view_level=1 and dsi.create_user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( dsi.view_level=2 and dsi.create_usergroup_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or dsi.view_level=3 ) and dsi.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (dsi.view_level=4 )");
				sqlBuffer.append(") and dsi.detection_set_state=1 and cti.crete_state=0  ");
			}
			sqlBuffer.append(" order by ipn ASC,ctiId1 ASC, dsi.id ASC");
			System.out.println("sqlBuffer:" + sqlBuffer.toString());
			page = this.commonService.findByPageForSql(sqlBuffer.toString(), pageNo, pageSize, null);
			List<Object[]> detectionInfoList; // 最新状态信息集合
			detectionInfoList = (List<Object[]>) page.getResult();
			detectionInfoList = changeValue(detectionInfoList, false);
			// 检测类别查询条件不为空时 查询出来的结果，先判断握手是否成功，如果握手状态异常则查出来的状态也是异常
			if (!StringUtil.isBlank(ctn)) {
				changeStatus(detectionInfoList, ctn);
			}
			nodeIpGroupListNew = getNodeIpGroupListNew(detectionInfoList, false);
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.faild_n81i');this.location='monitorData.do?action=query'</script>");
		}
		return "queryNE";

	}

	/**
	 * 
	 * TODO 网元检测菜单-子查询
	 * 
	 * @author jinshujuan Jun 17, 2013
	 * @version 1.0
	 * @return
	 */

	private String queryNEChild() {

		try {
			StringBuffer sqlBuffer = new StringBuffer();
			sqlBuffer.append(
					" select distinct din.id,nt.node_ip,cti.check_type_name1,dsi.PROCESS_IDEN_NAME,din.detectioned_state");
			sqlBuffer.append(
					",to_char(din.data_check_time,'yyyy-MM-dd HH24:mi:Ss'),'',din.current_times,din.detection_state_info,to_char(din.status_change_time,'yyyy-MM-dd HH24:mi:Ss')");
			sqlBuffer.append(
					",dsi.id dsiiId,cti.id ctiId,din.seq_id sqId,nt.node_system_type nodeSysType,nvl(checkTypeCharState.charStateNum,0) charStateNum,nt.node_type nodeType,nt.ipn ipn ,decode(cti.check_type_name,'NMSClient',-1,cti.id) ctiId1");

			sqlBuffer.append(" from DETECTION_INFO_NEW din");
			sqlBuffer.append(" left join DETECTION_SET_INFO dsi");
			sqlBuffer.append(" on din.detection_set_info_id = dsi.id");
			sqlBuffer.append(" left join check_type_info cti");
			sqlBuffer.append(" on dsi.check_type_id = cti.id");
			sqlBuffer.append(
					" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id,ipn from  NODE_TABLE) nt");
			sqlBuffer.append(" on din.seq_id = nt.seq_id");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------start
			sqlBuffer.append(" left join ");
			sqlBuffer.append(
					"  (select md.check_type_id as ctId,count(*) as charStateNum  from metadata md  where md.chart_state=0  group by md.check_type_id) checkTypeCharState ");
			sqlBuffer.append(" on checkTypeCharState.ctId=cti.id ");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------end

			sqlBuffer.append(
					" where nt.node_ip is not null AND nt.node_type =1 and nt.node_state = 0 and dsi.detection_set_state ='1'  and cti.crete_state=0  and din.valid=1");// 只显示有效的数据：din.valid=1
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and nt.system_id = ");
				sqlBuffer.append(this.getSystemID());
			}
			if (cip != null && !"".equals(cip) && !"null".equals(cip)) {
				sqlBuffer.append(" and nt.node_ip = '" + cip + "'");
			}
			if (ctn != null && !"".equals(ctn)) {
				sqlBuffer.append(" and Upper(cti.Check_Type_Name1) like '%" + ctn.toUpperCase() + "%'");

			}
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and (((( cti.view_level=1 and cti.user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( cti.view_level=2 and cti.group_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or cti.view_level=3 ) and cti.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (cti.view_level=4 )");
				sqlBuffer.append(") ");

				sqlBuffer.append("and (((( dsi.view_level=1 and dsi.create_user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( dsi.view_level=2 and dsi.create_usergroup_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or dsi.view_level=3 ) and dsi.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (dsi.view_level=4 )");
				sqlBuffer.append(") and dsi.detection_set_state=1 and cti.crete_state=0  ");
			}
			sqlBuffer.append("  order by ipn ASC,ctiId1 ASC, dsi.id ASC");
			System.out.println("sqlBuffer:" + sqlBuffer.toString());
			page = this.commonService.findByPageForSql(sqlBuffer.toString(), pageNo, pageSize, null);
			List<Object[]> detectionInfoList; // 最新状态信息集合
			detectionInfoList = (List<Object[]>) page.getResult();
			detectionInfoList = changeValue(detectionInfoList, false);
			// 检测类别查询条件不为空时 查询出来的结果，先判断握手是否成功，如果握手状态异常则查出来的状态也是异常
			if (!StringUtil.isBlank(ctn)) {
				changeStatus(detectionInfoList, ctn);
			}
			nodeIpGroupListNew = getNodeIpGroupListNew(detectionInfoList, false);
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.faild_n81i');this.location='monitorData.do?action=query'</script>");
		}
		return "queryNEChild";

	}

	/**
	 * 
	 * 查询检测设置的历史记录
	 * 
	 * @author jinshujuan Jun 18, 2013
	 * @version 1.0
	 * @return
	 */
	public void showDetectionInfo() {
		try {
			String sqlStr = "";
			if (!StringUtils.isBlank(flag) && ("queryAllConfigLevel".equals(flag) || "warning".equals(flag))) {
				sqlStr = "diw.PERFORMACE_DATA";
			} else {
				sqlStr = "diw.detection_state_info";
			}
			StringBuffer sql = new StringBuffer(
					"SELECT nt.node_ip,cti.check_type_name1,dsi.process_iden_name,diw.detectioned_state,"
							+ " TO_CHAR(diw.data_check_time, 'yyyy-MM-dd HH24:mi:Ss'),diw.current_times," + sqlStr + ","
							+ "  diw.id diwId,diw.seq_id,dsi.id dsiId,cti.id ctiId,nt.node_type,nt.node_system_type,nt.ipn,NVL(md.chartNum, 0) chartNum"
							+ "  from " + tableName
							+ " diw LEFT JOIN detection_set_info dsi ON diw.detection_set_info_id=dsi.id"
							+ "  LEFT JOIN check_type_info cti ON cti.id = dsi.check_type_id"
							+ "  LEFT JOIN ( SELECT DISTINCT t.node_ip,t.seq_id,t.node_type,t.node_system_type,t.ipn from node_table t) nt ON nt.seq_id=diw.seq_id"
							+ "  LEFT JOIN (SELECT check_type_id ctid,COUNT(*) AS chartNum from metadata  WHERE chart_state=0 GROUP BY check_type_id) md ON md.ctid=cti.id"
							+ "  WHERE diw.detection_set_info_id=" + dsiId + " AND diw.seq_id=" + sqId);
			// 默认取一定的开始时间(暂时为当前天的前n天) 到
			// 当前最新的时间，第一次进入监测数据历史列表时，sTime和eTime为null，之后查询，如果sTime和eTime为空，则为""
			if (eTime == null && sTime == null) {
				sTime = DateUtil.getShortDateStrByMinusDay(Constants.DEFAULT_SEARCH_DAY);
			}
			if (!StringUtil.isBlank(sTime)) {
				sql.append(" AND diw.data_check_time >= TO_DATE('" + sTime + " 00:00:00', 'yyyy-MM-dd HH24:mi:Ss')");
			}

			if (!StringUtil.isBlank(eTime)) {
				sql.append(" AND diw.data_check_time <= TO_DATE('" + eTime + " 23:59:59', 'yyyy-MM-dd HH24:mi:Ss')");
			}

			if (!StringUtil.isBlank(status)) {
				if ("1".equals(status)) {
					sql.append("  AND diw.detectioned_state = '" + status + "'");
				} else if ("-1,0".equals(status)) {
					sql.append("  AND (diw.detectioned_state = '-1' or diw.detectioned_state = '0')");
				} else {
					sql.append("  AND diw.detectioned_state IN (" + status + ")");
				}
			}
			sql.append(" ORDER by diw.data_check_time DESC");
			page = commonService.findByPageForSql(sql.toString(), pageNo, pageSize);
			detectionInfoWarningList = (List<Object[]>) page.getResult();

		} catch (Exception e) {
			e.printStackTrace();
			logger.info("设置名称查看异常！", e);
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.faild_n81i');this.location='monitorData.do?action=queryNE&pageNo="
							+ pageNo + "&pageSize=" + pageSize + "'</script>");
		}
	}

	/**
	 * 
	 * 拓扑图来源，查询服务器状态信息
	 * 
	 * @author tanghao 07 17, 2018
	 * queryMonitorDataInfoNewForTopo()方法修改
	 * @return
	 */
	private void queryMonitorDataInfoNewForTopoDetail() {
		if (mypageNo > 0 && mypageSize > 0) {
			pageNo = mypageNo;
			pageSize = mypageSize;
		}
		try {
			StringBuffer sqlBuffer = new StringBuffer();

			sqlBuffer.append(
					" select distinct din.id,nt.node_ip,cti.check_type_name1,dsi.PROCESS_IDEN_NAME,din.detectioned_state detectioned_state");
			sqlBuffer.append(
					",to_char(din.data_check_time,'yyyy-MM-dd HH24:mi:Ss'),'',din.current_times,din.detection_state_info,to_char(din.status_change_time,'yyyy-MM-dd HH24:mi:Ss')");
			sqlBuffer.append(
					",dsi.id dsiiId,cti.id ctiId,din.seq_id sqId,nt.node_system_type nodeSysType,nvl(checkTypeCharState.charStateNum,0) charStateNum,nt.node_type nodeType,nt.ipn ipn");
			sqlBuffer.append(",din.police_emergent police_emergent,din.police_level police_level");
			sqlBuffer.append(" from DETECTION_INFO_NEW din");
			sqlBuffer.append(" left join DETECTION_SET_INFO dsi");
			sqlBuffer.append(" on din.detection_set_info_id = dsi.id");
			sqlBuffer.append(" left join check_type_info cti");
			sqlBuffer.append(" on dsi.check_type_id = cti.id");
			// @2018-3-9 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
			StringBuffer queryIds=null;
			if(nodeType!=null&&Integer.parseInt(nodeType)==1){
				queryIds=new StringBuffer();
				String groupIdSql = "select node_id from node_table where "
						+ "node_id not in (select type_id from topo_node_info where type=2) and node_state=0 and node_group_id = "+nodeGroupId;
				List nodeGroupIds = this.commonService.executeSQL(groupIdSql);
				if(!nis.nms.util.StringUtil.objectIsNUll(nodeGroupIds)){
					for(int i=0;i<nodeGroupIds.size();i++){
						if(i==nodeGroupIds.size()-1){
							queryIds.append(nodeGroupIds.get(i));
						}else{
							queryIds.append(nodeGroupIds.get(i));
							queryIds.append(",");
						}
					}
				}else{
					queryIds.append(-1);
				}
			}
			/*
			 * sqlBuffer.
			 * append(" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id ,ipn from  NODE_TABLE WHERE node_group_id in"
			 * +
			 * "(select t.group_id from nodegroup_table t start with t.group_id ="
			 * + nodeGroupId +
			 * " connect by prior t.group_id = t.parent_group_id)) nt");
			 */
			//判断如果是单个节点
			if(nodeType!=null&&Integer.parseInt(nodeType)==2){
				sqlBuffer
				.append(" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id ,ipn from  NODE_TABLE WHERE node_id ="
						+  nodeId + ") nt");
			}else{
				sqlBuffer
				.append(" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id ,ipn from  NODE_TABLE WHERE node_id in"
						+ "(" + queryIds.toString() + ")) nt");
			}
			sqlBuffer.append(" on din.seq_id = nt.seq_id");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------start
			sqlBuffer.append(" left join ");
			sqlBuffer.append(
					"  (select md.check_type_id as ctId,count(*) as charStateNum  from metadata md  where md.chart_state=0  group by md.check_type_id) checkTypeCharState ");
			sqlBuffer.append(" on checkTypeCharState.ctId=cti.id ");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------end

			// sqlBuffer.append("");
			sqlBuffer.append(
					" where nt.node_ip is not null and nt.node_state = 0 and dsi.detection_set_state ='1'  and cti.crete_state=0  and din.valid=1");// 只显示有效的数据：din.valid=1
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and nt.system_id = ");
				sqlBuffer.append(this.getSystemID());
			}
			if (cip != null && !"".equals(cip) && !"null".equals(cip)) {
				sqlBuffer.append(" and nt.node_ip like '%" + cip.trim() + "%'");
			}
			/*if (ctn != null && !"".equals(ctn)) {
				sqlBuffer.append(" and Upper(cti.Check_Type_Name1) like '%" + ctn.toUpperCase() + "%'");
			}*/
			if(checkType != null && checkType != -1) {
				sqlBuffer.append(" and cti.id=" + checkType);
			}
			if (StringUtils.isNotBlank(stateInfo)) {
				sqlBuffer.append(" and din.detection_state_info like '%" + stateInfo + "%'");
			}
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and (((( cti.view_level=1 and cti.user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( cti.view_level=2 and cti.group_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or cti.view_level=3 ) and cti.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (cti.view_level=4 )");
				sqlBuffer.append(") ");

				sqlBuffer.append("and (((( dsi.view_level=1 and dsi.create_user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( dsi.view_level=2 and dsi.create_usergroup_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or dsi.view_level=3 ) and dsi.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (dsi.view_level=4 )");
				sqlBuffer.append(") and dsi.detection_set_state=1 and cti.crete_state=0  ");
			}
			sqlBuffer.append(" ORDER by  detectioned_state, police_emergent, police_level");
			System.out.println("sqlBuffer:" + sqlBuffer.toString());
			page = this.commonService.findByPageForSql(sqlBuffer.toString(), pageNo, pageSize, null);
			List<Object[]> detectionInfoList; // 最新状态信息集合
			detectionInfoList = (List<Object[]>) page.getResult();
			detectionInfoList = changeValue(detectionInfoList, false);
			// 检测类别查询条件不为空时 查询出来的结果，先判断握手是否成功，如果握手状态异常则查出来的状态也是异常
			if (!StringUtil.isBlank(ctn)) {
				changeStatus(detectionInfoList, ctn);
			}
			nodeIpGroupListNew = changeShowList(detectionInfoList, false);
			if (StringUtils.isNotBlank(nodeGroupId)) {
				NodegroupTable ngt = (NodegroupTable) this.commonService.get(NodegroupTable.class,
						Long.parseLong(nodeGroupId.trim()));
				nodeGroupName = ngt == null ? "" : ngt.getGroupName();
			}else if(StringUtils.isNotBlank(nodeId)){
				NodeTable ngt = (NodeTable) this.commonService.get(NodeTable.class,
						Long.parseLong(nodeId.trim()));
				nodeGroupName = ngt == null ? "" : ngt.getNodeIp();
			}
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.faild_n81i');</script>");
		}

	}
	
	/**
	 * 
	 * 拓扑图来源，查询紧急告警-服务器
	 * 
	 * @author tanghao 07 17, 2018
	 * queryEmergent()方法修改
	 * @return
	 */
	private void queryEmergentDetail() {
		if (mypageNo > 0 && mypageSize > 0) {
			pageNo = mypageNo;
			pageSize = mypageSize;
		}
		try {
			StringBuffer sqlBuffer =new StringBuffer();

			sqlBuffer.append(
					" select distinct din.id,nt.node_ip,cti.check_type_name1,dsi.PROCESS_IDEN_NAME,din.detectioned_state detectioned_state");
			sqlBuffer.append(
					",to_char(din.data_check_time,'yyyy-MM-dd HH24:mi:Ss'),'',din.current_times,din.detection_state_info,to_char(din.status_change_time,'yyyy-MM-dd HH24:mi:Ss')");
			sqlBuffer.append(
					",dsi.id dsiiId,cti.id ctiId,din.seq_id sqId,nt.node_system_type nodeSysType,nvl(checkTypeCharState.charStateNum,0) charStateNum,nt.node_type nodeType,nt.ipn ipn");
			sqlBuffer.append(",din.police_emergent police_emergent,din.police_level police_level");
			sqlBuffer.append(" from DETECTION_INFO_NEW din");
			sqlBuffer.append(" left join DETECTION_SET_INFO dsi");
			sqlBuffer.append(" on din.detection_set_info_id = dsi.id");
			sqlBuffer.append(" left join check_type_info cti");
			sqlBuffer.append(" on dsi.check_type_id = cti.id");
			// @2018-3-9 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
			StringBuffer queryIds=null;
			if(nodeType!=null&&Integer.parseInt(nodeType)==1){
				queryIds=new StringBuffer();
				String groupIdSql = "select node_id from node_table where "
						+ "node_id not in (select type_id from topo_node_info where type=2) and node_state=0 and node_group_id = "+nodeGroupId;
				List nodeGroupIds = this.commonService.executeSQL(groupIdSql);
				if(!nis.nms.util.StringUtil.objectIsNUll(nodeGroupIds)){
					for(int i=0;i<nodeGroupIds.size();i++){
						if(i==nodeGroupIds.size()-1){
							queryIds.append(nodeGroupIds.get(i));
						}else{
							queryIds.append(nodeGroupIds.get(i));
							queryIds.append(",");
						}
					}
				}
			}
			/*
			 * sqlBuffer.
			 * append(" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id ,ipn from  NODE_TABLE WHERE node_group_id in "
			 * +
			 * "(select t.group_id from nodegroup_table t start with t.group_id ="
			 * + nodeGroupId +
			 * " connect by prior t.group_id = t.parent_group_id)) nt");
			 */
			if(nodeType!=null&&Integer.parseInt(nodeType)==2){
				sqlBuffer
				.append(" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id ,ipn from  NODE_TABLE WHERE node_id ="
						+  nodeId + ") nt");
			}else{
				sqlBuffer
				.append(" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id ,ipn from  NODE_TABLE WHERE node_id in"
						+ "(" + queryIds.toString() + ")) nt");
			}
			sqlBuffer.append(" on din.seq_id = nt.seq_id");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------start
			sqlBuffer.append(" left join ");
			sqlBuffer.append(
					"  (select md.check_type_id as ctId,count(*) as charStateNum  from metadata md  where md.chart_state=0  group by md.check_type_id) checkTypeCharState ");
			sqlBuffer.append(" on checkTypeCharState.ctId=cti.id ");
			// ------------2013-1-23 hyx
			// 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------end

			sqlBuffer.append(
					" where nt.node_ip is not null and nt.node_state = 0 and dsi.detection_set_state ='1'  and cti.crete_state=0  and din.valid=1 and din.DETECTIONED_STATE<>1 AND din.POLICE_EMERGENT=0");// 只显示有效的数据：din.valid=1
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and nt.system_id = ");
				sqlBuffer.append(this.getSystemID());
			}
			if (cip != null && !"".equals(cip) && !"null".equals(cip)) {
				sqlBuffer.append(" and nt.node_ip like '%" + cip.trim() + "%'");
			}
			if (checkType != null && checkType != -1) {
				sqlBuffer.append(" and cti.id =" + checkType);
			}
/*			if (ctn != null && !"".equals(ctn)) {
				sqlBuffer.append(" and Upper(cti.Check_Type_Name1) like '%" + ctn.toUpperCase() + "%'");
			}
*/			if (!this.getAdminMark()) {
				sqlBuffer.append(" and (((( cti.view_level=1 and cti.user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( cti.view_level=2 and cti.group_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or cti.view_level=3 ) and cti.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (cti.view_level=4 )");
				sqlBuffer.append(") ");

				sqlBuffer.append("and (((( dsi.view_level=1 and dsi.create_user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(")");
				sqlBuffer.append(
						" or ( dsi.view_level=2 and dsi.create_usergroup_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1)) or dsi.view_level=3 ) and dsi.system_id = ");
				sqlBuffer.append(this.getSystemID());
				sqlBuffer.append(")");
				sqlBuffer.append(" or (dsi.view_level=4 )");
				sqlBuffer.append(") and dsi.detection_set_state=1 and cti.crete_state=0  ");
			}
			sqlBuffer.append(" ORDER by  detectioned_state, police_emergent, police_level");
			System.out.println("sqlBuffer:" + sqlBuffer.toString());
			page = this.commonService.findByPageForSql(sqlBuffer.toString(), pageNo, pageSize, null);
			List<Object[]> detectionInfoList; // 最新状态信息集合
			detectionInfoList = (List<Object[]>) page.getResult();
			detectionInfoList = changeValue(detectionInfoList, false);
			// 检测类别查询条件不为空时 查询出来的结果，先判断握手是否成功，如果握手状态异常则查出来的状态也是异常
			if (!StringUtil.isBlank(ctn)) {
				changeStatus(detectionInfoList, ctn);
			}
			nodeIpGroupListNew = changeShowList(detectionInfoList, false);
			// if(StringUtils.isNotBlank(nodeGroupId)) {
			// NodegroupTable ngt =
			// (NodegroupTable)this.commonService.get(NodegroupTable.class,
			// Long.parseLong(nodeGroupId.trim()));
			// nodeGroupName = ngt==null?"":ngt.getGroupName();
			// }else {
			// nodeGroupName = "";
			// }
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_MonitorDataAction.emportCurrentXlsAbnormalSet.faild_n81i');</script>");
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

	public Long[] getIds() {
		return ids;
	}

	public void setIds(Long[] ids) {
		this.ids = ids;
	}

	public String getCip() {
		return cip;
	}

	public void setCip(String cip) {
		this.cip = cip;
	}

	public List<DetectionInfoNew> getDetectionInfoNewList() {
		return detectionInfoNewList;
	}

	public void setDetectionInfoNewList(List<DetectionInfoNew> detectionInfoNewList) {
		this.detectionInfoNewList = detectionInfoNewList;
	}

	public DetectionInfoNew getDetectionInfoNew() {
		return detectionInfoNew;
	}

	public void setDetectionInfoNew(DetectionInfoNew detectionInfoNew) {
		this.detectionInfoNew = detectionInfoNew;
	}

	public String getDsiId() {
		return dsiId;
	}

	public void setDsiId(String dsiId) {
		this.dsiId = dsiId;
	}

	// public CheckTypeInfo getCheckTypeInfo() {
	// return checkTypeInfo;
	// }
	//
	// public void setCheckTypeInfo(CheckTypeInfo checkTypeInfo) {
	// this.checkTypeInfo = checkTypeInfo;
	// }

	public String getJsonStr() {
		return jsonStr;
	}

	public void setJsonStr(String jsonStr) {
		this.jsonStr = jsonStr;
	}

	/*
	 * public List<VDetectionInfoNew> getVdetectionInfoNewList() { return
	 * vdetectionInfoNewList; }
	 * 
	 * public void setVdetectionInfoNewList( List<VDetectionInfoNew>
	 * vdetectionInfoNewList) { this.vdetectionInfoNewList =
	 * vdetectionInfoNewList; }
	 */

	public VDetectionInfoNew getVdetectionInfoNew() {
		return vdetectionInfoNew;
	}

	public void setVdetectionInfoNew(VDetectionInfoNew vdetectionInfoNew) {
		this.vdetectionInfoNew = vdetectionInfoNew;
	}

	public List<List> getVnodeIpGroupList() {
		return vnodeIpGroupList;
	}

	public void setVnodeIpGroupList(List<List> vnodeIpGroupList) {
		this.vnodeIpGroupList = vnodeIpGroupList;
	}

	public List<List> getNodeIpGroupListNew() {
		return nodeIpGroupListNew;
	}

	public void setNodeIpGroupListNew(List<List> nodeIpGroupListNew) {
		this.nodeIpGroupListNew = nodeIpGroupListNew;
	}

	public String getCtn() {
		return ctn;
	}

	public void setCtn(String ctn) {
		this.ctn = ctn;
	}

	public String getStateInfo() {
		return stateInfo;
	}

	public void setStateInfo(String stateInfo) {
		this.stateInfo = stateInfo;
	}

	public List<CheckTypeInfo> getAllCheckTypeInfo() {
		return allCheckTypeInfo;
	}

	public void setAllCheckTypeInfo(List<CheckTypeInfo> allCheckTypeInfo) {
		this.allCheckTypeInfo = allCheckTypeInfo;
	}

	public List<Metadata> getMetadataList() {
		return metadataList;
	}

	public void setMetadataList(List<Metadata> metadataList) {
		this.metadataList = metadataList;
	}

	public String getMetaId() {
		return metaId;
	}

	public void setMetaId(String metaId) {
		this.metaId = metaId;
	}

	public String getNodeIp() {
		return nodeIp;
	}

	public void setNodeIp(String nodeIp) {
		this.nodeIp = nodeIp;
	}

	public String getSqId() {
		return sqId;
	}

	public void setSqId(String sqId) {
		this.sqId = sqId;
	}

	public int getPageNoSub() {
		return pageNoSub;
	}

	public void setPageNoSub(int pageNoSub) {
		this.pageNoSub = pageNoSub;
	}

	public int getPageSizeSub() {
		return pageSizeSub;
	}

	public void setPageSizeSub(int pageSizeSub) {
		this.pageSizeSub = pageSizeSub;
	}

	public Page getPageSub() {
		return pageSub;
	}

	public void setPageSub(Page pageSub) {
		this.pageSub = pageSub;
	}

	public String getLineNames() {
		return lineNames;
	}

	public void setLineNames(String lineNames) {
		this.lineNames = lineNames;
	}

	public String getCtId() {
		return ctId;
	}

	public void setCtId(String ctId) {
		this.ctId = ctId;
	}

	public List getDataList() {
		return dataList;
	}

	public void setDataList(List dataList) {
		this.dataList = dataList;
	}

	public String getDrIndex() {
		return drIndex;
	}

	public void setDrIndex(String drIndex) {
		this.drIndex = drIndex;
	}

	public NodeTable getNodeTable() {
		return nodeTable;
	}

	public void setNodeTable(NodeTable nodeTable) {
		this.nodeTable = nodeTable;
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getRequestType() {
		return requestType;
	}

	public void setRequestType(String requestType) {
		this.requestType = requestType;
	}

	public String getNodeGroupId() {
		return nodeGroupId;
	}

	public void setNodeGroupId(String nodeGroupId) {
		this.nodeGroupId = nodeGroupId;
	}

	public List<Object[]> getDetectionInfoWarningList() {
		return detectionInfoWarningList;
	}

	public void setDetectionInfoWarningList(List<Object[]> detectionInfoWarningList) {
		this.detectionInfoWarningList = detectionInfoWarningList;
	}

	public String getEntry() {
		return entry;
	}

	public void setEntry(String entry) {
		this.entry = entry;
	}

	public String getDetectId() {
		return detectId;
	}

	public void setDetectId(String detectId) {
		this.detectId = detectId;
	}

	public String getSeqId() {
		return seqId;
	}

	public void setSeqId(String seqId) {
		this.seqId = seqId;
	}

	public String getNameFlag() {
		return nameFlag;
	}

	public void setNameFlag(String nameFlag) {
		this.nameFlag = nameFlag;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getIsLeaf() {
		return isLeaf;
	}

	public void setIsLeaf(String isLeaf) {
		this.isLeaf = isLeaf;
	}

	public String getPicId() {
		return picId;
	}

	public void setPicId(String picId) {
		this.picId = picId;
	}

	public String getQueryParConditionDisplay() {
		return queryParConditionDisplay;
	}

	public void setQueryParConditionDisplay(String queryParConditionDisplay) {
		this.queryParConditionDisplay = queryParConditionDisplay;
	}

	public String getQueryChildConditionDisplay() {
		return queryChildConditionDisplay;
	}

	public void setQueryChildConditionDisplay(String queryChildConditionDisplay) {
		this.queryChildConditionDisplay = queryChildConditionDisplay;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public DetectionInfoWarning getDetectionInfoWarning() {
		return detectionInfoWarning;
	}

	public void setDetectionInfoWarning(DetectionInfoWarning detectionInfoWarning) {
		this.detectionInfoWarning = detectionInfoWarning;
	}

	public String getSTime() {
		return sTime;
	}

	public void setSTime(String time) {
		sTime = time;
	}

	public String getETime() {
		return eTime;
	}

	public void setETime(String time) {
		eTime = time;
	}

	public String getShowHistory() {
		return showHistory;
	}

	public void setShowHistory(String showHistory) {
		this.showHistory = showHistory;
	}

	public String getNodeType() {
		return nodeType;
	}

	public void setNodeType(String nodeType) {
		this.nodeType = nodeType;
	}

	public String getNodeIpRange() {
		return nodeIpRange;
	}

	public void setNodeIpRange(String nodeIpRange) {
		this.nodeIpRange = nodeIpRange;
	}

	public String getNodeGroupStr() {
		return nodeGroupStr;
	}

	public void setNodeGroupStr(String nodeGroupStr) {
		this.nodeGroupStr = nodeGroupStr;
	}

	public List<NodegroupTable> getAllNodeGroupInfo() {
		return allNodeGroupInfo;
	}

	public void setAllNodeGroupInfo(List<NodegroupTable> allNodeGroupInfo) {
		this.allNodeGroupInfo = allNodeGroupInfo;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getNodeGroupName() {
		return nodeGroupName;
	}

	public void setNodeGroupName(String nodeGroupName) {
		this.nodeGroupName = nodeGroupName;
	}

	public String getPIden() {
		return pIden;
	}

	public void setPIden(String iden) {
		pIden = iden;
	}

	public String getDct() {
		return dct;
	}

	public void setDct(String dct) {
		this.dct = dct;
	}

	public String getPolice_emergent() {
		return police_emergent;
	}

	public void setPolice_emergent(String police_emergent) {
		this.police_emergent = police_emergent;
	}

	public String getPolice_level() {
		return police_level;
	}

	public void setPolice_level(String police_level) {
		this.police_level = police_level;
	}

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

	public String getQueryNEChild() {
		return queryNEChild;
	}

	public void setQueryNEChild(String queryNEChild) {
		this.queryNEChild = queryNEChild;
	}

	public String getNodeId() {
		return nodeId;
	}

	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}

	public Integer getCheckType() {
		return checkType;
	}

	public void setCheckType(Integer checkType) {
		this.checkType = checkType;
	}

	public String getDetectionSetInfoId() {
		return detectionSetInfoId;
	}

	public void setDetectionSetInfoId(String detectionSetInfoId) {
		this.detectionSetInfoId = detectionSetInfoId;
	}


}
