package nis.nms.util;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;

import org.apache.log4j.Logger;

public class GenericUtils {
	private static Logger logger = Logger.getLogger(GenericUtils.class);
	
	private GenericUtils(){}
	
	@SuppressWarnings("unchecked")
	public static Class getGenericSuperclassType(Class clazz){
		return getGenericSuperclassType(clazz, 0);
	}
	
	/**
	 * 通过反射,获得定义Class时声明的父类的泛型参数的类型. 如public BookManager extends GenericManager<Book>
	 * @param clazz clazz The class to introspect
	 * @param index the Index of the generic ddeclaration,start from 0.
	 * @return the index generic declaration, or <code>Object.class</code> if cannot be determined
	 */
	@SuppressWarnings("unchecked")
	public static Class getGenericSuperclassType(Class clazz, int index) {

		Type type = clazz.getGenericSuperclass();
		if (!(type instanceof ParameterizedType)) {
			logger.warn(clazz.getSimpleName() + "'s superclass not ParameterizedType");
			return Object.class;
		}
		Type[] args = ((ParameterizedType) type).getActualTypeArguments();
		if (index < 0 || index >= args.length) {
			logger.warn("Index: " + index + ", Size of " + clazz.getSimpleName() + "'s Parameterized Type: "
					+ args.length);
			return Object.class;
		}
		if (!(args[index] instanceof Class)) {
			logger.warn(clazz.getSimpleName() + " not set the actual class on superclass generic parameter");
			return Object.class;
		}
		return (Class) args[index];
	}	
}
