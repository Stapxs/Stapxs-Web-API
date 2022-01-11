<%--
  Created by IntelliJ IDEA.
  User: Stapxs
  Date: 2021/9/12
  Time: 下午 2:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="cn.stapxs.api.appInfo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>关于 - 林槐服务接口</title>
    <jsp:include page="${pageContext.request.contextPath}/module/head.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/api/about.css">
</head>

<body style="background: var(--color-bg);">
<jsp:include page="${pageContext.request.contextPath}/module/navbar.jsp"/>
<div style="display: flex;flex-direction: column;height: calc(100vh - 76px);">
    <div class="container-lg" style="flex: 1;">
        <%-- Code Here …… --%>
        <div class="ss-card wel-card">
            <div>
                <div class="wel-icon">
                    <i class="fa fa-plug" aria-hidden="true"></i>
                </div>
                <span id="wel-title">Stapxs Web API</span><br>
                <span id="version">
                    <%
                        out.print(appInfo.type + " - " + appInfo.version);
                    %>
                </span><br>
                <button id="go-github" class="ss-button" style="margin-top: 20%;width: 80%;">访问项目</button>
            </div>
            <div id="wel-bl-pad" style="position: relative;pointer-events:none;">
                <svg style="opacity: 1;" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="info" class="svg-inline--fa fa-info fa-w-6" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 192 512">
                    <path fill="currentColor" d="M -160 44 c 30 0 58 -18 88 -18 s 58 18 88 18 s 58 -18 88 -18 s 58 18 88 18 v 44 h -352 Z"></path>
                </svg>
                <svg style="margin-left: calc(-70% - 240px);opacity: 1;" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="info" class="svg-inline--fa fa-info fa-w-6" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 192 512">
                    <path fill="currentColor" d="M -160 44 c 30 0 58 -18 88 -18 s 58 18 88 18 s 58 -18 88 -18 s 58 18 88 18 v 44 h -352 Z"></path>
                </svg>
                <svg style="margin-left: calc(-60% - 160px);" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="info" class="svg-inline--fa fa-info fa-w-6" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 192 512">
                    <path fill="currentColor" d="M -160 44 c 30 0 58 -18 88 -18 s 58 18 88 18 s 58 -18 88 -18 s 58 18 88 18 v 44 h -352 Z"></path>
                </svg>
                <svg style="margin-left: calc(-40% - 80px);" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="info" class="svg-inline--fa fa-info fa-w-6" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 192 512">
                    <path fill="currentColor" d="M -160 44 c 30 0 58 -18 88 -18 s 58 18 88 18 s 58 -18 88 -18 s 58 18 88 18 v 44 h -352 Z"></path>
                </svg>
                <svg style="margin-left: -30%;" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="info" class="svg-inline--fa fa-info fa-w-6" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 192 512">
                    <path fill="currentColor" d="M -160 44 c 30 0 58 -18 88 -18 s 58 18 88 18 s 58 -18 88 -18 s 58 18 88 18 v 44 h -352 Z"></path>
                </svg>
            </div>
        </div>
        <div class="wel-card-right">
            <div class="ss-card more-card" style="margin-top: 0;flex: 1;">
                <header><div></div>关于 Stapxs Web API</header>
                <div class="ss-card about-top">
                    『这是林槐语录API独有的一条哦！』 —— 要好好对待自己QWQ
                </div>
                <div class="about-text">
                    <i>
                        上面是林槐语录 API 里的一句，它曾经被安排在了第 32 位，一个我一直很喜欢的数字，而 SS Web API 也诞生于林槐语录。
                        2020 年 3 月，我把林槐语录全部文本化后放在了 blog 上，之后我想在更多地方显示林槐语录，于是
                        在 2020 年 7 月，我写下了第一个用于获取林槐语录的 PHP API —— 林槐语录 API，那只是个简短的 PHP 单文件。
                    </i>
                    <i>
                        之后，因为更多乱七八糟的功能添加了进来，blog 下的 api 目录逐渐变成了一堆 PHP 文件的合集，杂乱无章的提供着各种功能的接口。
                        在 2020 年大二，我学习了 Spring Boot，于是我规划着想把 API 整合成一个更规范完善的整体，由于学业繁忙，这个想法一直被搁置着。
                        2021 年的假期，我终于想起了 API 重构的计划着手开始重写 —— 这就是你现在看见的 Stapxs Web API！
                    </i>
                    <i>
                        还是那句熟悉的话：
                        它有着并不是特别好看的界面，有着并不是特别规范的代码，有着看起来非常鸡肋的彩蛋。
                        但是这些都不重要，重要的是，它是 SS 第一个用来学习和练习 Spring Boot 的程序。
                    </i>
                    <i style="text-align: right;">
                        林槐出品，必属稽品
                    </i>
                </div>
            </div>
        </div>
        <div class="ss-card" style="margin-top: 20px;">
            <header><div></div>特别感谢</header>
            <div class="thanks">
                <div>
                    <div style="background-image: url('/img/google.ico')"></div>
                    <div>
                        <span>Google</span><br>
                        <a>搜索引擎帮助我寻找到了很多匪夷所思的问题的解决方案</a>
                    </div>
                </div>
                <div>
                    <div style="background-image: url('/img/BLC.jpg')"></div>
                    <div>
                        <span>Bad Laugh Cat</span><br>
                        <a>是朋友哦 —— （大声</a>
                    </div>
                </div>
            </div>
            <div class="thanks">
                <div>
                    <div style="background-image: url('/img/photo_2019-07-17_10-05-12.jpg')"></div>
                    <div>
                        <span>A.C.Sukazyo Eyre</span><br>
                        <a>是朋友哦 —— （大声</a>
                    </div>
                </div>
            </div>
            <div id="github-helpper" class="ss-card github-pop">
                <div title="来自 Github 的维护者们">
                    <svg aria-hidden="true" focusable="false" data-prefix="fab" data-icon="github" class="svg-inline--fa fa-github fa-w-16" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 496 512"><path fill="currentColor" d="M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z"></path></svg>
                </div>
                <svg style="height: 30px;color: var(--color-main);margin-top: 5px;margin-right: 10px;" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="angle-right" class="svg-inline--fa fa-angle-right fa-w-8" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 512"><path fill="currentColor" d="M224.3 273l-136 136c-9.4 9.4-24.6 9.4-33.9 0l-22.6-22.6c-9.4-9.4-9.4-24.6 0-33.9l96.4-96.4-96.4-96.4c-9.4-9.4-9.4-24.6 0-33.9L54.3 103c9.4-9.4 24.6-9.4 33.9 0l136 136c9.5 9.4 9.5 24.6.1 34z"></path></svg>
            </div>
        </div>
        <div id="history" style="display: flex;margin-top: 20px;height: 310px;">
            <div class="ss-card history" style="width: 60%;margin-right: 20px;">
                <header><div></div>更新记录</header>
                <div class="scroll-top" style="display: none;"></div>
                <div id="history-body" onscroll="scrollDiv(this);">
                    <div id="history-wait">
                        <svg id="history-load" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="cog" class="svg-inline--fa fa-cog fa-w-16" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="currentColor" d="M487.4 315.7l-42.6-24.6c4.3-23.2 4.3-47 0-70.2l42.6-24.6c4.9-2.8 7.1-8.6 5.5-14-11.1-35.6-30-67.8-54.7-94.6-3.8-4.1-10-5.1-14.8-2.3L380.8 110c-17.9-15.4-38.5-27.3-60.8-35.1V25.8c0-5.6-3.9-10.5-9.4-11.7-36.7-8.2-74.3-7.8-109.2 0-5.5 1.2-9.4 6.1-9.4 11.7V75c-22.2 7.9-42.8 19.8-60.8 35.1L88.7 85.5c-4.9-2.8-11-1.9-14.8 2.3-24.7 26.7-43.6 58.9-54.7 94.6-1.7 5.4.6 11.2 5.5 14L67.3 221c-4.3 23.2-4.3 47 0 70.2l-42.6 24.6c-4.9 2.8-7.1 8.6-5.5 14 11.1 35.6 30 67.8 54.7 94.6 3.8 4.1 10 5.1 14.8 2.3l42.6-24.6c17.9 15.4 38.5 27.3 60.8 35.1v49.2c0 5.6 3.9 10.5 9.4 11.7 36.7 8.2 74.3 7.8 109.2 0 5.5-1.2 9.4-6.1 9.4-11.7v-49.2c22.2-7.9 42.8-19.8 60.8-35.1l42.6 24.6c4.9 2.8 11 1.9 14.8-2.3 24.7-26.7 43.6-58.9 54.7-94.6 1.5-5.5-.7-11.3-5.6-14.1zM256 336c-44.1 0-80-35.9-80-80s35.9-80 80-80 80 35.9 80 80-35.9 80-80 80z"></path></svg>
                        <br><i id="history-err">少女祈祷中</i>
                    </div>
                </div>
            </div>
            <div class="ss-card bcd-about">
                <div>
                    <div>
                        <div class="bcd-body" style="width: 45%;display: flex;justify-content: flex-end;border-radius: 0 5px 0 0;">
                            <div style="background:var(--color-card-2);border-radius: 16px;width: 25%;margin: 5px 0 5px 5px;"></div>
                            <div style="background: var(--color-card-2);border-radius: 100%;width: 7px;margin: 5px 8px 5px 5px;"></div>
                        </div>
                    </div>
                    <div>
                        <div class="bcd-body" style="width: 20%;margin-right: 25%;"></div>
                        <div class="bcd-body" style="width: 55%;display: flex;justify-content: flex-end;">
                            <div style="background: var(--color-card-2);width: calc(25% + 26px);margin-right: 5px;border-radius: 5px 5px 0 0;display: flex;justify-content: flex-end;">
                                <div style="background:var(--color-main);border-radius: 100%;width: 7px;margin: 10px 5px 0 5px;"></div>
                                <div style="background:var(--color-card-1);border-radius: 16px;width: calc(100% - 25px);margin: 10px 7px 0 0;"></div>
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="bcd-body" style="width: 10%;margin-right: 20%;"></div>
                        <div class="bcd-body" style="width: 40%;display: flex;justify-content: flex-end;">
                            <div style="background: var(--color-card-2);width: calc(35% + 25px);margin-right: 5px;display: flex;justify-content: flex-end;">
                                <div style="background: var(--color-card-1);border-radius: 16px;width: calc(100% - 14px);height: calc(100% - 10px);margin-top: 2.5px;margin-right: 7px;"></div>
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="bcd-body" style="width: 15%;margin-right: 40%;"></div>
                        <div class="bcd-body" style="width: 35%;display: flex;justify-content: flex-end;">
                            <div style="background: var(--color-card-2);width: calc(40% + 25px);margin-right: 5px;border-radius: 0 0 5px 5px;"></div>
                        </div>
                    </div>
                    <div>
                        <div class="bcd-body" style="width: 43%;"></div>
                    </div>
                    <div>
                        <div class="bcd-body" style="width: 13%;margin-right: 20%;"></div>
                        <div class="bcd-body" style="width: 49%;"></div>
                    </div>
                    <div>
                        <div class="bcd-body" style="width: 57%;"></div>
                    </div>
                    <div>
                        <div class="bcd-body" style="width: 17%;margin-right: 26%;"></div>
                        <div class="bcd-body" style="width: 52%;"></div>
                    </div>
                    <div>
                        <div class="bcd-body" style="width: 8%;margin-right: 8%;"></div>
                        <div class="bcd-body" style="width: 60%;">
                            <div style="background: var(--color-card-2);width: calc(100% - 7px);height: calc(100% - 7px);margin-top: 7px;border-radius: 0 7px 0 0;"></div>
                        </div>
                    </div>
                    <div>
                        <div class="bcd-body" style="width: 40%;border-radius: 0 0 7px 0;">
                            <div style="background: var(--color-card-2);width: calc(100% - 7px);height: calc(100% - 7px);margin-right: 7px;border-radius: 0 0 7px 0;"></div>
                        </div>
                    </div>
                </div>
                <span>Border Card UI For Web</span><br>
                <a>Version - 1.7</a>
            </div>
        </div>
        <div class="ss-card" style="margin-top: 20px;margin-bottom: 20px;">
            <button onclick="foldChange(this)" class="btn btn-primary lis-button" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
                <header><div></div>许可版权声明<i style="font-size: 0.5rem;font-style: normal;"> 按首字母排序</i></header>
                <svg style="transform: rotate(-90deg);" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="angle-right" class="svg-inline--fa fa-angle-right fa-w-8" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 512"><path fill="currentColor" d="M224.3 273l-136 136c-9.4 9.4-24.6 9.4-33.9 0l-22.6-22.6c-9.4-9.4-9.4-24.6 0-33.9l96.4-96.4-96.4-96.4c-9.4-9.4-9.4-24.6 0-33.9L54.3 103c9.4-9.4 24.6-9.4 33.9 0l136 136c9.5 9.4 9.5 24.6.1 34z"></path></svg>
            </button>
            <div class="collapse" id="collapseExample" style="padding: 10px;">
                <div class="ss-card lis-info">
                    <i>Font Awesome</i><a>By Fonticons, Inc.</a>
                </div>
                <div class="ss-card lis-info">
                    <i>Bootstrap</i><a>By Bootstrap team</a>
                    <div>MIT License</div>
                    <div style="clear: both;display: block;"></div>
                </div>
                <div class="ss-card lis-info">
                    <i>JQuery & JQuery UI</i><a>By OpenJS Foundation</a>
                    <div>MIT License</div>
                    <div style="clear: both;display: block;"></div>
                </div>
                <div class="ss-card lis-info">
                    <i>Jsencrypt</i><a>By travist</a>
                    <div>MIT License</div>
                    <div style="clear: both;display: block;"></div>
                </div>
                <div class="ss-card lis-info">
                    <i>PrismJS</i><a>By Lea Verou, Golmote, James DiGioia, Michael Schmidt & all these awesome people</a>
                    <div>MIT License</div>
                    <div style="clear: both;display: block;"></div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="${pageContext.request.contextPath}/module/footer.jsp"/>
</div>
</body>
<jsp:include page="${pageContext.request.contextPath}/module/js.jsp"/>
<script src="${pageContext.request.contextPath}/js/api/about.js"></script>
</html>
