<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html style="overflow-y: hidden;">
    <head>
    <%

    String basePath = request.getScheme() +"://" + request.getServerName()+ ":" +request.getServerPort() + request.getContextPath() + "/";
%>
        <base href="<%=basePath%>"> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>四方大数据平台</title>
        <link rel="stylesheet" type="text/css" href="<%=basePath%>static/portal/css/app.css">

</head>
    <body>
    	<div id=app></div>
    	<script type="text/javascript">
		    var basePath = "<%=basePath%>";
		</script>
		<script type="text/javascript" src="<%=basePath%>static/portal/js/manifest.js"></script>
		<script type="text/javascript" src="<%=basePath%>static/portal/js/vendor.js"></script>
		<script type="text/javascript" src="<%=basePath%>static/portal/js/app.js"></script>
    </body>
</html>
<script>(function (doc, win) {
            
         var docEl = doc.documentElement,
              recalc = function () {
                 //getBoundingClientRect获取元素位置 
         var mainWidth = document.getElementsByTagName("body")[0].getBoundingClientRect().width;
       
           // 1280 1920屏幕最小最大宽度
                 if(mainWidth<1280)mainWidth = 1280;
                 if(mainWidth>1920)mainWidth = 1920;
           if (!mainWidth) return;
                    docEl.style.fontSize = 100 * (mainWidth / 1280) + 'px';
                };
            recalc(); 
            win.addEventListener("resize", recalc, false);
            doc.addEventListener('DOMContentLoaded', recalc, false);
        })(document, window); 


        if(document.frames){
          let docHtml=null;
            document.frames['test'].onload=function(){  
              docHtml = this.contentWindow.document.getElementsByTagName('html')[0];
             docHtml .style.overflowX="hidden";
            }    
          }else{
            let docHtml=null;
                document.getElementById('test').onload=function(){  
             docHtml = this.contentWindow.document.getElementsByTagName('html')[0]; 
             docHtml .style.overflowX="hidden";
            }         
          }</script>