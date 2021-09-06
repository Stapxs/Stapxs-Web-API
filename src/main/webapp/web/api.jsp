<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String stat = (String) request.getAttribute("stat");
    String str = (String) request.getAttribute("str");
    switch (stat) {
        case "200": {
            out.print(str);
            break;
        }
        case "404": {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            out.print(str);
            break;
        }
        case "302": {
            response.sendRedirect(str);
            break;
        }
    }
%>