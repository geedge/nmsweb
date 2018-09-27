package com.nms.objectSnmp.util;

public class FormatUtil {
	public static String changType(String type){
		String resu="";
		if(type.equals("int") || type.equals("long")){
			resu="NUMBER";
		}else if(type.equals("String")){
			resu="VARCHAR2(400)";
		}
		return resu;
	}
	
	public static String formatBeanName(String oldName){
		String resu="";
		if(oldName!=null && !"".equals(oldName)){
			if(oldName.startsWith("DI_")){
				resu = oldName.substring(3,oldName.length());
			}else{
				resu=oldName;
			}
		}
		return resu;
	}
}
