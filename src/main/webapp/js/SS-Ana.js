let link = "/SS-Ana/Get?type=json";
if(ana_id > -1) {
    link = "/SS-Ana/Get?type=json&id=" + ana_id;
}
fetch(link)
    .then(response => response.json())
    .then(data => {
        const ana = document.getElementById('ana')
        ana.innerText = data.ana
        const time = document.getElementById("time")
        time.innerText = data.time
    })
    .catch(console.error)

// 事件
$(document).ready(function(){
    // 列表卡片点击事件
    $("div.flash").click(function () {
        if($("div.flash i").css("transform").toString() === "matrix(1, 0, 0, 1, 0, 0)") {
            $("div.flash i").css("transform", "rotate(360deg)")
        } else {
            $("div.flash i").css("transform", "rotate(0deg)")
        }
        $("#ana").css("opacity", "0");
        sleep(500).then(() => {
            fetch("/SS-Ana/Get?type=json")
                .then(response => response.json())
                .then(data => {
                    const ana = document.getElementById('ana')
                    ana.innerText = data.ana
                    const time = document.getElementById("time")
                    time.innerText = data.time
                })
                .catch(console.error)
            $("#ana").css("opacity", "1");
        })
    });
});

function sleep (time) {
    return new Promise((resolve) => setTimeout(resolve, time));
}