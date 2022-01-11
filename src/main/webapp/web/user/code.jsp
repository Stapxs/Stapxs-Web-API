<%--
  Created by IntelliJ IDEA.
  User: Stapxs
  Date: 2022/01/04
  Time: 11:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="cn.stapxs.api.appInfo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>验证码 - 林槐服务接口</title>
</head>

<body>
    <div style="background: #F8F9FA;">
        <div style="width: 700px;margin: 0 auto;padding-top: 30px;">
            <div style="margin-bottom: 20px;background-color: #FFFFFF;box-shadow:0 0 5px #e3e8ec;color: #50534F;border-radius: 7px;min-height: 40px;min-width: 40px;padding: 20px;">
                <div style="text-align: center;">
                    <img style="width: 40px;margin-bottom: 20px;margin-top: 20px;" src="data:image/svg+xml;base64,PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhciIgZGF0YS1pY29uPSJlbnZlbG9wZSIgY2xhc3M9InN2Zy1pbmxpbmUtLWZhIGZhLWVudmVsb3BlIGZhLXctMTYiIHJvbGU9ImltZyIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB2aWV3Qm94PSIwIDAgNTEyIDUxMiI+PHBhdGggZmlsbD0iY3VycmVudENvbG9yIiBkPSJNNDY0IDY0SDQ4QzIxLjQ5IDY0IDAgODUuNDkgMCAxMTJ2Mjg4YzAgMjYuNTEgMjEuNDkgNDggNDggNDhoNDE2YzI2LjUxIDAgNDgtMjEuNDkgNDgtNDhWMTEyYzAtMjYuNTEtMjEuNDktNDgtNDgtNDh6bTAgNDh2NDAuODA1Yy0yMi40MjIgMTguMjU5LTU4LjE2OCA0Ni42NTEtMTM0LjU4NyAxMDYuNDktMTYuODQxIDEzLjI0Ny01MC4yMDEgNDUuMDcyLTczLjQxMyA0NC43MDEtMjMuMjA4LjM3NS01Ni41NzktMzEuNDU5LTczLjQxMy00NC43MDFDMTA2LjE4IDE5OS40NjUgNzAuNDI1IDE3MS4wNjcgNDggMTUyLjgwNVYxMTJoNDE2ek00OCA0MDBWMjE0LjM5OGMyMi45MTQgMTguMjUxIDU1LjQwOSA0My44NjIgMTA0LjkzOCA4Mi42NDYgMjEuODU3IDE3LjIwNSA2MC4xMzQgNTUuMTg2IDEwMy4wNjIgNTQuOTU1IDQyLjcxNy4yMzEgODAuNTA5LTM3LjE5OSAxMDMuMDUzLTU0Ljk0NyA0OS41MjgtMzguNzgzIDgyLjAzMi02NC40MDEgMTA0Ljk0Ny04Mi42NTNWNDAwSDQ4eiI+PC9wYXRoPjwvc3ZnPg=="/>
                    <br><span style="color: #99B3DB;font-size: 1.3rem;">林槐服务接口</span>
                    <br><span>邮箱验证</span>
                    <div style="margin-bottom: 20px;text-align: left;background: #F1F3F5;padding: 20px;margin-top: 20px;box-shadow:0 0 5px #e3e8ec;color: #50534F;border-radius: 7px;min-height: 40px;min-width: 40px;padding: 20px;">
                        <span style="font-size: 0.8rem;">
                            看起来您正在进行林槐服务接口的邮箱验证，请将下面的验证码输入到个人中心界面的输入框中，此验证码将在五分钟后失效。<br>如果您不知道这是什么，请不要在意，忽略此邮件即可。
                        </span>
                    </div>
                    <%
                        String code = request.getParameter("code");
                        String[] list = code.split("");
                        if(code.length() != 4) {
                            throw new RuntimeException("加载错误：代码不正确！");
                        }
                    %>
                    <label align="center" id="ss-code-input">
                        <input type="text" value="<%=code.charAt(0)%>" disabled style="background: #F1F3F5;outline: 0;caret-color: transparent;border-radius: 7px;text-align: center;font-size: 1.5rem;margin: 0 10px;height: 60px;width: 60px;border: 0;">
                        <input type="text" value="<%=code.charAt(1)%>" disabled style="background: #F1F3F5;outline: 0;caret-color: transparent;border-radius: 7px;text-align: center;font-size: 1.5rem;margin: 0 10px;height: 60px;width: 60px;border: 0;">
                        <input type="text" value="<%=code.charAt(2)%>" disabled style="background: #F1F3F5;outline: 0;caret-color: transparent;border-radius: 7px;text-align: center;font-size: 1.5rem;margin: 0 10px;height: 60px;width: 60px;border: 0;">
                        <input type="text" value="<%=code.charAt(3)%>" disabled style="background: #F1F3F5;outline: 0;caret-color: transparent;border-radius: 7px;text-align: center;font-size: 1.5rem;margin: 0 10px;height: 60px;width: 60px;border: 0;">
                    </label>
                </div>
            </div>
        </div>
        <footer style="width: 700px;margin: 0 auto;padding-bottom: 20px;">
            <div style="color: #50534F;margin-bottom: 20px;background-color: #FFFFFF;box-shadow:0 0 5px #e3e8ec;color: #50534F;border-radius: 7px;min-height: 40px;min-width: 40px;padding: 20px;">
                <header style="color: #99B3DB;letter-spacing: 0.1rem;padding-bottom: 10px;font-size: 1.02rem;font-weight: 300;text-indent: 0;">
                    林槐服务接口
                    <span style="color: #7d817c;font-size: 0.7rem;margin-left: 10px;">
                    <%
                        out.print(appInfo.type + " - " + appInfo.version);
                    %>
                </span>
                </header>
                <span style="margin-left: 20px;font-size: 0.7rem;">Copyright © 2020 - 2021 Stapx Steve [ 林槐 ]</span><br>
                <div style="float: right;margin-top: -44px;">
                    <img style="width: 50px;opacity: 0.1;" src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNzQgMjU5Ij48ZyBpZD0i5ZyW5bGkXzIiIGRhdGEtbmFtZT0i5ZyW5bGkIDIiPjxnIGlkPSLmnKzkvZMiPjxyZWN0IGNsYXNzPSJjbHMtMSIgeD0iMTkiIHk9IjE2NyIgd2lkdGg9IjI4IiBoZWlnaHQ9IjI4Ii8+PHJlY3QgY2xhc3M9ImNscy0xIiB4PSI2MiIgeT0iMTgxIiB3aWR0aD0iMTQiIGhlaWdodD0iMTQiLz48cmVjdCBjbGFzcz0iY2xzLTEiIHg9Ijg5IiB5PSIxNjMiIHdpZHRoPSIxNCIgaGVpZ2h0PSIxNCIvPjxyZWN0IGNsYXNzPSJjbHMtMSIgeD0iNjIiIHk9IjYzIiB3aWR0aD0iMTQiIGhlaWdodD0iMTQiLz48cmVjdCBjbGFzcz0iY2xzLTEiIHg9IjgyIiB5PSI4NSIgd2lkdGg9IjE0IiBoZWlnaHQ9IjE0Ii8+PHJlY3QgY2xhc3M9ImNscy0xIiB4PSIxMTQiIHk9IjY2IiB3aWR0aD0iMjgiIGhlaWdodD0iMjgiLz48cG9seWdvbiBjbGFzcz0iY2xzLTEiIHBvaW50cz0iMTEyLjU0IDE1My41IDMzLjUgMTUzLjUgMzMuNSAxMDYuNSAxNTUgMTA2LjUgMTU1LjUgMTA2LjUgMTU5LjM3IDEwNi41IDE1OS40NiAyMDcuNSAxNTkuNSAyNTQuMzYgMTU5LjUgMjU0LjQ2IDE0NC41IDI1NC40NyAxNDQuNSAyNTQuMzcgMTQ0LjUgMjM4LjUgMTE2LjUgMjM4LjUgMTE2LjUgMjU0LjQgMTE2LjUgMjU0LjUgMTEyLjYzIDI1NC41IDExMi42MyAyNTQuNCAzLjU0IDI1NC41IDMuNSAyMDcuNjQgMTEyLjU5IDIwNy41NCAxMTIuNTQgMTUzLjUiLz48cG9seWdvbiBjbGFzcz0iY2xzLTEiIHBvaW50cz0iMTgzLjUxIDExNC41IDE5OC41IDExNC41IDE5OC41IDEzMC41IDE5OC41IDEzMS40OSAyNjkuNSAxMzEuNDIgMjY5LjQ4IDEwMy41IDIxOS41IDEwMy41NSAyMTkuNSA4NS40NyAyNjkuNSA4NS40MiAyNjkuNSA4NC41IDI2OS41IDM2LjQyIDI2OS41IDIwLjUgMjY5LjQ4IDIwLjUgMjUxLjUgMjAuNSAyNTEuNSA1LjUyIDI1MS41IDUuNSAyMzIuNSA1LjUgMjMyLjUgNS41MyAxODMuNSA1LjU4IDE4My41MyAzNi41IDIzMi41IDM2LjQ1IDIzMi41IDU0LjUzIDIxOS41IDU0LjU1IDIxOS41IDU0LjUgMTgyLjUgNTQuNSAxODIuNSAxMTQuNSAxODMuNTEgMTE0LjUiLz48cmVjdCBjbGFzcz0iY2xzLTEiIHg9IjI0MiIgeT0iMTUzIiB3aWR0aD0iMjgiIGhlaWdodD0iMjgiLz48cmVjdCBjbGFzcz0iY2xzLTEiIHg9IjE4MyIgeT0iMjQwIiB3aWR0aD0iMTQiIGhlaWdodD0iMTQiLz48cmVjdCBjbGFzcz0iY2xzLTEiIHg9IjIwNCIgeT0iMTY2IiB3aWR0aD0iMjYiIGhlaWdodD0iMTQiLz48cmVjdCBjbGFzcz0iY2xzLTEiIHg9IjE4MyIgeT0iMTkwIiB3aWR0aD0iMTQiIGhlaWdodD0iNDEiLz48cG9seWdvbiBjbGFzcz0iY2xzLTEiIHBvaW50cz0iMjY5LjUgMTg5LjUgMjY5LjUgMjMwLjYyIDI0NS42MiAyNTQuNSAyMDMuNSAyNTQuNSAyMDMuNSAxODkuNSAyNjkuNSAxODkuNSIvPjxyZWN0IGNsYXNzPSJjbHMtMSIgd2lkdGg9IjgiIGhlaWdodD0iOCIvPjxyZWN0IGNsYXNzPSJjbHMtMSIgeD0iMjY2IiB5PSIyNTEiIHdpZHRoPSI4IiBoZWlnaHQ9IjgiLz48cG9seWdvbiBjbGFzcz0iY2xzLTEiIHBvaW50cz0iMy41IDMzLjE2IDMwLjc3IDUuNSA1MC41IDUuNSAxNDUuNSA1LjUgMTQ1LjUgMTkuNSAxNTkuNSAxOS41IDE1OS41IDUyLjUgNTAuNSA1Mi41IDUwLjUgMTUzLjUgMy41IDE1My41IDMuNSA1Mi41IDMuNSAzMy4xNiIvPjwvZz48L2c+PC9zdmc+Cg=="/>
                </div>
            </div>
            <div style="margin-bottom: 10px;text-align: center;margin-top: -10px;font-size: 0.7rem;">
                <span style="color: #7d817c;">
                    此邮件为系统自动生成，请勿回复
                </span><br>
                <a style="color: #7d817c;">https://api.stapxs.cn</a><br>
                <%
                    if(request.getParameter("id") == null) {
                        throw new RuntimeException("加载错误：编号不正确！");
                    }
                %>
                <a style="color: #7d817c;">CV-<%=request.getParameter("id")%></a>
            </div>
        </footer>
    </div>
</body>
</html>