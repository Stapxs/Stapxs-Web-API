import fetch from 'node-fetch'
import { MinecraftServerListPing as mc } from 'minecraft-status'

import { Controller, Get, Param } from '@nestjs/common'
import { JSDOM as DOM } from 'jsdom'

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

    /**
     * 发送 Minecraft Server list Ping
     * @param params 服务器地址:端口号，可以缺省端口号
     * @returns 服务器返回的原始 List Ping 数据，见 https://wiki.vg/Server_List_Ping
     */
    @Get('mc-info/:link')
    async getMcServerInfo(@Param() params) {
        const link = (params.link as string).split(':')
        const address = link[0]
        let port = 25565
        if(link.length > 0) {
            port = Number(link[1])
        }

        let back = {}
        await mc.ping(4, address, port, 3000)
        .then(response => {
            back = { status: 200, data: response }
        })
        .catch(error => {
            back = { status: 500, data: error }
        })
        return back
    }

}

// 控制器接口信息列表
export const info = [
    {
        type: 'tool',
        address: '/tool/page-info/:link',
        name: '链接预览',
        description: '获取页面的 The Open Graph protocol 媒体信息。'
    },
    {
        type: 'tool',
        address: '/tool/mc-info/:link',
        name: 'Minecraft 服务器列表 Ping',
        description: '获取 Minecraft List Ping 返回的内容。'
    }
]