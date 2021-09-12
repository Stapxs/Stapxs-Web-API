const colorList =
    [
        ["§0", "000000", "000000"],
        ["§1", "0000AA", "00002A"],
        ["§2", "00AA00", "002A00"],
        ["§3", "00AAAA", "002A2A"],
        ["§4", "AA0000", "2A0000"],
        ["§5", "AA00AA", "2A002A"],
        ["§6", "FFAA00", "2A2A00"],
        ["§7", "AAAAAA", "2A2A2A"],
        ["§8", "555555", "151515"],
        ["§9", "5555FF", "15153F"],
        ["§a", "55FF55", "153F15"],
        ["§b", "55FFFF", "153F3F"],
        ["§c", "FF5555", "3F1515"],
        ["§d", "FF55FF", "3F153F"],
        ["§e", "FFFF55", "3F3F15"],
        ["§f", "FFFFFF", "3F3F3F"],
        ["§g", "DDD605", "373501"]
    ];
const codeList =
    [
        ["§k", ""],
        ["§l", "<a style='font-weight: bold;'>"],
        ["§m", "<a style='text-decoration:line-through;'>"],
        ["§n", "<a style='text-decoration: underline;'>"],
        ["§o", "<a style='font-style:italic;'>"],
        ["§r", "</a>"]
    ];

if(json !== "null") {
    const obj = JSON.parse(json)
    // 解析 title
    if(obj["description"]["translate"] !== undefined) {
        // 彩色标题形式
        // 处理颜色
        let title = obj["description"]["translate"];
        colorList.forEach(function (item, index) {
            title = title.replaceAll(item[0], "</a><a style='color:#" + item[1] + ";'>")
        })
        codeList.forEach(function (item, index) {
            title = title.replaceAll(item[0], item[1])
        })
        document.getElementById("title").innerHTML = "<a>" + title + "</a>"
    } else if(obj["description"]["extra"] !== undefined) {
        // JSON 数组颜色
        let title = "";
        for(const i in obj.description.extra) {
            let style = "";
            if(obj["description"]["extra"][i]["color"] !== undefined) {
                style += "color: " + obj["description"]["extra"][i]["color"] + ";"
            }
            if(obj["description"]["extra"][i]["bold"] === true) {
                style += "font-weight: bold;";
            }
            if(obj["description"]["extra"][i]["italic"] === true) {
                style += "font-style:italic;"
            }
            if(obj["description"]["extra"][i]["underlined"] === true) {
                style += "text-decoration: underline;"
            } else if(obj["description"]["extra"][i]["strikethrough"] === true) {
                style += "text-decoration:line-through;"
            }
            title += "</a><a style='" + style + "'>" + obj["description"]["extra"][i]["text"]
        }
        document.getElementById("title").innerHTML = "<a>" + title + "</a>"
    } else {
        document.getElementById("title").innerHTML = obj["description"]
    }
    // 图标
    if(obj["favicon"] === undefined) {
        document.getElementById("img").style.display = "none"
        document.getElementById("img-s").style.display = "none"
    } else {
        document.getElementById("img").src = obj["favicon"]
        document.getElementById("img-s").src = obj["favicon"]
    }
    // 版本
    document.getElementById("version").innerText = obj["version"]["name"]
    document.getElementById("version-t").innerText = "版本（" + obj["version"]["protocol"] + "）"
    // 玩家
    document.getElementById("players-t").innerText = "玩家（" + obj["players"]["online"] + " / " + obj["players"]["max"] + "）"
    if(obj["players"]["online"] > 0) {
        let players = ""
        for(const  i in obj.players.sample) {
            players += "<a id='" + obj["players"]["sample"][i]["id"] + "'>" + obj["players"]["sample"][i]["name"] + "</a><br>"
        }
        document.getElementById("players").innerHTML = players
    }
    // MOD
    if(obj["modinfo"] !== undefined) {
        document.getElementById("mods-t").innerText = "MOD 列表（" + obj["modinfo"]["type"] + "）"
        let mods = ""
        for(const  i in obj.modinfo.modList) {
            mods += "<a>" + obj["modinfo"]["modList"][i]["modid"] + ":" + obj["modinfo"]["modList"][i]["version"] + "<br>"
        }
        document.getElementById("mods").innerHTML = mods
    }
    //Ping
    document.getElementById("ping").innerText = obj["ping"] + " ms"
}

String.prototype.replaceAll = function(s1,s2){
    return this.replace(new RegExp(s1,"gm"),s2);
}