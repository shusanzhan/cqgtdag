/**
 * 
 */
package com.ystech.core.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.core.model.OperateLog;

/**
 * @author shusanzhan
 * @date 2013-6-22
 */
@Component("operateLogManageImpl")
public class OperateLogManageImpl extends HibernateEntityDao<OperateLog>{

}
