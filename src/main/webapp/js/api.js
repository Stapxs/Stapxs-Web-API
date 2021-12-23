// 初始化顶栏头像和登录信息
const cookies1 = document.cookie.split('; ')
let name = ''
let id = -1
let options = ''
cookies1.forEach(function (cookie) {
    if(cookie.indexOf("id") >= 0) {
        id = cookie.split('=')[1]
    }
    if(cookie.indexOf("name") >= 0) {
        name = cookie.split('=')[1]
    }
    if(cookie.indexOf("options") >= 0) {
        options = cookie.split('=')[1]
        options = options.split('|')
    }
})
// 修改顶栏内容
if(name !== '') {
    document.getElementById("user-avatar").title = name;
    document.getElementById("user-name").innerText = name;
}
// 加载头像
if(id >= 0) {
    document.getElementById("avatar-img").src = "/acc/info/getAvatar/" + id
}
// 加载颜色
if(options !== '') {
    changeMainColor(options[2])
}

function Login() {
    window.location.href = "/Account"
}

function saveOpt() {
    let str = ''
    options.forEach(function (v) {
        str += v.toString() + "|"
    })
    if (str !== '') {
        str = str.substring(0, str.length - 1)
    }
    return str
}

function changeMainColor(id) {
    document.documentElement.style.setProperty('--color-main', "var(--color-main-" + id + ")")
}