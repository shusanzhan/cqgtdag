/**
 * 
 */
package com.ystech.cqgtdag.action.news;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.lucene.service.IndexManageImpl;
import com.ystech.core.model.User;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cqgtdag.model.news.News;
import com.ystech.cqgtdag.model.news.NewsType;
import com.ystech.cqgtdag.service.news.NewsManageImpl;
import com.ystech.cqgtdag.service.news.NewsTypeManageImpl;

/**
 * @author shusanzhan
 * @date 2013-11-14
 */
@Component("newsAction")
@Scope("prototype")
public class NewsAction extends BaseController{
	private IndexManageImpl indexManageImpl;
	private News news;
	private NewsManageImpl newsManageImpl;
	private NewsTypeManageImpl newsTypeManageImpl;
	public News getNews() {
		return news;
	}
	public void setNews(News news) {
		this.news = news;
	}
	@Resource
	public void setNewsManageImpl(NewsManageImpl newsManageImpl) {
		this.newsManageImpl = newsManageImpl;
	}
	@Resource
	public void setNewsTypeManageImpl(NewsTypeManageImpl newsTypeManageImpl) {
		this.newsTypeManageImpl = newsTypeManageImpl;
	}
	@Resource
	public void setIndexManageImpl(IndexManageImpl indexManageImpl) {
		this.indexManageImpl = indexManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String titile = request.getParameter("newName");
		Page<News> page=null;
		if(null!=titile&&titile.trim().length()>0){
			page = newsManageImpl.pageQuery(pageNo, pageSize, "from News where title like '%"+titile+"%' ORDER BY releaseDate desc", new Object[]{});
		}else{
			page = newsManageImpl.pageQuery(pageNo, pageSize, "from News ORDER BY releaseDate desc", new Object[]{});
		}
		request.setAttribute("page", page);
		return "list";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String add() throws Exception {
		return "add";
	}
	/**
	 * 
	 * @return
	 * @throws Exception
	 */
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		if(dbid>0){
			News news2 = newsManageImpl.get(dbid);
			request.setAttribute("news", news2);
		}
		return "edit";
	}
	/**
	 * 功能描述：保存新闻信息
	 * 参数描述：
	 * @throws Exception
	 */
	public void save() throws Exception {
		User currentUser = SecurityUserHolder.getCurrentUser();
		HttpServletRequest request = this.getRequest();
		try{
			Integer newTypeDbid = ParamUtil.getIntParam(request, "newTypeDbid", -1);
			NewsType newType2 = newsTypeManageImpl.get(newTypeDbid);
			if(null==news.getDbid()||news.getDbid()<1){
				news.setReadNum(0);
				news.setNewstype(newType2);
				news.setReleaseDate(new java.util.Date());
				news.setModifyDate(new Date());
				news.setReleasePerson(currentUser);
				news.setIsStop(true);//默认为启用
				newsManageImpl.save(news);
			}else{
				News news2 = newsManageImpl.get(news.getDbid());
				news2.setReleasePerson(currentUser);
				news2.setTitle(news.getTitle());
				news2.setNewstype(newType2);
				news2.setModifyDate(new Date());
				news2.setTitlePicture(news.getTitlePicture());
				news2.setIntroduction(news.getIntroduction());
				news2.setAttach(news.getAttach());
				news2.setContent(news.getContent());
				newsManageImpl.save(news2);
			}
		}catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(e, "");
		}
		renderMsg("/news/queryList", "保存数据成功！");
		return ;
	}
	/**
	 * 功能描述：删除新闻
	 * 参数描述：新闻IDs
	 * 逻辑描述：
	 * 1、获取新闻IDs，
	 * 2、删除新闻的阅读记录
	 * 3、删除新闻的评论记录
	 * @throws Exception
	 */
	public void delete() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer[] dbids = ParamUtil.getIntArraryByDbids(request,"dbids");
		if(null!=dbids&&dbids.length>0){
			try {
				for (Integer dbid : dbids) {
					newsManageImpl.deleteById(dbid);
				}
			} catch (Exception e) {
				e.printStackTrace();
				renderErrorMsg(e, "");
			}
		}
		String query = ParamUtil.getQueryUrl(request);
		renderMsg("/news/queryList"+query, "保存数据成功！");
		return ;
	}
	/**
	 * 功能描述：启用新闻或者停用新闻
	 * 参数描述：新闻id
	 * 逻辑描述：通过新闻的Id获取新闻信息，
	 * 1、如果新闻信息是启用状态，则修改新闻新闻为停用状态，
	 * 2、如果新闻是停用状态则修改新闻为启用状态
	 * @return
	 * @throws Exception
	 */
	public void startNews() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			News news2 = newsManageImpl.get(dbid);
			if(news2.getIsStop()==false){
				news2.setIsStop(true);
			}else if(news2.getIsStop()==true){
				news2.setIsStop(false);
			}
			newsManageImpl.save(news2);
		} catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(e, "");
		}
		String param = ParamUtil.getQueryUrl(request);
		renderMsg("/news/queryList"+param, "保存数据成功！");
		
		return ;
	}
	/**
	 * 功能描述：批量启用新闻
	 * 参数描述：新闻ids
	 * 逻辑描述：通过新闻的Id获取新闻信息
	 * @return
	 * @throws Exception
	 */
	public void startNewsByIds() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer[] dbids = ParamUtil.getIntArrayByIds(request, "dbids");
		if(null!=dbids&&dbids.length>0){
			try {
				for (Integer dbid : dbids) {
					News news2 = newsManageImpl.get(dbid);
					news2.setIsStop(true);
					newsManageImpl.save(news2);
				}
			} catch (Exception e) {
				e.printStackTrace();
				renderErrorMsg(e, "");
				return ;
			}	
		}else{
			renderErrorMsg(new Throwable("更新数据失败"), "");
			return ;
		}
		
		String param = ParamUtil.getQueryUrl(request);
		renderMsg("/news/queryList"+param, "保存数据成功！");
		return ;
	}
	/**
	 * 功能描述：批量停用新闻
	 * 参数描述：新闻ids
	 * 逻辑描述：通过新闻的Ids获取新闻信息
	 * @return
	 * @throws Exception
	 */
	public void canncelNewsByIds() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer[] dbids = ParamUtil.getIntArrayByIds(request, "dbids");
		if(null!=dbids&&dbids.length>0){
			try {
				for (Integer dbid : dbids) {
					News news2 = newsManageImpl.get(dbid);
					news2.setIsStop(false);
					newsManageImpl.save(news2);
				}
			} catch (Exception e) {
				e.printStackTrace();
				renderErrorMsg(e, "");
				return ;
			}	
		}else{
			renderErrorMsg(new Throwable("更新数据失败"), "");
			return ;
		}
		
		String param = ParamUtil.getQueryUrl(request);
		renderMsg("/news/queryList"+param, "保存数据成功！");
		return ;
	}
	
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void createIndex() throws Exception {
		boolean state = indexManageImpl.createIndex();
		if(state==true){
			renderMsg("/news/queryList", "创建索引成功！");
		}
		else{
			renderErrorMsg(new Throwable("创建索引失败！"), "");
		}
		return ;
	}
}
