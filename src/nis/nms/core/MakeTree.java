/**
 * 
 */
package nis.nms.core;

import java.io.Reader;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import nis.nms.util.SortByStringChar;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;
/**
 * @author Administrator
 *
 */
public class MakeTree {

//	public static List getResourceList(Element resources){
//		List list = getList(resources);
//		return list;
//	}
//
//	private static List getList(Element resources) {
//		List list1 = new ArrayList();
//		List list = new ArrayList();
//		getElement(resources, list1);
//		A:for(int i = 0 ; i < list1.size() ; i++ ){
//			Resource resource1 = new Resource();
//			resource1 = (Resource) list1.get(i);
//			for( int k = 0 ; k < list1.size() ; k++ ){
//				Resource resource2 = new Resource();
//				resource2 = (Resource) list1.get(k);
//				if( resource1.getRsCode().longValue() > resource2.getRsCode().longValue() ){//排序？？？？
//					continue A;
//				}
//			}
//			list.add(resource1);
//			list1.remove(i);
//			i = -1;
//		}
//		return list;
//	}
	
	//递归遍历,取出所有的值,排列成一个集合
//	private static Element getElement(Element resources, List list) {
//		List resourceList = resources.getChildren(Constants.XML_FILE_NODE);
//		Element resourcesElement = null;
//		Resource resource = new Resource();
//		if(resourceList != null && resourceList.size() > 0){
//			for( int i = 0 ; i < resourceList.size() ; i++ ){
//				resourcesElement = (Element) resourceList.get(i);
//				resource = new Resource();
//				getResourcePro(resourcesElement, resource);
//				if(!resourcesElement.getAttributeValue(Constants.XML_FILE_NODE_RSCODE).equals("999999")){
//				list.add(resource);
//				}
//				if(resourcesElement.getChildren(Constants.XML_FILE_NODE) != null 
//						&& resourcesElement.getChildren(Constants.XML_FILE_NODE).size() > 0){
//					getElement(resourcesElement, list);
//				}
//			}
//		}
//		
//		return resourcesElement;
//	}
	
//	private static void getResourcePro(Element resources, Resource resource) {
//		//rsid
//		if(resources.getAttributeValue(Constants.XML_FILE_NODE_RSID) != null 
//				&& !resources.getAttributeValue(Constants.XML_FILE_NODE_RSID).equals("")){
//			resource.setRsid(new Long(resources.getAttributeValue(Constants.XML_FILE_NODE_RSID)));
//		}
//		//rsname
//		if(resources.getAttributeValue(Constants.XML_FILE_NODE_RSNAME) != null 
//				&& !resources.getAttributeValue(Constants.XML_FILE_NODE_RSNAME).equals("")){
//			resource.setRsname(resources.getAttributeValue(Constants.XML_FILE_NODE_RSNAME));
//		}
//		//number
//		if(resources.getAttributeValue(Constants.XML_FILE_NODE_NUMBER) != null 
//				&& !resources.getAttributeValue(Constants.XML_FILE_NODE_NUMBER).equals("")){
//			resource.setNumber(new Long(resources.getAttributeValue(Constants.XML_FILE_NODE_NUMBER)));
//		}
//		//rsdesc
//		if(resources.getAttributeValue(Constants.XML_FILE_NODE_RSDESC) != null 
//				&& !resources.getAttributeValue(Constants.XML_FILE_NODE_RSDESC).equals("")){
//			resource.setRsdesc(resources.getAttributeValue(Constants.XML_FILE_NODE_RSDESC));
//		}
//		//rsaddress
//		if(resources.getAttributeValue(Constants.XML_FILE_NODE_RSADDRESS) != null 
//				&& !resources.getAttributeValue(Constants.XML_FILE_NODE_RSADDRESS).equals("")){
//			resource.setRsaddress(resources.getAttributeValue(Constants.XML_FILE_NODE_RSADDRESS));
//		}
//		//business
//		if(resources.getAttributeValue(Constants.XML_FILE_NODE_BUSINESS) != null 
//				&& !resources.getAttributeValue(Constants.XML_FILE_NODE_BUSINESS).equals("")){
//			resource.setBusiness(resources.getAttributeValue(Constants.XML_FILE_NODE_BUSINESS));
//		}
//		//rsCode
//		if(resources.getAttributeValue(Constants.XML_FILE_NODE_RSCODE) != null 
//				&& !resources.getAttributeValue(Constants.XML_FILE_NODE_RSCODE).equals("")
//				&& !resources.getAttributeValue(Constants.XML_FILE_NODE_RSCODE).equals("999999")){
//			resource.setRsCode(new Long(resources.getAttributeValue(Constants.XML_FILE_NODE_RSCODE)));
//		}else{
//			resource.setRsCode(new Long(-1));
//		}
//		//parRsCode
//		if(resources.getParentElement().getAttributeValue(Constants.XML_FILE_NODE_RSCODE) != null 
//				&& !resources.getParentElement().getAttributeValue(Constants.XML_FILE_NODE_RSCODE).equals("")
//				&& !resources.getParentElement().getAttributeValue(Constants.XML_FILE_NODE_RSCODE).equals("999999")){
//			resource.setParRsCode(new Long(resources.getParentElement().getAttributeValue(Constants.XML_FILE_NODE_RSCODE)));
//		}else{
//			resource.setParRsCode(new Long(-1));
//		}
//	} 
	
	
	/**
	 * @param args
	 */
//	public static void main(String[] args) {
//		// TODO 自动生成方法存根
//		SAXBuilder builder = new SAXBuilder();
//		Element resources = null;
//		try{
//			//将xml字符串序列化,生成一个树型枚举对象
//			Reader read = new StringReader(Constants.XML_FILE);
//			Document read_doc = builder.build(read);
//			resources = read_doc.getRootElement();
//			List list = getResourceList(resources);
//			for( int i = 0 ; i < list.size() ; i++ ){
//				Resource resource = (Resource) list.get(i);
//			}
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//	}
	
//	public static Element getTestElement() {
//		SAXBuilder builder = new SAXBuilder();
//		Element resources = null;
//		try{
//			//将xml字符串序列化,生成一个树型枚举对象
//			Reader read = new StringReader(Constants.XML_FILE);
//			Document read_doc = builder.build(read);
//			resources = read_doc.getRootElement();
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//		return resources;
//	}
	//获取一级节点列表
	public static List getRootResourceList(List treeList){
		List rootList = new ArrayList();		
		for(int i =0;i<treeList.size();i++){
			Resource resource = (Resource)treeList.get(i);//0为pid,1为mkbh,2为mkmc,3为mkms,4为mkurl,5为mktb
			if("0".equals(resource.getParRsCode())){
				rootList.add(resource);
			}
		}
		//Comparator comp1 = new SortByStringChar();
		//Collections.sort(rootList, comp1);
		return rootList;
		
	}
	
	//获取二或三级节点列表
	public static List getotherResourceList(List treeList,String parentId){
		List secondList = new ArrayList();		
		for(int i =0;i<treeList.size();i++){
			Resource resource = (Resource)treeList.get(i);//0为pid,1为mkbh,2为mkmc,3为mkms,4为mkurl,5为mktb
			if(resource.getParRsCode().equals(parentId)){
				secondList.add(resource);
			}
		}	
		return secondList;
		
	}
	
	//根据父节点获取子节点列表
	public static List getSonResourceList(String pid,List treeList){
		List sonList = new ArrayList();
//		List list = getResourceList(resources);
		if(treeList!=null && treeList.size()>0){
			List rootList = getRootResourceList(treeList);
			//如果pid为空，则获取第一个根节点的id
			if(pid==null || "".equals(pid)){
				Resource resource1 = (Resource) rootList.get(0);
				pid = resource1.getRsid();
			}
			//找到父节点为传入pid的子节点，生成list
			for (int i = 0;i<treeList.size();i++){
				Resource resource1 = (Resource) treeList.get(i);
				if(resource1.getParRsCode().equals(pid) || resource1.getRsid().equals(pid)){
					resource1 = setPosition(resource1,treeList);
					sonList.add(resource1);						
				}			
			}
			//找到父节点为pid的子节点后，寻找子节点的子节点，生成list
			for(int j = 0;j<sonList.size();j++){
				Resource resource2 = (Resource) sonList.get(j);
				if(!resource2.getParRsCode().equals("0")){
					//System.out.println("rsCode2222==>" + resource2.getRsCode());
					for(int k = 0;k<treeList.size();k++){
						Resource resource3 = (Resource) treeList.get(k);
					//	System.out.println("parRsCode3333==>" + resource3.getParRsCode() );
						if(resource2.getRsCode().equals(resource3.getParRsCode())){
							resource3 = setPosition(resource3,treeList);
							sonList.add(resource3);
						}
					}
				}		
			}
			//Comparator comp1 = new SortByStringChar();
			//Collections.sort(sonList, comp1);
		}		
		return sonList;
	}
	//获取每个节点位置，目前以4级节点为限
	public static Resource setPosition(Resource resource,List list){		
		String[] strName = new String[4];
		String sid = resource.getRsid();
		String pid = resource.getParRsCode();
		resource.setPosition("");//先清空位置信息
		for(int i=0;i<4;i++){
			for(int j = 0;j<list.size();j++){
				Resource resource1 = (Resource)list.get(j);
				if(resource1.getRsid().equals(sid)){
					strName[i] = resource1.getRsname();
					sid = resource1.getParRsCode();
					break;
				}			
			}
		}
		for(int i = 3;i>=0;i--){
			if(strName[i]!= null && strName[i].length()>0){
				if(resource.getPosition()==null || "".equals(resource.getPosition())){
					resource.setPosition("["+strName[i]+"]");
				}else{
					resource.setPosition(resource.getPosition()+"-["+strName[i]+"]");
				}			
			}
		}
		return resource;
	}
	
	//获取所有节点信息
	public static List getAllResourceList(List treeList){
		List sonList = new ArrayList();
		if(treeList!=null && treeList.size()>0){
			//找到父节点为传入pid的子节点，生成list
			for (int i = 0;i<treeList.size();i++){
				Resource resource1 = (Resource) treeList.get(i);
				/*if(resource1.getParRsCode().equals("0") || resource1.getRsid().equals("0")){
					sonList.add(resource1);						
				}*/
				if(resource1.getParRsCode().equals("0") || resource1.getRsid().equals("0")){
					if(!(resource1.getParRsCode().equals("0") && resource1.getRsid().equals("0"))){
						sonList.add(resource1);		
					}
				}
			}
			//找到父节点为pid的子节点后，寻找子节点的子节点，生成list
			for(int j = 0;j<sonList.size();j++){
				Resource resource2 = (Resource) sonList.get(j);
					for(int k = 0;k<treeList.size();k++){
						Resource resource3 = (Resource) treeList.get(k);
						if(resource2.getRsCode().equals(resource3.getParRsCode())){
							sonList.add(resource3);
						}
					}		
			}
			Comparator comp1 = new SortByStringChar();
			Collections.sort(sonList, comp1);
		}		
		return sonList;
	}
	
	public static List<Resource> getResourceSortbyVaildAndId(List<?> treeList){
		List<Resource> sonList = new ArrayList<Resource>();
		if (treeList != null && treeList.size() > 0) {
			
			// 找到父节点为传入PID的子节点，生成LIST
			for (Object resourceObj : treeList) {
				Resource resource = (Resource) resourceObj;
				if(resource.getParRsCode().equals("0") || resource.getRsid().equals("0")){
					if(!(resource.getParRsCode().equals("0") && resource.getRsid().equals("0"))){
						sonList.add(resource);		
					}
				}
			}
			// 找到父节点为PID的子节点后，寻找子节点的子节点，添加LIST
			for (int i = 0; i < sonList.size(); i++) {
				Resource parResource = sonList.get(i); 
				for (Object resourceObj : treeList) {
					Resource resource = (Resource) resourceObj;
					if (parResource.getRsCode().equals(resource.getParRsCode())) {
						sonList.add(resource);
					}
				}
			}
			// 根据节点有效标志、节点编号排序（先有效1、再无效0；编号升序）
			Collections.sort(sonList, new Comparator<Resource>() {
				public int compare(Resource resA, Resource resB) {
					int isVaildA = resA.getIsValid();
					int isVaildB = resB.getIsValid();
					if (isVaildA != isVaildB) {
						return -1 * (isVaildA - isVaildB);
					}
					
					String value1 = String.valueOf(resA.getRsid());
					String value2 = String.valueOf(resB.getRsid());
					return value1.compareTo(value2);
				}
			});
			
		}
		return sonList;
	}
}
