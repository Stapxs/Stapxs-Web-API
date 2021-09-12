// 更新语录
fetch('/SS-Ana/Get?type=json')
    .then(response => response.json())
    .then(data => {
        const ana = document.getElementById('ana')
        ana.dataset.id = data.id
        ana.innerText = data.ana
    })
    .catch(console.error)

// 事件
$(document).ready(function(){
    // 语录点击事件
    $("div.ana-card").click(function () {
        window.location.href = "/SS-Ana/" + document.getElementById('ana').dataset.id;
    });
    // 主卡片分类
    $("#main-more div").click( function () {
        window.location.href = "/List";
    });
});