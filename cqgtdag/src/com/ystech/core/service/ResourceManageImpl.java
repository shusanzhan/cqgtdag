package com.ystech.core.service;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.transform.Transformers;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.core.model.Resource;
@Component("resourceManageImpl")
public class ResourceManageImpl extends HibernateEntityDao<Resource>{
	@SuppressWarnings("unchecked")
	public List<Resource> queryResourceByUserId(Integer userId) {
		String sql="SELECT * FROM resource WHERE dbid IN (SELECT resourceId from roleresource where roleId IN (SELECT roleId FROM userroles where userroles.userId="+userId+")) and menu=0 and parentId!=0 ORDER BY orderNo";
		List<Resource> resources = executeSql(sql, new Object[]{});
		//List<Resource> resources = session.createSQLQuery(sql).setResultTransformer(Transformers.aliasToBean(Resource.class)).list();
		return resources;
	}
	public List<Resource> queryResourceByUserId(Integer userId,Integer parentId) {
		String sql="SELECT * FROM resource WHERE dbid IN (SELECT resourceId from roleresource where roleId IN (SELECT roleId FROM userroles where userroles.userId="+userId+")) and parentId="+parentId+" ORDER BY orderNo";
		List<Resource> resources = executeSql(sql, new Object[]{});
		return resources;
	}
}
