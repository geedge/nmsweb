package nis.nms.util;

import org.hibernate.FlushMode;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.SessionFactoryUtils;
import org.springframework.orm.hibernate3.SessionHolder;
import org.springframework.transaction.support.TransactionSynchronizationManager;

public class HibernateUtil {
	
	/**
	 * 将hibernate的会话绑定给一个线程
	 * @param sessionFactory
	 * @return
	 */
	public static boolean bindHibernateSessionToThread(SessionFactory sessionFactory) {
		if (TransactionSynchronizationManager.hasResource(sessionFactory)) {
			return true;
		} else {
			Session session = sessionFactory.openSession();
			session.setFlushMode(FlushMode.MANUAL);
			SessionHolder sessionHolder = new SessionHolder(session);
			TransactionSynchronizationManager.bindResource(sessionFactory, sessionHolder);
		}
		return false;
	}
	
	/**
	 * 将线程上绑定的hibernate会话关闭
	 * @param participate
	 * @param sessionFactory
	 */
	public static void closeHibernateSessionFromThread(boolean participate, Object sessionFactory) {
        if (!participate) {
            SessionHolder sessionHolder = (SessionHolder)TransactionSynchronizationManager.unbindResource(sessionFactory);
            SessionFactoryUtils.closeSession(sessionHolder.getSession());
        }
    }
}
