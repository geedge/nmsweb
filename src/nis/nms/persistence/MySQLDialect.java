package nis.nms.persistence;

import java.sql.Types;

import org.hibernate.Hibernate;
/**
 * 自定义 mysql 方言，添加 text 字段类型支持
 * @author dell
 *
 */
public class MySQLDialect extends org.hibernate.dialect.MySQLDialect{
	
	public MySQLDialect() {
		super();
		registerHibernateType(Types.LONGVARCHAR, Hibernate.STRING.getName());
		registerHibernateType(Types.BIGINT, Hibernate.BIG_DECIMAL.getName());
		registerHibernateType(Types.INTEGER, Hibernate.BIG_DECIMAL.getName());
	}
	
}
