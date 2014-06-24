<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>新闻 添加</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx }/widgets/ztree/css/zTreeStyleSrc.css" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<style type="text/css">
ul.ztree {
    background: none repeat scroll 0 0 #F0F6E4;
    border: 1px solid #617775;
    height: 200px;
    margin-top: 10px;
    overflow-x: auto;
    overflow-y: scroll;
    width: 320px;
}
</style>
<body>
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/news/queryList'">新闻管理</a>-
   	<a href="javascript:void(-1)" class="current">
		<c:if test="${news.dbid>0 }" var="status">编辑新闻</c:if>
		<c:if test="${status==false }">添加新闻</c:if>
	</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form class="form-horizontal" method="post" action="" 	name="frmId" id="frmId">
		<input type="hidden" value="${news.dbid }" id="dbid" name="news.dbid">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
				<tr>
					<td class="formTableTdLeft">类型：</td>
					<td>
						<input id="newTypeName" type="text" readonly="readonly" name="newTypeName" value="${news.newstype.name }"  checkType="string,1,50" tip="类型不能为空" class="largeX text" onclick="showMenu();" />
						<input id="newTypeDbid" type="hidden" readonly="readonly" name="newTypeDbid" value="${news.newstype.dbid }"  />
						&nbsp;<a id="menuBtn" href="#" onclick="showMenu(); return false;" class="aedit">选择新闻类型</a>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">标题：</td>
					<td>
						<input type="text" name="news.title" id="title"	value="${news.title }" class="largeX text" title="标题"  checkType="string,1,50" tip="标题不能为空">
						<span style="color: red;">*</span>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">排序：</td>
					<td>
						<input type="text" class="largeX text" name="news.orderNum" id="orderNum"  value="${news.orderNum }" checkType="integer,1" canEmpty="Y" tip="请输入排序号！"/>
					</td>
				</tr>
			<tr height="120">
				<td class="formTableTdLeft">内容简介:&nbsp;</td>
				<td >
						<textarea cols="59" rows="10" id="introduction" name="news.introduction" class="text largeXXX"  style="height: 80px;" checkType="string,1,2000" canEmpty="Y" tip="内容简介必须小于2000个字符">${news.introduction }</textarea>
				</td>
			</tr>
				<tr>
					<td colspan="2">
							<textarea cols="59" rows="10" id="content" name="news.content" class="" checkType="string,1,2000" canEmpty="Y" tip="内容简介必须小于2000个字符">${news.content }</textarea>
							<input type="hidden" id="contentText" name="news.contentText">
					</td>
				</tr>
		</table>
	</form>
	<div class="formButton">
			<a href="javascript:void()"	onclick="$.utile.submitForm('frmId','${ctx}/news/save',true)"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
<div id="menuContent" class="menuContent" style="display:none; position: absolute;">
		<ul id="treeDemo" class="ztree" style="margin-top:0; width:230px; height: 250px;"></ul>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/swfupload.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/plugins/swfupload.queue.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/plugins/swfupload.speed.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/js/fileupload.handlers.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ztree/jquery.ztree.core-3.4.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ztree/jquery.ztree.excheck-3.4.min.js"></script>
<script type="text/javascript">
	function show(){
		var options=$("#type option:selected");
		var value=options[0].value;
		if(value=="图片"){
			$("#logoDiv").show();
		}else{
			$("#logoDiv").hide();
		}
	}
	var upload1;
	window.onload = function() {
		upload1 = new SWFUpload(
				{
					// Backend Settings
					upload_url : "${ctx}/swfUpload/uploadFile",
					post_params : {
						"PHPSESSID" : "6a95034fff6ba3a6aa8a990ca3af42ee","userId":"${sessionScope.user.dbid}"
					},
					//上传文件的名称
					file_post_name : "file",

					// File Upload Settings
					file_size_limit : "5242880", // 200MB
					file_types : "*.*",
					file_types_description : "All Files",
					file_upload_limit : "100",
					file_queue_limit : "0",

					// Event Handler Settings (all my handlers are in the Handler.js file)
					file_dialog_start_handler : fileDialogStart,
					file_queued_handler : fileQueued,
					file_queue_error_handler : fileQueueErrorHandler,
					file_dialog_complete_handler : fileDialogComplete,
					upload_start_handler : uploadStart,
					upload_progress_handler : uploadProgress,
					upload_error_handler : uploadError,
					upload_success_handler : uploadSuccess,
					upload_complete_handler : uploadComplete,

					// Button Settings
					button_image_url : "${ctx}/widgets/SWFUpload/images/XPButtonUploadText_61x22.png",
					button_placeholder_id : "spanButtonPlaceholder1",
					button_width : 61,
					button_height : 22,

					// Flash Settings
					flash_url : "${ctx}/widgets/SWFUpload/Flash/swfupload.swf",

					custom_settings : {
						progressTarget : "uploadFileContent",
						cancelButtonId : "btnCancel1",
						titlePicture : "fileUpload",
						fileUploadImage : "fileUploadImage"
					},
					// Debug Settings
					debug : false
				});

	}
</script>
<script type="text/javascript">
	var editor=CKEDITOR.replace("content");
	var setting = {
			check: {
				enable: true,
				chkStyle: "radio",
				radioType: "all"
			},
			view: {
				dblClickExpand: false
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				onClick: onClick,
				onCheck: onCheck
			}
		};
	function onClick(e, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		zTree.checkNode(treeNode, !treeNode.checked, null, true);
		return false;
	}

	function onCheck(e, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
		nodes = zTree.getCheckedNodes(true),
		v = "";
		db = '';
		for (var i=0, l=nodes.length; i<l; i++) {
			v += nodes[i].name + ",";
			db += nodes[i].id + ",";
		}
		if (v.length > 0 ) v = v.substring(0, v.length-1);
		if (db.length > 0 ) db = db.substring(0, db.length-1);
		var cityObj = $("#newTypeName");
		var newTypeDbid = $("#newTypeDbid");
		
		cityObj.attr("value", v);
		newTypeDbid.attr("value", db);
		
	}

	function showMenu() {
		var cityObj = $("#newTypeName");
		var cityOffset = $("#newTypeName").offset();
		$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");

		$("body").bind("mousedown", onBodyDown);
	}
	function hideMenu() {
		$("#menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	function onBodyDown(event) {
		if (!(event.target.id == "menuBtn" || event.target.id == "newTypeName" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
			hideMenu();
		}
	}

	$(document).ready(function(){
		$.post("${ctx}/newsType/jsonNewsType?timeStamp="+new Date()+"&urlType=2", { } ,function callback(json){
			$.fn.zTree.init($("#treeDemo"), setting, json);
			
		});
	});
</script>
</html>
