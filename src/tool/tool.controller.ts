import { Controller, Get, Param } from '@nestjs/common';
import { JSDOM as DOM } from 'jsdom';

@Controller('tool')
export class ToolController {
    /**
     * 获取链接预览
     * @param params 链接 
     * @returns og 开头的 meta 信息
     */
    @Get('page-info/:link')
    async getPageInfo(@Param() params) {
        const back = {}
        await fetch(params.link)
        .then(response => response.text())
        .then(data => {
            const html = new DOM(data)
            const document = html.window.document
            const head = document.getElementsByTagName('head')[0]
            const meta = head.getElementsByTagName('meta')
            for(let i=0; i<meta.length; i++) {
                const item = meta[i]
                const property = item.getAttribute('property')
                const content = item.getAttribute('content')
                if(property && property.startsWith('og:')) {
                    back[property] = content
                }
            }
        })
        return back
    }

}

// 控制器接口信息列表
export const info = [
    {
        address: '/tool/page-info/:link',
        name: '链接预览',
        description: '获取页面的 The Open Graph protocol 媒体信息。'
    }
]