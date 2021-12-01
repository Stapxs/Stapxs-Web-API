const types_id = ["text", "pic", "tool", "other"]
const types_name = ["文本", "图片", "工具", "其他"]
// 获取 API 基础列表
console.log('开始加载目录……')
fetch('/sys/getInfo')    .then(response => response.json())
    .then(data => {
        const base_html_type = String.raw`<a class="nav-link nav-ss-link" href="#item-{1}">{2}</a>`
        const base_html_api = String.raw`<nav class="nav nav-pills flex-column">{1}</nav>`
        const base_html_api_in = String.raw`<a class="nav-link nav-ss-link ml-3 my-1 left-nav-1" style="margin-left: 0 !important;" href="#{1}">
                                            <i class="fa fa-caret-right list-fa" aria-hidden="true"></i>
                                            <i>{2}</i>
                                        </a>`
        let inner = ''
        for(let i=0; i< types_id.length; i++) {
            console.log('开始加载文档体……')
            // 处理目录
            let sc_nav_inner = ''
            let sc_nav = base_html_api
            if(data[types_id[i]].length > 0) {
                // 生成标题
                createTypeTitle(i, types_name[i])
            }
            for (let j = 0; j < data[types_id[i]].length; j++) {
                if(j === 0) {
                    // let title = base_html_type;
                    // title = title.replace('{1}', types_id[i])
                    // title = title.replace('{2}', types_name[i])
                    // inner += title
                }
                let info = base_html_api_in
                info = info.replace('{1}', data[types_id[i]][j]['name'])
                info = info.replace('{2}', data[types_id[i]][j]['name'])
                sc_nav_inner += info
                // 处理内容
                getInfo(i, j, data[types_id[i]][j]['name'])         // 处理内容
            }
            sc_nav = sc_nav.replace('{1}', sc_nav_inner)
            inner += sc_nav_inner
        }
        document.getElementById('main-list').innerHTML = inner
        document.getElementById('loading-card').style.display = 'none'
    })
    .catch(console.error)

function getInfo(type_id, tool_id, name) {
    let html = ''
    // 创建卡片顶部
    const base_top = String.raw`                                    <div id="card-title-hd"></div>
                                    <header>{1}</header>`.replace('{1}', name)
    html += base_top
    // 创建本体
    let back
    let id = ''
    do {
        back = createInfo(name + id)
        html += back[0]
        id = '-' + back[1]
    } while (back[1] !== '0')
    // 添加本体
    // <div id="{1}" class="ss-card" style="margin-bottom: 20px;">
    let div = document.createElement('div')
    div.id = name
    div.classList.add('ss-card')
    div.style.marginBottom = '20px'
    div.innerHTML = html
    document.getElementById('main-body').append(div)
}

function createInfo(name) {
    let main_html = ''
    let next = '0'
    let url = '/text/' + name + '.ini?version=' + app_version
    // 同步请求
    const httpRequest = new XMLHttpRequest();
    httpRequest.open('GET', url, false)
    // httpRequest.timeout = 20000
    httpRequest.send();

    if (httpRequest.status === 200) {
        const ini = httpRequest.responseText
        // 构造全部本体内容
        const info = ini.split('\r\n')
        let values = []
        let backs = []
        let url = ''
        let type = ''
        let info_str = ''
        info.forEach(function (value, index) {
            if (value.split(':')[0].indexOf('api-value') >= 0) {
                values.push(value)
            } else if (value.split(':')[0].indexOf('api-back') >= 0) {
                backs.push(value)
            } else if (value.split(':')[0].indexOf('url') >= 0) {
                url = value.split(':')[1]
            } else if (value.split(':')[0].indexOf('type') >= 0) {
                type = value.split(':')[1].toUpperCase()
            } else if (value.split(':')[0].indexOf('info') >= 0) {
                info_str = value.split(':')[1]
            } else if (value.split(':')[0].indexOf('next') >= 0) {
                next = value.split(':')[1]
            }
        })
        // 构造主结构
        main_html += createMain(name, type, url, info_str)
        // 构造参数
        const value_html = createValues(values)
        // 构建返回参数
        const back_html = createBacks(backs, name)
        // 拼接参数
        if (value_html !== '') {
            main_html = main_html.replace('{5}', value_html)
        } else {
            main_html = main_html.replace('{5}', String.raw`<i class="fa fa-caret-right info-body-title" aria-hidden="true"></i><i>请求参数</i>` + value_html)
        }
        if (back_html !== '') {
            main_html = main_html.replace('{6}', back_html)
        } else {
            main_html = main_html.replace('{6}', String.raw`<i class="fa fa-caret-right info-body-title" aria-hidden="true"></i><i>返回示例</i>` + back_html)
        }
    }
    console.log(url)
    return [main_html, next]
}

function createTypeTitle(id, name) {
    const body = document.getElementById('main-body')
    let title_base = String.raw`<div></div><span>{1}</span>`
    title_base = title_base.replace('{1}', name)
    let div = document.createElement('div')
    div.id = 'item-' + id
    div.classList.add('ss-card')
    div.classList.add('ana-card')
    div.innerHTML = title_base
    body.append(div)
}

function createMain(name, type, url, info) {
    let main = String.raw`
                                    <div class="doc-body">
                                        <div class="ss-card add-card">
                                            <a>{2}</a>
                                            <i class="fa fa-square" aria-hidden="true"></i>
                                            <code>
                                                {3}
                                            </code>
                                            <div style="clear: both;display: block;"></div>
                                        </div>
                                        <div class="info-body">
                                            <i class="fa fa-caret-right info-body-title" aria-hidden="true"></i><i>功能简述</i>
                                            <p>{4}</p>
                                            {5}
                                            {6}
                                        </div>
                                    </div>`
    main = main.replace('{1}', name)
    main = main.replace('{2}', type)
    main = main.replace('{3}', url)
    main = main.replace('{4}', info)
    return main
}

function createValues(values) {
    if(values.length === 0) {
        return ''
    }
    let back = String.raw`<div class="cs-body">{1}</div>`
    const base_html = String.raw`
                                            <div>
                                                <a>{1}</a>
                                                <i>{2}</i>
                                                <ul>
                                                    <li>{3}</li>
                                                    {4}
                                                </ul>
                                            </div>`
    const base_add = String.raw`                                                    <li><i>{1}</i><code>{2}</code></li>`
    let back_inner = ''
    values.forEach(function (value) {
        let info = value.split(':')
        info = info[1].split('/')

        let body = base_html
        if (info.length >= 4) {
            // 无选填项
            body = body.replace('{1}', (info[0] === '*' ? '* ' : '') + info[1])
            body = body.replace('{2}', info[2])
            body = body.replace('{3}', info[3])
        }
        let add = ''
        if (info.length === 5) {
            // 无默认项
            let add_body = base_add
            add_body = add_body.replace('{1}', '可选')
            add_body = add_body.replace('{2}', info[4].replace(new RegExp('\\+', 'mg'), '、'))
            add += add_body
        }else if (info.length === 6) {
            // 完整
            let add_body = base_add
            add_body = add_body.replace('{1}', '默认')
            add_body = add_body.replace('{2}', info[4])
            add += add_body
            add_body = base_add
            add_body = add_body.replace('{1}', '可选')
            add_body = add_body.replace('{2}', info[5].replace(new RegExp('\\+', 'mg'), '、'))
            add += add_body
        }
        body = body.replace('{4}', add)
        back_inner += body
    })
    return back.replace('{1}', back_inner)
}

 function createBacks(backs, name) {
     if(backs.length === 0) {
         return ''
     }
     const icon_list = [
         "fa-check",
         "fa-exclamation",
         "fa-times"
     ]
     const back = String.raw`<div class="ss-card" style="background: var(--color-card-1);margin-top: 20px;">
                                    <button onclick="foldChange(this)" class="btn btn-primary lis-button collapsed" type="button" data-toggle="collapse" data-target="#{2}" aria-expanded="false" aria-controls="{2}">
                                        <header><i class="fa {4}" aria-hidden="true"></i>{1}</header>
                                        <svg style="transform: rotate(-90deg);" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="angle-right" class="svg-inline--fa fa-angle-right fa-w-8" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 512"><path fill="currentColor" d="M224.3 273l-136 136c-9.4 9.4-24.6 9.4-33.9 0l-22.6-22.6c-9.4-9.4-9.4-24.6 0-33.9l96.4-96.4-96.4-96.4c-9.4-9.4-9.4-24.6 0-33.9L54.3 103c9.4-9.4 24.6-9.4 33.9 0l136 136c9.5 9.4 9.5 24.6.1 34z"></path></svg>
                                    </button>
                                    <div class="collapse" id="{2}" style="padding: 10px;">
                                        <pre class="language-json">
                                            <code class="language-json">{3}</code>
                                        </pre>
                                    </div>
                                </div>`
     let all_back = ''
     backs.forEach(function (value) {
         // 拆分数据
         let back_code = value.substring(0, value.indexOf(':'))
         back_code = back_code.split('-')[2]
         let json = value.substring(value.indexOf(':') + 1, value.length)
         json = json.replace(new RegExp('\\+', 'mg'), '\n')
         json = Prism.highlight(json, Prism.languages.json, 'json');
         let its_back = back
         its_back = its_back.replace(new RegExp('\\{2\\}', 'mg'), name.replace(' ', '-') + '-' + back_code)
         its_back = its_back.replace('{3}', json)
         let icon = icon_list[0]
         switch (back_code) {
             case '200':
                 its_back = its_back.replace('{1}', '200 - OK')
                 icon = icon_list[0]
                 break
             case '404':
                 its_back = its_back.replace('{1}', '404 - NO FOUND')
                 icon = icon_list[1]
                 break
             case '500':
                 its_back = its_back.replace('{1}', '500 - SERVER ERR')
                 icon = icon_list[2]
                 break
         }
         its_back = its_back.replace('{4}', icon)
         all_back += its_back
     })
     return all_back
 }

function downCard(sender) {
    if(sender.style.transform === 'rotate(180deg)') {
        sender.style.transform = 'rotate(0deg)'
        document.getElementById('ml-main').style.marginTop = '0'
    } else {
        sender.style.transform = 'rotate(180deg)'
        document.getElementById('ml-main').style.marginTop = 'calc(50vh + 75px)'
    }
    if ($(document).scrollTop() >= $(document).height() - $(window).height() - 137) {
        document.getElementById('ml-main').style.marginTop = 'calc(50vh + 130px)'
    }
}

function closeCard() {
    document.getElementById('ml-main').style.display = 'none'
}

$(document).ready(function() {
    $(window).scroll(function() {
        if ($(document).scrollTop() >= $(document).height() - $(window).height() - 137) {
            if(document.getElementById('ml-main').style.marginTop !== '0px') {
                document.getElementById('ml-main').style.marginTop = 'calc(50vh + 130px)'
            }
        } else {
            if(document.getElementById('ml-main').style.marginTop === 'calc(50vh + 130px)') {
                document.getElementById('ml-main').style.marginTop = 'calc(50vh + 75px)'
            }
        }
    });
});