/**
 * 
 */
package com.ystech.core.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.core.model.Staff;

/**
 * @author shusanzhan
 * @date 2013-7-29
 */
@Component("staffManageImpl")
public class StaffManageImpl extends HibernateEntityDao<Staff>{

}
