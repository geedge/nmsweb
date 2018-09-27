package nis.nms.util;

import java.lang.reflect.Array;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;

import nis.nms.domains.Brand;

import org.apache.commons.lang.StringUtils;

/**
 * 
 * 去掉对象中String类型字段的空格(对于对象中的List类型的属性暂时无法处理)
 * TODO nmswebnis.nms.utilFormBeanUtil.java
 * @author Administrator
 * @version 1.0
 */
public class FormBeanUtil {
	
	/**
	 * 
	 * 去掉实体类中参数为STRING类型的属性的前后空格 
	 * @author Administrator Mar 31, 2012
	 * @version 1.0 
	 * @param model
	 * @throws Exception
	 */
	public static void stripStringProperty(Object model) throws Exception {
		Class clazz = model.getClass();
		// Object target = clazz.newInstance();
		
		Method[] methods = clazz.getMethods();// 获取所有方法
		String getterMethodName;// getter方法
		String setterMethodName;// setter方法
		Object propertyValue;// 属性值
		
		for (Method m: methods) {
			if (m.getName().startsWith("get") && m.getModifiers() == Modifier.PUBLIC) {// 获取public类型的getter方法
				getterMethodName = m.getName();
				propertyValue = m.invoke(model, null);// 获取属性值
				
				if (propertyValue == null) {
					continue;
				}
				// String 类型
				if (propertyValue.getClass().getName().equals("java.lang.String")) {
					setterMethodName = "set" + getterMethodName.substring(3);// 拼setter方法
					Method setterMethod = clazz.getMethod(setterMethodName,new Class[] { String.class });// 反射得到setter方法
					if (isSetterMethodExist(clazz, setterMethodName)) {
						setterMethod.invoke(model, StringUtils.strip((String) propertyValue));
					}
				}
				
				// String[]数组类型
				Class propertyValueClass = propertyValue.getClass();
				if (propertyValueClass.isArray()) {// 如果属性值的类型为数组
					Class elementType = propertyValueClass.getComponentType();
					if (elementType.getName().equals("java.lang.String")) {// 数组元素类型为String
						int length = Array.getLength(propertyValue);// 数组长度
						for (int i = 0; i < length; i++) {
							String arrayElementValue = (String) Array.get(propertyValue, i);// 获取数组元素值
							Array.set(propertyValue, i, StringUtils.strip(arrayElementValue));// 去前后空格后，再设回数组
						}
					}
				}
//				//复合类型
//				if (propertyValueClass.isSynthetic()) {// 如果属性值的类型为复合类型，如List
//					stripStringProperty(propertyValueClass);
//					System.out.println("fuhelexing=============");
//				}
			}
		}
	}
	
	
	/**
	 * 
	 * 判断CLASS中是否包含public的setter方法，且返回值为string类型 
	 * @author Administrator Mar 31, 2012
	 * @version 1.0 
	 * @param clazz
	 * @param setterName
	 * @return
	 */
	private static boolean isSetterMethodExist(Class clazz, String setterName) {
		Method[] methods = clazz.getMethods();
		for (Method m: methods)	{
			if (m.getName().equals(setterName) && m.getModifiers() == Modifier.PUBLIC) {// 匹配setter方法且是public
				Class[] paramTypes = m.getParameterTypes();
				for (Class c: paramTypes) {
					if (c.getName().equals("java.lang.String"))	{// setter方法参数类型为String
						return true;
					}
				}
			}
		}
		
		return false;
	}
			
	public static void main(String[] args) throws Exception {
		Brand f = new Brand();
		f.setId(new Long(232));
		f.setBrandDesc("  desc  aa  ");
		f.setBrandName("   ddd ");
		
		FormBeanUtil.stripStringProperty(f);
		
		System.out.println(f.getBrandDesc());
	}
}