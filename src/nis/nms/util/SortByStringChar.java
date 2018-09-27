package nis.nms.util;
import java.util.Comparator;

import nis.nms.core.Resource;

@SuppressWarnings("unchecked")
public class SortByStringChar implements Comparator{

 @Override
 	/**菜单排序，根据模块编号升序*/
	 public int compare(Object o1, Object o2) {
	//  String string1 = (String) o1;
	//  String string2 = (String) o2;
		Resource obj1 = (Resource) o1;
		Resource obj2 = (Resource) o2;
	//  String str1 = String.valueOf(string1.charAt(0));
	//  String str2 = String.valueOf(string2.charAt(0));
		String value1 = String.valueOf(obj1.getRsid());
		String value2 = String.valueOf(obj2.getRsid());
		if (value1.compareTo(value2)>0) {
		  return 1;
		} else {
		  return 0;
		}
	}
}

