<%@ page import="cn.stapxs.api.appInfo" %>

<script>
    window.app_version = '<%=appInfo.version%>-<%=appInfo.build%>'
</script>

<script src="${pageContext.request.contextPath}/js/jquery-1.12.4.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/api.js?version=<%=appInfo.version%>-<%=appInfo.build%>"></script>
<script src="${pageContext.request.contextPath}/js/main.js?version=<%=appInfo.version%>-<%=appInfo.build%>"></script>
<script src="${pageContext.request.contextPath}/js/spacingjs.js"></script>
<script src="${pageContext.request.contextPath}/js/prism.js"></script>
<%
    // TODO 在此处处理是否启用自动暗黑模式
%>
<script src="${pageContext.request.contextPath}/js/auto-theme.js?version=<%=appInfo.version%>-<%=appInfo.build%>"></script>