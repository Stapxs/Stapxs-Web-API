/**
 * @file: 支持服务控制器
 * @author: Stapxs
 * @time: 2022-2-10
 * @version: 1.0
 * @description 这是一些提供给站点其他服务用的功能，不会显示出来
 */

import fetch from 'node-fetch';
import { Controller, Get, Param } from '@nestjs/common';

@Controller('inner')
export class InnerController {
    /**
     * 获取 Home Assistant 实体信息，会屏蔽部分敏感信息
     * @param params 实体 ID
     * @returns 获取到的信息
     */
    @Get('home/:id')
    async getHomeInfo(@Param() params) {
        let info = {}
        const deleteKey = ['latitude', 'longitude', 'location']
        const url = process.env.HOME_ADDRESS + '/api/states/' + params.id
        await fetch(url, {
            method: 'GET',
            headers: {
                'Authorization': 'Bearer ' + process.env.HOME_TOKEN,
                'content-type': 'application/json'
            }
        })
            .then(response => response.json())
            .then(data => {
                // 移除一些敏感信息
                Object.keys((data as any).attributes).forEach((name: string) => {
                    if(deleteKey.indexOf(name.toLowerCase()) >= 0) {
                        (data as any).attributes[name] = 'removed'
                    }
                })
                delete (data as any).context
                info = data
            })
        return info
    }
}
