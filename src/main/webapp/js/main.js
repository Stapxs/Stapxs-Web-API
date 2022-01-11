let fist_load = true

function changeColor(type) {
    if(!fist_load) {
        // 启用颜色渐变动画
        document.body.style.transition = 'background, color, background-color .3s'
    } else {
        fist_load = false
    }
    // 切换颜色
    let match_list = ['color-.*\.css', 'prism-.*\.css']
    const css_list = document.getElementsByTagName("link")
    for(let i=0; i<css_list.length; i++) {
        name = css_list[i].href
        match_list.forEach(function (value) {
            if(name.match(value) != null) {
                const newLink = document.createElement("link");
                newLink.setAttribute("rel", "stylesheet");
                newLink.setAttribute("type", "text/css");
                if(type === "dark") {
                    newLink.setAttribute("href", name.replace('light', 'dark'));
                } else {
                    newLink.setAttribute("href", name.replace('dark', 'light'));
                }
                document.getElementsByTagName("head").item(0).replaceChild(newLink, css_list[i]);
            }
        })
    }
}

function foldChange(sender) {
    const svg = sender.getElementsByTagName('svg');
    if(svg[0].style.transform === 'rotate(-90deg)') {
        svg[0].style.transform = 'rotate(90deg)'
        animateScroll(sender, 40)
    } else {
        svg[0].style.transform = 'rotate(-90deg)'
    }
}

function animateScroll(element, speed) {
    let rect=element.getBoundingClientRect()
    let top=window.pageYOffset+rect.top
    let currentTop=document.documentElement.scrollTop
    let requestId
    function step(timestamp) {
        currentTop+=speed
        if(currentTop<=top){
            window.scrollTo(0,currentTop)
            requestId=window.requestAnimationFrame(step)
        }else{
            window.cancelAnimationFrame(requestId)
        }
    }
    window.requestAnimationFrame(step)
}

function scrollDiv(sender) {
    const par_body = sender.parentNode
    const line = par_body.getElementsByClassName('scroll-top')[0];
    if(sender.scrollTop === 0) {
        line.style.display = 'none'
    } else {
        line.style.display = 'block'
    }
}

function getQueryVariable(variable) {
    const query = window.location.search.substring(1);
    const vars = query.split("&");
    for (let i=0; i<vars.length; i++) {
        const pair = vars[i].split("=");
        if(pair[0] === variable){
            return pair[1]
        }
    }
    return false
}

function initCodeInput(body, allowEdit, fun) {
    if(body.classList.toString().indexOf('ss-code-input') >= 0) {
        // 初始化 label onclick 事件
        body.onclick = function () {codeInputAllow(body)}
        body.dataset.allowEdit = allowEdit
        // 遍历内部 input
        const inputs = body.getElementsByTagName('input')
        for(let i=0; i<inputs.length; i++) {
            inputs[i].dataset.id = (i+1).toString()                                 // 初始化 input id
            inputs[i].disabled = true                                               // 初始化 input 状态
            inputs[i].oninput = function () {codeInputChanged(inputs[i], fun)}       // 初始化 input oninput
            inputs[i].onkeydown = function () {codeInputDel(event, inputs[i])}      // 初始化 input onkeydown
        }
    }
}

function codeInputChanged(sender, fun) {
    if(sender.value !== '') {
        sender.value = sender.value.substring(sender.value.length - 1)
    }
    // 验证输入内容
    const num = Number(sender.value)
    if(sender.value.indexOf(' ') < 0 && !isNaN(num) && num < 10) {
        sender.disabled = true
        if(Number(sender.dataset.id) === sender.parentNode.getElementsByTagName('input').length) {
            // 最后一位
            if(sender.parentNode.dataset.allowEdit === 'true') {
                // 末尾不退出
                sender.disabled = false
                sender.focus()
            } else {
                // 延迟触发结束方法（为了让动画执行结束）
                setTimeout(() => {
                    fun()
                }, 300)
            }
        } else {
            sender.parentNode.getElementsByTagName('input')[Number(sender.dataset.id)].disabled = false
            sender.parentNode.getElementsByTagName('input')[Number(sender.dataset.id)].focus()
        }
    } else {
        sender.value = ''
    }
}

function codeInputAllow(body) {
    if(body.getElementsByTagName('input')[0].value === '') {
        body.getElementsByTagName('input')[0].disabled = false
        body.getElementsByTagName('input')[0].focus()
    }
}

function codeInputDel(key, sender) {
    if(Number(key.keyCode) === 8){
        sender.disabled = true
        if(Number(sender.dataset.id) > 1) {
            console.log(sender.value + "/" + Number(sender.dataset.id) + "/" + sender.parentNode.getElementsByTagName('input').length)
            if (sender.value !== '' && Number(sender.dataset.id) === sender.parentNode.getElementsByTagName('input').length) {
                setTimeout(() => {
                    sender.disabled = false
                    sender.value = ''
                    sender.focus()
                }, 100)
            } else {
                sender.value = ''
                sender.parentNode.getElementsByTagName('input')[Number(sender.dataset.id) - 2].disabled = false
                sender.parentNode.getElementsByTagName('input')[Number(sender.dataset.id) - 2].focus()
                setTimeout(() => {
                    sender.parentNode.getElementsByTagName('input')[Number(sender.dataset.id) - 2].value = ''
                }, 100)
            }
        } else {
            setTimeout(() => {
                sender.disabled = false
                sender.focus()
            }, 100)
        }
    }
}

function getCodeInput(body) {
    if(body.classList.toString().indexOf('ss-code-input') >= 0) {
        // 遍历内部 input
        const inputs = body.getElementsByTagName('input')
        let str = ''
        for(let i=0; i<inputs.length; i++) {
            // 拼接字符串
            str += inputs[i].value
        }
        // 返回
        return str
    }
}

function cleanCodeInput(body) {
    if(body.classList.toString().indexOf('ss-code-input') >= 0) {
        // 遍历内部 input
        const inputs = body.getElementsByTagName('input')
        for(let i=0; i<inputs.length; i++) {
            inputs[i].value = ''
        }
    }
}