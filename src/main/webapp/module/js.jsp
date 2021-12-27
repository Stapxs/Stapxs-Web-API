<%@ page import="cn.stapxs.api.appInfo" %>

<script>
    window.app_version = '<%=appInfo.version%>-<%=appInfo.build%>'
</script>

<script src="${pageContext.request.contextPath}/js/util/jquery-1.12.4.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js?version=<%=appInfo.version%>-<%=appInfo.build%>"></script>
<script src="${pageContext.request.contextPath}/js/api/api.js?version=<%=appInfo.version%>-<%=appInfo.build%>"></script>
<script src="${pageContext.request.contextPath}/js/util/spacingjs.js"></script>
<script src="${pageContext.request.contextPath}/js/util/prism.js"></script>
<script src="${pageContext.request.contextPath}/js/auto-theme.js?version=<%=appInfo.version%>-<%=appInfo.build%>"></script>