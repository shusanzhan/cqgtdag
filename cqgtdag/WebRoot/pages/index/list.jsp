<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>后台表单页面</title>
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
</head>
<body>
  <div class="head">
    <div class="logo"></div>
    <div class="head_nav">
      <c:forEach var="resource" items="${ resources}" varStatus="i" begin="0">
      	<c:if test="${i.index==0 }" var="status">
	      	<c:set var="resourceFirst" value="${resource }"></c:set>
      	 	<a href="javascript:void(-1)" onclick="subMenu(${resource.dbid},this)" class="active" id="menu${resource.dbid }">${resource.title }</a>
      	 </c:if>
      	 <c:if test="${status==false }">
	      	<a href="javascript:void(-1)" onclick="subMenu(${resource.dbid},this)" id="menu${resource.dbid }">${resource.title }</a>
	      </c:if>
      </c:forEach>
    </div>
  </div>
  <!--head end-->
    <div class="leftMenu">
      <div class="user">
        <div style="float:left;margin-right:10px;"><img src="${user.staff.photo }" width="37" height="37"/></div>
        <div style="float:left;">欢迎您<br />${user.userId }</div>
        <div class="clear"></div>
        <div class="user_a"><a  target="contentUrl" href="${ctx }/user/editSelf">账号设置</a>&nbsp;&nbsp;&nbsp; <a href="${ctx }/j_spring_security_logout">注销</a></div>
      </div>
      <div id="contentLeftMenu" class="left_nav" >
      </div>
    </div>
    <!--main_main-->
	 <iframe id="contentUrl" name="contentUrl" src="${ctx }/pages/index/content.jsp" scrolling="auto"  frameborder="0" class="contentUrl"  ></iframe>
  <!--main-->
</body>
<script src="${ctx }/widgets/bootstrap/jquery.min.js"></script>
<script src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	 var wWight = (window.document.documentElement.clientWidth || window.document.body.clientWidth || window.innerWidth);
	 var wHeight = (window.document.documentElement.clientHeight || window.document.body.clientHeight || window.innerHeight);
	 var contentUrlWi=wWight-145;
	 var leftHeight=wHeight-72;
	 if(is_ie){
		 contentUrlWi=wWight-149;
		 leftHeight=wHeight-80;
	 }
	 if(is_moz){
		 contentUrlWi=wWight-162;
		 leftHeight=wHeight-80;
	 }
	 $(".leftMenu").css("height",leftHeight);
	 $("#contentUrl").height(leftHeight);
	 $("#contentUrl").width(contentUrlWi);
	 subMenu("${resourceFirst.dbid}",null);
	 
	 //
})
window.onresize=function(){
	var wWight = (window.document.documentElement.clientWidth || window.document.body.clientWidth || window.innerWidth);
	var wHeight = (window.document.documentElement.clientHeight || window.document.body.clientHeight || window.innerHeight);
	 var contentUrlWi=wWight-145;
	 $("#contentUrl").width(contentUrlWi);
	 $(".leftMenu").css("height",wHeight-72);
	 $("#contentUrl").height(wHeight-72);
}
function subMenu(dbid,obj){
	if(null!=obj&&obj!=undefined){
		var head=$(".head_nav").find(".active").removeClass("active");
		$(obj).addClass("active");
	}
	
	$.post("${ctx}/main/submenu?dbid="+dbid+"&dateStamp="+new Date(),{},function(data){
		if(data=="error"){
			$(".left_nav").append();
		}else{
			var length=data.length;
			var menu="<ul>";
			for(i=0;i<length;i++){
				menu=menu+'<li onclick="targetLink(this)"><a href="'+data[i].url+'" target="'+data[i].target+'" >'+data[i].name+'</a></li>';
			}
			menu=menu+"</ul>";
			$(".left_nav").text("");
			$(".left_nav").append(menu);
		}
	})
}
function targetLink(obj){
	$(".left_nav").find(".active").removeClass("active");
	$(obj).addClass("active");
}

function showMessageBox(){
	$.post("${ctx}/message/noticeMessage",{},function (data){
		if(data.status==true){
			var content='<div style="text-align:center;">'+
			              '<a href="'+data.url+'" target="contentUrl">'+data.title+'</a>'+
						  '<div style="text-indent: 24px;text-align: left;">'+data.content+'</div>'+
						 '</div>';
			$.utile.MessageBox(content,data.dbid);
		}else if(data.status==false){
		}
	})
}
</script>
</html>
