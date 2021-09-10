<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String stat = (String) request.getAttribute("stat");
    String str = (String) request.getAttribute("str");
    boolean show = request.getAttribute("show") != null && (boolean) request.getAttribute("show");
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
        case "400": {
            if(show) {
                request.setAttribute("inn", true);
                request.setAttribute("str", str);
                request.setAttribute("code", "400");
                request.getRequestDispatcher("/Error").forward(request, response);
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print(str);
            }
            break;
        }
    }
%>