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
<nav class="navbar navbar-expand-lg navbar-dark" style="background: var(--color-card);margin-bottom: 20px;">
    <div class="container-lg" style="padding-left: 30px;">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <%
                if(title != null) {
                    out.print(title);
                } else {
                    out.print("林槐服务接口");
                }
            %>
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
            <svg style="background-image: none;color: var(--color-font);" class="navbar-toggler-icon" xmlns='http://www.w3.org/2000/svg' width='30' height='30' viewBox='0 0 30 30'><path stroke='currentColor' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'></path></svg>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
            <div class="navbar-nav mr-auto">
                <a class="nav-item nav-link <%if(servletPath.equals("/web/index.jsp"))out.print("active");%>" href="${pageContext.request.contextPath}/">主页</a>
                <a class="nav-item nav-link <%if(servletPath.equals("/web/list.jsp"))out.print("active");%>" href="${pageContext.request.contextPath}/List">列表</a>
                <a class="nav-item nav-link <%if(servletPath.equals("/web/doc.jsp"))out.print("active");%>" href="${pageContext.request.contextPath}/Doc">文档</a>
                <a class="nav-item nav-link <%if(servletPath.equals("/web/about.jsp"))out.print("active");%>" href="${pageContext.request.contextPath}/About">关于</a>
            </div>
            <form class="form-inline my-2 my-lg-0">
                <input class="form-control mr-sm-2 bar-search" type="search" placeholder="搜索" aria-label="搜索">
                <div id="user-avatar" class="avatar" title="登录" onclick="Login()">
                    <img id="avatar-img" src="${pageContext.request.contextPath}/img/user-solid-dark.svg" alt="头像">
                    <span id="user-name" class="user-name">登录</span>
                </div>
            </form>
        </div>
    </div>
</nav>