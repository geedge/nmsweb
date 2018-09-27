package nis.nms.util.jxls;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.jxls.reader.ReaderBuilder;
import net.sf.jxls.reader.XLSReadStatus;
import net.sf.jxls.reader.XLSReader;

import org.xml.sax.SAXException;

public class ReadExcel<T> {
//	
//	protected Class<T> entityClass;
//	
//	public ReadExcel(Class<T> entityClass){
//		
//	}
	
//	private final static String xmlConfig="student.xml";
//	private List read(){
//		InputStream inputXML = new BufferedInputStream(ReadExcel.class.getResourceAsStream(xmlConfig));
//        XLSReader mainReader;
////        String path=ReadExcel.class.getResource("/").getPath();
////        path=path.substring(1,path.indexOf("/WebRoot")+1)+"WebRoot/Excel/stu.xls";
//        String path = System.getProperty("user.dir");
//        path = path.replace("\\", "/") + "/" + "Excel/stu.xls";
//		try {
//			mainReader = ReaderBuilder.buildFromXML(inputXML);
//			 InputStream inputXLS = new BufferedInputStream(new FileInputStream(path));
//		        Student stu=new Student();
//		        List students = new ArrayList();
//		        Map beans = new HashMap();
//		        beans.put("stu", stu);
//		        beans.put("students", students);
//		        XLSReadStatus readStatus = mainReader.read(inputXLS, beans);
//		        return students;
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (SAXException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		return null;
//	}
	
	public List<T> read(String configXml, BufferedInputStream inputXLS, String[] beanNames){
//        String path = System.getProperty("user.dir");
//        path = path.replace("\\", "/") + xmlConfig;
		try {
//		InputStream inputXML = new BufferedInputStream(getClass().getResourceAsStream(xmlConfig));
		InputStream inputXML = new BufferedInputStream(new FileInputStream(configXml));
		XLSReader mainReader = ReaderBuilder.buildFromXML(inputXML);
		    Map property = new HashMap();
		    List<T> list = new ArrayList();
			T bean = (T) Class.forName(beanNames[0]).newInstance();
			property.put(beanNames[1], bean);
			property.put(beanNames[2], list);
			XLSReadStatus readStatus = mainReader.read(inputXLS, property);
		    return list;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public List<T> readXls(String configXml, String configXLS, String[] beanNames){
		try {
			BufferedInputStream inputXLS = new BufferedInputStream(new FileInputStream(configXLS));
			ReadExcel re = new ReadExcel();
			List<T> list = re.read(configXml, inputXLS, beanNames);
			return list;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return null;
	}
	
//	public static void main(String[] args) {
//	try {
//	ReadExcel re = new ReadExcel();
//    String path = System.getProperty("user.dir");
//    path = path.replace("\\", "/") + "/WebRoot/Excel/";
////    List list1 = new ArrayList();
////    list1.add(new String[]{"nis.ysp.util.jxls.Student", "stu", "students"});
//    BufferedInputStream inputXLS = new BufferedInputStream(new FileInputStream(path+"stu.xls"));
//	List<Student> list = re.read(path+"student.xml", inputXLS, new String[]{"nis.ysp.util.jxls.Student", "stu", "students"});
//	for(Student stu:list){
//		System.out.println(stu.getIdname()+"\t  "+stu.getName()+"\t  "+stu.getSubject()+"\t  "+stu.getScorename()+"\t  "+stu.getScore());
//	}
//	} catch (Exception e) {
//		// TODO Auto-generated catch block
//		e.printStackTrace();
//	}
//}
	
//	public static void main(String[] args) {
//		try {
//		ReadExcel re = new ReadExcel();
//        String path = System.getProperty("user.dir");
//        path = path.replace("\\", "/") + "/WebRoot/Excel/stu.xls";
//        List list1 = new ArrayList();
//        list1.add(new String[]{"nis.ysp.util.jxls.Student", "stu", "students"});
//		InputStream inputXLS = new BufferedInputStream(new FileInputStream(path));
//		List<Student> list = re.read("../../../../student.xml", inputXLS, list1);
//		for(Student stu:list){
//			System.out.println(stu.getIdname()+"\t  "+stu.getName()+"\t  "+stu.getSubject()+"\t  "+stu.getScorename()+"\t  "+stu.getScore());
//		}
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}
}
