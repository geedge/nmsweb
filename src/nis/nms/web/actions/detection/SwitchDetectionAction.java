package nis.nms.web.actions.detection;

import java.io.File;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;

import freemarker.template.SimpleDate;
import net.sf.json.JSONArray;
import nis.nms.bean.DeviceInfo;
import nis.nms.bean.DiSystem;
import nis.nms.bean.SwitchInfo;
import nis.nms.bean.SwitchPortInfo;
import nis.nms.bean.SwitchPortInfoSource;
import nis.nms.core.Constants;
import nis.nms.domains.DetectionSetInfo;
import nis.nms.domains.DeviceTypeInfo;
import nis.nms.domains.NodeFigureInfo;
import nis.nms.domains.NodeTable;
import nis.nms.domains.OptionTable;
import nis.nms.persistence.HibernateGeneralDaoImpl;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Common;
import nis.nms.util.Constant;
import nis.nms.util.DateUtil;
import nis.nms.util.ExportUtils;
import nis.nms.util.MyNumberFormat;
import nis.nms.util.Page;
import nis.nms.util.StringUtil;

@SuppressWarnings("unchecked")
@Results({ @Result(name = "queryList", value = "/page/detection/switchInfo/switchInfoTotalList.jsp"),
		@Result(name = "queryListChild", value = "/page/detection/switchInfo/switchInfoTotalListChild.jsp"),
		@Result(name = "siStatisticsList", value = "/page/detection/switchInfo/switchInfoList.jsp"),
		@Result(name = "switchDetectInfoGraphPage", value = "/page/detection/switchInfo/switchDetectInfoGraphPage.jsp"),
		@Result(name = "toConfigSpecialDevice", value = "/page/detection/switchInfo/selectNodeAndDeviceType.jsp"),
		@Result(name = "configSpecialDevice", value = "/page/detection/switchInfo/specialDeviceConfig.jsp"),
		@Result(name = "toConfigPort", value = "/page/detection/switchInfo/toConfigPort.jsp"),
		@Result(name = "toConfigPortChild", value = "/page/detection/switchInfo/toConfigPortChild.jsp"),
		@Result(name = "error", value = "/error.jsp") })
public class SwitchDetectionAction extends BaseAction {

	private Logger logger = Logger.getLogger(SwitchDetectionAction.class);
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	private int pageNo = 1;
	private int pageSize = this.getDefaultPageSize(); // 每页显示的记录条数
	private Page page;
	private String action;

	private String nodeIp;

	// 特种设备图形化配置需要的变量
	private String seqId;// 0-ok
	private String deviceBrandCode;
	private String deviceBrandTypeCode;
	private int maxDevNum = 1;// 设备最大叠加数
	private List<DeviceInfo> deviceModelList = new ArrayList<DeviceInfo>();// 设备模型列表
	private List<DeviceInfo> devicePositionList = new ArrayList<DeviceInfo>();// 设备位置列表
	private List<DeviceInfo> deviceConfigList = new ArrayList<DeviceInfo>();// 配置后的设备列表（有父子关系：device_type_code）
	private DeviceInfo rootDevice = new DeviceInfo();// 顶级设备
	private List<Long> devShowLevelList = new ArrayList<Long>();// 设备下子设备的showLevel（不重复）
	private List<String> switcheNodeList = new ArrayList<String>();// 交换机节点列表
	private List<Object[]> deviceBrandList = new ArrayList<Object[]>();// 设备品牌列表
	private List<DeviceTypeInfo> deviceBrandTypeList = new ArrayList<DeviceTypeInfo>();// 设备型号列表列表
	// 多个物理设备叠加为一个逻辑节点
	private long rootDeviceX = 450;// 第一个设备的坐标
	private long rootDeviceY = 30;// 第一个设备的坐标
	private long deviceGap = 15;// 每个设备之间的距离
	private String sortByXorY = "y";// 按哪个方向排列设备,目前展示界面的排列为竖向排列，暂时不支持横向排列
	private String modelSortByXorY = "x";// 模板的宽高：x：宽>高，y：宽<高

	// 展示时:
	private int devNum = 1;// 一个逻辑设备的物理设备个数据
	private String devHeightSum = "0";// 展示时，设备的总高度
	private String devWidthSum = "0";// 展示时，设备的总宽度
	private String devScrollHeight = "0";// 展示时，设备的总高度
	private String devScrollWidth = "0";// 展示时，设备的总宽度
	private long deviceShowGap = 15;// 每个设备之间的距离
	private String bodyScrollTop = "0";// 记录滚动条卷上去的距离

	// 交换机图形化展示
	private String svgName;
	private String detectId;// 监测设置Id-1-ok
	private String nameFlag;// 设备的标识-2
	private String pid;// 当前设备父id-3
	private String isLeaf;// 当前设备是否为叶子设备-4
	private String deviceTypeCode;// 设备型号
	private String dataCheckTime;// 当前数据监测时间
	private String ip;// 监测节点的ip-5-ok
	private String picId;// 当前查看对应图形的元素id-6
	private String startTime;// 端口数据折线图显示的时间范围的开始时间-7
	private String startTimeXt;// 系统数据折线图显示的时间范围的开始时间-7
	// private String endTime;//端口数据折线图显示的时间范围的结束时间
	private String sysStatus = "";// 系统状态描述
	private boolean sysStatusFlag = true;;// 系统状态标志:true正常，false异常

	private String queryParConditionDisplay;// 系统基础信息显示的收缩状态-8
	private String queryChildConditionDisplay;// 端口信息显示的收缩状态-9

	// 端口的监测时间的默认间隔
	private static final long defaultPortGap = 15l;
	private static final long defaultSysInfoGap = 1440l;
	private static final long defaultOtherGap = 15l;
	private static final long defaultDelay = 5l;

	private static final long minPacketSize = 28; // udp 包28
	// 查看告警信息
	private String param;

	private SwitchPortInfo switchPortInfo = new SwitchPortInfo();// 端口信息
	private Map<String, SwitchPortInfo> switchPortMap = new HashMap<String, SwitchPortInfo>();// 端口名称：端口详细信息
	private DiSystem diSystem = new DiSystem();// 系统基本信息

	private static final int base = 1000;// 进行单位转换的基数B-KB-MB

	// 网元类型
	private List<OptionTable> optionList = new ArrayList<OptionTable>();
	private String networElementType;

	// 端口状态配置时节点对应的nodeFigureInfoList
	private List<NodeFigureInfo> nodeFigureInfoList = new ArrayList<NodeFigureInfo>();
	private List<NodeFigureInfo> batchNodeFigureInfo;
	private String index;

	// 请求类型为topo 表示来源于拓扑图展示时点击灯泡查询节点组下的节点检测情况
	private String requestType;
	private String nodeGroupId;

	private String clickPortId;
	/*
	 * private List<DetectionSetInfo> detecSetList; private List<NodegroupTable>
	 * nodeGroupList; private List<NodeTable> nodeList; private DetectionSetInfo
	 * detectionSetInfo; private SystemTable systemTable; private List<Long>
	 * userEmailIds;
	 * 
	 * private List<XtJsJbxx> usergroupLists = new ArrayList<XtJsJbxx>();
	 * private List<CheckTypeInfo> allCheckTypeInfo; private Long[] ids; private
	 * String ip; private String ctn; private String gid; private String pIden;
	 * private String detectSetIden;
	 */

	@Override
	public String executeAction() throws Exception {
		String resultpage = null;
		if ("query".equals(this.action)) {
			getNewworkType();
			// 如果是拓扑图过来的请求 走queryMonitorDataInfoNewForTopo逻辑
			if (!com.nis.util.StringUtil.isBlank(requestType) && requestType.equals("topo")) {
				resultpage = totalSwitchInfoStatisticsForTopo();
			} else {
				resultpage = totalSwitchInfoStatistics();
			}

		} else if ("queryChild".equals(this.action)) {
			resultpage = totalSwitchInfoStatisticsChild();
		} else if ("singleSwitchInfo".equals(this.action)) {
			resultpage = querySwitchInfo();
		}

		// 特殊设备（如交换机等）监测信息图形化:第一次进入及自动刷新
		else if ("switchDetectInfoGraph".equals(this.action)) {
			switchDetectInfoGraph();
			resultpage = "switchDetectInfoGraphPage";
		}

		// 查询设备的详细信息：点击设备时
		else if ("detailPortInfo".equals(this.action)) {
			startTime = "";
			// endTime = "";
			switchDetectInfoGraph();
			resultpage = "switchDetectInfoGraphPage";
		}

		// 特种设备图形化配置
		else if ("toConfigSpecialDevice".equals(this.action)) {
			toConfigSpecialDevice();
			resultpage = "toConfigSpecialDevice";
		} else if ("configSpecialDevice".equals(this.action)) {
			configSpecialDevice();
			resultpage = "configSpecialDevice";
		} else if ("addSpecialDeviceConfig".equals(this.action)) {
			addSpecialDeviceConfig();
			resultpage = null;
		} else if ("emportCurrentXls".equals(this.action)) {
			resultpage = emportCurrentXls();
		} else if ("emportAllXls".equals(this.action)) {
			resultpage = emportAllXls();
		} else if ("emportXls".equals(this.action)) {// 导出节点端口详细
			resultpage = emportXls();
		} else if ("toConfigPort".equals(action)) {
			resultpage = toConfigPort();
		} else if ("toConfigPortChild".equals(action)) {
			toConfigPort();
			resultpage = "toConfigPortChild";
		} else if ("saveConfigPort".equals(action)) {
			resultpage = saveConfigPort();
		}
		return resultpage;
	}

	private void getNewworkType() {
		try {
			// 网元类别
			String sql = "select * from option_table t where t.TYPE_IDENTITY ='netelementtype' ORDER by t.show_num";
			optionList = this.commonService.executeSQL(sql, OptionTable.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 导出节点端口详细
	public String emportXls() {
		try {
			String detectId = this.getRequest().getParameter("detectId");
			String seqId = this.getRequest().getParameter("seqId");
			String checkDate = this.getRequest().getParameter("checkDate");

			// 数据查询sql
			// String datasSql = "select "
			// + "ifindex,"
			// + // 0
			// "ifdescr,"
			// + // 1
			// "iftype,"
			// + // 2
			// "ifmtu,"
			// + // 3
			// "ifspeed,"
			// + // 4
			// "ifphysaddress,"
			// + // 5
			// "ifadminstatus,"
			// + // 6
			// "ifoperstatus,"
			// + // 7
			// "iflastchange,"
			// + // 8
			// "ifinoctets,"
			// + // 9
			// "ifinucastpkts,"
			// + // 10
			// "ifinnucastpkts,"
			// + // 11
			// "ifindiscards,"
			// + // 12
			// "ifinerrors,"
			// + // 13
			// "ifinunknownprotos,"
			// + // 14
			// "ifoutoctets,"
			// + // 15
			// "ifoutucastpkts,"
			// + // 16
			// "ifoutnucastpkts,"
			// + // 17
			// "ifoutdiscards,"
			// + // 18
			// "ifouterrors,"
			// + // 10
			// "ifoutqlen,"
			// + // 20
			// "ifspecific,"
			// + // 21
			// "dsp.data_check_time_digital, "
			// + // 22
			// "dsp.INOCTETSSPEED, "
			// + // 23
			// // "dsp.INERRORSSCALE, " +
			// "dsp.OUTOCTETSSPEED, "
			// + // 24
			// // "dsp.OUTERRORSSCALE, " +
			// // "dsp.IFINDISCARDSPERC, " +
			// // "dsp.IFOUTDISCARDSPERC, " +
			// "dsp.INPKTSSPEED, "
			// + // 25
			// "dsp.OUTPKTSSPEED, "
			// + // 26
			// "dsp.IFINDISCARDS_VARY, "
			// + // 27
			// "dsp.IFOUTDISCARDS_VARY, "
			// + // 28
			// "dsp.IFINERRORS_VARY, "
			// + // 29
			// "dsp.IFOUTERRORS_VARY, "
			// + // 30
			// "dsp.IFHIGHSPEED, "
			// + // 31
			// "dsp.DATA_64_FLAG "
			// + // 32
			// "from di_switchport dsp "
			// +
			// // "left join detection_info di on di.id =
			// // dsp.detection_info_id "
			// // +
			// "where dsp.detection_set_info_id = "+ detectId
			// + " and dsp.seq_id = " + seqId
			// + " and (dsp.data_check_time = (" +
			// " select max(data_check_time) " +
			// " from di_switchport" +
			// " where data_check_time_digital<" + checkDate +
			// " and detection_set_info_id = "+ detectId +
			// " and seq_id = " + seqId +
			// " ) " +
			// "or dsp.data_check_time_digital = " + checkDate + " )"
			// + "order by dsp.ifdescr asc,dsp.data_check_time_digital desc";
			String datasSql = getSqlOfSwitchInfoList(checkDate, detectId, seqId);
			/* 查询 最新时间点的数据 */
			List<Object[]> lastDatasList = new ArrayList<Object[]>();
			if (StringUtils.isNotBlank(checkDate) && StringUtils.isNotBlank(detectId)
					&& StringUtils.isNotBlank(seqId)) {
				lastDatasList = commonService.executeSQL(datasSql);
			}
			if (lastDatasList == null || lastDatasList.size() == 0) {
				outHtmlString(
						"<script type=\"text/javascript\">alert(\"i18n_SwitchDetectionAction.emportXls.noData_n81i\");this.location='switchDetection.do?action=singleSwitchInfo'</script>");
				return null;
			}

			List<SwitchPortInfoSource> siList = new ArrayList<SwitchPortInfoSource>();
			for (Object[] objs : lastDatasList) {
				SwitchPortInfoSource si = new SwitchPortInfoSource();
				si.setIfIndex(objs[0] == null ? null : ((BigDecimal) objs[0]).intValue());
				si.setIfDescr(objs[1] == null ? null : (String) objs[1]);
				si.setIfType(objs[2] == null ? null : ((BigDecimal) objs[2]).intValue());
				si.setIfMtu(objs[3] == null ? null : ((BigDecimal) objs[3]).intValue());
				si.setIfSpeed(objs[4] == null ? null : ((BigDecimal) objs[4]).longValue());
				si.setIfPhysAddress(objs[5] == null ? null : (String) objs[5]);
				si.setIfAdminStatus(objs[6] == null ? null : ((BigDecimal) objs[6]).intValue());
				si.setIfOperStatus(objs[7] == null ? null : ((BigDecimal) objs[7]).intValue());

				si.setIfInOctets(objs[9] == null ? null : ((BigDecimal) objs[9]).doubleValue());
				si.setIfInUcastPkts(objs[10] == null ? null : ((BigDecimal) objs[10]).doubleValue());
				si.setIfInNUcastPkts(objs[11] == null ? null : ((BigDecimal) objs[11]).doubleValue());
				si.setIfInDiscards(objs[12] == null ? null : ((BigDecimal) objs[12]).doubleValue());
				si.setIfInErrors(objs[13] == null ? null : ((BigDecimal) objs[13]).doubleValue());
				si.setIfInUnknownProtos(objs[14] == null ? null : ((BigDecimal) objs[14]).doubleValue());

				si.setIfOutOctets(objs[15] == null ? null : ((BigDecimal) objs[15]).doubleValue());
				si.setIfOutUcastPkts(objs[16] == null ? null : ((BigDecimal) objs[16]).doubleValue());
				si.setIfOutNUcastPkts(objs[17] == null ? null : ((BigDecimal) objs[17]).doubleValue());

				si.setIfOutDiscards(objs[18] == null ? null : ((BigDecimal) objs[18]).doubleValue());
				si.setIfOutErrors(objs[19] == null ? null : ((BigDecimal) objs[19]).doubleValue());

				si.setIfOutQLen(objs[20] == null ? null : ((BigDecimal) objs[20]).doubleValue());
				si.setIfSpecific(objs[21] == null ? null : (String) objs[21]);
				si.setLastLongTime(objs[22] == null ? null : ((BigDecimal) objs[22]).longValue());

				si.setIfInOctetsSpeed(objs[23] == null ? 0.00d : ((BigDecimal) objs[23]).doubleValue());
				si.setIfOutOctetsSpeed(objs[24] == null ? 0.00d : ((BigDecimal) objs[24]).doubleValue());
				si.setInpktsspeed(objs[25] == null ? 0.00d : ((BigDecimal) objs[25]).doubleValue());
				si.setOutpktsspeed(objs[26] == null ? 0.00d : ((BigDecimal) objs[26]).doubleValue());
				si.setIfindiscardsVary(objs[27] == null ? null : ((BigDecimal) objs[27]).longValue());
				si.setIfoutdiscardsVary(objs[28] == null ? null : ((BigDecimal) objs[28]).longValue());
				si.setIfinerrorsVary(objs[29] == null ? null : ((BigDecimal) objs[29]).longValue());
				si.setIfouterrorsVary(objs[30] == null ? null : ((BigDecimal) objs[30]).longValue());
				si.setIfHighSpeed(objs[31] == null ? null : ((BigDecimal) objs[31]).longValue());
				si.setData64Flag(objs[32] == null ? 0 : ((BigDecimal) objs[32]).intValue());
				siList.add(si);
			}
			int thisIfindex = 0;
			List<SwitchPortInfo> spiList = new ArrayList<SwitchPortInfo>();
			for (int i = 0; i < siList.size(); i++) {
				SwitchPortInfoSource news = siList.get(i);
				thisIfindex = news.getIfIndex();
				SwitchPortInfoSource olds = null;
				i++;
				if (i < siList.size()) {
					olds = siList.get(i);
					if (olds != null && thisIfindex == olds.getIfIndex()) {
						spiList.add(resetData(olds, news));
					} else {
						i--;
					}
				}
			}
			// 获取节点ip
			ip = getIpBySeqId(seqId);
			String[] title = { getI18nText("i18n_SwitchDetectionAction.emportXls.title.portName_n81i"),
								getI18nText("i18n_SwitchDetectionAction.emportXls.title.bandwidth_n81i"), 
								getI18nText("i18n_SwitchDetectionAction.emportXls.title.status_n81i"), 
								getI18nText("i18n_SwitchDetectionAction.emportXls.title.inputRate_n81i"), 
								getI18nText("i18n_SwitchDetectionAction.emportXls.title.packetRate_n81i"),
								getI18nText("i18n_SwitchDetectionAction.emportXls.title.inputPacketLoss_n81i"),
								getI18nText("i18n_SwitchDetectionAction.emportXls.title.inputErrNum_n81i"),
								getI18nText("i18n_SwitchDetectionAction.emportXls.title.ouputRate_n81i"),
								getI18nText("i18n_SwitchDetectionAction.emportXls.title.outPacketRate_n81i"),
								getI18nText("i18n_SwitchDetectionAction.emportXls.title.outputPacketLoss_n81i"), 
								getI18nText("i18n_SwitchDetectionAction.emportXls.title.outputErrNum_n81i"), 
								getI18nText("i18n_SwitchDetectionAction.emportXls.title.lastCheckTime_n81i")};

			String[] colu = { "ifDescr", "ifHighSpeed", "ifOperStatus", "ifInOctetsSpeed", "inpktsspeed",
					"ifindiscardsVary", "ifinerrorsVary", "ifOutOctetsSpeed", "outpktsspeed", "ifoutdiscardsVary",
					"ifouterrorsVary", "lastStringTime" };
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(getI18nText("i18n_SwitchDetectionAction.emportXls.nodeIp_n81i") + ip + getI18nText("i18n_SwitchDetectionAction.emportXls.portInfo_n81i"), spiList, title, colu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// 当前页导出 程辉 2013-5-8新增
	public String emportCurrentXls() {
		try {
			String datasSql = getSqlOfTotalSwitStatForExport();
			page = commonService.findByPageForSql(datasSql, pageNo, pageSize);
			List<Object[]> datasList = (List<Object[]>) page.getResult();

			String[] title = { getI18nText("i18n_SwitchDetectionAction.emportXls.title1.checkType_n81i"),
								getI18nText("i18n_SwitchDetectionAction.emportXls.title1.setName_n81i"),
								getI18nText("i18n_SwitchDetectionAction.emportXls.title1.switchIp_n81i"),
								getI18nText("i18n_SwitchDetectionAction.emportXls.title1.portNum_n81i"), 
								getI18nText("i18n_SwitchDetectionAction.emportXls.title1.lastCheckTime_n81i")};

			String[] colu = { "1", "3", "5", "6", "7" };
			String url = "switchDetection.do?action=query&nodeIp=" + nodeIp + "&networElementType=" + networElementType
					+ "&pageSize=" + pageSize + "&pageNo=" + pageNo;
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(url, getI18nText("i18n_SwitchDetectionAction.emportXls.netDetecateInfo_n81i"), datasList, title, colu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// 导出全部 程辉 2013-5-8新增
	public String emportAllXls() {
		try {
			String datasSql = getSqlOfTotalSwitStatForExport();
			List<Object[]> datasList = commonService.executeSQL(datasSql);

			String[] title = { getI18nText("i18n_SwitchDetectionAction.emportXls.title1.checkType_n81i"),
					getI18nText("i18n_SwitchDetectionAction.emportXls.title1.setName_n81i"),
					getI18nText("i18n_SwitchDetectionAction.emportXls.title1.switchIp_n81i"),
					getI18nText("i18n_SwitchDetectionAction.emportXls.title1.portNum_n81i"), 
					getI18nText("i18n_SwitchDetectionAction.emportXls.title1.lastCheckTime_n81i")};

			String[] colu = { "1", "3", "5", "6", "7" };
			String url = "switchDetection.do?action=query&nodeIp=" + nodeIp + "&networElementType=" + networElementType
					+ "&pageSize=" + pageSize + "&pageNo=" + pageNo;
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(url,  getI18nText("i18n_SwitchDetectionAction.emportXls.netDetecateInfo_n81i"), datasList, title, colu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 1.查有效的DC管理的IP的范围 2.查询管理范围内有效的IP非空的网元节点 3.修改： 旧：从new表、switchport表
	 * 进行统计，统计有效的switchport监测：端口数、最新监测时间
	 * 新：从new表、node_figure_info表、device_type_info表
	 * 进行统计：端口数（修改为从node_figure_info取）、最新监测时间（修改为从new表取）
	 * 4.当前业务系统下的（admin展示所有业务系统的网元监测）
	 * 
	 * @author hyx Oct 14, 2013
	 * @version 1.0
	 * @return
	 */
	public String totalSwitchInfoStatistics() {

		try {
			String datasSql = getSqlOfTotalSwitchInfoStatistics();
			page = commonService.findByPageForSql(datasSql, pageNo, pageSize);
			List<Object[]> datasList = (List<Object[]>) page.getResult();
			// 页面按照网元类别归类展示
			List<List<Object[]>> datasListNew = converData(datasList);
			getRequest().setAttribute("datasList", datasListNew);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}

		return "queryList";
	}

	private String getSqlOfTotalSwitchInfoStatistics() {
		String switchPortType = rb.getString("detec.switch.str");
		if (StringUtils.isBlank(switchPortType)) {
			switchPortType = "switchport";
		}

		String datasSql = "select cti.id ctiId, " + " dsi.id dsiId," + " nt.seq_id," + " nt.network_element_type,"
				+ " nt.node_ip," + " cti.check_type_name1, " + " dsi.process_iden_name,  "
				+ " count(distinct nfi.id) ifIndex," + " to_char(din.data_check_time, 'yyyy-mm-dd hh24:mi:ss'),"
				+ " din.data_check_time_digital ," + " nt.ipn ipn " + " from detection_info_new din "
				+ " left join detection_set_info dsi on dsi.id = din.detection_set_info_id "
				+ " left join check_type_info cti on cti.id = dsi.check_type_id " + " left join ("
				+ " select distinct nt0.node_ip,nt0.seq_id,nt0.ipn,nt0.network_element_type,nt0.system_id "
				+ " from node_table nt0 join ("
				+ "               select sis.start_ip,sis.end_ip,sis.start_ipn,sis.end_ipn "
				+ "               from server_table st join server_ip_segment sis on st.id=sis.server_id "
				+ "               where st.server_state=0 and sis.SEGMENT_STATE<>-1) ls "
				+ " on nt0.ipn between ls.start_ipn and ls.end_ipn " + " where nt0.node_type=1 and nt0.node_state=0 ";
		if (!StringUtils.isBlank(nodeIp)) {
			datasSql += "AND NT0.NODE_IP like '%" + nodeIp.trim() + "%'";
		}
		datasSql += ") nt " + " on nt.seq_id = din.seq_id "
				+ " left join node_figure_info nfi on nfi.seqid = nt.seq_id "
				+ " left join device_type_info dti on dti.device_type_code=nfi.device_type_code "
				+ " where lower(cti.check_type_name) = lower('" + switchPortType + "') "// switchport监测
				+ "       and dsi.detection_set_state = 1 "// 监测设置有效
				+ "       and nvl(nt.node_ip,'-999')<>'-999' "// ip非空
				+ "       and ((lower(dti.di_table_name) ='di_switchport' and nfi.is_leaf=1 ) or nfi.id is null) ";// 端口设备

		// 对节点增加业务系统的过滤-2013-6-25 hyx add
		if (!this.getAdminMark()) {
			datasSql += " and nt.system_id = " + this.getSystemID();
		}

		if (!StringUtils.isBlank(networElementType)) {
			datasSql += " and nt.network_element_type = " + networElementType;
		}

		datasSql += " group by cti.id,cti.check_type_name1,cti.check_type_name,dsi.id,dsi.process_iden_name,nt.seq_id,nt.node_ip,din.data_check_time,din.data_check_time_digital,nt.ipn,nt.network_element_type"
				+ " ORDER BY ipn ";

		return datasSql;
	}

	private String getSqlOfTotalSwitStatForExport() {
		String switchPortType = rb.getString("detec.switch.str");
		if (StringUtils.isBlank(switchPortType)) {
			switchPortType = "switchport";
		}

		String datasSql = "select " + "cti.id ctiId, " + "cti.check_type_name1, " + "dsi.id dsiId, "
				+ "dsi.process_iden_name, " + "nt.seq_id, " + "nt.node_ip, " + "count(distinct nfi.id) ifIndex, "
				+ "to_char(din.data_check_time,'yyyy-mm-dd hh24:mi:ss'), " + "din.data_check_time_digital ,"
				+ "nt.ipn ipn " + " from detection_info_new din "
				+ " left join detection_set_info dsi on dsi.id = din.detection_set_info_id "
				+ " left join check_type_info cti on cti.id = dsi.check_type_id " + " left join ("
				+ " select distinct nt0.node_ip,nt0.seq_id,nt0.ipn,nt0.network_element_type,nt0.system_id "
				+ " from node_table nt0 join ("
				+ "               select sis.start_ip,sis.end_ip,sis.start_ipn,sis.end_ipn "
				+ "               from server_table st join server_ip_segment sis on st.id=sis.server_id "
				+ "               where st.server_state=0 and sis.SEGMENT_STATE<>-1) ls "
				+ " on nt0.ipn between ls.start_ipn and ls.end_ipn " + " where nt0.node_type=1 and nt0.node_state=0 ";
		if (!StringUtils.isBlank(nodeIp)) {
			datasSql += "AND NT0.NODE_IP like'%" + nodeIp.trim() + "%'";
		}
		datasSql += ") nt " + " on nt.seq_id = din.seq_id "
				+ " left join node_figure_info nfi on nfi.seqid = nt.seq_id "
				+ " left join device_type_info dti on dti.device_type_code=nfi.device_type_code "
				+ " where lower(cti.check_type_name) = lower('" + switchPortType + "') "// switchport监测
				+ "       and dsi.detection_set_state = 1 "// 监测设置有效
				+ "       and nvl(nt.node_ip,'-999')<>'-999' "// ip非空
				+ "       and ((lower(dti.di_table_name) ='di_switchport' and nfi.is_leaf=1 ) or nfi.id is null) ";// 端口设备

		// 对节点增加业务系统的过滤-2013-6-25 hyx add
		if (!this.getAdminMark()) {
			datasSql += " and nt.system_id = " + this.getSystemID();
		}

		if (!StringUtils.isBlank(networElementType)) {
			datasSql += " and nt.network_element_type = " + networElementType;
		}

		datasSql += " group by cti.id,cti.check_type_name1,cti.check_type_name,dsi.id,dsi.process_iden_name,nt.seq_id,nt.node_ip,din.data_check_time,din.data_check_time_digital,nt.ipn,nt.network_element_type"
				+ " ORDER BY ipn ";

		return datasSql;
	}

	/**
	 * 
	 * TODO 拓扑头过来的特种设置监测
	 * 
	 * @author jinshujuan Jun 13, 2013
	 * @version 1.0
	 * @return
	 */
	private String totalSwitchInfoStatisticsForTopo() {

		String switchPortType = rb.getString("detec.switch.str");
		if (StringUtils.isBlank(switchPortType)) {
			switchPortType = "switchport";
		}

		String datasSql = "select cti.id ctiId, dsi.id dsiId,nt.seq_id,nt.network_element_type,nt.node_ip,cti.check_type_name1, dsi.process_iden_name, count(distinct dsp.ifindex) ifIndex, to_char(dsp.data_check_time,'yyyy-mm-dd hh24:mi:ss'), dsp.data_check_time_digital ,nt.ipn ipn "
				+ " ,din.detectioned_state detectioned_state,din.police_emergent police_emergent,din.police_level police_level"
				+ " from detection_info_new din "
				+ "left join detection_set_info dsi on dsi.id = din.detection_set_info_id "
				+ "left join check_type_info cti on cti.id = dsi.check_type_id "
				+ "left join di_switchport dsp on dsp.detection_info_id = din.detection_info_id "
				+ "left join (select distinct nt0.node_ip,nt0.seq_id,nt0.ipn,nt0.network_element_type from node_table nt0 join (select sis.start_ip,sis.end_ip,sis.start_ipn,sis.end_ipn from server_table st join server_ip_segment sis on st.id=sis.server_id where st.server_state=0 and sis.SEGMENT_STATE<>-1) ls on nt0.ipn between ls.start_ipn and ls.end_ipn where nt0.node_type=1 and nt0.node_state=0 and nt0.node_group_id="
				+ nodeGroupId + ") nt on nt.seq_id = din.seq_id " + "where lower(cti.check_type_name) = lower('"
				+ switchPortType + "') " + "and dsi.detection_set_state = 1 " + "and nvl(nt.node_ip,'-999')<>'-999' ";
		if (!StringUtils.isBlank(networElementType)) {
			datasSql += " and nt.network_element_type = " + networElementType;
		}

		datasSql += " group by cti.id,cti.check_type_name1,cti.check_type_name,dsi.id,dsi.process_iden_name,nt.seq_id,nt.node_ip,dsp.data_check_time,dsp.data_check_time_digital,nt.ipn,nt.network_element_type"
				+ ", din.detectioned_state ,din.police_emergent ,din.police_level "
				+ " ORDER BY detectioned_state,police_emergent,police_level ";
		try {
			page = commonService.findByPageForSql(datasSql, pageNo, pageSize);
			List<Object[]> datasList = (List<Object[]>) page.getResult();
			// 页面按照网元类别归类展示
			List<List<Object[]>> datasListNew = converData(datasList);
			getRequest().setAttribute("datasList", datasListNew);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}

		return "queryList";

	}

	/**
	 * 
	 * TODO 将统一网元类型归类
	 * 
	 * @author jinshujuan May 23, 2013
	 * @version 1.0
	 * @param datasList
	 * @return
	 */
	private List<List<Object[]>> converData(List<Object[]> datasList) {
		List<List<Object[]>> list = new ArrayList<List<Object[]>>();
		try {
			String netElementTypeSql = "select distinct t.type_code,t.type_value,t.show_num from option_table t where t.TYPE_IDENTITY ='netelementtype' order by t.show_num asc ";

			List networkTypeList = commonService.executeSQL(netElementTypeSql);
			if (networkTypeList != null && networkTypeList.size() > 0) {
				for (int i = 0; i < networkTypeList.size(); i++) {
					Object[] args = (Object[]) networkTypeList.get(i);
					if (args != null && args.length >= 2 && args[0] != null && args[1] != null) {

						int type = Integer.parseInt(args[0].toString());
						String typeValue = args[1].toString();

						List<Object[]> typeList = new ArrayList<Object[]>();
						for (Object[] data : datasList) {
							if (data[3] != null && data[3] != "") {
								if (NumberUtils.isNumber(data[3].toString())
										&& type == Integer.parseInt(data[3].toString())) {
									data[3] = typeValue;
									typeList.add(data);
								}
							}
						}
						if (typeList != null && typeList.size() > 0) {
							list.add(typeList);
						}
					}
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
		return list;

	}

	public String totalSwitchInfoStatisticsChild() {
		try {
			String datasSql = getSqlOfTotalSwitchInfoStatistics();
			page = commonService.findByPageForSql(datasSql, pageNo, pageSize);
			List<Object[]> datasList = (List<Object[]>) page.getResult();
			// 页面按照网元类别归类展示
			List<List<Object[]>> datasListNew = converData(datasList);
			getRequest().setAttribute("datasList", datasListNew);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}

		return "queryListChild";
	}

	public String querySwitchInfo() {
		String detectId = this.getRequest().getParameter("detectId");
		String seqId = this.getRequest().getParameter("seqId");
		String checkDate = this.getRequest().getParameter("checkDate");
		String switchInfoSql = "select " + "ds.detection_info_id," + "sysdescr," + "sysobjectid," + "sysuptime,"
				+ "syscontact," + "sysname," + "syslocation," + "sysservices," + "ds.data_check_time_digital,"
				+ "ds.data_arrive_time_digital " + "from DI_SYSTEM ds "
				+ "left join detection_info_new din on ds.detection_info_id = din.detection_info_id " + "where 1=1 "
				+ "and din.detection_info_id is not null " + "and din.seq_id = " + seqId;

		try {
			List<Object[]> dateList = new ArrayList<Object[]>();
			if (StringUtils.isNotBlank(seqId)) {
				dateList = commonService.executeSQL(switchInfoSql);
			}
			if (dateList != null && dateList.size() > 0) {
				Object[] objects = dateList.get(0);
				SwitchInfo si = new SwitchInfo();
				si.setDetectionInfoId(objects[0] == null ? null : Long.parseLong(objects[0].toString()));
				si.setSysDescr(objects[1] == null ? null : objects[1].toString());
				si.setSysObjectID(objects[2] == null ? null : objects[2].toString());
				if (NumberUtils.isDigits(objects[3].toString())) {
					si.setSysUpTime(objects[3] == null ? null : Long.parseLong(objects[3].toString()));
				} else {
					si.setUpTimeStr0(objects[3] == null ? null : objects[3].toString());
				}
				si.setSysContact(objects[4] == null ? null : objects[4].toString());
				si.setSysName(objects[5] == null ? null : objects[5].toString());
				si.setSysLocation(objects[6] == null ? null : objects[6].toString());
				si.setSysServices((objects[7] == null ||!StringUtils.isNumeric((String)objects[7])) ? 0 : Integer.parseInt(objects[7].toString()));
				si.setCheckedTime(objects[8] == null ? null : Long.parseLong(objects[8].toString()));
				si.setArrivedTime(objects[9] == null ? null : Long.parseLong(objects[9].toString()));
				getRequest().setAttribute("si", si);
			}
		} catch (Exception e1) {
			logger.error(e1.getStackTrace());
			e1.printStackTrace();
		}

		// String dataCheckTimeTmp =
		// DateUtil.longToDate(Long.parseLong(checkDate), "yyyy-MM-dd
		// HH:mm:ss");
		// String dataCheckTimeTmp2 =
		// DateUtil.longToDate((Long.parseLong(checkDate)-1000), "yyyy-MM-dd
		// HH:mm:ss");
		// // 数据查询sql
		// String datasSql = "select "
		// + "dsp.ifindex,"
		// + // 0
		// "dsp.ifdescr,"
		// + // 1
		// "dsp.iftype,"
		// + // 2
		// "dsp.ifmtu,"
		// + // 3
		// "dsp.ifspeed,"
		// + // 4
		// "dsp.ifphysaddress,"
		// + // 5
		// "dsp.ifadminstatus,"
		// + // 6
		// "dsp.ifoperstatus,"
		// + // 7
		// "dsp.iflastchange,"
		// + // 8
		// "dsp.ifinoctets,"
		// + // 9
		// "dsp.ifinucastpkts,"
		// + // 10
		// "dsp.ifinnucastpkts,"
		// + // 11
		// "dsp.ifindiscards,"
		// + // 12
		// "dsp.ifinerrors,"
		// + // 13
		// "dsp.ifinunknownprotos,"
		// + // 14
		// "dsp.ifoutoctets,"
		// + // 15
		// "dsp.ifoutucastpkts,"
		// + // 16
		// "dsp.ifoutnucastpkts,"
		// + // 17
		// "dsp.ifoutdiscards,"
		// + // 18
		// "dsp.ifouterrors,"
		// + // 10
		// "dsp.ifoutqlen,"
		// + // 20
		// "dsp.ifspecific,"
		// + // 21
		// "dsp.data_check_time_digital, "
		// + // 22
		// "dsp.INOCTETSSPEED, "
		// + // 23
		//// "dsp.INERRORSSCALE, " +
		// "dsp.OUTOCTETSSPEED, "
		// + // 24
		//// "dsp.OUTERRORSSCALE, " +
		//// "dsp.IFINDISCARDSPERC, " +
		//// "dsp.IFOUTDISCARDSPERC, " +
		// "dsp.INPKTSSPEED, "
		// + // 25
		// "dsp.OUTPKTSSPEED, "
		// + // 26
		// "dsp.IFINDISCARDS_VARY, "
		// + // 27
		// "dsp.IFOUTDISCARDS_VARY, "
		// + // 28
		// "dsp.IFINERRORS_VARY, "
		// + // 29
		// "dsp.IFOUTERRORS_VARY, "
		// + // 30
		// "dsp.IFHIGHSPEED, "
		// + // 31
		// "dsp.DATA_64_FLAG, "
		// + // 32
		// "dsp.data_check_time"
		// +//33
		// " from di_switchport dsp "
		// +
		//// "left join detection_info di on di.id = dsp.detection_info_id " +
		// " where dsp.detection_set_info_id = " + detectId
		// + " and dsp.seq_id = " + seqId
		// + " and (dsp.data_check_time = (select dsTmp.data_check_time " +
		// " from (select ds.data_check_time " +
		// " from di_switchport ds" +
		// " where ds.detection_set_info_id= " + detectId +
		// " and ds.seq_id= " + seqId +
		// " and ds.data_check_time<=to_date('" + dataCheckTimeTmp2
		// +"','yyyy-MM-dd HH24:mi:ss')" +
		// " order by ds.data_check_time desc" +
		// " ) dsTmp" +
		// " where rownum=1 "
		// + " ) "
		// + " or dsp.data_check_time = to_date('" + dataCheckTimeTmp
		// +"','yyyy-MM-dd HH24:mi:ss') " +
		// " )"
		// + " order by dsp.ifdescr asc,dsp.data_check_time desc";
		String datasSql = getSqlOfSwitchInfoList(checkDate, detectId, seqId);

		try {
			/* 查询 最新时间点的数据 */
			List<Object[]> lastDatasList = new ArrayList<Object[]>();
			if (StringUtils.isNotBlank(checkDate) && StringUtils.isNotBlank(detectId)
					&& StringUtils.isNotBlank(seqId)) {
				lastDatasList = commonService.executeSQL(datasSql);
			}
			if (lastDatasList == null || lastDatasList.size() == 0) {
				return "siStatisticsList";
			}

			List<SwitchPortInfoSource> siList = new ArrayList<SwitchPortInfoSource>();
			for (Object[] objs : lastDatasList) {
				SwitchPortInfoSource si = new SwitchPortInfoSource();
				si.setIfIndex(objs[0] == null ? null : ((BigDecimal) objs[0]).intValue());
				si.setIfDescr(objs[1] == null ? null : (String) objs[1]);
				si.setIfType(objs[2] == null ? null : ((BigDecimal) objs[2]).intValue());
				si.setIfMtu(objs[3] == null ? null : ((BigDecimal) objs[3]).intValue());
				si.setIfSpeed(objs[4] == null ? null : ((BigDecimal) objs[4]).longValue());
				si.setIfPhysAddress(objs[5] == null ? null : (String) objs[5]);
				si.setIfAdminStatus(objs[6] == null ? null : ((BigDecimal) objs[6]).intValue());
				si.setIfOperStatus(objs[7] == null ? null : ((BigDecimal) objs[7]).intValue());
				// si.setIfLastChange(objs[8]==null?null:Long.parseLong((String)objs[8]));

				si.setIfInOctets(objs[9] == null ? null : ((BigDecimal) objs[9]).doubleValue());
				si.setIfInUcastPkts(objs[10] == null ? null : ((BigDecimal) objs[10]).doubleValue());
				si.setIfInNUcastPkts(objs[11] == null ? null : ((BigDecimal) objs[11]).doubleValue());
				// logger.debug((objs[10]==null?null:((BigDecimal)objs[10]).doubleValue())+"
				// vs
				// "+(objs[11]==null?null:((BigDecimal)objs[11]).doubleValue()));
				si.setIfInDiscards(objs[12] == null ? null : ((BigDecimal) objs[12]).doubleValue());
				si.setIfInErrors(objs[13] == null ? null : ((BigDecimal) objs[13]).doubleValue());
				si.setIfInUnknownProtos(objs[14] == null ? null : ((BigDecimal) objs[14]).doubleValue());

				si.setIfOutOctets(objs[15] == null ? null : ((BigDecimal) objs[15]).doubleValue());
				si.setIfOutUcastPkts(objs[16] == null ? null : ((BigDecimal) objs[16]).doubleValue());
				si.setIfOutNUcastPkts(objs[17] == null ? null : ((BigDecimal) objs[17]).doubleValue());

				si.setIfOutDiscards(objs[18] == null ? null : ((BigDecimal) objs[18]).doubleValue());
				si.setIfOutErrors(objs[19] == null ? null : ((BigDecimal) objs[19]).doubleValue());

				si.setIfOutQLen(objs[20] == null ? null : ((BigDecimal) objs[20]).doubleValue());
				si.setIfSpecific(objs[21] == null ? null : (String) objs[21]);
				si.setLastLongTime(objs[22] == null ? null : ((BigDecimal) objs[22]).longValue());

				si.setIfInOctetsSpeed(objs[23] == null ? 0.00d : ((BigDecimal) objs[23]).doubleValue());
				// si.setIfInErrorsScale(objs[24]==null?0.00d:((BigDecimal)objs[24]).doubleValue());
				si.setIfOutOctetsSpeed(objs[24] == null ? 0.00d : ((BigDecimal) objs[24]).doubleValue());
				// si.setIfOutErrorsScale(objs[26]==null?0.00d:((BigDecimal)objs[26]).doubleValue());
				// si.setIfindiscardsperc(objs[27]==null?0.00d:((BigDecimal)objs[27]).doubleValue())
				// ;
				// si.setIfoutdiscardsperc(objs[28]==null?0.00d:((BigDecimal)objs[28]).doubleValue());
				si.setInpktsspeed(objs[25] == null ? 0.00d : ((BigDecimal) objs[25]).doubleValue());
				si.setOutpktsspeed(objs[26] == null ? 0.00d : ((BigDecimal) objs[26]).doubleValue());
				si.setIfindiscardsVary(objs[27] == null ? null : ((BigDecimal) objs[27]).longValue());
				si.setIfoutdiscardsVary(objs[28] == null ? null : ((BigDecimal) objs[28]).longValue());
				si.setIfinerrorsVary(objs[29] == null ? null : ((BigDecimal) objs[29]).longValue());
				si.setIfouterrorsVary(objs[30] == null ? null : ((BigDecimal) objs[30]).longValue());
				si.setIfHighSpeed(objs[31] == null ? null : ((BigDecimal) objs[31]).longValue());
				si.setData64Flag(objs[32] == null ? 0 : ((BigDecimal) objs[32]).intValue());
				siList.add(si);
			}
			int thisIfindex = 0;
			// String this
			List<SwitchPortInfo> spiList = new ArrayList<SwitchPortInfo>();
			// detailPortInfo2("GigabitEthernet0/13","DI_SWITCHPORT",Long.parseLong(checkDate),null);
			for (int i = 0; i < siList.size(); i++) {
				SwitchPortInfoSource news = siList.get(i);
				thisIfindex = news.getIfIndex();
				SwitchPortInfoSource olds = null;
				i++;
				if (i < siList.size()) {
					olds = siList.get(i);
					if (olds != null && thisIfindex == olds.getIfIndex()) {
						spiList.add(resetData(olds, news));
					} else {
						i--;
					}
				}
			}

			getRequest().setAttribute("totalSiList", spiList);
			// 获取节点ip
			ip = getIpBySeqId(seqId);
			getRequest().setAttribute("switchIp", ip);
			getRequest().setAttribute("detectId", detectId);
			getRequest().setAttribute("seqId", seqId);
			getRequest().setAttribute("checkDate", checkDate);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}

		return "siStatisticsList";
	}

	private String getSqlOfSwitchInfoList(String checkDate, String detectId, String seqId) {
		String datasSql = "";
		if (StringUtils.isNotBlank(checkDate) && StringUtils.isNotBlank(detectId) && StringUtils.isNotBlank(seqId)) {
			String dataCheckTimeTmp = DateUtil.longToDate(Long.parseLong(checkDate), "yyyy-MM-dd HH:mm:ss");
			String dataCheckTimeTmp2 = DateUtil.longToDate((Long.parseLong(checkDate) - 1000), "yyyy-MM-dd HH:mm:ss");
			// 数据查询sql
			datasSql = "select  dspRlt.ifindex," + " dspRlt.ifdescr," + " dspRlt.iftype," + " dspRlt.ifmtu,"
					+ " dspRlt.ifspeed," + " dspRlt.ifphysaddress," + " dspRlt.ifadminstatus," + " dspRlt.ifoperstatus,"
					+ " dspRlt.iflastchange," + " dspRlt.ifinoctets," + " dspRlt.ifinucastpkts,"
					+ " dspRlt.ifinnucastpkts," + " dspRlt.ifindiscards," + " dspRlt.ifinerrors,"
					+ " dspRlt.ifinunknownprotos," + " dspRlt.ifoutoctets," + " dspRlt.ifoutucastpkts,"
					+ " dspRlt.ifoutnucastpkts," + " dspRlt.ifoutdiscards," + " dspRlt.ifouterrors,"
					+ " dspRlt.ifoutqlen," + " dspRlt.ifspecific," + " dspRlt.data_check_time_digital,"
					+ " dspRlt.INOCTETSSPEED," + " dspRlt.OUTOCTETSSPEED," + " dspRlt.INPKTSSPEED,"
					+ " dspRlt.OUTPKTSSPEED," + " dspRlt.IFINDISCARDS_VARY," + " dspRlt.IFOUTDISCARDS_VARY,"
					+ " dspRlt.IFINERRORS_VARY," + " dspRlt.IFOUTERRORS_VARY," + " dspRlt.IFHIGHSPEED,"
					+ " dspRlt.DATA_64_FLAG," + " dspRlt.data_check_time " + " from (" + " select " + "dsp.ifindex," + // 0
					"dsp.ifdescr," + // 1
					"dsp.iftype," + // 2
					"dsp.ifmtu," + // 3
					"dsp.ifspeed," + // 4
					"dsp.ifphysaddress," + // 5
					"dsp.ifadminstatus," + // 6
					"dsp.ifoperstatus," + // 7
					"dsp.iflastchange," + // 8
					"dsp.ifinoctets," + // 9
					"dsp.ifinucastpkts," + // 10
					"dsp.ifinnucastpkts," + // 11
					"dsp.ifindiscards," + // 12
					"dsp.ifinerrors," + // 13
					"dsp.ifinunknownprotos," + // 14
					"dsp.ifoutoctets," + // 15
					"dsp.ifoutucastpkts," + // 16
					"dsp.ifoutnucastpkts," + // 17
					"dsp.ifoutdiscards," + // 18
					"dsp.ifouterrors," + // 10
					"dsp.ifoutqlen," + // 20
					"dsp.ifspecific," + // 21
					"dsp.data_check_time_digital, " + // 22
					"dsp.INOCTETSSPEED, " + // 23
					// "dsp.INERRORSSCALE, " +
					"dsp.OUTOCTETSSPEED, " + // 24
					// "dsp.OUTERRORSSCALE, " +
					// "dsp.IFINDISCARDSPERC, " +
					// "dsp.IFOUTDISCARDSPERC, " +
					"dsp.INPKTSSPEED, " + // 25
					"dsp.OUTPKTSSPEED, " + // 26
					"dsp.IFINDISCARDS_VARY, " + // 27
					"dsp.IFOUTDISCARDS_VARY, " + // 28
					"dsp.IFINERRORS_VARY, " + // 29
					"dsp.IFOUTERRORS_VARY, " + // 30
					"dsp.IFHIGHSPEED, " + // 31
					"dsp.DATA_64_FLAG, " + // 32
					"dsp.data_check_time" + // 33
					" from di_switchport dsp " +
					// "left join detection_info di on di.id =
					// dsp.detection_info_id " +
					" where dsp.detection_set_info_id = " + detectId + " and dsp.seq_id = " + seqId
					/*
					 * +
					 * " and (dsp.data_check_time = (select dsTmp.data_check_time "
					 * + " from (select ds.data_check_time " +
					 * "       from di_switchport ds" +
					 * "       where  ds.detection_set_info_id= " + detectId +
					 * "              and ds.seq_id= " + seqId +
					 * "       and ds.data_check_time<=to_date('" +
					 * dataCheckTimeTmp2 +"','yyyy-MM-dd HH24:mi:ss')" +
					 * "       order by ds.data_check_time desc" + " ) dsTmp" +
					 * " where rownum=1 " + " ) "
					 */
					// @2018年4月10日18:34:10 fang 修改 rownum 适配mysql
					+ " and (dsp.data_check_time = (select max(dsTmp.data_check_time) "
					+ " from (select ds.data_check_time " + "       from di_switchport ds"
					+ "       where  ds.detection_set_info_id= " + detectId + "              and ds.seq_id= " + seqId
					+ "       and ds.data_check_time<=to_date('" + dataCheckTimeTmp2 + "','yyyy-MM-dd HH24:mi:ss')"
					+ " ) dsTmp" + " ) "

					+ " or dsp.data_check_time = to_date('" + dataCheckTimeTmp + "','yyyy-MM-dd HH24:mi:ss') " + " )"
					+ " order by dsp.ifdescr asc,dsp.data_check_time desc " + " )dspRlt "
					+ " left join (select nfi.name_flag  " + " from node_figure_info nfi "
					+ " left join device_type_info dti on dti.device_type_code=nfi.device_type_code "
					+ " where (lower(dti.di_table_name) ='di_switchport' ) " + " and nfi.is_leaf=1  "
					+ " and  nfi.seqid=" + seqId + "  ) deviceTmp  " + " on deviceTmp.name_flag=dspRlt.ifdescr"
					+ "  where deviceTmp.name_flag is not null ORDER BY dspRlt.ifindex,dspRlt.data_check_time desc";
		}

		return datasSql;
	}

	/**
	 * 
	 * @time Apr 22, 2013-1:22:34 PM
	 * @param siList
	 */
	public SwitchPortInfo resetData(SwitchPortInfoSource old, SwitchPortInfoSource news) {
		SwitchPortInfo portInfo = new SwitchPortInfo();

		// 存值
		portInfo.setLastLongTime(old.getLastLongTime());
		portInfo.setIfSpeedStr(news.getIfSpeedStr());
		portInfo.setIfHighSpeed(news.getIfHighSpeed());
		portInfo.setIfIndex(news.getIfIndex());
		portInfo.setIfDescr(news.getIfDescr());
		portInfo.setIfType(news.getIfType());
		portInfo.setIfMtu(news.getIfMtu());
		portInfo.setIfSpeed(news.getIfSpeed());
		portInfo.setIfPhysAddress(news.getIfPhysAddress());
		portInfo.setIfAdminStatus(news.getIfAdminStatus());
		portInfo.setIfOperStatus(news.getIfOperStatus());
		portInfo.setIfLastChange(news.getIfLastChange());
		portInfo.setIfLastChangeStr(news.getIfLastChangeStr());

		portInfo.setIfInOctets(news.getIfInOctets() == null ? null : news.getIfInOctets().longValue());
		portInfo.setIfInUcastPkts(news.getIfInUcastPkts() == null ? 0 : news.getIfInUcastPkts().longValue());
		portInfo.setIfInNUcastPkts(news.getIfInNUcastPkts() == null ? 0 : news.getIfInNUcastPkts().longValue());
		portInfo.setIfInDiscards(news.getIfInDiscards() == null ? 0 : news.getIfInDiscards().longValue());
		portInfo.setIfInErrors(news.getIfInErrors() == null ? 0 : news.getIfInErrors().longValue());
		portInfo.setIfInUnknownProtos(
				news.getIfInUnknownProtos() == null ? 0 : news.getIfInUnknownProtos().longValue());
		portInfo.setIfOutOctets(news.getIfOutOctets() == null ? 0 : news.getIfOutOctets().longValue());
		portInfo.setIfOutUcastPkts(news.getIfOutUcastPkts() == null ? 0 : news.getIfOutUcastPkts().longValue());
		portInfo.setIfOutNUcastPkts(news.getIfOutNUcastPkts() == null ? 0 : news.getIfOutNUcastPkts().longValue());
		portInfo.setIfOutDiscards(news.getIfOutDiscards() == null ? 0 : news.getIfOutDiscards().longValue());
		portInfo.setIfOutErrors(news.getIfOutErrors() == null ? 0 : news.getIfOutErrors().longValue());
		portInfo.setIfOutQLen(news.getIfOutQLen() == null ? 0 : news.getIfOutQLen().longValue());

		portInfo.setIfSpecific(news.getIfSpecific());

		portInfo.setIfindiscardsVary(news.getIfindiscardsVary());
		portInfo.setIfoutdiscardsVary(news.getIfoutdiscardsVary());
		portInfo.setIfinerrorsVary(news.getIfinerrorsVary());
		portInfo.setIfouterrorsVary(news.getIfouterrorsVary());
		portInfo.setIfInOctetsSpeed(news.getIfInOctetsSpeed());
		portInfo.setInpktsspeed(news.getInpktsspeed());
		portInfo.setIfOutOctetsSpeed(news.getIfOutOctetsSpeed());
		portInfo.setOutpktsspeed(news.getOutpktsspeed());

		if (news == null || old == null || news.getLastLongTime() == null || old.getLastLongTime() == null) {
			return portInfo;
		}

		double ifInDiscards_n = news.getIfInDiscards() == null ? 0 : news.getIfInDiscards();
		double ifInDiscards_o = old.getIfInDiscards() == null ? 0 : news.getIfInDiscards();

		double ifOutDiscards_n = news.getIfOutDiscards() == null ? 0 : news.getIfOutDiscards();
		double ifOutDiscards_o = old.getIfOutDiscards() == null ? 0 : news.getIfOutDiscards();

		double ifInErrors_n = news.getIfInErrors() == null ? 0 : news.getIfInErrors();
		double ifInErrors_o = old.getIfInErrors() == null ? 0 : news.getIfInErrors();

		double ifOutErrors_n = news.getIfOutErrors() == null ? 0 : news.getIfOutErrors();
		double ifOutErrors_o = old.getIfOutErrors() == null ? 0 : news.getIfOutErrors();

		/* 丢包数 */
		double dInDiscardsL = (ifInDiscards_n - ifInDiscards_o);
		if (dInDiscardsL < 0) {
			dInDiscardsL = 0d;
		}
		portInfo.setIfindiscardsVary(new Double(dInDiscardsL).longValue());

		double dOutDiscardsL = (ifOutDiscards_n - ifOutDiscards_o);
		if (dOutDiscardsL < 0) {
			dOutDiscardsL = 0d;
		}
		portInfo.setIfindiscardsVary(new Double(dOutDiscardsL).longValue());
		/* 丢包数 end */
		/* 错包数 */
		double dInErrorsL = (ifInErrors_n - ifInErrors_o);
		if (dInErrorsL < 0) {
			dInErrorsL = 0d;
		}
		portInfo.setIfindiscardsVary(new Double(dInErrorsL).longValue());

		double dOutErrorsL = (ifOutErrors_n - ifOutErrors_o);
		if (dOutErrorsL < 0) {
			dOutErrorsL = 0d;
		}
		portInfo.setIfindiscardsVary(new Double(dOutErrorsL).longValue());
		/* 错包数 end */

		boolean dataFlag64 = true;
		double value64 = (1d + Long.MAX_VALUE) * 2;
		int flag = news.getData64Flag();
		long waitTime = 15 * 60 * 1000l; // ms

		if (flag == 0) {
			dataFlag64 = false;
			return portInfo;
		}

		waitTime = (news.getLastLongTime() - old.getLastLongTime());

		// 非64位不计算
		if (dataFlag64 && waitTime != 0) {// 由于会存在2个主板，其端口名相同，如都是meth0_0，所以计算的时候会出现waitTime为0，此时取news的值
			/**
			 * 二次计算 平均输入速率=△ifInOctets/T 平均输出速率=△ifOutOctets/T
			 * 平均收包速率=（△ifInUcastPkts+△ifInNucastPkts）/T
			 * 平均发包速率=（△ifOutUcastPks+△ifOutNucastPks）/T
			 */
			Double ifInOctets_n = news.getIfInOctets();
			Double ifInUcastPkts_n = news.getIfInUcastPkts();
			Double ifInNucastPkts_n = news.getIfInNUcastPkts();

			Double ifOutOctets_n = news.getIfOutOctets();
			Double ifOutUcastPkts_n = news.getIfOutUcastPkts();
			Double ifOutNucastPkts_n = news.getIfOutNUcastPkts();

			Double ifInOctets_o = old.getIfInOctets();
			Double ifInUcastPkts_o = old.getIfInUcastPkts();
			Double ifInNucastPkts_o = old.getIfInNUcastPkts();

			Double ifOutOctets_o = old.getIfOutOctets();
			Double ifOutUcastPkts_o = old.getIfOutUcastPkts();
			Double ifOutNucastPkts_o = old.getIfOutNUcastPkts();

			/* 平均输入速率=△ifInOctets/T 单位：bps */
			double dInOctetsL = (ifInOctets_n - ifInOctets_o);
			// 非负数处理
			if (dInOctetsL < 0) {
				dInOctetsL += value64;
			}
			BigDecimal ifInOctetsSpeed = new BigDecimal(dInOctetsL * 1000).divide(new BigDecimal(waitTime), 2,
					RoundingMode.HALF_UP);

			/* 平均输出速率=△ifOutOctets/T 单位：bps */
			double dOutOctetsL = (ifOutOctets_n - ifOutOctets_o);
			// 非负数处理
			if (dOutOctetsL < 0) {
				dOutOctetsL += value64;
			}
			BigDecimal ifOutOctetsSpeed = new BigDecimal(dOutOctetsL * 1000).divide(new BigDecimal(waitTime), 2,
					RoundingMode.HALF_UP);

			/* 平均收包速率=（△ifInUcastPkts+△ifInNucastPkts）/T 单位：pps */
			double iupks = ifInUcastPkts_n - ifInUcastPkts_o;
			if (iupks < 0) {
				if (dataFlag64) { // 64位数据
					iupks += value64;
				}
			}

			double inupks = ifInNucastPkts_n - ifInNucastPkts_o;
			if (inupks < 0) {
				if (dataFlag64) { // 64位数据
					inupks += value64;
				}
			}
			double dInPks = iupks + inupks;

			BigDecimal inPksSpeed = new BigDecimal(dInPks * 1000).divide(new BigDecimal(waitTime), 2,
					RoundingMode.HALF_UP);

			// logger.debug("in
			// data:>"+"("+ifInUcastPkts_n+"-"+ifInUcastPkts_o+")+("+ifInNucastPkts_n+"-"+ifInNucastPkts_o+")="+((ifInUcastPkts_n
			// - ifInUcastPkts_o)+(ifInNucastPkts_n - ifInNucastPkts_o))+" /
			// timss"+waitTime+" values "+ (new
			// BigDecimal(dInPks*1000).divide(new BigDecimal(waitTime),2,
			// RoundingMode.HALF_UP)));

			/* 平均发包速率=（△ifOutUcastPks+△ifOutNucastPks）/T 单位：pps */
			double oupks = ifOutUcastPkts_n - ifOutUcastPkts_o;
			if (oupks < 0) {
				if (dataFlag64) { // 64位数据
					oupks += value64;
				}
			}

			double onupks = ifOutNucastPkts_n - ifOutNucastPkts_o;
			if (onupks < 0) {
				if (dataFlag64) { // 64位数据
					onupks += value64;
				}
			}
			double dOutPks = oupks + onupks;

			BigDecimal outPksSpeed = new BigDecimal(dOutPks * 1000).divide(new BigDecimal(waitTime), 2,
					RoundingMode.HALF_UP);
			// logger.debug("outdata:>"+"("+ifOutUcastPkts_n+"-"+ifOutUcastPkts_o+")+("+ifOutNucastPkts_n+"-"+ifOutNucastPkts_o+")="+((ifOutUcastPkts_n
			// - ifOutUcastPkts_o)+(ifOutNucastPkts_n - ifOutNucastPkts_o))+" /
			// timss"+waitTime+" values "+ (new
			// BigDecimal(dOutPks*1000).divide(new BigDecimal(waitTime),2,
			// RoundingMode.HALF_UP)));
			// -- 计算输入输出速度

			double ifinoctetsspeed_a = ifInOctetsSpeed.doubleValue(); // --单位bps
			double ifoutoctetsspeed_a = ifOutOctetsSpeed.doubleValue(); // --单位bps

			Double inPksSpeed_a = inPksSpeed.doubleValue(); // --单位pps
			if (inPksSpeed_a * minPacketSize > ifinoctetsspeed_a) {
				logger.debug("端口数据计算抛弃数据-------");
				logger.debug("端口数据计算抛弃数据：时间：（" + news.getLastLongTime() + "-" + old.getLastLongTime() + ")");
				logger.debug("端口数据计算抛弃数据：输入包速度与输入字节速度计算式：（" + inPksSpeed_a + " * " + minPacketSize + " > "
						+ ifinoctetsspeed_a + ")");
				logger.debug("端口数据计算抛弃数据-------");
				inPksSpeed_a = null;
			}

			Double outPksSpeed_a = outPksSpeed.doubleValue(); // --单位pps
			if (outPksSpeed_a * minPacketSize > ifoutoctetsspeed_a) {
				logger.debug("端口数据计算抛弃数据-------");
				logger.debug("端口数据计算抛弃数据：时间：（" + news.getLastLongTime() + "-" + old.getLastLongTime() + ")");
				logger.debug("端口数据计算抛弃数据：输出包速度与输入字节速度计算式：（" + outPksSpeed_a + " * " + minPacketSize + " > "
						+ ifoutoctetsspeed_a + ")");
				logger.debug("端口数据计算抛弃数据-------");
				outPksSpeed_a = null;
			}

			double maxSpeed = (portInfo.getIfHighSpeed() == null || portInfo.getIfHighSpeed().longValue() == 0)
					? portInfo.getIfSpeed() : portInfo.getIfHighSpeed().longValue() * 1024 * 1024;

			// 带宽范围内的值 更新
			if (ifinoctetsspeed_a < maxSpeed) {
				portInfo.setIfInOctetsSpeed(ifinoctetsspeed_a);
			} else {
				logger.debug("端口数据计算抛弃数据-------");
				logger.debug("端口数据计算抛弃数据：时间：（" + news.getLastLongTime() + "-" + old.getLastLongTime() + ")");
				logger.debug("端口数据计算抛弃数据：输入字节速度和带宽：（" + ifinoctetsspeed_a + " vs " + maxSpeed + ")");
				logger.debug("端口数据计算抛弃数据-------");
				portInfo.setIfInOctetsSpeed(null);
			}
			// System.out.println(" date "+portInfo.getIfDescr()+"
			// "+portInfo.getIfInOctetsSpeed() +" "+ifinoctetsspeed_a);

			// 带宽范围内的值 更新
			if (ifoutoctetsspeed_a < maxSpeed) {
				portInfo.setIfOutOctetsSpeed(ifoutoctetsspeed_a);
			} else {
				logger.debug("端口数据计算抛弃数据-------");
				logger.debug("端口数据计算抛弃数据：时间：（" + news.getLastLongTime() + "-" + old.getLastLongTime() + ")");
				logger.debug("端口数据计算抛弃数据：输出字节速度和带宽：（" + ifoutoctetsspeed_a + " vs " + maxSpeed + ")");
				logger.debug("端口数据计算抛弃数据-------");
				portInfo.setIfOutOctetsSpeed(null);
			}
			portInfo.setInpktsspeed(inPksSpeed_a);
			portInfo.setOutpktsspeed(outPksSpeed_a);

		}

		return portInfo;
	}

	/**
	 * 2013-6-9 hyx 最新监测时间的获取：--端口的 监测正常:取最新的监测时间 超周期:取当前时间
	 * 
	 */
	public void switchDetectInfoGraph() {
		try {
			if (StringUtils.isNotBlank(seqId) && StringUtils.isNotBlank(detectId)) {
				// 第一步：节点未配置相应图形则返回
				String hasNodeSql = "SELECT DEVICE_TYPE_CODE FROM NODE_FIGURE_INFO T WHERE T.SEQID=" + seqId;
				List<Object[]> hasNodeList = commonService.executeSQL(hasNodeSql);
				if (hasNodeList == null || hasNodeList.size() == 0) {
					outHtmlString("<script type=\"text/javascript\">alert('i18n_SwitchDetectionAction.emportXls.noPictore_n81i');"
							+ "this.location='switchDetection.do?action=query';</script>");
				}

				// 第二步:查询当前节点有哪些监测信息
				String searchDetectTableInfoSql = " SELECT DISTINCT DTI.DI_TABLE_NAME,DTI.INDEX_FILED,"
						+ "                               DTI.STATUS_FILED,DTI.STATUS_SYMBOLS,"
						+ "                               DTI.STATUS_VALUE"
						+ " 					FROM NODE_FIGURE_INFO T"
						+ " 					LEFT JOIN DEVICE_TYPE_INFO DTI"
						+ " 					ON T.DEVICE_TYPE_CODE=DTI.DEVICE_TYPE_CODE"
						+ " 					WHERE DTI.DI_TABLE_NAME IS NOT NULL and DTI.DI_TABLE_NAME != '' "
						+ "                           AND SEQID=" + seqId;

				logger.info("操作记录：统计当前节点有哪些监测" + searchDetectTableInfoSql);
				List<Object[]> detectTableInfoList = commonService.executeSQL(searchDetectTableInfoSql);

				/**
				 * 第三步：更新节点表：不更新node_figure_info表，只将node_figure_info表和di_switchport表进行连接，生成NodeFigureInfo对象列表:
				 * 只关注人工设置为up的端口，人工设置为down的端口无端口图片显示 人工设置为up的端口，根据端口状态显示端口图片：
				 * 1：绿色，正常 0：红色，异常
				 */
				logger.info("操作记录：开始更新node_figure_info监测信息。。。");
				Long diSwitchportCheckTimeDigital = null;
				Long diSwitchportCheckGap = null;
				List<NodeFigureInfo> list = getNodeFigureInfoList(seqId);
				for (Object[] objs : detectTableInfoList) {
					String detailTabName = objs[0] == null ? "" : objs[0].toString();// 详细监测信息的表名
					String indexFiled = objs[1] == null ? "" : objs[1].toString();// 对应node_figure_info表的nameFlag字段
					String statusFiled = objs[2] == null ? "" : objs[2].toString();// 监测状态字段
					String statusSymbols = objs[3] == null ? "" : objs[3].toString();// 判断监测异常的操作
					String statusValue = objs[4] == null ? "" : objs[4].toString();// 监测异常的值

					if (!Constants.DI_SYSTEM_TABLE_NAME.equalsIgnoreCase(detailTabName)) {// 设备都有的公共的信息：系统基础信息和端口信息
						Long checkTimeDigital = getLatestDetectTimeDigitalBySeqId(detailTabName, seqId);// 从detailTabName表查询seqId的最新的监测时间
						Long checkGap = getLatestCheckGapBySeqId(detailTabName, seqId);// 从详细监测信息表中获得监测设置id，再获得监测设置的监测周期：分钟
						if (Constants.DI_SWITCHPORT_TABLE_NAME.equalsIgnoreCase(detailTabName)
								&& StringUtils.isNotBlank(indexFiled)) {// 交换机端口监测信息
																		// 更新node_figure_info表中的设备状态信息及显示的图片-端口信息
							diSwitchportCheckTimeDigital = checkTimeDigital;
							diSwitchportCheckGap = checkGap;
							updateNodeFigureInfo(detailTabName, checkTimeDigital, indexFiled, checkGap, list);
							// statisticSysStatus(detailTabName,
							// checkTimeDigital, indexFiled);// 统计系统状态

							// pid=0表示当前设备为顶级设备，测试默认展示系统基本信息
							if (pid != null && "0".equals(pid)) {
								// 查询系统基本信息
								logger.info("操作记录：开始查询系统基础信息。。。");
								searchSysInfo(detailTabName, checkTimeDigital, checkGap);// checkTimeDigital为当前周期

							} else if (isLeaf != null && "1".equals(isLeaf)) {// isLeaf=1表示为叶子节点
																				// 查询系统基本信息
								logger.info("操作记录：开始查询系统基础信息。。。");
								searchSysInfo(detailTabName, checkTimeDigital, checkGap);
								// 查询端口的详细信息
								if (StringUtils.isNotBlank(nameFlag)) {
									logger.info("操作记录：开始查询节点" + nameFlag + "相关信息。。。");
									detailPortInfo2(nameFlag, detailTabName, checkTimeDigital, checkGap);// 交换机端口信息才需要
								}
							} else {// 查询系统基本信息
								logger.info("操作记录：开始查询系统基础信息。。。");
								searchSysInfo(detailTabName, checkTimeDigital, checkGap);
								pid = "0";
							}
						} else if (StringUtils.isNotBlank(detailTabName) && StringUtils.isNotBlank(indexFiled)) {
							// 更新node_figure_info表中的设备状态信息及显示的图片-电源、风扇等
							updateNodeFigureInfo(detailTabName, checkTimeDigital, indexFiled, statusFiled,
									statusSymbols, statusValue, checkGap, list);
							// statisticSysStatus(detailTabName,
							// checkTimeDigital,
							// indexFiled,
							// statusFiled,
							// statusSymbols,
							// statusValue);// 统计系统状态
						}

					}

				}

				// 第四步：系统状态的判断：从告警列表中查询
				sysStatusFlag = !isAbnormal(ip);
				if (sysStatusFlag) {
					diSystem.setSysStatus(getI18nText("i18n_SwitchDetectionAction.emportXls.normal_n81i"));
				} else {
					// sysStatus = sysStatus.contains("，") ? "："+
					// sysStatus.substring(0,
					// sysStatus.length() - 1) : sysStatus;
					// param = "&nameFlag=" + nameFlag + "&pid=" + pid +
					// "&isLeaf=" + isLeaf +
					// "&picId=" + picId
					// +
					// "&queryParConditionDisplay=&queryChildConditionDisplay=none";//
					// 点击异常时，一定是端口页面收缩，系统基础信息页面打开+"
					diSystem.setSysStatus(
							"<a href='javascript:toWarningList();'><font color='red'><strong>i18n_SwitchDetectionAction.emportXls.exception_n81i</strong></font></a>");
				}

				// 第五步：生成svg文件
				if (list != null && list.size() > 0) {
					// 此处比较费时
					detailAllPortInfo(diSwitchportCheckTimeDigital, diSwitchportCheckGap);// 需要查询每个端口的带宽、输入、输出的bps、pps
					logger.info("操作记录：开始生成svg文件。。。");
					generSwitchGraphXmlFile(list);
				}

				// 第六步：界面设备显示位置及宽高的确定：根据设备的数量及宽高
				logger.info("操作记录：查询共有几个物理设备，得到设备总高度（或者宽度）。。。");
				String devNumHql = "from NodeFigureInfo where seqid=" + seqId + " and pid=0 order by showIndex asc";// order
																													// by
				// showIndex
				// asc:查询第一个设备的
				List<NodeFigureInfo> devNumList = (List<NodeFigureInfo>) this.commonService.find(devNumHql);
				if (devNumList != null && devNumList.size() > 0) {
					devNum = devNumList.size();
					NodeFigureInfo nodeTmp = devNumList.get(0);
					Long devHeight = nodeTmp.getFigureHeight() == null ? 0 : nodeTmp.getFigureHeight();
					Long devY = nodeTmp.getFigureY() == null ? 0 : nodeTmp.getFigureY();
					devHeightSum = (devNum * (devHeight + deviceShowGap) + devY + 10) + "";
					devScrollHeight = ((devNum - 1) * (devHeight + deviceShowGap) + devY + 1500) + "";// 设置的大一些，也可以
				}
				// 保证可以正常显示提示信息（tooltip）
				if (Integer.parseInt(devHeightSum) < 600) {
					devHeightSum = "600";
				}
			}
		} catch (Exception e) {
			logger.error("Abnormal display of network element monitoring information", e);
		}

	}

	// 查询节点是否有异常信息
	private boolean isAbnormal(String cip) {
		boolean isAbnormalFlag = false;
		try {
			if (StringUtils.isNotBlank(cip)) {
				/*
				 * StringBuffer sqlBuffer = new StringBuffer();
				 * sqlBuffer
				 * .append(" select * from   (select row_number() over (PARTITION BY newTable.ip,newTable.iden order by newTable.dctime desc, newTable.ip) LEV, newTable.* FROM ("
				 * ); sqlBuffer
				 * .append(" select distinct din.id,nt.node_ip ip,cti.check_type_name1,dsi.PROCESS_IDEN_NAME iden,din.detectioned_state"
				 * ); sqlBuffer
				 * .append(",to_char(din.data_check_time,'yyyy-MM-dd HH24:mi:Ss') dctime,'',din.current_times,din.detection_state_info,to_char(din.status_change_time,'yyyy-MM-dd HH24:mi:Ss')"
				 * ); sqlBuffer
				 * .append(",dsi.id dsiiId,cti.id ctiId,din.seq_id sqId,nt.node_system_type nodeSysType,nvl(checkTypeCharState.charStateNum,0) charStateNum,nt.node_type nodeType,nt.ipn ipn, din.police_level police_level"
				 * );
				 * 
				 * sqlBuffer.append(" from DETECTION_INFO_NEW din");
				 * sqlBuffer.
				 * append(" left join DETECTION_SET_INFO dsi");
				 * sqlBuffer.
				 * append(" on din.detection_set_info_id = dsi.id");
				 * sqlBuffer.append(" left join check_type_info cti"
				 * );
				 * sqlBuffer.append(" on dsi.check_type_id = cti.id"
				 * ); sqlBuffer
				 * .append(" left join (select distinct node_ip,seq_id,node_system_type,node_type,node_state,system_id,ipn from  NODE_TABLE) nt"
				 * );
				 * sqlBuffer.append(" on din.seq_id = nt.seq_id");
				 * // ------------2013-1-23 hyx //
				 * 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------
				 * start sqlBuffer.append(" left join "); sqlBuffer
				 * .append("  (select md.check_type_id as ctId,count(*) as charStateNum  from metadata md  where md.chart_state=0  group by md.check_type_id) checkTypeCharState "
				 * ); sqlBuffer.
				 * append(" on checkTypeCharState.ctId=cti.id "); //
				 * ------------2013-1-23 hyx //
				 * 对于无统计字段的监测类型，在监测数据列表里不显示折线图链接------------------
				 * end
				 * 
				 * sqlBuffer
				 * .append(" where nt.node_ip is not null "); //
				 * in('0','-1') if
				 * (!this.getAdminMark()) {
				 * sqlBuffer.append(" and nt.system_id = ");
				 * sqlBuffer.append(this.getSystemID()); } // if
				 * (cip != null && !"".equals(cip) &&
				 * !"null".equals(cip)) { // } if
				 * (!this.getAdminMark()) { //
				 * 权限控制------begin // String sqlparam =
				 * " or (cti.view_level=4 )";
				 * 
				 * sqlBuffer .append("and (( cti.view_level=1 and
				 * cti.user_id=" + this.getUserID() + ")" + " or (
				 * cti.view_level=2 and cti.group_id in (select
				 * x.jsbh from Xt_Yh_Js_Index x where x.yhbh='" +
				 * this.getUser().getYhbh() + "' and x.type = 1)) or
				 * (cti.view_level=3 and cti.system_id = " +
				 * this.getSystemID() + ")" + sqlparam + ") ");
				 * 
				 * // -------------end sqlBuffer.
				 * append(" and (((( cti.view_level=1 and cti.user_id="
				 * ); sqlBuffer.append(this.getUserID());
				 * sqlBuffer.append(")"); sqlBuffer
				 * .append(" or ( cti.view_level=2 and cti.group_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='"
				 * ); sqlBuffer.append(this.getUser().getYhbh());
				 * sqlBuffer
				 * .append("' and x.type = 1)) or cti.view_level=3 ) and cti.system_id = "
				 * ); sqlBuffer.append(this.getSystemID());
				 * sqlBuffer.append(")");
				 * sqlBuffer.append(" or (cti.view_level=4 )");
				 * sqlBuffer.append(") ");
				 * 
				 * sqlBuffer.
				 * append("and (((( dsi.view_level=1 and dsi.create_user_id="
				 * ); sqlBuffer.append(this.getUserID());
				 * sqlBuffer.append(")"); sqlBuffer
				 * .append(" or ( dsi.view_level=2 and dsi.create_usergroup_id in (select  x.jsbh from  Xt_Yh_Js_Index  x  where x.yhbh='"
				 * ); sqlBuffer.append(this.getUser().getYhbh());
				 * sqlBuffer
				 * .append("' and x.type = 1)) or dsi.view_level=3 ) and dsi.system_id = "
				 * ); sqlBuffer.append(this.getSystemID());
				 * sqlBuffer.append(")");
				 * sqlBuffer.append(" or (dsi.view_level=4 )");
				 * sqlBuffer.append(")   ");//and
				 * dsi.detection_set_state=1 and cti.crete_state=0
				 * 
				 * } sqlBuffer.
				 * append(" AND nt.node_type =1 and nt.node_state = 0 and dsi.detection_set_state ='1'  and cti.crete_state=0  and din.valid=1 AND din.detectioned_state in('0','-1') and nt.node_ip = '"
				 * + cip + "'");//
				 * 只显示有效的数据：din.valid=1,只查询异常的数据（不关心已经恢复正常的监测）：
				 * detectioned_state // sqlBuffer.
				 * append(" order by police_level ASC, ipn ASC,cti.id ASC, dsi.id ASC"
				 * );//不需要排序，会降低速度
				 * sqlBuffer.append(" ) newTable ) WHERE LEV =1");
				 * System.out.println("sqlBuffer:" +
				 * sqlBuffer.toString()); List list =
				 * this.commonService.executeSQL(sqlBuffer.toString(
				 * )); if (list != null && list.size() > 0) {
				 * isAbnormalFlag = true; }
				 */

				//添加一个虚列，hibernate bug 当只有一条数据且 只有一个字段 返回类型为数组
				StringBuffer sqlBuffer = new StringBuffer();
				sqlBuffer.append(" select count(1) , 1 from   (select newTable.ip,newTable.iden FROM (");
				sqlBuffer.append(" select distinct din.id,nt.node_ip ip,cti.check_type_name1,dsi.PROCESS_IDEN_NAME iden,din.detectioned_state");
				sqlBuffer.append(",to_char(din.data_check_time,'yyyy-MM-dd HH24:mi:Ss') dctime,din.current_times,din.detection_state_info,to_char(din.status_change_time,'yyyy-MM-dd HH24:mi:Ss')");
				sqlBuffer.append(",dsi.id dsiiId,cti.id ctiId,din.seq_id sqId,nt.node_system_type nodeSysType,nvl(checkTypeCharState.charStateNum,0) charStateNum,nt.node_type nodeType,nt.ipn ipn, din.police_level police_level");

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

				sqlBuffer.append(" where nt.node_ip is not null ");
				if (!this.getAdminMark()) {
					sqlBuffer.append(" and nt.system_id = ");
					sqlBuffer.append(this.getSystemID());
				}

				if (!this.getAdminMark()) {
					// 权限控制------begin
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
					sqlBuffer.append(")   ");// and dsi.detection_set_state=1
				}
				sqlBuffer
						.append(" AND nt.node_type =1 and nt.node_state = 0 and dsi.detection_set_state ='1'  and cti.crete_state=0  and din.valid=1 AND din.detectioned_state in('0','-1') and nt.node_ip = '"
								+ cip + "'");// 只显示有效的数据：din.valid=1,只查询异常的数据（不关心已经恢复正常的监测）：detectioned_state
				// sqlBuffer.append(" order by police_level ASC, ipn ASC,cti.id
				// ASC, dsi.id ASC");//不需要排序，会降低速度
				sqlBuffer.append(" ) newTable group by newTable.ip,newTable.iden ) ttttt ");
				System.out.println("sqlBuffer:" + sqlBuffer.toString());
				List<Object[]> nodeTmp = this.commonService.executeSQL(sqlBuffer.toString());
				/*
				 * if (list != null && list.size() > 0) { isAbnormalFlag = true;
				 * }
				 */
				if (nodeTmp != null && nodeTmp.get(0)[0] != null && Long.valueOf(nodeTmp.get(0)[0].toString()) > 0) {
					isAbnormalFlag = true;
				}
			}
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_PoliceSetAction.queryPoliceSetInfo.faild_n81i');this.location='monitorData.do?action=query'</script>");
		}
		return isAbnormalFlag;

	}

	// 查询当前节点的所有设备实例
	private List<NodeFigureInfo> getNodeFigureInfoList(String seqId) {
		List<NodeFigureInfo> list = new ArrayList<NodeFigureInfo>();
		try {
			if (StringUtils.isNotBlank(seqId)) {
				String sql = "SELECT NFI.ID," + "            NFI.PID," + "            NFI.DEVICE_TYPE_CODE,"
						+ "            NFI.SEQID," + "            NFI.SHOW_LEVEL," + "            NFI.SHOW_INDEX,"
						+ "            NFI.NAME_FLAG," + "            NFI.PORT_OPER_STATUS,"
						+ "            NFI.PORT_STATUS," + "            NFI.FIGURE_TYPE," + "            NFI.FIGURE_X,"
						+ "            NFI.FIGURE_Y," + "            NFI.FIGURE_WIDTH,"
						+ "            NFI.FIGURE_HEIGHT," + "            NFI.FIGURE_STROKE,"
						+ "            NFI.FIGURE_STROKE_WIDTH," + "            NFI.FIGURE_FILL,"
						+ "            NFI.DATA_CHECK_TIME_DIGITAL,"
						+ "            TO_CHAR(NFI.ADD_TIME,'YYYY-MM-DD HH24:MI:SS')," + "            NFI.ADD_USERID,"
						+ "            TO_CHAR(NFI.LAST_UPDATE_TIME,'YYYY-MM-DD HH24:MI:SS'),"
						+ "            NFI.LAST_UPDATE_USERID," + "            NFI.FIGURE_FILL_MODEL,"
						+ "            NFI.IS_LEAF," + "            NFI.PORT_SET_STATE,"
						+ "            DTI.DI_TABLE_NAME" + "  FROM NODE_FIGURE_INFO NFI "
						+ "  LEFT JOIN DEVICE_TYPE_INFO DTI " + "  ON NFI.DEVICE_TYPE_CODE=DTI.DEVICE_TYPE_CODE "
						+ "  WHERE SEQID=" + seqId.trim()
						+ " AND ( NFI.IS_LEAF=0 OR (NFI.IS_LEAF=1 AND (PORT_SET_STATE=1 OR PORT_SET_STATE IS NULL)))    "
						+ "  ORDER BY SHOW_LEVEL ASC";// ,PID ASC,SHOW_INDEX
				// ASC
				// 排序是为了图片的显示，显示图片时，要先显示最顶级的图片，否则图片之间会有覆盖现象,只查询人工设置状态为up的端口(还包括板卡，机框，它们默认的port_set_status为1)

				List<Object[]> nodeTmp = this.commonService.executeSQL(sql);

				for (Object[] objs : nodeTmp) {
					NodeFigureInfo node = new NodeFigureInfo();
					node.setId(objs[0] == null ? null : Long.parseLong(objs[0].toString()));
					node.setPid(objs[1] == null ? null : Long.parseLong(objs[1].toString()));
					node.setDeviceTypeCode(objs[2] == null ? "" : objs[2].toString());
					node.setSeqid(objs[3] == null ? null : Long.parseLong(objs[3].toString()));
					node.setShowLevel(objs[4] == null ? null : Long.parseLong(objs[4].toString()));
					node.setShowIndex(objs[5] == null ? null : Long.parseLong(objs[5].toString()));
					node.setNameFlag(objs[6] == null ? "" : objs[6].toString());
					node.setPortOperStatus(objs[7] == null ? null : Long.parseLong(objs[7].toString()));
					node.setPortStatus(objs[8] == null ? null : Long.parseLong(objs[8].toString()));
					node.setFigureType(objs[9] == null ? "" : objs[9].toString());
					node.setFigureX(objs[10] == null ? null : Long.parseLong(objs[10].toString()));
					node.setFigureY(objs[11] == null ? null : Long.parseLong(objs[11].toString()));
					node.setFigureWidth(objs[12] == null ? null : Long.parseLong(objs[12].toString()));
					node.setFigureHeight(objs[13] == null ? null : Long.parseLong(objs[13].toString()));
					node.setFigureStroke(objs[14] == null ? "" : objs[14].toString());
					node.setFigureStrokeWidth(objs[15] == null ? null : Long.parseLong(objs[15].toString()));
					node.setFigureFill(objs[16] == null ? "" : objs[16].toString());
					node.setDataCheckTimeDigital(objs[17] == null ? null : Long.parseLong(objs[17].toString()));
					node.setAddTime(objs[18] == null ? null
							: new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(objs[18].toString()));
					node.setAddUserid(objs[19] == null ? null : Long.parseLong(objs[19].toString()));
					node.setLastUpdateTime(objs[20] == null ? null
							: new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(objs[20].toString()));
					node.setLastUpdateUserid(objs[21] == null ? null : Long.parseLong(objs[21].toString()));
					node.setFigureFillModel(objs[22] == null ? "" : objs[22].toString());
					node.setIsLeaf(objs[23] == null ? null : Long.parseLong(objs[23].toString()));
					node.setPortsetState(objs[24] == null ? null : Long.parseLong(objs[24].toString()));
					node.setDiTableName(objs[25] == null ? "" : objs[25].toString());

					list.add(node);
				}
			}
		} catch (Exception e) {
			logger.error("Query all the device instances of the current node", e);
		}

		return list;
	}

	// /**------------------------------备用
	// * 已知条件：seqId、detectId(公共的：交换机端口信息监测)，生成特殊设备图形: 0.节点未配置相应图形则返回 1.获取节点ip
	// * 2.获取当前监测数据（最新）的时间 3.查询当前节点有哪些监测信息，进行循环，更新node_figure_info表状态
	// * A:如果是di_switchport监测，则特殊处理，并查询系统的基础信息和点击端口的信息
	// *
	// (1).生成PORT_OPER_STATUS、PORT_STATUS及DATA_CHECK_TIME_DIGITAL(端口的展示图片也要根据监测数据自动生成)
	// * (2).图片端口显示： PORT_OPER_STATUS=2(down)：无图片，表示端口未接线
	// * PORT_OPER_STATUS=1（up），PORT_STATUS=1（正常：up）：绿色（再根据数据是否有问题来判断是否为红色）
	// * PORT_OPER_STATUS=1（up），PORT_STATUS=0（不正常：down）：黄色 (3).查询系统基本信息
	// * (4).计算系统的总输出速度、输入速度、收包速率、发包速率 (5).根据nameFlag查询端口的信息
	// * B:否则，则按指定的状态字段，更新node_figure_info表的图片（状态）
	// * 4.根据设备的seqid从表NODE_FIGURE_INFO中查询对应的信息，最终组成图形
	// * 5.根据查询的信息，生成一个svg的xml文件（生成到哪？每次看都要生成？还是生成一次后，每次用旧的？）
	// *
	// 7.生成新的图片的名字时，是根据数据库中原有的名字进行叠加的，但是执行过一次后，数据库的名字已经被叠加了，第二次再执行时，拼出的图片名字就有问题了，因为数据库里的图片名已经被改变了:
	// * 将svg的名字改为：seqId-setId.svg，(不用删除无用的svg文件)
	// *
	// * 2013-2-27 hyx
	// */
	// public void switchDetectInfoGraph()
	// {
	// try
	// {
	// if (StringUtils.isNotBlank(seqId) && StringUtils.isNotBlank(detectId))
	// {
	// // 节点未配置相应图形则返回
	// String hasNodeSql = "select * from node_figure_info t where t.seqid=" +
	// seqId;
	// List<Object[]> hasNodeList = commonService.executeSQL(hasNodeSql);
	// if (hasNodeList == null || hasNodeList.size() <= 0)
	// {
	// outHtmlString("<script
	// type=\"text/javascript\">alert('此节点未配置相应图形！');this.location='switchDetection.do?action=query';</script>");
	// }
	//
	// // 获取节点ip:有列表传递过来，不从数据库查询，加快速度
	// // ip = getIpBySeqId(seqId);
	// logger.info("操作记录：查询网元设备IP为：" + ip);
	//
	// // //获取node_figure_info数据的监测时间--要从node_figure_info表获取（可能不是最新的）
	// // String checkTimeSql = "select max(t.data_check_time_digital) from
	// // node_figure_info t where t.seqid="+seqId;
	// // List<Object[]> checkTimeList = commonService.executeSQL(checkTimeSql);
	// // if(checkTimeList!=null && checkTimeList.size()>0){
	// // Object checkTimeObj = checkTimeList.get(0);
	// // Long dataCheckTimeDigital =
	// // (checkTimeObj==null)?null:Long.valueOf(checkTimeObj.toString());
	// // dataCheckTime = DateUtil.longToDate(dataCheckTimeDigital, "yyyy-MM-dd
	// // HH:mm:ss");
	// // }
	// // logger.info("操作记录：查询网元设备最新监测时间为："+dataCheckTime);
	//
	// // 查询当前节点有哪些监测信息
	// String searchDetectTableInfoSql = " select distinct
	// dti.di_table_name,dti.index_filed,"
	// + " dti.status_filed,dti.status_symbols,"
	// + " dti.status_value"
	// + " from node_figure_info t"
	// + " left join device_type_info dti"
	// + " on t.device_type_code=dti.device_type_code"
	// + " where seqid="
	// + seqId + " and dti.di_table_name is not null";
	//
	// logger.info("操作记录：统计当前节点有哪些监测信息" + searchDetectTableInfoSql);
	//
	// List<Object[]> detectTableInfoList = commonService
	// .executeSQL(searchDetectTableInfoSql);
	// logger.info("操作记录：开始更新node_figure_info监测信息。。。");
	// for (Object[] objs: detectTableInfoList)
	// {
	// String detailTabName = objs[0] == null ? "" : objs[0].toString();//
	// 监测信息的表名
	// String indexFiled = objs[1] == null ? "" : objs[1].toString();//
	// 对应node_figure_info表的nameFlag字段
	// String statusFiled = objs[2] == null ? "" : objs[2].toString();// 监测状态字段
	// String statusSymbols = objs[3] == null ? "" : objs[3].toString();//
	// 判断监测异常的操作
	// String statusValue = objs[4] == null ? "" : objs[4].toString();// 监测异常的值
	// // 根据detectId查询具体信息所在表名，根据seqId从表里查询当前节点最新的监测时间
	// Long checkTimeDigital = getLatestDetectTimeDigitalBySeqId(detailTabName,
	// seqId);
	// Long checkGap = getLatestCheckGapBySeqId(detailTabName, seqId);
	//
	// // 根据监测设置，获得监测设置的监测周期:分钟
	//
	// if (!Constants.DI_SYSTEM_TABLE_NAME.equalsIgnoreCase(detailTabName))
	// {// 设备都有的公共的信息：系统基础信息和端口信息
	// if (Constants.DI_SWITCHPORT_TABLE_NAME.equalsIgnoreCase(detailTabName)
	// && StringUtils.isNotBlank(indexFiled))
	// {// 交换机端口监测信息
	// // 更新node_figure_info表中的设备状态信息及显示的图片
	// updateNodeFigureInfo(detailTabName,
	// checkTimeDigital,
	// indexFiled,
	// checkGap);
	// statisticSysStatus(detailTabName, checkTimeDigital, indexFiled);// 统计系统状态
	//
	// // pid=0表示当前设备为顶级设备，测试默认展示系统基本信息
	// if (pid != null && "0".equals(pid))
	// {
	// // 查询系统基本信息
	// logger.info("操作记录：开始查询系统基础信息。。。");
	// searchSysInfo(detailTabName, checkTimeDigital, checkGap);//
	// checkTimeDigital为当前周期
	//
	// } else if (isLeaf != null && "1".equals(isLeaf))
	// {// isLeaf=1表示为叶子节点
	// // 查询系统基本信息
	// logger.info("操作记录：开始查询系统基础信息。。。");
	// searchSysInfo(detailTabName, checkTimeDigital, checkGap);
	// // 查询端口的详细信息
	// if (StringUtils.isNotBlank(nameFlag))
	// {
	// logger.info("操作记录：开始查询节点" + nameFlag + "相关信息。。。");
	// detailPortInfo2(nameFlag,
	// detailTabName,
	// checkTimeDigital,
	// checkGap);// 交换机端口信息才需要
	// }
	// } else
	// {
	// // 查询系统基本信息
	// logger.info("操作记录：开始查询系统基础信息。。。");
	// searchSysInfo(detailTabName, checkTimeDigital, checkGap);
	// pid = "0";
	// }
	// } else if (StringUtils.isNotBlank(detailTabName)
	// && StringUtils.isNotBlank(indexFiled))
	// {
	// // 更新node_figure_info表中的设备状态信息及显示的图片
	// updateNodeFigureInfo(detailTabName,
	// checkTimeDigital,
	// indexFiled,
	// statusFiled,
	// statusSymbols,
	// statusValue,
	// checkGap);
	// statisticSysStatus(detailTabName,
	// checkTimeDigital,
	// indexFiled,
	// statusFiled,
	// statusSymbols,
	// statusValue);// 统计系统状态
	// }
	//
	// }
	//
	// }
	//
	// // 最新监测时间dataCheckTime如果比当前系统时间相差2个监测周期
	// //
	// 获取node_figure_info数据的监测时间--要从node_figure_info表获取（可能不是最新的）:应该放到update表node_figure_info数据之后获取
	// String checkTimeSql = "select max(t.data_check_time_digital) from
	// node_figure_info t where t.seqid="
	// + seqId;
	// List<Object[]> checkTimeList = commonService.executeSQL(checkTimeSql);
	// if (checkTimeList != null && checkTimeList.size() > 0)
	// {
	// Object checkTimeObj = checkTimeList.get(0);
	// Long dataCheckTimeDigital = (checkTimeObj == null) ? null : Long
	// .valueOf(checkTimeObj.toString());
	// dataCheckTime = DateUtil
	// .longToDate(dataCheckTimeDigital, "yyyy-MM-dd HH:mm:ss");
	// }
	// logger.info("操作记录：查询网元设备最新监测时间为：" + dataCheckTime);
	//
	// if (sysStatusFlag)
	// {
	// diSystem.setSysStatus("正常");
	// } else
	// {
	// sysStatus = sysStatus.contains("，") ? "："
	// + sysStatus.substring(0, sysStatus.length() - 1) : sysStatus;
	// param = "&nameFlag=" + nameFlag + "&pid=" + pid + "&isLeaf=" + isLeaf
	// + "&picId=" + picId
	// + "&queryParConditionDisplay=&queryChildConditionDisplay=none";//
	// 点击异常时，一定是端口页面收缩，系统基础信息页面打开+"
	// // startTime";
	// // diSystem.setSysStatus("<a
	// //
	// href='"+this.getRequest().getContextPath()+"/detection/detectionWarning.do?action=query&entry=switch&ip="+ip+"&detectId="+detectId+"&seqId="+seqId+"'>异常</a>"+sysStatus+"");
	// diSystem
	// .setSysStatus("<a href='javascript:toWarningList();'><font
	// color='red'><strong>异常</strong></font></a>"
	// + sysStatus + "");
	// // diSystem.setSysStatus("<a
	// //
	// href='"+this.getRequest().getContextPath()+"/detection/detectionWarning.do?action=query&entry=switch&ip="+ip+"&detectId="+detectId+"&seqId="+seqId+param+"'>异常</a>"+sysStatus+"");
	// }
	//
	// // 生成svg文件:需要查询每个端口的带宽、输入、输出的bps、pps
	// String hql = "from NodeFigureInfo where seqid=? order by showLevel
	// asc,pid
	// asc,showIndex asc";// 排序是为了图片的显示，显示图片时，要先显示最顶级的图片，否则图片之间会有覆盖现象
	// List<NodeFigureInfo> list = (List<NodeFigureInfo>)
	// this.commonService.find(hql,
	// Long.valueOf(seqId.trim()));
	// if (list != null && list.size() > 0)
	// {
	// detailAllPortInfo();
	// logger.info("操作记录：开始生成svg文件。。。");
	// generSwitchGraphXmlFile(list);
	// }
	//
	// logger.info("操作记录：查询共有几个物理设备，得到设备总高度（或者宽度）。。。");
	// String devNumHql = "from NodeFigureInfo where seqid=" + seqId
	// + " and pid=0 order by showIndex asc";// order by
	// // showIndex
	// // asc:查询第一个设备的
	// List<NodeFigureInfo> devNumList = (List<NodeFigureInfo>)
	// this.commonService
	// .find(devNumHql);
	// if (devNumList != null && devNumList.size() > 0)
	// {
	// devNum = devNumList.size();
	// NodeFigureInfo nodeTmp = devNumList.get(0);
	// Long devHeight = nodeTmp.getFigureHeight() == null ? 0 : nodeTmp
	// .getFigureHeight();
	// Long devY = nodeTmp.getFigureY() == null ? 0 : nodeTmp.getFigureY();
	// devHeightSum = (devNum * (devHeight + deviceShowGap) + devY + 10) + "";
	// devScrollHeight = ((devNum - 1) * (devHeight + deviceShowGap) + devY +
	// 1500)
	// + "";// 设置的大一些，也可以
	// }
	// // 保证可以正常显示提示信息（tooltip）
	// if (Integer.parseInt(devHeightSum) < 600)
	// {
	// devHeightSum = "600";
	// }
	//
	// }
	// } catch (Exception e)
	// {
	// logger.error("网元监测信息图形展示 异常", e);
	// }
	//
	// }

	/**
	 * 统计系统状态：有一个监测信息异常，则系统异常: 端口异常：1-2,1-1-0
	 */
	// private void statisticSysStatus(String detailTabName, Long
	// checkTimeDigital,
	// String indexFiled)
	// {
	// try
	// {
	// if (StringUtils.isNotBlank(seqId) &&
	// StringUtils.isNotBlank(detailTabName)
	// && checkTimeDigital != null)
	// {
	// String sql = " select
	// nfi.id,tmp.data_check_time_digital,tmp.ifadminstatus,tmp.ifoperstatus,tmp.detectioned_state,nfi.figure_fill,nfi.figure_fill_model"
	// + " from node_figure_info nfi"
	// + " left join ("
	// + " select ds.data_check_time_digital,ds.detectioned_state,"
	// + indexFiled
	// + ",ds.ifadminstatus,ds.ifoperstatus"
	// + " from "
	// + detailTabName
	// + " ds"
	// + " where ds.seq_id="
	// + seqId
	// + " and ds.data_check_time_digital="
	// + checkTimeDigital
	// + " )tmp"
	// + " on nfi.name_flag=tmp."
	// + indexFiled
	// + "||''"
	// + " left join device_type_info dti"
	// + " on nfi.device_type_code=dti.device_type_code"
	// + " where nfi.seqId="
	// + seqId + // 需要更新状态的：如果已经是最新的则不需要更新表,如果没有监测时间的也需要更新
	// " and di_table_name='" + detailTabName + "'";// 有没有表名，代表有没有监测信息
	//
	// logger.info("统计系统状态：端口sql：" + sql);
	//
	// List<Object[]> dateList = commonService.executeSQL(sql);
	// if (dateList != null && dateList.size() > 0)
	// {
	// int len = dateList.size();
	// for (int i = 0; i < len; i++)
	// {
	// Object[] objects = dateList.get(i);
	// String ifadminstatus = objects[2] == null ? "" : objects[2].toString();//
	// 默认是空
	// String ifoperstatus = objects[3] == null ? "" : objects[3].toString();//
	// 默认是空
	// String detectionedstate = objects[4] == null ? "" :
	// objects[4].toString();//
	// 默认是空
	// // 黄色不是异常
	// // if("1".equals(ifadminstatus)&&"2".equals(ifoperstatus)) {//黄色1-0
	// // sysStatusFlag = false;
	// // if(!sysStatus.contains("端口异常 ，")) {
	// // sysStatus = sysStatus + "端口异常 ，";
	// // }
	// // break;
	// // }else
	//
	// // 1-1-1.png:绿色
	// // 1-1-0.png:红色---------异常--------端口异常
	//
	// // 2.png:灰色-端口关闭
	// // 1-2:无图-未接线-系统正常
	// // TIMEOUT:无图-超时无信息-系统异常--------异常-----在update的时候统计了
	// if ("1".equals(ifadminstatus) && "1".equals(ifoperstatus)
	// && !"1".equals(detectionedstate))
	// {// 红色1-1-0, 0或者-1
	// sysStatusFlag = false;
	// if (!sysStatus.contains("端口数据异常 ，"))
	// {
	// sysStatus = sysStatus + "端口数据异常 ，";
	// }
	// break;
	// }
	// }
	// }
	// }
	// } catch (Exception e)
	// {
	// logger.error("统计系统状态 异常", e);
	// }
	// }
	/**
	 * 统计系统状态：有一个监测信息异常，则系统异常: 风扇、电源灯异常：abnormal
	 */
	// private void statisticSysStatus(String detailTabName, Long
	// checkTimeDigital,
	// String indexFiled,
	// String statusFiled, String statusSymbols, String statusValue)
	// {
	// try
	// {
	// if (StringUtils.isNotBlank(seqId) &&
	// StringUtils.isNotBlank(detailTabName)
	// && checkTimeDigital != null)
	// {
	// String sql = " select nfi.id,tmp.data_check_time_digital," + " tmp."
	// + statusFiled + ",nfi.figure_fill_model" + " from node_figure_info nfi"
	// + " left join ("
	// + " select ds.data_check_time_digital,ds.detectioned_state,"
	// + indexFiled + "," + statusFiled + " from "
	// + detailTabName
	// + " ds"
	// + " where ds.seq_id="
	// + seqId
	// +
	// // " and " +statusFiled + statusSymbols + "'"+statusValue +"'"+
	// " and ds.data_check_time_digital=" + checkTimeDigital + " )tmp"
	// + " on nfi.name_flag=tmp." + indexFiled + "||''"
	// + " left join device_type_info dti"
	// + " on nfi.device_type_code=dti.device_type_code" + " where nfi.seqId="
	// + seqId + // 需要更新状态的：如果已经是最新的则不需要更新表,如果没有监测时间的也需要更新
	// " and di_table_name='" + detailTabName + "'" + // 叶子设备可通过是否有监测信息表来判断
	// " and " + statusFiled + statusSymbols + "'" + statusValue + "'";
	// logger.info("统计系统状态：其它（风扇、电源等）sql：" + sql);
	//
	// List<Object[]> dateList = commonService.executeSQL(sql);
	// if (dateList != null && dateList.size() > 0)
	// {// 说明有异常的
	// sysStatusFlag = false;
	// if (!sysStatus.contains("风扇、电源等异常 ，"))
	// {
	// sysStatus = sysStatus + "风扇、电源等异常 ，";
	// }
	// }
	// }
	// } catch (Exception e)
	// {
	// logger.error("统计系统状态 异常", e);
	// }
	// }
	private void searchSysInfo(String detailTabName, Long checkTimeDigital, Long checkGap) {
		try {

			/**
			 * 查询网元系统基础信息 1.从check_type_info表根据监测类别名称，查询出信息所在的表
			 * 2.从对应表里查询最新的网元系统基础信息（条件：seqid，按DATA_CHECK_TIME_DIGITAL排序，取最新）
			 */
			// 系统基础信息不用检查是否超时，只取最新的即可，但是统计的数值（输入、输出速度，发包、收包速率）要判断是否超时（超时的标准是端口的2个监测周期）
			String checkTypeName = Constant.NE_SYSTEM_INFO_CHECKTYPENAME;

			if (StringUtils.isNotBlank(checkTypeName)) {
				String setIdSql = " SELECT T.TABLE_NAME  " + "  FROM CHECK_TYPE_INFO T  "
						+ "  WHERE LOWER(T.CHECK_TYPE_NAME) = LOWER('" + checkTypeName + "')";
				List<Object[]> setTableNameList = commonService.executeSQL(setIdSql);

				if (setTableNameList != null && setTableNameList.size() > 0) {
					Object obj = setTableNameList.get(0);
					String neSysInfoTabName = obj == null ? null : obj.toString();
					if (StringUtils.isNotBlank(neSysInfoTabName)) {
						String systemInfoSql = "SELECT DS.SYSDESCR,DS.SYSUPTIME,DS.SYSNAME,DS.SYSLOCATION " + "  FROM  "
								+ neSysInfoTabName + " DS" + "  WHERE DS.SEQ_ID=" + seqId
								+ "  ORDER BY DS.DATA_CHECK_TIME DESC";// 只取最新监测时间的网元系统基础信息
						List<Object[]> systemInfoList = commonService.executeSQL(systemInfoSql);

						if (systemInfoList != null && systemInfoList.size() > 0) {
							Object[] sysObjs = systemInfoList.get(0);// 只取最新监测时间的网元系统基础信息
							diSystem.setSysDescr(sysObjs[0] == null ? null : sysObjs[0].toString());
							diSystem.setSysUpTime(converseSysUpTime(sysObjs[1] == null ? "" : sysObjs[1].toString()));
							diSystem.setSysName(sysObjs[2] == null ? null : sysObjs[2].toString());
							diSystem.setSysLocation(sysObjs[3] == null ? null : sysObjs[3].toString());
						}
						logger.info("操作记录：获取系统基础信息");
					}
				}
			}

			// 计算系统的总输出速度、输入速度、收包速率、发包速率-只计算node_figure_info里配置的端口（48个）
			if (checkGap == null) {
				checkGap = defaultPortGap;// 此处周期的判断应该是端口的周期
			}
			long period = (2 * checkGap + defaultDelay) * 60 * 1000;// 2个周期
			long curTime = new Date().getTime();
			if (StringUtils.isNotBlank(detailTabName) && checkTimeDigital != null
					&& (curTime - checkTimeDigital) <= period) {// 如果没有超过2个周期，则取值计算
				String dataCheckTimeTmp = DateUtil.longToDate(checkTimeDigital, "yyyy-MM-dd HH:mm:ss");
				String sysSumSql = "SELECT SUM(TMP.INOCTETSSPEED),SUM(TMP.OUTOCTETSSPEED),SUM(TMP.OUTPKTSSPEED),SUM(TMP.INPKTSSPEED)"
						+ "  FROM NODE_FIGURE_INFO NFI" + "  LEFT JOIN ("// 只计算NODE_FIGURE_INFO里配置的端口（48个）
						+ "       SELECT  DS.IFDESCR,DS.INOCTETSSPEED,DS.OUTPKTSSPEED,DS.OUTOCTETSSPEED,DS.INPKTSSPEED"
						+ "       FROM  " + detailTabName + " DS  " + "       WHERE  DS.SEQ_ID=" + seqId
						// + " AND DS.DATA_CHECK_TIME_DIGITAL = " +
						// checkTimeDigital
						+ "              AND DS.DATA_CHECK_TIME=TO_DATE('" + dataCheckTimeTmp
						+ "','yyyy-MM-dd HH24:mi:ss')" + "  )TMP " + "  ON NFI.NAME_FLAG=TMP.IFDESCR"
						+ "  WHERE  (NFI.PORT_SET_STATE IS NULL OR NFI.PORT_SET_STATE=1)"
						+ "        AND  NFI.IS_LEAF=1  " + "        AND NFI.SEQID=" + seqId;

				List sysSumList = commonService.executeSQL(sysSumSql);
				if (sysSumList != null && sysSumList.size() > 0) {
					Object[] sysSumObj = (Object[]) sysSumList.get(0);
					// BigDecimal bFromB = new BigDecimal(8);

					// BigDecimal sysInSpeedSumTmp = sysSumObj[0] == null ? null
					// : ((BigDecimal)
					// sysSumObj[0]).multiply(bFromB).setScale(0,BigDecimal.ROUND_UP);
					// BigDecimal sysOutSpeedSumTmp = sysSumObj[1] == null ?
					// null
					// : ((BigDecimal)
					// sysSumObj[1]).multiply(bFromB).setScale(0,BigDecimal.ROUND_UP);
					BigDecimal sysInSpeedSumTmp = sysSumObj[0] == null ? null
							: ((BigDecimal) sysSumObj[0]).setScale(0, BigDecimal.ROUND_UP);
					BigDecimal sysOutSpeedSumTmp = sysSumObj[1] == null ? null
							: ((BigDecimal) sysSumObj[1]).setScale(0, BigDecimal.ROUND_UP);
					diSystem.setSysInSpeedSum(sysInSpeedSumTmp == null ? null : sysInSpeedSumTmp.toString());
					diSystem.setSysOutSpeedSum(sysOutSpeedSumTmp == null ? null : sysOutSpeedSumTmp.toString());
					diSystem.setSysOutPktsSpeedSum(sysSumObj[2] == null ? null
							: ((BigDecimal) sysSumObj[2]).setScale(0, BigDecimal.ROUND_UP).toString());
					diSystem.setSysInPktsSpeedSum(sysSumObj[3] == null ? null
							: ((BigDecimal) sysSumObj[3]).setScale(0, BigDecimal.ROUND_UP).toString());
				}
				logger.info("操作记录：获取系统统计信息");
			}
		} catch (Exception e) {
			logger.error("Graphical display of network element monitoring information -> Query system basic information anomaly", e);
		}
	}

	// time如果是数字的话，除以100得到秒数
	private String converseSysUpTime(String time) throws Exception {
		String sysUpTime = "";
		if (StringUtils.isNotBlank(time)) {
			String timeTmp = time.replaceAll("[0-9]", "");
			if (timeTmp.length() > 0) {// 字符串类型
				sysUpTime = time;
			} else {// 数字类型
				long timeDigital = Long.parseLong(time);
				sysUpTime = converseTime(timeDigital * 10);
			}
		}

		return sysUpTime;

	}

	private String converseTime(long time) throws Exception {
		String str = "";
		long nd = 1000 * 24 * 60 * 60;
		long nh = 1000 * 60 * 60;
		long nm = 1000 * 60;
		long ns = 1000;

		long days = time / nd;
		long hour = time % nd / nh;
		long min = time % nd % nh / nm;
		long sec = time % nd % nh % nm / ns;

		str = days + " days, " + hour + ":" + min + ":" + sec;
		return str;
	}

	// 查询所有类型为交换机的节点的ip和seqId、所有的设备类型、型号、每个型号最大的叠加数
	public void toConfigSpecialDevice() {
		String nodeInfoSql = "select distinct nodeIp, seqId from NodeTable where nodeType=1 and nodeState=0 order by nodeIp desc";// 只查询交换机、有效节点
		String devBrandSql = "select DEVICE_RAND_CODE,DEVICE_RAND_NAME from DEVICE_BRAND_INFO ";// 查询设备品牌
		String devBrandTypeSql = "from DeviceTypeInfo where showLevel=1 and figure_x is not null";// 只查询顶级设备的设备型号,x坐标为空的，不可进行配置
		try {
			switcheNodeList = this.commonService.find(nodeInfoSql);
			deviceBrandList = this.commonService.executeSQL(devBrandSql);
			deviceBrandTypeList = this.commonService.find(devBrandTypeSql);

		} catch (Exception e) {
			logger.error("Network element configuration initialization information: SeqId, Device Type, Device model query exception", e);
		}

	}

	public void toGetNeNode() {
		String nodeInfoSql = "select distinct nodeIp, seqId from NodeTable where nodeType=1 and nodeState=0 order by nodeIp desc";// 只查询交换机、有效节点
		try {
			switcheNodeList = this.commonService.find(nodeInfoSql);

		} catch (Exception e) {
			logger.error("Network element configuration initialization information: SeqId, Device Type, Device model query exception", e);
		}

	}

	// String-NodeTable:端口配置，查询符合条件的网元节点--只用于查询nodeTable表有效的网元数据
	public String queryInfoForAjax() {
		String ajaxProperties = this.getRequest().getParameter("ajaxProperties").trim();
		String ajaxTableName = this.getRequest().getParameter("ajaxTableName").trim();
		String ajaxType = null;

		if (this.getRequest().getParameter("ajaxValue") != null) {
			ajaxType = this.getRequest().getParameter("ajaxType").trim();
		}
		String ajaxValue = null;
		if (this.getRequest().getParameter("ajaxValue") != null) {
			ajaxValue = this.getRequest().getParameter("ajaxValue").trim();
		}
		String isTableconfig = "";
		String sq1 = "lower(";
		String sq2 = ")";
		if (null != ajaxProperties && !("").equals(ajaxProperties) && null != ajaxTableName
				&& !("").equals(ajaxTableName) && null != ajaxType && !("").equals(ajaxType)) {
			if (("TableConfig").equals(ajaxTableName))
				isTableconfig = " and x.activeflag not in(9,11)";
			if (("Tableconfig").equals(ajaxTableName) && ("subject").equals(ajaxProperties)) {
				sq1 = "";
				sq2 = "";
			}
			try {
				StringBuffer stringBuffer = new StringBuffer();

				if (("Long").equals(ajaxType)) {
					String sql = "select distinct x." + ajaxProperties + " from " + ajaxTableName + " x  "
							+ " where 1=1" + " and " + sq1 + "x." + ajaxProperties + "" + sq2 + " like ('" + ajaxValue
							+ "%') " + isTableconfig + " order by x." + ajaxProperties + "";
					List<Long> list = this.commonService.find(sql);

					for (Long s : list) {
						stringBuffer.append("" + s + ",");
					}
				}

				if (("Integer").equals(ajaxType)) {
					String sql = "select distinct x." + ajaxProperties + " from " + ajaxTableName + " x where 1=1"
							+ " and " + sq1 + "x." + ajaxProperties + "" + sq2 + " like ('" + ajaxValue + "%') "
							+ isTableconfig + " order by x." + ajaxProperties + "";
					List<Integer> list = this.commonService.find(sql);

					for (Integer s : list) {
						stringBuffer.append("" + s + ",");
					}
				}

				if (("String").equals(ajaxType)) {
					String sql = "select distinct trim(x." + ajaxProperties + ") from " + ajaxTableName
							+ " x where 1=1 and x." + ajaxProperties + "!='null' " + " and " + sq1 + "x."
							+ ajaxProperties + "" + sq2 + " like ('%" + ajaxValue.toLowerCase() + "%') "
							+ isTableconfig;
					Object systemIdObj = this.getRequest().getSession().getAttribute(Constant.SESSION_SYSTEM_LOGIN);
					if (systemIdObj != null && ajaxProperties.equals("nodeIp") && ajaxTableName.equals("NodeTable")) {
						// 有效节点 节点状态：0，有效；1，无效--只查询网元
						sql += " and x.nodeState = 0 and nodeType=1 ";
						Long systemId = new Long(systemIdObj.toString());
						// admin 的systemId为-1 管理员可以查看所有系统
						if (systemId != -1l) {
							sql += " and x.systemId = " + systemId;
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
					stringBuffer.replace(stringBuffer.length() - 1, stringBuffer.length(), "");
				System.out.println(stringBuffer.toString());
				// this.getResponse().setContentType("application/xml");
				this.getResponse().setCharacterEncoding("utf-8");
				// this.getResponse().setHeader("Cache-Control", "no-cache");
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

	// 特种设备图形化配置:maxDevNum：最大设备叠加数
	public void configSpecialDevice() {
		if (StringUtils.isNotBlank(deviceBrandCode) && StringUtils.isNotBlank(deviceBrandTypeCode)
				&& StringUtils.isNotBlank(seqId)) {
			try {

				ip = getIpBySeqId(seqId);
				// 步骤一：查询对应设备型号的底图，无则返回并提示
				String searchDeviceSql = " select dti.device_type_code," + "                dti.figure_width,"
						+ "                dti.figure_height," + "                dti.figure_fill,"
						+ "                dti.show_index," + "                dti.id,"
						+ "                dti.figure_x," + "                dti.figure_y,"
						+ "                dti.show_level" + " from device_type_info  dti" + " where device_rand_code='"
						+ deviceBrandCode + "' " + "       and device_type_code='" + deviceBrandTypeCode + "' ";

				logger.info("操作记录：查询设备型号底图sql=" + searchDeviceSql);
				List<Object[]> deviceInfoList = commonService.executeSQL(searchDeviceSql);
				if (deviceInfoList != null && deviceInfoList.size() > 0) {
					Object[] objs = deviceInfoList.get(0);// 获得设备
					rootDevice.setDeviceCode(objs[0] == null ? "" : objs[0].toString());
					rootDevice.setDeviceWidth(objs[1] == null ? null : Long.parseLong(objs[1].toString()));
					rootDevice.setDeviceHeight(objs[2] == null ? null : Long.parseLong(objs[2].toString()));
					rootDevice.setDeviceFill(objs[3] == null ? "" : objs[3].toString());
					rootDevice.setShowIndex(objs[4] == null ? "" : objs[4].toString());
					rootDevice.setId(objs[5] == null ? null : Long.parseLong(objs[5].toString()));
					rootDevice.setFigureX(objs[6] == null ? null : Long.parseLong(objs[6].toString()));
					rootDevice.setFigureY(objs[7] == null ? null : Long.parseLong(objs[7].toString()));
					rootDevice.setShowLevel(objs[8] == null ? null : Long.parseLong(objs[8].toString()));
				} else {
					outHtmlString("<script type=\"text/javascript\">alert('i18n_SwitchDetectionAction.emportXls.noDevice_n81i');window.history.go(-1);</script>");
				}

				// @2018-3-9 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
				String swcbSql = "select sub_device_type_code   from device_brand_type where 1=1 ";
				List<Map<String, Object>> list = this.commonService.startWithConnectBy(swcbSql,
						"par_device_type_code='" + deviceBrandTypeCode+"'", "sub_device_type_code", "par_device_type_code");
				StringBuilder t = new StringBuilder();
				for (Map<String, Object> map : list) {
					if (map != null) {
						Object o = HibernateGeneralDaoImpl.getIgnoreCase(map, "sub_device_type_code");
						if (o != null) {
							t.append(",'");
							t.append(o.toString());
							t.append("'");
						}
					}
				}
				if (t.length() > 0) {
					t.deleteCharAt(0);
				}
				// 步骤二：查询此型号下所有的子设备,放在jsp页面的左侧（设备模型），以供拖动，组合设备
				/*
				 * 2014.11.18 wx
				 * 发现子设备（板卡）对应多个父设备（主机架）的时候，有可能会调用错误的主机架与板卡关系（板卡对应多个主机架，
				 * 调用的关系有可能不是与设备型号底图 对应的主机架的关系）
				 */
				String searchSubDeviceSql = " select dby.par_device_type_code,"
						+ "                dti.device_type_code," + "                dti.figure_width,"
						+ "                dti.figure_height," + "                dti.figure_fill,"
						+ "                dti.show_level," + "                dti.is_link," + "                dti.id,"
						+ "                dti.is_leaf," + "                dti.show_index,"
						+ "                dti.figure_x," + "                dti.figure_y"
						+ " from device_type_info dti " + " left join device_brand_type dby"
						// + " on
						// dby.sub_device_type_code=dti.device_type_code"//板子型号
						/*
						 * 2014 11 18 wx 更改jion 语句，限制父设备型号
						 */
						+ " on dby.sub_device_type_code=dti.device_type_code and dby.par_device_type_code='"
						+ deviceBrandTypeCode + "' "// 板子型号
						+ " where dti.device_rand_code='" + deviceBrandCode + "' "// 品牌
						+ "       and dti.device_type_code in(" + t.toString() + ") "
						+ "       and dti.figure_x is not null" + // x为空的不进行配置
						"       and dti.show_level<3" + // 目前只支持配置2级设备
						" order by dti.show_level asc";
				/*
				 * +
				 * " on dby.sub_device_type_code=dti.device_type_code and dby.par_device_type_code='"
				 * +deviceBrandTypeCode+"' "//板子型号 +
				 * " where dti.device_rand_code='" + deviceBrandCode + "' "//品牌
				 * + "       and dti.device_type_code in("//获取设备型号底图关联的板卡型号 +
				 * " 			select sub_device_type_code " +
				 * "           from device_brand_type "//板卡主机架对应关系表中查找板子 +
				 * "           start with par_device_type_code='" +
				 * deviceBrandTypeCode//根节点 + "' " +
				 * "           connect by prior sub_device_type_code=par_device_type_code "
				 * + "       ) " + "       and dti.figure_x is not null" + //
				 * x为空的不进行配置 "       and dti.show_level<3" + // 目前只支持配置2级设备
				 * " order by dti.show_level asc";
				 */
				logger.info("操作记录：查询设备的子设备sql=" + searchSubDeviceSql);
				List<Object[]> subDeviceInfoList = commonService.executeSQL(searchSubDeviceSql);
				if (subDeviceInfoList != null && subDeviceInfoList.size() > 0) {
					for (Object[] objs : subDeviceInfoList) {
						DeviceInfo device = new DeviceInfo();
						System.out.println("父设备code---------------------------------------" + objs[0].toString());
						device.setParDeviceCode(objs[0] == null ? "" : objs[0].toString());// 父设备code
						device.setDeviceCode(objs[1] == null ? "" : objs[1].toString());
						device.setDeviceWidth(objs[2] == null ? null : Long.parseLong(objs[2].toString()));
						device.setDeviceHeight(objs[3] == null ? null : Long.parseLong(objs[3].toString()));
						String deviceFill = objs[4] == null ? "" : objs[4].toString();
						device.setDeviceFill(deviceFill);// 设备图片
						Long showLevel = objs[5] == null ? null : Long.parseLong(objs[5].toString());
						device.setShowLevel(showLevel);
						if (showLevel != null && !devShowLevelList.contains(showLevel)) {
							devShowLevelList.add(showLevel);// show_level按从小到大的顺序排列
						}

						device.setIsLink(objs[6] == null ? null : Long.parseLong(objs[6].toString()));
						device.setId(objs[7] == null ? null : Long.parseLong(objs[7].toString()));
						device.setIsLeaf(objs[8] == null ? null : Long.parseLong(objs[8].toString()));
						device.setShowIndex(objs[9] == null ? "" : objs[9].toString());
						if (StringUtils.isNotBlank(deviceFill) && deviceFill.endsWith(".png")) {
							device.setDeviceFillMini(deviceFill.substring(0, deviceFill.length() - 4) + "-MINI.png");
						}
						device.setFigureX(objs[10] == null ? null : Long.parseLong(objs[10].toString()));
						device.setFigureY(objs[11] == null ? null : Long.parseLong(objs[11].toString()));

						deviceModelList.add(device);
					}
					DeviceInfo deviceTmp = deviceModelList.get(0);
					Long heightTmp = deviceTmp.getDeviceHeight() == null ? 0l : deviceTmp.getDeviceHeight();
					Long widthTmp = deviceTmp.getDeviceWidth() == null ? 0l : deviceTmp.getDeviceWidth();
					if (heightTmp > widthTmp) {
						modelSortByXorY = "y";
					}
				}

				// 查询叠加时的基数（showIndex为-1的,要等有端口信息的叠加完毕再进行叠加）:
				String searchPositionCountSql = " select dti.device_type_code," + "        dti.show_index,"
						+ "        dti.show_level," + "             dti.figure_x," + "             dti.figure_y,"
						+ "             dti.figure_width," + "             dti.figure_height,"
						+ "             dti.is_link" + "  from device_type_info  dti"
						+ "  where  is_leaf=0 and pid in ("
						+ "      select id from device_type_info dti where device_rand_code='" + deviceBrandCode
						+ "' and device_type_code='" + deviceBrandTypeCode + "'" + "  )" + "  and show_index > -1 ";

				logger.info("操作记录：查询叠加时的槽位基数sql=" + searchPositionCountSql);
				List<Object[]> positionCountList = commonService.executeSQL(searchPositionCountSql);
				int posCount = positionCountList != null ? positionCountList.size() : 0;
				// 步骤三：查询对应设备型号的底图所有的卡槽的位置列表:maxDevNum：最大设备叠加数:叠加时，有些槽位不
				String searchDevicePositionSql = " select dti.device_type_code," + "        dti.show_index,"
						+ "        dti.show_level," + "             dti.figure_x," + "             dti.figure_y,"
						+ "             dti.figure_width," + "             dti.figure_height,"
						+ "             dti.is_link" + "  from device_type_info  dti"
						+ "  where  is_leaf=0 and pid in ("
						+ "      select id from device_type_info dti where device_rand_code='" + deviceBrandCode
						+ "' and device_type_code='" + deviceBrandTypeCode + "'" + "  )"
						+ "  order by dti.show_index asc,device_type_code asc";// 按showIndex和deviceTypeCode升序排序：有多个设备的showIndex=-1，时按deviceTypeCode排序，可以区分开

				logger.info("操作记录：查询设备的卡槽位置sql=" + searchDevicePositionSql);
				List<Object[]> devicePositionInfoList = commonService.executeSQL(searchDevicePositionSql);
				rootDevice.setDevPostionNum(devicePositionInfoList == null ? 0 : devicePositionInfoList.size());// 顶级设备的位置个数
				if (devicePositionInfoList != null && devicePositionInfoList.size() > 0) {
					// int maxNum = maxDevNum;
					Object[] objTmp = devicePositionInfoList.get(devicePositionInfoList.size() - 1);
					int showIndexTmp = objTmp[1] == null ? 0 : Integer.parseInt(objTmp[1].toString());// 由于是按show_index升序排列的，所以最后一个的shouIndex为最大的
					int maxCount = (maxDevNum - 1) * posCount + showIndexTmp + 1;// -1的设备开始的showIndex,此处可以加1或者更大的值，只要不占用有端口信息的槽位的编号即可

					for (int i = 0; i < maxDevNum; i++) {// 设备编号从0-（maxNum-1）
						for (Object[] objs : devicePositionInfoList) {
							DeviceInfo device = new DeviceInfo();
							device.setDeviceCode(objs[0] == null ? "" : objs[0].toString());
							// 多个物理设备叠加时的showIndex的获取
							Long showIndex = objs[1] == null ? 0l : Long.parseLong(objs[1].toString());
							if (showIndex > -1) {
								showIndex = i * posCount + showIndex;
							} else {
								showIndex = Long.parseLong(maxCount + "");
								maxCount++;
							}
							device.setShowIndex(showIndex.toString());

							device.setShowLevel(objs[2] == null ? null : Long.parseLong(objs[2].toString()));

							// 到jsp界面再确定每个卡槽的位置
							device.setFigureX(objs[3] == null ? null : Long.parseLong(objs[3].toString()));
							device.setFigureY(objs[4] == null ? null : Long.parseLong(objs[4].toString()));

							device.setDeviceWidth(objs[5] == null ? null : Long.parseLong(objs[5].toString()));
							device.setDeviceHeight(objs[6] == null ? null : Long.parseLong(objs[6].toString()));
							device.setIsLink(objs[7] == null ? null : Long.parseLong(objs[7].toString()));

							device.setDevNum(i);// 多个设备叠加时，设备的编号

							devicePositionList.add(device);
						}
					}
				}

				Long devHeight = rootDevice.getDeviceHeight() == null ? 0 : rootDevice.getDeviceHeight();
				devScrollHeight = ((maxDevNum - 1) * (devHeight + deviceGap) + rootDeviceY + 1500) + "";

			} catch (Exception e) {
				logger.error("Get subdevice of device model " + deviceBrandTypeCode + " exception", e);
			}
		}
	}

	/**
	 * 
	 * TODO 验证子设备与槽位是否对应 device_boardsolt_board表中有对应的初始化配置
	 * 
	 * @author jinshujuan Jun 14, 2013
	 * @version 1.0
	 * @return
	 */
	public String checkPostion() {
		try {
			// alert(deviceTypeCode+" "+subDeviceCode+" "+postion);
			String deviceTypeCode = getRequest().getParameter("deviceTypeCode");// 主机架型号
			String subDeviceCode = getRequest().getParameter("subDeviceCode");// 板卡型号
			String postion = getRequest().getParameter("postion");// 端口
			if (!com.nis.util.StringUtil.isBlank(deviceTypeCode) && !com.nis.util.StringUtil.isBlank(subDeviceCode)
					&& !com.nis.util.StringUtil.isBlank(postion)) {
				String sql = "SELECT t.device_brand_code from device_boardsolt_board t WHERE t.device_type_code='"
						+ deviceTypeCode + "' AND t.device_board_code='" + subDeviceCode
						+ "' AND t.device_board_solt_code='" + postion + "'";
				List list = commonService.executeSQL(sql);
				outJsonString("" + list.size());
			}

		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}

	public void addSpecialDeviceConfig() {
		try {
			commonService.beginTransaction();
			if (StringUtils.isNotBlank(seqId) && rootDevice != null && deviceConfigList.size() > 0) {
				// 第一步：配置之前，先从node_figure_info表里删除seqId的相应配置
				this.commonService.delete(NodeFigureInfo.class, "seqid", Long.parseLong(seqId));

				// 第二步：查询界面配置设备的所有叶子设备,将界面配置的设备及查询的叶子设备组合到一个list中
				// 将deviceConfigList列表中为null的值都去掉
				for (int i = 0; i < deviceConfigList.size();) {
					DeviceInfo dev = deviceConfigList.get(i);
					if (dev == null) {
						deviceConfigList.remove(i);
					} else {
						i++;
					}
				}
				List<DeviceInfo> leafDeviceList = getLeafDeviceGroup(deviceConfigList);// deviceConfigList包含rootDevice
				deviceConfigList.addAll(leafDeviceList);

				// 第三步：递归存设备
				// 先存入rootDev设备:多个物理节点组成一个逻辑节点时，rootDev有多个，rootDev的坐标应该由jsp页面组合？
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date dNow = new Date();
				Date createDate = sdf.parse(sdf.format(dNow));

				if (deviceConfigList != null && deviceConfigList.size() > 0) {
					// DeviceInfo rootDev = deviceConfigList.get(0);
					// NodeFigureInfo nodeFigure =
					// createNodeFigure(rootDev,createDate,0l,"",0l,0l);//生成nodeFigureInfo记录
					// this.commonService.save(nodeFigure);
					// Long nodePid = nodeFigure.getId();
					// deviceConfigList.remove(0);

					for (int i = 0; i < deviceConfigList.size();) {
						DeviceInfo rootDev = deviceConfigList.get(i);
						if (rootDev != null && rootDev.getShowLevel() != null && rootDev.getShowLevel() == 1l) {// 一级设备
							NodeFigureInfo nodeFigure = createNodeFigure(rootDev, createDate, 0l, "", 0l, 0l);// 生成nodeFigureInfo记录
							this.commonService.save(nodeFigure);
							Long nodePid = nodeFigure.getId();
							deviceConfigList.remove(i);

							String parShowIndex = generatParShowIndex(rootDev.getParShowIndex(),
									rootDev.getShowIndex());
							configAndSaveNodeFigureInfo(deviceConfigList, createDate, nodePid, parShowIndex,
									rootDev.getDeviceCode(), rootDev.getShowIndex(), nodeFigure.getFigureX(),
									nodeFigure.getFigureY());
						} else {
							i++;
						}
					}
				}
			}
			commonService.commit();
			outHtmlString(
					"<script type=\"text/javascript\">alert(\"i18n_SwitchDetectionAction.emportXls.configSuccess_n81i\");this.location='switchDetection.do?action=toConfigSpecialDevice'</script>");
		} catch (Exception e) {
			commonService.rollback();
			logger.error("Get subdevice of device model " + deviceBrandTypeCode + " exception", e);
		}
	}

	// 查询界面配置设备的所有叶子设备
	private List<DeviceInfo> getLeafDeviceGroup(List<DeviceInfo> deviceConfigList) {
		List<DeviceInfo> leafDeviceList = new ArrayList<DeviceInfo>();
		try {
			if (deviceConfigList != null && deviceConfigList.size() > 0) {
				int len = deviceConfigList.size();
				String[] subdeviceIdList = new String[len];
				for (int i = 0; i < len; i++) {
					DeviceInfo deviceTmp = deviceConfigList.get(i);
					if (deviceTmp != null && deviceTmp.getId() != null) {// &&
																			// !"undefined".equals(deviceTmp.getId().toLowerCase():界面无属性
						subdeviceIdList[i] = deviceTmp.getId().toString();
					}
				}
				// 查询不重复的叶子设备（板卡类型可能一样，可能有多个机框）
				if (subdeviceIdList.length > 0) {
					String ids = StringUtil.linkToString(subdeviceIdList, ",", "");
					if (StringUtils.isNotBlank(ids)) {

						// @2018-3-12 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
						String swcbSql = "select id from device_type_info where 1=1  ";
						List<Map<String, Object>> list = this.commonService.startWithConnectBy(swcbSql,
								"id in (" + ids + ")", "id", "pid");
						StringBuilder sb = new StringBuilder();
						for (Map<String, Object> map : list) {
							if (map != null) {
								Object o = HibernateGeneralDaoImpl.getIgnoreCase(map, "id");
								if (o != null) {
									sb.append(",");
									sb.append(o.toString());
								}
							}
						}
						if (sb.length() > 0) {
							sb.deleteCharAt(0);
						}
						String subDeviceSql = " select   id," + "        pid," + "        device_type_code,"
								+ "        show_index," + "        figure_width," + "        figure_height,"
								+ "        figure_x," + "        figure_y," + "        figure_fill,"
								+ "        is_link," + "        is_leaf," + "        show_level" + " from ("
								+ " select id," + "        pid," + "        device_type_code," + "        show_index,"
								+ "        figure_width," + "        figure_height," + "        figure_x,"
								+ "        figure_y," + "        figure_fill," + "        is_link," + "        is_leaf,"
								+ "        show_level" + " from device_type_info where id in (" + sb.toString() + ")"
								+ " )tmp where is_leaf=1  and id not in(" + ids + ")" + " and figure_x is not null";
						// 对于x坐标为空的，不生成实例端口
						/*
						 * String subDeviceSql = " select   id," +
						 * "        pid," + "        device_type_code," +
						 * "        show_index," + "        figure_width," +
						 * "        figure_height," + "        figure_x," +
						 * "        figure_y," + "        figure_fill," +
						 * "        is_link," + "        is_leaf," +
						 * "        show_level" + " from (" + " select id," +
						 * "        pid," + "        device_type_code," +
						 * "        show_index," + "        figure_width," +
						 * "        figure_height," + "        figure_x," +
						 * "        figure_y," + "        figure_fill," +
						 * "        is_link," + "        is_leaf," +
						 * "        show_level" +
						 * " from device_type_info start with id in (" + ids +
						 * ") connect by prior id=pid" +
						 * " )tmp where is_leaf=1  and id not in(" + ids + ")" +
						 * " and figure_x is not null";// 对于x坐标为空的，不生成实例端口
						 */ logger.info("操作记录：查询叶子设备(不重复)sql=" + subDeviceSql);

						List<Object[]> subDevInfoList = commonService.executeSQL(subDeviceSql);
						Map<String, List<DeviceInfo>> subDeviceConfigMap = new HashMap<String, List<DeviceInfo>>();// 父设备id:所有的子设备
						if (subDevInfoList != null && subDevInfoList.size() > 0) {
							for (Object[] objs : subDevInfoList) {
								DeviceInfo device = new DeviceInfo();

								device.setId(objs[0] == null ? null : Long.parseLong(objs[0].toString()));
								String pid = objs[1] == null ? "" : objs[1].toString();
								device.setPid(pid);
								device.setDeviceCode(objs[2] == null ? "" : objs[2].toString());
								device.setShowIndex(objs[3] == null ? "" : objs[3].toString());
								device.setDeviceWidth(objs[4] == null ? null : Long.parseLong(objs[4].toString()));
								device.setDeviceHeight(objs[5] == null ? null : Long.parseLong(objs[5].toString()));
								device.setFigureX(objs[6] == null ? null : Long.parseLong(objs[6].toString()));
								device.setFigureY(objs[7] == null ? null : Long.parseLong(objs[7].toString()));
								device.setDeviceFill(objs[8] == null ? "" : objs[8].toString());
								device.setIsLink(objs[9] == null ? null : Long.parseLong(objs[9].toString()));
								device.setIsLeaf(objs[10] == null ? null : Long.parseLong(objs[10].toString()));
								device.setShowLevel(objs[11] == null ? null : Long.parseLong(objs[11].toString()));

								if (!subDeviceConfigMap.containsKey(pid)) {
									List<DeviceInfo> deviceListTmp = new ArrayList<DeviceInfo>();
									deviceListTmp.add(device);
									subDeviceConfigMap.put(pid, deviceListTmp);
								} else {
									List<DeviceInfo> deviceListTmp = subDeviceConfigMap.get(pid);
									deviceListTmp.add(device);
									subDeviceConfigMap.put(pid, deviceListTmp);
								}
							}
						}

						// 循环所有父设备，生成叶子设备:showIndex=-1时，此设备底下没有子设备
						for (int i = 0; i < len; i++) {
							DeviceInfo deviceTmp = deviceConfigList.get(i);
							if (deviceTmp != null && deviceTmp.getId() != null) {// &&
																					// !"undefined".equals(deviceTmp.getId().toLowerCase():界面无属性
								List<DeviceInfo> subDeviceListTmp = subDeviceConfigMap
										.get(deviceTmp.getId().toString());
								if (subDeviceListTmp != null && subDeviceListTmp.size() > 0) {
									String parShowIndex = generatParShowIndex(deviceTmp.getParShowIndex(),
											deviceTmp.getShowIndex());
									for (DeviceInfo devTmp : subDeviceListTmp) {
										DeviceInfo devClone = devTmp.clone();
										devClone.setParShowIndex(parShowIndex);// 父showInex:如1,3:机框的第三个卡槽的位置
										devClone.setParDeviceCode(deviceTmp.getDeviceCode());

										// 此处叶子设备的x、y值就取本身的值，在生成NodeFigureInfo的时候再进行组合
										// if(deviceTmp.getFigureX()!=null &&
										// devClone.getFigureX()!=null) {
										// devClone.setFigureX(deviceTmp.getFigureX()+devClone.getFigureX());
										// }
										// if(deviceTmp.getFigureY()!=null &&
										// devClone.getFigureY()!=null) {
										// devClone.setFigureY(deviceTmp.getFigureY()+devClone.getFigureY());
										// }

										leafDeviceList.add(devClone);
									}
								}
							}
						}
					}
				}
			}
		} catch (Exception e) {
			logger.error("Query interface configuring all leaf device exception for configuration devices", e);
		}

		return leafDeviceList;
	}

	private String generatParShowIndex(String parShowIndex, String showIndex) {
		String sumShowIndex = "";
		if (StringUtils.isNotBlank(parShowIndex) && StringUtils.isNotBlank(showIndex)) {
			sumShowIndex = parShowIndex + "," + showIndex;// getShowIndex不允许为空
		} else {
			sumShowIndex = StringUtils.isNotBlank(showIndex) ? showIndex
					: (StringUtils.isNotBlank(parShowIndex) ? parShowIndex : "");
		}
		return sumShowIndex;
	}

	// 根据界面配置的信息，组合成node_figure_info表的记录
	// posiIndex:用于生成nameFlag（只对deviceTypeInfo表nameFormat字段包含[X]和[Y]的设备有效）
	private void configAndSaveNodeFigureInfo(List<DeviceInfo> devConfigList, Date createDate, Long nodePid,
			String devParShowIndex, String parDevCode, String posiIndex, Long parX, Long parY) {
		try {
			commonService.beginTransaction();
			if (devConfigList != null && devConfigList.size() > 0 && StringUtils.isNotBlank(devParShowIndex)
					&& StringUtils.isNotBlank(parDevCode) && nodePid != null && createDate != null) {

				for (int i = 0; i < devConfigList.size();) {
					DeviceInfo dev = devConfigList.get(i);
					if (dev == null) {
						devConfigList.remove(i);
					} else if (dev != null && parDevCode.equals(dev.getParDeviceCode()) // 父设备型号+parShowIndex
							&& devParShowIndex.equals(dev.getParShowIndex())) {
						NodeFigureInfo nodeFigure = createNodeFigure(dev, createDate, nodePid, posiIndex, parX, parY);// 生成nodeFigureInfo记录
						this.commonService.save(nodeFigure);
						Long nodeFigureId = nodeFigure.getId();
						devConfigList.remove(i);

						if (dev.getIsLeaf() != null && dev.getIsLeaf() != 1l) {// 如果是非叶子设备，则生成nodeFigureInfo存入list
							String parShowIndex = generatParShowIndex(devParShowIndex, dev.getShowIndex());
							configAndSaveNodeFigureInfo(devConfigList, createDate, nodeFigureId, parShowIndex,
									dev.getDeviceCode(), dev.getShowIndex(), nodeFigure.getFigureX(),
									nodeFigure.getFigureY());
							i = 0;// 每次递归回来，重置i为0
						}

					} else {
						i++;
					}
				}
			}
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			logger.error("Recursive generation of nodeFigureInfo records exception", e);
		}
	}

	/**
	 * deviceConfig:要生成nodeFigureInfo的设备 parshowIndex:当前设备的父设备在祖父设备中的位置
	 * X、Y：界面配置的设备的xy坐标由jsp页面进行组合，从后台查询的叶子设备的xy坐标，由createNodeFigure()方法组合
	 * deviceConfig：jsp界面配置的设备或者后台查询的叶子设备 pid：nodeFigureInfo记录的父id
	 * [X]：parPosiIndex：当前设备的父设备在祖父设备的位置标号（创建端口时，为板卡在机框的卡槽位置）--替换[X]
	 * [Y]:为设备自身在父设备的位置标号
	 * parX、parY：父设备左上角的坐标（设备的位置=父亲设备左上角的坐标+设备自身距离父设备左上角坐标的距离）
	 */
	private NodeFigureInfo createNodeFigure(DeviceInfo deviceConfig, Date createDate, Long pid, String parPosiIndex,
			Long parX, Long parY) {
		NodeFigureInfo nodeFigure = new NodeFigureInfo();
		try {
			if (deviceConfig.getId() != null && deviceConfig != null && parX != null && parY != null) {
				DeviceTypeInfo deviceInfo = (DeviceTypeInfo) this.commonService.get(DeviceTypeInfo.class,
						deviceConfig.getId());

				nodeFigure.setPid(pid);
				nodeFigure.setDeviceTypeCode(deviceInfo.getDeviceTypeCode());
				nodeFigure.setSeqid(Long.parseLong(seqId));
				nodeFigure.setShowLevel(deviceInfo.getShowLevel() == null ? null : deviceInfo.getShowLevel());

				// 如果是非叶子设备，[Y]都替换为自己在父设备中的位置，[X]其实是当前设备的父设备在祖父设备中的位置
				Long selfShowIndex = deviceConfig.getShowIndex() == null ? null
						: Long.parseLong(deviceConfig.getShowIndex());// 组合设备后，当前设备在父设备中的位置
				// 叶子设备：不能再接子设备了,showIndex取设备本身的showIndex，
				nodeFigure.setShowIndex(selfShowIndex);

				// nameFlag进行替换（目前只替换叶子设备的，如果顶级父设备包含[X]、[Y]，也不进行替换,因为nameFlag是为了查询端口、风扇、电源等的监测信息）：[X]:本设备占用父设备的位置的标号，[Y]设备本身的showIndex
				String nameFormat = deviceInfo.getNameFormat();
				if (StringUtils.isNotBlank(nameFormat)
						&& (nameFormat.toUpperCase().contains("[X]") || nameFormat.toUpperCase().contains("[Y]"))
						&& selfShowIndex != null && parPosiIndex != null
						&& (deviceInfo.getIsLeaf() != null && deviceInfo.getIsLeaf() == 1l)) {
					nameFormat = nameFormat.replace("[X]", parPosiIndex);
					nameFormat = nameFormat.replace("[Y]", selfShowIndex.toString());
				}
				if (StringUtils.isBlank(nameFormat)) {
					nameFormat = deviceInfo.getDeviceTypeCode();
				}
				nodeFigure.setNameFlag(nameFormat);

				nodeFigure.setPortOperStatus(-1l);
				nodeFigure.setPortStatus(-1l);

				nodeFigure.setFigureType(deviceInfo.getFigureType());
				/**
				 * jsp界面上，把板卡的x，y替换为卡槽的x，y， 每个设备的x，y取决于父设备的x，y，
				 * 父设备的x，y等于：父设备的x，y加上自身和父设备的距离（device_type_info表中，自身的坐标是以父设备为基准点的）
				 */
				nodeFigure.setFigureX(parX + deviceConfig.getFigureX());// 顶级设备的显示的位置都是固定的，暂时从DeviceTypeInfo表里取
				nodeFigure.setFigureY(parY + deviceConfig.getFigureY());

				nodeFigure.setFigureWidth(deviceInfo.getFigureWidth());
				nodeFigure.setFigureHeight(deviceInfo.getFigureHeight());
				nodeFigure.setFigureStroke(deviceInfo.getFigureStroke());
				nodeFigure.setFigureStrokeWidth(deviceInfo.getFigureStrokeWidth());
				nodeFigure.setFigureFill(deviceInfo.getFigureFill());

				// data_check_time_digital为空

				nodeFigure.setAddTime(createDate);
				nodeFigure.setAddUserid(getUserID());
				nodeFigure.setLastUpdateTime(createDate);
				nodeFigure.setLastUpdateUserid(getUserID());

				nodeFigure.setFigureFillModel(deviceInfo.getFigureFill());
				nodeFigure.setIsLeaf(deviceInfo.getIsLink() == null ? null : deviceInfo.getIsLink());// 是否有连接
				nodeFigure.setPortsetState(1l);// 默认端口设置状态为up
			}
		} catch (Exception e) {
			logger.error("Generate nodeFigureInfo object from DeviceInfo exception", e);
		}

		return nodeFigure;
	}

	public static void main(String[] args) {

		// List<NodeFigureInfo> tmp = (List<NodeFigureInfo>)new
		// SwitchDetectionAction().getNodeFigureInfos("40");
		String str = "MPUA[X]";
		System.out.println(str.replace("[X]", "[1]"));

		List<String> aList = new ArrayList<String>();
		aList.add("1");
		aList.add("2a");
		aList.add("3");
		aList.add("4a");
		Iterator ite = aList.iterator();
		while (ite.hasNext()) {
			aList.remove(0);
		}
		//
		// for(String str:aList) {
		// if(str.contains("a")) {
		// aList.remove(str);
		// }
		// }
		//
		// System.out.println(aList.size());

		// System.out.println(1365730307000l+(1365730307000l-1365729407000l));
		// String num = "13270452850";
		// // String num = "1195874669";
		// // String num = "3254887187";
		// // String num = "325537591";
		// String str = "27 days, 5:39:39.20";
		// SwitchDetectionAction sd = new SwitchDetectionAction();
		// try
		// {
		//
		// String webPathTmp =
		// SwitchDetectionAction.class.getClassLoader().getResource("mibs3").getPath();
		// // File file = new File(webPathTmp+"/a.txt");
		// //
		// System.out.println(webPathTmp);
		// // FileUtils.writeStringToFile(file, "aa");
		// // System.out.println(sd.converseSysUpTime(num));
		// // System.out.println(sd.converseSysUpTime(str));
		// } catch (Exception e)
		// {
		// e.printStackTrace();
		// }
		//
	}

	// 根据seqId获取对应的ip地址
	private String getIpBySeqId(String seqId) {
		String ipStr = "";
		try {
			if (StringUtils.isNotBlank(seqId)) {
				List<NodeTable> nodeList = (List<NodeTable>) this.commonService
						.find("from NodeTable where seqId=" + seqId);
				if (nodeList != null && nodeList.size() > 0) {
					NodeTable node = nodeList.get(0);
					ipStr = node.getNodeIp();
				}
			}
		} catch (Exception e) {
			logger.error("Get ip exception based on seqId：" + seqId , e);
		}
		return ipStr;
	}

	/**
	 * 查看具体端口信息: 根据seqId、detectId（监测设置id）、flagName，查询此端口的详细信息
	 * 1.根据seqId、detectId，从detection_info_new查询最新周期的监测时间，从而得到最新信息在detection_info表所在的表分区
	 * 2.再将detection_info表和di_switchport表左连接，获取端口的最新详细信息
	 * 
	 */
	public SwitchPortInfo detailPortInfo2(String nameFlag, String detailTabName, Long checkTimeDigital, Long checkGap) {
		SwitchPortInfo portInfo = new SwitchPortInfo();
		try {
			if (checkGap == null) {
				checkGap = defaultPortGap + defaultDelay;
			} else {
				checkGap = checkGap + defaultDelay;
			}
			long period = 2 * checkGap * 60 * 1000;// 2个周期
			long curTime = new Date().getTime();
			if (checkTimeDigital == null || (checkTimeDigital != null && (curTime - checkTimeDigital) > period)) {// 超时未接收到监测信息
				switchPortInfo.setIfDescr(nameFlag);// ifdescr:接口描述
				switchPortInfo.setIfInOctetsSpeed(0d);// inoctetsspeed:输入速率
				switchPortInfo.setIfInErrorsScale(0d);// inerrorsscale:输入差错率
				switchPortInfo.setIfTypeStr("");// iftypestr:端口类型
				switchPortInfo.setOutpktsspeed(0d);// 发包速率
				switchPortInfo.setIfOutErrorsScale(0d);// 输出差错率
				switchPortInfo.setIfOutOctetsSpeed(0d);// 输出速度
				switchPortInfo.setInpktsspeed(0d);// 收包速率
				switchPortInfo.setIfoutdiscardsperc(0d);// 输出丢包率
				switchPortInfo.setIfindiscardsperc(0d);// 输入丢包率
				switchPortInfo.setIfPhysAddress("");
				switchPortInfo.setIfSpeedStr(null);// 端口的每秒比特数：带宽
				switchPortInfo.setIfSpeed(0l);
				switchPortInfo.setIfHighSpeed(0l);
				switchPortInfo.setIfLastChangeStr("");// 在端口进入当前运作状态时，系统的sysUpTime
				// 的评估
				switchPortInfo.setIfOperStatus(-1);// 端口的运行状态
				switchPortInfo.setIfAdminStatus(-1);// 端口的运行状态

				switchPortInfo.setIfindiscardsVary(0l);// 输入丢包数
				switchPortInfo.setIfoutdiscardsVary(0l);// 输出丢包数
				switchPortInfo.setIfinerrorsVary(0l);// 输入差错数
				switchPortInfo.setIfouterrorsVary(0l);// 输出差错数
			} else if (StringUtils.isNotBlank(seqId) && StringUtils.isNotBlank(nameFlag)
					&& StringUtils.isNotBlank(detailTabName) && checkTimeDigital != null) {

				// String tableName = "di_switchport";
				String dataCheckTimeTmp = DateUtil.longToDate((checkTimeDigital), "yyyy-MM-dd HH:mm:ss");// 减去1000相当于1秒
				String dataCheckTimeTmp2 = DateUtil.longToDate((checkTimeDigital - 1000), "yyyy-MM-dd HH:mm:ss");// 减去1000相当于1秒
				String sql = " SELECT " + " DS.IFDESCR," + // 0
						" DS.IFINOCTETS," + // 1
						" DS.IFINUCASTPKTS," + // 2
						" DS.IFINNUCASTPKTS," + // 3
						" DS.IFINUNKNOWNPROTOS," + // 4
						" DS.IFOUTOCTETS," + // 5
						" DS.IFOUTUCASTPKTS," + // 6
						" DS.IFOUTNUCASTPKTS," + // 7
						" DS.IFTYPE," + // 8
						" DS.OUTPKTSSPEED," + // 9
						" DS.OUTERRORSSCALE," + // 10
						" DS.OUTOCTETSSPEED," + // 11
						" DS.INPKTSSPEED," + // 12
						" DS.INERRORSSCALE," + // 13
						" DS.INOCTETSSPEED," + // 14
						" DS.IFOUTDISCARDSPERC," + // 15
						" DS.IFINDISCARDSPERC," + // 16
						" DS.IFPHYSADDRESS," + // 17
						" DS.IFSPEED," + // 18从数据库取出的数据带宽单位 为：BPS
						" DS.IFLASTCHANGE," + // 19
						" DS.IFOPERSTATUS," + // 20
						" DS.IFADMINSTATUS," + // 21
						" DS.IFINDISCARDS_VARY," + // 22输入丢包数
						" DS.IFOUTDISCARDS_VARY," + // 23输出丢包数
						" DS.IFINERRORS_VARY," + // 24输入差错数
						" DS.IFOUTERRORS_VARY," + // 25输出差错数
						" DS.IFHIGHSPEED, " + // 26 从数据库取出的数据带宽单位
												// 为：MBPS，优先考虑MBPS
						" DS.DATA_64_FLAG, " + // 27 端口数据64位标识
						" DS.DATA_CHECK_TIME_DIGITAL " + " FROM " + detailTabName + " DS" + " WHERE  DS.IFDESCR='"
						+ nameFlag + "'" + "  AND DS.SEQ_ID= " + seqId
						/*
						 * + "  AND (DS.DATA_CHECK_TIME = (" +
						 * " SELECT  DSTMP.DATA_CHECK_TIME    " +
						 * " FROM ( SELECT  DS.DATA_CHECK_TIME      " +
						 * " FROM "+ detailTabName + " DS " + //
						 * " WHERE  DS.IFDESCR='" + nameFlag + "' AND" +
						 * " WHERE "+ " DS.SEQ_ID="+ seqId +
						 * " AND DS.DATA_CHECK_TIME <=TO_DATE('" +
						 * dataCheckTimeTmp2+"','yyyy-MM-dd HH24:mi:ss')" +
						 * //上面的时间减去1000是为了用<=,这样可以加快执行速度
						 * " ORDER BY  DS.DATA_CHECK_TIME DESC) DSTMP " +
						 * " WHERE  ROWNUM=1" + ")"
						 */
						// @2018年4月10日18:42:06 fang 修改rownum 适配mysql
						+ "  AND (DS.DATA_CHECK_TIME = (" + " SELECT  DATA_CHECK_TIME    "
						+ " FROM ( SELECT  max(DS.DATA_CHECK_TIME)      " + " FROM " + detailTabName + " DS "
						+ " WHERE " + " DS.SEQ_ID=" + seqId + " AND DS.DATA_CHECK_TIME <=TO_DATE('" + dataCheckTimeTmp2
						+ "','yyyy-MM-dd HH24:mi:ss')" + // 上面的时间减去1000是为了用<=,这样可以加快执行速度
						" ) DSTMP " + ")" + " OR DS.DATA_CHECK_TIME =TO_DATE('" + dataCheckTimeTmp
						+ "','yyyy-MM-dd HH24:mi:ss')" + ")"
						+ "       ORDER BY DS.IFDESCR ASC ,DS.DATA_CHECK_TIME DESC";
				logger.info("查询端口详细信息sql：" + sql);
				List<Object[]> dateList = commonService.executeSQL(sql);
				if (dateList != null && dateList.size() > 0) {

					List<SwitchPortInfoSource> spislist = new ArrayList<SwitchPortInfoSource>();
					for (Object[] objs : dateList) {
						SwitchPortInfoSource spis = new SwitchPortInfoSource();

						spis.setIfDescr(objs[0] == null ? null : (String) objs[0]);// ifdescr:接口描述

						spis.setIfInOctets(objs[1] == null ? 0d : ((BigDecimal) objs[1]).doubleValue());// 输入字节
						spis.setIfInUcastPkts(objs[2] == null ? 0d : ((BigDecimal) objs[2]).doubleValue());//
						spis.setIfInNUcastPkts(objs[3] == null ? 0d : ((BigDecimal) objs[3]).doubleValue());//
						spis.setIfInUnknownProtos(objs[4] == null ? 0d : ((BigDecimal) objs[4]).doubleValue());//

						spis.setIfOutOctets(objs[5] == null ? 0d : ((BigDecimal) objs[5]).doubleValue());//
						spis.setIfOutUcastPkts(objs[6] == null ? 0d : ((BigDecimal) objs[6]).doubleValue());//
						spis.setIfOutNUcastPkts(objs[7] == null ? 0d : ((BigDecimal) objs[7]).doubleValue());//

						spis.setIfType(objs[8] == null ? 0 : (((BigDecimal) objs[8]).intValue()));//

						spis.setOutpktsspeed(objs[9] == null ? 0d : ((BigDecimal) objs[9]).doubleValue());// 发包速率
						spis.setIfOutErrorsScale(objs[10] == null ? 0d : ((BigDecimal) objs[10]).doubleValue());// 输出差错率
						spis.setIfOutOctetsSpeed(objs[11] == null ? 0d : ((BigDecimal) objs[11]).doubleValue());// 输出速度

						spis.setInpktsspeed(objs[12] == null ? 0d : ((BigDecimal) objs[12]).doubleValue());// 收包速率
						spis.setIfInErrorsScale(objs[13] == null ? 0d : ((BigDecimal) objs[13]).doubleValue());//
						spis.setIfInOctetsSpeed(objs[14] == null ? 0d : ((BigDecimal) objs[14]).doubleValue());//

						spis.setIfoutdiscardsperc(objs[15] == null ? 0d : ((BigDecimal) objs[15]).doubleValue());// 输出丢包率
						spis.setIfindiscardsperc(objs[16] == null ? 0d : ((BigDecimal) objs[16]).doubleValue());// 输入丢包率
						spis.setIfPhysAddress(objs[17] == null ? null : (String) objs[17]);

						spis.setIfSpeed(objs[18] == null ? null : (((BigDecimal) objs[18]).longValue()));// 端口的每秒比特数：带宽
						spis.setIfLastChangeStr(objs[19] == null ? null : (String) objs[19]);// 在端口进入当前运作状态时，系统的sysUpTime
						// 的评估
						spis.setIfOperStatus(objs[20] == null ? null : ((BigDecimal) objs[20]).intValue());// 端口的运行状态
						spis.setIfAdminStatus(objs[21] == null ? null : ((BigDecimal) objs[21]).intValue());// 端口的运行状态

						spis.setIfindiscardsVary(objs[22] == null ? 0l : ((BigDecimal) objs[22]).longValue());// 输入丢包数
						spis.setIfoutdiscardsVary(objs[23] == null ? 0l : ((BigDecimal) objs[23]).longValue());// 输出丢包数
						spis.setIfinerrorsVary(objs[24] == null ? 0l : ((BigDecimal) objs[24]).longValue());// 输入差错数
						spis.setIfouterrorsVary(objs[25] == null ? 0l : ((BigDecimal) objs[25]).longValue());// 输出差错数

						spis.setIfHighSpeed(objs[26] == null ? null : (((BigDecimal) objs[26]).longValue()));// 26
																												// 端口的每秒兆比特数：带宽
						spis.setData64Flag(objs[27] == null ? 0 : (((BigDecimal) objs[27]).intValue()));// 27
																										// 端口数据64位标识
						spis.setLastLongTime(objs[28] == null ? null : (((BigDecimal) objs[28]).longValue()));
						spislist.add(spis);
					}

					String thisIfindex = "";
					for (int i = 0; i < spislist.size(); i++) {

						SwitchPortInfoSource news = spislist.get(i);
						thisIfindex = news.getIfDescr();
						SwitchPortInfoSource olds = null;
						i++;
						if (i < spislist.size()) {
							olds = spislist.get(i);
							if (olds != null && thisIfindex.equalsIgnoreCase(olds.getIfDescr())) {
								switchPortInfo = resetData(olds, news);
								break;
							} else {
								i--;
							}
						}
					}

					// 输出速度和输入速度：大于等于1000000，的除以1000000，转换为MBps，小于1000000的直接显示
					BigDecimal bFromB = new BigDecimal(8);

					BigDecimal ifInOctetsSpeedTmp = switchPortInfo.getIfInOctetsSpeed() == null ? null
							: new BigDecimal(switchPortInfo.getIfInOctetsSpeed()).multiply(bFromB).setScale(0,
									BigDecimal.ROUND_UP);
					BigDecimal ifOutOctetsSpeedTmp = switchPortInfo.getIfOutOctetsSpeed() == null ? null
							: new BigDecimal(switchPortInfo.getIfOutOctetsSpeed()).multiply(bFromB).setScale(0,
									BigDecimal.ROUND_UP);
					switchPortInfo
							.setIfInOctetsSpeed(ifInOctetsSpeedTmp == null ? 0d : ifInOctetsSpeedTmp.doubleValue());// inoctetsspeed:输入速率
					switchPortInfo
							.setIfOutOctetsSpeed(ifOutOctetsSpeedTmp == null ? 0d : ifOutOctetsSpeedTmp.doubleValue());// 输出速度
					switchPortInfo.setIfInErrorsScale(switchPortInfo.getIfInErrorsScale() == null ? null
							: new BigDecimal(switchPortInfo.getIfInErrorsScale()).setScale(0, BigDecimal.ROUND_UP)
									.doubleValue());// inerrorsscale:输入差错率
					switchPortInfo.setOutpktsspeed(switchPortInfo.getOutpktsspeed() == null ? null
							: new BigDecimal(switchPortInfo.getOutpktsspeed()).setScale(0, BigDecimal.ROUND_UP)
									.doubleValue());// 发包速率
					switchPortInfo.setIfOutErrorsScale(switchPortInfo.getIfOutErrorsScale() == null ? null
							: new BigDecimal(switchPortInfo.getIfOutErrorsScale()).setScale(0, BigDecimal.ROUND_UP)
									.doubleValue());// 输出差错率
					switchPortInfo.setInpktsspeed(switchPortInfo.getInpktsspeed() == null ? null
							: new BigDecimal(switchPortInfo.getInpktsspeed()).setScale(0, BigDecimal.ROUND_UP)
									.doubleValue());// 收包速率
					switchPortInfo.setIfoutdiscardsperc(switchPortInfo.getIfoutdiscardsperc() == null ? null
							: new BigDecimal(switchPortInfo.getIfoutdiscardsperc()).setScale(0, BigDecimal.ROUND_UP)
									.doubleValue());// 输出丢包率
					switchPortInfo.setIfindiscardsperc(switchPortInfo.getIfindiscardsperc() == null ? null
							: new BigDecimal(switchPortInfo.getIfindiscardsperc()).setScale(0, BigDecimal.ROUND_UP)
									.doubleValue());// 输入丢包率

					switchPortInfo.setIfTypeStr(switchPortInfo.getIfType() + "");
				} else {
					// switchPortInfo = null;
					switchPortInfo.setIfDescr(nameFlag);// ifdescr:接口描述
					switchPortInfo.setIfInOctetsSpeed(0d);// inoctetsspeed:输入速率
					switchPortInfo.setIfInErrorsScale(0d);// inerrorsscale:输入差错率
					switchPortInfo.setIfTypeStr("");// iftypestr:端口类型
					switchPortInfo.setOutpktsspeed(0d);// 发包速率
					switchPortInfo.setIfOutErrorsScale(0d);// 输出差错率
					switchPortInfo.setIfOutOctetsSpeed(0d);// 输出速度
					switchPortInfo.setInpktsspeed(0d);// 收包速率
					switchPortInfo.setIfoutdiscardsperc(0d);// 输出丢包率
					switchPortInfo.setIfindiscardsperc(0d);// 输入丢包率
					switchPortInfo.setIfPhysAddress("");
					switchPortInfo.setIfSpeedStr(null);// 端口的每秒比特数：带宽
					switchPortInfo.setIfSpeed(0l);
					switchPortInfo.setIfHighSpeed(0l);

					switchPortInfo.setIfLastChangeStr("");// 在端口进入当前运作状态时，系统的sysUpTime
					// 的评估
					switchPortInfo.setIfOperStatus(-1);// 端口的运行状态
					switchPortInfo.setIfAdminStatus(-1);// 端口的运行状态

					switchPortInfo.setIfindiscardsVary(0l);// 输入丢包数
					switchPortInfo.setIfoutdiscardsVary(0l);// 输出丢包数
					switchPortInfo.setIfinerrorsVary(0l);// 输入差错数
					switchPortInfo.setIfouterrorsVary(0l);// 输出差错数
				}

			}
			portInfo = switchPortInfo;
		} catch (Exception e) {
			logger.error("Query port details exception", e);
		}

		return portInfo;
	}

	/**
	 * 查询所有端口的详细信息：端口名称、带宽、输入、输出的bps、pps: seqId+di_switchport:node_figure_info
	 * ->nameFlag 1.如果最大监测时间超时，则map中无数据，4个值为0 2.如果最大监测时间不超时，则生成map
	 * 
	 */
	public void detailAllPortInfo(Long checkTimeDigital, Long checkGap) {
		try {
			if (StringUtils.isNotBlank(seqId)) {
				String detailTabName = Constants.DI_SWITCHPORT_TABLE_NAME;
				// Long checkTimeDigital =
				// getLatestDetectTimeDigitalBySeqId(detailTabName,
				// seqId);
				// Long checkGap = getLatestCheckGapBySeqId(detailTabName,
				// seqId);
				if (checkGap == null) {
					System.out.println(checkGap);
					checkGap = defaultPortGap;
				}
				long period = (2 * checkGap + defaultDelay) * 60 * 1000;// 2个周期+5分钟延迟
				long curTime = new Date().getTime();
				if (checkTimeDigital != null && (curTime - checkTimeDigital) <= period) {// 数据未超时
																							// 数据查询sql
					String dataCheckTimeTmp = DateUtil.longToDate((checkTimeDigital), "yyyy-MM-dd HH:mm:ss");
					String dataCheckTimeTmp2 = DateUtil.longToDate((checkTimeDigital - 1000), "yyyy-MM-dd HH:mm:ss");
					String datasSql = "SELECT " + "IFINDEX,"// 0
							+ "IFDESCR,"// 1
							+ "IFTYPE,"// 2
							+ "IFMTU,"// 3
							+ "IFSPEED,"// 4
							+ "IFPHYSADDRESS,"// 5
							+ "IFADMINSTATUS,"// 6
							+ "IFOPERSTATUS,"// 7
							+ "IFLASTCHANGE,"// 8
							+ "IFINOCTETS,"// 9
							+ "IFINUCASTPKTS,"// 10
							+ "IFINNUCASTPKTS,"// 11
							+ "IFINDISCARDS,"// 12
							+ "IFINERRORS,"// 13
							+ "IFINUNKNOWNPROTOS,"// 14
							+ "IFOUTOCTETS,"// 15
							+ "IFOUTUCASTPKTS,"// 16
							+ "IFOUTNUCASTPKTS,"// 17
							+ "IFOUTDISCARDS," // 18
							+ "IFOUTERRORS,"// 19
							+ "IFOUTQLEN,"// 20
							+ "IFSPECIFIC,"// 21
							+ "DSP.DATA_CHECK_TIME_DIGITAL, "// 22
							+ "DSP.INOCTETSSPEED, "// 23
							+ "DSP.OUTOCTETSSPEED, "// 24
							+ "DSP.INPKTSSPEED, "// 25
							+ "DSP.OUTPKTSSPEED, "// 26
							+ "DSP.IFINDISCARDS_VARY, "// 27
							+ "DSP.IFOUTDISCARDS_VARY, "// 28
							+ "DSP.IFINERRORS_VARY, "// 29
							+ "DSP.IFOUTERRORS_VARY, "// 30
							+ "DSP.IFHIGHSPEED, "// 31
							+ "DSP.DATA_64_FLAG "// 32
							+ " FROM DI_SWITCHPORT DSP " + " WHERE  DSP.SEQ_ID = " + seqId
							/*
							 * + " AND (  DSP.DATA_CHECK_TIME = (" +
							 * " SELECT DSTMP.DATA_CHECK_TIME  " +
							 * " FROM (SELECT DS.DATA_CHECK_TIME " +
							 * " FROM "+detailTabName+" DS" +
							 * "  WHERE  DS.SEQ_ID="+seqId +
							 * "         AND DS.DATA_CHECK_TIME<=TO_DATE('" +
							 * dataCheckTimeTmp2+"','yyyy-MM-dd HH24:mi:ss') "
							 * ////上面的时间减去1000是为了用<=,这样可以加快执行速度 +
							 * "  ORDER BY DS.DATA_CHECK_TIME DESC) DSTMP" +
							 * " WHERE ROWNUM=1" +")"
							 */
							// @2018年4月10日18:35:52 fang 修改rownum 适配 mysql
							+ " AND (  DSP.DATA_CHECK_TIME = (" + " SELECT max(DSTMP.DATA_CHECK_TIME)  "
							+ " FROM (SELECT DS.DATA_CHECK_TIME " + " FROM " + detailTabName + " DS"
							+ "  WHERE  DS.SEQ_ID=" + seqId + "         AND DS.DATA_CHECK_TIME<=TO_DATE('"
							+ dataCheckTimeTmp2 + "','yyyy-MM-dd HH24:mi:ss') " //// 上面的时间减去1000是为了用<=,这样可以加快执行速度
							+ "  ) DSTMP" + ")" + " OR DSP.DATA_CHECK_TIME = TO_DATE('" + dataCheckTimeTmp
							+ "','yyyy-MM-dd HH24:mi:ss')" + " )"// 查询最新的两条记录
							+ " ORDER BY DSP.IFDESCR ASC,DSP.DATA_CHECK_TIME DESC";

					/* 查询 最新时间点的数据 */
					List<Object[]> lastDatasList = commonService.executeSQL(datasSql);
					if (lastDatasList != null && lastDatasList.size() > 0) {
						List<SwitchPortInfoSource> siList = new ArrayList<SwitchPortInfoSource>();
						for (Object[] objs : lastDatasList) {
							SwitchPortInfoSource si = new SwitchPortInfoSource();
							si.setIfIndex(objs[0] == null ? null : ((BigDecimal) objs[0]).intValue());
							si.setIfDescr(objs[1] == null ? null : (String) objs[1]);
							si.setIfType(objs[2] == null ? null : ((BigDecimal) objs[2]).intValue());
							si.setIfMtu(objs[3] == null ? null : ((BigDecimal) objs[3]).intValue());
							si.setIfSpeed(objs[4] == null ? null : ((BigDecimal) objs[4]).longValue());
							si.setIfPhysAddress(objs[5] == null ? null : (String) objs[5]);
							si.setIfAdminStatus(objs[6] == null ? null : ((BigDecimal) objs[6]).intValue());
							si.setIfOperStatus(objs[7] == null ? null : ((BigDecimal) objs[7]).intValue());

							si.setIfInOctets(objs[9] == null ? null : ((BigDecimal) objs[9]).doubleValue());
							si.setIfInUcastPkts(objs[10] == null ? null : ((BigDecimal) objs[10]).doubleValue());
							si.setIfInNUcastPkts(objs[11] == null ? null : ((BigDecimal) objs[11]).doubleValue());
							si.setIfInDiscards(objs[12] == null ? null : ((BigDecimal) objs[12]).doubleValue());
							si.setIfInErrors(objs[13] == null ? null : ((BigDecimal) objs[13]).doubleValue());
							si.setIfInUnknownProtos(objs[14] == null ? null : ((BigDecimal) objs[14]).doubleValue());

							si.setIfOutOctets(objs[15] == null ? null : ((BigDecimal) objs[15]).doubleValue());
							si.setIfOutUcastPkts(objs[16] == null ? null : ((BigDecimal) objs[16]).doubleValue());
							si.setIfOutNUcastPkts(objs[17] == null ? null : ((BigDecimal) objs[17]).doubleValue());

							si.setIfOutDiscards(objs[18] == null ? null : ((BigDecimal) objs[18]).doubleValue());
							si.setIfOutErrors(objs[19] == null ? null : ((BigDecimal) objs[19]).doubleValue());

							si.setIfOutQLen(objs[20] == null ? null : ((BigDecimal) objs[20]).doubleValue());
							si.setIfSpecific(objs[21] == null ? null : (String) objs[21]);
							si.setLastLongTime(objs[22] == null ? null : ((BigDecimal) objs[22]).longValue());

							// 输入、输出速度，收包、发包速率
							si.setIfInOctetsSpeed(objs[23] == null ? 0.00d : ((BigDecimal) objs[23]).doubleValue());
							si.setIfOutOctetsSpeed(objs[24] == null ? 0.00d : ((BigDecimal) objs[24]).doubleValue());
							si.setInpktsspeed(objs[25] == null ? 0.00d : ((BigDecimal) objs[25]).doubleValue());
							si.setOutpktsspeed(objs[26] == null ? 0.00d : ((BigDecimal) objs[26]).doubleValue());

							si.setIfindiscardsVary(objs[27] == null ? null : ((BigDecimal) objs[27]).longValue());
							si.setIfoutdiscardsVary(objs[28] == null ? null : ((BigDecimal) objs[28]).longValue());
							si.setIfinerrorsVary(objs[29] == null ? null : ((BigDecimal) objs[29]).longValue());
							si.setIfouterrorsVary(objs[30] == null ? null : ((BigDecimal) objs[30]).longValue());
							si.setIfHighSpeed(objs[31] == null ? null : ((BigDecimal) objs[31]).longValue());
							si.setData64Flag(objs[32] == null ? 0 : ((BigDecimal) objs[32]).intValue());
							siList.add(si);
						}

						String thisIfindex = "";

						// 当端口只有一条记录时，map里也没有值
						for (int i = 0; i < siList.size(); i++) {
							SwitchPortInfoSource news = siList.get(i);
							thisIfindex = news.getIfDescr();
							SwitchPortInfoSource olds = null;
							i++;
							if (i < siList.size()) {
								olds = siList.get(i);
								if (olds != null && thisIfindex.equalsIgnoreCase(olds.getIfDescr())) {
									SwitchPortInfo portInfoTmp = resetData(olds, news);
									// 输出速度和输入速度：大于等于1000000，的除以1000000，转换为MBps，小于1000000的直接显示
									BigDecimal bFromB = new BigDecimal(8);

									BigDecimal ifInOctetsSpeedTmp = portInfoTmp.getIfInOctetsSpeed() == null ? null
											: new BigDecimal(portInfoTmp.getIfInOctetsSpeed()).multiply(bFromB)
													.setScale(0, BigDecimal.ROUND_UP);
									BigDecimal ifOutOctetsSpeedTmp = portInfoTmp.getIfOutOctetsSpeed() == null ? null
											: new BigDecimal(portInfoTmp.getIfOutOctetsSpeed()).multiply(bFromB)
													.setScale(0, BigDecimal.ROUND_UP);
									portInfoTmp.setIfOutOctetsSpeed(
											ifOutOctetsSpeedTmp == null ? 0d : ifOutOctetsSpeedTmp.doubleValue());// 输出速度
									portInfoTmp.setIfInOctetsSpeed(
											ifInOctetsSpeedTmp == null ? 0d : ifInOctetsSpeedTmp.doubleValue());// inoctetsspeed:输入速率

									portInfoTmp
											.setIfOutOctetsSpeedStr(
													MyNumberFormat
															.formatStr1(
																	portInfoTmp.getIfOutOctetsSpeed() == null ? null
																			: new BigDecimal(
																					portInfoTmp.getIfOutOctetsSpeed()),
																	0, 1024));
									portInfoTmp
											.setIfInOctetsSpeedStr(
													MyNumberFormat
															.formatStr1(
																	portInfoTmp.getIfInOctetsSpeed() == null ? null
																			: new BigDecimal(
																					portInfoTmp.getIfInOctetsSpeed()),
																	0, 1024));

									portInfoTmp.setOutpktsspeed(portInfoTmp.getOutpktsspeed() == null ? null
											: new BigDecimal(portInfoTmp.getOutpktsspeed())
													.setScale(0, BigDecimal.ROUND_UP).doubleValue());// 发包速率
									portInfoTmp.setInpktsspeed(portInfoTmp.getInpktsspeed() == null ? null
											: new BigDecimal(portInfoTmp.getInpktsspeed())
													.setScale(0, BigDecimal.ROUND_UP).doubleValue());// 收包速率

									String speedStr = portInfoTmp.getIfHighSpeed() == null ? MyNumberFormat
											.formatStr1(new BigDecimal(portInfoTmp.getIfSpeed()), 0, 1000)
											: portInfoTmp.getIfHighSpeed() + "Mbps";
									portInfoTmp.setSpeedStr(speedStr);

									switchPortMap.put(portInfoTmp.getIfDescr(), portInfoTmp);
								} else {
									i--;
								}
							}
						}
					}
				}
			}

		} catch (Exception e) {
			logger.error("Query all port details exception", e);
		}
	}

	/**
	 * 查看具体端口信息: 根据seqId、detectId（监测设置id）、flagName，查询此端口的详细信息
	 * 1.根据seqId、detectId，从detection_info_new查询最新周期的监测时间，从而得到最新信息在detection_info表所在的表分区
	 * 2.再将detection_info表和di_switchport表左连接，获取端口的最新详细信息
	 * 
	 */
	/*
	 * public void detailPortInfo(String nameFlag,String detailTabName,Long
	 * checkTimeDigital,Long checkGap) { try { if(checkGap==null) {
	 * checkGap=defaultPortGap+defaultDelay; }else {
	 * checkGap=checkGap+defaultDelay; } long period = 2*checkGap*60*1000;//2个周期
	 * long curTime = new Date().getTime(); if(checkTimeDigital==null ||
	 * (checkTimeDigital!=null&&(curTime-checkTimeDigital)>period))
	 * {//超时未接收到监测信息 switchPortInfo.setIfDescr(nameFlag);//ifdescr:接口描述
	 * switchPortInfo.setIfInOctetsSpeed(0d);//inoctetsspeed:输入速率
	 * switchPortInfo.setIfInErrorsScale(0d);//inerrorsscale:输入差错率
	 * switchPortInfo.setIfTypeStr("");//iftypestr:端口类型
	 * switchPortInfo.setOutpktsspeed(0d);//发包速率
	 * switchPortInfo.setIfOutErrorsScale(0d);//输出差错率
	 * switchPortInfo.setIfOutOctetsSpeed(0d);//输出速度
	 * switchPortInfo.setInpktsspeed(0d);//收包速率
	 * switchPortInfo.setIfoutdiscardsperc(0d);//输出丢包率
	 * switchPortInfo.setIfindiscardsperc(0d);//输入丢包率
	 * switchPortInfo.setIfPhysAddress("");
	 * switchPortInfo.setIfSpeedStr(null);//端口的每秒比特数：带宽
	 * switchPortInfo.setIfLastChangeStr("");//在端口进入当前运作状态时，系统的sysUpTime 的评估
	 * switchPortInfo.setIfOperStatus(-1);//端口的运行状态
	 * switchPortInfo.setIfAdminStatus(-1);//端口的运行状态
	 * 
	 * switchPortInfo.setIfindiscardsVary(0l);//输入丢包数
	 * switchPortInfo.setIfoutdiscardsVary(0l);//输出丢包数
	 * switchPortInfo.setIfinerrorsVary(0l);//输入差错数
	 * switchPortInfo.setIfouterrorsVary(0l);//输出差错数 }else
	 * if(StringUtils.isNotBlank(seqId)&&StringUtils.isNotBlank(nameFlag)
	 * &&StringUtils.isNotBlank(detailTabName)&&checkTimeDigital!=null) { //
	 * String tableName = "di_switchport"; String sql = " select ds.ifdescr,"
	 * +//0 " ds.inoctetsspeed," +//1 " ds.inerrorsscale," +//2 " ds.iftype,"
	 * +//3 " ds.outpktsspeed," +//4 " ds.outerrorsscale," +//5 "
	 * ds.outoctetsspeed," +//6 " ds.inpktsspeed," +//7 " ds.ifoutdiscardsperc,"
	 * +//8 " ds.ifindiscardsperc," +//9 " ds.ifphysaddress," +//10 "
	 * ds.ifspeed," +//11从数据库取出的数据带宽单位 为：bps " ds.iflastchange," +//12 "
	 * ds.ifoperstatus," +//13 " ds.ifadminstatus," +//14 "
	 * ds.ifindiscards_vary," +//15输入丢包数 " ds.ifoutdiscards_vary," +//16输出丢包数 "
	 * ds.ifinerrors_vary," +//17输入差错数 " ds.ifouterrors_vary," +//18输出差错数 "
	 * ds.IFHIGHSPEED " + //19 从数据库取出的数据带宽单位 为：Mbps，优先考虑Mbps " from
	 * "+detailTabName+" ds" + " where ds.Data_Check_Time_Digital ="
	 * +checkTimeDigital+ " and ds.ifdescr='"+nameFlag+"'" + " and
	 * ds.seq_id="+seqId;
	 * 
	 * logger.info("查询端口详细信息sql："+sql);
	 * 
	 * List<Object[]> dateList = commonService.executeSQL(sql); if
	 * (dateList!=null && dateList.size()>0) { Object[] objs = dateList.get(0);
	 * 
	 * //输出速度和输入速度：大于等于1000000，的除以1000000，转换为MBps，小于1000000的直接显示 BigDecimal
	 * bFromB = new BigDecimal(8);
	 * 
	 * BigDecimal ifInOctetsSpeedTmp =
	 * objs[1]==null?null:((BigDecimal)objs[1]).multiply(bFromB).setScale(0,
	 * BigDecimal.ROUND_UP); BigDecimal ifOutOctetsSpeedTmp =
	 * objs[6]==null?null:((BigDecimal)objs[6]).multiply(bFromB).setScale(0,
	 * BigDecimal.ROUND_UP);
	 * switchPortInfo.setIfInOctetsSpeed(ifInOctetsSpeedTmp==null?0d:
	 * ifInOctetsSpeedTmp.doubleValue());//inoctetsspeed:输入速率
	 * switchPortInfo.setIfOutOctetsSpeed(ifOutOctetsSpeedTmp==null?0d:
	 * ifOutOctetsSpeedTmp.doubleValue());//输出速度
	 * 
	 * switchPortInfo.setIfDescr(objs[0]==null?null:(String)objs[0]);//ifdescr:
	 * 接口描述
	 * switchPortInfo.setIfInErrorsScale(objs[2]==null?0d:((BigDecimal)objs[2]).
	 * setScale(0, BigDecimal.ROUND_UP).doubleValue());//inerrorsscale:输入差错率
	 * switchPortInfo.setIfTypeStr(objs[3]==null?null:((BigDecimal)objs[3])+"");
	 * //iftype:端口类型
	 * switchPortInfo.setOutpktsspeed(objs[4]==null?0d:((BigDecimal)objs[4]).
	 * setScale(0, BigDecimal.ROUND_UP).doubleValue());//发包速率
	 * switchPortInfo.setIfOutErrorsScale(objs[5]==null?0d:((BigDecimal)objs[5])
	 * .setScale(0, BigDecimal.ROUND_UP).doubleValue());//输出差错率
	 * switchPortInfo.setInpktsspeed(objs[7]==null?0d:((BigDecimal)objs[7]).
	 * setScale(0, BigDecimal.ROUND_UP).doubleValue());//收包速率
	 * switchPortInfo.setIfoutdiscardsperc(objs[8]==null?0d:((BigDecimal)objs[8]
	 * ).setScale(0, BigDecimal.ROUND_UP).doubleValue());//输出丢包率
	 * switchPortInfo.setIfindiscardsperc(objs[9]==null?0d:((BigDecimal)objs[9])
	 * .setScale(0, BigDecimal.ROUND_UP).doubleValue());//输入丢包率
	 * switchPortInfo.setIfPhysAddress(objs[10]==null?null:(String)objs[10]); //
	 * switchPortInfo.setIfSpeedStr(objs[11]==null?null:(((BigDecimal)objs[11]).
	 * longValue()/(base*base)*8)+"");//端口的每秒比特数：带宽
	 * switchPortInfo.setIfSpeed(objs[11]==null?null:(((BigDecimal)objs[11]).
	 * longValue()));//端口的每秒比特数：带宽 //
	 * switchPortInfo.setIfSpeedStr(objs[11]==null?null:(((BigDecimal)objs[11]).
	 * longValue()/(base*base))+"");//端口的每秒比特数：带宽
	 * switchPortInfo.setIfLastChangeStr(objs[12]==null?null:(String)objs[12]);/
	 * /在端口进入当前运作状态时，系统的sysUpTime 的评估
	 * switchPortInfo.setIfOperStatus(objs[13]==null?null:((BigDecimal)objs[13])
	 * .intValue());//端口的运行状态
	 * switchPortInfo.setIfAdminStatus(objs[14]==null?null:((BigDecimal)objs[14]
	 * ).intValue());//端口的运行状态
	 * 
	 * switchPortInfo.setIfindiscardsVary(objs[15]==null?0l:((BigDecimal)objs[15
	 * ]).longValue());//输入丢包数
	 * switchPortInfo.setIfoutdiscardsVary(objs[16]==null?0l:((BigDecimal)objs[
	 * 16]).longValue());//输出丢包数
	 * switchPortInfo.setIfinerrorsVary(objs[17]==null?0l:((BigDecimal)objs[17])
	 * .longValue());//输入差错数
	 * switchPortInfo.setIfouterrorsVary(objs[18]==null?0l:((BigDecimal)objs[18]
	 * ).longValue());//输出差错数
	 * switchPortInfo.setIfHighSpeed(objs[19]==null?null:(((BigDecimal)objs[19])
	 * .longValue()));//端口的每秒比特数：带宽
	 * 
	 * }else { // switchPortInfo = null;
	 * switchPortInfo.setIfDescr(nameFlag);//ifdescr:接口描述
	 * switchPortInfo.setIfInOctetsSpeed(0d);//inoctetsspeed:输入速率
	 * switchPortInfo.setIfInErrorsScale(0d);//inerrorsscale:输入差错率
	 * switchPortInfo.setIfTypeStr("");//iftypestr:端口类型
	 * switchPortInfo.setOutpktsspeed(0d);//发包速率
	 * switchPortInfo.setIfOutErrorsScale(0d);//输出差错率
	 * switchPortInfo.setIfOutOctetsSpeed(0d);//输出速度
	 * switchPortInfo.setInpktsspeed(0d);//收包速率
	 * switchPortInfo.setIfoutdiscardsperc(0d);//输出丢包率
	 * switchPortInfo.setIfindiscardsperc(0d);//输入丢包率
	 * switchPortInfo.setIfPhysAddress("");
	 * switchPortInfo.setIfSpeedStr(null);//端口的每秒比特数：带宽
	 * switchPortInfo.setIfLastChangeStr("");//在端口进入当前运作状态时，系统的sysUpTime 的评估
	 * switchPortInfo.setIfOperStatus(-1);//端口的运行状态
	 * switchPortInfo.setIfAdminStatus(-1);//端口的运行状态
	 * 
	 * switchPortInfo.setIfindiscardsVary(0l);//输入丢包数
	 * switchPortInfo.setIfoutdiscardsVary(0l);//输出丢包数
	 * switchPortInfo.setIfinerrorsVary(0l);//输入差错数
	 * switchPortInfo.setIfouterrorsVary(0l);//输出差错数 } } } catch (Exception e) {
	 * logger.error("查询端口详细信息 异常",e); } }
	 */

	// 根据seqId和监测设置id，从detection_info_new表中查询最新监测时间（数字表示）、detection_info中对应的信息在哪个表分区
	private Map<String, String> getTabPartAndCheckTime(String seqId, String detectId) {
		Map<String, String> map = new HashMap<String, String>();
		String timeSql = "select max(tNew.Data_Check_Time_Digital)," + " to_char(max(tNew.Data_Check_Time),'YYYY') ,"
				+ " to_char(max(tNew.Data_Check_Time),'iw') " + " from detection_info_new tNew" + " where tNew.Seq_Id="
				+ seqId + " and tNew.Detection_Set_Info_Id =" + detectId;
		// System.out.println("查询最新分区sql："+timeSql);
		List<Object[]> timeList;
		try {
			timeList = commonService.executeSQL(timeSql);
			if (timeList != null && timeList.size() > 0) {
				Object[] time = timeList.get(0);
				String checkTimeDigital = time[0] == null ? "" : time[0].toString();
				String year = time[1] == null ? null : time[1].toString();
				String week = time[2] == null ? null : time[2].toString();

				if (year != null && week != null) {
					// map.put("partitionName", "DI_W"+year+week);
					map.put("partitionName", "DI_" + year + "W" + week);
				}
				map.put("checkTimeDigital", checkTimeDigital);
			}
		} catch (Exception e) {
			logger.error("According to seqid and monitoring settions ID,get the partition exception of detection_info table", e);
		}
		return map;
	}

	/**
	 * 2013-6-9 hyx detailTabName：详细监测信息表名
	 * checkTimeDigital：最新监测信息时间（从详细监测信息表中获得）
	 * list：nodeFigureInfo列表（不包括人工设置为down的端口）
	 * 
	 * port_set_statue、ifadminstatus、ifoperstatus： 1:up 2:down detection_state：
	 * 1:正常，0：异常（流量为0、port_set_statue为up时，ifadminstatus、ifoperstatus有一个为down、监测数据达到设置告警值）
	 * 
	 * port_oper_status：1：up，2：down:取哪个状态？？port_set_statue？or
	 * ifadminstatus--------------？
	 * port_oper_status=1（up）：port_status=0（不正常，但是数据异常），port_state=1（正常）-----？
	 * 
	 * port_set_statue : ifadminstatus : ifoperstatus : detection_state up：
	 * 1-1-1.png:绿色:正常 1-1-0.png:红色:异常(数据，端口状态) down： 2:人工设置为down：无图 or
	 * 灰色-------？ 超时：无图
	 * 
	 * 
	 */
	private void updateNodeFigureInfo(String detailTabName, Long checkTimeDigital, String indexFiled, Long checkGap,
			List<NodeFigureInfo> list) {
		try {
			// 超过两个周期，没有监测数据：系统状态：异常，监测时间：当前时间
			if (checkGap == null) {
				checkGap = defaultPortGap;
			}
			long period = (2 * checkGap + defaultDelay) * 60 * 1000;// 2个周期+5分钟
			long curTime = new Date().getTime();

			// 针对的是 所有端口 都超时2监测周期无监测信息的情况
			if (checkTimeDigital == null || (checkTimeDigital != null && (curTime - checkTimeDigital) > period)) {

				for (NodeFigureInfo node : list) {
					if (node.getDiTableName() != null && detailTabName.equalsIgnoreCase(node.getDiTableName())) {// 是否为端口设备，是：更新端口的信息：监测时间、端口状态、端口显示图片
						node.setDataCheckTimeDigital(curTime);
						node.setPortOperStatus(-1l);
						node.setPortStatus(-1l);
						node.setFigureFill("");
					}
				}

				logger.info(
						(curTime - checkTimeDigital) + "操作记录：tableName=" + detailTabName + ",信息全部超时，未接收到监测信息" + period);

				// 最新监测时间
				dataCheckTime = DateUtil.longToDate(curTime, "yyyy-MM-dd HH:mm:ss");
				logger.info("操作记录：查询网元设备最新监测时间为：" + dataCheckTime + "操作记录：网元设备最新监测时间为："
						+ DateUtil.longToDate(checkTimeDigital, "yyyy-MM-dd HH:mm:ss"));

			} else if (StringUtils.isNotBlank(seqId) && StringUtils.isNotBlank(detailTabName)
					&& checkTimeDigital != null) {
				// 最新监测时间
				dataCheckTime = DateUtil.longToDate(checkTimeDigital, "yyyy-MM-dd HH:mm:ss");

				String sql = " SELECT  NFI.ID, " + " TMP.DATA_CHECK_TIME_DIGITAL," + "            TMP.IFADMINSTATUS, "
						+ "            TMP.IFOPERSTATUS," + "            TMP.DETECTIONED_STATE, "
						+ "            NFI.FIGURE_FILL," + "            NFI.FIGURE_FILL_MODEL, "
						+ "            TMP.IFDESCR," + "            NFI.NAME_FLAG," + "            NFI.PORT_SET_STATE"
						+ " FROM NODE_FIGURE_INFO NFI" + " LEFT JOIN (" + "         SELECT DS.DATA_CHECK_TIME_DIGITAL,"
						+ "                DS.DETECTIONED_STATE," + indexFiled + " as IFDESCR,"
						+ "                DS.IFADMINSTATUS," + "                DS.IFOPERSTATUS" + "         FROM "
						+ detailTabName + " DS" + "         WHERE DS.SEQ_ID=" + seqId
						// + " AND DS.DATA_CHECK_TIME_DIGITAL=" +
						// checkTimeDigital
						+ "               AND DS.DATA_CHECK_TIME=TO_DATE('" + dataCheckTime
						+ "','yyyy-MM-dd HH24:mi:ss')" + " ) TMP" + " ON  NFI.NAME_FLAG=TMP.IFDESCR||''"
						+ " LEFT JOIN DEVICE_TYPE_INFO DTI" + " ON NFI.DEVICE_TYPE_CODE=DTI.DEVICE_TYPE_CODE"
						+ " WHERE (NFI.PORT_SET_STATE IS NULL OR NFI.PORT_SET_STATE=1)"// 只关注人工设置为up的端口
						+ "       AND DI_TABLE_NAME='" + detailTabName + "'"// 有没有表名，代表有没有监测信息
						+ "       AND NFI.SEQID=" + seqId;// 需要更新状态的：如果已经是最新的则不需要更新表,如果没有监测时间的也需要更新

				logger.info("操作记录：查询节点的图形配置相关监测信息sql：" + sql);

				logger.info("操作记录：查询网元设备最新监测时间为：" + dataCheckTime);

				List<Object[]> dateList = commonService.executeSQL(sql);
				if (dateList != null && dateList.size() > 0) {
					Map<String, Object[]> idUpdateInfoMap = new HashMap<String, Object[]>();// id:需要更新的信息

					int len = dateList.size();

					String portOperStatus = "2";// 操作的状态:默认down
					String portStatus = "1";// 实际的状态：默认正常
					for (int i = 0; i < len; i++) {
						Object[] objects = dateList.get(i);
						String id = objects[0] == null ? "" : objects[0].toString();
						Long dataCheckTimeDigital = objects[1] == null ? null : Long.parseLong(objects[1].toString());
						String ifadminstatus = objects[2] == null ? "" : objects[2].toString();
						// String ifoperstatus = objects[3] == null ? "" :
						// objects[3].toString();
						String detectionedstate = objects[4] == null ? "" : objects[4].toString();
						String figureFill = "";
						String figureFillModel = objects[6] == null ? "" : objects[6].toString();
						String ifDescr = objects[7] == null ? "" : objects[7].toString();
						String nameFlag = objects[8] == null ? "" : objects[8].toString();
						// String portSetState = objects[9] == null ? "" :
						// objects[9].toString();
						if (StringUtils.isNotBlank(ifDescr)) {
							portOperStatus = ifadminstatus;
							portStatus = detectionedstate;
							// if ("1".equals(portSetState)){
							if (StringUtils.isNotBlank(figureFillModel) && figureFillModel.endsWith(".png")) {
								// if("-1".equals(detectionedstate)) {//-1：无详细信息
								// detectionedstate = "0";//0:有详细信息，但是信息有误
								// }
								figureFill = figureFillModel.substring(0, figureFillModel.length() - 4) + "-1-1-"
										+ detectionedstate + ".png";
								logger.debug(ifDescr + "******************figureFillModel:" + figureFillModel
										+ "*******************nameFlag:" + nameFlag + "******************figureFill:"
										+ figureFill);

							}
							// } else if ("2".equals(portSetState)) {
							// if (StringUtils.isNotBlank(figureFillModel)
							// && figureFillModel.endsWith(".png")) {
							// figureFill = figureFillModel.substring(0,
							// figureFillModel.length() - 4)+
							// "-2.png";
							// }
							// }

							Object[] updateInfo = new Object[4];
							updateInfo[0] = dataCheckTimeDigital;
							updateInfo[1] = portOperStatus;
							updateInfo[2] = portStatus;
							updateInfo[3] = figureFill;

							idUpdateInfoMap.put(id, updateInfo);

						} else {// 如果有节点（最大的监测时间）的监测信息正确，则其它不正确节点的最新监测时间按最大监测时间来
							/*
							 * 由于每到一个监测周期的时候，信息会一条一条的录入，端口有较多时，如果在录入了一部分后进行查询，
							 * 系统的端口信息并没有超时无监测信息，而是有些延迟,虽然延迟了，但是监测信息的时间是一样的，
							 * arriveTime也是一样的，只不过arriveTime可能会比监测时间晚一些
							 */
							// logger.info("操作记录：nameFlag=" + nameFlag
							// + ",监测时间正常，但ifDescr为空，因此无图片：超过 2 监测周期，未接收到监测结果信息
							// ，");
							Object[] updateInfo = new Object[4];
							updateInfo[0] = checkTimeDigital;
							updateInfo[1] = -1l;
							updateInfo[2] = -1l;
							updateInfo[3] = "";

							idUpdateInfoMap.put(id, updateInfo);
						}

					}

					for (NodeFigureInfo node : list) {
						Object[] updateInfoTmp = idUpdateInfoMap.get(node.getId() + "");
						if (node.getDiTableName() != null && detailTabName.equalsIgnoreCase(node.getDiTableName())
								&& updateInfoTmp != null) {// 是否为端口设备，是：更新端口的信息：监测时间、端口状态、端口显示图片
							node.setDataCheckTimeDigital(Long.parseLong(updateInfoTmp[0] + ""));
							node.setPortOperStatus(Long.parseLong(updateInfoTmp[1] + ""));
							node.setPortStatus(Long.parseLong(updateInfoTmp[2] + ""));
							node.setFigureFill(updateInfoTmp[3] + "");
						}
					}
				}
			}
		} catch (Exception e) {
			logger.error("Update the device status information,monitoring time(digital representation) and abnormal picture displayed in the node_figure_info table", e);
		}
	}

	private void updateNodeFigureInfo(String detailTabName, Long checkTimeDigital, String indexFiled,
			String statusFiled, String statusSymbols, String statusValue, Long checkGap, List<NodeFigureInfo> list) {
		try {
			// 超过两个周期，没有监测数据：系统状态：异常，监测时间：当前时间 or 从表detection_info取，端口显示灰色
			if (checkGap == null) {
				checkGap = defaultOtherGap;
			}
			long period = (2 * checkGap + defaultDelay) * 60 * 1000;// 2个周期+5分钟（入库延迟时间）
			long curTime = new Date().getTime();
			// 针对的是 所有 都超时2监测周期无监测信息的情况
			if (checkTimeDigital == null || (checkTimeDigital != null && (curTime - checkTimeDigital) > period)) {
				for (NodeFigureInfo node : list) {
					if (node.getDiTableName() != null && detailTabName.equalsIgnoreCase(node.getDiTableName())) {// 是否为端口设备，是：更新端口的信息：监测时间、端口状态、端口显示图片
						node.setDataCheckTimeDigital(curTime);
						node.setFigureFill("");
					}
				}

				logger.info("操作记录：tableName=" + detailTabName + ",信息全部超时，未接收到监测信息");

			} else if (StringUtils.isNotBlank(seqId) && StringUtils.isNotBlank(detailTabName)
					&& checkTimeDigital != null) {

				String sql = " SELECT NFI.ID," + "           TMP.DATA_CHECK_TIME_DIGITAL," + "           TMP."
						+ statusFiled + "," + "           NFI.FIGURE_FILL_MODEL," + "           TMP." + indexFiled
						+ " FROM NODE_FIGURE_INFO NFI" + " LEFT JOIN (" + "       SELECT DS.DATA_CHECK_TIME_DIGITAL,"
						+ "              DS.DETECTIONED_STATE," + indexFiled + "," + statusFiled + "       FROM  "
						+ detailTabName + " DS" + "       WHERE DS.SEQ_ID=" + seqId
						+ "             AND DS.DATA_CHECK_TIME_DIGITAL=" + checkTimeDigital + " )TMP"
						+ " ON  NFI.NAME_FLAG=TMP." + indexFiled + "||''" + " LEFT JOIN DEVICE_TYPE_INFO DTI"
						+ " ON NFI.DEVICE_TYPE_CODE=DTI.DEVICE_TYPE_CODE" + " WHERE NFI.SEQID=" + seqId + // 需要更新状态的：如果已经是最新的则不需要更新表,如果没有监测时间的也需要更新
						"         AND DI_TABLE_NAME='" + detailTabName + "'";// 叶子设备可通过是否有监测信息表来判断

				logger.info("操作记录：查询节点的图形配置相关监测信息sql：" + sql);

				List<Object[]> dateList = commonService.executeSQL(sql);
				if (dateList != null && dateList.size() > 0) {
					Map<String, Object[]> idUpdateInfoMap = new HashMap<String, Object[]>();// id:需要更新的信息
					int len = dateList.size();
					for (int i = 0; i < len; i++) {
						Object[] objects = dateList.get(i);
						String id = objects[0] == null ? "" : objects[0].toString();
						Long dataCheckTimeDigital = objects[1] == null ? null : Long.parseLong(objects[1].toString());
						String status = objects[2] == null ? "" : objects[2].toString();
						String figureFillModel = objects[3] == null ? "" : objects[3].toString();
						String indexField = objects[4] == null ? "" : objects[4].toString();
						String figureFill = "";

						if (StringUtils.isNotBlank(indexField)) {
							if (StringUtils.isNotBlank(figureFillModel) && figureFillModel.endsWith(".png")
									&& !"offline".equalsIgnoreCase(status)) {
								figureFill = figureFillModel.substring(0, figureFillModel.length() - 4) + "-" + status
										+ ".png";
							}

							Object[] updateInfo = new Object[2];
							updateInfo[0] = dataCheckTimeDigital;
							updateInfo[1] = figureFill;

							idUpdateInfoMap.put(id, updateInfo);

						} else {
							// logger.info("操作记录：indexFiled=" + indexField
							// + ",监测时间正常，但indexField为空，因此无图片：超过 2
							// 监测周期，未接收到监测结果信息 ，");
							Object[] updateInfo = new Object[2];
							updateInfo[0] = checkTimeDigital;
							updateInfo[1] = "";

							idUpdateInfoMap.put(id, updateInfo);
						}
					}

					for (NodeFigureInfo node : list) {
						Object[] updateInfoTmp = idUpdateInfoMap.get(node.getId() + "");
						if (node.getDiTableName() != null && detailTabName.equalsIgnoreCase(node.getDiTableName())
								&& updateInfoTmp != null) {// 是否为对应设备，是：更新信息：监测时间、端口显示图片
							node.setDataCheckTimeDigital(Long.parseLong(updateInfoTmp[0] + ""));
							node.setFigureFill(updateInfoTmp[1] + "");
						}
					}
				}
			}

		} catch (Exception e) {
			logger.error("Update the device status information,monitoring time(digital representation) and abnormal picture displayed in the node_figure_info table", e);
		}
	}

	// /**-------------备用
	// * 更新node_figure_info表中的设备状态信息、监测时间（数字表示）及显示的图片，并返回最新监测时间的数字表示
	// *
	// * sql思路： （1）根据seqId从di_switchport查询出 当前节点的最新监测时间
	// * （2）根据seqId、最新监测时间，从di_switchport表查询
	// * 当前节点最新的所有端口的信息（当前节点设置的所有的端口的状态（操作、实际、数据状态），根据这3个状态去判断每个端口的状态显示）
	// * （3）再将node_figure_info和以上查询的数据左连接，得到需要的数据（若未查询到状态的（非端口+端口无数据），使用默认图片）
	// * （4）条件：node_figure_info里的监测时间为null 或者 和detection_info表的监测时间不等
	// 根据sql查询出的数据:
	// * 循环：根据查询出的3个状态，更新node_figure_info表的2个状态和图片，并更新data_check_time_digital
	// *
	// * （1）DATA_CHECK_TIME_DIGITAL=最新时间（每次都查询，不一样则更新到最新时间）
	// * //-------------------------------------------------------
	// * IFADMINSTATUS：操作端口状态 2:down 1:up IFOPERSTATUS：端口实际的状态 2:down 1:up
	// * DETECTIONED_STATE：监测数据的状态 1:正常 0：不正常 推出-> PORT_OPER_STATUS: 2:down 1:up
	// * PORT_STATUS:（PORT_OPER_STATUS=up时才有） 1:正常 0：不正常
	// * //----------------------------------------------------------
	// *
	// * IFADMINSTATUS = down（2）: PORT_OPER_STATUS=2(down)：灰色，端口关闭
	// *
	// * IFADMINSTATUS = up（1），IFOPERSTATUS = down(2):
	// * PORT_OPER_STATUS=1（up），PORT_STATUS=0（不正常：down）：无图,表示端口实际为关闭的，表示端口未接线
	// *
	// * IFADMINSTATUS = up（1），IFOPERSTATUS = up(1),DETECTIONED_STATE=1（正常）:
	// * PORT_OPER_STATUS=1（up），PORT_STATUS=1（正常：up）：绿色（再根据数据是否有问题来判断是否为红色）
	// *
	// * IFADMINSTATUS = up（1），IFOPERSTATUS = up(1), DETECTIONED_STATE=0（不正常）:
	// * PORT_OPER_STATUS=1（up）、PORT_STATUS=0（不正常）:红色，端口up，但是数据异常
	// *
	// * 超过两个周期没有监测数据：
	// *
	// PORT_OPER_STATUS=1（up）、PORT_STATUS=0（不正常）:无图，端口up，但是数据异常，大图上放上文本提示信息：设备异常!
	// * 字体红色
	// *
	// *
	// *
	// *
	// checkTimeDigital:最大监测时间，如果最大监测时间都超过2周期，未接收到监测信息的话，那其他端口（最新监测时间小于最大监测时间的）必然也属于超时无监测信息
	// * 更新此节点的所有端口：
	// 情况1：最新时间没有对应端口的信息:就是ifdescr、data_check_time_digital为null或者空的，
	// * 情况2：没有此端口的任何信息：超周期，无信息
	// * 以上2种情况都更新所有端口：如果ifdescr不为null或者空，则按原来的处理，为空的，则按超时无监测信息处理
	// */
	// private void updateNodeFigureInfo(String detailTabName, Long
	// checkTimeDigital,
	// String indexFiled, Long checkGap)
	// {
	// try
	// {
	// // 超过两个周期，没有监测数据：系统状态：异常，监测时间：当前时间 or 从表detection_info取，端口显示灰色
	// if (checkGap == null)
	// {
	// checkGap = defaultPortGap + defaultDelay;
	// } else
	// {
	// checkGap = checkGap + defaultDelay;
	// }
	// long period = 2 * checkGap * 60 * 1000;// 2个周期
	// long curTime = new Date().getTime();
	// // 针对的是 所有端口 都超时2监测周期无监测信息的情况
	// if (checkTimeDigital == null
	// || (checkTimeDigital != null && (curTime - checkTimeDigital) > period))
	// {
	// sysStatusFlag = false;// 系统状态标识
	// if (!sysStatus.contains("超过 2 监测周期，未接收到监测结果信息 ，"))
	// {
	// sysStatus = sysStatus + "超过 2 监测周期，未接收到监测结果信息 ，";
	// }
	// String sql = " select nfi.id,nfi.figure_fill_model" + " from
	// node_figure_info
	// nfi"
	// + " left join device_type_info dti"
	// + " on nfi.device_type_code=dti.device_type_code" + " where nfi.seqId="
	// + seqId + // 需要更新状态的：如果已经是最新的则不需要更新表,如果没有监测时间的也需要更新
	// " and di_table_name='" + detailTabName + "'";// 有没有表名，代表有没有监测信息
	//
	// logger.info("操作记录：查询当前节点的图形设置相关信息sql：" + sql);
	// logger.info("操作记录：tableName=" + detailTabName + ",信息全部超时，未接收到监测信息");
	//
	// List<Object[]> dateList = commonService.executeSQL(sql);
	// if (dateList != null && dateList.size() > 0)
	// {
	// int len = dateList.size();
	// String updateSql = "update node_figure_info t set
	// DATA_CHECK_TIME_DIGITAL=?
	// ,PORT_OPER_STATUS=?,PORT_STATUS=? ,FIGURE_FILL=? where t.id=?";
	// List[] listArry = new ArrayList[5];
	// listArry[0] = new ArrayList();
	// listArry[1] = new ArrayList();
	// listArry[2] = new ArrayList();
	// listArry[3] = new ArrayList();
	// listArry[4] = new ArrayList();
	// for (int i = 0; i < len; i++)
	// {
	// Object[] objects = dateList.get(i);
	// String id = objects[0] == null ? "" : objects[0].toString();
	// // String figureFillModel = objects[1]==null?"":objects[1].toString();
	// // String figureFill =
	// //
	// figureFillModel.substring(0,figureFillModel.length()-4)+"-TIMEOUT.png";
	//
	// listArry[0].add(curTime);// 超时未接收到监测信息时，监测时间取当前时间
	// listArry[1].add(-1l);
	// listArry[2].add(-1l);
	// listArry[3].add("");
	// listArry[4].add(id);
	//
	// }
	// commonService.updateBatchBySql(updateSql, listArry);
	// }
	// } else if (StringUtils.isNotBlank(seqId) &&
	// StringUtils.isNotBlank(detailTabName)
	// && checkTimeDigital != null)
	// {
	// String sql = " select nfi.id," + " tmp.data_check_time_digital,"
	// + " tmp.ifadminstatus," + " tmp.ifoperstatus,"
	// + " tmp.detectioned_state," + " nfi.figure_fill,"
	// + " nfi.figure_fill_model," + " tmp.ifdescr,"
	// + " nfi.name_flag" + " from node_figure_info nfi"
	// + " left join ("
	// + " select ds.data_check_time_digital,ds.detectioned_state,"
	// + indexFiled + ",ds.ifadminstatus,ds.ifoperstatus" + " from "
	// + detailTabName + " ds" + " where ds.seq_id=" + seqId
	// + " and ds.data_check_time_digital=" + checkTimeDigital
	// + " )tmp" + " on nfi.name_flag=tmp." + indexFiled + "||''"
	// + " left join device_type_info dti"
	// + " on nfi.device_type_code=dti.device_type_code" + " where nfi.seqId="
	// + seqId + // 需要更新状态的：如果已经是最新的则不需要更新表,如果没有监测时间的也需要更新
	// " and di_table_name='" + detailTabName + "'";// 有没有表名，代表有没有监测信息
	// // " and (nfi.data_check_time_digital is null " +
	// // " or nfi.data_check_time_digital<>tmp.data_check_time_digital)";
	//
	// logger.info("操作记录：查询节点的图形配置相关监测信息sql：" + sql);
	//
	// List<Object[]> dateList = commonService.executeSQL(sql);
	// if (dateList != null && dateList.size() > 0)
	// {
	// int len = dateList.size();
	// String portOperStatus = "2";// 操作的状态:默认down
	// String portStatus = "1";// 实际的状态：默认正常
	// String updateSql = "update node_figure_info t set
	// DATA_CHECK_TIME_DIGITAL=?
	// ,PORT_OPER_STATUS=?,PORT_STATUS=? ,FIGURE_FILL=? where t.id=?";
	// List[] listArry = new ArrayList[5];
	// listArry[0] = new ArrayList();
	// listArry[1] = new ArrayList();
	// listArry[2] = new ArrayList();
	// listArry[3] = new ArrayList();
	// listArry[4] = new ArrayList();
	// for (int i = 0; i < len; i++)
	// {
	// Object[] objects = dateList.get(i);
	// String id = objects[0] == null ? "" : objects[0].toString();// 默认是空
	// Long dataCheckTimeDigital = objects[1] == null ? null : Long
	// .parseLong(objects[1].toString());// 默认是空
	// String ifadminstatus = objects[2] == null ? "" : objects[2].toString();//
	// 默认是空
	// String ifoperstatus = objects[3] == null ? "" : objects[3].toString();//
	// 默认是空
	// String detectionedstate = objects[4] == null ? "" :
	// objects[4].toString();//
	// 默认是空
	// String figureFill = "";// 默认是空
	// String figureFillModel = objects[6] == null ? "" :
	// objects[6].toString();//
	// 默认是空
	// String ifDescr = objects[7] == null ? "" : objects[7].toString();// 默认是空
	// String nameFlag = objects[8] == null ? "" : objects[8].toString();// 默认是空
	//
	// if (StringUtils.isNotBlank(ifDescr))
	// {
	// // IFADMINSTATUS = down（2）:
	// // PORT_OPER_STATUS=2(down)：灰色，端口关闭
	// //
	// // IFADMINSTATUS = up（1），IFOPERSTATUS = down(2):
	// // PORT_OPER_STATUS=1（up），PORT_STATUS=0（不正常：down）：无图,表示端口实际为关闭的，表示端口未接线
	// //
	// // IFADMINSTATUS = up（1），IFOPERSTATUS = up(1),DETECTIONED_STATE=1（正常）:
	// // PORT_OPER_STATUS=1（up），PORT_STATUS=1（正常：up）：绿色（再根据数据是否有问题来判断是否为红色）
	// //
	// // IFADMINSTATUS = up（1），IFOPERSTATUS = up(1), DETECTIONED_STATE=0（不正常）:
	// // PORT_OPER_STATUS=1（up）、PORT_STATUS=0（不正常）:红色，端口up，但是数据异常
	// //
	// // 超过两个周期没有监测数据：
	// //
	// PORT_OPER_STATUS=1（up）、PORT_STATUS=0（不正常）:无图，端口up，但是数据异常，大图上放上文本提示信息：设备异常!
	// // 字体红色
	//
	// // 1-1-1.png:绿色
	// // 1-1-0.png:红色
	//
	// // 2.png:灰色-端口关闭
	// // 1-2:无图-未接线-系统正常
	// // TIMEOUT:无图-超时无信息-系统异常
	// portOperStatus = ifadminstatus;
	//
	// if ("1".equals(ifadminstatus))
	// {
	// if (StringUtils.isNotBlank(figureFillModel)
	// && figureFillModel.endsWith(".png"))
	// {
	// figureFill = figureFillModel.substring(0, figureFillModel
	// .length() - 4)
	// + "-1";
	// }
	//
	// if ("2".equals(ifoperstatus))
	// {// 无图
	// portStatus = "0";
	// figureFill = "";
	// } else if ("1".equals(ifoperstatus) && "1".equals(detectionedstate))
	// {// 绿色1-1-1
	// portStatus = "1";
	// figureFill = figureFill + "-1-1";
	// } else if ("1".equals(ifoperstatus)
	// && !"1".equals(detectionedstate))
	// {// 红色1-1-0
	// portStatus = "0";
	// figureFill = figureFill + "-1-0";
	// }
	//
	// if (figureFill != null && !"".equals(figureFill)
	// && !figureFill.endsWith(".png"))
	// {
	// figureFill = figureFill + ".png";
	// }
	// } else if ("2".equals(ifadminstatus))
	// {
	// if (StringUtils.isNotBlank(figureFillModel)
	// && figureFillModel.endsWith(".png"))
	// {
	// figureFill = figureFillModel.substring(0, figureFillModel
	// .length() - 4)
	// + "-2.png";
	// }
	// }
	//
	// listArry[0].add(dataCheckTimeDigital);
	// listArry[1].add(portOperStatus);
	// listArry[2].add(portStatus);
	// listArry[3].add(figureFill);
	// listArry[4].add(id);
	// } else
	// {// 如果有节点（最大的监测时间）的监测信息正确，则其它不正确节点的最新监测时间按最大监测时间来
	// /*
	// * 由于每到一个监测周期的时候，信息会一条一条的录入，端口有126个，如果在录入了一部分后进行查询，
	// *
	// 系统的端口信息并没有超时无监测信息，而是有些延迟,虽然延迟了，但是监测信息的时间是一样的，arriveTime也是一样的，只不过arriveTime可能会比监测时间晚2分钟左右
	// */
	// logger.info("操作记录：nameFlag=" + nameFlag);
	// logger.info("操作记录：监测时间正常，但ifDescr为空，因此无图片：超过 2 监测周期，未接收到监测结果信息 ，");
	// sysStatusFlag = false;// 系统状态标识
	// if (!sysStatus.contains("超过 2 监测周期，未接收到监测结果信息 ，"))
	// {
	// sysStatus = sysStatus + "超过 2 监测周期，未接收到监测结果信息 ，";
	// }
	// // figureFill =
	// //
	// figureFillModel.substring(0,figureFillModel.length()-4)+"-TIMEOUT.png";
	// listArry[0].add(checkTimeDigital);
	// listArry[1].add(-1l);
	// listArry[2].add(-1l);
	// listArry[3].add("");
	// listArry[4].add(id);
	// }
	//
	// }
	//
	// commonService.updateBatchBySql(updateSql, listArry);
	// }
	//
	// }
	// } catch (Exception e)
	// {
	// logger.error("更新node_figure_info表中的设备状态信息、监测时间（数字表示）及显示的图片 异常", e);
	// }
	// }
	// -----------备用
	// private void updateNodeFigureInfo(String detailTabName, Long
	// checkTimeDigital,
	// String indexFiled, String statusFiled, String statusSymbols, String
	// statusValue,
	// Long checkGap)
	// {
	// try
	// {
	//
	// // 超过两个周期，没有监测数据：系统状态：异常，监测时间：当前时间 or 从表detection_info取，端口显示灰色
	// if (checkGap == null)
	// {
	// checkGap = defaultOtherGap + defaultDelay;
	// } else
	// {
	// checkGap = checkGap + defaultDelay;
	// }
	// long period = 2 * checkGap * 60 * 1000;// 2个周期
	// long curTime = new Date().getTime();
	// // 针对的是 所有 都超时2监测周期无监测信息的情况
	// if (checkTimeDigital == null
	// || (checkTimeDigital != null && (curTime - checkTimeDigital) > period))
	// {
	// sysStatusFlag = false;// 系统状态标识
	// if (!sysStatus.contains("超过 2 监测周期，未接收到监测结果信息 ，"))
	// {
	// sysStatus = sysStatus + "超过 2 监测周期，未接收到监测结果信息 ，";
	// }
	// String sql = " select nfi.id,nfi.figure_fill_model" + " from
	// node_figure_info
	// nfi"
	// + " left join device_type_info dti"
	// + " on nfi.device_type_code=dti.device_type_code" + " where nfi.seqId="
	// + seqId + // 需要更新状态的：如果已经是最新的则不需要更新表,如果没有监测时间的也需要更新
	// " and di_table_name='" + detailTabName + "'";// 有没有表名，代表有没有监测信息
	//
	// logger.info("操作记录：查询当前节点的图形设置相关信息sql：" + sql);
	// logger.info("操作记录：tableName=" + detailTabName + ",信息全部超时，未接收到监测信息");
	//
	// List<Object[]> dateList = commonService.executeSQL(sql);
	// if (dateList != null && dateList.size() > 0)
	// {
	// int len = dateList.size();
	// String updateSql = "update node_figure_info t set
	// DATA_CHECK_TIME_DIGITAL=?
	// ,FIGURE_FILL=? where t.id=?";
	// List[] listArry = new ArrayList[3];
	// listArry[0] = new ArrayList();
	// listArry[1] = new ArrayList();
	// listArry[2] = new ArrayList();
	// for (int i = 0; i < len; i++)
	// {
	// Object[] objects = dateList.get(i);
	// String id = objects[0] == null ? "" : objects[0].toString();
	// // String figureFillModel = objects[1]==null?"":objects[1].toString();
	// // String figureFill =
	// //
	// figureFillModel.substring(0,figureFillModel.length()-4)+"-TIMEOUT.png";
	//
	// listArry[0].add(curTime);// 超时未接收到监测信息时，监测时间取当前时间
	// listArry[1].add("");
	// listArry[2].add(id);
	// }
	// commonService.updateBatchBySql(updateSql, listArry);
	// }
	// } else if (StringUtils.isNotBlank(seqId) &&
	// StringUtils.isNotBlank(detailTabName)
	// && checkTimeDigital != null)
	// {
	//
	// String sql = " select nfi.id," + " tmp.data_check_time_digital,"
	// + " tmp."
	// + statusFiled
	// + ","
	// + " nfi.figure_fill_model,"
	// + " tmp."
	// + indexFiled
	// + " from node_figure_info nfi"
	// + " left join ("
	// + " select ds.data_check_time_digital,ds.detectioned_state,"
	// + indexFiled
	// + ","
	// + statusFiled
	// + " from "
	// + detailTabName
	// + " ds"
	// + " where ds.seq_id="
	// + seqId
	// + " and ds.data_check_time_digital="
	// + checkTimeDigital
	// + " )tmp"
	// + " on nfi.name_flag=tmp."
	// + indexFiled
	// + "||''"
	// + " left join device_type_info dti"
	// + " on nfi.device_type_code=dti.device_type_code"
	// + " where nfi.seqId="
	// + seqId + // 需要更新状态的：如果已经是最新的则不需要更新表,如果没有监测时间的也需要更新
	// " and di_table_name='" + detailTabName + "'";// 叶子设备可通过是否有监测信息表来判断
	// // " and nfi.is_leaf=1" + //isLeaf用来判断是否加链接？
	// // " and (nfi.data_check_time_digital is null " +
	// // " or nfi.data_check_time_digital<>tmp.data_check_time_digital)";
	//
	// logger.info("操作记录：查询节点的图形配置相关监测信息sql：" + sql);
	//
	// List<Object[]> dateList = commonService.executeSQL(sql);
	// if (dateList != null && dateList.size() > 0)
	// {
	// int len = dateList.size();
	// String updateSql = "update node_figure_info t set
	// DATA_CHECK_TIME_DIGITAL=?
	// ,FIGURE_FILL=? where t.id=?";
	// List[] listArry = new ArrayList[3];
	// listArry[0] = new ArrayList();
	// listArry[1] = new ArrayList();
	// listArry[2] = new ArrayList();
	// for (int i = 0; i < len; i++)
	// {
	// Object[] objects = dateList.get(i);
	// String id = objects[0] == null ? "" : objects[0].toString();// 默认是空
	// Long dataCheckTimeDigital = objects[1] == null ? null : Long
	// .parseLong(objects[1].toString());// 默认是空
	// String status = objects[2] == null ? "" : objects[2].toString();// 默认是空
	// String figureFillModel = objects[3] == null ? "" :
	// objects[3].toString();//
	// 默认是空
	// String indexField = objects[4] == null ? "" : objects[4].toString();//
	// 默认是空
	// String figureFill = "";// 默认是空
	//
	// if (StringUtils.isNotBlank(indexField))
	// {
	// if (StringUtils.isNotBlank(figureFillModel)
	// && figureFillModel.endsWith(".png")
	// && !"offline".equalsIgnoreCase(status))
	// {
	// figureFill = figureFillModel.substring(0,
	// figureFillModel.length() - 4)
	// + "-" + status + ".png";
	// }
	//
	// listArry[0].add(dataCheckTimeDigital);
	// listArry[1].add(figureFill);
	// listArry[2].add(id);
	// } else
	// {
	// logger.info("操作记录：indexFiled=" + indexField);
	// logger.info("操作记录：监测时间正常，但indexField为空，因此无图片：超过 2 监测周期，未接收到监测结果信息 ，");
	// sysStatusFlag = false;// 系统状态标识
	// if (!sysStatus.contains("超过 2 监测周期，未接收到监测结果信息 ，"))
	// {
	// sysStatus = sysStatus + "超过 2 监测周期，未接收到监测结果信息 ，";
	// }
	// // figureFill =
	// //
	// figureFillModel.substring(0,figureFillModel.length()-4)+"-TIMEOUT.png";
	//
	// listArry[0].add(checkTimeDigital);//
	// 超时未接收到监测信息时，监测时间取所有端口的最大监测时间（因为每次应该获取所有端口的信息，如果有一些端口没有获取，说明异常了）
	// listArry[1].add("");
	// listArry[2].add(id);
	// }
	// }
	//
	// commonService.updateBatchBySql(updateSql, listArry);
	// }
	// }
	//
	// } catch (Exception e)
	// {
	// logger.error("更新node_figure_info表中的设备状态信息、监测时间（数字表示）及显示的图片 异常", e);
	// }
	// }
	//
	// 通过监测设置id获取监测信息存放的表名
	private String getTabNameByDetecSetId(String detecSetId) {
		String tabName = "";
		if (StringUtils.isNotBlank(detecSetId)) {
			String tabNameSql = " select cti.table_name" + " from check_type_info cti" + " where cti.id = ("
					+ "        select dsi.check_type_id " + "        from detection_set_info dsi "
					+ "        where dsi.id = " + detecSetId + ")";
			List<Object[]> setTableNameList;
			try {
				setTableNameList = commonService.executeSQL(tabNameSql);
				if (setTableNameList != null && setTableNameList.size() > 0) {
					Object obj = setTableNameList.get(0);
					tabName = obj == null ? null : obj.toString();
				}
			} catch (Exception e) {
				logger.error("Get the table name exception by monitoring ID settings", e);
			}

		}

		return tabName;
	}

	/**
	 * 通过seqId和设置id，查询detection_info_new表对应该IP的该设置的最新监测信息时间
	 * 
	 * @param seqId
	 * @param detectionSetId
	 * @return
	 */
	//
	private Long getLatestDetectTimeDigitalBySeqId(String detailTabName, String seqId) {
		Long checkTimeDigital = 0l;
		if (StringUtils.isNotBlank(detailTabName) && StringUtils.isNotBlank(seqId)) {
			StringBuffer sqlBuffer = new StringBuffer();
			sqlBuffer.append(" select TO_CHAR(MAXCHECKTIME, 'yyyy-MM-dd HH24:mi:ss') from ( ");
			sqlBuffer.append(" SELECT MAX(din.data_check_time)  MAXCHECKTIME from DETECTION_INFO_NEW din");
			// sqlBuffer.append(" where din.seq_id = ?");
			// sqlBuffer.append(" and din.detection_set_info_id = ?");
			sqlBuffer.append(" where din.detection_set_info_id in(");
			sqlBuffer.append(
					"select dsi.id from DETECTION_SET_INFO dsi where dsi.check_type_id in(select cti.id from check_type_info cti where cti.table_name=? and cti.crete_state=0)");
			sqlBuffer.append(") and din.seq_id = ?");
			sqlBuffer.append(") ttttt");
			try {
				List<Object[]> setTableNameList = commonService.executeSQL(sqlBuffer.toString(),
						new String[] { detailTabName, seqId });

				logger.info("getLatestDetectTimeDigitalBySeqId获取最新监测sql：" + sqlBuffer.toString());
				if (setTableNameList != null && setTableNameList.size() > 0) {
					Object obj = setTableNameList.get(0);
					Date checkTimeDate = obj == null ? null : DateUtil.format.parse(obj.toString());
					checkTimeDigital = checkTimeDate == null ? null : checkTimeDate.getTime();
				}
			} catch (Exception e) {
				logger.error("Query the latest monitoring information time exception of seqId through seqId and table name", e);
			}
		}

		return checkTimeDigital;
	}

	/**
	 * 根据seqID获取设置获取监测数据间隔
	 * 通过seqId和表名，查询seqId的当前监测的设置的监测时间间隔（因为一个节点，同一种监测设置，可能设置多个，此时，我们取监测信息最新的监测设置的间隔时间）
	 * 
	 * @param detailTabName
	 * @param seqId
	 * @return
	 */
	private Long getLatestCheckGapBySeqId(String detailTabName, String seqId) {
		// Long checkGap = null;
		Long checkGap = 0l;
		if (StringUtils.isNotBlank(detailTabName) && StringUtils.isNotBlank(seqId)) {
			StringBuffer sqlBuffer = new StringBuffer();
			sqlBuffer.append(" SELECT DSI.CHECK_GAP FROM DETECTION_SET_INFO DSI WHERE DSI.ID in ( ");
			sqlBuffer.append(" select distinct detection_set_info_id from ");
			sqlBuffer.append(detailTabName);
			sqlBuffer.append(" where data_check_time=(select  max(dw.data_check_time) from ");
			sqlBuffer.append(detailTabName);
			sqlBuffer.append(" dw where dw.detection_set_info_id in( ");
			sqlBuffer.append(" select dsi.id from DETECTION_SET_INFO dsi where dsi.check_type_id in( ");
			sqlBuffer.append(
					" select cti.id from check_type_info cti where cti.table_name = ? and cti.crete_state = 0 ");
			sqlBuffer.append(" )");
			sqlBuffer.append(" ) and dw.seq_id =? and dw.data_check_time > sysdate - 1");
			sqlBuffer.append(" ) ");
			sqlBuffer.append(" )");
			try {
				List<Object[]> detectSetList = commonService.executeSQL(sqlBuffer.toString(),
						new String[] { detailTabName, seqId });
				logger.info("getLatestCheckGapBySeqId获取分区sql获取最新监测sql：" + sqlBuffer.toString());
				if (detectSetList != null && detectSetList.size() > 0) {
					Object obj = detectSetList.get(0);
					checkGap = obj == null ? null : Long.parseLong(obj.toString());
				} else {

				}
			} catch (Exception e) {
				logger.error("Through seqId and table name,query seqId's latest monitoring information monitoring interval exceptions", e);
			}
		}

		return checkGap;
	}
	/*
	 * // 通过seqId和表名，查询seqId的最新监测信息时间:查询最新的2个分区 private Long
	 * getLatestDetectTimeDigitalBySeqId(String detailTabName, String seqId) {
	 * Long checkTimeDigital = null; if (StringUtils.isNotBlank(detailTabName)
	 * && StringUtils.isNotBlank(seqId)) { try { String partitionName =
	 * " SELECT PARTITION_NAME  " + " FROM (" + " SELECT VI.PARTITION_NAME " +
	 * " FROM USER_TAB_PARTITIONS VI " + " WHERE VI.TABLE_NAME = '" +
	 * detailTabName.toUpperCase() + "'" + // 表示当前分区已经有数据存入了
	 * " ORDER BY VI.PARTITION_NAME DESC ) " + " WHERE ROWNUM<=2";
	 * List<Object[]> partNameList = commonService.executeSQL(partitionName);
	 * logger.debug("getLatestDetectTimeDigitalBySeqId获取分区sql："+partitionName);
	 * List<String> partNames = new ArrayList<String>(); if (partNameList !=
	 * null && partNameList.size() > 0) { for (int i = 0; i <
	 * partNameList.size(); i++) { Object obj = partNameList.get(i); if (obj !=
	 * null && !"".equals(obj.toString().trim())) { partNames.add("  PARTITION("
	 * + obj.toString() + ")  "); } } }
	 * 
	 * 
	 * String checkTimeSql =
	 * "SELECT TO_CHAR(MAXCHECKTIME,'yyyy-MM-dd HH24:mi:ss')  FROM ("+
	 * " SELECT MAX(DATA_CHECK_TIME)  MAXCHECKTIME" + // 查询当前节点的端口信息的最新监测时间
	 * "  FROM (";
	 * 
	 * if (partNames.size() > 0 && partNames.get(0) != null) { checkTimeSql +=
	 * " SELECT DS.DATA_CHECK_TIME FROM " + detailTabName + partNames.get(0) +
	 * " DS  WHERE DS.SEQ_ID=" + seqId; if (partNames.size() > 1 &&
	 * partNames.get(1) != null) { checkTimeSql += " UNION ALL " +
	 * " SELECT DS2.DATA_CHECK_TIME FROM " + detailTabName + partNames.get(1) +
	 * " DS2  WHERE DS2.SEQ_ID=" + seqId; } checkTimeSql += ")"; } else {
	 * checkTimeSql += detailTabName + ")  DS WHERE DS.SEQ_ID=" + seqId; }
	 * 
	 * checkTimeSql +=")";
	 * 
	 * List<Object[]> setTableNameList = commonService.executeSQL(checkTimeSql);
	 * 
	 * logger.debug("getLatestDetectTimeDigitalBySeqId获取最新监测sql："+checkTimeSql);
	 * if (setTableNameList != null && setTableNameList.size() > 0) { Object obj
	 * = setTableNameList.get(0); Date checkTimeDate =
	 * obj==null?null:DateUtil.format.parse(obj.toString()); checkTimeDigital =
	 * checkTimeDate == null ? null : checkTimeDate.getTime(); } } catch
	 * (Exception e) { logger.error("通过seqId和表名，查询seqId的最新监测信息时间 异常", e); } }
	 * 
	 * return checkTimeDigital; }
	 */

	// 通过seqId和表名，查询seqId的当前监测的设置的监测时间间隔（因为一个节点，同一种监测设置，可能设置多个，此时，我们取监测信息最新的监测设置的间隔时间）
	/*
	 * private Long getLatestCheckGapBySeqId(String detailTabName, String seqId)
	 * { Long checkGap = null; if (StringUtils.isNotBlank(detailTabName) &&
	 * StringUtils.isNotBlank(seqId)) { try { String partitionName =
	 * " SELECT PARTITION_NAME  " + " FROM (" + " SELECT VI.PARTITION_NAME " +
	 * " FROM USER_TAB_PARTITIONS VI " + " WHERE VI.TABLE_NAME = '" +
	 * detailTabName.toUpperCase() + "'" + // 表示当前分区已经有数据存入了
	 * " ORDER BY VI.PARTITION_NAME DESC ) " + " WHERE ROWNUM<=2";
	 * List<Object[]> partNameList = commonService.executeSQL(partitionName);
	 * 
	 * logger.debug("getLatestCheckGapBySeqId获取分区sql："+partitionName);
	 * List<String> partNames = new ArrayList<String>(); if (partNameList !=
	 * null && partNameList.size() > 0) { for (int i = 0; i <
	 * partNameList.size(); i++) { Object obj = partNameList.get(i); if (obj !=
	 * null && !"".equals(obj.toString().trim())) { partNames.add("  PARTITION("
	 * + obj.toString() + ")  "); } } } //partNames.clear(); String
	 * detectSetIdSql = " SELECT DSI.CHECK_GAP " +
	 * "  FROM DETECTION_SET_INFO DSI " + "  WHERE DSI.ID =(" +
	 * "               		    SELECT DETECTION_SET_INFO_ID   " +
	 * "                         FROM ("; if (partNames.size() > 0 &&
	 * partNames.get(0) != null) { detectSetIdSql +=
	 * " SELECT DETECTION_SET_INFO_ID FROM " + detailTabName + partNames.get(0)
	 * + "  WHERE DETECTION_SET_INFO_ID >=0  and SEQ_ID=" + seqId; if
	 * (partNames.size() > 1 && partNames.get(1) != null) { detectSetIdSql +=
	 * " UNION ALL" + " SELECT DETECTION_SET_INFO_ID FROM " + detailTabName +
	 * partNames.get(1) + "  WHERE DETECTION_SET_INFO_ID >=0  AND SEQ_ID=" +
	 * seqId; } detectSetIdSql += ")  WHERE ROWNUM=1  )"; } else {
	 * detectSetIdSql += detailTabName +
	 * ")  WHERE ROWNUM=1 AND DETECTION_SET_INFO_ID IS NOT NULL  AND SEQ_ID=" +
	 * seqId + ")"; }
	 * 
	 * List<Object[]> detectSetList = commonService.executeSQL(detectSetIdSql);
	 * logger.debug("getLatestCheckGapBySeqId获取分区sql获取最新监测sql："+detectSetIdSql);
	 * if (detectSetList != null && detectSetList.size() > 0) { Object obj =
	 * detectSetList.get(0); checkGap = obj == null ? null :
	 * Long.parseLong(obj.toString()); } } catch (Exception e) {
	 * logger.error("通过seqId和表名，查询seqId的最新监测信息的监测时间间隔 异常", e); } }
	 * 
	 * return checkGap; }
	 */

	// 生成svg文件，用于显示网元监测图
	private void generSwitchGraphXmlFile(List<NodeFigureInfo> list) {
		int tipWidth = 155;// 提示信息框的宽度
		StringBuffer xmlStr = new StringBuffer("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
		xmlStr.append("\n");
		xmlStr.append(
				"<svg version=\"1.1\"  xmlns=\"http://www.w3.org/2000/svg\"  xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"100%\" height=\"100%\"  onload=\"init(evt)\">");// xmlns=\"http://www.w3.org/2000/svg\":火狐显示时的支持
		// xmlns:xlink=\"http://www.w3.org/1999/xlink\"：图片链接的支持
		xmlStr.append("\n <style>");
		xmlStr.append("\n .tooltip{font-size: 20px;}");
		xmlStr.append("\n .tooltip_bg{fill: white;stroke: pink;stroke-width: 1;opacity: 0.85;}");
		xmlStr.append("\n </style>");

		xmlStr.append("\n <script type=\"text/ecmascript\">");
		xmlStr.append("\n <![CDATA[");
		xmlStr.append("\n function init(evt){ ");
		xmlStr.append("\n    if(window.svgDocument == null){ ");
		xmlStr.append("\n        svgDocument = evt.target.ownerDocument; ");
		xmlStr.append("\n    } ");
		xmlStr.append("\n    svgDocument.svgWnd = window ; ");
		xmlStr.append("\n    parentwindow = window.parent; ");
		xmlStr.append("\n    tooltip = svgDocument.getElementById('tooltip');");
		xmlStr.append("\n    tooltip_bg = svgDocument.getElementById('tooltip_bg');");
		xmlStr.append("\n } ");
		xmlStr.append("\n var svgNS = \"http://www.w3.org/2000/svg\"; ");
		// xmlStr.append("\n function create_multiline(width) { ");
		// xmlStr.append("\n var text_element = tooltip;");
		// xmlStr.append("\n var words = text_element.firstChild.data.split('
		// ');");
		// xmlStr.append("\n var start_x = text_element.getAttributeNS(null,
		// 'x');");
		// xmlStr.append("\n text_element.firstChild.data = ''; ");
		// xmlStr.append("\n var tspan_element = document.createElementNS(svgNS,
		// \"tspan\");");
		// xmlStr.append("\n var text_node = document.createTextNode(words[0]);
		// ");
		// xmlStr.append("\n tspan_element.appendChild(text_node);");
		// xmlStr.append("\n text_element.appendChild(tspan_element);");
		// xmlStr.append("\n for(var i=1; i<words.length; i++){");
		// xmlStr.append("\n var len = tspan_element.firstChild.data.length;");
		// xmlStr.append("\n tspan_element.firstChild.data += \" \" +
		// words[i];");
		// xmlStr.append("\n if (tspan_element.getComputedTextLength() >
		// width){");
		// xmlStr.append("\n tspan_element.firstChild.data =
		// tspan_element.firstChild.data.slice(0, len);");
		// xmlStr.append("\n var tspan_element = document.createElementNS(svgNS,
		// \"tspan\");");
		// xmlStr.append("\n tspan_element.setAttributeNS(null, \"x\",
		// start_x);");
		// xmlStr.append("\n tspan_element.setAttributeNS(null, \"dy\", 18);");
		// xmlStr.append("\n text_node = document.createTextNode('
		// '+words[i]);");
		// xmlStr.append("\n tspan_element.appendChild(text_node);");
		// xmlStr.append("\n text_element.appendChild(tspan_element);");
		// xmlStr.append("\n } ");
		// xmlStr.append("\n } ");
		// xmlStr.append("\n } ");
		xmlStr.append("\n function create_multiline(width) {     ");
		xmlStr.append("\n     var testMaxLen = 100;");

		xmlStr.append("\n     var text_element = tooltip;");
		xmlStr.append("\n     var words = text_element.firstChild.data.split(';');");
		xmlStr.append("\n     var start_x = text_element.getAttributeNS(null, 'x');");
		xmlStr.append("\n     text_element.firstChild.data = '';	 ");

		xmlStr.append("\n     var tspan_element = document.createElementNS(svgNS, \"tspan\");");
		xmlStr.append("\n     var text_node = document.createTextNode(words[0]);	");
		xmlStr.append("\n     tspan_element.appendChild(text_node);");
		xmlStr.append("\n     text_element.appendChild(tspan_element);");

		// xmlStr.append("\n alert(testMaxLen);");
		// xmlStr.append("\n alert(tspan_element.getComputedTextLength());");
		xmlStr.append("\n     if (tspan_element.getComputedTextLength() > testMaxLen){");
		xmlStr.append("\n         testMaxLen = tspan_element.getComputedTextLength();");
		// xmlStr.append("\n alert(testMaxLen);");
		xmlStr.append("\n     }");

		xmlStr.append("\n     for(var i=1; i<words.length; i++){");
		// xmlStr.append("\n var len = tspan_element.firstChild.data.length;");
		// xmlStr.append("\n tspan_element.firstChild.data += \" \" +
		// words[i];");
		// xmlStr.append("\n if (tspan_element.getComputedTextLength() >
		// width){");
		// xmlStr.append("\n tspan_element.firstChild.data =
		// tspan_element.firstChild.data.slice(0, len);");
		xmlStr.append("\n                var tspan_element = document.createElementNS(svgNS, \"tspan\");");
		xmlStr.append("\n                tspan_element.setAttributeNS(null, \"x\", start_x);");
		xmlStr.append("\n                tspan_element.setAttributeNS(null, \"dy\", 18);");
		xmlStr.append("\n                text_node = document.createTextNode(''+words[i]);");
		xmlStr.append("\n                tspan_element.appendChild(text_node);");
		xmlStr.append("\n                text_element.appendChild(tspan_element);");

		xmlStr.append("\n     			 if (tspan_element.getComputedTextLength() > testMaxLen){");// 要先执行text_element.appendChild(tspan_element)，元素加入文件里了，才可以操作
		xmlStr.append("\n         			 testMaxLen = tspan_element.getComputedTextLength();");
		xmlStr.append("\n     			 }");
		// xmlStr.append("\n } ");
		xmlStr.append("\n     } ");
		// xmlStr.append("\n alert(testMaxLen);");
		xmlStr.append("\n     tooltip_bg.setAttributeNS(null,\"width\",testMaxLen+18);");
		// xmlStr.append("\n
		// alert(tooltip_bg.getAttributeNS(null,\"width\"));");
		xmlStr.append("\n } ");
		xmlStr.append("\n function ShowTooltip(evt,mouseovertext,midX) {  ");
		xmlStr.append("\n    nodeList = tooltip.childNodes; ");
		xmlStr.append("\n    if(nodeList != null){ ");
		xmlStr.append("\n    	len = nodeList.length; ");
		xmlStr.append("\n    	for(var i=0; i<len; i++){");
		xmlStr.append("\n    		tooltip.removeChild(tooltip.firstChild); ");
		xmlStr.append("\n    	}");
		xmlStr.append("\n    }");

		xmlStr.append("\n    if(evt.clientX<midX){ ");// 提示信息显示在右边
		xmlStr.append("\n    	tooltip.setAttributeNS(null,\"x\",evt.clientX+16);");
		xmlStr.append("\n    	tooltip_bg.setAttributeNS(null,\"x\",evt.clientX+8);");
		xmlStr.append("\n    }else{");
		xmlStr.append("\n       var tipBgWidth = tooltip_bg.getAttributeNS(null, 'width');");
		xmlStr.append("\n    	tooltip.setAttributeNS(null,\"x\",evt.clientX-tipBgWidth+8);");
		xmlStr.append("\n    	tooltip_bg.setAttributeNS(null,\"x\",evt.clientX-tipBgWidth);");
		xmlStr.append("\n    }");

		xmlStr.append("\n    tooltip.setAttributeNS(null,\"y\",evt.clientY+33);");
		xmlStr.append("\n    tooltip_bg.setAttributeNS(null,\"y\",evt.clientY+16);");

		xmlStr.append("\n    var text_node = document.createTextNode(mouseovertext);");
		xmlStr.append("\n    tooltip.appendChild(text_node);");

		xmlStr.append("\n    tooltip.setAttributeNS(null,\"visibility\",\"visible\"); ");
		xmlStr.append("\n    tooltip_bg.setAttributeNS(null,\"visibility\",\"visible\"); ");
		// xmlStr.append("\n alert(svgDocument.rootElement); ");
		// xmlStr.append("\n
		// alert(svgDocument.rootElement.getAttributeNS(null,'width')); ");
		// xmlStr.append("\n attrs = svgDocument.attributes; ");
		// xmlStr.append("\n if(attrs != null){ ");
		// xmlStr.append("\n len = attrs.length; ");
		// xmlStr.append("\n for(var i=0; i<len; i++){");
		// xmlStr.append("\n var attr = attrs.item(i); ");
		// xmlStr.append("\n alert(attr.name+':'+attr.value); ");
		// xmlStr.append("\n }");
		// xmlStr.append("\n }");
		xmlStr.append("\n    create_multiline(" + (tipWidth - 5) + "); ");// 将提示信息换行
		xmlStr.append("\n } ");
		xmlStr.append("\n function detailPortInfo(a,b,c,id){  ");
		xmlStr.append("\n   parentwindow.detailPortInfo(a,b,c,id)  ");
		xmlStr.append("\n }");
		xmlStr.append("\n function HideTooltip(){  ");
		xmlStr.append("\n    tooltip.setAttributeNS(null,\"visibility\",\"hidden\"); ");
		xmlStr.append("\n    tooltip_bg.setAttributeNS(null,\"visibility\",\"hidden\");  ");
		xmlStr.append("\n } ");

		// 划线的js
		xmlStr.append("\n function showSelect(id){ ");
		xmlStr.append("\n  var obj = svgDocument.getElementById(id); ");
		xmlStr.append("\n  if(obj == null) return ;");
		xmlStr.append("\n  var x = obj.getAttribute(\"x\");");
		xmlStr.append("\n  var y = obj.getAttribute(\"y\");");
		xmlStr.append("\n  var width = obj.getAttribute(\"width\"); ");
		xmlStr.append("\n  var height = obj.getAttribute(\"height\");");
		xmlStr.append("\n  var selected_box = svgDocument.getElementById('selected_box'); ");
		xmlStr.append("\n  selected_box.setAttributeNS(null,\"x\",x-1); ");
		xmlStr.append("\n  selected_box.setAttributeNS(null,\"y\",y-1);");
		xmlStr.append("\n  selected_box.setAttributeNS(null,\"width\",parseInt(width)+1);");
		xmlStr.append("\n  selected_box.setAttributeNS(null,\"height\",parseInt(height)+1);");
		xmlStr.append("\n  selected_box.setAttributeNS(null,\"visibility\",\"visible\"); ");
		xmlStr.append("\n } ");
		xmlStr.append("\n ]]></script> ");
		String webPathTmp = SwitchDetectionAction.class.getClassLoader().getResource("").getPath();
		logger.info("操作记录：项目绝对路径为：" + webPathTmp);
		String xmlFileName = seqId + "-" + detectId + ".svg";
		// if(checkTimeDigital!=null) {
		// xmlFileName = checkTimeDigital.toString()+".svg";
		// }
		// String sepStr = System.getProperty("file.separator"); //文件分隔符
		String sepStr = "/";
		String webRootPath = Common.buildPath(webPathTmp.substring(1, webPathTmp.length() - 16));
		String webPath = sepStr + webRootPath + "page" + sepStr + "detection" + sepStr + "switchInfo" + sepStr
				+ xmlFileName;// svg文件的路径和文件名\D:/Tomcat
								// 6.0_NMS/webapps/nmsweb/page\detection\switchInfo\448-9.svg
		/*
		 * String webPath = sepStr + webRootPath + "page" + sepStr + "detection"
		 * + sepStr + "switchInfo" + sepStr + "448-9.svg";
		 */
		// String imagesPath = webRootPath+Constants.SVG_IMAGES_PATH;
		String imagesPath = Common.buildPath(getRequest().getContextPath()) + sepStr + Constants.SVG_IMAGES_PATH;
		try {
			if (list != null && list.size() > 0) {
				NodeFigureInfo rootDev = new NodeFigureInfo();
				// String hql = "from NodeFigureInfo where seqid="+ seqId+" and
				// pid='0'";
				// List<NodeFigureInfo> rootDevList =
				// (List<NodeFigureInfo>)this.commonService.find(hql);
				// if(rootDevList!=null && rootDevList.size()>0){
				// rootDev = rootDevList.get(0);//根设备
				// deviceTypeCode = rootDev.getDeviceTypeCode();//获取监测设备类型
				// }
				for (NodeFigureInfo nodeFigure : list) {
					if (nodeFigure.getPid().longValue() == 0l) {
						deviceTypeCode = nodeFigure.getDeviceTypeCode();// 获取监测设备类型
						rootDev = nodeFigure;// 根设备
						break;
					}
				}

				long x = rootDev.getFigureX();
				long width = rootDev.getFigureWidth();
				long midX = x + width / 2;// 当鼠标小于midX时，端口的提示信息在右边显示，当鼠标的x大于等于midX时，端口的提示信息在左边显示
				String xmlElemStr = "";
				if (!sysStatusFlag && rootDev != null) {
					xmlStr.append("\n");
					xmlStr.append("<image  x=\"" + rootDev.getFigureX() + "\" y=\"" + rootDev.getFigureY()
							+ "\"  width=\"" + rootDev.getFigureWidth()
							+ "\"  height=\"30\"  stroke=\"black\"  stroke-width=\"2\"  xlink:href=\"" + imagesPath
							+ "sysStatusError.png\"  /> ");
				}
				for (NodeFigureInfo nodeFigure : list) {
					/*
					 * String xmlElemStr = ""; //
					 * 系统异常时，加文本提示信息:异常提示显示在图片最上面，整个设备图片下移errorheight if
					 * (!sysStatusFlag && rootDev != null) {
					 * xmlStr.append("\n"); xmlStr.append("<image  x=\"" +
					 * rootDev.getFigureX() + "\" y=\"" + rootDev.getFigureY() +
					 * "\"  width=\"" + rootDev.getFigureWidth() +
					 * "\"  height=\"30\"  stroke=\"black\"  stroke-width=\"2\"  xlink:href=\""
					 * + imagesPath + "sysStatusError.png\"  /> "); xmlElemStr =
					 * getXmlElemStrByFillType(nodeFigure, imagesPath, midX,30);
					 * }else{
					 */
					xmlStr.append("\n");
					xmlStr.append("<image  x=\"" + rootDev.getFigureX() + "\" y=\"" + rootDev.getFigureY()
							+ "\"  width=\"" + rootDev.getFigureWidth()
							+ "\"  height=\"30\"  stroke=\"black\"  stroke-width=\"2\"  xlink:href=\"\"  /> ");
					if (!sysStatusFlag && rootDev != null) {
						xmlElemStr = getXmlElemStrByFillType(nodeFigure, imagesPath, midX, 30);
					} else {
						xmlElemStr = getXmlElemStrByFillType(nodeFigure, imagesPath, midX, 0);
					}
					/* } */
					xmlStr.append("\n");
					xmlStr.append(xmlElemStr);
				}

				// 系统异常时，加文本提示信息:要先显示异常提示，否则会影响tip的显示，但是异常提示要显示在设备底图的上面？？
				/*
				 * if (!sysStatusFlag && rootDev != null) { xmlStr.append("\n");
				 * xmlStr.append("<image  x=\"" + rootDev.getFigureX() +
				 * "\" y=\"" + rootDev.getFigureY() + "\"  width=\"" +
				 * rootDev.getFigureWidth() +
				 * "\"  height=\"30\"  stroke=\"black\"  stroke-width=\"2\"  xlink:href=\""
				 * + imagesPath + "sysStatusError.png\"  /> "); }
				 */
				xmlStr.append(
						"\n <rect id=\"selected_box\" fill=\"none\"  stroke=\"red\" stroke-width=\"1\"     x=\"\" y=\"\"  width=\"\" height=\"\"  visibility=\"hidden\" /> ");
				// 增加提示文本
				xmlStr.append(
						"\n <rect fill=\"#FFFFCC\"  stroke=\"black\" stroke-width=\"1\"  id=\"tooltip_bg\"   x=\"0\" y=\"0\"  width=\""
								+ tipWidth + "\" height=\"125\"  visibility=\"hidden\" /> ");
				xmlStr.append(
						"\n <text class=\"tooltip\" id=\"tooltip\"    x=\"10\" y=\"10\"   visibility=\"hidden\" ></text>");

			}
			xmlStr.append("\n");
			xmlStr.append("</svg>");

			// 将字符串写成文件，命名为xmlFileName
			File file = new File(webPath);
			//
			logger.info("操作记录：svg图片所在路径为：" + imagesPath);
			logger.info("操作记录：生成svg文件的路径为：" + webPath);
			FileUtils.writeStringToFile(file, xmlStr.toString(), "UTF-8");
			svgName = xmlFileName;
			logger.info("操作记录：已生成svg文件：" + svgName);

		} catch (Exception e) {
			logger.error("Generate svg file exception", e);
		}

	}

	/**
	 * 
	 * @param nodeFigure
	 * @param imagesPath
	 * @param midX
	 * @param errorheight
	 *            如果异常则把图片放在设备最上面，所有图片加上errorheight，即整个图片下移
	 * @return
	 */
	private String getXmlElemStrByFillType(NodeFigureInfo nodeFigure, String imagesPath, long midX, int errorheight) {
		String elemStr = "";
		if (nodeFigure != null) {
			String figureFill = nodeFigure.getFigureFill();
			String figureType = nodeFigure.getFigureType();
			if (StringUtils.isNotBlank(figureFill)) {

				Long x = nodeFigure.getFigureX();
				Long y = nodeFigure.getFigureY();
				// 整个图片下移
				y = y + Long.valueOf(errorheight) + 13;
				Long width = nodeFigure.getFigureWidth();
				Long height = nodeFigure.getFigureHeight();
				String stroke = nodeFigure.getFigureStroke();
				Long strokeWidth = nodeFigure.getFigureStrokeWidth();
				String nameFlagTmp = nodeFigure.getNameFlag();
				Long pid = nodeFigure.getPid();
				Long isLeaf = nodeFigure.getIsLeaf();
				Long id = nodeFigure.getId();

				if ("image".equals(figureType)) {// 图片
					if (isLeaf == 1l) {// 加链接
						String tip = nameFlagTmp + " ";
						SwitchPortInfo portInfo = switchPortMap.get(nameFlagTmp);
						if (portInfo != null) {
							tip += ";"+getI18nText("i18n_SwitchDetectionAction.emportXls.netSpeed_n81i")+":" + (portInfo.getSpeedStr() == null ? "--" : portInfo.getSpeedStr()) + ";"+getI18nText("i18n_SwitchDetectionAction.emportXls.output_n81i")+":"
									+ (portInfo.getIfOutOctetsSpeedStr() == null ? "--"
											: portInfo.getIfOutOctetsSpeedStr())
									+ ";"+getI18nText("i18n_SwitchDetectionAction.emportXls.input_n81i")+":"
									+ (portInfo.getIfInOctetsSpeedStr() == null ? "--"
											: portInfo.getIfInOctetsSpeedStr())
									+ ";"+getI18nText("i18n_SwitchDetectionAction.emportXls.packout_n81i")+":"
									+ (portInfo.getOutpktsspeed() == null ? "--"
											: new BigDecimal(portInfo.getOutpktsspeed()))
									+ "pps;"+getI18nText("i18n_SwitchDetectionAction.emportXls.packin_n81i")+":" + (portInfo.getInpktsspeed() == null ? "--"
											: new BigDecimal(portInfo.getInpktsspeed()))
									+ "pps";
						} else {
							tip += ";"+getI18nText("i18n_SwitchDetectionAction.emportXls.netSpeed_n81i")+":0Mbps;"+getI18nText("i18n_SwitchDetectionAction.emportXls.output_n81i")+":0bps;"+getI18nText("i18n_SwitchDetectionAction.emportXls.input_n81i")+":0bps;"+getI18nText("i18n_SwitchDetectionAction.emportXls.packout_n81i")+":0pps;"+getI18nText("i18n_SwitchDetectionAction.emportXls.packin_n81i")+":0pps;";
						}
						elemStr = "<a xlink:href=\"javascript:detailPortInfo('" + nameFlagTmp + "'," + pid + ","
								+ isLeaf + "," + id + ")\" onmousemove=\"ShowTooltip(evt, '" + tip + "'," + midX
								+ ")\"  onmouseout=\"HideTooltip()\"> \n";
						/*
						 * if (StringUtils.isNotBlank(nameFlag) &&
						 * nameFlag.equalsIgnoreCase(nameFlagTmp)) { elemStr +=
						 * "<rect fill=\"none\"  stroke=\"red\" stroke-width=\"1\"   x=\""
						 * + (x - 1) + "\" y=\"" + (y - 1) + "\"  width=\"" +
						 * (width + 2) + "\" height=\"" + (height + 2) +
						 * "\"   /> ";// 显示选中端口的框 }
						 */
						elemStr += "\n <image id=\"" + id + "\" x=\"" + x + "\"  y=\"" + y + "\"  width=\"" + width
								+ "\"  height=\"" + height + "\"  stroke=\"" + stroke + "\"  stroke-width=\""
								+ strokeWidth + "\"  xlink:href=\"" + imagesPath + figureFill + "\"  /> " + "\n </a>";
					} else {// 不加链接
						elemStr = " \n" + "<image id=\"" + id + "\" x=\"" + x + "\"  y=\"" + y + "\"  width=\"" + width
								+ "\"  height=\"" + height + "\"  stroke=\"" + stroke + "\"  stroke-width=\""
								+ strokeWidth + "\"  xlink:href=\"" + imagesPath + figureFill + "\"  /> " + "\n ";
					}
				} else if ("rect".equals(figureType)) {// 矩形
					elemStr = "<rect id=\"" + id + "\"  x=\"" + x + "\"  y=\"" + y + "\"  width=\"" + width
							+ "\"  height=\"" + height + "\"  stroke=\"" + stroke + "\"  stroke-width=\"" + strokeWidth
							+ "\"  fill=\"" + figureFill + "\"  transform=\"translate(-2,-39)\" /> ";
				} else if ("circle".equals(figureType)) {// 圆形
					elemStr = "<circle  cx=\"" + x + "\"  cy=\"" + y + "\"  r=\"" + width + "\"  stroke=\"" + stroke
							+ "\"  stroke-width=\"" + strokeWidth + "\"  fill=\"" + figureFill + "\"  /> ";
				}
			}
		}

		return elemStr;
	}

	// 端口数据折线图
	public String getSource() {
		String dataType = this.getRequest().getParameter("dataType");// 数据类型（表中的字段名）
		String dataDesc = this.getRequest().getParameter("dataDesc");// 类型描述
		String unit = this.getRequest().getParameter("unit");// 数据的单位
		List sourceList = null;
		String driwSQL = "";
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();
		try {

			if (StringUtils.isNotBlank(seqId) && StringUtils.isNotBlank(detectId) && StringUtils.isNotBlank(dataType)
					&& StringUtils.isNotBlank(nameFlag)) {

				// - 查询库表名
				String detailTabName = getTabNameByDetecSetId(detectId);
				Map<String, Object> result = new HashMap();
				List<Map<String, Object>> line = new ArrayList<Map<String, Object>>();
				// 封装一条拆线
				Map<String, Object> chart = new HashMap();
				Map<String, Object> chartPoint = new HashMap();
				Map<String, Object> otherPoint = new HashMap();
				String dataType0 = "";
				if (StringUtils.isNotBlank(dataType)) {

					// -替换查询字段 用于运算
					if ("INOCTETSSPEED".equalsIgnoreCase(dataType)) { // 输入字节速度
						dataType0 = dataType + ",IFINOCTETS";
					} else if ("OUTOCTETSSPEED".equalsIgnoreCase(dataType)) { // 输出字节速度
						dataType0 = dataType + ",IFOUTOCTETS";
					} else if ("INPKTSSPEED".equalsIgnoreCase(dataType)) { // 输入包速度
						dataType0 = dataType + ",IFINUCASTPKTS,IFINNUCASTPKTS,IFINOCTETS";
					} else if ("OUTPKTSSPEED".equalsIgnoreCase(dataType)) { // 输出包速度
						dataType0 = dataType + ",IFOUTUCASTPKTS,IFOUTNUCASTPKTS,IFOUTOCTETS";
					} else if ("ifoutdiscards_vary".equalsIgnoreCase(dataType)) { // 输出丢包数
						dataType0 = dataType + ",IFOUTDISCARDS";
					} else if ("ifindiscards_vary".equalsIgnoreCase(dataType)) { // 输入丢包数
						dataType0 = dataType + ",IFINDISCARDS";
					} else if ("ifouterrors_vary".equalsIgnoreCase(dataType)) { // 输出差错数
						dataType0 = dataType + ",IFOUTERRORS";
					} else if ("ifinerrors_vary".equalsIgnoreCase(dataType)) { // 输入差错数
						dataType0 = dataType + ",IFINERRORS";
					} else {
						dataType0 = dataType;
					}

					// 根据时间查询数据用于统计
					if (StringUtils.isNotBlank(startTime)) {// &&StringUtils.isNotBlank(endTimeTmp)
						String pattern = "yyyy-MM-dd HH:mm";
						Date sd = Common.getDateObject(startTime, pattern);
						Date end = new Date(sd.getTime() + 24*60*60*1000);
						driwSQL = "  SELECT DS.DATA_CHECK_TIME_DIGITAL,DS.DATA_64_FLAG,"
								+ "DECODE(IFHIGHSPEED,NULL,IFSPEED,0,IFSPEED,IFHIGHSPEED*1024*1024) IFHIGHSPEEDBPS,"
								+ dataType0 + "  FROM  " + detailTabName + " DS  " + "  WHERE DS.DETECTION_SET_INFO_ID="
								+ detectId + "        AND DS.IFDESCR='" + nameFlag + "'" + "        AND DS.SEQ_ID="
								+ seqId + "        AND DS.DATA_CHECK_TIME >= TO_DATE('" + startTime
								+ "','yyyy-MM-dd HH24:mi')" + "        AND DS.DATA_CHECK_TIME <= TO_DATE('" + Common.getDateStr(end, pattern)
								+ "','yyyy-MM-dd HH24:mi')" + "  ORDER BY DS.DATA_CHECK_TIME ASC";
					} else {
						driwSQL = "  SELECT DS.DATA_CHECK_TIME_DIGITAL,DS.DATA_64_FLAG, "
								+ "DECODE(IFHIGHSPEED,NULL,IFSPEED,0,IFSPEED,IFHIGHSPEED*1024*1024) IFHIGHSPEEDBPS,"
								+ dataType0 + "  FROM  " + detailTabName + " DS  "
								+ "  WHERE  DS.DETECTION_SET_INFO_ID=" + detectId + "        AND DS.IFDESCR='"
								+ nameFlag + "'" + "        AND DS.SEQ_ID=" + seqId
								+ "        AND DS.DATA_CHECK_TIME >= SYSDATE - 1" + "  ORDER BY DS.DATA_CHECK_TIME ASC";

						startTime = DateUtil.getFormatDate(DateUtil.getBeforeHourDate(new Date(), 24));
					}
				}
				System.out.println("driwSQL:" + driwSQL);
				sourceList = this.commonService.executeSQL(driwSQL);

				Map<String, Object> resultStartTime = new HashMap();
				resultStartTime.put("startTime", startTime);
				returnList.add(resultStartTime);

				// 查询监测设置信息，获取周期间隔时间，用于断线
				DetectionSetInfo dsi = (DetectionSetInfo) this.commonService.get(DetectionSetInfo.class,
						Long.parseLong(detectId));
				long gapTime = dsi.getCheckGap(); // 单位： 分钟
				gapTime = gapTime * 60 * 1000; // 分钟 变毫秒
				Object[] objs = null;
				List<Object[]> dataPoint = new ArrayList<Object[]>();
				if (sourceList.size() > 0) {

					// 计算
					if ("INOCTETSSPEED".equalsIgnoreCase(dataType)) { // 输入字节速度
						objs = commonService.bitSpeedSourceList(sourceList, gapTime);
					} else if ("OUTOCTETSSPEED".equalsIgnoreCase(dataType)) { // 输出字节速度
						objs = commonService.bitSpeedSourceList(sourceList, gapTime);
					} else if ("INPKTSSPEED".equalsIgnoreCase(dataType)) { // 输入包速度
						objs = commonService.pktSpeedSourceList(sourceList, gapTime);
					} else if ("OUTPKTSSPEED".equalsIgnoreCase(dataType)) { // 输出包速度
						objs = commonService.pktSpeedSourceList(sourceList, gapTime);
					} else if ("ifoutdiscards_vary".equalsIgnoreCase(dataType)) { // 输出丢包数
						dataPoint = commonService.pktDiscardsList(sourceList);
					} else if ("ifindiscards_vary".equalsIgnoreCase(dataType)) { // 输入丢包数
						dataPoint = commonService.pktDiscardsList(sourceList);
					} else if ("ifouterrors_vary".equalsIgnoreCase(dataType)) { // 输出差错数
						dataPoint = commonService.pktDiscardsList(sourceList);
					} else if ("ifinerrors_vary".equalsIgnoreCase(dataType)) { // 输入差错数
						dataPoint = commonService.pktDiscardsList(sourceList);
					} else {
						for (int i = 0; i < sourceList.size(); i++) {
							Object[] olds = (Object[]) sourceList.get(i);
							dataPoint.add(new Object[] { olds[0], olds[2] });
						}
					}

					// 封装一条折线
					chart.put("name", dataType + getI18nText("i18n_SwitchDetectionAction.emportXls.avgSpeed_n81i"));
					chart.put("data", objs != null ? objs[0] : null);
					chartPoint.put("name", getI18nText("i18n_SwitchDetectionAction.emportXls.pointSpeed_n81i"));
					chartPoint.put("data", objs != null ? objs[1] : null);
					otherPoint.put("name", dataType);
					otherPoint.put("data", dataPoint);
					line.add(chart);
					line.add(chartPoint);
					line.add(otherPoint);
					result.put("lines", line);
					result.put("xtitle", ip + "_" + nameFlag + "：" + dataDesc + unit + getI18nText("i18n_SwitchDetectionAction.emportXls.cartogram_n81i"));
					result.put("ytitle", dataDesc + unit);

					returnList.add(result);
				}
				String jsonStr = JSONArray.fromObject(returnList).toString();
				this.getResponse().setCharacterEncoding("utf-8");
				PrintWriter printWriter = this.getResponse().getWriter();
				printWriter.write(jsonStr);
				printWriter.close();
				printWriter = null;
			}
		} catch (Exception e) {
			logger.error("Get port detail line chart exception", e);
		}
		return null;
	}

	// 系统折线图 Oct 16,2013 zwm
	public String getSystemSource() throws Exception {
		String dataType = this.getRequest().getParameter("dataType");// 数据类型（表中的字段名）
		HttpServletRequest request = this.getRequest();
		request.setCharacterEncoding("UTF-8");
		String dataDesc =request.getParameter("dataDesc");// 类型描述
		System.out.println(" $dataDesc="+dataDesc);
		String unit = this.getRequest().getParameter("unit");// 数据的单位
		List sourceList = null;
		String driwSQL = "";
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();
		try {

			if (StringUtils.isNotBlank(seqId) && StringUtils.isNotBlank(detectId) && StringUtils.isNotBlank(dataType) // &&
																														// StringUtils.isNotBlank(nameFlag)
			) {

				// - 查询库表名
				String detailTabName = getTabNameByDetecSetId(detectId);
				Map<String, Object> result = new HashMap();
				List<Map<String, Object>> line = new ArrayList<Map<String, Object>>();
				// 封装一条拆线
				Map<String, Object> chart = new HashMap();
				Map<String, Object> chartPoint = new HashMap();
				Map<String, Object> otherPoint = new HashMap();
				String dataType0 = "";
				if (StringUtils.isNotBlank(dataType)) {

					// -替换查询字段 用于运算
					if ("INOCTETSSPEED".equalsIgnoreCase(dataType)) { // 输入字节速度
						dataType0 = "sum(" + dataType + " )" + dataType + ",sum(IFINOCTETS) IFINOCTETS";
					} else if ("OUTOCTETSSPEED".equalsIgnoreCase(dataType)) { // 输出字节速度
						dataType0 = "sum(" + dataType + " )" + dataType + ",sum(IFOUTOCTETS) IFOUTOCTETS";
					} else if ("INPKTSSPEED".equalsIgnoreCase(dataType)) { // 输入包速度
						dataType0 = "sum(" + dataType + " )" + dataType
								+ ",sum(IFINUCASTPKTS) IFINUCASTPKTS,sum(IFINNUCASTPKTS) IFINNUCASTPKTS,sum(IFINOCTETS)IFINOCTETS ";
					} else if ("OUTPKTSSPEED".equalsIgnoreCase(dataType)) { // 输出包速度
						dataType0 = "sum(" + dataType + " )" + dataType
								+ ",sum(IFOUTUCASTPKTS) IFOUTUCASTPKTS,sum(IFOUTNUCASTPKTS) IFOUTNUCASTPKTS,sum(IFOUTOCTETS) IFOUTOCTETS";
					} else {
						dataType0 = dataType;
					}

					// 根据时间查询数据用于统计
					if (StringUtils.isNotBlank(startTimeXt)) {// &&StringUtils.isNotBlank(endTimeTmp)
						SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
						driwSQL = "  SELECT DS.DATA_CHECK_TIME_DIGITAL,DS.DATA_64_FLAG,"
								+ " SUM(DECODE(IFHIGHSPEED,NULL,IFSPEED,0,IFSPEED,IFHIGHSPEED*1024*1024)) IFHIGHSPEEDBPS,"
								+ dataType0 + "  FROM  " + detailTabName + " DS  " + "  WHERE DS.IFDESCR IN ("
								+ " SELECT NFI.NAME_FLAG" + " FROM NODE_FIGURE_INFO NFI  "
								+ " WHERE  ( NFI.PORT_SET_STATE IS NULL  OR NFI.PORT_SET_STATE=1 ) "
								+ "         AND  NFI.IS_LEAF=1  " + "         AND NFI.SEQID= " + seqId + " )"
								+ "    AND DS.DETECTION_SET_INFO_ID=" + detectId + "    AND DS.SEQ_ID=" + seqId
								+ "    AND DS.DATA_CHECK_TIME >= TO_DATE('" + startTimeXt + "','yyyy-MM-dd HH24:mi')"
								+ "    AND DS.DATA_CHECK_TIME <= TO_DATE('" + format.format(DateUtil.getBeforeHourDate(format.parse(startTimeXt), -24)) + "','yyyy-MM-dd HH24:mi')"
								+ "  GROUP  BY DS.DATA_CHECK_TIME_DIGITAL ,DS.DATA_64_FLAG"
								+ "  ORDER   BY DS.DATA_CHECK_TIME_DIGITAL   ASC";
					} else {
						driwSQL = "  SELECT DS.DATA_CHECK_TIME_DIGITAL,DS.DATA_64_FLAG, "
								+ " SUM(DECODE(IFHIGHSPEED,NULL,IFSPEED,0,IFSPEED,IFHIGHSPEED*1024*1024)) IFHIGHSPEEDBPS,"
								+ dataType0 + "  FROM  " + detailTabName + " DS  " + "  WHERE   DS.IFDESCR IN ("
								+ " SELECT NFI.NAME_FLAG" + " FROM NODE_FIGURE_INFO NFI  "
								+ " WHERE  ( NFI.PORT_SET_STATE IS NULL  OR NFI.PORT_SET_STATE=1 ) "
								+ "         AND  NFI.IS_LEAF=1  " + "         AND NFI.SEQID= " + seqId + " )"
								+ "        AND DS.DETECTION_SET_INFO_ID=" + detectId + "        AND DS.SEQ_ID=" + seqId
								+ "        AND  DS.DATA_CHECK_TIME >= SYSDATE - 1 "
								+ "  GROUP  BY DS.DATA_CHECK_TIME_DIGITAL ,DS.DATA_64_FLAG"
								+ "   ORDER   BY DS.DATA_CHECK_TIME_DIGITAL   ASC";
						startTimeXt = DateUtil.getFormatDate(DateUtil.getBeforeHourDate(new Date(), 24));
					}
				}
				System.out.println("driwSQL:" + driwSQL);
				sourceList = this.commonService.executeSQL(driwSQL);
				
				Map<String, Object> resultStartTime = new HashMap();
				resultStartTime.put("startTimeXt", startTimeXt);
				returnList.add(resultStartTime);

				// 查询监测设置信息，获取周期间隔时间，用于断线
				DetectionSetInfo dsi = (DetectionSetInfo) this.commonService.get(DetectionSetInfo.class,
						Long.parseLong(detectId));
				long gapTime = dsi.getCheckGap(); // 单位： 分钟
				gapTime = gapTime * 60 * 1000; // 分钟 变毫秒
				Object[] objs = null;
				List<Object[]> dataPoint = new ArrayList<Object[]>();
				if (sourceList.size() > 0) {

					// 计算
					if ("INOCTETSSPEED".equalsIgnoreCase(dataType)) { // 输入字节速度
						objs = commonService.bitSpeedSourceList(sourceList, gapTime);
					} else if ("OUTOCTETSSPEED".equalsIgnoreCase(dataType)) { // 输出字节速度
						objs = commonService.bitSpeedSourceList(sourceList, gapTime);
					} else if ("INPKTSSPEED".equalsIgnoreCase(dataType)) { // 输入包速度
						objs = commonService.pktSpeedSourceList(sourceList, gapTime);
					} else if ("OUTPKTSSPEED".equalsIgnoreCase(dataType)) { // 输出包速度
						objs = commonService.pktSpeedSourceList(sourceList, gapTime);
					} else {
						for (int i = 0; i < sourceList.size(); i++) {
							Object[] olds = (Object[]) sourceList.get(i);
							dataPoint.add(new Object[] { olds[0], olds[2] });
						}
					}

					// 封装一条折线
					chart.put("name", dataType + getI18nText("i18n_SwitchDetectionAction.emportXls.avgSpeed_n81i"));
					chart.put("data", objs != null ? objs[0] : null);
					chartPoint.put("name", getI18nText("i18n_SwitchDetectionAction.emportXls.pointSpeed_n81i"));
					chartPoint.put("data", objs != null ? objs[1] : null);
					otherPoint.put("name", dataType);
					otherPoint.put("data", dataPoint);
					line.add(chart);
					line.add(chartPoint);
					line.add(otherPoint);
					result.put("lines", line);
					result.put("xtitle", ip + " ：" + dataDesc + unit + getI18nText("i18n_SwitchDetectionAction.emportXls.cartogram_n81i"));
					result.put("ytitle", dataDesc + unit);

					returnList.add(result);
				}

				String jsonStr = JSONArray.fromObject(returnList).toString();
				this.getResponse().setCharacterEncoding("utf-8");
				PrintWriter printWriter = this.getResponse().getWriter();
				printWriter.write(jsonStr);
				printWriter.close();
				printWriter = null;
			}
		} catch (Exception e) {
			logger.error("Get port detail line chart exception", e);
		}
		return null;
	}
	/*
	 * //端口数据折线图 public String getSource() { String dataType =
	 * this.getRequest().getParameter("dataType");//数据类型（表中的字段名） String dataDesc
	 * = this.getRequest().getParameter("dataDesc");//类型描述 String unit =
	 * this.getRequest().getParameter("unit");//数据的单位 List sourceList = null;
	 * String driwSQL = ""; List<Map<String, Object>> returnList = new
	 * ArrayList<Map<String, Object>>(); try {
	 * 
	 * if(StringUtils.isNotBlank(seqId)&&StringUtils.isNotBlank(detectId)
	 * &&StringUtils.isNotBlank(dataType)&&StringUtils.isNotBlank(nameFlag)) {
	 * String detailTabName = getTabNameByDetecSetId(detectId); Map<String,
	 * Object> result = new HashMap(); List<Object[]> data = new
	 * ArrayList<Object[]>(); List<Map<String, Object>> line = new
	 * ArrayList<Map<String, Object>>(); // 封装一条拆线 Map<String, Object> chart =
	 * new HashMap(); if(StringUtils.isNotBlank(dataType)) { // String
	 * endTimeTmp = DateUtil.getBigDate(startTime, endTime); // String
	 * startTimeTmp = DateUtil.getSmallDate(startTime, endTime);
	 * if(StringUtils.isNotBlank(startTime))
	 * {//&&StringUtils.isNotBlank(endTimeTmp) driwSQL = " select
	 * ds.Data_Check_Time_Digital, " +dataType + " from "+detailTabName+" ds
	 * " + " where ds.data_check_time >= to_date('"+startTime+"','yyyy-MM-dd
	 * HH24:mi')"+ " and ds.data_check_time <=
	 * to_date('"+startTime+"','yyyy-MM-dd HH24:mi')+1"+ " and ds.ifdescr='" +
	 * nameFlag + "'" + " and ds.seq_id=" + seqId + " order by
	 * ds.data_check_time asc"; }else { driwSQL = " select
	 * ds.Data_Check_Time_Digital, " +dataType + " from "+detailTabName+" ds
	 * " + " where ds.data_check_time >= sysdate - 1" + " and ds.ifdescr='" +
	 * nameFlag + "'" + " and ds.seq_id=" + seqId +
	 * " order by ds.data_check_time asc"; // endTime =
	 * DateUtil.getFormatDate(new Date()); startTime =
	 * DateUtil.getFormatDate(DateUtil.getBeforeHourDate(new Date(),24)); }
	 * System.out.println("driwSQL:" + driwSQL); sourceList =
	 * this.commonService.executeSQL(driwSQL); } Map<String, Object>
	 * resultStartTime = new HashMap(); resultStartTime.put("startTime",
	 * startTime); returnList.add(resultStartTime);
	 * 
	 * 2013-03-04 绘制展示图增加图断点判断 Edit by zg begin DetectionSetInfo dsi =
	 * (DetectionSetInfo) this.commonService.get(DetectionSetInfo.class,
	 * Long.parseLong(detectId)); long gapTime = dsi.getCheckGap(); //单位： 分钟
	 * gapTime = gapTime*60*1000; //分钟 变毫秒 long pointTime = 0; 2013-03-04
	 * 绘制展示图增加图断点判断 Edit by zg end long previewTime = 0l; int previewFlag = 0;
	 * if (sourceList.size() > 0) { for (int i = 0; i < sourceList.size(); i++)
	 * { Object[] row = (Object[]) sourceList.get(i); Object[] tmp = new
	 * Object[2]; 2013-03-04 绘制展示图增加图断点判断 Edit by zg begin long rowTime =
	 * row[0]==null?null:Long.parseLong(row[0].toString());
	 * 
	 * if(pointTime == 0){ pointTime = rowTime; }
	 * 
	 * if(pointTime + gapTime*2 <rowTime){ //即上一时间点数据到当前时间点数据时间间隔超过两个周期 //增加断
	 * Object[] tmp0 = new Object[]{pointTime + gapTime*2,null}; data.add(tmp0);
	 * }
	 * 
	 * pointTime = rowTime; tmp[0] = rowTime; // tmp[0] = (sdf.parse((String)
	 * row[0])).getTime(); 2013-03-04 绘制展示图增加图断点判断 Edit by zg end
	 * 
	 * //tmp[1] = ((BigDecimal) row[1]).intValue();
	 * 
	 * //如果是带宽，则除以1000000，不要小数，其它则要2位小数 if(row[1] instanceof BigDecimal) {
	 * if("ifspeed".equals(dataType)) { tmp[1] = (((BigDecimal)
	 * row[1]).divide(new BigDecimal(base*base))).setScale(0,
	 * BigDecimal.ROUND_UP); }else if("outoctetsspeed".equals(dataType) ||
	 * "inoctetsspeed".equals(dataType)){ tmp[1] = ((BigDecimal)
	 * row[1]).multiply(new BigDecimal(8)).setScale(0, BigDecimal.ROUND_UP);
	 * }else { tmp[1] = ((BigDecimal) row[1]).setScale(0, BigDecimal.ROUND_UP);
	 * } }else { tmp[1] = row[1]; }
	 * 
	 * data.add(tmp); } // 封装一条折线 chart.put("name", dataType); chart.put("data",
	 * data); line.add(chart);
	 * 
	 * result.put("lines", line); result.put("xtitle",
	 * ip+"_"+nameFlag+"："+dataDesc+unit+"统计图"); result.put("ytitle",
	 * dataDesc+unit); // result.put("startTime", startTime); //
	 * result.put("endTime", endTime); returnList.add(result); }
	 * 
	 * String jsonStr = JSONArray.fromObject(returnList).toString();
	 * System.out.println(jsonStr);
	 * this.getResponse().setCharacterEncoding("utf-8"); PrintWriter printWriter
	 * = this.getResponse().getWriter(); printWriter.write(jsonStr);
	 * printWriter.close(); printWriter = null; } // param =
	 * "&pid="+pid+"&isLeaf="+isLeaf+"&picId="+picId;//点击异常时，一定是端口页面收缩，
	 * 系统基础信息页面打开+" startTime"; String sysStatus = picId; // "&picId="+picId //
	 * diSystem.setSysStatus("<a
	 * href='"+this.getRequest().getContextPath()+"/detection/detectionWarning.
	 * do?action=query&entry=switch&ip="+ip+"&detectId="+detectId+"&seqId=
	 * "+seqId+param+"'>异常</a>"+sysStatus+""); } catch (Exception e) {
	 * logger.error("获取端口详细信息折线图 异常",e); } return null; }
	 */

	/**
	 * 端口状态配置
	 */
	public String toConfigPort() {
		try {

			System.out.println(nodeIp);
			if (!StringUtils.isBlank(nodeIp)) {
				String hql1 = "from NodeTable where nodeIp='" + nodeIp.trim() + "'";
				List<NodeTable> nodeListTmp = (List<NodeTable>) commonService.find(hql1);
				if (nodeListTmp != null && nodeListTmp.size() > 0) {
					NodeTable node = nodeListTmp.get(0);
					Long seqId = node == null ? null : node.getSeqId();
					if (seqId != null) {
						String hql = " from NodeFigureInfo  where seqid = " + seqId
								+ " and isLeaf=1 order by pid,showIndex ";
						page = commonService.findByPage(hql, pageNo, pageSize);
						nodeFigureInfoList = (List<NodeFigureInfo>) page.getResult();
					}
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "toConfigPort";
	}

	// public String toConfigPort()
	// {
	// try
	// {
	// System.out.println(seqId);
	// if (!StringUtils.isBlank(seqId))
	// {
	// String hql = " from NodeFigureInfo where seqid = " +
	// Long.parseLong(seqId) +"
	// and isLeaf=1 order by pid,showIndex ";
	// page = commonService.findByPage(hql, pageNo, pageSize);
	// nodeFigureInfoList = (List<NodeFigureInfo>) page.getResult();
	// }
	//
	// } catch (Exception e)
	// {
	// e.printStackTrace();
	// }
	// return "toConfigPort";
	// }

	/**
	 * 
	 * TODO 保存端口状态配置
	 * 
	 * @author jinshujuan Jun 6, 2013
	 * @version 1.0
	 * @return
	 */
	public String saveConfigPort() {
		try {
			// 单个保存
			if (!StringUtils.isBlank(index)) {
				int ind = NumberUtils.toInt(index);
				NodeFigureInfo nodeFigureInfo = batchNodeFigureInfo.get(ind);
				updatePortState(nodeFigureInfo);

			} else if (batchNodeFigureInfo != null) {
				for (NodeFigureInfo nodeFigureInfo : batchNodeFigureInfo) {
					updatePortState(nodeFigureInfo);
				}
			}
			toConfigPort();// 保存后，仍然要显示符合查询条件的列表

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "toConfigPort";
	}

	private void updatePortState(NodeFigureInfo nodeFigureInfo) {
		try {
			Long id = nodeFigureInfo.getId();
			Long state = nodeFigureInfo.getPortsetState();
			String hql = "update NodeFigureInfo set portsetState =" + state + " where id = " + id;
			System.out.println("hql:::::::" + hql);
			commonService.updateByHql(hql);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public Logger getLogger() {
		return logger;
	}

	public void setLogger(Logger logger) {
		this.logger = logger;
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

	public String getDetectId() {
		return detectId;
	}

	public void setDetectId(String detectId) {
		this.detectId = detectId;
	}

	public String getSvgName() {
		return svgName;
	}

	public void setSvgName(String svgName) {
		this.svgName = svgName;
	}

	public String getSeqId() {
		return seqId;
	}

	public void setSeqId(String seqId) {
		this.seqId = seqId;
	}

	public String getDeviceTypeCode() {
		return deviceTypeCode;
	}

	public void setDeviceTypeCode(String deviceTypeCode) {
		this.deviceTypeCode = deviceTypeCode;
	}

	public SwitchPortInfo getSwitchPortInfo() {
		return switchPortInfo;
	}

	public void setSwitchPortInfo(SwitchPortInfo switchPortInfo) {
		this.switchPortInfo = switchPortInfo;
	}

	public String getDataCheckTime() {
		return dataCheckTime;
	}

	public void setDataCheckTime(String dataCheckTime) {
		this.dataCheckTime = dataCheckTime;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getNameFlag() {
		return nameFlag;
	}

	public void setNameFlag(String nameFlag) {
		this.nameFlag = nameFlag;
	}

	public DiSystem getDiSystem() {
		return diSystem;
	}

	public void setDiSystem(DiSystem diSystem) {
		this.diSystem = diSystem;
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

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
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

	public String getSysStatus() {
		return sysStatus;
	}

	public void setSysStatus(String sysStatus) {
		this.sysStatus = sysStatus;
	}

	public boolean isSysStatusFlag() {
		return sysStatusFlag;
	}

	public void setSysStatusFlag(boolean sysStatusFlag) {
		this.sysStatusFlag = sysStatusFlag;
	}

	public String getDeviceBrandCode() {
		return deviceBrandCode;
	}

	public void setDeviceBrandCode(String deviceBrandCode) {
		this.deviceBrandCode = deviceBrandCode;
	}

	public String getDeviceBrandTypeCode() {
		return deviceBrandTypeCode;
	}

	public void setDeviceBrandTypeCode(String deviceBrandTypeCode) {
		this.deviceBrandTypeCode = deviceBrandTypeCode;
	}

	public List<DeviceInfo> getDeviceModelList() {
		return deviceModelList;
	}

	public void setDeviceModelList(List<DeviceInfo> deviceModelList) {
		this.deviceModelList = deviceModelList;
	}

	public DeviceInfo getRootDevice() {
		return rootDevice;
	}

	public void setRootDevice(DeviceInfo rootDevice) {
		this.rootDevice = rootDevice;
	}

	public List<DeviceInfo> getDevicePositionList() {
		return devicePositionList;
	}

	public void setDevicePositionList(List<DeviceInfo> devicePositionList) {
		this.devicePositionList = devicePositionList;
	}

	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
	}

	public List<DeviceInfo> getDeviceConfigList() {
		return deviceConfigList;
	}

	public void setDeviceConfigList(List<DeviceInfo> deviceConfigList) {
		this.deviceConfigList = deviceConfigList;
	}

	public static int getBase() {
		return base;
	}

	public List<Long> getDevShowLevelList() {
		return devShowLevelList;
	}

	public void setDevShowLevelList(List<Long> devShowLevelList) {
		this.devShowLevelList = devShowLevelList;
	}

	public List<String> getSwitcheNodeList() {
		return switcheNodeList;
	}

	public void setSwitcheNodeList(List<String> switcheNodeList) {
		this.switcheNodeList = switcheNodeList;
	}

	public List<DeviceTypeInfo> getDeviceBrandTypeList() {
		return deviceBrandTypeList;
	}

	public void setDeviceBrandTypeList(List<DeviceTypeInfo> deviceBrandTypeList) {
		this.deviceBrandTypeList = deviceBrandTypeList;
	}

	public List<Object[]> getDeviceBrandList() {
		return deviceBrandList;
	}

	public void setDeviceBrandList(List<Object[]> deviceBrandList) {
		this.deviceBrandList = deviceBrandList;
	}

	public Map<String, SwitchPortInfo> getSwitchPortMap() {
		return switchPortMap;
	}

	public void setSwitchPortMap(Map<String, SwitchPortInfo> switchPortMap) {
		this.switchPortMap = switchPortMap;
	}

	public int getMaxDevNum() {
		return maxDevNum;
	}

	public void setMaxDevNum(int maxDevNum) {
		this.maxDevNum = maxDevNum;
	}

	public long getRootDeviceX() {
		return rootDeviceX;
	}

	public void setRootDeviceX(long rootDeviceX) {
		this.rootDeviceX = rootDeviceX;
	}

	public long getRootDeviceY() {
		return rootDeviceY;
	}

	public void setRootDeviceY(long rootDeviceY) {
		this.rootDeviceY = rootDeviceY;
	}

	public long getDeviceGap() {
		return deviceGap;
	}

	public void setDeviceGap(long deviceGap) {
		this.deviceGap = deviceGap;
	}

	public String getSortByXorY() {
		return sortByXorY;
	}

	public void setSortByXorY(String sortByXorY) {
		this.sortByXorY = sortByXorY;
	}

	public String getDevHeightSum() {
		return devHeightSum;
	}

	public void setDevHeightSum(String devHeightSum) {
		this.devHeightSum = devHeightSum;
	}

	public String getDevWidthSum() {
		return devWidthSum;
	}

	public void setDevWidthSum(String devWidthSum) {
		this.devWidthSum = devWidthSum;
	}

	public long getDeviceShowGap() {
		return deviceShowGap;
	}

	public void setDeviceShowGap(long deviceShowGap) {
		this.deviceShowGap = deviceShowGap;
	}

	public int getDevNum() {
		return devNum;
	}

	public void setDevNum(int devNum) {
		this.devNum = devNum;
	}

	public String getDevScrollHeight() {
		return devScrollHeight;
	}

	public void setDevScrollHeight(String devScrollHeight) {
		this.devScrollHeight = devScrollHeight;
	}

	public String getDevScrollWidth() {
		return devScrollWidth;
	}

	public void setDevScrollWidth(String devScrollWidth) {
		this.devScrollWidth = devScrollWidth;
	}

	public String getBodyScrollTop() {
		return bodyScrollTop;
	}

	public void setBodyScrollTop(String bodyScrollTop) {
		this.bodyScrollTop = bodyScrollTop;
	}

	public List<OptionTable> getOptionList() {
		return optionList;
	}

	public void setOptionList(List<OptionTable> optionList) {
		this.optionList = optionList;
	}

	public String getNetworElementType() {
		return networElementType;
	}

	public void setNetworElementType(String networElementType) {
		this.networElementType = networElementType;
	}

	public String getModelSortByXorY() {
		return modelSortByXorY;
	}

	public void setModelSortByXorY(String modelSortByXorY) {
		this.modelSortByXorY = modelSortByXorY;
	}

	public List<NodeFigureInfo> getNodeFigureInfoList() {
		return nodeFigureInfoList;
	}

	public void setNodeFigureInfoList(List<NodeFigureInfo> nodeFigureInfoList) {
		this.nodeFigureInfoList = nodeFigureInfoList;
	}

	public String getIndex() {
		return index;
	}

	public void setIndex(String index) {
		this.index = index;
	}

	public List<NodeFigureInfo> getBatchNodeFigureInfo() {
		return batchNodeFigureInfo;
	}

	public void setBatchNodeFigureInfo(List<NodeFigureInfo> batchNodeFigureInfo) {
		this.batchNodeFigureInfo = batchNodeFigureInfo;
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

	public String getNodeIp() {
		return nodeIp;
	}

	public void setNodeIp(String nodeIp) {
		this.nodeIp = nodeIp;
	}

	public String getStartTimeXt() {
		return startTimeXt;
	}

	public void setStartTimeXt(String startTimeXt) {
		this.startTimeXt = startTimeXt;
	}

	public String getClickPortId() {
		return clickPortId;
	}

	public void setClickPortId(String clickPortId) {
		this.clickPortId = clickPortId;
	}

	// public String getEndTime()
	// {
	// return endTime;
	// }
	//
	//
	// public void setEndTime(String endTime)
	// {
	// this.endTime = endTime;
	// }

}