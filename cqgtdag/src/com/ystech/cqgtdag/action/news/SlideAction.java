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
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cqgtdag.model.news.Slide;
import com.ystech.cqgtdag.service.news.SlideManageImpl;

/**
 * @author shusanzhan
 * @date 2014年1月26日
 */
@Component("slideAction")
@Scope("prototype")
public class SlideAction extends BaseController{
	private Slide slide;
	private SlideManageImpl slideManageImpl;
	public Slide getSlide() {
		return slide;
	}
	public void setSlide(Slide slide) {
		this.slide = slide;
	}
	@Resource
	public void setSlideManageImpl(SlideManageImpl slideManageImpl) {
		this.slideManageImpl = slideManageImpl;
	}
	/**
	 * 功能描述： 参数描述： 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String username = request.getParameter("title");
		Integer currentBussi = getCurrentBussi();
		Page<Slide> page=null;
		if(null!=username&&username.trim().length()>0){
			page = slideManageImpl.pageQuery(pageNo, pageSize, "from Slide where  title like '%"+username+"%'", new Object[]{});
		}else{
			page = slideManageImpl.pageQuery(pageNo, pageSize, "from Slide    ", new Object[]{});
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
	 * 功能描述： 参数描述： 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		if(dbid>0){
			Slide slide2 = slideManageImpl.get(dbid);
			request.setAttribute("slide", slide2);
		}
		return "edit";
	}

	/**
	 * 功能描述： 参数描述： 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public void save() throws Exception {
		HttpServletRequest request = getRequest();
		Integer parentMenu = ParamUtil.getIntParam(request, "parentMenu", 5);
		try{
			Integer dbid = slide.getDbid();
			if(dbid==null||dbid<=0){
				slide.setCreateTime(new Date());
				slide.setModifyTime(new Date());
				slideManageImpl.save(slide);
			}else{
				slideManageImpl.save(slide);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/slide/queryList?parentMenu="+parentMenu, "保存数据成功！");
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
		Integer parentMenu = ParamUtil.getIntParam(request, "parentMenu", 5);
		if(null!=dbids&&dbids.length>0){
			try {
				for (Integer dbid : dbids) {
					slideManageImpl.deleteById(dbid);
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
		renderMsg("/slide/queryList"+query+"&parentMenu="+parentMenu, "删除数据成功！");
		return;
	}
}
