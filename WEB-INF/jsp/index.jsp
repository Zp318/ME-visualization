<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta charset="utf-8">
    <title>visual</title>
        <base href="/me/">
        <%

    String basePath = request.getScheme() +"://" + request.getServerName()+ ":" +request.getServerPort() + request.getContextPath() + "/";
%>
           <link  href="${pageContext.request.contextPath}/static/css/app.css" rel=stylesheet>
           <script type=text/javascript src="${pageContext.request.contextPath}/static/js/manifest.js"></script>
           <script type=text/javascript src="${pageContext.request.contextPath}/static/js/vendor.js"></script>
           <script type=text/javascript src="${pageContext.request.contextPath}/static/js/app.js"></script>
 
  </head>
  <body style="min-width: 1024px">
    <div id="app"></div>
    <!-- built files will be auto injected -->
  </body>
</html>

  <script>
         (function (doc, win) {
         var docEl = doc.documentElement,
              recalc = function () {
                 //getBoundingClientRect获取元素位置 
         var mainWidth = document.getElementsByTagName("body")[0].getBoundingClientRect().width;
           // 1366 1920屏幕最小最大宽度
                 if(mainWidth<1280)mainWidth = 1280;
                 if(mainWidth>1920)mainWidth = 1920;
           if (!mainWidth) return;
                    docEl.style.fontSize = 100 * (mainWidth / 1366) + 'px';
                };
            recalc(); 
            win.addEventListener("resize", recalc, false);
            doc.addEventListener('DOMContentLoaded', recalc, false);
        })(document, window); 
  </script>