package nis.nms.persistence;


import java.io.Serializable;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.beanutils.PropertyUtils;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.impl.CriteriaImpl;
import org.hibernate.metadata.ClassMetadata;
import org.hibernate.transform.Transformers;
import org.springframework.context.support.FileSystemXmlApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.util.Assert;
import org.springframework.util.ReflectionUtils;

import nis.nms.util.BaseAction;
import nis.nms.util.BeanUtils;
import nis.nms.util.GenericUtils;
import nis.nms.util.Page;
@SuppressWarnings("unchecked")
public class HibernateGeneralDaoImpl<T> extends HibernateDaoSupport implements HibernateGeneralDao<T> {
	private Class<T> entityClass;
	private String message;
	private Session txSession;
	/**
	 * 是否使用事务标识，声明式 事务不起作用，全部改为 在 action 中 手动开启 并 手动关闭
	 */
	private Transaction tx;
	private boolean txFlag = false;
	
	/**
	 * 通过反射得到父类的类型
	 */
	public HibernateGeneralDaoImpl(){
		entityClass = GenericUtils.getGenericSuperclassType(getClass());
	}

	public Session getLocalSession(){
		if(txSession == null){
			txSession = this.getSession();
		}
		return txSession;
	}
	/**
	 * 开启事务
	 * @return
	 */
	public Transaction beginTransaction(){
		try {
			if(!isTransaction()){
				txSession = this.getSession();
				tx = txSession.beginTransaction();
				txFlag = true;
			}
		} catch (Exception e) {
			txFlag = false;
			throw new RuntimeException(e);
		}
		return tx;
	}
	
	/**
	 * 是否已经开启事务
	 * @return
	 */
	public boolean isTransaction(){
		return txFlag && tx.isActive();
	}
	
	/**
	 * 提交事务
	 */
	public void commit(){
		try {
			if(isTransaction()){
				txSession.flush();
				tx.commit();
				txFlag = false;
				txSession.clear();
				tx = null;
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 回滚 事务
	 * @param transaction
	 */
	public void rollback(){
		try {
			if(isTransaction()){
				tx.rollback();
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		} finally {
			txFlag = false;
			try {
				txSession.clear();
			} catch (Exception e2) {}
			tx = null;
		}
	}
	
	@Override
	public void save(Object entity) throws Exception {
		if(txFlag){
			getLocalSession().save(entity);
		}else{
			Session ss = null;
			Transaction tx = null;
			try {
				ss = getLocalSession();
				tx = ss.beginTransaction();
				tx.begin();
				ss.save(entity);
				ss.flush();
				tx.commit();
			} catch (Exception e) {
				tx.rollback();
				throw e;
			} finally {
				try {
					ss.clear();
				} catch (Exception e2) {}
			}
		}
	}
	
	@Override
	public void saveAll(Object entity) throws Exception {
		if(txFlag){
			getLocalSession().save(entity);
			flush();
		}else{
			Session ss = null;
			Transaction tx = null;
			try {
				ss = getLocalSession();
				tx = ss.beginTransaction();
				tx.begin();
				ss.save(entity);
				ss.flush();
				tx.commit();
			} catch (Exception e) {
				tx.rollback();
				throw e;
			} finally {
				try {
					ss.clear();
				} catch (Exception e2) {}
			}
		}
	}
	
	@Override
	public void update(Object entity) throws Exception {
		if(txFlag){
			getLocalSession().update(entity);
			flush();
		}else{
			Session ss = null;
			Transaction tx = null;
			try {
				ss = getLocalSession();
				tx = ss.beginTransaction();
				tx.begin();
				ss.update(entity);
				ss.flush();
				tx.commit();
			} catch (Exception e) {
				tx.rollback();
				throw e;
			} finally {
				try {
					ss.clear();
				} catch (Exception e2) {}
			}
		}
	}

	@Override
	public void updateByHql(String hql, Object... values) throws Exception {
		hql = OracleToMysql.trans(hql);
		Session ss = getLocalSession();
		Query query = ss.createQuery(hql);
		if(txFlag){
			if (values != null) {
				//依次向HQL中的"?"占位符填入参数
				for (int i=0; i<values.length; i++){
					query.setParameter(i, values[i]);
				}
			}
			query.executeUpdate();
			flush();
		}else{
			Transaction tx = null;
			try {
				ss = getLocalSession();
				tx = ss.beginTransaction();
				tx.begin();
				if (values != null) {
					//依次向HQL中的"?"占位符填入参数
					for (int i=0; i<values.length; i++){
						query.setParameter(i, values[i]);
					}
				}
				query.executeUpdate();
				ss.flush();
				tx.commit();
			} catch (Exception e) {
				tx.rollback();
				throw e;
			} finally {
				try {
					ss.clear();
				} catch (Exception e2) {}
			}
		}
	}

	@Override
	public void saveOrUpdate(Object entity) throws Exception {
		if(txFlag){
			getLocalSession().saveOrUpdate(entity);
			flush();
		}else{
			Session ss = null;
			Transaction tx = null;
			try {
				ss = getLocalSession();
				tx = ss.beginTransaction();
				tx.begin();
				ss.saveOrUpdate(entity);
				ss.flush();
				tx.commit();
			} catch (Exception e) {
				tx.rollback();
				throw e;
			} finally {
				try {
					ss.clear();
				} catch (Exception e2) {}
			}
		}
	}

	@Override
	public void saveOrUpdate(Collection<T> entities) throws Exception {
		Session session = getLocalSession();
		if(txFlag){
			if(entities != null && entities.size() > 0){
				Iterator<T> iterator = entities.iterator();
				while(iterator.hasNext()){
					session.saveOrUpdate(iterator.next());
				}
			}
			flush();
		}else{
			Transaction tx = null;
			try {
				tx = session.beginTransaction();
				tx.begin();
				if(entities != null && entities.size() > 0){
					Iterator<T> iterator = entities.iterator();
					while(iterator.hasNext()){
						session.saveOrUpdate(iterator.next());
						
					}
				}
				session.flush();
				tx.commit();
			} catch (Exception e) {
				tx.rollback();
				throw e;
			} finally {
				try {
					session.clear();
				} catch (Exception e2) {}
			}
		}
	}

	@Override
	public void delete(Object entity) throws Exception {
		if(txFlag){
			getLocalSession().delete(entity);
			flush();
		}else{
			Session ss = null;
			Transaction tx = null;
			try {
				ss = getLocalSession();
				tx = ss.beginTransaction();
				tx.begin();
				ss.delete(entity);
				ss.flush();
				tx.commit();
			} catch (Exception e) {
				tx.rollback();
				throw e;
			} finally {
				try {
					ss.clear();
				} catch (Exception e2) {}
			}
		}
	}

	public void delete(Serializable id) throws Exception {
		if(txFlag){
			getLocalSession().delete(get(id));
			flush();
		}else{
			Session ss = null;
			Transaction tx = null;
			try {
				ss = getLocalSession();
				tx = ss.beginTransaction();
				tx.begin();
				ss.delete(get(id));
				ss.flush();
				tx.commit();
			} catch (Exception e) {
				tx.rollback();
				throw e;
			} finally {
				try {
					ss.clear();
				} catch (Exception e2) {}
			}
		}
	}
	
	public void delete(String entityName, Serializable id) throws Exception {
		String hql = "DELETE FROM " + entityName + " WHERE id=?";
		hql = OracleToMysql.trans(hql);
		Session ss = getLocalSession();
		Query query = ss.createQuery(hql);
		if(txFlag){
			query.setParameter(0, id);
			query.executeUpdate();
			flush();
		}else{
			Transaction tx = null;
			try {
				ss = getLocalSession();
				tx = ss.beginTransaction();
				tx.begin();
				query.setParameter(0, id);
				query.executeUpdate();
				ss.flush();
				tx.commit();
			} catch (Exception e) {
				tx.rollback();
				throw e;
			} finally {
				try {
					ss.clear();
				} catch (Exception e2) {}
			}
		}
	}
	
	public void delete(String hql) throws Exception {
//		getHibernateTemplate().bulkUpdate(hql);
		delete(hql,null);
	}

	
	@Override
	public void delete(Class<T> entityClass, String propertyName, Object propertyValue) throws Exception {
		String hql = "DELETE FROM " + entityClass.getName() + " WHERE " + propertyName + "=?";
		hql = OracleToMysql.trans(hql);
		Session ss = getLocalSession();
		Query query = ss.createQuery(hql);
		if(txFlag){
			query.setParameter(0, propertyValue);
			query.executeUpdate();
			flush();
		}else{
			Transaction tx = null;
			try {
				ss = getLocalSession();
				tx = ss.beginTransaction();
				tx.begin();
				query.setParameter(0, propertyValue);
				query.executeUpdate();
				ss.flush();
				tx.commit();
			} catch (Exception e) {
				tx.rollback();
				throw e;
			} finally {
				try {
					ss.clear();
				} catch (Exception e2) {}
			}
		}
	}

	@Override
	public void delete(String hql, Object... values) throws Exception {
		Session ss = getLocalSession();
		Query query = ss.createQuery(hql);
		if(txFlag){
			if(values != null){
				for(int i = 0,j= values.length;i<j;i++){
					query.setParameter(i, values[i]);
				}
			}
			query.executeUpdate();
			flush();
		}else{
			Transaction tx = null;
			try {
				ss = getLocalSession();
				tx = ss.beginTransaction();
				tx.begin();
				if(values != null){
					for(int i = 0,j= values.length;i<j;i++){
						query.setParameter(i, values[i]);
					}
				}
				query.executeUpdate();
				ss.flush();
				tx.commit();
			} catch (Exception e) {
				tx.rollback();
				throw e;
			} finally {
				try {
					ss.clear();
				} catch (Exception e2) {}
			}
		}
	}

	@Override
	public void flush() throws Exception {
		getLocalSession().flush();
	}

	@Override
	public void clear() throws Exception {
		getLocalSession().clear();
	}

	@Override
	public void evict(Object entity) throws Exception {
		getLocalSession().evict(entity);
	}

	@Override
	public T get(Serializable id) throws Exception {
		return (T) getLocalSession().get(this.entityClass, id);
	}

	@Override
	public T get(Class<T> entityClass, Serializable id) throws Exception {
		return (T) getLocalSession().get(entityClass, id);
	}

	@Override
	public T load(Serializable id) throws Exception {
		return (T) getLocalSession().load(this.entityClass, id);
	}

	@Override
	public T load(Class<T> entityClass, Serializable id) throws Exception {
		return (T) getLocalSession().load(entityClass, id);
	}

	@Override
	public List loadAll() throws Exception {
		return loadAll(this.entityClass);
//		return getHibernateTemplate().loadAll(this.entityClass);
	}

	@Override
	public List loadAll(Class<T> entityClass) throws Exception {
		Criteria criteria = getLocalSession().createCriteria(entityClass);
		return criteria.list();
//		return getHibernateTemplate().loadAll(entityClass);
	}

	@Override
	public List findAll() throws Exception {
		return getHibernateTemplate().findByCriteria(DetachedCriteria.forClass(this.entityClass));
	}

	@Override
	public List findAll(Class<T> entityClass) throws Exception {
		return getHibernateTemplate().findByCriteria(DetachedCriteria.forClass(entityClass));
	}

	@Override
	public List findAll(Class<T> entityClass, boolean isAsc, String orderPropertyName) throws Exception {
		Assert.hasText(orderPropertyName);
		Order order = null;
		if (isAsc){
			order = Order.asc(orderPropertyName);
		}else{
			order = Order.desc(orderPropertyName);
		}
		return getHibernateTemplate().findByCriteria(DetachedCriteria.forClass(entityClass).addOrder(order));
	}


	@Override
	public List find(String hql, Object... values) throws Exception {
		Assert.hasText(hql);
		hql = OracleToMysql.trans(hql);
		return getHibernateTemplate().find(hql, values);
	}

	@Override
	public List<T> find(String hql, int startIndex, int pageSize, Object... values) throws Exception {
		Query query = getLocalSession().createQuery(hql);
		query.setFirstResult(startIndex);
		query.setMaxResults(pageSize);
		if (values != null) {
			//向HQL中的占位符填入参数
			for (int i=0; i<values.length; i++){
				query.setParameter(i, values[i]);
			}
		}
		return query.list();
	}

	@Override
	public List executeSQL(String sql, Object... values) throws Exception {
		Assert.hasText(sql);
		sql = OracleToMysql.trans(sql);
		Query query = getLocalSession().createSQLQuery(sql);
		if (values != null) {
			for(int i = 0; i < values.length; i++){
				query.setParameter(i, values[i]);
			}
		}
		return query.list();
	}


	/**
	 * 返回 map
	 * @param sql
	 * @param values
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,Object>> executeSQLMap(String sql, Object... values) throws Exception {
		Assert.hasText(sql);
		sql = OracleToMysql.trans(sql);
		Query query = getLocalSession().createSQLQuery(sql).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
		if (values != null) {
			for(int i = 0; i < values.length; i++){
				query.setParameter(i, values[i]);
			}
		}
		return query.list();
	}
	
	public int executeSQLDelete(String sql, Object... values) throws Exception {
		int result = -1;
		Assert.hasText(sql);
		sql = OracleToMysql.trans(sql);
		Session ss = getLocalSession();
		Query query = ss.createQuery(sql);
		if(txFlag){
			if (values != null) {
				for(int i = 0; i < values.length; i++){
					query.setParameter(i, values[i]);
				}
			}
			result = query.executeUpdate();
			flush();
		}else{
			Transaction tx = null;
			try {
				tx = ss.beginTransaction();
				tx.begin();
				if (values != null) {
					for(int i = 0; i < values.length; i++){
						query.setParameter(i, values[i]);
					}
				}
				result = query.executeUpdate();
				tx.commit();
			} catch (Exception e) {
				tx.rollback();
				throw e;
			} finally {
				try {
					ss.clear();
				} catch (Exception e2) {}
			}
		}
		return result;
	}

	@Override
	public List findByCriterion(int startIndex, int pageSize, Criterion... criterions) throws Exception {
		// TODO Auto-generated method stub
		Criteria criteria = getLocalSession().createCriteria(this.entityClass);
		criteria.setFirstResult(startIndex).setMaxResults(pageSize);
		if (criterions != null) {
			for (Criterion criterion : criterions) {
				criteria.add(criterion);
			}
		}
		return criteria.list();
	}

	@Override
	public List findByCriterion(Class<T> entityClass, int startIndex, int pageSize, Criterion... criterions) throws Exception {
		// TODO Auto-generated method stub
		Criteria criteria = getLocalSession().createCriteria(entityClass);
		criteria.setFirstResult(startIndex).setMaxResults(pageSize);
		if (criterions != null) {
			for (Criterion criterion : criterions) {
				criteria.add(criterion);
			}
		}
		return criteria.list();
	}

	@Override
	public List findByProperty(String propertyName, Object propertyValue) throws Exception {
		Criteria criteria = getLocalSession().createCriteria(this.entityClass);
		criteria.add(Restrictions.eq(propertyName, propertyValue));
		return criteria.list();
	}

	@Override
	public List findByProperty(Class<T> entityClass, String propertyName, Object propertyValue) throws Exception {
		Criteria criteria = getLocalSession().createCriteria(entityClass);
		criteria.add(Restrictions.eq(propertyName, propertyValue));
		return criteria.list();
	}

	@Override
	public List findByProperty(String propertyName, Object propertyValue, boolean isAsc, String orderPropertyName) throws Exception {
		Assert.hasText(propertyName,BaseAction.getI18nText("i18n_HibernateGeneralDaoImpl.findByProperty.parmIsNotNull_n81i"));
		Assert.hasText(orderPropertyName, BaseAction.getI18nText("i18n_HibernateGeneralDaoImpl.findByProperty.sortFieldIsNotNull_n81i"));
		Criteria criteria = getLocalSession().createCriteria(this.entityClass);
		criteria.add(Restrictions.eq(propertyName, propertyValue));
		if(isAsc){
			criteria.addOrder(Order.asc(orderPropertyName));
		}else{
			criteria.addOrder(Order.desc(orderPropertyName));
		}
		return criteria.list();		
	}

	@Override
	public List findByProperty(Class<T> entityClass, String propertyName,
			Object propertyValue, boolean isAsc, String orderPropertyName) throws Exception {
		Criteria criteria = getLocalSession().createCriteria(entityClass);
		criteria.add(Restrictions.eq(propertyName, propertyValue));
		if(isAsc){
			criteria.addOrder(Order.asc(orderPropertyName));
		}else{
			criteria.addOrder(Order.desc(orderPropertyName));
		}
		return criteria.list();
	}

	@Override
	public T findByPropertyUnique(Class<T> entityClass, String propertyName, Object propertyValue) throws Exception {
		Criteria criteria = getLocalSession().createCriteria(entityClass);
		criteria.add(Restrictions.eq(propertyName, propertyValue));
		return (T) criteria.uniqueResult();
	}

	@Override
	public String getIdentifierPropertyName(Class<T> clazz) throws Exception {
		Assert.notNull(clazz);
		ClassMetadata meta = getSessionFactory().getClassMetadata(clazz);
		Assert.notNull(meta, "Class " + clazz + " not define in hibernate session factory.");
		String identifierPropertyName = meta.getIdentifierPropertyName();
		Assert.hasText(identifierPropertyName, clazz.getSimpleName() + " has no identifier property define.");
		return identifierPropertyName;
	}

	@Override
	public Serializable getIdentifier(Class<T> clazz, Object entity) throws Exception {
		Assert.notNull(clazz);
		Assert.notNull(entity);
		return (Serializable) PropertyUtils.getProperty(entity, this.getIdentifierPropertyName(clazz));
	}

	@Override
	public boolean isUnique(Object entity, String uniquePropertyNames) throws Exception {
		return isUnique(this.entityClass, entity, uniquePropertyNames);
	}

	@Override
	public boolean isUnique(Class<T> entityClass, Object entity, String uniquePropertyNames) throws Exception {
		Assert.hasText(uniquePropertyNames);
		Criteria criteria = getLocalSession().createCriteria(entityClass);
		criteria.setProjection(Projections.rowCount());
		String[] nameList = uniquePropertyNames.split(",");
		try {
			// 循环加入唯一列
			for (String name : nameList) {
				criteria.add(Restrictions.eq(name, PropertyUtils.getProperty(entity, name)));
			}
			// 以下代码为了如果是update的情况,排除entity自身.
			String identifierPropertyName = this.getIdentifierPropertyName(entityClass);
			// 取得entity的主键值
			Serializable id = getIdentifier(entityClass, entity);
			// 如果id!=null,说明对象已存在,该操作为update,加入排除自身的判断
			if (id != null)
				criteria.add(Restrictions.not(Restrictions.eq(identifierPropertyName, id)));
		} catch (Exception e) {
			ReflectionUtils.handleReflectionException(e);
		}
		boolean flag = (Integer) criteria.uniqueResult() == 0;
		return flag;
	}

	@Override
	public Long getSequenceValue(String sequenceName) throws Exception {
		message = BaseAction.getI18nText("i18n_HibernateGeneralDaoImpl.findByProperty.sortNameIsNotNull_n81i");
		Assert.hasText(sequenceName, message);
		String sql = "select " + sequenceName + ".nextval as num from dual";
		sql = OracleToMysql.trans(sql);
		Long sequenceValue = (Long) getLocalSession().createSQLQuery(sql).addScalar("num", Hibernate.LONG).uniqueResult();
		return sequenceValue;
	}
	
	@Override
	public Long getCount(String entityClassName) throws Exception {
		String hql = "select count(*) from " + entityClassName;
		Long total = (Long)getLocalSession().createQuery(hql).list().get(0);
		return total;
	}
	
	public Long getCountHql(String countHql) throws Exception {
		List countlist = null;
		long totalCount = 0;
		countHql = OracleToMysql.trans(countHql);
		if(!countHql.contains("count(")){
			String countQueryString = " select count(*) " + removeSelect(removeOrders(countHql));
			countlist = getHibernateTemplate().find(countQueryString);
			Iterator iter = countlist.iterator();
			if(iter.hasNext()){
				totalCount = Long.parseLong(countlist.get(0).toString());
			}
		}else{
			countlist = getHibernateTemplate().find(countHql);
			totalCount = countlist.size();
		}
		return totalCount;
	}

	@Override
	public Long getCount(String entityClassName, String clause) throws Exception {
		// TODO Auto-generated method stub
		String hql = "select count(*) from " + entityClassName + " where " + clause;
		hql = OracleToMysql.trans(hql);
		Long total = (Long)getLocalSession().createQuery(hql).list().get(0);
		return total;
	}

	@Override
	public Page findByPage(String hql, int pageNo, int pageSize, Object... values) throws Exception {
		Assert.hasText(hql);
		Assert.isTrue(pageNo >= 1, "pageNo should start from 1");
		hql = OracleToMysql.trans(hql);
		// Count查询
		if (values != null && values.length == 0) {
			values = null;
		}
		List countlist = null;
		long totalCount = 0;
		if(!hql.contains("count(")){
			String countQueryString = " select count(*) " + removeSelect(removeOrders(hql));
			countlist = getHibernateTemplate().find(countQueryString, values);
			Iterator iter = countlist.iterator();
			if(iter.hasNext()){
				totalCount = Long.parseLong(countlist.get(0).toString());
			}
		}else{
			countlist = getHibernateTemplate().find(hql, values);
			totalCount = countlist.size();
		}
		if (totalCount < 1) return new Page();
		// 实际查询返回分页对象
		int startIndex = Page.getStartOfPage(pageNo, pageSize);
		
		Query query = createQuery(hql, values);
		//从数据库中第startIndex开始取出pageSize条数据并返回当前页面中的数据
		List list = query.setFirstResult(startIndex).setMaxResults(pageSize).list();
		Page page = new Page(startIndex, totalCount, pageSize, list);
		return page;
	}
	
	@Override
	public Page findByRollPage(String hql, int pageNo, int pageSize, Object... values) throws Exception {
		Assert.hasText(hql);
		Assert.isTrue(pageNo >= 1, "pageNo should start from 1");
		hql = OracleToMysql.trans(hql);
		// Count查询
		if (values != null && values.length == 0) {
			values = null;
		}
		// 实际查询返回分页对象
		int startIndex = Page.getStartOfPage(pageNo, pageSize);
		Query query = createQuery(hql, values);
		List list = query.setFirstResult(startIndex).setMaxResults(pageSize+1).list();
		int resultsIndex = list.size();
		if(resultsIndex == pageSize + 1)
			list.remove(pageSize);
		Page page = new Page(startIndex, pageSize, list);
		if(resultsIndex == pageSize + 1)
			page.setHasNextPage(true);
		else
			page.setHasNextPage(false);
		return page;
	}

	@Override
	public Page findByPage(int pageNo, int pageSize, Criterion... criterions) throws Exception {
		Criteria criteria = createCriteria(this.entityClass, criterions);
		return findPageByCriteria(criteria, pageNo, pageSize);
	}

	@Override
	public Page findByPage(Class entityClass, int pageNo, int pageSize, Criterion... criterions)
			throws Exception {
		Criteria criteria = createCriteria(entityClass, criterions);
		return findPageByCriteria(criteria, pageNo, pageSize);
	}

	@Override
	public Page findByPage(int pageNo, int pageSize, boolean isAsc,
			String orderProperty, Criterion... criterions) throws Exception {
		Criteria criteria = createCriteria(this.entityClass, isAsc, orderProperty, criterions);
		return findPageByCriteria(criteria, pageNo, pageSize);
	}
	@Override
	public Page findByPage(Class entityClass, int pageNo, int pageSize, boolean isAsc, String orderProperty,
						   Criterion... criterions) throws Exception {
		Criteria criteria = createCriteria(entityClass, isAsc, orderProperty, criterions);
		return findPageByCriteria(criteria, pageNo, pageSize);
	}

	public Class<T> getEntityClass() {
		return entityClass;
	}

	public void setEntityClass(Class<T> entityClass) {
		this.entityClass = entityClass;
	}

	//私有方法,仅在本类中使用
	private static String removeSelect(String hql) {
		Assert.hasText(hql);
		int beginiss = hql.toLowerCase().indexOf("from");
		Assert.isTrue(beginiss != -1, " hql : " + hql + " must has a keyword 'from'");
		return hql.substring(beginiss);
	}
	
	//私有方法
	private static String removeOrders(String hql) {
		Assert.hasText(hql);
		Pattern p = Pattern.compile("order\\s*by[\\w|\\W|\\s|\\S]*", Pattern.CASE_INSENSITIVE);
		Matcher m = p.matcher(hql);
		StringBuffer sb = new StringBuffer();
		while (m.find()) {
			m.appendReplacement(sb, "");
		}
		m.appendTail(sb);
		return sb.toString();
	}
	
	//私有方法
	public Query createQuery(String hql, Object... values){
		Assert.hasText(hql);
		hql = OracleToMysql.trans(hql);
		Query query = getLocalSession().createQuery(hql);
		if (values != null) {
			for(int i = 0; i < values.length; i++){
				query.setParameter(i, values[i]);
			}
		}
		return query;
	}
	
	//私有方法
	private Criteria createCriteria(Class<T> entityClass, Criterion... criterions){
		Criteria criteria = getLocalSession().createCriteria(entityClass);
		if(criterions == null) return criteria;
		for(Criterion c : criterions){
			criteria.add(c);
		}
		return criteria;
	}
	
	//私有方法
	private Criteria createCriteria(Class<T> entityClass, boolean isAsc, String orderProperty, Criterion... criterions){
		Assert.hasText(orderProperty);
		Criteria criteria = createCriteria(entityClass, criterions);
		if(isAsc){
			criteria.addOrder(Order.asc(orderProperty));
		}else{
			criteria.addOrder(Order.desc(orderProperty));
		}
		return criteria;
	}
	
	//私有方法，将页码转换为起始行号再进行查询
	public Page findPageByQuery(Query query, int pageNo, int pageSize) throws Exception {
		long totalCount = query.list().size();
		if (totalCount < 1) return new Page();
		// 实际查询返回分页对象
		int startIndex = Page.getStartOfPage(pageNo, pageSize);
		List list = query.setFirstResult(startIndex).setMaxResults(pageSize).list();
		Page page = new Page(startIndex, totalCount, pageSize, list);
		return page;
	}

	//私有方法，将页码转换为起始行号再进行查询
	protected Page findPageByCriteria(Criteria criteria, int pageNo, int pageSize) throws Exception {
		Assert.notNull(criteria);
		Assert.isTrue(pageNo >= 1, "pageNo should start from 1");
		CriteriaImpl impl = (CriteriaImpl) criteria;
		// 先把Projection和OrderBy条件取出来,清空两者来执行Count操作
		Projection projection = impl.getProjection();
		List<CriteriaImpl.OrderEntry> orderEntries;
		try {
			orderEntries = (List) BeanUtils.forceGetProperty(impl, "orderEntries");
			BeanUtils.forceSetProperty(impl, "orderEntries", new ArrayList());
		} catch (Exception e) {
			throw new InternalError(" Runtime Exception impossibility throw ");
		}
		// 执行查询
		long totalCount = Long.parseLong(criteria.setProjection(Projections.rowCount()).uniqueResult().toString());
		// 将之前的Projection和OrderBy条件重新设回去
		criteria.setProjection(projection);
		if (projection == null) {
			criteria.setResultTransformer(CriteriaSpecification.ROOT_ENTITY);
		}
		try {
			BeanUtils.forceSetProperty(impl, "orderEntries", orderEntries);
		} catch (Exception e) {
			throw new InternalError(" Runtime Exception impossibility throw ");
		}
		// 返回分页对象
		if (totalCount < 1) return new Page();
		// 实际查询返回分页对象
		int startIndex = Page.getStartOfPage(pageNo, pageSize);
		List list = criteria.setFirstResult(startIndex).setMaxResults(pageSize).list();
		Page page = new Page(startIndex, totalCount, pageSize, list);
		return page;
	}

	/**
	 * 模拟oracle start with connect by
	 * @param sql select * from table where xxx
	 * @param start 开始条件
	 * @param idName
	 * @param pidName
	 * @return
	 * @throws Exception 
	 */
	public  List<Map<String,Object>> startWithConnectBy(String sql ,String start,String idName,String pidName) throws Exception{	
		List<Map<String,Object>> result = new ArrayList();
		StringBuilder sb = new StringBuilder();
		sb.append(sql);
		sb.append(" and ");
		sb.append(start);
		List<Map<String,Object>> temp = this.executeSQLMap(sb.toString());
		//result.addAll(temp);
		do {
			if(temp == null || temp.size() <1){
				break;
			}else{
				result.addAll(temp);
				StringBuilder tsb = new StringBuilder();
				for(Map<String,Object> m : temp){
					Object object = getIgnoreCase(m, idName);
					tsb.append(",");
					if(object instanceof String){
						tsb.append("'");
						tsb.append(object);
						tsb.append("'");
					}else{
						tsb.append(object);
					}
				}
				tsb.deleteCharAt(0);
				start = tsb.toString();
			}
			
			StringBuilder psb = new StringBuilder();
			psb.append(sql);
			psb.append(" and ");
			psb.append(pidName);
			psb.append(" in ( ");
			psb.append(start);
			psb.append(" )");
			temp = this.executeSQLMap(psb.toString());
			//result.addAll(temp);n b
		} while (true);
		return result;
	}
	
	/**
	 * 不区分大小写 获取 map 的值
	 * @param map
	 * @param key
	 * @return
	 */
	public static Object getIgnoreCase(Map<String,Object> map,String key){
		Set<String> keySet = map.keySet();
		for(String s : keySet){
			if(s!=null && key.equalsIgnoreCase(s)){
				return map.get(s);
			}else if(key == null && s == null){
				return map.get(s);
			}
		}
		return null;
	}
	
	
	
	public int updateBySql(String sql,Object... obj) throws Exception {
		Session session = getLocalSession();
		Connection con=session.connection();
		sql = OracleToMysql.trans(sql);
		con.setAutoCommit(false);
		PreparedStatement ps=con.prepareStatement(sql);
		int resu =0;
		try {
			if (obj != null && obj.length>0) {
				//依次向SQL中的"?"占位符填入参数
				for(int j=0; j<obj.length; j++){
					ps.setObject(j+1, obj[j]);
				}
			}
			ps.executeUpdate();
			session.flush();
			if(!isTransaction()){
				con.commit();
				session.clear();
			}
		} catch (Exception e) {
			resu =-1;
			throw e;
		}finally{
			if(ps!=null){
				ps.close();
			}
		}
		return resu;
	}
	public int updateBatchBySql(String sql,List ...lists) throws Exception {
		Session session = getLocalSession();
		Connection con=session.connection();
		con.setAutoCommit(false);
		PreparedStatement ps=con.prepareStatement(sql);
		int resu =0;
		try {
			if (lists != null && lists.length>0) {
				//依次向SQL中的"?"占位符填入参数
				for (int i=0; i<lists[0].size(); i++){
					for(int j=0; j<lists.length; j++){
						ps.setObject(j+1, lists[j].get(i));
						//System.out.println("==============ps.setObject("+(j+1)+","+lists[j].get(i)+")");
					}
					ps.addBatch();
					
					/*if(i%5000==0){
						ps.executeBatch();
						con.commit();
					}*/
				}
				ps.executeBatch();
			}else{
				ps.executeUpdate();
			}
			session.flush();
			if(!isTransaction()){
				con.commit();
				session.clear();
			}
		} catch (Exception e) {
			resu =-1;
			throw e;
		}finally{
			if(ps!=null){
				ps.close();
			}
		}
		return resu;
	}
	
	//批量插入
	public boolean insertBatchBySqls(List<String> sqls) throws Exception {
		Session session = getLocalSession();
		Connection con=session.connection();
		con.setAutoCommit(false);
		Statement sta=con.createStatement();
		boolean resu = true;
		try {
			for (String str : sqls) {
				sta.addBatch(str);
			}
			sta.executeBatch();
			session.flush();
			if(!isTransaction()){
				con.commit();
				session.clear();
			}
		} catch (Exception e) {
			resu =false;
			throw e;
		}finally{
			if(sta!=null){
				sta.close();
			}
		}
		return resu;
	}
	
	public boolean executeProForCTable(String proName,String tableName,String filedAndType,String fileds) throws Exception {	
		Session session = getLocalSession();
		Connection con=session.connection();
		CallableStatement cs = null;
		boolean resu = true;
		try {
			con.setAutoCommit(false);
			cs = con.prepareCall("{call "+proName+"(?,?,?)}");
			cs.setString(1,tableName);
			cs.setString(2,filedAndType);
			cs.setString(3, fileds);
			cs.execute();
			session.flush();
			if(!isTransaction()){
				con.commit();
				session.clear();
			}
		} catch (Exception e) {
			e.printStackTrace();
			resu = false;
		}finally{
			if(cs!=null){ 
				cs.close();
			}
		}
		return resu;
	}
	
	public boolean executeProForUTable(String proName,String tableName,String fileds) throws Exception {	
		Session session = getLocalSession();
		Connection con=session.connection();
		CallableStatement cs = null;
		boolean resu = true;
		try {
			con.setAutoCommit(false);
			cs = con.prepareCall("{call "+proName+"(?,?,?)}");
			cs.setString(1,tableName);
			cs.setString(2, fileds);
			cs.execute();
			session.flush();
			if(!isTransaction()){
				con.commit();
				session.clear();
			}
		} catch (Exception e) {
			e.printStackTrace();
			resu = false;
		}finally{
			if(cs!=null){ 
				cs.close();
				con.setAutoCommit(true);
			}
		}
		return resu;
	}
	
	
	
	
	public static void main(String[] args) throws Exception {
		FileSystemXmlApplicationContext context = new FileSystemXmlApplicationContext("D:\\Workspaces\\nmsweb\\src\\conf\\spring\\applicationContext.xml");
		HibernateGeneralDaoImpl dao = (HibernateGeneralDaoImpl)context.getBean("HibernateGeneralDaoImpl");
		List executeSQL = dao.executeSQL("select sysdate from dual");
		System.out.println(executeSQL);
	}
	
}