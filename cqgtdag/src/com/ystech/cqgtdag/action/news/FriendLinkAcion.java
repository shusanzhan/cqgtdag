/**
 * 
 */
package com.ystech.cqgtdag.action.news;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cqgtdag.model.news.FriendLink;
import com.ystech.cqgtdag.service.news.FriendLinkManageImpl;

/**
 * @author shusanzhan
 * @date 2014-5-22
 */
@Component("friendLinkAcion")
@Scope("prototype")
public class FriendLinkAcion extends BaseController{
	private FriendLink friendLink;
	private FriendLinkManageImpl friendLinkManageImpl;
	public FriendLink getFriendLink() {
		return friendLink;
	}
	public void setFriendLink(FriendLink friendLink) {
		this.friendLink = friendLink;
	}
	public FriendLinkManageImpl getFriendLinkManageImpl() {
		return friendLinkManageImpl;
	}
	@Resource
	public void setFriendLinkManageImpl(FriendLinkManageImpl friendLinkManageImpl) {
		this.friendLinkManageImpl = friendLinkManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String username = request.getParameter("title");
		Page<FriendLink> page=null;
		if(null!=username&&username.trim().length()>0){
			page = friendLinkManageImpl.pageQuery(pageNo, pageSize, "from FriendLink where   title like '%"+username+"%'", new Object[]{});
		}else{
			page = friendLinkManageImpl.pageQuery(pageNo, pageSize, "from FriendLink   ", new Object[]{});
		}
		request.setAttribute("page", page);
		return "list";
	}

	/**
	 * 功能描述： 参数描述： 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String add() throws Exception {
		return "edit";
	}

	/**
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		if(dbid>0){
			FriendLink friendLink2 = friendLinkManageImpl.get(dbid);
			request.setAttribute("friendLink", friendLink2);
		}
		return "edit";
	}

	/**
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public void save() throws Exception {
		HttpServletRequest request = getRequest();
		//slide.setBussiId(currentBussi);
		try{
				friendLinkManageImpl.save(friendLink);
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/friendLink/queryList", "保存数据成功！");
		return ;
	}

	/**
	 * 功能描述： 参数描述： 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public void delete() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer[] dbids = ParamUtil.getIntArraryByDbids(request,"dbids");
		if(null!=dbids&&dbids.length>0){
			try {
				for (Integer dbid : dbids) {
					friendLinkManageImpl.deleteById(dbid);
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
				renderErrorMsg(e, "");
				return ;
			}
		}else{
			renderErrorMsg(new Throwable("未选中数据！"), "");
			return ;
		}
		String query = ParamUtil.getQueryUrl(request);
		renderMsg("/friendLink/queryList"+query, "删除数据成功！");
		return;
	}
}
