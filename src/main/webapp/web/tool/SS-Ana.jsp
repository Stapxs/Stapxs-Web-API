<%@ page import="cn.stapxs.api.util.Number" %>
<%@ page import="cn.stapxs.api.appInfo" %>
<%--
  Created by IntelliJ IDEA.
  User: Stapxs
  Date: 2021/9/1
  Time: 下午 4:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>林槐语录 - 林槐服务接口</title>
    <jsp:include page="${pageContext.request.contextPath}/module/head.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tool/SS-Ana.css">

    <meta property="og:title" content="林槐语录">
    <meta property="og:description" content="<%=request.getAttribute("ana")%>">
    <meta property="og:url" content="https://<%=appInfo.domain%>/SS-Ana/<%=request.getAttribute("id")%>">
</head>

<body style="background: var(--color-bg);color: var(--color-font)">
<jsp:include page="${pageContext.request.contextPath}/module/navbar.jsp"/>
<div style="display: flex;flex-direction: column;height: calc(100vh - 76px);">
    <div class="container-lg" style="flex: 1;">
        <div class="main-card">
            <div class="control-space">
                <div style="display: flex;">
                    <div class="ss-card con-title">
                        <div></div>
                        <span>林槐语录 -&nbsp;</span><span id="time"></span>
                    </div>
                    <div class="ss-card like">
                        <i class="fa fa-heart" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="ss-card flash">
                    <i class="fa fa-refresh" aria-hidden="true"></i>
                </div>
            </div>
            <div class="ss-card" style="margin-top: 20px;overflow: hidden;">
                <div style="display: flex;flex-wrap: wrap;">
                    <div class="show-card">
                        <span id="use-icon">“</span>
                        <div>
                            <span id="ana">没有这条语录哦</span>
                        </div>
                    </div>
                    <div class="bl-pad">
                        <svg style="opacity: 1;" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="info" class="svg-inline--fa fa-info fa-w-6" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 192 512">
                            <path fill="currentColor" d="M -160 44 c 30 0 58 -18 88 -18 s 58 18 88 18 s 58 -18 88 -18 s 58 18 88 18 v 44 h -352 Z"></path>
                        </svg>
                        <svg style="margin-left: calc(-70% - 540px);opacity: 1;" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="info" class="svg-inline--fa fa-info fa-w-6" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 192 512">
                            <path fill="currentColor" d="M -160 44 c 30 0 58 -18 88 -18 s 58 18 88 18 s 58 -18 88 -18 s 58 18 88 18 v 44 h -352 Z"></path>
                        </svg>
                        <svg style="margin-left: calc(-60% - 260px);" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="info" class="svg-inline--fa fa-info fa-w-6" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 192 512">
                            <path fill="currentColor" d="M -160 44 c 30 0 58 -18 88 -18 s 58 18 88 18 s 58 -18 88 -18 s 58 18 88 18 v 44 h -352 Z"></path>
                        </svg>
                        <svg style="margin-left: calc(-40% - 80px);" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="info" class="svg-inline--fa fa-info fa-w-6" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 192 512">
                            <path fill="currentColor" d="M -160 44 c 30 0 58 -18 88 -18 s 58 18 88 18 s 58 -18 88 -18 s 58 18 88 18 v 44 h -352 Z"></path>
                        </svg>
                        <svg style="margin-left: calc(-40% + 40px);opacity: 0.7;" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="info" class="svg-inline--fa fa-info fa-w-6" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 192 512">
                            <path fill="currentColor" d="M -160 44 c 30 0 58 -18 88 -18 s 58 18 88 18 s 58 -18 88 -18 s 58 18 88 18 v 44 h -352 Z"></path>
                        </svg>
                        <svg style="margin-left: 0700px; margin-top: -250px;width: 3px;transform: rotate(35deg);" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 13 270"><rect fill="currentColor" x="0.5" y="0.5" width="12" height="269"></rect></svg>
                        <svg style="margin-left: -100px; margin-top: -250px;width: 3px;transform: rotate(35deg);" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 13 270"><rect fill="currentColor" x="0.5" y="0.5" width="12" height="269"></rect></svg>
                        <svg style="margin-left: -300px; margin-top: 0000px;width: 3px;transform: rotate(35deg);" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 13 270"><rect fill="currentColor" x="0.5" y="0.5" width="12" height="269"></rect></svg>
                        <svg style="margin-left: 0500px; margin-top: -200px;width: 3px;transform: rotate(35deg);" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 13 270"><rect fill="currentColor" x="0.5" y="0.5" width="12" height="269"></rect></svg>
                        <svg style="margin-left: 0650px; margin-top: 0050px;width: 3px;transform: rotate(35deg);" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 13 270"><rect fill="currentColor" x="0.5" y="0.5" width="12" height="269"></rect></svg>
                        <svg style="margin-left: 0200px; margin-top: -100px;width: 3px;transform: rotate(35deg);" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 13 270"><rect fill="currentColor" x="0.5" y="0.5" width="12" height="269"></rect></svg>
                        <svg style="margin-left: 0200px; margin-top: -330px;width: 3px;transform: rotate(35deg);" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 13 270"><rect fill="currentColor" x="0.5" y="0.5" width="12" height="269"></rect></svg>
                        <svg style="margin-left: 0400px; margin-top: -260px;width: 3px;transform: rotate(35deg);" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 13 270"><rect fill="currentColor" x="0.5" y="0.5" width="12" height="269"></rect></svg>
                        <svg style="margin-left: -100px; margin-top: -060px;width: 3px;transform: rotate(35deg);" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 13 270"><rect fill="currentColor" x="0.5" y="0.5" width="12" height="269"></rect></svg>
                        <svg style="margin-left: 0200px; margin-top: 0000px;width: 3px;transform: rotate(35deg);" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 13 270"><rect fill="currentColor" x="0.5" y="0.5" width="12" height="269"></rect></svg>
                    </div>
                </div>
            </div>
        </div>
    </div>
<jsp:include page="${pageContext.request.contextPath}/module/footer.jsp"/>
</div>
</body>
<jsp:include page="${pageContext.request.contextPath}/module/js.jsp"/>
<script>
    <%
        String id = (String) request.getAttribute("id");
        if(id == null) {
            out.print("const ana_id = -1;");
        } else if(!Number.isInteger(id)) {
            out.print("const ana_id = -2;");
        } else {
            out.print("const ana_id = " + id + ";");
        }
    %>
</script>
<script src="${pageContext.request.contextPath}/js/tool/SS-Ana.js"></script>
</html>
