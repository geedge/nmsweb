package nis.nms.web.actions.detection;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;

import com.nis.util.StringUtil;

import nis.nms.core.Constants;
import nis.nms.domains.CheckTypeInfo;
import nis.nms.domains.DataPoliceRelation;
import nis.nms.domains.DetectionInfoWarning;
import nis.nms.domains.DetectionSetInfo;
import nis.nms.domains.Metadata;
import nis.nms.domains.OptionTable;
import nis.nms.domains.SetDetDataCon;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Common;
import nis.nms.util.Constant;
import nis.nms.util.ExportUtils;
import nis.nms.util.Page;

@SuppressWarnings("unchecked")
@Results({ @Result(name = "queryDetecWarningInfo", value = "/page/detection/detecWarning/detecWarningList.jsp"),
		@Result(name = "queryDetecWarningInfoChild", value = "/page/detection/detecWarning/detecWarningListChild.jsp"),
		@Result(name = "queryConfLevelDetecWarningInfo", value = "/page/detection/detecWarning/detecConfLevelWarningList.jsp"),
		@Result(name = "queryConfLevelDetecWarningInfoChild", value = "/page/detection/detecWarning/detecConfLevelWarningListChild.jsp"),
		@Result(name = "detailWarningInfo", value = "/page/detection/detecWarning/detailWarningInfo.jsp"),
		@Result(name = "showDetectionInfo", value = "/page/detection/detecWarning/detectionInfoList.jsp"),
		@Result(name = "error", value = "/error.jsp") })
/**
 * 监测设置相关操作
 */
public class DetectionWarningAction extends BaseAction {

	private Logger logger = Logger.getLogger(DetectionWarningAction.class);
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	private int pageNo = 1;
	private int pageSize = this.getDefaultPageSize(); // 每页显示的记录条数
	private Page page;
	private String action;
	private String menuVisit; // 是否通过菜单访问（Boolean.parse(menuVisit)）
	private List<DetectionInfoWarning> detecWarningList;
	private DetectionInfoWarning detectionWarningInfo;
	private List<CheckTypeInfo> allCheckTypeInfo;
	private Long[] ids;
	private Long police_level;
	private String police_emergent = "";
	private String warnType = "";// warnType=leftWarn:左下角报警
									// warnType=warnMenu:告警信息菜单
	private List<OptionTable> optionList = new ArrayList<OptionTable>();
	private Long setPoleceLevel;// 参数配置处配置，决定告警信息显示哪些级别的告警信息
	private String nodeIp;
	// 查询条件
	private String pIden;
	private String ip;
	private String nodeIpRange;// IP段
	private String ctn;
	private Integer checkType;
	private String dct;
	private String stateInfo;
	private String seqIdList;
	private String sqId;
	private String dsiId;
	private String sTime;
	private String eTime;
	private String status;
	private String nodeType;
	private List<Object[]> detectionInfoWarningList;
	// 告警查询来源levelAlarm=1来自于login页面的报警信息
	private String levelAlarm;
	private String timeoutDetecFilter; // 过滤超周期状态信息

	private String emergentSetStr = "";
	private String levelSetStr = "";
	private List<String> levelSetList = new ArrayList<String>();
	private SetDetDataCon detecSet = new SetDetDataCon();

	private int mypageNo;
	private int mypageSize;

	private String queryConfLevelChild;// 判断是否是滚动加载子页面

	@Override
	public String executeAction() throws Exception {
		String resultpage = "";
		if ("query".equals(this.action) || "queryNE".equals(this.action) || "queryAll".equals(this.action)) {
			queryCheckTypeInfo();
			if ("queryNE".equals(this.action)) {
				nodeType = "1";// 节点类型为网元
			} else if ("query".equals(this.action)) {
				nodeType = "0";
			}
			this.queryDetecWarningInfo();
			resultpage = "queryDetecWarningInfo";
		} else if ("queryChild".equals(this.action)) {
			queryCheckTypeInfo();
			this.queryDetecWarningInfo();
			resultpage = "queryDetecWarningInfoChild";
		} else if ("queryAllConfigLevel".equalsIgnoreCase(this.action)) {// 告警信息列表
			warnType = "warnMenu"; // 告警信息查询
			queryCheckTypeInfo();
			this.queryConfLevelDetecWarningInfo();
			resultpage = "queryConfLevelDetecWarningInfo";
		} else if ("queryConfLevelChild".equals(this.action)) {
			queryCheckTypeInfo();
			this.queryConfLevelDetecWarningInfo();
			resultpage = "queryConfLevelDetecWarningInfoChild";
		} else if ("detail".equals(this.action)) {
			resultpage = detailDetecWarningInfo();
		} else if ("getTaskMessages".equals(this.action)) {
			resultpage = this.getAlarmMessages();
		} else if ("emportCurrentXls".equals(this.action)) {
			resultpage = emportCurrentXls();
		} else if ("emportAllXls".equals(this.action)) {
			resultpage = emportAllXls();
		} /*
			 * else { queryCheckTypeInfo(); resultpage =
			 * this.queryDetecWarningInfo(); }
			 */
		return resultpage;
	}

	// isDefaultNonEmerg:是否默认显示非紧急信息
	private StringBuffer getIsEmergeAndLevelCon(boolean isDefaultNonEmerg) {
		StringBuffer sqlBuffer = new StringBuffer();
		// 配置界面的条件：emergentSetStr（是否紧急） levelSetStr（非紧急下的级别）
		// 查询界面查询条件：police_emergent（是否紧急） police_level（非紧急级别）
		// 是否紧急状态确定
		if (",0,".equals(emergentSetStr)) { // 检测设置为“紧急”时
			police_emergent = "0";
		} else if (",1,".equals(emergentSetStr)) { // 检测设置为“非紧急”时
			police_emergent = "1";
		} else if (isDefaultNonEmerg && ((StringUtils.isNotBlank(emergentSetStr) && // 配置条件设置为“紧急+非紧急”
																					// 或者都不选
				emergentSetStr.contains(",0,") && emergentSetStr.contains(",1,"))
				|| StringUtils.isBlank(emergentSetStr))) {
			// 2016-08-03 zbc 监测设置为“紧急+非紧急”时，默认显示非紧急的内容（BUG0004452）
			if (Boolean.parseBoolean(menuVisit)) { // 通过左侧菜单访问时，默认显示非紧急告警信息
				police_emergent = "1";
			}
		}

		if (StringUtils.isNotBlank(police_emergent) && !"undefined".equals(police_emergent.toLowerCase())) { // 查询紧急状态或查询非紧急状态
			sqlBuffer.append(" AND police_emergent=" + police_emergent.trim());
		}

		// 预警级别过滤
		if (police_level != null) { // 因为查询条件是配置的子集，所以优先采用查询条件，查询界面选择了非紧急级别
			sqlBuffer.append(" AND police_level = " + police_level);
		} // 如果没有查询非紧急级别条件
			// 如果查询界面为非紧急,则直接看配置的级别即可
		else if ("1".equals(police_emergent) && StringUtils.isNotBlank(levelSetStr) && levelSetStr.length() >= 3) {
			sqlBuffer.append(" AND police_level in( " + levelSetStr.substring(1, levelSetStr.length() - 1) + ")");
		}
		// 如果查询界面为请选择（包含紧急和指定级别的非紧急），且配置了非紧急级别，则进行过滤，否则不进行过滤（避免漏掉请选择情况下的紧急告警）
		else if ((!"0".equals(police_emergent)) && !"1".equals(police_emergent) && StringUtils.isNotBlank(levelSetStr)
				&& levelSetStr.length() >= 3) {
			sqlBuffer.append(" AND (police_emergent = 0 or (police_emergent = 1 and police_level in ("
					+ levelSetStr.substring(1, levelSetStr.length() - 1) + ")))");
		}

		return sqlBuffer;
	}

	private String getOrderStr() {
		return "  order by police_emergent asc,police_level asc,dctime desc, ipn ";
	}

	// 当前页导出 程辉 2013-5-8新增 (告警信息，异常服务器，异常网元)
	public String emportCurrentXls() {
		try {
			// 0:服务器，1：网元，空为报警信息
			String type = this.getRequest().getParameter("type");
			this.getRequest().setAttribute("type", type);
			String levelAndEmergType = "";
			if ("0".equals(nodeType)) {// 服务器
				levelAndEmergType = Constants.MENU_CODE_SERVER_WARNING_INFO;
			} else if ("1".equals(nodeType)) {// 网元
				levelAndEmergType = Constants.MENU_CODE_NE_WARNING_INFO;
			} else if (Constants.WARN_TYPE_LEFT_WARN.equals(warnType)) {// 左下角报警
				levelAndEmergType = Constants.MENU_CODE_EMERGENT_WARNING_INFO;// 报警信息
			} else if (Constants.WARN_TYPE_WARN_MENU.equals(warnType)) {
				levelAndEmergType = Constants.MENU_CODE_ALL_WARNING_INFO;// 告警信息
			}

			StringBuffer sqlBuffer = getNewWarnInfoSql(levelAndEmergType, false);

			// 2013-12-26 hyx 根据不同的异常列表，得到配置的列表过滤条件------------end

			System.out.println("sqlBuffer:" + sqlBuffer.toString());
			page = this.commonService.findByPageForSql(sqlBuffer.toString(), pageNo, pageSize);
			List<Object[]> detectionWarningList1; // 最新状态信息集合
			detectionWarningList1 = (List<Object[]>) page.getResult();
			List<DetectionInfoWarning> detecWarningList = new ArrayList<DetectionInfoWarning>();
			if (detectionWarningList1.size() > 0) {
				detecWarningList = this.getTimeColorIP(detectionWarningList1);
				detecWarningList = changeValue(detecWarningList);// 匹配故障库
			}
			for (int i = 0; i < detecWarningList.size(); i++) {
				if (detecWarningList.get(i).getCheckWay().equals("0")) {
					detecWarningList.get(i).setCheckWay(getI18nText("i18n_DetectionWarningAction.emportCurrentXls.active_n81i"));
				}
				if (detecWarningList.get(i).getCheckWay().equals("1")) {
					detecWarningList.get(i).setCheckWay(getI18nText("i18n_DetectionWarningAction.emportCurrentXls.passive_n81i"));
				}
			}

			String[] title = { getI18nText("i18n_DetectionWarningAction.emportCurrentXls.title.hostName_n81i"),
								getI18nText("i18n_DetectionWarningAction.emportCurrentXls.title.monitorType_n81i"), 
								getI18nText("i18n_DetectionWarningAction.emportCurrentXls.title.setName_n81i"), 
								getI18nText("i18n_DetectionWarningAction.emportCurrentXls.title.monitorWay_n81i"),
								getI18nText("i18n_DetectionWarningAction.emportCurrentXls.title.lastCheckTime_n81i"),
								getI18nText("i18n_DetectionWarningAction.emportCurrentXls.title.duration_n81i"), 
								getI18nText("i18n_DetectionWarningAction.emportCurrentXls.title.attempt_n81i"), 
								getI18nText("i18n_DetectionWarningAction.emportCurrentXls.title.alertLevel_n81i"),
								getI18nText("i18n_DetectionWarningAction.emportCurrentXls.title.performanceData_n81i") };

			String[] colu = { "nodeIp", "detectionSetInfo.checkTypeInfo.checkTypeName1",
					"detectionSetInfo.processIdenName", "checkWay", "dataCheckTime", "persistTime", "currentTimes",
					"policeLevel", "performaceData" };
			String pageType = this.getRequest().getParameter("pageType");
			String url = "";
			if ("queryAllConfigLevel".equals(pageType)) {
				url = "detectionWarning.do?action=queryAllConfigLevel&ip=" + ip + "&ctn=" + ctn + "&pIden=" + pIden
						+ "&dct=" + dct + "&stateInfo=" + stateInfo + "&pageSize=" + pageSize + "&pageNo=" + pageNo
						+ "&timeoutDetecFilter=" + timeoutDetecFilter;
				/*url = "detectionWarning.do?action=queryAllConfigLevel&ip=" + ip + "&checkType=" + checkType + "&pIden=" + pIden
						+ "&dct=" + dct + "&stateInfo=" + stateInfo + "&pageSize=" + pageSize + "&pageNo=" + pageNo
						+ "&timeoutDetecFilter=" + timeoutDetecFilter;*/
			} else if ("query".equals(pageType)) {
				/*url = "detectionWarning.do?action=query&police_emergent=" + police_emergent + "&police_level="
						+ (police_level == null ? "" : police_level) + "&ip=" + ip + "&checkType=" + checkType + "&pIden=" + pIden
						+ "&dct=" + dct + "&stateInfo=" + stateInfo + "&pageSize=" + pageSize + "&pageNo=" + pageNo
						+ "&timeoutDetecFilter=" + timeoutDetecFilter;*/
				url = "detectionWarning.do?action=query&police_emergent=" + police_emergent + "&police_level="
						+ (police_level == null ? "" : police_level) + "&ip=" + ip + "&ctn=" + ctn + "&pIden=" + pIden
						+ "&dct=" + dct + "&stateInfo=" + stateInfo + "&pageSize=" + pageSize + "&pageNo=" + pageNo
						+ "&timeoutDetecFilter=" + timeoutDetecFilter;
			} else if ("queryNE".equals(pageType)) {
				/*url = "detectionWarning.do?action=queryNE&police_emergent=" + police_emergent + "&police_level="
						+ (police_level == null ? "" : police_level) + "&ip=" + ip + "&checkType=" + checkType + "&pIden=" + pIden
						+ "&dct=" + dct + "&stateInfo=" + stateInfo + "&pageSize=" + pageSize + "&pageNo=" + pageNo
						+ "&timeoutDetecFilter=" + timeoutDetecFilter;*/
				url = "detectionWarning.do?action=queryNE&police_emergent=" + police_emergent + "&police_level="
						+ (police_level == null ? "" : police_level) + "&ip=" + ip + "&ctn=" + ctn + "&pIden=" + pIden
						+ "&dct=" + dct + "&stateInfo=" + stateInfo + "&pageSize=" + pageSize + "&pageNo=" + pageNo
						+ "&timeoutDetecFilter=" + timeoutDetecFilter;
			} else if ("3Droom".equals(pageType)) {
				/*url = "detectionWarning.do?action=queryAll&type=3Droom&police_emergent=" + police_emergent
						+ "&police_level=" + (police_level == null ? "" : police_level) + "&ip=" + ip + "&checkType=" + checkType
						+ "&pIden=" + pIden + "&dct=" + dct + "&stateInfo=" + stateInfo + "&pageSize=" + pageSize
						+ "&pageNo=" + pageNo + "&timeoutDetecFilter=" + timeoutDetecFilter;*/
				url = "detectionWarning.do?action=queryAll&type=3Droom&police_emergent=" + police_emergent
						+ "&police_level=" + (police_level == null ? "" : police_level) + "&ip=" + ip + "&ctn=" + ctn
						+ "&pIden=" + pIden + "&dct=" + dct + "&stateInfo=" + stateInfo + "&pageSize=" + pageSize
						+ "&pageNo=" + pageNo + "&timeoutDetecFilter=" + timeoutDetecFilter;
			}
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(url, getI18nText("i18n_DetectionWarningAction.emportCurrentXls.warningInfoTable_n81i"), detecWarningList, title, colu);
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		return null;
	}

	// 导出全部 程辉 2013-5-8新增
	public String emportAllXls() {
		try {
			// 0:服务器，1：网元，空为报警信息
			String type = this.getRequest().getParameter("type");
			this.getRequest().setAttribute("type", type);
			String levelAndEmergType = "";
			if ("0".equals(nodeType)) {// 服务器
				levelAndEmergType = Constants.MENU_CODE_SERVER_WARNING_INFO;
			} else if ("1".equals(nodeType)) {// 网元
				levelAndEmergType = Constants.MENU_CODE_NE_WARNING_INFO;
			} else if (Constants.WARN_TYPE_LEFT_WARN.equals(warnType)) {// 左下角报警
				levelAndEmergType = Constants.MENU_CODE_EMERGENT_WARNING_INFO;// 报警信息
			} else if (Constants.WARN_TYPE_WARN_MENU.equals(warnType)) {
				levelAndEmergType = Constants.MENU_CODE_ALL_WARNING_INFO;// 告警信息
			}
			StringBuffer sqlBuffer = getNewWarnInfoSql(levelAndEmergType, false);

			System.out.println("sqlBuffer:" + sqlBuffer.toString());
			List<Object[]> detectionWarningList1 = this.commonService.executeSQL(sqlBuffer.toString());
			List<DetectionInfoWarning> detecWarningList = new ArrayList<DetectionInfoWarning>();
			if (detectionWarningList1.size() > 0) {
				detecWarningList = this.getTimeColorIP(detectionWarningList1);
				detecWarningList = changeValue(detecWarningList);// 匹配故障库
			}
			for (int i = 0; i < detecWarningList.size(); i++) {
				if (detecWarningList.get(i).getCheckWay().equals("0")) {
					detecWarningList.get(i).setCheckWay(getI18nText("i18n_DetectionWarningAction.emportCurrentXls.active_n81i"));
				}
				if (detecWarningList.get(i).getCheckWay().equals("1")) {
					detecWarningList.get(i).setCheckWay(getI18nText("i18n_DetectionWarningAction.emportCurrentXls.passive_n81i"));
				}
			}

			String[] title = { getI18nText("i18n_DetectionWarningAction.emportCurrentXls.title.hostName_n81i"),
								getI18nText("i18n_DetectionWarningAction.emportCurrentXls.title.monitorType_n81i"), 
								getI18nText("i18n_DetectionWarningAction.emportCurrentXls.title.setName_n81i"), 
								getI18nText("i18n_DetectionWarningAction.emportCurrentXls.title.monitorWay_n81i"),
								getI18nText("i18n_DetectionWarningAction.emportCurrentXls.title.lastCheckTime_n81i"),
								getI18nText("i18n_DetectionWarningAction.emportCurrentXls.title.duration_n81i"), 
								getI18nText("i18n_DetectionWarningAction.emportCurrentXls.title.attempt_n81i"), 
								getI18nText("i18n_DetectionWarningAction.emportCurrentXls.title.alertLevel_n81i"),
								getI18nText("i18n_DetectionWarningAction.emportCurrentXls.title.performanceData_n81i") };

			String[] colu = { "nodeIp", "detectionSetInfo.checkTypeInfo.checkTypeName1",
					"detectionSetInfo.processIdenName", "checkWay", "dataCheckTime", "persistTime", "currentTimes",
					"policeLevel", "performaceData" };
			String pageType = this.getRequest().getParameter("pageType");
			String url = "";
			if ("queryAllConfigLevel".equals(pageType)) {
				/*url = "detectionWarning.do?action=queryAllConfigLevel&ip=" + ip + "&checkType=" + checkType + "&pIden=" + pIden
						+ "&dct=" + dct + "&stateInfo=" + stateInfo + "&pageSize=" + pageSize + "&pageNo=" + pageNo
						+ "&timeoutDetecFilter=" + timeoutDetecFilter;*/
				url = "detectionWarning.do?action=queryAllConfigLevel&ip=" + ip + "&ctn=" + ctn + "&pIden=" + pIden
						+ "&dct=" + dct + "&stateInfo=" + stateInfo + "&pageSize=" + pageSize + "&pageNo=" + pageNo
						+ "&timeoutDetecFilter=" + timeoutDetecFilter;
			} else if ("query".equals(pageType)) {
				/*url = "detectionWarning.do?action=query&police_emergent=" + police_emergent + "&police_level="
						+ (police_level == null ? "" : police_level) + "&ip=" + ip + "&checkType=" + checkType + "&pIden=" + pIden
						+ "&dct=" + dct + "&stateInfo=" + stateInfo + "&pageSize=" + pageSize + "&pageNo=" + pageNo
						+ "&timeoutDetecFilter=" + timeoutDetecFilter;*/
				url = "detectionWarning.do?action=query&police_emergent=" + police_emergent + "&police_level="
						+ (police_level == null ? "" : police_level) + "&ip=" + ip + "&ctn=" + ctn + "&pIden=" + pIden
						+ "&dct=" + dct + "&stateInfo=" + stateInfo + "&pageSize=" + pageSize + "&pageNo=" + pageNo
						+ "&timeoutDetecFilter=" + timeoutDetecFilter;
			} else if ("queryNE".equals(pageType)) {
				/*url = "detectionWarning.do?action=queryNE&police_emergent=" + police_emergent + "&police_level="
						+ (police_level == null ? "" : police_level) + "&ip=" + ip + "&checkType=" + checkType + "&pIden=" + pIden
						+ "&dct=" + dct + "&stateInfo=" + stateInfo + "&pageSize=" + pageSize + "&pageNo=" + pageNo
						+ "&timeoutDetecFilter=" + timeoutDetecFilter;*/
				url = "detectionWarning.do?action=queryNE&police_emergent=" + police_emergent + "&police_level="
						+ (police_level == null ? "" : police_level) + "&ip=" + ip + "&ctn=" + ctn + "&pIden=" + pIden
						+ "&dct=" + dct + "&stateInfo=" + stateInfo + "&pageSize=" + pageSize + "&pageNo=" + pageNo
						+ "&timeoutDetecFilter=" + timeoutDetecFilter;
			} else if ("3Droom".equals(pageType)) {
				/*url = "detectionWarning.do?action=queryAll&type=3Droom&police_emergent=" + police_emergent
						+ "&police_level=" + (police_level == null ? "" : police_level) + "&ip=" + ip + "&checkType=" + checkType
						+ "&pIden=" + pIden + "&dct=" + dct + "&stateInfo=" + stateInfo + "&pageSize=" + pageSize
						+ "&pageNo=" + pageNo + "&timeoutDetecFilter=" + timeoutDetecFilter;*/
				url = "detectionWarning.do?action=queryAll&type=3Droom&police_emergent=" + police_emergent
						+ "&police_level=" + (police_level == null ? "" : police_level) + "&ip=" + ip + "&ctn=" + ctn
						+ "&pIden=" + pIden + "&dct=" + dct + "&stateInfo=" + stateInfo + "&pageSize=" + pageSize
						+ "&pageNo=" + pageNo + "&timeoutDetecFilter=" + timeoutDetecFilter;
			}
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(url, getI18nText("i18n_DetectionWarningAction.emportCurrentXls.warningInfoTable_n81i"), detecWarningList, title, colu);
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		return null;
	}

	private StringBuffer getNewWarnInfoSql(String menuCode, boolean isDefaultNonEmerg) {
		String seqList = this.getRequest().getParameter("seqList");
		String type = this.getRequest().getParameter("type");
		/*
		 * sqlBuffer_test.
		 * append(" select LEV, id, ip, ctn, iden, cw, to_char(dctime,'yyyy-MM-dd HH24:mi:Ss') , ctime, pl, dsinfo,noticeInfo, "
		 * ); sqlBuffer_test.
		 * append("       to_char(stime,'yyyy-MM-dd HH24:mi:Ss'), dsiiId,ctiId, nodeSysType,nodeType,police_emergent, "
		 * ); sqlBuffer_test.
		 * append("       police_level, seqid,performacedate, ipn, dgid, did, dip  "
		 * ); sqlBuffer_test.append(" from ("); sqlBuffer_test.
		 * append("    select row_number() over (PARTITION BY newTable.ip,newTable.iden  order by newTable.dctime desc, newTable.ip) LEV, newTable.*"
		 * ); sqlBuffer_test.append("    FROM ("); // detecWarningList根据列索引解析数据,
		 * 新增查询字段必须在原查询字段后追加。 sqlBuffer_test.
		 * append(" select diw.id, dsi.node_ip dip, dsi.node_groups_id dgid, dsi.node_ips_id did, nt.node_ip ip, cti.check_type_name1 ctn, dsi.PROCESS_IDEN_NAME iden, "
		 * ); sqlBuffer_test.
		 * append(" dsi.CHECK_WAY cw,diw.data_check_time dctime,diw.current_times ctime,diw.POLICE_LEVEL pl, "
		 * ); sqlBuffer_test.
		 * append(" diw.DETECTION_STATE_INFO dsinfo,diw.NOTICE_INFO noticeInfo,diw.status_change_time stime,dsi.id dsiiId, "
		 * ); sqlBuffer_test.
		 * append(" cti.id ctiId,nt.node_system_type nodeSysType,nt.node_type nodeType,diw.police_emergent police_emergent, "
		 * ); sqlBuffer_test.
		 * append(" diw.police_level police_level,diw.seq_id seqid,diw.PERFORMACE_DATA performacedate,nt.ipn ipn "
		 * ); sqlBuffer_test.append(" from ( ");
		 * sqlBuffer_test.append("      select * from  detection_info_warning "
		 * ); sqlBuffer_test.append("      where valid=1   ");//查询异常列表时，
		 * 默认查询前n个小时的数据，否则查询速度很慢，目前默认查询前一个小时的数据 if (seqList != null &&
		 * !"".equals(seqList)){ sqlBuffer_test.append(" and SEQ_ID in(" +
		 * seqList + ")"); seqIdList = seqList; } else{ if (seqIdList != null &&
		 * !"".equals(seqIdList)){ sqlBuffer_test.append(" and SEQ_ID in(" +
		 * seqIdList + ")"); } } if (dct != null && !"".equals(dct)){
		 * sqlBuffer_test.append(" and data_check_time >= to_date('" + dct +
		 * "','yyyy-mm-dd')");
		 * sqlBuffer_test.append(" and data_check_time <= to_date('" + dct +
		 * " 23:59:59','yyyy-mm-dd HH24:mi:ss')"); } else {
		 * sqlBuffer_test.append(" and data_check_time >= (sysdate-"+Constants.
		 * DEFAULT_SEARCH_WARNINFO_HOUR+"/24) "); }
		 * sqlBuffer_test.append(" ) diw");
		 * sqlBuffer_test.append(" left join ("); sqlBuffer_test.
		 * append(" select * from  DETECTION_SET_INFO where  detection_set_state ='1'"
		 * ); if (pIden != null && !"".equals(pIden)){
		 * sqlBuffer_test.append(" and Upper(PROCESS_IDEN_NAME) like '%" +
		 * pIden.trim().toUpperCase() + "%'"); } // 如果是admin登陆则无限制 if
		 * (!this.getAdminMark()){
		 * sqlBuffer_test.append(" and (( view_level=1 and create_user_id=");
		 * sqlBuffer_test.append(this.getUserID());
		 * sqlBuffer_test.append(" and system_Id =" + this.getSystemID() + ")");
		 * sqlBuffer_test.
		 * append(" or ( view_level=2 and create_usergroup_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='"
		 * ); sqlBuffer_test.append(this.getUser().getYhbh());
		 * sqlBuffer_test.append("' and x.type = 1) and system_Id = " +
		 * this.getSystemID() + ") or (view_level=3 and system_id = " +
		 * this.getSystemID() + ")");
		 * sqlBuffer_test.append(" or (view_level=4 ))"); }
		 * sqlBuffer_test.append(" )dsi on diw.detection_set_info_id = dsi.id "
		 * ); sqlBuffer_test.append(" left join " ); sqlBuffer_test.
		 * append("( select * from check_type_info where crete_state=0 " ); if
		 * (ctn != null && !"".equals(ctn)){
		 * sqlBuffer_test.append(" and Upper(Check_Type_Name1) like '%" +
		 * ctn.toUpperCase() + "%'"); }
		 * sqlBuffer_test.append(")cti on dsi.check_type_id = cti.id ");
		 * sqlBuffer_test.append(" left join (" ); sqlBuffer_test.
		 * append(" select distinct node_ip,ipn,seq_id,node_system_type,node_type,node_state,system_id "
		 * ); sqlBuffer_test.append(" from  NODE_TABLE  "); sqlBuffer_test.
		 * append(" where node_ip is not null  and node_state = 0 "); if (ip !=
		 * null && !"".equals(ip)){ sqlBuffer_test.append(" and node_ip like '%"
		 * + ip.trim() + "%'"); } if (!StringUtils.isBlank(nodeType)) {
		 * sqlBuffer_test.append(" AND node_type =" + nodeType); } if
		 * (!this.getAdminMark()){
		 * sqlBuffer_test.append(" and system_id = ");
		 * sqlBuffer_test.append(this.getSystemID()); }
		 * sqlBuffer_test.append(" ) nt on diw.seq_id = nt.seq_id ");
		 * sqlBuffer_test.append("    ) newTable ");
		 * sqlBuffer_test.append(") WHERE "); //查询条件过滤 -- 过滤掉没有配置的节点或节点组
		 * sqlBuffer_test.
		 * append(" ((did is not null and dgid is not null and ip in ");
		 * sqlBuffer_test.
		 * append(" (select regexp_substr (dip,'[^,]+',1,rownum) from dual connect by rownum <= length(dip) - length(replace(dip,',',''))+1)) "
		 * ); sqlBuffer_test.
		 * append(" or (did is null and dgid is not null and ip in ");
		 * sqlBuffer_test.
		 * append(" (select node_ip from node_table where node_group_id in (select regexp_substr (dgid,'[^,]+',1,rownum) from dual connect by rownum <= length(dgid) - length(replace(dgid,',',''))+1)))"
		 * ); sqlBuffer_test.append(" or (did is null and dgid is null)) ");
		 * sqlBuffer_test.
		 * append(" and police_level !=99 and dsiiId is not null and ctiId is not null and ip is not null "
		 * ); //查询条件过滤 -- 性能信息 if (StringUtils.isNotBlank(stateInfo)) {
		 * sqlBuffer_test.append(" and performacedate like '%"+stateInfo+"%'");
		 * } //查询条件过滤 -- 状态信息，过滤超周期信息（超过%监测周期，未接收到监测结果信息） if
		 * (!"false".equals(timeoutDetecFilter)) { String desinfo =
		 * Constants.DETECT_TIMEOUT_ALARMINFO.replace(" %d ", "%");
		 * sqlBuffer_test.
		 * append(" and (performacedate is null or performacedate not like '" +
		 * desinfo + "') "); } //2013-12-26 hyx
		 * 根据不同的异常列表，得到配置的列表过滤条件------------begin //0:服务器，1：网元，空为报警信息
		 * 
		 * this.getRequest().setAttribute("type",type); if("0".equals(nodeType))
		 * {//服务器
		 * getConfOfDetecLevelAndEmerg(Constants.MENU_CODE_SERVER_WARNING_INFO);
		 * }else if("1".equals(nodeType)) {//网元
		 * getConfOfDetecLevelAndEmerg(Constants.MENU_CODE_NE_WARNING_INFO);
		 * }else if("3Droom".equals(type)){
		 * getConfOfDetecLevelAndEmerg(Constants.MENU_CODE_3DROOM_WARNING_INFO);
		 * }else if(StringUtils.isBlank(nodeType)){
		 * getConfOfDetecLevelAndEmerg(menuCode);//报警信息 }
		 * 
		 * //是否紧急及非紧急级别的条件
		 * sqlBuffer_test.append(getIsEmergeAndLevelCon(isDefaultNonEmerg));
		 * sqlBuffer_test.append(" AND LEV =1 ");
		 * 
		 * //2013-12-26 hyx 根据不同的异常列表，得到配置的列表过滤条件------------end
		 * sqlBuffer_test.append(getOrderStr());
		 */
		// @2018年4月17日18:00:30 分析梳理原sql，重写
		String temp = "select diw.id,\n" + "       dsi.node_ip              dip,\n"
				+ "       dsi.node_groups_id       dgid,\n" + "       dsi.node_ips_id          did,\n"
				+ "       nt.node_ip               ip,\n" + "       cti.check_type_name1     ctn,\n"
				+ "       dsi.PROCESS_IDEN_NAME    iden,\n" + "       dsi.CHECK_WAY            cw,\n"
				+ "       diw.data_check_time      dctime,\n" + "       diw.current_times        ctime,\n"
				+ "       diw.POLICE_LEVEL         pl,\n" + "       diw.DETECTION_STATE_INFO dsinfo,\n"
				+ "       diw.NOTICE_INFO          noticeInfo,\n" + "       diw.status_change_time   stime,\n"
				+ "       dsi.id                   dsiiId,\n" + "       cti.id                   ctiId,\n"
				+ "       nt.node_system_type      nodeSysType,\n" + "       nt.node_type             nodeType,\n"
				+ "       diw.police_emergent      police_emergent,\n"
				+ "       diw.police_level         police_level,\n" + "       diw.seq_id               seqid,\n"
				+ "       diw.PERFORMACE_DATA      performacedate,\n" + "       nt.ipn                   ipn\n"
				+ "  from (select seq_id, detection_set_info_id, max(data_check_time) dct\n"
				+ "          from detection_info_warning\n" + "         where valid = 1\n"
				+ "           and data_check_time >= (sysdate - 2/24)\n"
				+ "         group by seq_id, detection_set_info_id) dnew\n" + "  left join detection_info_warning diw\n"
				+ "    on dnew.seq_id = diw.seq_id\n"
				+ "   and dnew.detection_set_info_id = diw.detection_set_info_id\n"
				+ "   and dnew.dct = diw.data_check_time\n" + "  left join DETECTION_SET_INFO dsi\n"
				+ "    on diw.detection_set_info_id = dsi.id\n" + "  left join check_type_info cti\n"
				+ "    on dsi.check_type_id = cti.id\n" + "  left join NODE_TABLE nt\n"
				+ "    on diw.seq_id = nt.seq_id\n" + " where diw.valid = 1\n"
				+ "   and dsi.detection_set_state = '1'\n" + "   and cti.crete_state = 0\n"
				+ "   and nt.node_ip is not null\n" + "   and nt.node_state = 0";
		StringBuffer sbNewSql = new StringBuffer();
		sbNewSql.append("select 1 LEV,id,ip,ctn, iden, cw, to_char(dctime, 'yyyy-MM-dd HH24:mi:Ss'), ctime, pl,dsinfo,noticeInfo, to_char(stime, 'yyyy-MM-dd HH24:mi:Ss'),dsiiId, ctiId, nodeSysType,nodeType,police_emergent, police_level, seqid, performacedate,ipn,dgid,did, dip from ( ");
		sbNewSql.append(temp);
		if (pIden != null && !"".equals(pIden)) {
			sbNewSql.append(" and Upper(dsi.PROCESS_IDEN_NAME) like '%" + pIden.trim().toUpperCase() + "%'");
		}

		// 如果是admin登陆则无限制
		if (!this.getAdminMark()) {
			sbNewSql.append(" and (( dsi.view_level=1 and dsi.create_user_id=");
			sbNewSql.append(this.getUserID());
			sbNewSql.append(" and dsi.system_Id =" + this.getSystemID() + ")");
			sbNewSql.append(" or ( dsi.view_level=2 and dsi.create_usergroup_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
			sbNewSql.append(this.getUser().getYhbh());
			sbNewSql.append("' and x.type = 1) and dsi.system_Id = " + this.getSystemID()
					+ ") or (dsi.view_level=3 and dsi.system_id = " + this.getSystemID() + ")");
			sbNewSql.append(" or (dsi.view_level=4 ))");
		}

		if (ip != null && !"".equals(ip)) {
			sbNewSql.append(" and nt.node_ip like '%" + ip.trim() + "%'");
		}
		if (!StringUtils.isBlank(nodeType)) {
			sbNewSql.append(" AND nt.node_type =" + nodeType);
		}
		if (!this.getAdminMark()) {
			sbNewSql.append(" and nt.system_id = ");
			sbNewSql.append(this.getSystemID());
		}

/*		if (ctn != null && !"".equals(ctn)) {
			sbNewSql.append(" and Upper(cti.Check_Type_Name1) like '%" + ctn.toUpperCase() + "%'");
		}*/

		if(checkType != null && checkType != -1) {
			sbNewSql.append(" and cti.id=" + checkType);
		}
		
		if (dct != null && !"".equals(dct)) {
			sbNewSql.append(" and diw.data_check_time >= to_date('" + dct + "','yyyy-mm-dd')");
			sbNewSql.append(" and diw.data_check_time <= to_date('" + dct + " 23:59:59','yyyy-mm-dd HH24:mi:ss')");
		} else {
			sbNewSql.append(" and diw.data_check_time >= (sysdate-" + Constants.DEFAULT_SEARCH_WARNINFO_HOUR + "/24) ");
		}

		if (seqList != null && !"".equals(seqList)) {
//			sbNewSql.append(" and diw.SEQ_ID exists (" + seqList + ")");
			sbNewSql.append(" and diw.SEQ_ID in (" + seqList + ")");
			seqIdList = seqList;
		} else {
			if (seqIdList != null && !"".equals(seqIdList)) {
//				sbNewSql.append(" and diw.SEQ_ID exists (" + seqIdList + ")");
				sbNewSql.append(" and diw.SEQ_ID in (" + seqIdList + ")");
			}
		}
		sbNewSql.append(" ) newTable where ");
		// 查询条件过滤 -- 过滤掉没有配置的节点或节点组
		sbNewSql.append(" ((did is not null and dgid is not null and ");
		if (Constant.IS_MYSQL) {
			sbNewSql.append(" find_in_set(ip,dip) > 0 )");
			sbNewSql.append(" or (did is null and dgid is not null and ");
			sbNewSql.append(" ip in  (select node_ip from node_table where find_in_set(node_group_id,dgid) > 0 ))");
		} else {
			sbNewSql.append(" ip in  (select regexp_substr (dip,'[^,]+',1,rownum) from dual connect by rownum <= length(dip) - length(replace(dip,',',''))+1)) ");
			sbNewSql.append(" or (did is null and dgid is not null and ");
			sbNewSql.append(" ip in  (select node_ip from node_table where node_group_id in (select regexp_substr (dgid,'[^,]+',1,rownum) from dual connect by rownum <= length(dgid) - length(replace(dgid,',',''))+1)))");
		}
		sbNewSql.append(" or (did is null and dgid is null)) ");
		sbNewSql.append(" and police_level !=99 and dsiiId is not null and ctiId is not null and ip is not null ");
		// 查询条件过滤 -- 性能信息
		if (StringUtils.isNotBlank(stateInfo)) {
			sbNewSql.append(" and performacedate like '%" + stateInfo + "%'");
		}
		// 查询条件过滤 -- 状态信息，过滤超周期信息（超过%监测周期，未接收到监测结果信息）
		if (!"false".equals(timeoutDetecFilter)) {
			String desinfo = Constants.DETECT_TIMEOUT_ALARMINFO.replace(" %d ", "%");
			sbNewSql.append(" and (performacedate is null or performacedate not like '" + desinfo + "') ");
		}
		// 2013-12-26 hyx 根据不同的异常列表，得到配置的列表过滤条件------------begin
		// 0:服务器，1：网元，空为报警信息
		this.getRequest().setAttribute("type", type);
		if ("0".equals(nodeType)) {// 服务器
			getConfOfDetecLevelAndEmerg(Constants.MENU_CODE_SERVER_WARNING_INFO);
		} else if ("1".equals(nodeType)) {// 网元
			getConfOfDetecLevelAndEmerg(Constants.MENU_CODE_NE_WARNING_INFO);
		} else if ("3Droom".equals(type)) {
			getConfOfDetecLevelAndEmerg(Constants.MENU_CODE_3DROOM_WARNING_INFO);
		} else if (StringUtils.isBlank(nodeType)) {
			getConfOfDetecLevelAndEmerg(menuCode);// 报警信息
		}
		// 是否紧急及非紧急级别的条件
		sbNewSql.append(getIsEmergeAndLevelCon(isDefaultNonEmerg));
		//不同节点组配置同一ip导致seq_id相同，多次查询出同一告警信息
		sbNewSql.append(" group by id");
		// 2013-12-26 hyx 根据不同的异常列表，得到配置的列表过滤条件------------end
		sbNewSql.append(getOrderStr());
		System.out.println("getNewWarnInfoSql --> " + sbNewSql);
		return sbNewSql;
	}

	public void queryDetecWarningInfo() {
		long start1 = System.currentTimeMillis();
		if (mypageNo > 0 && mypageSize > 0) {
			pageNo = mypageNo;
			pageSize = mypageSize;
		}
		String parmString = "";
		try {
			// 0:服务器，1：网元，空为报警信息
			String type = this.getRequest().getParameter("type");
			this.getRequest().setAttribute("type", type);
			String levelAndEmergType = "";
			if ("0".equals(nodeType)) {// 服务器
				levelAndEmergType = Constants.MENU_CODE_SERVER_WARNING_INFO;
				
			} else if ("1".equals(nodeType)) {// 网元
				levelAndEmergType = Constants.MENU_CODE_NE_WARNING_INFO;
				
			} else if ("3Droom".equals(type)) {
				levelAndEmergType = Constants.MENU_CODE_3DROOM_WARNING_INFO;
			} else if (StringUtils.isBlank(nodeType)) {
				levelAndEmergType = Constants.MENU_CODE_EMERGENT_WARNING_INFO;// 报警信息
			}

			StringBuffer sqlBuffer = getNewWarnInfoSql(levelAndEmergType, true);
			logger.info("warnlist-sql:" + sqlBuffer.toString());
			page = this.commonService.findByPageForSql(sqlBuffer.toString(), pageNo, pageSize, null);
			List<Object[]> detectionWarningList1; // 最新状态信息集合
			detectionWarningList1 = (List<Object[]>) page.getResult();
			if (detectionWarningList1.size() > 0) {
				detecWarningList = this.getTimeColorIP(detectionWarningList1);
				detecWarningList = changeValue(detecWarningList);// 匹配故障库
				if ("3Droom".equals(type)) {// 从3d机房进入
					if (!StringUtil.isBlank(nodeIp)) {
						ip = detecWarningList.get(0).getNodeIp();
					}
				}
			}
			
//			getConfOfDetecLevelAndEmerg(levelAndEmergType);
		} catch (Exception e) {
			logger.error("Query Exception List Exception", e);
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_DetectionWarningAction.emportCurrentXls.faild_n81i');this.location='detectionWarning.do?action=query'"
							+ parmString + "</script>");
			return;
		}
	}

	/**
	 * 
	 * 查询配置的级别的紧急的告警信息：配置的级别+紧急
	 * 
	 * @author Administrator Oct 17, 2013
	 * @version 1.0
	 * @return
	 */
	public void queryConfLevelDetecWarningInfo() {
		if (mypageNo > 0 && mypageSize > 0) {
			pageNo = mypageNo;
			pageSize = mypageSize;
		}
		String parmString = "";
		try {
			StringBuffer sqlBuffer = getNewWarnInfoSql(Constants.MENU_CODE_ALL_WARNING_INFO, false);
			System.out.println("sqlBuffer:" + sqlBuffer.toString());
			page = this.commonService.findByPageForSql(sqlBuffer.toString(), pageNo, pageSize, null);
			List<Object[]> detectionWarningList1; // 最新状态信息集合
			detectionWarningList1 = (List<Object[]>) page.getResult();
			if (detectionWarningList1.size() > 0) {
				detecWarningList = this.getTimeColorIP(detectionWarningList1);
				detecWarningList = changeValue(detecWarningList);// 匹配故障库
			}
			//getConfOfDetecLevelAndEmerg(Constants.MENU_CODE_ALL_WARNING_INFO);
		} catch (Exception e) {
			logger.error("Query Alarm List Exception", e);
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_DetectionWarningAction.emportCurrentXls.faild_n81i');this.location='detectionWarning.do?action=query'"
							+ parmString + "</script>");
			return;
		}
	}

	private String getConfShowDetecLevel() {
		// 参数配置：可配置告警信息显示哪些级别的告警,默认只显示1级的告警
		String setPoleceLevel = "";
		try {
			String sql = "select * from option_table t where lower(t.TYPE_IDENTITY) = lower('"
					+ Constants.DETEC_WARNING_LEVEL_FLAG + "') and type_state=0";// 查询启用的级别
			optionList = this.commonService.executeSQL(sql, OptionTable.class);
			if (optionList != null && optionList.size() > 0) {
				String levelTmp = "";
				for (OptionTable opt : optionList) {
					levelTmp = opt.getTypeCode() == null ? "" : opt.getTypeCode().trim();
					if (levelTmp.replaceAll("[0-9]", "").length() == 0) {// 如果是数字，则组合
						setPoleceLevel = setPoleceLevel + levelTmp + ",";
					}
				}
				if (setPoleceLevel.endsWith(",")) {
					setPoleceLevel = setPoleceLevel.substring(0, setPoleceLevel.length() - 1);
				}
			} else {
				setPoleceLevel = "1";
			}
		} catch (Exception e) {
			logger.error("Getting alarm information list display alarm level exception", e);
		}
		return setPoleceLevel;
	}

	// 监测过滤配置：可配置告警信息、异常服务器、异常网元（业务逻辑拓扑、报警信息？）菜单显示的异常监测信息的紧急程度、告警级别
	private void getConfOfDetecLevelAndEmerg(String menuCode) {
		try {
			levelSetList.clear();
			String sql = "select * from set_det_data_con t where lower(t.MENU_CODE) = lower('" + menuCode + "')";
			List<SetDetDataCon> setList = this.commonService.executeSQL(sql, SetDetDataCon.class);

			if (setList != null && setList.size() > 0) {
				detecSet = setList.get(0);

				emergentSetStr = detecSet.getPoliceEmergent();// 配置的紧急状态

				levelSetStr = detecSet.getPoliceLevel();// 配置的级别条件
				if (StringUtils.isNotBlank(levelSetStr)) {
					String[] levelArray = levelSetStr.split(",");
					for (String level : levelArray) {
						if (StringUtils.isNotBlank(level)) {
							levelSetList.add(level);
						}
					}
				} else if (StringUtils.isBlank(emergentSetStr) || emergentSetStr.contains(",1,")) {// 未选择级别，选择了非紧急(空、只选非紧急、全选)，，则级别为全部的
					for (int i = 1; i <= 5; i++) {
						levelSetList.add(i + "");
					}
				}

			}
		} catch (Exception e) {
			logger.error("Get exception monitoring list filter configuration exception", e);
		}
	}

	public String queryDetecWarningInfoChild() {
		String parmString = "";
		try {
			String type = this.getRequest().getParameter("type");
			this.getRequest().setAttribute("type", type);
			String levelAndEmergType = "";
			if ("0".equals(nodeType)) {// 服务器
				levelAndEmergType = Constants.MENU_CODE_SERVER_WARNING_INFO;
			} else if ("1".equals(nodeType)) {// 网元
				levelAndEmergType = Constants.MENU_CODE_NE_WARNING_INFO;
			} else if ("3Droom".equals(type)) {
				levelAndEmergType = Constants.MENU_CODE_3DROOM_WARNING_INFO;
			} else if (StringUtils.isBlank(nodeType)) {
				levelAndEmergType = Constants.MENU_CODE_EMERGENT_WARNING_INFO;// 报警信息
			}

			StringBuffer sqlBuffer = getNewWarnInfoSql(levelAndEmergType, true);
			page = this.commonService.findByPageForSql(sqlBuffer.toString(), pageNo, pageSize, null);
			List<Object[]> detectionWarningList1; // 最新状态信息集合
			detectionWarningList1 = (List<Object[]>) page.getResult();
			if (detectionWarningList1.size() > 0) {
				detecWarningList = this.getTimeColorIP(detectionWarningList1);
				detecWarningList = changeValue(detecWarningList);// 匹配故障库
			}

		} catch (Exception e) {
			logger.error("Query exception list exception", e);
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_DetectionWarningAction.emportCurrentXls.faild_n81i');this.location='detectionWarning.do?action=query'"
							+ parmString + "</script>");
			return null;
		}

		return "queryDetecWarningInfoChild";

	}

	public String queryConfLevelDetecWarningInfoChild() {
		String parmString = "";
		try {
			StringBuffer sqlBuffer = getNewWarnInfoSql(Constants.MENU_CODE_ALL_WARNING_INFO, false);
			System.out.println("sqlBuffer:" + sqlBuffer.toString());
			page = this.commonService.findByPageForSql(sqlBuffer.toString(), pageNo, pageSize, null);
			List<Object[]> detectionWarningList1; // 最新状态信息集合
			detectionWarningList1 = (List<Object[]>) page.getResult();
			if (detectionWarningList1.size() > 0) {
				detecWarningList = this.getTimeColorIP(detectionWarningList1);
				detecWarningList = changeValue(detecWarningList);// 匹配故障库
			}

		} catch (Exception e) {
			logger.error("Query alarm list exception", e);
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_DetectionWarningAction.emportCurrentXls.faild_n81i');this.location='detectionWarning.do?action=query'"
							+ parmString + "</script>");
			return null;
		}

		return "queryConfLevelDetecWarningInfoChild";

	}

	public List<DetectionInfoWarning> changeValue(List<DetectionInfoWarning> list) throws Exception {
		try {
			Map<Long, Map<Long, String>> maps = (Map<Long, Map<Long, String>>) this.getRequest().getSession()
					.getServletContext().getAttribute("troubles");
			if (maps != null && maps.size() > 0) {
				if (maps.containsKey(this.getSystemID())) {// 判断系统id
					Map<Long, String> mapCode = maps.get(this.getSystemID());// key:
					// code
					// value:
					// desc
					Set<Long> keys = mapCode.keySet();
					for (int j = 0; j < list.size(); j++) {
						for (Iterator it = keys.iterator(); it.hasNext();) {
							if (list.get(j).getDetectionStateInfo() != null
									&& !"".equals(list.get(j).getDetectionStateInfo())) {
								if (it.next().toString().equals(list.get(j).getDetectionStateInfo())) {
									list.get(j).setDetectionStateInfo(mapCode.get(it.next()));
									break;
								}
							} else {
								list.get(j).setDetectionStateInfo("");
								break;
							}
						}
					}
				}
			}
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		return list;
	}

	private void queryCheckTypeInfo() throws Exception {
		try {
			/*
			 * String hql = "";
			 * if(this.getAdminMark()){//如果是admin登陆则无限制 hql
			 * = "from CheckTypeInfo where 1=1 and isSchedule<>2"; }else{
			 * //权限控制--------begin String sqlparam = " or (t.viewLevel=4 )" ;
			 * hql = "from CheckTypeInfo t where 1=1 and isSchedule<>2 and ((
			 * t.viewLevel=1 and t.userId="+ this.getUserID()+ ")" + " or (
			 * t.viewLevel=2 and t.groupId in (select x.jsbh from XtYhJsIndex x
			 * where x.yhbh='" + this.getUser().getYhbh() + "' and x.type = 1))
			 * or (t.viewLevel=3 and t.systemId = "+this.getSystemID()+")" +
			 * sqlparam + ") "; //----------------end } hql +=" and creteState =
			 * 0 order by isSchedule asc , createTime asc";
			 * 
			 * allCheckTypeInfo = this.commonService.find(hql);
			 */
			StringBuffer hql = new StringBuffer();
			if (this.getAdminMark()) {// 如果是admin登陆则无限制
				hql.append("from CheckTypeInfo where isSchedule<>2");
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
			// hql.append(" and creteState = 0 order by isSchedule asc ,
			// createTime asc");
			hql.append(
					" and creteState = 0 order by decode(isSchedule,0,0,2,0,1,1,2) asc ,decode(isSnmp,2,0,null,0,1) asc, ID asc");
			allCheckTypeInfo = this.commonService.find(hql.toString());
		} catch (Exception e) {
			logger.error("Query monitoring category information exception", e);
		}
	}

	public String detailDetecWarningInfo() {
		String type = this.getRequest().getParameter("type");
		this.getRequest().setAttribute("type", type);
		String findFiledSql = "";
		String filedComm = "";
		Map map = new HashMap();
		try {
			if (ids != null && ids.length > 0) {
				List list = this.commonService.find("from DetectionInfoWarning where id=?", ids[0]);
				if (list != null && list.size() > 0) {
					detectionWarningInfo = (DetectionInfoWarning) list.get(0);
					// detectionWarningInfo.setCheckWay(detectionWarningInfo.getDetectionSetInfo().getCheckWay());
				}

				Long seqIdLong = detectionWarningInfo.getSeqId();
				String ipSql = "select distinct nt.node_ip from node_table nt where nt.seq_id = " + seqIdLong;
				List ipList = this.commonService.executeSQL(ipSql);
				if (ipList != null && ipList.size() > 0) {
					nodeIp = ipList.get(0).toString();
				}

				CheckTypeInfo cti = (CheckTypeInfo) this.commonService.get(CheckTypeInfo.class,
						detectionWarningInfo.getDetectionSetInfo().getCheckTypeInfo().getId());
				List mList = this.commonService.find("from Metadata where checkTypeInfo.id=?", cti.getId());
				if (mList != null && mList.size() > 0) {
					for (int j = 0; j < mList.size(); j++) {
						Metadata metadata = (Metadata) mList.get(j);
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
						md.setFiledComments(getI18nText("i18n_DetectionWarningAction.emportCurrentXls.state_n81i"));
						mList.add(md);
						findFiledSql += ",decode(detectioned_state,1,'"+getI18nText("i18n_DetectionWarningAction.emportCurrentXls.normal_n81i")+"',0,'"+getI18nText("i18n_DetectionWarningAction.emportCurrentXls.exception_n81i")+"',-1,'"+getI18nText("i18n_DetectionWarningAction.emportCurrentXls.doFaild_n81i")+"','') detectioned_state";
					}
					if (StringUtils.isNotBlank(filedComm)) {
						filedComm += ","+getI18nText("i18n_DetectionWarningAction.emportCurrentXls.state_n81i");
					}
				}
				String tableName = cti.getTableName();
				/*
				 * String sql2 =
				 * "SELECT COUNT(*) from user_tables where table_name = '" +
				 * tableName + "'"; List list2 =
				 * this.commonService.executeSQL(sql2); int num2 =
				 * Integer.parseInt(list2.get(0).toString());
				 */
				// @2018-3-8 11:22:10 mysql适配
				int num2 = this.commonService.isTableExist(tableName);
				if (num2 > 0) {
					String serchSql = "select " + findFiledSql + " from " + tableName + " t where t.detection_info_id="
							+ detectionWarningInfo.getDetectionInfoId();
					List listInfo = this.commonService.executeSQL(serchSql);
					if (listInfo != null && listInfo.size() > 0) {
						Object[] resu = (Object[]) listInfo.get(0);
						String[] filedCommArr = filedComm.split(",");
						if (resu != null && filedCommArr != null && resu.length == filedCommArr.length) {
							for (int k = 0; k < resu.length; k++) {
								map.put(filedCommArr[k], resu[k] == null ? "" : resu[k].toString());
							}
						}
					}
				}

				List policeList = this.commonService.find("from DataPoliceRelation where detectionSetInfo.id=?",
						detectionWarningInfo.getDetectionSetInfo().getId());
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

						if (map.containsKey(keyString)) {
							if (map.get(keyString) != null && !"".equals(map.get(keyString))
									&& dpr.getPoliceValue() != null && !"".equals(dpr.getPoliceValue())) {
								Float num = new Float(0.0);
								try {
									num = Float.parseFloat(map.get(keyString).toString())
											- Float.parseFloat(String.valueOf(dpr.getPoliceValue()));

								} catch (Exception e) {
									logger.error("", e);
								}
								if (num > 0) {
									map.put(keyString, map.get(keyString)
											+ "&nbsp&nbsp&nbsp&nbsp<font color='#FF0000'>i18n_DetectionWarningAction.emportCurrentXls.outWarningValue_n81i" + num + "</font>");
								}
							} else {
								map.put(keyString, "&nbsp;");
							}
						}
					}
				}

				this.getRequest().setAttribute("infoMap", map);
			}
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			String parmString = "";
			if (police_level != null && !"".equals(police_level)) {
				parmString = "&police_level=" + police_level;
			}
			outHtmlString(
					"<script type=\"text/javascript\">alert('i18n_DetectionWarningAction.emportCurrentXls.faild_n81i');this.location='detectionWarning.do?action=query'"
							+ parmString + "</script>");
		}

		return "detailWarningInfo";
	}

	public List<List> getNodeIpGroupList() throws Exception {
		List<List> detecWarningGroupList = new ArrayList<List>();
		String nip1 = "";
		String nip2 = "";
		for (int i = 0; i < detecWarningList.size(); i++) {
			List<DetectionInfoWarning> listSoNews = new ArrayList<DetectionInfoWarning>();
			for (int j = i; j < detecWarningList.size(); j++) {
				nip1 = detecWarningList.get(i).getNodeIp();
				nip2 = detecWarningList.get(j).getNodeIp();
				if (nip1 == null)
					nip1 = "";
				if (nip2 == null)
					nip2 = "";
				if (nip1.equals(nip2)) {
					listSoNews.add(detecWarningList.get(j));
					i = j;
				} else {
					i = j - 1;
					break;
				}
			}
			detecWarningGroupList.add(listSoNews);
		}

		return detecWarningGroupList;
	}

	// 得到持续时间,bgColor,IP
	public List<DetectionInfoWarning> getTimeColorIP(List<Object[]> detectionWarningList) throws Exception {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date datacheckTime = null;
		Date status_change_time = null;
		List<DetectionInfoWarning> resuList = new ArrayList<DetectionInfoWarning>();
		for (int i = 0; i < detectionWarningList.size(); i++) {
			// 警告颜色
			String bgcolor = "";
			// switch
			// (Integer.parseInt(detectionWarningList.get(i)[7].toString())) {
			switch (Integer.parseInt(detectionWarningList.get(i)[8].toString())) {
			case 0:// 红
				bgcolor = "#FF0000";
				break;
			case 1:// 浅 红 FF00FF FF6347
				bgcolor = "#FF6EB4";
				break;
			case 2:// 橙
				bgcolor = "#FF8000";
				break;
			case 3:// 黄
				bgcolor = "#A6A600";
				break;
			case 4:// 青
				bgcolor = "#00AEAE";
				break;
			case 5:// 蓝
				bgcolor = "#0000FF";
				break;
			case 99:// 绿
				bgcolor = "#008000";
				break;
			default:
				bgcolor = "";
				break;
			}
			// set持续时间
			StringBuffer dateStr = new StringBuffer();
			if (detectionWarningList.get(i)[6] != null// 5
					&& detectionWarningList.get(i)[11] != null) {// 10
				datacheckTime = simpleDateFormat.parse(detectionWarningList.get(i)[6].toString());// 5
				status_change_time = simpleDateFormat.parse(detectionWarningList.get(i)[11].toString());// 10
				if (datacheckTime.getTime() - status_change_time.getTime() > 0) {
					long l = datacheckTime.getTime() - status_change_time.getTime();
					long day = l / (24 * 60 * 60 * 1000);
					long hour = (l / (60 * 60 * 1000) - day * 24);
					long min = ((l / (60 * 1000)) - day * 24 * 60 - hour * 60);
					long s = (l / 1000 - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60);

					if (day != 0) {
						dateStr.append(day+ " "+ getI18nText("i18n_DetectionWarningAction.emportCurrentXls.day_n81i")+ " ");
					}
					if (hour != 0) {
						dateStr.append(hour+ " " + getI18nText("i18n_DetectionWarningAction.emportCurrentXls.hour_n81i")+ " ");
					}
					if (min != 0) {
						dateStr.append(min + " "+ getI18nText("i18n_DetectionWarningAction.emportCurrentXls.minute_n81i")+ " ");
					}
					if (s != 0) {
						dateStr.append(s + " "+ getI18nText("i18n_DetectionWarningAction.emportCurrentXls.second_n81i")+ " ");
					}
				}
			} else {
				dateStr.append("");
			}
			DetectionInfoWarning diw = new DetectionInfoWarning(
					Long.parseLong(
							detectionWarningList.get(i)[1] == null ? "0" : detectionWarningList.get(i)[1].toString()),
					(DetectionSetInfo) this.commonService.get(DetectionSetInfo.class,
							Long.parseLong(detectionWarningList.get(i)[12].toString())),
					detectionWarningList.get(i)[5] == null ? "" : detectionWarningList.get(i)[5].toString(),
					detectionWarningList.get(i)[9] == null ? "" : detectionWarningList.get(i)[9].toString(),
					Long.parseLong(detectionWarningList.get(i)[7] == null ? "0"
							: detectionWarningList.get(i)[7].toString()),
					detectionWarningList.get(i)[11] == null ? null
							: simpleDateFormat.parse(detectionWarningList.get(i)[11].toString()),
					Long.parseLong(
							detectionWarningList.get(i)[8] == null ? "0" : detectionWarningList.get(i)[8].toString()),
					detectionWarningList.get(i)[6] == null ? null
							: simpleDateFormat.parse(detectionWarningList.get(i)[6].toString()),
					detectionWarningList.get(i)[10] == null ? "" : detectionWarningList.get(i)[10].toString(), bgcolor,
					dateStr.toString(),
					detectionWarningList.get(i)[2] == null ? "" : detectionWarningList.get(i)[2].toString(),
					Long.parseLong(detectionWarningList.get(i)[18] == null ? "0"
							: detectionWarningList.get(i)[18].toString()),
					detectionWarningList.get(i)[14] == null ? "" : detectionWarningList.get(i)[14].toString().trim(),
					detectionWarningList.get(i)[15] == null ? "" : detectionWarningList.get(i)[15].toString().trim(),
					detectionWarningList.get(i)[19] == null ? "" : detectionWarningList.get(i)[19].toString().trim());

			resuList.add(diw);
		}
		return resuList;
	}

	/**
	 * 获取警告提醒消息，此方法为AJAX异步调用 暂时获取今天的警报信息
	 */
	public String getAlarmMessages() throws Exception {
		List<Object[]> list = null;
		int sysWarnSize = 0;
		try {
			StringBuffer sqlBuffer = new StringBuffer();
			sqlBuffer.append(
					"select count(*) from nms_error_info t where t.error_state=1  and (t.error_code,t.errort_ip,t.errort_getip,t.error_time) in (select t.error_code,t.errort_ip,t.errort_getip,max(t.error_time) from nms_error_info t group by t.error_code,t.errort_ip,t.errort_getip) ");
			List<Object> objsList = this.commonService.executeSQL(sqlBuffer.toString());
			if (objsList != null && objsList.size() > 0) {
				sysWarnSize = objsList.get(0) == null ? 0 : Integer.valueOf(objsList.get(0).toString());
				/*
				 * BigDecimal decimal = (BigDecimal) objsList.get(0);
				 * sysWarnSize = decimal == null ? 0 : decimal.intValue();
				 */
			}
			list = null;
		} catch (Exception e) {
			e.printStackTrace();
		}

		try {
			// 获取警报统计信息
			StringBuffer sqlBuffer = new StringBuffer();

			sqlBuffer.append("select pl,count(pl),police_emergent from (");
			sqlBuffer.append(getNewWarnInfoSql(Constants.MENU_CODE_EMERGENT_WARNING_INFO, true));
			sqlBuffer.append(") tempTable");

			sqlBuffer.append(" group by pl,police_emergent order by pl ");

			System.out.println("动画告警：" + sqlBuffer.toString());
			list = this.commonService.executeSQL(sqlBuffer.toString());
			StringBuffer out = new StringBuffer();
			out.append("<response>");
			if (this.getAdminMark()) {// 如果是admin登陆则无限制
				addTaskXmlDate(getI18nText("i18n_DetectionWarningAction.emportCurrentXls.sysWarning_n81i"), "/nmsError/nmsErrorInfo.do?action=query&eiState=1", sysWarnSize, out);
			}
			if (list != null && list.size() > 0) {
				int emergentCount = 0;
				// 为了先显示紧急告警，循环了2次list
				for (int i = 0; i < list.size(); i++) {
					Object[] objs = list.get(i);
					if (objs != null && objs.length == 3) {
						String emegerentStr = objs[2] == null ? "" : objs[2].toString();
						if (objs[1] != null && objs[0] != null && !"".equals(objs[1]) && !"".equals(objs[0])) {
							if ("0".equals(emegerentStr)) { // 紧急告警

								emergentCount = emergentCount + Integer.parseInt(objs[1].toString());
							}
						}
					}
				}

				if (emergentCount > 0) {

					addTaskXmlDate(getI18nText("i18n_DetectionWarningAction.emportCurrentXls.policeEmergent_n81i"), "/detection/detectionWarning.do?action=queryAll&warnType="
							+ Constants.WARN_TYPE_LEFT_WARN + "&police_emergent=0", emergentCount, out);
				}

				for (int i = 0; i < list.size(); i++) {
					Object[] objs = list.get(i);
					if (objs != null && objs.length == 3) {
						String emegerentStr = objs[2] == null ? "" : objs[2].toString();
						if (objs[1] != null && objs[0] != null && !"".equals(objs[1]) && !"".equals(objs[0])) {
							if ("1".equals(emegerentStr)) {
								int count = Integer.parseInt(objs[1].toString());
								addTaskXmlDate(getI18nText("i18n_DetectionWarningAction.emportCurrentXls.unpoliceEmergent1_n81i") + objs[0] + getI18nText("i18n_DetectionWarningAction.emportCurrentXls.unpoliceEmergent2_n81i"),
										"/detection/detectionWarning.do?action=queryAll&warnType="
												+ Constants.WARN_TYPE_LEFT_WARN + "&police_emergent=1&police_level="
												+ objs[0],
										count, out);
							}
						}
					}
				}
			}
			out.append("</response>");
			// System.out.println(out);
			outAjaxString(out.toString());
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 
	 * 首页报警信息的个数统计 加入99级别的告警
	 * 
	 * @author jinshujuan May 23, 2013
	 * @version 1.0
	 * @param policeLevel
	 * @return
	 */
	private int getCount(int policeLevel) {
		try {
			StringBuffer sqlBuffer = new StringBuffer();
			sqlBuffer.append("select count(*) from " + "(select newTable.ip,newTable.iden " + "FROM (");
			/*
			 * +
			 * "(select row_number() over (PARTITION BY newTable.ip,newTable.iden"
			 * + // ,newTable.pl
			 * " order by newTable.dctime desc, newTable.ip) LEV, newTable.*" +
			 * "FROM (");
			 */
			sqlBuffer.append(" select " + "diw.id," + "nt.node_ip ip," + "cti.check_type_name1 ctn,"
					+ "dsi.PROCESS_IDEN_NAME iden," + "dsi.CHECK_WAY cw,");
			sqlBuffer.append("to_char(diw.data_check_time,'yyyy-MM-dd HH24:mi:Ss') dctime," + "diw.current_times ctime,"
					+ "diw.POLICE_LEVEL pl," + "diw.DETECTION_STATE_INFO dsinfo," + "diw.NOTICE_INFO noticeInfo,"
					+ "to_char(diw.status_change_time,'yyyy-MM-dd HH24:mi:Ss') stime,");
			sqlBuffer.append("dsi.id dsiiId,cti.id ctiId,nt.node_system_type nodeSysType,nt.node_type nodeType");
			sqlBuffer.append(" from detection_info_warning diw");
			sqlBuffer.append(" left join DETECTION_SET_INFO dsi");
			sqlBuffer.append(" on diw.detection_set_info_id = dsi.id");
			sqlBuffer.append(" left join check_type_info cti");
			sqlBuffer.append(" on dsi.check_type_id = cti.id");
			sqlBuffer.append(
					" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id from  NODE_TABLE) nt");
			sqlBuffer.append(" on diw.seq_id = nt.seq_id");
			sqlBuffer.append(
					" where nt.node_ip is not null and nt.node_state = 0 and dsi.detection_set_state ='1' and cti.crete_state=0 and diw.valid=1 AND diw.police_emergent=0 ");// 只显示有效的数据：valid=1
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and nt.system_id = ");
				sqlBuffer.append(this.getSystemID());
			}

			sqlBuffer.append(
					" and diw.data_check_time >= to_date(to_char((sysdate-1),'yyyy-mm-dd'),'yyyy-mm-dd hh24:mi:ss')");

			sqlBuffer.append(" and diw.POLICE_LEVEL in (99, " + policeLevel + ") ");

			// 如果是admin登陆则无限制
			if (!this.getAdminMark()) {
				sqlBuffer.append(" and (( dsi.view_level=1 and dsi.create_user_id=");
				sqlBuffer.append(this.getUserID());
				sqlBuffer.append(" and dsi.system_Id =" + this.getSystemID() + ")");
				sqlBuffer.append(
						" or ( dsi.view_level=2 and dsi.create_usergroup_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='");
				sqlBuffer.append(this.getUser().getYhbh());
				sqlBuffer.append("' and x.type = 1) and dsi.system_Id = " + this.getSystemID()
						+ ") or (dsi.view_level=3 and dsi.system_id = " + this.getSystemID() + ")");
				sqlBuffer.append(" or (dsi.view_level=4 ))");
			}

			// sqlBuffer.append(" order by diw.POLICE_LEVEL asc ,
			// diw.data_check_time desc , nt.node_ip");
			sqlBuffer.append(" ) newTable group by newTable.ip, newTable.iden )");
			// sqlBuffer.append(" ) newTable ) WHERE LEV =1");
			System.out.println("sqlBuffer:" + sqlBuffer.toString());
			List<Object[]> list = commonService.executeSQL(sqlBuffer.toString());
			if (list != null && list.size() > 0) {
				Object object = list.get(0);
				if (object != null) {
					return Integer.parseInt(object.toString());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	/**
	 * 追加任务提醒异步通讯数据
	 * 
	 * @param name
	 *            显示的描述
	 * @param url
	 *            跳转的页面
	 * @param count
	 *            工作任务数
	 * @param out
	 *            需要追加的StringBuffer
	 * @author ZhengXi 2010-6-25
	 */
	private void addTaskXmlDate(String name, String url, Object count, StringBuffer out) throws Exception {
		String bathPath = getRequest().getContextPath();
		if (count != null && !count.toString().equals("0")) {
			out.append("<alarms>");
			out.append("<alarm_level>" + Common.toHTMLCode(name) + "</alarm_level>");
			out.append("<url>" + Common.toHTMLCode(bathPath + url) + "</url>");
			out.append("<count>" + count + "</count>");
			out.append("</alarms>");
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

	public List<CheckTypeInfo> getAllCheckTypeInfo() {
		return allCheckTypeInfo;
	}

	public void setAllCheckTypeInfo(List<CheckTypeInfo> allCheckTypeInfo) {
		this.allCheckTypeInfo = allCheckTypeInfo;
	}

	public Long[] getIds() {
		return ids;
	}

	public void setIds(Long[] ids) {
		this.ids = ids;
	}

	public List<DetectionInfoWarning> getDetecWarningList() {
		return detecWarningList;
	}

	public void setDetecWarningList(List<DetectionInfoWarning> detecWarningList) {
		this.detecWarningList = detecWarningList;
	}

	public DetectionInfoWarning getDetectionWarningInfo() {
		return detectionWarningInfo;
	}

	public void setDetectionWarningInfo(DetectionInfoWarning detectionWarningInfo) {
		this.detectionWarningInfo = detectionWarningInfo;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getCtn() {
		return ctn;
	}

	public void setCtn(String ctn) {
		this.ctn = ctn;
	}

	public String getDct() {
		return dct;
	}

	public void setDct(String dct) {
		this.dct = dct;
	}

	public String getStateInfo() {
		return stateInfo;
	}

	public void setStateInfo(String stateInfo) {
		this.stateInfo = stateInfo;
	}

	public Long getPolice_level() {
		return police_level;
	}

	public void setPolice_level(Long police_level) {
		this.police_level = police_level;
	}

	public String getpIden() {
		return pIden;
	}

	public void setpIden(String pIden) {
		this.pIden = pIden;
	}

	public String getNodeIp() {
		return nodeIp;
	}

	public void setNodeIp(String nodeIp) {
		this.nodeIp = nodeIp;
	}

	public String getSeqIdList() {
		return seqIdList;
	}

	public void setSeqIdList(String seqIdList) {
		this.seqIdList = seqIdList;
	}

	public String getLevelAlarm() {
		return levelAlarm;
	}

	public void setLevelAlarm(String levelAlarm) {
		this.levelAlarm = levelAlarm;
	}

	public String getNodeType() {
		return nodeType;
	}

	public void setNodeType(String nodeType) {
		this.nodeType = nodeType;
	}

	public Long getSetPoleceLevel() {
		return setPoleceLevel;
	}

	public void setSetPoleceLevel(Long setPoleceLevel) {
		this.setPoleceLevel = setPoleceLevel;
	}

	public List<OptionTable> getOptionList() {
		return optionList;
	}

	public void setOptionList(List<OptionTable> optionList) {
		this.optionList = optionList;
	}

	public String getSqId() {
		return sqId;
	}

	public void setSqId(String sqId) {
		this.sqId = sqId;
	}

	public String getDsiId() {
		return dsiId;
	}

	public void setDsiId(String dsiId) {
		this.dsiId = dsiId;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public List<Object[]> getDetectionInfoWarningList() {
		return detectionInfoWarningList;
	}

	public void setDetectionInfoWarningList(List<Object[]> detectionInfoWarningList) {
		this.detectionInfoWarningList = detectionInfoWarningList;
	}

	public String getLevelSetStr() {
		return levelSetStr;
	}

	public void setLevelSetStr(String levelSetStr) {
		this.levelSetStr = levelSetStr;
	}

	public String getEmergentSetStr() {
		return emergentSetStr;
	}

	public void setEmergentSetStr(String emergentSetStr) {
		this.emergentSetStr = emergentSetStr;
	}

	public List<String> getLevelSetList() {
		return levelSetList;
	}

	public void setLevelSetList(List<String> levelSetList) {
		this.levelSetList = levelSetList;
	}

	public SetDetDataCon getDetecSet() {
		return detecSet;
	}

	public void setDetecSet(SetDetDataCon detecSet) {
		this.detecSet = detecSet;
	}

	public String getPolice_emergent() {
		return police_emergent;
	}

	public void setPolice_emergent(String police_emergent) {
		this.police_emergent = police_emergent;
	}

	public String getWarnType() {
		return warnType;
	}

	public void setWarnType(String warnType) {
		this.warnType = warnType;
	}

	public String getNodeIpRange() {
		return nodeIpRange;
	}

	public void setNodeIpRange(String nodeIpRange) {
		this.nodeIpRange = nodeIpRange;
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

	public Integer getCheckType() {
		return checkType;
	}

	public void setCheckType(Integer checkType) {
		this.checkType = checkType;
	}

	public String getQueryConfLevelChild() {
		return queryConfLevelChild;
	}

	public void setQueryConfLevelChild(String queryConfLevelChild) {
		this.queryConfLevelChild = queryConfLevelChild;
	}

	public String getMenuVisit() {
		return menuVisit;
	}

	public void setMenuVisit(String menuVisit) {
		this.menuVisit = menuVisit;
	}

	public String getTimeoutDetecFilter() {
		return timeoutDetecFilter;
	}

	public void setTimeoutDetecFilter(String timeoutDetecFilter) {
		this.timeoutDetecFilter = timeoutDetecFilter;
	}
}
