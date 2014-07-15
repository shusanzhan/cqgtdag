package com.ystech.core.action;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.Md5;
import com.ystech.core.web.BaseController;
import com.ystech.core.model.Department;
import com.ystech.core.model.Staff;
import com.ystech.core.model.Table1;
import com.ystech.core.model.User;
import com.ystech.core.service.Table1ManageImpl;

@Component("table1Action")
@Scope("prototype")
public class Table1Action extends BaseController {
	private Table1 table1;
	private Table1ManageImpl table1ManageImpl;
	
	public void setTable1(Table1 value){
		this.table1=value;
	}
	
	public Table1 getTable1(){
		return this.table1;
	}
	
	public void setTableManageImpl(Table1ManageImpl value){
		this.table1ManageImpl=value;
	}
	
	public Table1ManageImpl getTableManageImpl(){
		return this.table1ManageImpl;
	}
	
	public void save() throws Exception {
		HttpServletRequest request = this.getRequest();
		String[] departmentIds = request.getParameterValues("departmentIds");
		table1ManageImpl.save(table1);
		
		renderMsg("/user/queryList", "保存数据成功！");
		return ;
	}
}
