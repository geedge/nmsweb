package nis.nms.web.actions.nodePosition;                        
import java.io.File;
import java.io.FileInputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import nis.nms.domains.NodeBoxTable;
import nis.nms.domains.NodeBoxTableVo;
import nis.nms.domains.NodeLatticeTable;
import nis.nms.domains.NodeRoomLatticeTable;
import nis.nms.domains.NodeRoomTable;
import nis.nms.domains.NodeTable;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.ExportUtils;
import nis.nms.util.Page;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;

import com.nis.util.StringUtil;


@SuppressWarnings("unchecked")
@Results( { 
	@Result(name="queryBoxSetInfo", value = "/page/show/nodeBox/boxInfoList.jsp"),
	@Result(name="addBoxInfo", value = "/page/show/nodeBox/addBoxInfo.jsp"),
	@Result(name="updateBoxInfo", value = "/page/show/nodeBox/updateBoxInfo.jsp"),
	@Result(name="detailBoxInfo", value = "/page/show/nodeBox/detailBoxInfo.jsp"),
	
	@Result(name="error", value ="/error.jsp"),
	@Result(name = "showError", value = "/page/show/nodeBox/showImportError.jsp")
})

/**
 * 监测设置相关操作
 */
public class BoxSetAction extends BaseAction {
	private Logger logger = Logger.getLogger(BoxSetAction.class);
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	private int pageNo = 1;
	private int pageSize =this.getDefaultPageSize();		//每页显示的记录条数
	private Page page;
	private String action;
	private List<NodeBoxTable> nodeBoxList;
	private NodeBoxTable nodeBox;
	private Long[] ids;
	private String ispnNum;
	private String descinfo;
	
	private String fromWhere;
	private String isComplete;	
	
	private String roomid;
	
	private String roomIspn;

	public String getRoomIspn() {
		return roomIspn;
	}

	public void setRoomIspn(String roomIspn) {
		this.roomIspn = roomIspn;
	}

	public String getRoomid() {
		return roomid;
	}

	public void setRoomid(String roomid) {
		this.roomid = roomid;
	}

	// 导入节点文件
	private File myFile;
	private String myFileFileName;

	@Override
	public String executeAction() throws Exception {
		String resultpage = "";
		this.getRequest().setAttribute("fromWhere", fromWhere);
		if("query".equals(this.action)){
			resultpage = this.queryBoxInfo();
		}else if("openAdd".equals(this.action)){
			this.getRoomIspnOption();
			resultpage = "addBoxInfo";
		}else if("doAdd".equals(this.action)){
			this.getRequest().setAttribute("fromWhere", fromWhere);
			resultpage = this.addBoxInfo();
		}else if("openUpdate".equals(this.action)){
			resultpage = this.openUpdBox();
		}else if("doUpdate".equals(this.action)){
			resultpage = this.doUpdBox();
		}else if("del".equals(this.action)){
			resultpage = this.delBoxInfo();
		}else if ("downloadExample".equals(this.action)) {// 导出模板  程辉 2013-4-27新增
			resultpage = this.downloadExample();
		}else if ("importXls".equals(this.action)) {// 导入  程辉 2013-4-27新增
			resultpage = this.importXls();
		}else if ("emportCurrentXls".equals(this.action)) {// 导出当前页  程辉 2013-5-15新增
			resultpage = this.emportCurrentXls();
		}else if ("emportAllXls".equals(this.action)) {// 导出全部  程辉 2013-5-15新增
			resultpage = this.emportAllXls();
		}else if("addCheck".equals(this.action)){
			addCheck();
			return null;
		}else if("updateCheck".equals(this.action)){
			updateCheck();
			return null;
		}else  {
			resultpage = this.queryBoxInfo();
		}
		return resultpage;
	}
	
	private void getRoomIspnOption() {
		if(StringUtil.isBlank(roomIspn)){
			String hql = "from NodeRoomTable order by roomId desc";
			try {
				List<NodeRoomTable> nodeRoomList = commonService.find(hql);
				this.getRequest().setAttribute("nodeRoomList",nodeRoomList);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public String queryBoxInfo(){
		try {
			isComplete = this.getRequest().getParameter("isComplete");			
			String roomspan="";
			if(roomid!=null&&!roomid.equals("")){
				List roomspanlist = this.commonService.find("select roomIspn from NodeRoomTable where roomId="+roomid);
				if(roomspanlist!=null&&roomspanlist.size()>0){
					roomspan=roomspanlist.get(0).toString();
				}
			}
			
			String hql = "from NodeBoxTable where 1=1";
			if(ispnNum!=null && !"".equals(ispnNum)){
				hql += " and ispn like '%" + ispnNum.trim() + "%'";
			}
			if(roomspan!=null && !"".equals(roomspan)){
				hql += " and roomIspn = '" + roomspan + "'";
			}
			hql += " order by ispn asc";
			page = this.commonService.findByPage(hql, pageNo, pageSize);
			nodeBoxList = (List<NodeBoxTable>)page.getResult(); 
			
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			this.outHtmlString("<script>alert('i18n_BoxSetAction.queryBoxInfo.queryBoxFaild_n81i');history.back();</script>");
			return null;
		}
		
		return "queryBoxSetInfo";
		
	}
	
	public void addCheck(){
		List list = null;
		try {
			list = this.commonService.find("from NodeBoxTable where ispn=?",nodeBox.getIspn());
			if(list!=null && list.size()>0){
				this.outString("exist");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("机柜管理添加校验失败！",e);
			this.outString("exception");
			return ;
		}
		this.outString("success");
	}
	
	/**
	 * 新增机柜：初始化机柜位置表，机柜是多少U位就插入多少条数据，初始化时SEQID为空（即表示未存放节点机）
	 * 	2012-9-14 添加对所属机房信息的维护，更新机房位置表
	 * @return
	 */
	public String addBoxInfo(){
		List list = null;
		try {
			commonService.beginTransaction();
			//判断数据是否存在
			/*list = this.commonService.find("from NodeBoxTable where ispn=?",nodeBox.getIspn());
			if(list!=null && list.size()>0){
				this.outHtmlString("<script>alert('记录已存在，请重新输入！');history.back();</script>");
				return null;
			}*/
			
			this.commonService.save(nodeBox);
			
			//-----初始化机柜位置表
			List<Object> list2 = new ArrayList<Object>();
			for(long i=1; i<=nodeBox.getBoxUType(); i++){
				NodeLatticeTable nlt = new NodeLatticeTable();
				nlt.setNodeBoxId(nodeBox.getNodeBoxId());
				nlt.setNodeposition(i);
				list2.add(nlt);
			}
			this.commonService.saveOrUpdate(list2);
			
			//------机房位置维护
			this.commonService
					.updateByHql(
							"update NodeRoomLatticeTable set nodeBoxId=?"
									+ " where roomId in(select roomId from NodeRoomTable where roomIspn=?) and latticeRowPosition=? and latticeColPosition=?",
							nodeBox.getNodeBoxId(), nodeBox.getRoomIspn(),
							nodeBox.getRoomRowPosition(), nodeBox
									.getRoomColPosition());
			
			//记录用户操作用于设置向导
			if(fromWhere!=null && !"".equals(fromWhere)){
				if(fromWhere.equals("formGuide")){
					String str ="<script type=\"text/javascript\">alert('i18n_BoxSetAction.queryBoxInfo.success_n81i');this.location='boxSet.do?action=query&isComplete=0&roomid="+roomid+"&roomIspn="+roomIspn+"'</script>";
					outHtmlString(str);
				}
			}else{
				String str= "<script type=\"text/javascript\">alert('i18n_BoxSetAction.queryBoxInfo.success_n81i');this.location='boxSet.do?action=query&roomIspn="+roomIspn+"&roomid="+roomid+"'</script>";
				outHtmlString(str);
			}
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			logger.error(e.getStackTrace());
			this.outHtmlString("<script>alert('i18n_BoxSetAction.queryBoxInfo.addBoxFaild_n81i');history.back();</script>");
			return null;
		}
		return null;
	}
	
	public String openUpdBox(){
		try {
			if(ids!=null && ids.length>0){
				List list = this.commonService.find(
						"from NodeBoxTable where nodeBoxId=?", ids[0]);
				if(list!=null && list.size()>0){
					nodeBox = (NodeBoxTable)list.get(0);
				}
			}
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			this.outHtmlString("<script>alert('i18n_BoxSetAction.queryBoxInfo.toUpdateViewFaild_n81i');history.back();</script>");
			return null;
		}
		
		return "updateBoxInfo";
		
	}
	
	public void updateCheck(){
		List list;
		try {
			list = this.commonService.find("from NodeBoxTable where ispn='"+nodeBox.getIspn()+"' and nodeBoxId <> "+nodeBox.getNodeBoxId());
			if (list != null && list.size() > 0) {
				this.outString(getI18nText("i18n_BoxSetAction.queryBoxInfo.recordExists_n81i"));
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("机柜管理修改异常！",e);
			this.outString("exception");
		}
		this.outString("success");
	}
	
	/**
	 * 修改机柜：
	 * 1、机柜U位变更范围若已存放了节点机，则不允许修改  
	 * 2、机柜U位若是增大，则直接在位置表中插入增大的记录；机柜U位若是减小，减小的范围若未放置节点，则删除位置表记录
	 * @return
	 */
	public String doUpdBox(){
		try {
			commonService.beginTransaction();
			List list =null;
			/*List list = this.commonService.find("from NodeBoxTable where ispn='"+nodeBox.getIspn()+"' and nodeBoxId <> "+nodeBox.getNodeBoxId());
			if (list != null && list.size() > 0) {
				this.outHtmlString("<script>alert('记录已存在，请重新输入！');history.back();</script>");
				return null;
			}*/
			String historyBack = "boxSet!executeAction.do?action=openUpdate"
				+ "&ids=" + nodeBox.getNodeBoxId()
				+ "&pageNo=" + pageNo + "&pageSize=" + pageSize;
			
			NodeBoxTable nbt = (NodeBoxTable) this.commonService.get(
					NodeBoxTable.class, nodeBox.getNodeBoxId());
			nbt.setDescinfo(nodeBox.getDescinfo());
			nbt.setRoomIspn(nodeBox.getRoomIspn());
			nbt.setRoomRowPosition(nodeBox.getRoomRowPosition());
			nbt.setRoomColPosition(nodeBox.getRoomColPosition());
			
			if(!nbt.getIspn().equals(nodeBox.getIspn())) { // 机柜编号修改，级联修改节点表
				String sql = "select count(1) from node_box_table nbt"
						+" where nbt.ispn ='" + nodeBox.getIspn().trim() + "'";
				BigDecimal result = (BigDecimal) this.commonService.createSQLQuery(sql).list().get(0);
				if(result.compareTo(BigDecimal.ZERO) > 0){
					this.outHtmlString("<script>alert('i18n_BoxSetAction.queryBoxInfo.boxIdExists_n81i');this.location='" + historyBack + "';</script>");
					return null;
				} else {
					String oldIspn = nbt.getIspn();
					nbt.setIspn(nodeBox.getIspn());
					sql = "update node_table set NODE_BOX_ISPN = '" + nodeBox.getIspn().trim() + "'"
						+ " where NODE_BOX_ISPN = '" + oldIspn + "'";
					this.commonService.updateBySql(sql);
				}
			}
			
			if(nbt.getBoxUType()==null){//更新时为了兼容以前的旧数据
				nbt.setBoxUType(0l);
			}
			//-----维护机柜位置表
			if(nodeBox.getBoxUType()>nbt.getBoxUType()){//增大机柜U位，直接添加机柜位置表
				List<Object> list2 = new ArrayList<Object>();
				for(long i=(nbt.getBoxUType()+1); i<=nodeBox.getBoxUType(); i++){
					NodeLatticeTable nlt = new NodeLatticeTable();
					nlt.setNodeBoxId(nodeBox.getNodeBoxId());
					nlt.setNodeposition(i);
					list2.add(nlt);
				}
				this.commonService.saveOrUpdate(list2);
			}else if(nodeBox.getBoxUType()<nbt.getBoxUType()){//减小机柜U位，检查减小的部分是否存放了节点机
				String hql = "from NodeLatticeTable where nodeBoxId=? and nodeSeqId is not null and nodeposition>?";
				list = this.commonService.find(hql,nodeBox.getNodeBoxId(),nodeBox.getBoxUType());
				if (list != null && list.size() > 0) {
					this.outHtmlString("<script>alert('i18n_BoxSetAction.queryBoxInfo.hadUpdateNode_n81i');this.location='" + historyBack + "';</script>");
					return null;
				}
				hql = "delete from NodeLatticeTable where nodeBoxId=? and nodeposition>?";
				this.commonService.delete(hql,nodeBox.getNodeBoxId(),nodeBox.getBoxUType());
			}
			//设置U位并更新
			nbt.setBoxUType(nodeBox.getBoxUType());
			
			//------维护机房位置
			String hql = "update NodeRoomLatticeTable set nodeBoxId=null where nodeBoxId=?";
			this.commonService.updateByHql(hql, nodeBox.getNodeBoxId());
			hql = "update NodeRoomLatticeTable set nodeBoxId=?" +
					" where roomId in(select roomId from NodeRoomTable where roomIspn=?)" +
					" and latticeRowPosition=? and latticeColPosition=?";
			this.commonService.updateByHql(hql, nodeBox.getNodeBoxId(), nodeBox
					.getRoomIspn(), nodeBox.getRoomRowPosition(), nodeBox
					.getRoomColPosition());
			
			this.commonService.update(nbt);
			this.getRequest().setAttribute("MSG", 1);
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			logger.error(e.getStackTrace());
			this.outHtmlString("<script>alert('i18n_BoxSetAction.queryBoxInfo.updateFaild_n81i');history.back();</script>");
			return null;
		}
		
		return this.queryBoxInfo();
		
	}
	
	public String delBoxInfo(){
		try {
			if(ids!=null && ids.length>0){
				commonService.beginTransaction();
				for(Long id : ids){
					List list = this.commonService.find(
							"from NodeLatticeTable where nodeBoxId=? and nodeSeqId is not null", id);
					if(list!=null && list.size()>0){
						NodeBoxTable nrt = (NodeBoxTable)this.commonService.get(NodeBoxTable.class, id);
						this.outHtmlString("<script>alert('i18n_BoxSetAction.queryBoxInfo.hadUpdateNodeToDelete1_n81i[" +nrt.getIspn()+ "]i18n_BoxSetAction.queryBoxInfo.hadUpdateNodeToDelete2_n81i');history.back();</script>");
						return null;
					}
				}
				//清空node_room_lattice_table标识ID
				this.commonService.updateBatchBySql("update node_room_lattice_table set node_box_id=null where node_box_id=?", Arrays.asList(ids));
				//删除记录
				this.commonService.updateBatchBySql("delete from NODE_BOX_TABLE where BOX_ID=?", Arrays.asList(ids));
				outHtmlString("<script type=\"text/javascript\">alert('i18n_BoxSetAction.queryBoxInfo.success_n81i');this.location='boxSet.do?action=query&pageNo="+pageNo+"&pageSize="+pageSize+"&roomid="+roomid+"&roomIspn="+roomIspn+"'</script>");
				commonService.commit();
			}
		} catch (Exception e) {
			commonService.rollback();
			logger.error(e.getStackTrace());
			this.outHtmlString("<script>alert('i18n_BoxSetAction.queryBoxInfo.deleteFaild_n81i');history.back();</script>");
			return null;
		}
		
		return this.queryBoxInfo();
	}
	
	/**
	 * Ajax请求，获取机房的空闲行
	 * @return
	 */
	public String getRoomFreeRows(){
		try {
			String roomIspn = this.getRequest().getParameter("roomIspn");
			String boxId = this.getRequest().getParameter("boxId");
			String hql = "select distinct latticeRowPosition from NodeRoomLatticeTable" +
					" where roomId in (select roomId from NodeRoomTable where roomIspn=?)";
			if(boxId!=null){
				hql += " and (nodeBoxId is null or nodeBoxId = " +boxId+ ")";
			}else{
				hql += " and nodeBoxId is null";
			}
			hql += " order by latticeRowPosition asc";
			List<Long> allList = (List<Long>)this.commonService.find(hql, roomIspn);
			System.out.println("-------- room free rows: " + Arrays.toString(allList.toArray()));
			this.outJsonArray(allList);
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * Ajax请求，获取机房指定行的空闲列
	 * @return
	 */
	public String getRoomFreeCols(){
		try {
			String rowNumStr = this.getRequest().getParameter("rowNum");
			String roomIspn = this.getRequest().getParameter("roomIspn");
			String boxId = this.getRequest().getParameter("boxId");
			Long rowNum = 0l;
			if(rowNumStr!=null && !"".equals(rowNumStr)){
				rowNum = Long.parseLong(rowNumStr);
			}
			String hql = "select distinct latticeColPosition from NodeRoomLatticeTable" +
				" where roomId in (select roomId from NodeRoomTable where roomIspn=?)";
			if(boxId!=null){
				hql += " and (nodeBoxId is null or nodeBoxId = " +boxId+ ")";
			}else{
				hql += " and nodeBoxId is null";
			}
			hql += "  and latticeRowPosition=? order by latticeColPosition asc";
			List<Long> allList = (List<Long>)this.commonService.find(hql, roomIspn,rowNum);
			System.out.println("--------room free cols: " + Arrays.toString(allList.toArray()));
			this.outJsonArray(allList);
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * Ajax请求，获取所有机柜编号
	 * @return
	 */
	public String getAllBoxsIspn(){
		try {
			String hql = "select distinct ispn from NodeBoxTable order by ispn ";
			List<Long> allList = (List<Long>)this.commonService.find(hql);
			String getIspn = "";
			for (int i = 0; i < allList.size(); i++) {
				if (allList.get(i) != null && !"".equals(allList.get(i))) {
					getIspn += allList.get(i) + ";";
				}
			}
			outString(getIspn);
			System.out.println("--------room free cols: " + Arrays.toString(allList.toArray()));
			//this.outJsonArray(allList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
		return null;
	}
	
	// 模板下载   程辉 2013-4-27新增
	public String downloadExample() {
		try {
			Page p = this.commonService.findByPage("from NodeBoxTable", 1, 3);
			List<NodeTable> st = (List<NodeTable>) p.getResult();
			String[] title = { getI18nText("i18n_BoxSetAction.queryBoxInfo.title_n81i"), 
								getI18nText("i18n_BoxSetAction.queryBoxInfo.title_n81i"),
								getI18nText("i18n_BoxSetAction.queryBoxInfo.title_n81i"),
								getI18nText("i18n_BoxSetAction.queryBoxInfo.title_n81i"),
								getI18nText("i18n_BoxSetAction.queryBoxInfo.title_n81i"),
								getI18nText("i18n_BoxSetAction.queryBoxInfo.title_n81i")};
			
			String[] colu = { "ispn", "boxUType","roomIspn", "roomRowPosition",
							  "roomColPosition","descinfo"};
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(getI18nText("i18n_BoxSetAction.queryBoxInfo.boxBaseInfo_n81i"), st, title, colu,"downloadExample");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
		return null;
	}

	// 导入 程辉 2013-4-27新增
	public String importXls() {
		String errorInfo = "";
		try {
			List<NodeBoxTableVo> list = new ArrayList<NodeBoxTableVo>();

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
				NodeBoxTableVo nodeVo = new NodeBoxTableVo();
				Row row = sheet.getRow(i);
				Cell cell_1 = row.getCell((short) 0);
				Cell cell_2 = row.getCell((short) 1);
				Cell cell_3 = row.getCell((short) 2);
				Cell cell_4 = row.getCell((short) 3);
				Cell cell_5 = row.getCell((short) 4);
				Cell cell_6 = row.getCell((short) 5);
				if ((null == cell_1 || 3 == cell_1.getCellType())
						&& (null == cell_2 || 3 == cell_2.getCellType())
						&& (null == cell_3 || 3 == cell_3.getCellType())
						&& (null == cell_4 || 3 == cell_4.getCellType())
						&& (null == cell_5 || 3 == cell_5.getCellType())
						&& (null == cell_6 || 3 == cell_6.getCellType())) {
					sum--;
				}else {
					// 编号
					if (null == cell_1) {
						errorInfo +=  getI18nText("i18n_BoxSetAction.queryBoxInfo.errorInfo1_n81i",i+"");
					} else if (cell_1.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_1.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_BoxSetAction.queryBoxInfo.errorInfo1_n81i",i+"");
						} else {
							String ispn = cell_1.getStringCellValue().trim();
							nodeVo.setIspn(ispn);
						}
					} else {
						errorInfo +=  getI18nText("i18n_BoxSetAction.queryBoxInfo.errorInfo2_n81i",i+"");
					}
					// U位
					if (null == cell_2) {
						errorInfo +=  getI18nText("i18n_BoxSetAction.queryBoxInfo.errorInfo3_n81i",i+"");
					} else if (cell_2.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						long boxUType = (long) cell_2.getNumericCellValue();
						nodeVo.setBoxUType(boxUType);
					} else {
						errorInfo +=  getI18nText("i18n_BoxSetAction.queryBoxInfo.errorInfo4_n81i",i+"");
					}

					// 机房编号
					if (null == cell_3) {
						errorInfo +=  getI18nText("i18n_BoxSetAction.queryBoxInfo.errorInfo5_n81i",i+"");
					} else if (cell_3.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_3.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_BoxSetAction.queryBoxInfo.errorInfo5_n81i",i+"");
						} else {
							String roomIspn = cell_3.getStringCellValue()
									.trim();
							nodeVo.setRoomIspn(roomIspn);
						}
					} else {
						errorInfo +=  getI18nText("i18n_BoxSetAction.queryBoxInfo.errorInfo6_n81i",i+"");
					}

					// 机房行号
					if (null == cell_4) {
						errorInfo +=  getI18nText("i18n_BoxSetAction.queryBoxInfo.errorInfo7_n81i",i+"");
					} else if (cell_4.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						long roomRowPosition = (long) cell_4
								.getNumericCellValue();
						nodeVo.setRoomRowPosition(roomRowPosition);
					} else {
						errorInfo +=  getI18nText("i18n_BoxSetAction.queryBoxInfo.errorInfo8_n81i",i+"");
					}

					// 机房列号
					if (null == cell_5) {
						errorInfo +=  getI18nText("i18n_BoxSetAction.queryBoxInfo.errorInfo9_n81i",i+"");
					} else if (cell_5.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						long roomColPosition = (long) cell_5
								.getNumericCellValue();
						nodeVo.setRoomColPosition(roomColPosition);
					} else {
						errorInfo +=  getI18nText("i18n_BoxSetAction.queryBoxInfo.errorInfo10_n81i",i+"");
					}

					// 描述
					if (null == cell_6) {
						errorInfo +=  getI18nText("i18n_BoxSetAction.queryBoxInfo.errorInfo11_n81i",i+"");
					} else if (cell_6.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_6.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_BoxSetAction.queryBoxInfo.errorInfo11_n81i",i+"");
						} else {
							String descinfo = cell_6.getStringCellValue()
									.trim();
							nodeVo.setDescinfo(descinfo);
						}
					} else {
						errorInfo +=  getI18nText("i18n_BoxSetAction.queryBoxInfo.errorInfo12_n81i",i+"");
					}

					if ("".equals(errorInfo)) {// 保存节点
						errorInfo = this.saveNode(nodeVo);
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
//				this.getRequest().setAttribute("MSG", 1);
//				return this.queryBoxInfo();
				outHtmlString("<script type=\"text/javascript\">alert('i18n_BoxSetAction.queryBoxInfo.success_n81i');this.location='boxSet.do?action=query&roomid="+roomid+"'</script>");
				return null;
			} else if (sum == 0) {
				this
						.outHtmlString("<script>alert('i18n_BoxSetAction.queryBoxInfo.fileIsNull_n81i');history.back();</script>");
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
		return "showError";
	}

	private String saveNode(NodeBoxTableVo vo) {
		String desc = "";
		try {
			commonService.beginTransaction();
			// 保存节点信息
			NodeBoxTable nodeT = new NodeBoxTable();
			nodeT.setIspn(vo.getIspn());
			nodeT.setBoxUType(vo.getBoxUType());
			nodeT.setRoomIspn(vo.getRoomIspn());
			nodeT.setRoomRowPosition(vo.getRoomRowPosition());
			nodeT.setRoomColPosition(vo.getRoomColPosition());
			nodeT.setDescinfo(vo.getDescinfo());

			//判断机柜编号是否已存在
			List list = this.commonService.find(
					"from NodeBoxTable where ispn=?", nodeT.getIspn());
			if (list != null && list.size() > 0) {
				return getI18nText("i18n_BoxSetAction.queryBoxInfo.boxIdRepeat_n81i");
			}
			
			long roomID; //如果机房存在  接收机房id 
			List boxList = this.commonService
					.find("from NodeRoomTable where roomIspn='"
							+ nodeT.getRoomIspn() + "'");
			if (boxList == null || boxList.size() == 0) {
				return getI18nText("i18n_BoxSetAction.queryBoxInfo.noRoomExists_n81i");
			}else{
				roomID = ((NodeRoomTable)boxList.get(0)).getRoomId();
			}
			
			//查询机房是否存在  如果存在判断该位置是否已存在机柜
			List positionList = this.commonService.find("from NodeRoomLatticeTable where roomId=?" +
					" and latticeRowPosition=? and latticeColPosition=?", roomID,nodeT.getRoomRowPosition(),
					nodeT.getRoomColPosition());
			if (positionList == null || positionList.size() == 0) {
				return getI18nText("i18n_BoxSetAction.queryBoxInfo.roomPostionExists_n81i");
			} else if (((NodeRoomLatticeTable) positionList.get(0))
					.getNodeBoxId() != null) {
				return getI18nText("i18n_BoxSetAction.queryBoxInfo.roomHadBox_n81i");
			}
			this.commonService.save(nodeT);
			
			//-----初始化机柜位置表
			List<Object> list2 = new ArrayList<Object>();
			for(long i=1; i<=nodeT.getBoxUType(); i++){
				NodeLatticeTable nlt = new NodeLatticeTable();
				nlt.setNodeBoxId(nodeT.getNodeBoxId());
				nlt.setNodeposition(i);
				list2.add(nlt);
			}
			this.commonService.saveOrUpdate(list2);
			
			//------机房位置维护
			this.commonService
					.updateByHql(
							"update NodeRoomLatticeTable set nodeBoxId=?"
									+ " where roomId in(select roomId from NodeRoomTable where roomIspn=?) and latticeRowPosition=? and latticeColPosition=?",
									nodeT.getNodeBoxId(), nodeT.getRoomIspn(),
									nodeT.getRoomRowPosition(), nodeT
									.getRoomColPosition());
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			desc = getI18nText("i18n_BoxSetAction.queryBoxInfo.nodeInfoErr_n81i");
		}
		return desc;
	}
	
	// 当前页导出   程辉 2013-5-8新增
	public String emportCurrentXls() {
		try {
//			String hql = "from NodeBoxTable where 1=1";
//			if(ispnNum!=null && !"".equals(ispnNum)){
//				hql += " and ispn like '%" + ispnNum.trim() + "%'";
//			}
//			hql += " order by ispn asc";
//			page = this.commonService.findByPage(hql, pageNo, pageSize);
			
			String roomspan="";
			if(roomid!=null&&!roomid.equals("")){
				List roomspanlist = this.commonService.find("select roomIspn from NodeRoomTable where roomId="+roomid);
				if(roomspanlist!=null&&roomspanlist.size()>0){
					roomspan=roomspanlist.get(0).toString();
				}
			}
			
			String hql = "from NodeBoxTable where 1=1";
			if(ispnNum!=null && !"".equals(ispnNum)){
				hql += " and ispn like '%" + ispnNum.trim() + "%'";
			}
			if(roomspan!=null && !"".equals(roomspan)){
				hql += " and roomIspn = '" + roomspan + "'";
			}
			hql += " order by ispn asc";
			page = this.commonService.findByPage(hql, pageNo, pageSize);
			List<NodeBoxTable> nodeBoxList = (List<NodeBoxTable>)page.getResult(); 
			
			String[] title = { getI18nText("i18n_BoxSetAction.queryBoxInfo.title1.boxId_n81i"),
								getI18nText("i18n_BoxSetAction.queryBoxInfo.title1.boxDesc_n81i"),
								getI18nText("i18n_BoxSetAction.queryBoxInfo.title1.roomId_n81i")};
			
			String[] colu = { "ispn", "descinfo","roomIspn"};
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(getI18nText("i18n_BoxSetAction.queryBoxInfo.boxBaseInfo_n81i"), nodeBoxList, title, colu);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
		return null;
	}
	
	// 导出全部   程辉 2013-5-8新增
	public String emportAllXls() {
		try {
//			String hql = "from NodeBoxTable where 1=1";
//			if(ispnNum!=null && !"".equals(ispnNum)){
//				hql += " and ispn like '%" + ispnNum.trim() + "%'";
//			}
//			hql += " order by ispn asc";
			
			String roomspan="";
			if(roomid!=null&&!roomid.equals("")){
				List roomspanlist = this.commonService.find("select roomIspn from NodeRoomTable where roomId="+roomid);
				if(roomspanlist!=null&&roomspanlist.size()>0){
					roomspan=roomspanlist.get(0).toString();
				}
			}
			
			String hql = "from NodeBoxTable where 1=1";
			if(ispnNum!=null && !"".equals(ispnNum)){
				hql += " and ispn like '%" + ispnNum.trim() + "%'";
			}
			if(roomspan!=null && !"".equals(roomspan)){
				hql += " and roomIspn = '" + roomspan + "'";
			}
			hql += " order by ispn asc";
			//page = this.commonService.findByPage(hql, pageNo, pageSize);
			List<NodeBoxTable> nodeBoxList = this.commonService.find(hql); 
			
			String[] title = { getI18nText("i18n_BoxSetAction.queryBoxInfo.title1.boxId_n81i"),
					getI18nText("i18n_BoxSetAction.queryBoxInfo.title1.boxDesc_n81i"),
					getI18nText("i18n_BoxSetAction.queryBoxInfo.title1.roomId_n81i")};
			
			String[] colu = { "ispn", "descinfo","roomIspn"};
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(getI18nText("i18n_BoxSetAction.queryBoxInfo.boxBaseInfo_n81i"), nodeBoxList, title, colu);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
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

	public Long[] getIds() {
		return ids;
	}

	public void setIds(Long[] ids) {
		this.ids = ids;
	}

	public List<NodeBoxTable> getNodeBoxList() {
		return nodeBoxList;
	}

	public void setNodeBoxList(List<NodeBoxTable> nodeBoxList) {
		this.nodeBoxList = nodeBoxList;
	}

	public String getIspnNum() {
		return ispnNum;
	}

	public void setIspnNum(String ispnNum) {
		this.ispnNum = ispnNum;
	}

	public String getDescinfo() {
		return descinfo;
	}

	public void setDescinfo(String descinfo) {
		this.descinfo = descinfo;
	}

	public NodeBoxTable getNodeBox() {
		return nodeBox;
	}

	public void setNodeBox(NodeBoxTable nodeBox) {
		this.nodeBox = nodeBox;
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

}
