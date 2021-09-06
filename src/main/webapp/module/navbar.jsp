<%--
  Created by IntelliJ IDEA.
  User: Stapxs
  Date: 2021/9/1
  Time: 下午 6:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String servletPath=request.getServletPath();
    String title = (String) request.getAttribute("title");
%>
<nav class="navbar navbar-expand-lg navbar-dark" style="background: var(--color-card);margin-bottom: 20px">
    <div class="container-lg" style="padding-left: 30px;">
        <a class="navbar-brand" href="/">
            <%
                if(title != null) {
                    out.print(title);
                } else {
                    out.print("林槐服务接口");
                }
            %>
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
            <div class="navbar-nav">
                <a class="nav-item nav-link <%if(servletPath.equals("/web/index.jsp"))out.print("active");%>" href="${pageContext.request.contextPath}/">主页</a>
                <a class="nav-item nav-link <%if(servletPath.equals("/web/list.jsp"))out.print("active");%>" href="${pageContext.request.contextPath}/List">列表</a>
                <a class="nav-item nav-link <%if(servletPath.equals("/web/doc.jsp"))out.print("active");%>" href="${pageContext.request.contextPath}/Doc">文档</a>
                <a class="nav-item nav-link" href="#">关于</a>
            </div>
        </div>
    </div>
</nav>