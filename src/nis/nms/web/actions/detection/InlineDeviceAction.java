package nis.nms.web.actions.detection;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;
import org.hibernate.SQLQuery;

import com.nis.util.StringUtil;

import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Constant;
import nis.nms.util.Page;

@Results({ 
	@Result(name = "inlineInfoList", value = "/page/detection/monitorData/inlineInfoList.jsp")
})
@SuppressWarnings("all")
public class InlineDeviceAction extends BaseAction{
	private static final Logger logger = Logger.getLogger(InlineDeviceAction.class);
	private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	private int pageNo = 1;
	private int pageSize = this.getDefaultPageSize(); // 每页显示的记录条数
	private Page page;
	private String action;
	private String nodeIp;//查询条件：节点ip
	private String addrCode; //查询条件：地域编码
	private String ispKeyCode;//查询条件：运营商唯一标识
	
	@Override
	public String executeAction() throws Exception {
		String result = "inlineInfoList";
		//查询运营商等信息
		if("query".equalsIgnoreCase(this.action)) {
			result =  inlineInfoList();
		}
		return result;
	}

	/**
	 * 查询 串联设备运营商等信息
	 * @return
	 * @throws Exception 
	 */
	public String inlineInfoList() throws Exception {
		Long systemID = this.getSystemID();//当前登录的 视图 id
		//运营商信息
		String sql = "select * from sys_isp_info order by id";
		List ispList = commonService.executeSQLMap(sql);
		this.getRequest().setAttribute("ispList", ispList);
		//地域信息
		sql = "select * from sys_addr_info order by id";
		List addrList = commonService.executeSQLMap(sql);
		this.getRequest().setAttribute("addrList", addrList);
		
		StringBuilder sbSql = new StringBuilder();
		sql = "SELECT " +
				"	sdi.*,  sii.isp_key_name,  sai.addr_name, nt.*  " +
				" FROM " +
				"	sys_device_info sdi " +
				"	LEFT JOIN sys_isp_info sii ON sdi.isp = sii.isp_key_code " +
				"	LEFT JOIN sys_addr_info sai ON sdi.entrance_id = sai.addr_code " +
				"	LEFT JOIN ( SELECT node_ip, seq_id FROM node_table GROUP BY node_ip ) nt ON nt.node_ip = sdi.ip_addr " +
				"where sdi.status != 0 ";
		sbSql.append(sql);
		if(systemID != -1) {
			sbSql.append(" and sdi.system_id = ").append(systemID);
		}
		if(!StringUtil.isBlank(nodeIp)) {
			sbSql.append(" and sdi.ip_addr like '%").append(nodeIp).append("%' ");
		}
		if(!StringUtil.isBlank(addrCode)) {
			sbSql.append(" and sdi.entrance_id = ").append(addrCode);
		}
		if(!StringUtil.isBlank(ispKeyCode)) {
			sbSql.append(" and sdi.isp = ").append(ispKeyCode);
		}
		sbSql.append(" order by sdi.ip_addr,sdi.link_id");
		Page devicePage = commonService.findByPageForSqlMap(sbSql.toString(), pageNo, pageSize);
		//List<Map<String,Object>> deviceList = commonService.executeSQLMap();
		
		//查询所有的 串联设备 bypass 状态
		sql = "SELECT " +
			"	dp.*  " +
			"FROM " +
			"	di_propmstatus dp " +
			"	LEFT JOIN detection_info_new din ON dp.detection_info_id = din.DETECTION_INFO_ID " +
			"	LEFT JOIN node_table nt ON nt.seq_id = din.SEQ_ID  " +
			"WHERE " +
			"	nt.network_element_type = 1  " +
			"	AND node_type = 1  " +
			"	AND node_state = 0 " ;
		sbSql.setLength(0);
		sbSql.append(sql);
		if(systemID != -1) {
			sbSql.append(" and nt.system_id = ").append(systemID);
		}
		List<Map<String,Object>> byPassList = commonService.executeSQLMap(sbSql.toString());
		Map<String,Map<String,Object>> byPassMap = new HashMap<String, Map<String,Object>>(byPassList.size());
		for(Map<String,Object> map : byPassList) {
			String seqId = map.get("SEQ_ID")+"";
			String status = map.get("propmStatus")+"";
			String index = map.get("popmIndex")+"";
			byPassMap.put(seqId+index, map);
		}
		
		//查询所有的串联设备的 端口数据
		sql = "SELECT " +
				"	dp.*  " +
				"FROM " +
				"	di_switchport dp " +
				"	LEFT JOIN detection_info_new din ON dp.detection_info_id = din.DETECTION_INFO_ID " +
				"	LEFT JOIN node_table nt ON nt.seq_id = din.SEQ_ID  " +
				"WHERE " +
				"	nt.network_element_type = 1  " +
				"	AND node_type = 1  " +
				"	AND node_state = 0 " ;
		sbSql.setLength(0);
		sbSql.append(sql);
		if(systemID != -1) {
			sbSql.append(" and nt.system_id = ").append(systemID);
		}
		List<Map<String,Object>> portList = commonService.executeSQLMap(sbSql.toString());
		Map<String,Map<String,Object>> portMap = new HashMap<String, Map<String,Object>>(byPassList.size());
		for(Map<String,Object> map : portList) {
			String seqId = map.get("SEQ_ID")+"";
			String ifdescr = map.get("IFDESCR")+"";
			portMap.put(seqId+ifdescr, map);
		}
		
		List<Map<String,Object>> deviceList = (List<Map<String,Object>>)devicePage.getResult();
		for(Map<String,Object> device : deviceList) {
			String seqId = device.get("seq_id")+"";
			String linkIndex = device.get("link_id")+"";
			String portName = device.get("port_name")+"";
			
			Map<String, Object> map = byPassMap.get(seqId+linkIndex);
			if(map != null) {
				String s = map.get("propmStatus")+"";
				s = (s == null ? "No Data": (s.equals("1") ? "pass" : "bypass"));
				device.put("propmStatus", s);
			}
			if(!StringUtil.isBlank(portName)) {
				String[] portArr = portName.split(",");
				long inoctetsspeed = 0l;//输入
				long inpktsspeed = 0l;//输入包速率
				String checkTime = null;
				for(String port : portArr) {
					Map<String, Object> p = portMap.get(seqId+ port);
					if(p != null) {
						Object inOct = p.get("INOCTETSSPEED");
						Object inPac = p.get("INPKTSSPEED");
						if(inOct != null) {
							inoctetsspeed += Long.valueOf(inOct+"");
						}
						if(inPac != null) {
							inpktsspeed += Long.valueOf(inPac+"");
						}
						if(checkTime == null) {
							checkTime = p.get("DATA_CHECK_TIME_DIGITAL") +"";
							Date date = new Date(Long.valueOf(checkTime));
							checkTime = sdf.format(date);
						}
					}
				}
				
				device.put("INOCTETSSPEED", String.format("%.2f", inoctetsspeed/1024.0/1024.0) +" Mbps");
				device.put("INPKTSSPEED", inpktsspeed +" pps");
				device.put("DATA_CHECK_TIME",checkTime);
			}
		}
		this.getRequest().setAttribute("page", devicePage);
		return "inlineInfoList";
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

	public String getNodeIp() {
		return nodeIp;
	}

	public void setNodeIp(String nodeIp) {
		this.nodeIp = nodeIp;
	}

	public String getAddrCode() {
		return addrCode;
	}

	public void setAddrCode(String addrCode) {
		this.addrCode = addrCode;
	}

	public String getIspKeyCode() {
		return ispKeyCode;
	}

	public void setIspKeyCode(String ispKeyCode) {
		this.ispKeyCode = ispKeyCode;
	}

	
}
