/**
 * ExportUtils.java
 * 版权所有(C) 2010 北京中科智源育成信息技术有限公司
 * 创建:ZhengXi 2010-7-21
 */
package nis.nms.util;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts2.ServletActionContext;
import org.hibernate.lob.SerializableClob;

/**
 * 导出工具类
 * 
 * @author ZhengXi
 * @version 1.0
 * 
 */
public class ExportUtils {
	private HttpServletResponse response;
	private boolean autoSizeColumn = false;

	public boolean isAutoSizeColumn() {
		return autoSizeColumn;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	/**
	 * 设置是否自动列宽
	 * 
	 * @param autoSizeColumn
	 * @author ZhengXi
	 */
	public void setAutoSizeColumn(boolean autoSizeColumn) {
		this.autoSizeColumn = autoSizeColumn;
	}

	/**
	 * 以流导出大数据Excel
	 * 
	 * @param sheetSize
	 *            每页最大数据承载量
	 * @param dateList
	 *            数据集(行数据可以是对象或数组)
	 * @param titles
	 *            表头数组
	 * @param fields
	 *            字段数组,每个字段支持获取无限关联对象的字段属性。
	 *            <br/>(例如：获取用户字段对象的班级字段对象的name字段属性:user.classes.name) <br/>
	 *            如果数据集每行数据为Object[]数组，则字段数组必须对应Object[]的下标
	 * @param out
	 *            需要输出的文件流
	 * @throws Exception
	 * @author ZhengXi 2010-6-21
	 */
	public void exportExcel2Sheet(String exportName,String sheetName,String sheetName1,List tempList, Object[] titles,
			Object[] fields,List tempList1, Object[] titles1, Object[] fields1)
			throws Exception {
		SimpleDateFormat format = new SimpleDateFormat("yy-MM-dd_HH-mm-ss");
		String fileName = exportName + "_" + format.format(new Date()) + ".xls";
		// 设置一下相应的文件格式和文件名
		HttpServletResponse res = response == null ? ServletActionContext
				.getResponse() : response;
		res.setContentType("application/vnd.ms-excel;charset=UTF-8");
		res.setHeader("Content-Disposition", "attachment; filename=\""
				+ new String(fileName.getBytes("gb2312"), "ISO8859-1") + "\"");
		OutputStream out = res.getOutputStream();
		if (tempList.size() > 65535 || tempList1.size() > 65535) {
			out.close();
			throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.singleSheet_n81i"));
		}
		try {
			HSSFSheet sheet = null;
			HSSFSheet sheet1 = null;
			// 封装对象
			HSSFWorkbook workbook = new HSSFWorkbook();
			HSSFCellStyle dateStyle = workbook.createCellStyle();
			HSSFDataFormat formatDate = workbook.createDataFormat();
			dateStyle.setDataFormat(formatDate.getFormat("yyy-mm-dd hh:mm:ss"));
			// 构造每个Sheet的数据
			if (tempList.size() >= 0) {
				// 为了避免标题与数据部统一，计算最小取值范围
				int titleLength = 0;
				for (int j = 0; j < titles.length; j++) {
					if (titles[j] != null) {
						titleLength++;
					}
				}
				Object[] tempTitle = new Object[titleLength];
				for (int j = 0, r = 0; j < titles.length; j++) {
					if (titles[j] != null) {
						tempTitle[r++] = titles[j];
					}
				}
				titles = tempTitle;
				int minCell = fields.length < titles.length ? fields.length
						: titles.length;
				sheet = workbook.createSheet(sheetName);
				HSSFRow row = sheet.createRow(0);
				for (int m = 0; m < titles.length; m++) {
					HSSFCell cell = row.createCell(m);
					HSSFRichTextString text = new HSSFRichTextString(titles[m]
							.toString());
					cell.setCellValue(text);// 把数据放到单元格中
				}
				// 构造每行数据
				for (int j = 1; j < tempList.size() + 1; j++) {
					row = sheet.createRow(j);
					Object object = tempList.get(j - 1);
					if (object instanceof Object[]) {
						Object[] valueArray = (Object[]) object;
						for (int col = 0; col < minCell; col++) {
							HSSFCell cell = row.createCell(col);
							int fieldIndex;
							try {
								fieldIndex = Integer.parseInt(fields[col]
										.toString());
							} catch (Exception e) {
								throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.shouldBeIndex_n81i"));
							}
							Object value;
							try {
								value = valueArray[fieldIndex];
							} catch (RuntimeException e) {
								throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.rowDataErr_n81i")
										+ fieldIndex + BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.rowData_n81i"));
							}
							if(value != null && value instanceof String){
								value = BaseAction.getI18nText((String)value);
							}
							this.createCell(cell, dateStyle, value);
						}
					} else {
						for (int col = 0; col < minCell; col++) {
							HSSFCell cell = row.createCell(col);
							Object value = getValueByField(object, fields[col]
									.toString());
							if(value != null && value instanceof String){
								value = BaseAction.getI18nText((String)value);
							}
							this.createCell(cell, dateStyle, value);
						}
					}
				}
				if (this.autoSizeColumn) {
					for (short j = 0; j < fields.length; j++) {
						sheet.autoSizeColumn(j);
					}
				}
			}

			if (tempList1.size() >= 0) {
				// 为了避免标题与数据部统一，计算最小取值范围
				int titleLength = 0;
				for (int j = 0; j < titles1.length; j++) {
					if (titles1[j] != null) {
						titleLength++;
					}
				}
				Object[] tempTitle = new Object[titleLength];
				for (int j = 0, r = 0; j < titles1.length; j++) {
					if (titles1[j] != null) {
						tempTitle[r++] = titles1[j];
					}
				}
				titles1 = tempTitle;
				int minCell = fields1.length < titles1.length ? fields1.length
						: titles1.length;
				sheet1 = workbook.createSheet(sheetName1);
				HSSFRow row = sheet1.createRow(0);
				for (int m = 0; m < titles1.length; m++) {
					HSSFCell cell = row.createCell(m);
					HSSFRichTextString text = new HSSFRichTextString(titles1[m]
							.toString());
					cell.setCellValue(text);// 把数据放到单元格中
				}
				// 构造每行数据
				for (int j = 1; j < tempList1.size() + 1; j++) {
					row = sheet1.createRow(j);
					Object object = tempList1.get(j - 1);
					if (object instanceof Object[]) {
						Object[] valueArray = (Object[]) object;
						for (int col = 0; col < minCell; col++) {
							HSSFCell cell = row.createCell(col);
							int fieldIndex;
							try {
								fieldIndex = Integer.parseInt(fields1[col]
										.toString());
							} catch (Exception e) {
								throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.shouldBeIndex_n81i"));
							}
							Object value;
							try {
								value = valueArray[fieldIndex];
							} catch (RuntimeException e) {
								throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.rowDataErr_n81i")
										+ fieldIndex + BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.rowData_n81i"));
							}
							if(value != null && value instanceof String){
								value = BaseAction.getI18nText((String)value);
							}
							this.createCell(cell, dateStyle, value);
						}
					} else {
						for (int col = 0; col < minCell; col++) {
							HSSFCell cell = row.createCell(col);
							Object value = getValueByField(object, fields1[col]
									.toString());
							if(value != null && value instanceof String){
								value = BaseAction.getI18nText((String)value);
							}
							this.createCell(cell, dateStyle, value);
						}
					}
				}
				if (this.autoSizeColumn) {
					for (short j = 0; j < fields1.length; j++) {
						sheet1.autoSizeColumn(j);
					}
				}
			}
			workbook.write(out);
			if (out != null) {
				try {
					out.flush();
					out.close();
				} catch (IOException ioe) {
					System.out.println("ExportUtils.exportBigExcle()");
					throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.IOException_n81i") + ioe.getMessage());
				}
			}
		} catch (Exception e) {
			System.out.println("ExportUtils.exportBigExcle()");
			e.printStackTrace();
			throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.exportException_n81i") + e.getMessage());
		}
	}	
	
	/**
	 * 以网页打开在保持方式导出大数据Excel
	 * 
	 * @param exportName
	 *            导出文件名
	 * @param dateList
	 *            数据集
	 * @param titles
	 *            表头数组
	 * @param fields
	 *            字段数组,每个字段支持获取无限关联对象的字段属性。
	 *            <br/>(例如：获取用户字段对象的班级字段对象的name字段属性:user.classes.name)
	 * @throws Exception
	 * @author ZhengXi 2010-6-21
	 */
	public void exportExcel(String exportName, List dateList, Object[] titles,
			Object[] fields,Object... values) throws Exception {
		if((dateList==null||dateList.size()==0)&&(values==null||values.length==0)){
			ServletActionContext.getResponse().setContentType("text/html;charset=utf-8");
			ServletActionContext.getResponse().getWriter().print("<script>alert('i18n_ExportUtils.exportExcel2Sheet.noDataExport_n81i');window.history.back();</script>");//.getOutputStream().print("没有数据！");
			return;
		}
		exportExcel(65535, exportName, dateList, titles, fields);
	}
	public void exportExcel(String url,String exportName, List dateList, Object[] titles,
			Object[] fields,Object... values) throws Exception {
		if((dateList==null||dateList.size()==0)&&(values==null||values.length==0)){
			ServletActionContext.getResponse().setContentType("text/html;charset=utf-8");
			ServletActionContext.getResponse().getWriter().print("<script>alert('i18n_ExportUtils.exportExcel2Sheet.noDataExport_n81i');this.location='"+url+"';</script>");//.getOutputStream().print("没有数据！");
			return;
		}
		exportExcel(65535, exportName, dateList, titles, fields);
	}
	/*
	 * 以网页打开在保持方式导出大数据Excel
	 * 
	 * @param exportName
	 *            导出文件名
	 * @param dateList
	 *            数据集
	 * @param titles
	 *            表头数组
	 * @param fields
	 *            字段数组,每个字段支持获取无限关联对象的字段属性。
	 *            <br/>(例如：获取用户字段对象的班级字段对象的name字段属性:user.classes.name)
	 * @throws Exception
	 */
	public void exportExcel1(String exportName, List<List<Object>> dateList,String[] sheetNames, List<Object[]> titles,
			List<Object[]>  fields,Object... values) throws Exception {
		if((dateList==null||dateList.size()==0)&&(values==null||values.length==0)){
			ServletActionContext.getResponse().setContentType("text/html;charset=utf-8");
			ServletActionContext.getResponse().getWriter().print("<script>alert('i18n_ExportUtils.exportExcel2Sheet.noDataExport_n81i');window.history.back();</script>");//.getOutputStream().print("没有数据！");
			return;
		}
		exportExcel1(65535, exportName, dateList,sheetNames, titles, fields);
	}
	/**
	 * 以网页打开在保持方式导出大数据Excel
	 * 
	 * @param exportName
	 *            导出文件名
	 * @param dateList
	 *            数据集
	 * @param titles
	 *            表头数组
	 * @param fields
	 *            字段数组,每个字段支持获取无限关联对象的字段属性。
	 *            <br/>(例如：获取用户字段对象的班级字段对象的name字段属性:user.classes.name)
	 * @throws Exception
	 * @author chenghui 2013-5-23
	 */
	public void exportExcel2Sheet(String exportName, List tempList, Object[] titles,
			Object[] fields) throws Exception {
		SimpleDateFormat format = new SimpleDateFormat("yy-MM-dd_HH-mm-ss");
		String fileName = exportName + "_" + format.format(new Date()) + ".xls";
		// 设置一下相应的文件格式和文件名
		HttpServletResponse res = response == null ? ServletActionContext
				.getResponse() : response;
		res.setContentType("application/vnd.ms-excel;charset=UTF-8");
		res.setHeader("Content-Disposition", "attachment; filename=\""
				+ new String(fileName.getBytes("gb2312"),"ISO8859-1") + "\"");
		OutputStream out = res.getOutputStream();		

		if (tempList == null) {
			out.close();
			throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.noDataExport_n81i"));
		}
		try {			
			// 封装对象
			HSSFWorkbook workbook = new HSSFWorkbook();
			HSSFCellStyle dateStyle = workbook.createCellStyle();
			HSSFDataFormat formatDate = workbook.createDataFormat();
			dateStyle.setDataFormat(formatDate.getFormat("yyy-mm-dd hh:mm:ss"));
			
			HSSFSheet sheet = null;
			// 构造第一个Sheet的数据
			if (tempList.size() > 0) {
				// 为了避免标题与数据部统一，计算最小取值范围
				int titleLength = 0;
				for (int j = 0; j < titles.length; j++) {
					if (titles[j] != null) {
						titleLength++;
					}
				}
				Object[] tempTitle = new Object[titleLength];
				for (int j = 0, r = 0; j < titles.length; j++) {
					if (titles[j] != null) {
						tempTitle[r++] = titles[j];
					}
				}
				titles = tempTitle;
				int minCell = fields.length < titles.length ? fields.length
						: titles.length;
				// 构造新的Sheet,并命名为文件名+编号
				sheet = workbook.createSheet(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.data_n81i")+"(" + (1) + "-"
						+ (tempList.size()) + ")");

				// 构造表头
				HSSFRow row = sheet.createRow(0);
				for (int m = 0; m < titles.length; m++) {
					HSSFCell cell = row.createCell(m);
					HSSFRichTextString text = new HSSFRichTextString(titles[m]
							.toString());
					cell.setCellValue(text);// 把数据放到单元格中
				}
				// 构造每行数据
				for (int j = 1; j < tempList.size() + 1; j++) {
					row = sheet.createRow(j);
					Object object = tempList.get(j - 1);
					if (object instanceof Object[]) {
						Object[] valueArray = (Object[]) object;
						for (int col = 0; col < minCell; col++) {
							HSSFCell cell = row.createCell(col);
							int fieldIndex;
							try {
								fieldIndex = Integer.parseInt(fields[col]
										.toString());
							} catch (Exception e) {
								throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.shouldBeIndex_n81i"));
							}
							Object value;
							try {
								value = valueArray[fieldIndex];
							} catch (RuntimeException e) {
								throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.rowDataErr_n81i")
										+ fieldIndex + BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.rowData_n81i"));
							}
							if(value != null && value instanceof String){
								value = BaseAction.getI18nText((String)value);
							}
							this.createCell(cell, dateStyle, value);
						}
					} else {
						for (int col = 0; col < minCell; col++) {
							HSSFCell cell = row.createCell(col);
							Object value = getValueByField(object, fields[col]
									.toString());
							if(value != null && value instanceof String){
								value = BaseAction.getI18nText((String)value);
							}
							this.createCell(cell, dateStyle, value);
						}
					}
				}
				if (this.autoSizeColumn) {
					for (short j = 0; j < fields.length; j++) {
						sheet.autoSizeColumn(j);
					}
				}
			}else{
				// 为了避免标题与数据部统一，计算最小取值范围
				int titleLength = 0;
				for (int j = 0; j < titles.length; j++) {
					if (titles[j] != null) {
						titleLength++;
					}
				}
				Object[] tempTitle = new Object[titleLength];
				for (int j = 0, r = 0; j < titles.length; j++) {
					if (titles[j] != null) {
						tempTitle[r++] = titles[j];
					}
				}
				titles = tempTitle;
				// 构造新的Sheet,并命名为文件名+编号
				sheet = workbook.createSheet(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.mould_n81i"));

				// 构造表头
				HSSFRow row = sheet.createRow(0);
				for (int m = 0; m < titles.length; m++) {
					HSSFCell cell = row.createCell(m);
					HSSFRichTextString text = new HSSFRichTextString(titles[m]
							.toString());
					cell.setCellValue(text);// 把数据放到单元格中
				}
			}
			
			HSSFSheet sheet1 = null;
			sheet1 = workbook.createSheet(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.tableField_n81i"));
			// 构造表头
			HSSFRichTextString text = null;
			HSSFCell cell=null;
			HSSFRow row = sheet1.createRow(0);
			// 构造表头列数据
			cell = row.createCell(0);
			text = new HSSFRichTextString(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.fieldName_n81i"));
			cell.setCellValue(text);// 把数据放到单元格中
			if (this.autoSizeColumn) {
				sheet1.autoSizeColumn(0);
			}
			
			cell = row.createCell(1);
			text = new HSSFRichTextString(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.fieldDesc_n81i"));
			cell.setCellValue(text);// 把数据放到单元格中		
			if (this.autoSizeColumn) {
				sheet1.autoSizeColumn(1);
			}	

			cell = row.createCell(2);
			text = new HSSFRichTextString(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.fieldType_n81i"));
			cell.setCellValue(text);// 把数据放到单元格中
			if (this.autoSizeColumn) {
				sheet1.autoSizeColumn(2);
			}

			cell = row.createCell(3);
			text = new HSSFRichTextString(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.length_n81i"));
			cell.setCellValue(text);// 把数据放到单元格中
			if (this.autoSizeColumn) {
				sheet1.autoSizeColumn(3);
			}

			cell = row.createCell(4);
			text = new HSSFRichTextString(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.isChart_n81i"));
			cell.setCellValue(text);// 把数据放到单元格中
			if (this.autoSizeColumn) {
				sheet1.autoSizeColumn(4);
			}

			cell = row.createCell(5);
			text = new HSSFRichTextString("OID");
			cell.setCellValue(text);// 把数据放到单元格中
			if (this.autoSizeColumn) {
				sheet1.autoSizeColumn(5);
			}
			
			cell = row.createCell(6);
			text = new HSSFRichTextString(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.monitorTypeName_n81i"));
			cell.setCellValue(text);// 把数据放到单元格中
			if (this.autoSizeColumn) {
				sheet1.autoSizeColumn(6);
			}

			cell = row.createCell(7);
			text = new HSSFRichTextString(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.tableName_n81i"));
			cell.setCellValue(text);// 把数据放到单元格中
			if (this.autoSizeColumn) {
				sheet1.autoSizeColumn(7);
			}
			
			workbook.write(out);
			if (out != null) {
				try {
					out.flush();
					out.close();
				} catch (IOException ioe) {
					System.out.println("ExportUtils.exportBigExcle()");
					throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.IOException_n81i") + ioe.getMessage());
				}
			}
		} catch (Exception e) {
			System.out.println("ExportUtils.exportBigExcle()");
			e.printStackTrace();
			throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.exportException_n81i") + e.getMessage());
		}
	}

	/**
	 * 以网页打开在保持方式导出大数据Excel
	 * 
	 * @param sheetSize
	 *            单个Sheet最多承载数据量
	 * @param exportName
	 *            导出文件名
	 * @param dateList
	 *            数据集
	 * @param titles
	 *            表头数组
	 * @param fields
	 *            字段数组,每个字段支持获取无限关联对象的字段属性。
	 *            <br/>(例如：获取用户字段对象的班级字段对象的name字段属性:user.classes.name)
	 * @throws Exception
	 * @author ZhengXi 2010-6-21
	 */
	public void exportExcel(int sheetSize, String exportName, List dateList,
			Object[] titles, Object[] fields) throws Exception {
		SimpleDateFormat format = new SimpleDateFormat("yy-MM-dd_HH-mm-ss");
		String fileName = exportName + "_" + format.format(new Date()) + ".xls";
		// 设置一下相应的文件格式和文件名
		HttpServletResponse res = response == null ? ServletActionContext
				.getResponse() : response;
		res.setContentType("application/vnd.ms-excel;charset=UTF-8");
//		res.setHeader("Content-Disposition", "attachment; filename=\""
//				+ URLEncoder.encode(fileName, "UTF-8") + "\"");
		res.setHeader("Content-Disposition", "attachment; filename=\""
				+ new String(fileName.getBytes("gb2312"),"ISO8859-1") + "\"");
		OutputStream out = res.getOutputStream();
		exportExcel(sheetSize, dateList, titles, fields, out);
		// out.flush();
		
	}
	public void exportExcel1(int sheetSize, String exportName, List<List<Object>> dateList,String[] sheetNames,
			List<Object[]> titles, List<Object[]>  fields) throws Exception {
		SimpleDateFormat format = new SimpleDateFormat("yy-MM-dd_HH-mm-ss");
		String fileName = exportName + "_" + format.format(new Date()) + ".xls";
		// 设置一下相应的文件格式和文件名
		HttpServletResponse res = response == null ? ServletActionContext
				.getResponse() : response;
				res.setContentType("application/vnd.ms-excel;charset=UTF-8");
//		res.setHeader("Content-Disposition", "attachment; filename=\""
//				+ URLEncoder.encode(fileName, "UTF-8") + "\"");
				res.setHeader("Content-Disposition", "attachment; filename=\""
						+ new String(fileName.getBytes("gb2312"),"ISO8859-1") + "\"");
				OutputStream out = res.getOutputStream();
				exportExcel1(sheetSize, dateList,sheetNames, titles, fields, out);
				// out.flush();
				
	}

	/**
	 * 以文件保存形式导出大数据Excel
	 * 
	 * @param sheetSize
	 *            单个Sheet最多承载数据量
	 * @param dateList
	 *            数据集
	 * @param titles
	 *            表头数组
	 * @param fields
	 *            字段数组,每个字段支持获取无限关联对象的字段属性。
	 *            <br/>(例如：获取用户字段对象的班级字段对象的name字段属性:user.classes.name)
	 * @param fileName
	 *            输出文件路径
	 * @throws Exception
	 * @author ZhengXi 2010-6-21
	 */
	public String exportExcel(int sheetSize, List<Object> dateList,
			Object[] titles, Object[] fields, String fileName) throws Exception {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss");
		fileName = fileName + "_" + format.format(new Date()) + ".xls";
		OutputStream out = new FileOutputStream(fileName);
		exportExcel(sheetSize, dateList, titles, fields, out);
		return fileName;

	}

	/**
	 * 以流导出大数据Excel
	 * 
	 * @param sheetSize
	 *            每页最大数据承载量
	 * @param dateList
	 *            数据集(行数据可以是对象或数组)
	 * @param titles
	 *            表头数组
	 * @param fields
	 *            字段数组,每个字段支持获取无限关联对象的字段属性。
	 *            <br/>(例如：获取用户字段对象的班级字段对象的name字段属性:user.classes.name) <br/>
	 *            如果数据集每行数据为Object[]数组，则字段数组必须对应Object[]的下标
	 * @param out
	 *            需要输出的文件流
	 * @throws Exception
	 * @author ZhengXi 2010-6-21
	 */
	@SuppressWarnings( { "unchecked", "deprecation" })
	private void exportExcel(int sheetSize, List dateList, Object[] titles,
			Object[] fields, OutputStream out) throws Exception {
		if (dateList == null) {
			out.close();
			throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.noDataExport_n81i"));
		}
		if (sheetSize <= 0) {
			out.close();
			throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.moreThanZero_n81i"));
		}
		// 计算出Sheet的个数
		int sheetNum = dateList.size() / sheetSize + 1;
		if (sheetNum < 200) {
			try {
				List tempList = null;
				HSSFSheet sheet = null;
				// 封装对象
				HSSFWorkbook workbook = new HSSFWorkbook();
				HSSFCellStyle dateStyle = workbook.createCellStyle();
				HSSFDataFormat formatDate = workbook.createDataFormat();
				dateStyle.setDataFormat(formatDate
						.getFormat("yyy-mm-dd hh:mm:ss"));
				// 构造每个Sheet的数据
				for (int i = 0; i < sheetNum; i++) {
					int start = i * sheetSize;
					int end = (i + 1) * sheetSize;
					if (end < dateList.size()) {
						tempList = dateList.subList(start, end);
					} else {
						tempList = dateList.subList(start, dateList.size());
					}
					if (tempList.size() > 0) {
						// 为了避免标题与数据部统一，计算最小取值范围
						int titleLength=0;
						for (int j = 0; j < titles.length; j++) {
							if (titles[j] != null) {
								titleLength++;
							}
						}
						Object[] tempTitle = new Object[titleLength];
						for (int j = 0, r = 0; j < titles.length; j++) {
							if (titles[j] != null) {
								tempTitle[r++]=titles[j];
							}
						}
						titles=tempTitle;
						int minCell = fields.length < titles.length ? fields.length
								: titles.length;
						// 构造新的Sheet,并命名为文件名+编号
						sheet = workbook.createSheet(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.data_n81i")+"("
								+ (sheetSize * i + 1) + "-"
								+ ((sheetSize * i) + tempList.size()) + ")");
						
						// 构造表头
//						for (short m = 0; m < minCell; m++) {
//							if (titles[m]!=null) {
//								sheet.createRow(0).createCell(m).setCellValue(
//										titles[m].toString());
//							}
//						}
						HSSFRow row = sheet.createRow(0);
						for(int m = 0; m < titles.length; m++){
							HSSFCell cell = row.createCell(m);
							HSSFRichTextString text = new HSSFRichTextString(titles[m].toString());
							cell.setCellValue(text);//把数据放到单元格中
						}
						// 构造每行数据
						for (int j = 1; j < tempList.size() + 1; j++) {
							row = sheet.createRow(j);
							Object object = tempList.get(j - 1);
							if (object instanceof Object[]) {
								Object[] valueArray = (Object[]) object;
								for (int col = 0; col < minCell; col++) {
									HSSFCell cell = row.createCell(col);
									int fieldIndex;
									try {
										fieldIndex = Integer
												.parseInt(fields[col]
														.toString());
									} catch (Exception e) {
										throw new Exception(
												BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.shouldBeIndex_n81i"));
									}
									Object value;
									try {
										value = valueArray[fieldIndex];
									} catch (RuntimeException e) {
										throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.rowDataErr_n81i")
												+ fieldIndex + BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.rowData_n81i"));
									}
									if(value != null && value instanceof String){
										value = BaseAction.getI18nText((String)value);
									}
									this.createCell(cell, dateStyle, value);
								}
							} else {
								for (int col = 0; col < minCell; col++) {
									HSSFCell cell = row.createCell(col);
									Object value = getValueByField(object,
											fields[col].toString());
									if(value != null && value instanceof String){
										value = BaseAction.getI18nText((String)value);
									}
									this.createCell(cell, dateStyle, value);
								}
							}
						}
						if (this.autoSizeColumn) {
							for (short j = 0; j < fields.length; j++) {
								sheet.autoSizeColumn(j);
							}
						}
					}else{
						// 为了避免标题与数据部统一，计算最小取值范围
						int titleLength=0;
						for (int j = 0; j < titles.length; j++) {
							if (titles[j] != null) {
								titleLength++;
							}
						}
						Object[] tempTitle = new Object[titleLength];
						for (int j = 0, r = 0; j < titles.length; j++) {
							if (titles[j] != null) {
								tempTitle[r++]=titles[j];
							}
						}
						titles=tempTitle;
						// 构造新的Sheet,并命名为文件名+编号
						sheet = workbook.createSheet(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.mould_n81i"));
						HSSFRow row = sheet.createRow(0);
						for(int m = 0; m < titles.length; m++){
							HSSFCell cell = row.createCell(m);
							HSSFRichTextString text = new HSSFRichTextString(titles[m].toString());
							cell.setCellValue(text);//把数据放到单元格中
						}
					}
				}
				workbook.write(out);
				if (out != null) {
					try {
						out.flush();
						out.close();
					} catch (IOException ioe) {
						System.out.println("ExportUtils.exportBigExcle()");
						throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.IOException_n81i") + ioe.getMessage());
					}
				}
			} catch (Exception e) {
				System.out.println("ExportUtils.exportBigExcle()");
				e.printStackTrace();
				throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.exportException_n81i") + e.getMessage());
			}
		} else {
			out.close();
			throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.outZoom_n81i"));
		}

	}
	// by
	private void exportExcel1(int sheetSize, List<List<Object>> dataList,String[] sheetNames, List<Object[]> titles,
			List<Object[]>  fields, OutputStream out) throws Exception {
		if (dataList == null) {
			out.close();
			throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.noDataExport_n81i"));
		}
		if (sheetSize <= 0) {
			out.close();
			throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.moreThanZero_n81i"));
		}
		// 计算出Sheet的个数
		int sheetNum = sheetNames.length;
		if (sheetNum < 200) {
			try {
				List tempList = null;
				HSSFSheet sheet = null;
				// 封装对象
				HSSFWorkbook workbook = new HSSFWorkbook();
				HSSFCellStyle dateStyle = workbook.createCellStyle();
				HSSFDataFormat formatDate = workbook.createDataFormat();
				dateStyle.setDataFormat(formatDate
						.getFormat("yyy-mm-dd hh:mm:ss"));
				// 构造每个Sheet的数据
				for (int i = 0; i < sheetNum; i++) {
					int start = 0;
					int end = sheetSize;
					if (end < dataList.get(i).size()) {
					tempList = dataList.get(i).subList(start, end);
					} else {
						tempList = dataList.get(i).subList(start, dataList.get(i).size());
					}
					if (tempList.size() > 0) {
						// 为了避免标题与数据部统一，计算最小取值范围
						int titleLength=0;
						for (int j = 0; j < titles.get(i).length; j++) {
							if (titles.get(i)[j] != null) {
								titleLength++;
							}
						}
						Object[] tempTitle = new Object[titleLength];
						for (int j = 0, r = 0; j < titles.get(i).length; j++) {
							if (titles.get(i)[j] != null) {
								tempTitle[r++]=titles.get(i)[j];
							}
						}
						titles.set(i,tempTitle);
						int minCell = fields.get(i).length < titles.get(i).length ? fields.get(i).length
								: titles.get(i).length;
						// 构造新的Sheet
						sheet = workbook.createSheet(sheetNames[i]);
						
						// 构造表头
//						for (short m = 0; m < minCell; m++) {
//							if (titles[m]!=null) {
//								sheet.createRow(0).createCell(m).setCellValue(
//										titles[m].toString());
//							}
//						}
						HSSFRow row = sheet.createRow(0);
						for(int m = 0; m < titles.get(i).length; m++){
							HSSFCell cell = row.createCell(m);
							HSSFRichTextString text = new HSSFRichTextString(titles.get(i)[m].toString());
							cell.setCellValue(text);//把数据放到单元格中
						}
						// 构造每行数据
						for (int j = 1; j < tempList.size() + 1; j++) {
							row = sheet.createRow(j);
							Object object = tempList.get(j - 1);//数据对象
							if (object instanceof Object[]) {
								Object[] valueArray = (Object[]) object;
								for (int col = 0; col < minCell; col++) {
									HSSFCell cell = row.createCell(col);
									int fieldIndex;
									try {
										fieldIndex = Integer
										.parseInt(fields.get(i)[col]
										                 .toString());
									} catch (Exception e) {
										throw new Exception(
										BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.shouldBeIndex_n81i"));
									}
									Object value;
									try {
										value = valueArray[fieldIndex];
									} catch (RuntimeException e) {
										throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.rowDataErr_n81i")
												+ fieldIndex + BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.rowData_n81i"));
									}
									if(value != null && value instanceof String){
										value = BaseAction.getI18nText((String)value);
									}
									this.createCell(cell, dateStyle, value);
								}
							} else {
								for (int col = 0; col < minCell; col++) {
									HSSFCell cell = row.createCell(col);
									Object value = getValueByField(object,
											fields.get(i)[col].toString());
									if(value != null && value instanceof String){
										value = BaseAction.getI18nText((String)value);
									}
									this.createCell(cell, dateStyle, value);
								}
							}
						}
						if (this.autoSizeColumn) {
							for (short j = 0; j < fields.get(i).length; j++) {
								sheet.autoSizeColumn(j);
							}
						}
					}else{
						// 为了避免标题与数据部统一，计算最小取值范围
						int titleLength=0;
						for (int j = 0; j < titles.get(i).length; j++) {
							if (titles.get(i)[j] != null) {
								titleLength++;
							}
						}
						Object[] tempTitle = new Object[titleLength];
						for (int j = 0, r = 0; j < titles.get(i).length; j++) {
							if (titles.get(i)[j] != null) {
								tempTitle[r++]=titles.get(i)[j];
							}
						}
						titles.set(i,tempTitle);
						// 构造新的Sheet,并命名为文件名+编号
						sheet = workbook.createSheet(sheetNames[i]);
						HSSFRow row = sheet.createRow(0);
						for(int m = 0; m < titles.get(i).length; m++){
							HSSFCell cell = row.createCell(m);
							HSSFRichTextString text = new HSSFRichTextString(titles.get(i)[m].toString());
							cell.setCellValue(text);//把数据放到单元格中
						}
					}
				}
				workbook.write(out);
				if (out != null) {
					try {
						out.flush();
						out.close();
					} catch (IOException ioe) {
						System.out.println("ExportUtils.exportBigExcle()");
						throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.IOException_n81i") + ioe.getMessage());
					}
				}
			} catch (Exception e) {
				System.out.println("ExportUtils.exportBigExcle()");
				e.printStackTrace();
				throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.exportException_n81i") + e.getMessage());
			}
		} else {
			out.close();
			throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.outZoom_n81i"));
		}
		
	}

	/**
	 * 创建单元格
	 * 
	 * @param sheet
	 *            指定要创建单元格的Sheet分页
	 * @param dateStyle
	 *            时间格式（自动判断值是否为时间格式，如果是则转换单元格格式）
	 * @param row
	 *            行号
	 * @param cell
	 *            列号
	 * @param value
	 *            值
	 * @author ZhengXi 2010-8-27
	 */
	private void createCell(HSSFCell cellObj, HSSFCellStyle dateStyle,Object value) {
//		HSSFCell cellObj = sheet.createRow(row).createCell(cell);
		if (value instanceof Date) {
			cellObj.setCellValue((Date) value);
			cellObj.setCellStyle(dateStyle);
		} else if (value instanceof Long) {
			cellObj.setCellValue((Long) value);
		} else if (value instanceof Integer) {
			cellObj.setCellValue((Integer) value);
		} else if (value instanceof Calendar) {
			cellObj.setCellValue((Calendar) value);
			cellObj.setCellStyle(dateStyle);
		} else if (value instanceof Boolean) {
			cellObj.setCellValue((Boolean) value);
		} else if (value instanceof Double) {
			cellObj.setCellValue((Double) value);
		} else if (value instanceof BigDecimal) {
			cellObj.setCellValue((String) ((BigDecimal) value).toString());
		} else if (value instanceof Character) {
			cellObj.setCellValue((String) ((Character) value).toString());
		} else if (value instanceof SerializableClob) {
			SerializableClob clob = (SerializableClob)value;
			try {
				String desc = (clob==null || clob.length()==0)?"":clob.getSubString(1,Integer.parseInt(clob.length()+""));
				cellObj.setCellValue(desc);
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			cellObj.setCellValue((String) value);
		}
	}

	/**
	 * 指定对象，根据字段名获取属性值，支持获取无限关联对象的字段属性。
	 * 
	 * @param source
	 *            指定对象
	 * @param field
	 *            字段名，支持获取无限关联对象的字段属性。
	 *            <br/>(例如：获取用户字段对象的班级字段对象的name字段属性user.classes.name)
	 * @return 属性值
	 * @throws Exception
	 *             没有找到字段属性
	 * @author ZhengXi Jun 22, 2010 9:22:12 AM
	 */
	@SuppressWarnings("unchecked")
	private Object getValueByField(Object source, String field)
			throws Exception {
		// 获取字段集合，如果存在子字段则分割
		String[] fields = field.split("\\.");
		// 先获取第一个字段的对象
		Object tempObject = getFiledVale(source, fields[0]);
		if (tempObject == null) {
			return "";
		}
		// 如果存在子对象则递归取到最后一个字段的值
		if (fields.length > 1) {
			for (int i = 1; i < fields.length; i++) {
				tempObject = getFiledVale(tempObject, fields[i]);
				if (tempObject == null) {
					return "";
				}
			}
		}
		return tempObject;
	}

	/**
	 * 指定对象，根据字段名获取属性值
	 * 
	 * @param source
	 *            指定对象
	 * @param field
	 *            字段名
	 * @return 属性值
	 * @throws Exception
	 * @author ZhengXi Jun 22, 2010 9:24:10 AM
	 */
	@SuppressWarnings("unchecked")
	private Object getFiledVale(Object source, String field) throws Exception {
		Class sourceClass = source.getClass();
		// 转换字段的首字母为大写
		field = field.substring(0, 1).toUpperCase() + field.substring(1);
		// 获取源对象的get+Field方法
		Method sourceMethod = null;
		Object sourceValue = null;
		try {
			sourceMethod = sourceClass.getMethod("get" + field);
			// 支持私有字段获取
			sourceMethod.setAccessible(true);
			// 获取源对象的 field 属性的值
			sourceValue = sourceMethod.invoke(source);
		} catch (Exception e) {
			System.out.println("ExportUtils.getFiledVale()");
			throw new Exception(BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.get_n81i")+"[" + field + "]"+BaseAction.getI18nText("i18n_ExportUtils.exportExcel2Sheet.fieldErr_n81i")+":" + e.getMessage());
		}
		return sourceValue;
	}
}
