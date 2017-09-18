<%@page language="java" import="com.cdsf.webmvc.RuntimeContext" pageEncoding="UTF-8"  contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="s" uri="http://www.springframework.org/tags" %>

<%
String path = request.getContextPath();
String casClient=RuntimeContext.get("cas.client",
		String.class, RuntimeContext.SCOPE_CONFIG);
%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>资源加载中...</title>
<script type="text/javascript" src="<s:url value='/static/js/lib/jquery.js?ver=20140102'/>"></script>
<script type="text/javascript">
$(function(){

    var indexPath="<%=path%>/static/index.jsp";
	var url=GetQueryString("skipTo")||localStorage.skipTo;
	
	if(url&&url!="null"){localStorage.skipTo=url;}
	else{
		top.location.href = indexPath;
		return;
	}

	 $.ajax({
         type:'post',
         data:"",
         url: "<%=path%>/login/loginCheck.json",
         dataType: 'json',
         success:function (data) {
<%--         	 url="<%=path%>/static/app.html"; --%>
			 //第二步，然后检查单点登录状态，如果通过，直接跳转要访问的系统主页
			 //第三步，如果登录一个系统后，回到portal主页，再去访问其他系统，这时打开新窗口，跳转到要访问的系统主页
// 			alert("check login success,arg fromLoginJsp is "+localStorage.fromLoginJsp)
			skipToUrlAndReturnIndex(url,indexPath,localStorage.fromLoginJsp);
         },
         error:function (ex) {
             //第一步，点击系统入口按钮,登录状态检查不通过，于是到这里登录：新打开portal登录页面，登录后，跳转回到redirect页面
             if (ex.status == 401) {
                var loginLocation  = decodeURI(ex.getResponseHeader("Login-Location"));
                localStorage.fromLoginJsp=true;
                window.open(loginLocation, "_blank");
                top.location.href = indexPath;
             }
         }
	 }
	);
	
	if(window != top) {
		top.location.href = url;///window.location.href;
		return;
	}
	

	function GetQueryString(name)
	{
	     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
	     var r = window.location.search.substr(1).match(reg);
	     if(r!=null)return  unescape(r[2]); return null;
	}
	//新打开url并返回主页，如果跳转成功，删除缓存的url
	function skipToUrlAndReturnIndex(url,indexPath,fromLoginJsp){

		if(!fromLoginJsp||fromLoginJsp=="null"||fromLoginJsp=="undefined"){//第三步从主页跳转过来的，打开新窗口url

	   		window.open(url, "_blank");
	   	 	top.location.href = indexPath;///window.location.href;
		}else{//第二步登录后跳转过来的，直接在登录页面跳url

// 			从登录页面跳一次马上清fromLoginJsp缓存
			localStorage.fromLoginJsp=null;
			top.location.href = url;
		}
// 		跳一次马上清url缓存
		localStorage.skipTo=null;
	}
});
	</script>
</head>
<body>
	资源加载中...
</body>
</html>

