<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="<c:url value='/css/common.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/css/index_tab.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/css/health_records.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/js/artDialog/skins/default.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/js/validationEngine/skins/validationEngine.jquery.css'/>" rel="stylesheet" type="text/css"/>
<link href="<c:url value='/css/popup.css'/>" rel="stylesheet" type="text/css" />
<script src="<c:url value='/js/jquery/jquery-1.8.2.min.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/artDialog/jquery.artDialog.min.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/artDialog/artDialog.plugins.min.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/validationEngine/languages/jquery.validationEngine-zh_CN.js'/>" type="text/javascript" charset="utf-8"></script>
<script src="<c:url value='/js/validationEngine/jquery.validationEngine.js'/>" type="text/javascript" charset="utf-8"></script>
<script src="<c:url value='/js/page/validationEngine-additional-methods.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/base.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/page/jquery.page.js'/>"  type="text/javascript"></script>
<script src="<c:url value='/js/common.js'/>"  type="text/javascript"></script>
<script src="<c:url value='/js/page/jquery.hwin.js'/>"  type="text/javascript"></script>
<script type="text/javascript">
	$(function(){
		jQuery('#changePwd_form').validationEngine("attach",
		    	{
		    				promptPosition:"centerRight:0,-10",
		    				maxErrorsPerField:1,
		    				scroll:false
		    				//binded:false,
		    				//showArrow:false,
		    		}
		    	);
	});
	  function changePwd(){
		   //if(!$("#changePwd_form").valid()){
			if(!jQuery('#changePwd_form').validationEngine("validate")){
				return false;
		   }
		   var requestUrl = "/healthRecordAction/changePwd.action";
		  var para = $("#changePwd_form").dataForJson({prefix:''});
	  	   showScreenProtectDiv(1);
		   showLoading();
	    	xmlHttp = $.ajax({
				url: requestUrl,
				async:true,
				data:para,
				dataType:"json",
				type:"POST",
				complete:function(){
				    hideScreenProtectDiv(1);
			        hideLoading();
				},
				error:function(){
					$.alert('无权限');
				},success:function(response){
				    var modelMap = response.modelMap;
				    var state = modelMap.state;
				    if(state == "0"){
				    	$.alert("修改成功");
				    }else if(state == "-2"){
				    	$.alert("输入旧密码不正确");
				    }else{
				    	$.alert("修改失败");
				    }
				}
			});
	  }
</script>
</head>
<body>
<div>
<form id="changePwd_form">
       <div class="password_information" style="font-family: '微软雅黑'">
         <div class="title_informationModify"><span class="tgrey_title_informationModify">密码</span>修改</div>
         <div class="password_informationMain">
           <ul>
             <li>旧密码：</li>
             <li class="register_input"><input type="password"  id="oldPwd" name="oldPwd" class="validate[required,minSize[6],maxSize[20],funcCall[filterSpecialSign]]"/>
             </li>
             <li>新密码：</li>
             <li class="register_input"><input type="password"  id="newPwd"  name="newPwd"   class= "validate[required,minSize[6],maxSize[20],funcCall[password]]"/>
             </li>
             <li>确认新密码：</li>
             <li class="register_input"><input type="password"  id="confirmPwd"  name="confirmPwd"   class="validate[required,minSize[6],maxSize[20],equals[newPwd],funcCall[password]]"/>
             </li>
             <li class="btn_reguster"><a onclick="changePwd()" style="cursor: pointer;">确定</a></li>
           </ul>
         </div>
       </div>
 </form>
 </div>
   

<div id="divloading">
	<img src="/images/public/blue-loading.gif" />
</div>

<div id="transparentDiv" ></div>

<div id="transparentDiv2"></div>   
</body>
</html>