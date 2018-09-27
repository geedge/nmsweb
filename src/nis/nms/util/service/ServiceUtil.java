package nis.nms.util.service;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;

/**
 * 服务工具类，通过本类得到服务
 */
public final class ServiceUtil {

	/**
	 * Spring Context对象.
	 */
	private static ApplicationContext applicatonContext;
	
	/**
	 * @return applicatonContext
	 */
	public static ApplicationContext getApplicatonContext() {
		return applicatonContext;
	}

	/**
	 * @param applicatonContext
	 *            要设置的 applicatonContext
	 */
	public static void setApplicatonContext(ApplicationContext applicatonContext) {
		ServiceUtil.applicatonContext = applicatonContext;
	}

	/**
	 * 得到spring配置中的bean，bean的id的命名必须是该bean的类名！
	 */
	public static Object getServiceObject(Class c) {
		String name = c.getName();
		name = name.replaceFirst(c.getPackage().getName() + ".", "");
		return applicatonContext.getBean(name);
	}
	
	/**
	 * 得到spring配置中的bean，bean的id的命名必须是该bean的类名！
	 */
	public static Object getServiceObject(String name) {
		return ServiceUtil.getApplicatonContext().getBean(name);
	}
}