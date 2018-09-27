package com.nms.objectSnmp.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import nis.nms.domains.CheckTypeInfo;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;

import org.apache.log4j.Logger;

import com.nms.objectSnmp.impl.GenJavaCodeTool;
import com.nms.objectSnmp.util.EntityInfo;
import com.nms.objectSnmp.util.FileUtil;
import com.nms.objectSnmp.util.FormatUtil;
import com.zhtelecom.common.snmp.impl.SNMPAPIImpl;
import com.zhtelecom.mib.MibValueSymbol;
import com.zhtelecom.mib.snmp.SnmpObjectType;

@SuppressWarnings("unchecked")
public class SnmpAction extends BaseAction{
	private Logger logger = Logger.getLogger(SnmpAction.class);
	private static final long serialVersionUID = 1L;
	private CommonService commonService ;
	private FileUtil fileUtil = new FileUtil();
	private static SNMPAPIImpl snmpapi;
	
	public SnmpAction(CommonService common) {
		snmpapi = new SNMPAPIImpl();
		this.commonService = common;
	}
	
	private SnmpAction() {
		snmpapi = new SNMPAPIImpl();
	}
	
	/** 
	 * @param cti
	 * 		监测类别
	 * @param listEI
	 * 		栏位信息
	 */
	public void insertFiled(CheckTypeInfo cti, List<EntityInfo> listEI) throws Exception{
		SimpleDateFormat sdf = null;
		String createDate = "";
		sdf = new SimpleDateFormat("yyyy-MM-dd");
		createDate = sdf.format(cti.getCreateTime());
		List<String> sqls = new ArrayList<String>();
		StringBuffer infoSQL = new StringBuffer("insert into METADATA "
				+ "(ID," + "CHECK_TYPE_ID," + "TABLE_NAME," + "TABLE_COMMENTS,"
				+ "CREATE_DATE," + "CREATE_PERSON," + "STATE," + "CHART_STATE," +"SORT_SIGN,"
				+ "FILED_COMMENTS," + "FILED_TYPE," + "OID," + "SHOW_NUM)"); // SQL

		try {
			if (listEI != null && listEI.size() > 0) {
				for (int i = 0; i < listEI.size(); i++) {
					StringBuffer values = new StringBuffer();// values
					EntityInfo ei = listEI.get(i);
					String sql = "";
					values.append(" values(SEQ_METADATA.NEXTVAL," + cti.getId()
							+ " ,'" + cti.getTableName() + "', ");
					values.append("'" + cti.getTableComments() + "', ");// 表描述
					values.append("to_date('" + createDate + "','yyyy-MM-dd'),");// 创建时间
					values.append(cti.getUserId() + ", ");// 创建人
					values.append("'0', ");// 是否启用
					values.append("'1', ");// 是否用于统计
					values.append("1, ");// 是否分类标识:0是；1否，公用统计图中的多线分类标识字段
					values.append("'" + ei.getFiledName() + "',");//字段描述
					values.append("'" + ei.getFiledType() + "',");
					values.append("'" + ei.getOid() + "',");
					values.append(ei.getShowNum() + ")");
					sql = infoSQL.toString() + values.toString();
					sqls.add(sql);
				}
				this.commonService.insertBatchBySqls(sqls);
				logger.debug("插入数据源成功！");
			}
		} catch (Exception e) {
			logger.error("Failed to insert the data source!",e);
			throw new Exception("Failed to insert the data source!");
		}
		
	}
	
	//得到栏位
	public List<EntityInfo> getFiled(String oid)throws Exception{
		List<EntityInfo> list = null;
		try {
			MibValueSymbol mibvaluesymbol = snmpapi.getMibSymbolByOid(oid);
			if(mibvaluesymbol !=null){
				list = new ArrayList<EntityInfo>();
				MibValueSymbol amibvaluesymbols[] = mibvaluesymbol.getChildren();//所有子节点
				for (int i = 0; i < amibvaluesymbols.length; i++)
				{
					MibValueSymbol mibvaluekey = amibvaluesymbols[i];//子节点
					if (!mibvaluekey.isTable() && !mibvaluekey.isTableRow())
					{
						//字段名
						String filedName = mibvaluekey.getName();
						//字段oid
						String childoid=mibvaluekey.getValue().toString();
						//show_num传输序号
						//int showNum =Integer.parseInt(childoid.substring(childoid.lastIndexOf(".")+1, childoid.length()));
						int showNum = i+1;
						SnmpObjectType snmpobjecttype = (SnmpObjectType)mibvaluekey.getType();
						//字段类型
						String filedType = GenJavaCodeTool.getType(snmpobjecttype);
						EntityInfo ei = new EntityInfo();
						ei.setFiledName(filedName);
						ei.setFiledType(FormatUtil.changType(filedType));//转换成数据库类型
						ei.setOid(childoid);
						ei.setShowNum(showNum);
						list.add(ei);
						//System.out.println("filedname:"+filedName+"------filedtype:"+filedType+"---oid:"+childoid);
					}
				}
			}
			logger.debug("获取栏位成功！");
		} catch (Exception e) {
			logger.error("Failed to get the field!",e);
			throw new Exception("Failed to get the field!");
		}
		return list;
	}
	
	public void loadAllMibs(List<String> mibNames) throws Exception{
		try {			
			LinkedList<String> loadErrorFiles = new LinkedList<String>();
			if(mibNames !=null && mibNames.size()>0){
				for(int i=0;i<mibNames.size();i++){
					try {
						//System.out.println(mibNames.get(i));
						snmpapi.loadMib(mibNames.get(i));
					} catch (Exception e) {
						//System.out.println("加载："+mibNames.get(i)+"出错！");
						loadErrorFiles.add(mibNames.get(i));
						continue;
					}
				}
				
				if(loadErrorFiles.size()>0){
					//System.out.println("--------------------------------------------");
					for(int j=0;j<loadErrorFiles.size();j++){
						try {
							//System.out.println(loadErrorFiles.get(j));
							snmpapi.loadMib(loadErrorFiles.get(j));
						} catch (Exception e) {
							//System.out.println("加载："+loadErrorFiles.get(j)+"出错！");
							logger.error("Load the mib library"+loadErrorFiles.get(j)+"failed！",e);
							continue;	
						}
					}
				}
			}else{
				throw new Exception();
			}
			logger.debug("加载mib成功！");
		} catch (Exception e) {
			logger.error("Load MIB failed!", e);
			throw new Exception("i18n_SnmpAction.insertFiled.loadMibErr_n81i");
		}
	}
	
	public void genJavaCode(String tableName,String oid) throws Exception{
		GenJavaCodeTool.genJavaCode(snmpapi,tableName, oid);
		
	}
	
	public void createClass(String name)throws Exception{
		fileUtil.createClass(name);
	}

	@Override
	public String executeAction() throws Exception {
		return null;
	}
	
	public static void main(String [] args ) {
		SnmpAction sa = new SnmpAction();
		sa.test();
	}
	public void test(){
		//1.load all mib
		List<String> names =null;
		List<EntityInfo> allfileds = null;
		String checkTypeName = "system_test_0329";
		String oid = "1.3.6.1.2.1.1";
		try {
			names = fileUtil.getAllMibFileNames();
			loadAllMibs(names);
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			return;
		}
		
		//2.create javaBean and class
		try {
			genJavaCode(FormatUtil.formatBeanName(checkTypeName),oid);
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			return;
		}
		
		try {
			createClass(FormatUtil.formatBeanName(checkTypeName));
		} catch (Exception e1) {
			logger.error(e1.getStackTrace());
			return;
		}
		
		//3.get all filed
		try {
			allfileds = getFiled(oid.trim());
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			return;
		}
		
		//4.save
		try {
//			this.commonService.save(checkTypeInfo);
//			insertFiled(checkTypeInfo,allfileds);
			//this.getRequest().setAttribute("MSG", 1);
			
			// 将更新操作写到操作日志中
//			this.addDBOperationRpt(commonService,"check_type_info", "INSERT", checkTypeInfo.getId());
//			outHtmlString("<script type=\"text/javascript\">alert('操作成功');this.location='checkTypeSet.do?action=query&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			return;
		}
		
	}
}
