package nis.nms.web.actions.nmstaskManager;

import java.util.List;

import nis.nms.service.CommonService;

public class NmstaskManagerHelper {

	/*
	 * 根据任务查询任务执行结果信息
	 */
	@SuppressWarnings("unchecked")
	public List<Object[]> getTaskResult(CommonService commserver,String sql){
		List<Object[]> listresult = null;
		try {
			 listresult = commserver.createSQLQuery(sql).list();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return listresult;
	}
}
