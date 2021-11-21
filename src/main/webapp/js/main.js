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
// TODO 等待头像上传 API 和获取 API 完成后补充

function Login() {
    window.location.href = "/Account"
}

function changeColor(type) {
    const oldLink = document.getElementsByTagName("link").item(0);
    const newLink = document.createElement("link");
    newLink.setAttribute("rel", "stylesheet");
    newLink.setAttribute("type", "text/css");
    if(type === "dark") {
        newLink.setAttribute("href", "/css/color-dark.css");
    } else {
        newLink.setAttribute("href", "/css/color-light.css");
    }
    document.getElementsByTagName("head").item(0).replaceChild(newLink, oldLink);
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