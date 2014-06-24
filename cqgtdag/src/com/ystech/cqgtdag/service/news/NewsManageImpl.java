/**
 * 
 */
package com.ystech.cqgtdag.service.news;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cqgtdag.model.news.News;

/**
 * @author shusanzhan
 * @date 2014-5-28
 */
@Component("newsManageImpl")
public class NewsManageImpl extends HibernateEntityDao<News>{

}
