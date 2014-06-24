<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>幻灯片 添加</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/slide/queryList'">幻灯片管理</a>-
   	<a href="javascript:void(-1)" class="current">
		<c:if test="${slide.dbid>0 }" var="status">编辑幻灯片</c:if>
		<c:if test="${status==false }">添加幻灯片</c:if>
	</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form class="form-horizontal" method="post" action="" 	name="frmId" id="frmId">
		<input type="hidden" value="${slide.dbid }" id="dbid" name="slide.dbid">
		<input type="hidden" value="${slide.createTime }" id="createTime" name="slide.createTime">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
				<tr>
					<td class="formTableTdLeft">名称：</td>
					<td>
						<input type="text" class="largeX text" name="slide.title"	id="title" value="${slide.title }" checkType="string,1,100"  tip="请输入网站名称！"  />
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">类型 ：</td>
					<td>
						<select id="typeid" name="slide.typeid" onchange="show();">
							<option value="1">图片</option>
							<option value="2">文本</option>
						</select>
					</td>
				</tr>
				
				<c:if test="${!empty(slide.picUrl)||fn:length(slide.picUrl )>0  }" var="status">
				<tr id="logoDiv">
						<td class="formTableTdLeft">图片：</td>
						<td>
							<input type="hidden" name="slide.picUrl" id="fileUpload" readonly="readonly"	value="${slide.picUrl }" tip="请上传图片">
							<img alt="" id="fileUploadImage" src="${slide.picUrl }" width="50" height="30">
							<div id="div1">
								<div style="padding-left: 5px;">
								<span id="spanButtonPlaceholder1"></span> <br />
							</div>
								<div id="uploadFileContent" class="uploadFileContent" style="width: 200px"></div>
								图片：规格为560*400
							</div>
						</td>
				</tr>
				</c:if>
				<c:if test="${status==false }">
				<tr id="logoDiv" > 
					<td class="formTableTdLeft">图片：</td>
					<td>
						<input type="hidden" name="slide.picUrl" id="fileUpload" readonly="readonly"	value="${slide.picUrl }" tip="请上传图片">
						<img alt="" id="fileUploadImage" src="${slide.picUrl }" width="50" height="30">
						<div id="div1">
							<div style="padding-left: 5px;">
							<span id="spanButtonPlaceholder1"></span> <br />
						</div>
							<div id="uploadFileContent" class="uploadFileContent" style="width: 200px"></div>
							图片：规格为560*400
						</div>
					</td>
					</tr>
				</c:if>
				<tr>
					<td class="formTableTdLeft">链接：</td>
					<td>
						<input type="text" class="largeX text" name="slide.url"	id="url" value="${slide.url }" checkType="url" canEmpty="Y" tip="请输入正确的网址！" />
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">启用：</td>
					<td>
						<input  type="checkbox" name="slide.display" id="display"  value="true" ${slide.display==true?'checked="checked"':'' } />启用
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">排序：</td>
					<td>
						<input type="text" class="largeX text" name="slide.orderNum" id="orderNum"  value="${slide.orderNum }" checkType="integer,1" canEmpty="Y" tip="请输入排序号！"/>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">备注：</td>
					<td>
						<textarea class="largeX text" name="slide.description" id="description"  cols="6" rows="6" style="height: 80px;">${slide.description}</textarea>
					</td>
				</tr>
		</table>
	</form>
	<div class="formButton">
			<a href="javascript:void()"	onclick="$.utile.submitForm('frmId','${ctx}/slide/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/swfupload.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/plugins/swfupload.queue.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/plugins/swfupload.speed.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/js/fileupload.handlers.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript">
	function show(){
		var options=$("#typeid option:selected");
		var value=options[0].value;
		if(value=="1"){
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
						fileUploadImage : "fileUploadpicUrl"
					},
					// Debug Settings
					debug : false
				});

	}
</script>
</html>
