package nis.nms.service;



import java.util.Date;

import nis.nms.persistence.HibernateGeneralDaoImpl;
import nis.nms.util.Page;

import org.hibernate.Criteria;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;


public class ResultService<ResultInfo> extends HibernateGeneralDaoImpl<ResultInfo>{
	
	// 按指定的排序方式进行排序
	public Page addSort(Criteria criteria, Long selectOrder, int pageNo, int pageSize) throws Exception{
		switch (selectOrder.intValue()) {
		case 0:
			criteria = criteria.addOrder(Order.desc("interestWeight"));
			break;
		case 1:
			criteria = criteria.addOrder(Order.asc("interestWeight"));
			break;
		case 2:
			criteria = criteria.addOrder(Order.desc("engineWeight"));
			break;
		case 3:
			criteria = criteria.addOrder(Order.asc("engineWeight"));
			break;
		case 4:
			criteria = criteria.addOrder(Order.desc("gatherTime"));
			break;
		case 5:
			criteria = criteria.addOrder(Order.asc("gatherTime"));
			break;
		}
		Page page = findPageByCriteria(criteria, pageNo, pageSize);
		return page;
	}
	
	public Page pageList(Long missionId, int pageNo, int pageSize, Date startTime, Date endTime, Long selectOrder, Long selectSearchType, String condition) throws Exception{
		Criterion[] criterions = new Criterion[]{Restrictions.eq("missionInfo.missionId", missionId), Restrictions.eq("searchType", selectSearchType), Restrictions.ge("gatherTime", startTime), Restrictions.le("gatherTime", endTime), Restrictions.or(Restrictions.like("title", "%"+condition+"%"),Restrictions.like("ab", "%"+condition+"%"))};
		Criteria criteria = getSession().createCriteria(this.getEntityClass());
		if(criterions != null){
			for(Criterion c : criterions){
				criteria.add(c);
			}
		}
		return this.addSort(criteria, selectOrder, pageNo, pageSize);
	}
	
}
