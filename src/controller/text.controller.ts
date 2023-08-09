import { randomInt } from 'crypto'
import { Controller, Param, Get } from '@nestjs/common'

import * as ana from '../assets/ss-ana.json'

@Controller('text')
export class TextController {
    @Get('ss-ana')
    getSSAnaRandon() {
        return ana[randomInt(0, ana.length - 1)].text
    }
    @Get('ss-ana/:type')
    getSSAnaType(@Param('type') type: string) {
        const num = randomInt(0, ana.length - 1)
        switch(type) {
            case 'text': return ana[num].text
            case 'json': return {
                status: 200,
                id: num,
                ... ana[num]
            }
            default: return {
                status: 403,
                message: "参数不正确"
            }
        }
    }
    @Get('ss-ana/:type/:id')
    getSSAnaTypeId(@Param('type') type: string, @Param('id') id: number) {
        switch(type) {
            case 'text': return ana[id].text
            case 'json': return {
                status: 200,
                id: id,
                ... ana[id]
            }
            default: return {
                status: 403,
                message: "参数不正确"
            }
        }
    }
}

// 控制器接口信息列表
export const info = [
    {
        address: '/text/ss-ana/:type/:id',
        name: '获取林槐语录',
        description: '获取林槐语录，参数可缺省。'
    }
]