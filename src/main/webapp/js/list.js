// 初始化列表内容
fetch('/sys/getInfo')
    .then(response => response.json())
    .then(data => {
        const html = String.raw`
                                <div class="ss-card api-list-card" data-name="{1}">
                                    <div></div>
                                    <div style="margin-left: 20px;">
                                        <div>
                                            <header>{2}</header>
                                        </div>
                                        <div style="margin-left: 20px;">
                                            <span>{3}</span>
                                        </div>
                                    </div>
                                </div>`;
        const name = ["pic", "text", "tool", "other"];
        for(let i=1; i<= name.length; i++) {
            for (let j = 0; j < data[name[i-1]].length; j++) {
                let str = html;
                str = str.replace("{1}", data[name[i-1]][j]["name"]);
                str = str.replace("{2}", data[name[i-1]][j]["name"]);
                str = str.replace("{3}", data[name[i-1]][j]["info"]);
                let strCha = "#tabs-" + i;
                $(strCha).append(str);
            }
        }
    })
    .catch(console.error)

// 事件
$(document).ready(function(){
    // 列表卡片点击事件
    $("div").delegate(".api-list-card", "click", function () {
        window.location.href = "/Doc#" + $(this).data("name");
    });
});