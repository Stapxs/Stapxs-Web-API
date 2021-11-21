// 刷新 GitHub 贡献者列表
// <div style="background-image: url('/img/photo_2019-07-17_10-05-12.jpg')"></div>
fetch('https://api.github.com/repos/stapxs/stapxs-web-api/contributors')
    .then(response => response.json())
    .then(data => {
        for(let i=0; i<data.length; i++) {
            const img = document.createElement("div")
            img.style.backgroundImage = "url('" + data[i]["avatar_url"] + "')"
            img.title = data[i]["login"]
            img.onclick = function () {
                window.open(data[i]["html_url"]);
            }
            document.getElementById("github-helpper").append(img)
        }
    })
    .catch(console.error)

// 刷新更新记录
updateHistory()

/*
<div>
     <div id="history-dot"><div></div></div>
     <header>暗黑模式 - 2021-09-29T01:06:39Z</header>
     <a>Add | 亮色主题配色 /css/color-light.css</a><br>
     <a>Bug | 修正 /SS-Ana/{id} 调用方式显示不正确的问题</a><br>
     <a>Cha | 暗色主题配色 /css/color.css -> /css/color-dark.css</a>
</div>
 */
function updateHistory() {
    fetch('https://api.github.com/repos/stapxs/stapxs-web-api/commits')
    .then(response => response.json())
    .then(data => {
        document.getElementById("history-wait").style.display = "none"
        document.getElementById("history-body").style.textAlign = "left"

        for (let i = 0; i < data.length; i++) {
            const msg = data[i]["commit"]["message"].split("\n")
            if (msg.length >= 1) {
                const inn = String.raw`<div class="history-dot"><div></div></div><header>{1}</header>`
                const his = String.raw`<a>{1}</a><br>`
                let str = '<div>' + inn.replace("{1}", msg[0] + " - " + data[i]["commit"]["author"]["date"])
                for (let i = 1; i < msg.length; i++) {
                    str += his.replace("{1}", msg[i])
                }
                document.getElementById("history-body").insertAdjacentHTML("beforeend", str + "</div>")
            }
        }
    })
    .catch(function (e) {
        document.getElementById("history-load").style.animation = "none"
        document.getElementById("history-err").innerText = "加载失败：" + e
    })
}

// 事件
$(document).ready(function(){
    $("#go-github").click( function () {
        window.open("https://github.com/Stapxs/Stapxs-Web-API");
    })
});