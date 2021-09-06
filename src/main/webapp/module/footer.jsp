<%@ page import="cn.stapxs.api.appInfo" %><%--
  Created by IntelliJ IDEA.
  User: Stapxs
  Date: 2021/9/2
  Time: 下午 4:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="container-lg">
    <div class="ss-card">
        <header>林槐服务接口
            <span>
                <%
                    out.print(appInfo.type + " - " + appInfo.version);
                %>
            </span>
        </header>
        <span>Copyright © 2020 - 2021 Stapx Steve [ 林槐 ]</span><br>
        <div style="float: right;margin-top: -44px;">
            <svg style="width: 50px;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 274 259"><g id="圖層_2" data-name="圖層 2"><g id="本体"><rect class="cls-1" x="19" y="167" width="28" height="28"/><rect class="cls-1" x="62" y="181" width="14" height="14"/><rect class="cls-1" x="89" y="163" width="14" height="14"/><rect class="cls-1" x="62" y="63" width="14" height="14"/><rect class="cls-1" x="82" y="85" width="14" height="14"/><rect class="cls-1" x="114" y="66" width="28" height="28"/><polygon class="cls-1" points="112.54 153.5 33.5 153.5 33.5 106.5 155 106.5 155.5 106.5 159.37 106.5 159.46 207.5 159.5 254.36 159.5 254.46 144.5 254.47 144.5 254.37 144.5 238.5 116.5 238.5 116.5 254.4 116.5 254.5 112.63 254.5 112.63 254.4 3.54 254.5 3.5 207.64 112.59 207.54 112.54 153.5"/><polygon class="cls-1" points="183.51 114.5 198.5 114.5 198.5 130.5 198.5 131.49 269.5 131.42 269.48 103.5 219.5 103.55 219.5 85.47 269.5 85.42 269.5 84.5 269.5 36.42 269.5 20.5 269.48 20.5 251.5 20.5 251.5 5.52 251.5 5.5 232.5 5.5 232.5 5.53 183.5 5.58 183.53 36.5 232.5 36.45 232.5 54.53 219.5 54.55 219.5 54.5 182.5 54.5 182.5 114.5 183.51 114.5"/><rect class="cls-1" x="242" y="153" width="28" height="28"/><rect class="cls-1" x="183" y="240" width="14" height="14"/><rect class="cls-1" x="204" y="166" width="26" height="14"/><rect class="cls-1" x="183" y="190" width="14" height="41"/><polygon class="cls-1" points="269.5 189.5 269.5 230.62 245.62 254.5 203.5 254.5 203.5 189.5 269.5 189.5"/><rect class="cls-1" width="8" height="8"/><rect class="cls-1" x="266" y="251" width="8" height="8"/><polygon class="cls-1" points="3.5 33.16 30.77 5.5 50.5 5.5 145.5 5.5 145.5 19.5 159.5 19.5 159.5 52.5 50.5 52.5 50.5 153.5 3.5 153.5 3.5 52.5 3.5 33.16"/></g></g></svg>        </div>
    </div>
    <div>
        <span>
            <a rel="nofollow" href="http://beian.miit.gov.cn" target="_blank">苏ICP备 20015498号-2 | </a><a href="https://icp.gov.moe" target="_blank">萌ICP备 </a><a href="https://icp.gov.moe/?keyword=20202320" target="_blank"> 20202320号</a>
        </span>
    </div>
</footer>