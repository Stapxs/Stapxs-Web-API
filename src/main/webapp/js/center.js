// 验证登录
const cookies = document.cookie.split('; ')
let idIn = -1
let tok = ''
cookies.forEach(function (cookie) {
    if(cookie.indexOf("id") >= 0) {
        idIn = cookie.split('=')[1]
    }
    if(cookie.indexOf("token") >= 0) {
        tok = cookie.split('=')[1]
    }
})
if(idIn !== -1 && tok !== '') {
    // 验证登录
    try {
        const httpRequest = new XMLHttpRequest();
        httpRequest.open("POST", "/acc/verifyLogin", true);
        httpRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        httpRequest.send("id=" + idIn + "&token=" + tok);

        httpRequest.onreadystatechange = function () {
            if (httpRequest.status !== 200) {
                window.location.href = "/Account"
            }
        };
    } catch (e) {
        console.error(e)
        window.location.href = "/Account"
    }
} else {
    window.location.href = "/Account"
}

// 设置顶栏信息
try {
    const httpRequest = new XMLHttpRequest();
    httpRequest.open("POST", "/acc/info/getInfo", true);
    httpRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    httpRequest.send("id=" + idIn + "&token=" + tok);

    httpRequest.onreadystatechange = function () {
        if (httpRequest.readyState === 4 && httpRequest.status === 200) {
            const json = JSON.parse(httpRequest.responseText)
            document.getElementById("avatar-img").src = "/acc/info/getAvatar/" + json.value.user_id
            document.getElementById("avatar-center-img").src = "/acc/info/getAvatar/" + json.value.user_id
            document.getElementById("id").innerText = "#" + json.value.user_id
            document.getElementById("name").innerText = json.value.user_name
            document.getElementById("nick").innerText = json.value.user_nick
            if(json.value.time_login !== undefined) {
                const time = Date.parse(json.value.time_login)
                document.getElementById('login_time').innerText = new Date(time).toLocaleString()
                document.getElementById('login_ip').innerText = json.value.ip_login
                document.getElementById('login_info_pan').style.display = 'block'
                document.getElementById('exit_button_pan').style.display = 'none'
            }
        }
    };
} catch (e) {
    showError('获取用户信息错误：' + e.message)
}

// 加载 key 列表
try {
    const httpRequest = new XMLHttpRequest();
    httpRequest.open("POST", "/acc/key/get", true);
    httpRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    httpRequest.send("id=" + idIn + "&token=" + tok);

    httpRequest.onreadystatechange = function () {
        if (httpRequest.readyState === 4 && httpRequest.status === 200) {
            const list = JSON.parse(httpRequest.responseText)
            if(list.length >= 5) {
                document.getElementById('create-key').disabled = true
            }
            for(let i=0; i<list.length; i++) {
                // 创建 key-body
                const html = String.raw`<div></div>
                    <span>{1}</span>
                    <button onclick="deleteKey(this);" class="ss-button" style="background: #e81123;color: #fff;" title="删除"><i class="fa fa-trash" aria-hidden="true"></i></button>
                    <button onclick="copyButton();" class="ss-button key-copy" title="复制"><i class="fa fa-clone" aria-hidden="true"></i></button>`.replace('{1}', list[i].key_value)
                let div = document.createElement("div")
                div.classList.add("key-control")
                div.classList.add("key-body")
                div.style.flexDirection = 'initial'
                div.dataset.id = list[i].key_id
                div.innerHTML = html
                // 添加 key-body
                document.getElementById('key-body').append(div)
                // 隐藏加载条
                document.getElementById('key-loading').style.display = 'none'
            }
        }
    };
} catch (e) {
    showError('获取用户 Key 错误：' + e.message)
    document.getElementById('key-loading').style.display = 'none'
}

function copyButton() {
    var clipboard = new ClipboardJS('.key-copy', {
        target: function(trigger) {
            return trigger.nextElementSibling.nextElementSibling
        }
    })
    clipboard.on('success', function (e) {
        console.log("复制成功！")
    })
    clipboard.on('error', function(e) {
        showError('复制失败！')
    })
}

function createKey() {
    try {
        const httpRequest = new XMLHttpRequest();
        httpRequest.open("POST", "/acc/key/new", true);
        httpRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        httpRequest.send("id=" + idIn + "&token=" + tok);

        httpRequest.onreadystatechange = function () {
            if(httpRequest.responseText.indexOf('status') > 0) {
                const info = JSON.parse(httpRequest.responseText)
                if(info.status === 200) {
                    location.reload();
                } else {
                    showError('创建用户 Key 错误：' + info.message)
                }
            }
        };
    } catch (e) {
        showError('创建用户 Key 错误：' + e.message)
    }
}

function deleteKey(sender) {
    const key_id = sender.parentNode.dataset.id
    try {
        const httpRequest = new XMLHttpRequest();
        httpRequest.open("POST", "/acc/key/delete", true);
        httpRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        httpRequest.send("id=" + idIn + "&token=" + tok + "&num=" + key_id);
    } catch (e) {
        showError('删除用户 Key 错误：' + e.message)
    }
    location.reload();
}

function showError(msg) {
    document.getElementById('center_err_msg').innerText = msg
    document.getElementById('center_err_pan').style.display = 'flex'
    document.getElementById('center_err_pan').style.marginBottom = '20px'
    document.body.scrollTop = document.documentElement.scrollTop = 0
}