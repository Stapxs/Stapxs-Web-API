<%@ page import="cn.stapxs.api.util.Number" %><%--
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
</head>

<body style="background: var(--color-bg);color: var(--color-font)">
<jsp:include page="${pageContext.request.contextPath}/module/navbar.jsp"/>
<div style="display: flex;flex-direction: column;height: calc(100vh - 76px);">
    <div class="container-lg" style="flex: 1;">
        <!-- Code Here -->

    </div>
    <jsp:include page="${pageContext.request.contextPath}/module/footer.jsp"/>
</div>
</body>
<jsp:include page="${pageContext.request.contextPath}/module/js.jsp"/>
<script src="${pageContext.request.contextPath}/js/tool/Steve-Doing.js"></script>
</html>
