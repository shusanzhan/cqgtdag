package com.ystech.core.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.core.model.Role;
@Component("roleManageImpl")
public class RoleManageImpl extends HibernateEntityDao<Role>{

}
