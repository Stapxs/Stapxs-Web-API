// 验证登录
let back = document.referrer
if(back !== '') {
    back = back.substring(back.lastIndexOf('/'))
    if(back !== '/Account?back=Doing') {
        window.location.href = "/Account?back=Doing"
    }
} else {
    window.location.href = "/Account?back=Doing"
}

// 获取参数
