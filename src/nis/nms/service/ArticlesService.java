package nis.nms.service;

import nis.nms.domains.NmsErrorInfo;
import nis.nms.persistence.HibernateGeneralDaoImpl;

public class ArticlesService<T> extends HibernateGeneralDaoImpl<T> {
	
	public void saveSystemError(){
		NmsErrorInfo errorInfo= new NmsErrorInfo();
	}
	
	public void getErrorCode(){
		NmsErrorInfo errorInfo= new NmsErrorInfo();
	}
}
