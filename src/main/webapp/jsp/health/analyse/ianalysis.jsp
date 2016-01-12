<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>995120健康服务中心</title>
<link href="<c:url value='/css/common.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/css/index_right.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/css/index_tab.css'/>" rel="stylesheet" type="text/css" />
<script src="<c:url value='/js/jquery/jquery-1.4.4.min.js'/>" type="text/javascript"></script>

<!-- main JS libs -->
<script src="<c:url value='/js/libs/modernizr.min.js'/>"></script>
<script src="<c:url value='/js/libs/jquery-1.10.0.js'/>"></script>
<script src="<c:url value='/js/libs/jquery-ui.min.js'/>"></script>
<script src="<c:url value='/js/libs/bootstrap.min.js'/>"></script>
<!-- Style CSS -->
<link href="<c:url value='/css/bootstrap.css'/>" media="screen" rel="stylesheet">
<link href="<c:url value='/style.css'/>" media="screen" rel="stylesheet">
<!-- scripts -->
<script src="<c:url value='/js/general.js'/>"></script>

<script type="text/javascript">
var tabIndex = "0";
var tabMap = {};

$(function(){
	var $div_li = $("div.tab_menu ul li");
	
	$div_li.click(function(){	
		$(this).addClass("selected").siblings().removeClass("selected");
		var index = $div_li.index(this);
		$("div.tab_box > div").eq(index).show().siblings().hide();
		
		if(index  in tabMap){
		 
		}else{
			if(index == 0){
			 $("#bp_iframe").attr("src","./bp.jsp");
			}else if(index == 1){
			 $("#ecg_iframe").attr("src","./ecg.jsp");
			}
			tabMap[index] = 1;
		}
	});
   
   if(tabIndex in tabMap){
   	
   }else{
	tabMap[tabIndex] = 1;
	if(tabIndex == 0){
		$("#bp_iframe").attr("src","./bp.jsp");
	}else if(tabIndex == 1){
		$("#ecg_iframe").attr("src","./ecg.jsp?flag=0");
	}
	
	$div_li.eq(tabIndex).addClass("selected").siblings().removeClass("selected");
	$("div.tab_box > div").eq(tabIndex).show().siblings().hide();
  }
});
 

function sonIframeResize() {
      
	var iframe = document.getElementById("bp_iframe");
	try {
		var bHeight = iframe.contentWindow.document.body.scrollHeight;
		var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
		var height = Math.min(bHeight, dHeight);
		iframe.height = height;
		
	} catch (ex) {
	    
	}
	
	var iframe = document.getElementById("ecg_iframe");
	try {
		var bHeight = iframe.contentWindow.document.body.scrollHeight;
		var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
		var height = Math.min(bHeight, dHeight);
		iframe.height = height;
		
	} catch (ex) {
	    
	}
}

window.setInterval("sonIframeResize()", 500); 
</script>
</head>

<body>
<div class="example-item alt-color gradient">
<div class="tabs_framed styled" >
    <div class="inner">
        <ul class="tabs clearfix active_bookmark1">
            <li class="active"><a href="#bp" data-toggle="tab" hidefocus="true" class="gradient" style="outline: none;">血压</a></li>
            <li ><a href="#ecg" data-toggle="tab" hidefocus="true" class="gradient" style="outline: none;">心电</a></li>
        </ul>

        <div class="tab-content clearfix">
            <div class="tab-pane fade in active" id="bp">
              	<iframe id="bp_iframe" frameborder="0" width="100%"  scrolling="no"  onload="sonIframeResize();"></iframe>
            </div>
            <div class="tab-pane fade" id="ecg">
                <iframe id ="ecg_iframe"  frameborder="0" width="100%"  scrolling="no" onload="sonIframeResize();"></iframe>
            </div>
        </div>
    </div>
</div>
</div>
<!--
 <div class="index_tab">   
   <div class="tab_menu">
      <ul>
        <li class="selected">血压</li>
        <li>心电</li>
      </ul>
   </div>
   <div class="tab_box">
      <div>
			<iframe id="bp_iframe" frameborder="0" width="100%"  scrolling="no"  onload="sonIframeResize();"></iframe>
      </div>
      <div class="hide">
        	<iframe id ="ecg_iframe"  frameborder="0" width="100%"  scrolling="no" onload="sonIframeResize();"></iframe>
      </div>
   </div>
 </div>
  -->
</body>
</html>
