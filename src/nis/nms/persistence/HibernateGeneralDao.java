package nis.nms.persistence;


import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import nis.nms.util.Page;

import org.hibernate.criterion.Criterion;

public interface HibernateGeneralDao<T> {
	/**
	 * 将实体保 存至数据库
	 * @param entity
	 * @throws Exception
	 */
	public void save(Object entity) throws Exception;
	
	public void saveAll(Object entity) throws Exception;
	/**
	 * 根据实体更新数据库
	 * @param entity
	 * @throws Exception
	 */
	public void update(Object entity) throws Exception;
	
	/**
	 * 根据传入的多个ID批量更新数据库
	 * @param ids
	 * @throws Exception
	 */
	public void updateByHql(String hql, Object... values) throws Exception;
	
	/**
	 * 将实体保存或更新到数据库，如果数据库中无此实体则保存，有此实体则更新
	 * @param entity
	 * @throws Exception
	 */
	public void saveOrUpdate(Object entity) throws Exception;
	
	/**
	 * 将集合中的实体全部保存或更新到数据库
	 * @param entities
	 * @throws Exception
	 */
	public void saveOrUpdate(Collection<T> entities) throws Exception;
	
	/**
	 * 根据指定实体对象删除记录
	 * @param entity
	 * @throws Exception
	 */
	public void delete(Object entity) throws Exception;
	
	/**
	 * 根据指定的实体类名称和ID删除记录
	 * @param entityName
	 * @param propertyName
	 * @param propertyValue
	 * @throws Exception
	 */
	public void delete(Class<T> entityClass, String propertyName, Object propertyValue) throws Exception;
	
	/**
	 * 根据id语句删除记录
	 * @param hql
	 * @param values
	 * @throws Exception
	 */
	
	public void delete(Serializable id) throws Exception ;
	
	/**
	 * 根据表名和id语句删除记录
	 * @param hql
	 * @param values
	 * @throws Exception
	 */
	
	public void delete(String entityName, Serializable id) throws Exception ;
	
	/**
	 * 根据HQL语句删除记录
	 * @param hql
	 * @param values
	 * @throws Exception
	 */

	public void delete(String hql) throws Exception;
	
	/**
	 * 根据HQL语句删除记录
	 * @param hql
	 * @param values
	 * @throws Exception
	 */
	public void delete(String hql, Object... values) throws Exception;
	
	/**将缓存中的对象保存到数据库，但clear后才会引起缓存数据变化
	 * @throws Exception
	 */
	public void flush() throws Exception;
	
	/**
	 * 清除缓存中的所有对象
	 * @throws Exception
	 */
	public void clear() throws Exception;
	
	/**
	 * 清除缓存中的指定实体对象
	 * @param entity
	 * @throws Exception
	 */
	public void evict(Object entity) throws Exception;
	
	/**
	 * 获得一行记录，根据Hibernate约定，get方法将直接命中数据库，不从缓存中加载数据
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public T get(Serializable id) throws Exception;
	
	/**
	 * 获得一行记录，根据Hibernate约定，get方法将直接命中数据库，不从缓存中加载数据
	 * @param entityClass
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public T get(Class<T> entityClass, Serializable id) throws Exception;
	
	/**
	 * 获得一行记录，根据Hibernate约定，load方法将从缓存中加载数据
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public T load(Serializable id) throws Exception;
	
	/**
	 * 获得一行记录，根据Hibernate约定，load方法将从缓存中加载数据
	 * @param entityClass
	 * @param id
	 * @return 
	 * @throws Exception
	 */
	public T load(Class<T> entityClass, Serializable id) throws Exception;
	
	/**
	 * 加载实体类中的所有记录
	 * @param entityClass
	 * @return 
	 * @throws Exception
	 */
	public List<T> loadAll() throws Exception; 
	
	/**
	 * 加载实体类中的所有记录
	 * @param entityClass
	 * @return 
	 * @throws Exception
	 */
	public List<T> loadAll(Class<T> entityClass) throws Exception; 
	
	/**
	 * 查找实体类中的所有记录
	 * @param entityClass
	 * @return 
	 * @throws Exception
	 */
	public List<T> findAll() throws Exception; 
	
	/**
	 * 查找实体类中的所有记录
	 * @param entityClass
	 * @return 
	 * @throws Exception
	 */
	public List<T> findAll(Class<T> entityClass) throws Exception; 
	
	/**
	 * 查找实体类中的所有记录，并根据指定的排序方式和字段进行排序
	 * @param entityClass
	 * @param isAsc
	 * @param orderPropertyName
	 * @return 
	 * @throws Exception
	 */
	public List<T> findAll(Class<T> entityClass, boolean isAsc, String orderPropertyName) throws Exception; 
	
	/**
	 * 根据HQL语句查询数据库，允许有0到多个参数
	 * @param hql
	 * @param values
	 * @return 
	 * @throws Exception
	 */
	public List<T> find(String hql, Object... values) throws Exception;
	
	/**
	 * 根据HQL语句查询数据库，并指定起始索引和记录条数，允许有0到多个参数
	 * @param hql
	 * @param startIndex
	 * @param pageSize
	 * @param values
	 * @return
	 * @throws Exception
	 */
	public List<T> find(String hql, int startIndex, int pageSize, Object... values) throws Exception;
	
	/**
	 * 根据原生的SQL语句查询数据库，并允许有0到多个参数
	 * @param sql
	 * @param values
	 * @return
	 * @throws Exception
	 */
	public List<T> executeSQL(String sql, Object... values) throws Exception;
	
	/**
	 * 分页查询，允许有0到多个Criterion查询条件参数
	 * @param startIndex
	 * @param pageSize
	 * @param criterions
	 * @return
	 * @throws Exception
	 */
	public List<T> findByCriterion(int startIndex, int pageSize, Criterion... criterions) throws Exception;
	
	/**
	 * 从指定的实体雷中进行分页查询，允许有0到多个Criterion查询条件参数
	 * @param entityClass
	 * @param startIndex
	 * @param pageSize
	 * @param criterions
	 * @return
	 * @throws Exception
	 */
	public List<T> findByCriterion(Class<T> entityClass, int startIndex, int pageSize, Criterion... criterions) throws Exception;
	
	/**
	 * 根据指定的属性名称和属性值查找满足条件的所有记录
	 * @param propertyName
	 * @param propertyValue
	 * @return
	 * @throws Exception
	 */
	public List<T> findByProperty(String propertyName, Object propertyValue) throws Exception;
	
	/**
	 * 根据指定的属性名称和属性值从指定的实体类中查找满足条件的所有记录
	 * @param entityClass
	 * @param propertyName
	 * @param propertyValue
	 * @return
	 * @throws Exception
	 */
	public List<T> findByProperty(Class<T> entityClass, String propertyName, Object propertyValue) throws Exception;
	
	/**
	 * 根据指定的属性名称和属性值查找满足条件的所有记录，并将结果按照指定的排序方式和字段进行排序
	 * @param propertyName
	 * @param propertyValue
	 * @param isAsc
	 * @param orderPropertyName
	 * @return
	 * @throws Exception
	 */
	public List<T> findByProperty(String propertyName, Object propertyValue, boolean isAsc, String orderPropertyName) throws Exception;
	
	/**
	 * 根据指定的属性名称和属性值从指定的实体类中查找满足条件的所有记录，并将结果按照指定的排序方式和字段进行排序
	 * @param entityClass
	 * @param propertyName
	 * @param propertyValue
	 * @param isAsc
	 * @param orderPropertyName
	 * @return
	 * @throws Exception
	 */
	public List<T> findByProperty(Class<T> entityClass, String propertyName, Object propertyValue, boolean isAsc, String orderPropertyName)  throws Exception;
	
	/**
	 * 根据属性名称和对应的值，从指定的实体类中获得唯一的一行记录
	 * @param entityClass
	 * @param propertyName
	 * @param propertyValue
	 * @return 
	 * @throws Exception
	 */
	public T findByPropertyUnique(Class<T> entityClass, String propertyName, Object propertyValue) throws Exception;
	
	/**
	 * 根据指定的序列名称，手工获取此序列的当前值，只适用于Oracle
	 * @param sequenceName
	 * @return
	 * @throws Exception
	 */
	public Long getSequenceValue(String sequenceName) throws Exception;
	
	/**
	 * 根据指定类获得标识字段的名称
	 * @param clazz
	 * @return
	 * @throws Exception
	 */
	public String getIdentifierPropertyName(Class<T> clazz) throws Exception;
	
	/**
	 * 根据指定类和实体获得标识ID
	 * @param clazz
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public Serializable getIdentifier(Class<T> clazz, Object entity) throws Exception;
	
	/**
	 * 根据实体对象和属性名称判断是否唯一
	 * @param entity
	 * @param uniquePropertyNames
	 * @return
	 * @throws Exception
	 */
	public boolean isUnique(Object entity, String uniquePropertyNames) throws Exception;
	
	/**
	 * 根据实体类、实体对象和属性名称判断是否唯一
	 * @param entityClass
	 * @param entity
	 * @param uniquePropertyNames
	 * @return
	 * @throws Exception
	 */
	public boolean isUnique(Class<T> entityClass, Object entity, String uniquePropertyNames) throws Exception;
	
	/**
	 * 根据指定的实体类名称统计出所有记录的条数
	 * @param entityClassName
	 * @return
	 * @throws Exception
	 */
	public Long getCount(String entityClassName) throws Exception;
	
	/**
	 * 根据指定的实体类名称以及where子句，统计出满足条件的所有记录的条数
	 * @param entityClassName
	 * @param clause
	 * @return
	 * @throws Exception
	 */
	public Long getCount(String entityClassName, String clause) throws Exception;
	
	/**
	 * 分页查询函数，使用hql
	 * @param pageNo
	 * @param pageSize
	 * @param hql
	 * @param values
	 * @return
	 * @throws Exception
	 */
	public Page findByPage(String hql, int pageNo, int pageSize, Object... values) throws Exception;
	/**
	 * 分页查询函数，使用hql,进行无统计总页数的分页查询
	 * @param pageNo
	 * @param pageSize
	 * @param hql
	 * @param values
	 * @return
	 * @throws Exception
	 */
	public Page findByRollPage(String hql, int pageNo, int pageSize, Object... values) throws Exception;

	/**
	 * 分页查询函数，使用包含查询条件的<code>Criterion</code>
	 * @param pageNo 页号,从1开始.
	 * @param pageSize
	 * @param criterions
	 * @return 含总记录数和当前页数据的Page对象
	 * @throws Exception
	 */
	public Page findByPage(int pageNo, int pageSize, Criterion... criterions) throws Exception;

	/**
	 * 分页查询函数，指定entityClass，使用包含查询条件的<code>Criterion</code>
	 * @param entityClass
	 * @param pageNo 页号,从1开始.
	 * @param pageSize
	 * @param criterions
	 * @return 含总记录数和当前页数据的Page对象
	 * @throws Exception
	 */
	public Page findByPage(Class<T> entityClass, int pageNo, int pageSize, Criterion... criterions) throws Exception;

	/**
	 * 分页查询函数，使用查询条件和排序条件
	 * @param pageNo 页号,从1开始.
	 * @param pageSize
	 * @param orderBy
	 * @param isAsc
	 * @param criterions
	 * @return 含总记录数和当前页数据的Page对象
	 * @throws Exception
	 */
	public Page findByPage(int pageNo, int pageSize, boolean isAsc, String orderProperty,
						   Criterion... criterions) throws Exception;

	/**
	 * 分页查询函数，指定entityClass，使用查询条件和排序条件
	 * @param entityClass
	 * @param pageNo 页号,从1开始.
	 * @param pageSize
	 * @param orderBy
	 * @param isAsc
	 * @param criterions
	 * @return 含总记录数和当前页数据的Page对象
	 * @throws Exception
	 */
	public Page findByPage(Class<T> entityClass, int pageNo, int pageSize, boolean isAsc, String orderProperty,
						   Criterion... criterions) throws Exception;
	
	
}
