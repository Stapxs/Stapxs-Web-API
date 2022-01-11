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
    let isFinishNotBase = false
    // 验证邮箱激活代码正确性
    const passEmail = function () {
        let isFinishPass =false
        const code = getCodeInput(document.getElementById('mail-check-inputs-body'))
        try {
            const httpRequest = new XMLHttpRequest();
            httpRequest.open("POST", "/acc/passMail", true);
            httpRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            httpRequest.send("id=" + idIn + "&token=" + tok + "&code=" + code);

            httpRequest.onreadystatechange = function () {
                if(httpRequest.responseText.indexOf("status") > 0) {
                    const json = JSON.parse(httpRequest.responseText)
                    if (json.status === 200 && !isFinishPass) {
                        isFinishPass = true
                        // 刷新页面
                        location.reload();
                    } else if(json.status === 403 && !isFinishPass) {
                        isFinishPass = true
                        showError("验证邮箱错误：" + JSON.parse(httpRequest.responseText).message)
                        document.getElementById('mail-button').disabled = false
                        document.getElementById('mail-button').style.display = 'block'
                        document.getElementById('mail-button').innerHTML = '<i class="fa fa-envelope" aria-hidden="true"></i> 重新发送'
                        cleanCodeInput(document.getElementById('mail-check-inputs-body'))
                    }
                }

            };
        } catch (e) {
            console.error(e)
        }
    }
    // 进行严格登录验证（验证账户是否可用（邮箱是否激活））
    try {
        const httpRequest = new XMLHttpRequest();
        httpRequest.open("POST", "/acc/verifyLogin", true);
        httpRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        httpRequest.send("id=" + idIn + "&token=" + tok + "&notBase=true");

        httpRequest.onreadystatechange = function () {
            if (httpRequest.status !== 200 && !isFinishNotBase) {
                isFinishNotBase = true
                // 初始化验证码输入框
                initCodeInput(document.getElementById('mail-check-inputs-body'), false, passEmail)
                // 隐藏用户中心的主题，显示邮箱验证模块
                showError('账户检查错误：请验证邮箱！');
                document.getElementById('main-body').style.display = 'none'
                document.getElementById('mail-check-body').style.display = 'block'
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
                document.getElementById('login_ip').innerText = json.value.ip_login.substring(0, json.value.ip_login.indexOf(':'))
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
            if (list.length <= 0) {
                document.getElementById('key-loading').style.display = 'none'
            }
            if (list.length >= 5) {
                document.getElementById('create-key').disabled = true
            }
            for (let i = 0; i < list.length; i++) {
                // 创建 key-body
                let html = String.raw`<div></div>
                    <span class="key-txt">{1}</span>
                    <span class="key-tip" style="display: {2};">[{3}]</span>
                    <button onclick="deleteKey(this);" class="ss-button" style="background: #e81123;color: #fff;" title="删除"><i class="fa fa-trash" aria-hidden="true"></i></button>
                    <button onclick="copyButton();" class="ss-button key-copy" title="复制"><i class="fa fa-clone" aria-hidden="true"></i></button>
                    <button onclick="changeName(this);" class="ss-button key-copy" title="修改备注"><i class="fa fa-pencil" aria-hidden="true"></i></button>`.replace('{1}', list[i].key_value)
                if(list[i].key_name !== undefined) {
                    html = html.replace('{2}', 'inline-block')
                    html = html.replace('{3}', ' ' + list[i].key_name + ' ')
                } else {
                    html = html.replace('{2}', 'none')
                }
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

// 初始化设置项
if(options !== '') {
    if(options[0] === '1') {
        document.getElementById('opt0').getElementsByTagName('input')[0].checked = true
    }
    if(options[1] === '1') {
        document.getElementById('opt1').getElementsByTagName('input')[0].checked = true
    }
    const colors = document.getElementById("color-list").getElementsByTagName('label')
    for(let i=0; i<colors.length; i++) {
        if(colors[i].dataset.id === options[2]) {
            colors[i].getElementsByTagName('input')[0].checked = true
            break
        }
    }
}

function copyButton() {
    var clipboard = new ClipboardJS('.key-copy', {
        text: function(trigger) {
            return trigger.parentNode.getElementsByClassName('key-txt')[0].innerText
        }
    })
    clipboard.on('error', function(e) {
        showError('复制失败！' + e.trigger)
    })
    clipboard.on('success', function (e) {
        e.trigger.innerHTML = '<i class="fa fa-check" aria-hidden="true"></i>'
        $(e.trigger).popover({
            content: '复制成功',
            placement: 'top',
            template: String.raw`<div class="popover ss-pop" role="tooltip"><div class="arrow"></div><div class="popover-body"></div></div>`
        })
        $(e.trigger).popover('show')
        setTimeout(() => e.trigger.innerHTML = '<i class="fa fa-clone" aria-hidden="true"></i>', 1100)
        setTimeout(() => $(e.trigger).popover('hide'), 1100)
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

function changeName(sender) {
    sender.id = 'changeb' + sender.parentNode.dataset.id
    const inputWay = sender.previousElementSibling.previousElementSibling.previousSibling
    if(inputWay.nodeName === 'INPUT') {
        // 改为笔
        sender.innerHTML = '<i class="fa fa-pencil" aria-hidden="true"></i>'
        // 确认修改
        const reg = /^\S{0,5}$/
        if(inputWay.value !== '') {
            if (reg.test(inputWay.value)) {
                try {
                    const httpRequest = new XMLHttpRequest();
                    httpRequest.open("POST", "/acc/key/name", true);
                    httpRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                    httpRequest.send("id=" + idIn + "&token=" + tok + "&num=" + sender.parentNode.dataset.id + "&name=" + inputWay.value);

                    httpRequest.onreadystatechange = function () {
                        if (httpRequest.responseText.indexOf('status') > 0) {
                            const info = JSON.parse(httpRequest.responseText)
                            if (info.status === 200) {
                                console.log('提交成功！')
                                // 移除输入框
                                inputWay.style.marginRight = '-30px'
                                inputWay.style.width = '0'
                                // 为了让动画能够工作，给一点点不存在的延时
                                setTimeout(() => inputWay.remove(), 150)
                                setTimeout(() => location.reload(), 150)
                            } else {
                                showError('更新用户 Key 错误(' + info.status + ')：' + info.message)
                            }
                        }
                    };
                } catch (e) {
                    showError('更新用户 Key 错误：' + e.message)
                }
            } else {
                showError('更新用户 Key 错误：内容不合法，最多包含 5 个字符，不能包含空白字符。')
            }
        }
        // 移除输入框
        inputWay.style.marginRight = '-30px'
        inputWay.style.width = '0'
        // 为了让动画能够工作，给一点点不存在的延时
        setTimeout(() => inputWay.remove(), 150)
    } else {
        // 改为勾子
        sender.innerHTML = '<i class="fa fa-times" aria-hidden="true"></i>'
        const addWhere = sender.previousElementSibling.previousElementSibling
        // 创建输入框
        let input = document.createElement('input')
        input.style.flex = '0'
        input.style.width = '0'
        input.style.height = '33px'
        input.style.transition = 'width, margin-right .3s'
        input.style.marginRight = '-30px'
        input.style.marginTop = '-1px'
        input.classList.add('ss-input')
        input.placeholder = '输入备注'
        input.type = 'text'
        input.id = 'change' + sender.parentNode.dataset.id
        input.setAttribute('oninput','keyInChange(' + sender.parentNode.dataset.id + ');');
        // 插入
        sender.parentNode.insertBefore(input, addWhere)
        // 为了让动画能够工作，给一点点不存在的延时
        setTimeout(() => input.style.marginRight = '10px', 1)
        setTimeout(() => input.style.width = '200px', 1)
    }
}

function keyInChange(id) {
    const sender = document.getElementById('change' + id)
    const txt = sender.value
    if(txt === '') {
        document.getElementById('changeb' + id).innerHTML = '<i class="fa fa-times" aria-hidden="true"></i>'
        document.getElementById('changeb' + id).disabled = false
    } else {
        const reg = /^\S{0,5}$/
        if(reg.test(sender.value)) {
            document.getElementById('changeb' + id).innerHTML = '<i class="fa fa-check" aria-hidden="true"></i>'
            document.getElementById('changeb' + id).disabled = false
        } else {
            document.getElementById('changeb' + id).innerHTML = '<i class="fa fa-times" aria-hidden="true"></i>'
            document.getElementById('changeb' + id).disabled = true
        }
    }
}

function setMainColor(sender) {
    const color_id = sender.parentNode.dataset.id
    changeMainColor(color_id)
    // 保存颜色设置到 cookie
    const exp = new Date();
    exp.setTime(exp.getTime() + 50 * 60 * 1000);
    // 拆分设置参数
    let opt = "0|0|0"
    if(options !== '') {
        options[2] = color_id   // 颜色是第三位
        // 构建设置参数
        opt = saveOpt(options)
    }
    document.cookie = "options=" + opt + "; expires=" + exp.toGMTString() + "; path=/";
}

function changeSet(sender) {
    const setbody_id = sender.parentNode.dataset.id
    const set_status = sender.checked
    // 保存设置到 cookie
    const exp = new Date();
    exp.setTime(exp.getTime() + 50 * 60 * 1000);
    // 拆分设置参数
    let opt = "0|0|0"
    if(options !== '') {
        options[setbody_id] = set_status ? '1' : '0'
        // 构建设置参数
        opt = saveOpt(options)
    }
    document.cookie = "options=" + opt + "; expires=" + exp.toGMTString() + "; path=/";
    uploadColor()
}

function exitAcc() {
    try {
        const httpRequest = new XMLHttpRequest();
        httpRequest.open("POST", "/acc/OutAcc", true);
        httpRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        httpRequest.send("id=" + idIn + "&token=" + tok);

        httpRequest.onreadystatechange = function () {
            if(httpRequest.responseText.indexOf('status') > 0) {
                const info = JSON.parse(httpRequest.responseText)
                if(info.status === 200) {
                    location.reload();
                } else {
                    showError('退出登录错误：' + info.message)
                }
            }
        };
    } catch (e) {
        showError('退出登录错误：' + e.message)
    }
}

function sendMail() {
    let is_get = false
    // 验证输入
    const mail = document.getElementById('mail-input').value
    const reg = /^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/
    if (!reg.test(mail)) {
        showError("请输入正确的邮箱！");
        return false;
    }
    document.getElementById('mail-input').disabled = true
    document.getElementById('mail-input').style.width = '0'
    setTimeout(() => document.getElementById('mail-input').style.display = 'none', 200)
    document.getElementById('mail-button').innerHTML = '<i class="fa fa-cog fa-spin" aria-hidden="true"></i> 发送中'
    try {
        const httpRequest = new XMLHttpRequest();
        httpRequest.open("POST", "/acc/verifyMail", true);
        httpRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        httpRequest.send("id=" + idIn + "&token=" + tok + "&mail=" + mail);

        httpRequest.onreadystatechange = function () {
            if(httpRequest.responseText.indexOf('status') > 0) {
                const info = JSON.parse(httpRequest.responseText)
                if(info.status === 200 && !is_get) {
                    is_get = true
                    // 显示验证码输入框
                    document.getElementById('mail-button').style.display = 'none'
                    document.getElementById('mail-check-inputs').style.display = 'block'
                    document.getElementById('mail-check-inputs-body').click()
                } else if(info.status === 403 && !is_get) {
                    is_get = true
                    showError(info.message)
                    document.getElementById('mail-button').disabled = false
                    document.getElementById('mail-button').style.display = 'block'
                    document.getElementById('mail-button').innerHTML = '<i class="fa fa-envelope" aria-hidden="true"></i> 重新发送'
                    cleanCodeInput(document.getElementById('mail-check-inputs-body'))
                }
            }
        };
    } catch (e) {
        showError('发送邮件错误：' + e.message)
    }
    document.getElementById('mail-input').disabled = false
}

function showError(msg) {
    document.getElementById('center_err_msg').innerText = msg
    document.getElementById('center_err_pan').style.display = 'flex'
    document.getElementById('center_err_pan').style.marginBottom = '20px'
    document.body.scrollTop = document.documentElement.scrollTop = 0
}