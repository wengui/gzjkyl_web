<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>995120健康服务中心 | 找回密码</title>
<link rel="Shortcut Icon" href="/995120.ico"/>
<link href="<c:url value='/css/common.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/css/password.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/css/index_bottom.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/js/artDialog/skins/blue.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/js/validationEngine/skins/validationEngine.jquery.css'/>"  rel="stylesheet"  type="text/css" />
<script src="<c:url value='/js/jquery/jquery-1.8.2.min.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/artDialog/jquery.artDialog.min.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/artDialog/artDialog.plugins.min.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/validationEngine/languages/jquery.validationEngine-zh_CN.js'/>" type="text/javascript" charset="utf-8"></script>
<script src="<c:url value='/js/validationEngine/jquery.validationEngine.js'/>"  type="text/javascript" charset="utf-8"></script>
<script src="<c:url value='/js/page/validationEngine-additional-methods.js'/>"  type="text/javascript"></script>
<!-- main JS libs -->
<script src="<c:url value='/js/libs/modernizr.min.js'/>"></script>
<script src="<c:url value='/js/libs/bootstrap.min.js'/>"></script>
<!-- Style CSS -->
<link href="<c:url value='/css/bootstrap.css'/>" media="screen" rel="stylesheet">
<link href="<c:url value='/style.css'/>" media="screen" rel="stylesheet">
<!-- scripts -->
<script src="<c:url value='/js/general.js'/>"></script>
<script type="text/javascript">
	<!--
	function MM_jumpMenu(targ,selObj,restore){ //v3.0
	  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
	  if (restore) selObj.selectedIndex=0;
	}
	//-->
	var check_login_id=false;
	var memberBaseInfo=null;
	
	function checkLoginId(){
		memberBaseInfo=null;
		check_login_id=false;
		var login_id=$("#login_id").val();
		if(login_id==""){
			$("#login_id").attr("style","color:#ccc;");
			$("#login_id").val("用户名");
		}
		if(login_id.length<5||login_id.length>30){
			$("#login_id_point").html("<span class='tRed'>*</span>用户名长度在5-30之间！");			
			return false;
		}
		var c= /^[a-zA-Z0-9]{1}\w{4,29}$/; 
		if(!c.test(login_id)){
			$("#login_id_point").html("<span class='tRed'>*</span>用户名含非法字符！");
			return false;
		}
		para="login_id="+login_id;
		
		xmlHttp = $.ajax({						
				url:"/gzjky/register/queryMemberBaseInfoByLoginId.do",
				cache: false,
				async: false,
				data:para,
				dataType:"json",
				type:"POST",

				error:function(){
					$.alert('异常');
				},success:function(response){
					if(response==null){
						$("#login_id_point").html("<span class='tRed'>*</span>您输入的用户名不存在，请重新输入！");	
					}
					else {						
						memberBaseInfo=response;
						$("#login_id_point").html("<img src='../../images/login/tick.png'/>");
						check_login_id=true;					
					}
				}
		});		
	}
	
	function checkMail(){
			var c= /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((.[a-zA-Z0-9_-]{2,3}){1,2})$/;
			var mail=$("#mail").val();
			
			if(mail==""){
				$("#mail").attr("style","color:#ccc;");
				$("#mail").val("绑定邮箱地址");
				$("#mail_point").html("<span class='tRed'>*</span>请输入绑定邮箱地址！");
				return false;
			}
			if(!c.test(mail)){
				$("#mail_point").html("<span class='tRed'>*</span>请输入正确的邮箱地址！");
				return false;
			}	
			if(memberBaseInfo!=null){
				if(memberBaseInfo.email==null||memberBaseInfo.email==""){
					 $("#mail_point").html("<span class='tRed'>*</span>该用户名没有绑定邮箱，请使用手机号码找回！"); 
				}
				else if(mail==memberBaseInfo.email){
					$("#mail_point").html("<img src='../../images/login/tick.png'/>");		
					return true;
				}
				else{
					$("#mail_point").html("<span class='tRed'>*</span>请检查输入的邮箱地址与绑定的邮箱地址是否一致！");
					return false;
				}
			}
			else{
				/* $("#mail_point").html("<span class='tRed'>*</span>该用户名没有绑定邮箱，请使用手机号码找回！"); */	
				return false;
			}
	}
	
	function checkCellPhone(){
			var c=/^((00){1}[1-9]{1}[0-9]{1,3}|86|\+86)?1[3458]\d{9}$/;
			var cell_phone=$("#cell_phone").val();
			if(cell_phone==""){
				$("#cell_phone").attr("style","color:#ccc;");
				$("#cell_phone").val("绑定手机号码");
				return false;
			}
			if(!c.test(cell_phone)){
				$("#cell_phone_point").html("<span class='tRed'>*</span>请输入正确的手机号码！");
				return false;
			}	
			if(memberBaseInfo!=null){
				if(memberBaseInfo.cellphone==null||memberBaseInfo.cellphone==""){
					$("#cell_phone_point").html("<span class='tRed'>*</span>该用户没有绑定手机号码！");	
					return false;
				}
				else if(cell_phone==memberBaseInfo.cellphone){
					$("#cell_phone_point").html("");		
					return true;
				}
				else{
					$("#cell_phone_point").html("<span class='tRed'>*</span>请检查输入的手机号码与绑定的手机号码是否一致！");
					return false;
				}
			}
			else{
				/* $("#cell_phone_point").html("<span class='tRed'>*</span>该用户没有绑定手机号码！");	 */
				return false;
			}
	}
	
	function sendCellPhone(obj){			
			if(!checkCellPhone()){
				return false;
			}
			time(obj);
			var login_id=$("#login_id").val();
			var cell_phone=$("#cell_phone").val();
			var para="login_id="+login_id+"&cell_phone="+cell_phone;
			xmlHttp = $.ajax({						
				url:"/register/sendCellPhone.action",
				async:true,
				data:para,
				dataType:"json",
				type:"POST",		
				error:function(){
					$.alert('异常');
				},success:function(response){					
					$("#cell_phone_point").html(response);			
				}
			});	
	}
	
	var wait=60;
	function time(obj) {
		if (wait == -1) {
			//$("#send_check_code").attr("onclick","sendCellPhone()");
			obj.onclick = function(){sendCellPhone(obj);};	
			$("#send_check_code").html("发送验证码");	
			wait = 60;
		} else {
			$("#send_check_code").attr("onclick", "");
			$("#send_check_code").html("重新发送(" + wait + ")");
			wait--;
			setTimeout(function() {
				time(obj);
			},
			1000);
		}
	}
	
	function checkCheckCode(){
		var c=/^\d{4,6}$/;
		var check_code=$("#check_code").val();
		if(check_code==""){
			$("#check_code").attr("style","color:#ccc;");
			$("#check_code").val("验证码");
		}
		if(!c.test(check_code)){
			$("#check_code_point").html("<span class='tRed'>*</span>请输入正确的验证码！");
			return false;
		}
		/* $("#check_code_point").html("<img src='../../images/login/tick.png'/>"); */
		$("#check_code_point").html("");
		return true;
	}
	
	function showPoint(obj){
		 if(obj.value=="用户名"){
			obj.value="";		 
			$("#login_id").attr("style","color:#5a5a5a;"); 
		} 
		if(obj.value=="绑定手机号码"){
			obj.value="";
			$("#cell_phone").attr("style","color:#5a5a5a;"); 
		}
		if(obj.value=="绑定邮箱地址"){
			obj.value="";
			$("#mail").attr("style","color:#5a5a5a;"); 
		}
		if(obj.value=="验证码"){
			obj.value="";
			$("#check_code").attr("style","color:#5a5a5a;"); 
		}
	}
	
	function changeBackWay(){
 		$("#password_phone").css("display","none");
		$("#password_mail").css("display","none");
		var c=$("#back_way").val();
		if(c=="0"){
			$("#password_phone").css("display","block");
		}
		if(c=="1"){
			$("#password_mail").css("display","block");
		}
	    
		/* var c=$("#back_way").val();
		if(c=="0"){
			$(".password_phone").attr("style","display:block");
			$(".password_mail").attr("style","display:none");
		}
		if(c=="1"){
			$(".password_phone").attr("style","display:none"); 
			$(".password_mail").attr("style","display:block"); 
		} */
	}
	
	function toChangePasswd(){
		checkLoginId();
		var back_way=$("#back_way").val();
		if(back_way=="0"){
			if(check_login_id&checkCellPhone()&checkCheckCode()){		
				var login_id=$("#login_id").val();
				var cell_phone=$("#cell_phone").val();
				var check_code=$("#check_code").val();
				var para="login_id="+login_id+"&cell_phone="+cell_phone+"&memo="+check_code;
				xmlHttp = $.ajax({						
					url:"/gzjky/findPwd/checkCode.do",
					async:true,
					data:para,
					dataType:"json",
					type:"POST",		
					error:function(){	
						$.alert('异常');
					},success:function(response){		
						if(response.result=="-1"){	
							$("#cell_phone_point").html("<span class='tRed'>*</span>请先获取手机验证码！");
						}	
						if(response.result=="-2"){		
							$("#check_code_point").html("<span class='tRed'>*</span>验证码错误或失效！");
						}	
						if(response.result=="1"){		
							$("#login_id").val("");
							$("#cell_phone").val("");
							$("#check_code").val("");
							window.location.href="password_modification.jsp?login_id="+login_id+"&cell_phone="+cell_phone+"&check_code="+check_code;
						}
					}
				});	
			}
		}
		else if(back_way=="1"){
			if(checkMail()&check_login_id){	
				var login_id=$("#login_id").val();
				var mail=$("#mail").val();
				var para="login_id="+login_id+"&email="+mail;
				xmlHttp = $.ajax({						
					url:"/gzjky/findPwd/sendPwd.do",
					async:true,
					data:para,
					dataType:"json",
					type:"POST",		
					error:function(){	
						$("#result_point").html("<span class='tRed'>*</span>出现异常！");
					},success:function(response){		
						if(response.result=="-1"){
							$("#result_point").html("<span class='tRed'>*</span>连接邮件服务失败！");
						}
						if(response.result=="-2"){
							$("#result_point").html("<span class='tRed'>*</span>出现异常！");
						}
						if(response.result=="-3"){
							$("#result_point").html("<span class='tRed'>*</span>抱歉，您上次提交的忘记密码申请还未处理，1小时内不能重复申请！");
						}
						if(response.result=="1"){
							$("#login_id").val("");
							$("#back_way").val("0");
							$("#mail").val("");				
							window.location.href="password_mail_success.jsp?mail="+mail;
						}
					}
				});	
			}
		}
	}
	
	document.onkeydown=function() {  
		if (window.event.keyCode==13) {
		    toChangePasswd();
		}
	};	
</script>
</head>

<body>
  <div class="register">
   <!--register_header start--> 
	<div class="register_header">
      <div class="bgTop_register">
        <div class="login_out">
          <ul>
           <li class="login_wechat"><a href="../health/index/wechat.jsp" title="995120健康服务中心官方微信" target="_blank">官方微信</a></li>
           <li class="login_bolg"><a title="995120健康服务中心官方微博" href="http://weibo.com/5137507355/profile" target="_blank">官方微博</a></li>
           <li class="login_service_phone">400-0785-120</li>
           <li class="login_top"><a href="../login.jsp">用户登录</a></li>
           <li class="login_register"><a href="../register/protocol.jsp">立即注册</a></li> 
          </ul>
        </div>
        <div class="logo_menu">
          <div class="bgLogo_register">
            <ul>
             <li class="tGraymax">找回密码</li>
             <li class="goHome"><a href="../login.jsp">返回首页</a></li>
            </ul>
          </div>
        </div>
      </div>
    </div>
    <!--register_header end-->
    
    <!--register_middle start-->
    <div class="register_middle">
      <div class="register_main">
        <div class="bg_register">
          <div class="register_title">
            <ul>
              <li class="titleGreen">找回密码</li>
              <li class="titleGray"></li>
            </ul>
          </div>
          <div class="password_choice">
            <div class="password_choice_left"></div>
            <div class="password_choice_right">
              <ul>
                <li class="register_input"><input type="text" value="用户名" name="login_id"  id="login_id"   maxlength="30" onblur="checkLoginId()" onfocus="showPoint(this)"/></li>
                <li class="register_prompt"  id="login_id_point"></li>
                <li class="register_input"><select name="back_way" id="back_way" onchange="changeBackWay()"><option selected="selected" value="0">通过手机找回密码</option><option value="1">通过邮箱找回密码</option>
                </select></li>
                <div id="password_phone" style="">
	                <li class="register_input"><input type="text" value="绑定手机号码" name="cell_phone" id="cell_phone" onblur="checkCellPhone()" onfocus="showPoint(this)"  maxlength="20"/></li>
	                <li class="captcha"><a href="javascript:void(0)" onclick="sendCellPhone(this);" id="send_check_code" title="发送验证码">发送验证码</a></li>
	                <li class="captcha_prompt" id="cell_phone_point"></li>
	                <li class="register_input"><input type="text" value="验证码"  name="check_code" id="check_code" onblur="checkCheckCode()" onfocus="showPoint(this)" maxlength="8"/></li>
	                <li class="register_prompt" id="check_code_point"></li>
	            </div>
                <!-- <li class="register_prompt"></li> -->
                <div id="password_mail" style="display:none">
	                <li class="register_input"><input type="text" value="绑定邮箱地址" name="mail" id="mail" onblur="checkMail()" onfocus="showPoint(this)"/></li>
	                <li class="register_prompt" id="mail_point"></li>
	                <li class="captcha_prompt" id="result_point"></li>
	            </div>
                <li class="btn_reguster"><a href="javascript:void(0)" onclick="toChangePasswd()" title="下一步">下一步</a></li>
              </ul>
            </div>  
          </div>   
        </div>
      </div>  
    </div>
    <!--register_middle end-->
    
    <!--index_health_bottom start-->
	<style>
		.tGray_bottom a{text-decoration: none; color: #ffffff;}
	</style>

    <!--index_health_bottom start-->
    <a name="page_botton_block"></a>
    <div class="index_health_bottom" >
      <div class="bottom_main">
        <div class="bottom_contact">
          <ul>
            <li class="tWhite">
            <span class="tGreen" title="联系我们">Contact us</span>联系我们
            </li>
            <li class="tGray_bottom" title="地址">地址：浙江省杭州市西湖区西斗门路天堂软件园E幢13楼</li>
            <li class="tGray_bottom" title="客服热线">客服热线：400-0785-120</li>
            <li class="tGray_bottom" title="公司官网">公司官网：<a href="http://www.hellowin.cn" target="_blank">www.hellowin.cn</a></li>
            <li class="tGray_bottom" title="服务邮箱">邮箱：helowin@hellowin.cn</li>
            <li class="tGray_bottom">
				<a href="http://122.224.75.236/wzba/login.do?method=hdurl&doamin=http://www.995120.cn&id=330108000063652&SHID=1223.0AFF_NAME=com.rouger.
				gs.main.UserInfoAff&AFF_ACTION=qyhzdetail&PAGE_URL=ShowDetail"
				target="_blank"> <img src="http://122.224.75.236/wzba/view/baxx/gh.jpg" border="0"></a>        
            </li>
          </ul>
        </div>
        <div class="bottom_help">
          <ul>
            <li class="tWhite"></li>
            <li class="taqueation_left"></li>
            <li class="taqueation_middle"></li>
            <li class="taqueation_right"></li>
            <li class="taqueation_left"></li>
            <li class="taqueation_middle"></li>
            <li class="taqueation_right"></li>
          </ul>
        </div>
        <div class="bottom_concern">
          <ul>
            <li class="tWhite"><span class="tGreen">Concern us</span>关注我们</li>
            <li class="wechat_code">官方微信</li>
            <li class="blog_code">官方新浪微博</li>
          </ul>
        </div>
        <div class="copyright">
	        Copyright © 2010-2014 浙江好络维物联网络技术有限公司版权所有  浙ICP备10212076号-1
	        <script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1000351579'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s22.cnzz.com/z_stat.php%3Fid%3D1000351579%26show%3Dpic1' type='text/javascript'%3E%3C/script%3E"));</script>    
        </div>
      </div>
    </div>
    <!--index_health_bottom start-->
    <!--index_health_bottom start-->
  </div>
</body>
</html>
