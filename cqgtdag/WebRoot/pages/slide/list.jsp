<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<title>友情链接管理</title>
<meta charset="UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
</head>
<body>
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">幻灯片管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="${ctx }/slide/add?parentMenu=1">添加</a>
		<a class="but button" href="javascript:void(-1)" onclick="$.utile.deleteIds('${ctx }/slide/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/slide/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table  cellpadding="0" cellspacing="0" class="searchTable">
			<tr>
				<td>幻灯片称：</td>
				<td><input type="text" class="text midea"  id="name" name="name" value="${param.name}" ></input></td>
				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
			</tr>
		 </table>
   		</form>
   	</div>
</div>
<c:if test="${empty(page.result)||page.result==null }" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead class="TableHeader">
		<tr>
			<td class="sn">
					<input type="checkbox" name="title-table-checkbox" id="title-table-checkbox"  onclick="selectAll(this,'id')">
			</td>
			<td class="span2">图片</td>
			<td class="span2">名称</td>
			<td class="span2">类型</td>
			<td  class="span2">链接</td>
			<td class="span1">是否显示</td>
			<td class="span1">排序</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="slide" >
			<tr>
				<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${slide.dbid }">
				</td>
				<td style="text-align: left;">
					<img alt="" src="${slide.picUrl }" width="80" onclick="if('${slide.url }'.indexOf('http')<=0){window.open('http://${slide.url }')}else{window.open('${slide.url }')}">	</td>
				<td>
					${slide.title }
				</td>
				<td>
				<c:if test="${slide.typeid==1 }">
					图片
				</c:if>
				<c:if test="${slide.typeid==2 }">
					文本
				</c:if>
				</td>
				<td>
					<a href="javascript:void(-1)" onclick="if('${slide.url }'.indexOf('http')<=0){window.open('http://${slide.url }')}else{window.open('${slide.url }')}">${slide.url }</a>
				</td>
				<td>
					<c:if test="${slide.display==true }">
						<span style="color: blue;">显示</span>
					</c:if>
					<c:if test="${slide.display==false }">
						<span style="color: red;">隐藏</span>
					</c:if>
				</td>
				<td>${slide.orderNum }</td>
				<td style="text-align: center;">
				<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/slide/edit?dbid=${slide.dbid}&parentMenu=1'">编辑</a> | 
				<a href="javascript:void(-1)" class="aedit" onclick="$.utile.deleteById('${ctx}/slide/delete?dbids=${slide.dbid}','searchPageForm')" title="删除">删除</a></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</c:if>
<div id="fanye">
	<%@ include file="../commons/commonPagination.jsp" %>
</div>
<script type="text/javascript" src="${ctx }/widgets/bootstrap/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
</body>
</html>
