// 自动暗黑模式相关代码
let media = window.matchMedia('(prefers-color-scheme: dark)');
if(media.matches){
    changeColor("dark")
} else {
    changeColor("light")
}
let callback = (e) => {
    let prefersDarkMode = e.matches;
    if (prefersDarkMode) {
        changeColor("dark")
    } else {
        changeColor("light")
    }
};
if (typeof media.addEventListener === 'function') {
    media.addEventListener('change', callback);
} else if (typeof media.addListener === 'function') {
    media.addListener(callback);
}