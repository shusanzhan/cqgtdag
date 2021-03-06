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
	<a href="javascript:void(-1);" onclick="">新闻管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="${ctx }/news/add?parentMenu=1">添加</a>
		<a class="but button" href="javascript:void(-1);" onclick="$.utile.operatorDataByDbids('${ctx}/news/startNewsByIds','searchPageForm','您确定要启用所选新闻吗？')" title="启用所选新闻">启用</a>
		<a class="but button" href="javascript:void(-1);" onclick="$.utile.operatorDataByDbids('${ctx}/news/canncelNewsByIds','searchPageForm','您确定要停止所选新闻吗？')"  title="停止所选新闻">停止</a>
		<a class="but button" href="javascript:void(-1);" onclick="createIndex('${ctx}/news/createIndex')"  title="创建索引">创建索引</a>
		<a class="but button" href="javascript:void(-1)" onclick="$.utile.deleteIds('${ctx }/news/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/news/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table  cellpadding="0" cellspacing="0" class="searchTable">
			<tr>
				<td>标题：</td>
				<td><input type="text" id="newName" class="text midea"  name="newName" value="${param.newName}"></input></td>
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
			<td class="span2">标题</td>
			<td class="span2">发布人</td>
			<td  class="span2">类型</td>
			<td class="span1">发布时间</td>
			<td class="span1">点击数</td>
			<td class="span1">状态</td>
			<td class="span1">排序</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="news">
			<tr>
				<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${news.dbid }">
				</td>
				<td align="left" title="${news.title }">
			<c:if test="${fn:length(news.title)<20 }" var="status">
				${news.title }
			</c:if>
			<c:if test="${status==false }">
				${fn:substring(news.title,0,20) }...
			</c:if>
			</td>
			<td>${news.releasePerson.realName }</td>
			<td>${news.newstype.name }</td>
			<td>
			<fmt:formatDate value="${news.releaseDate }" pattern="yyyy-MM-dd mm:hh"/>
			</td>
			<td>${news.readNum }</td>
			<td>
				<c:if test="${news.isStop==true }" var="status">
					<span style="color: #008000;">启用</span>
				</c:if>
				<c:if test="${status==false }">
					<span style="color: red;">停用</span>
				</c:if>
			</td>
			<td>${news.orderNum }</td>
			<td style="text-align: center;">
				<a href="javascript:void(-1)" class="aedit"	onclick="window.location.href='${ctx }/news/edit?dbid=${news.dbid}'">编辑</a>
				<a href="javascript:void(-1)" class="aedit" onclick="$.utile.deleteById('${ctx }/news/delete?dbids=${news.dbid}','searchPageForm')">删除</a>
				<a href="javascript:void(-1)" class="aedit" onclick="window.open('${ctx}/home/read?dbid=${news.dbid }')">预览</a>
				<c:if test="${news.isStop==true }" var="status">
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/news/startNews?dbid=${news.dbid}','searchPageForm','您确定要停止该新闻吗？')">停止</a>
				</c:if>
				<c:if test="${status==false }">
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/news/startNews?dbid=${news.dbid}','searchPageForm','您确定要启用该新闻吗？')">启用</a>
				</c:if>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</c:if>
<div id="fanye">
	<%@ include file="../commons/commonPagination.jsp" %>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript">
function createIndex(url){
	window.top.art.dialog({
		content : '您确要创建索引吗？',
		icon : 'warning',
		width:"250px",
		height:"80px",
		window : 'top',
		lock : true,
		ok : function() {// 点击去定按钮后执行方法
			$.post(url + "?datetime=" + new Date(),{},function callBack(data) {
				if (data[0].mark == 2) {// 关系存在引用，删除时提示用户，用户点击确认后在退回删除页面
					window.top.art.dialog({
						content : data[0].message,
						icon : 'warning',
						window : 'top',
						width:"250px",
						height:"80px",
						lock : true,
						ok : function() {// 点击去定按钮后执行方法

							$.utile.close();
							return;
						}
					});
				}
				if (data[0].mark == 1) {// 删除数据失败时提示信息
					/* $.cqtaUtile.errMessage(data[0].message); */
					$.utile.tips(data[0].message);
				}
				if (data[0].mark == 0) {// 删除数据成功提示信息
					/* $.cqtaUtile.okDeleteMessage(data[0].message); */
					$.utile.tips(data[0].message);
				}
				// 页面跳转到列表页面
				setTimeout(function() {
					window.location.href = data[0].url
				}, 1000);
			});
		},
		cancel : true
	});
}
</script>
</html>
