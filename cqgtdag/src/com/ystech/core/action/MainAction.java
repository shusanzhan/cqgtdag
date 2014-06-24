/**
 * 
 */
package com.ystech.core.action;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.model.Department;
import com.ystech.core.model.User;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.service.DepartmentManageImpl;
import com.ystech.core.service.ResourceManageImpl;
import com.ystech.core.util.DateUtil;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;

/**
 * @author shusanzhan
 * @date 2014-2-11
 */
@Component("mainAction")
@Scope("prototype")
public class MainAction extends BaseController{
	private String[] datas={"新到车辆","预警一级","预警二级","自有一级","自有二级","自有三级","自有重点"};
	private String[] hasCardatas={"拥有奇瑞车","没有车","有其他品牌汽车"};
	private ResourceManageImpl resourceManageImpl;
	private HttpServletRequest request=getRequest();
	private DepartmentManageImpl departmentManageImpl;
	@Resource
	public void setResourceManageImpl(ResourceManageImpl resourceManageImpl) {
		this.resourceManageImpl = resourceManageImpl;
	}
	@Resource
	public void setDepartmentManageImpl(DepartmentManageImpl departmentManageImpl) {
		this.departmentManageImpl = departmentManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String login() throws Exception {
		return "login";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String index() throws Exception {
		HttpServletRequest request = this.getRequest();
		User user = SecurityUserHolder.getCurrentUser();
		List<com.ystech.core.model.Resource> resources = resourceManageImpl.queryResourceByUserId(user.getDbid());
		request.setAttribute("resources", resources);
		return "index";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String servicecontent() throws Exception {
		
		return "servicecontent";
	}
	public void submenu() {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		User user = SecurityUserHolder.getCurrentUser();
		try{
			List<com.ystech.core.model.Resource> resources = resourceManageImpl.queryResourceByUserId(user.getDbid(),dbid);
			JSONArray resourceJson=new JSONArray();
			for (com.ystech.core.model.Resource resource : resources) {
				JSONObject jsonObject=new JSONObject();
				jsonObject.put("id", resource.getDbid());
				jsonObject.put("target", "contentUrl");
				jsonObject.put("url", resource.getContent());
				jsonObject.put("name", resource.getTitle());
				resourceJson.put(jsonObject);
			}
			renderJson(resourceJson.toString());
		}catch (Exception e) {
			e.printStackTrace();
			renderText("error");
			return ;
		}
	}
}
