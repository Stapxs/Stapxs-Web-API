// 初始化顶栏头像和登录信息
const cookies1 = document.cookie.split('; ')
let name = ''
let id = -1
cookies1.forEach(function (cookie) {
    if(cookie.indexOf("id") >= 0) {
        id = cookie.split('=')[1]
    }
    if(cookie.indexOf("name") >= 0) {
        name = cookie.split('=')[1]
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

function Login() {
    window.location.href = "/Account"
}