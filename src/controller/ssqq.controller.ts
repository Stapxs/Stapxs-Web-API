/**
 * @file: Stapxs QQ Lite 信息提供控制器
 * @author: Stapxs
 * @time: 2025-09-17
 * @version: 1.0
 * @description 这是一些提供给 Stapxs QQ Lite 用的功能，不会显示出来
 */

import fetch from 'node-fetch';
import { Controller, Get, Param, Query } from '@nestjs/common';
import * as crypto from 'crypto';
import { UmamiService } from 'src/service/umami.service';

@Controller('ssqq')
export class SSqqController {
    private umamiService: UmamiService;

    private static removeName = ['country', 'region', 'city']

    constructor() {
        this.umamiService = new UmamiService();
    }

    /**
     * 获取爱发电赞助者信息
     * @returns 获取到的信息
     */
    @Get('sponsor')
    async getSponsorList() {
        const address = 'https://www.ifdian.net/api/open/query-sponsor'
        const params = {
            page: 1,
            per_page: 100
        }
        const timestamp = Math.floor(Date.now() / 1000)
        const signStr = `${process.env.AFD_TOKEN}params${JSON.stringify(params)}ts${timestamp}user_id${process.env.AFD_USERID}`
        const sign = crypto.createHash('md5').update(signStr).digest('hex')
        const data = {
            user_id: process.env.AFD_USERID,
            ts: timestamp,
            sign: sign,
            params: JSON.stringify(params)
        }
        // post 请求
        const res = await fetch(address, {
            method: 'POST',
            headers: {
                'content-type': 'application/json'
            },
            body: JSON.stringify(data)
        })
        const result = await res.json()
        if(result.ec === 200) {
            const list = result.data.list
            const sponsorList = list.map(item => {
                return {
                    current_plan: item.current_plan.name,
                    last_pay_time: item.last_pay_time,
                    user: {
                        name: item.user.name,
                        avatar: item.user.avatar
                    }
                }
            })
            return {
                count: result.data.total_count,
                list: sponsorList
            }
        } else {
            return { error: result.em }
        }
    }

    /**
     * ============================== Umami 相关接口 =============================
     * 其中，备注支持详细筛选的接口均支持传入 query 参数进行筛选，query 均为 GET 请求参数，支持的参数有：
     * - timezone 时区，默认为 UTC+8，可选值见 https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
     * - url 访问页面
     * - referrer 来源页面
     * - title 访问页面标题
     * - host 访问主机
     * - os 操作系统名称
     * - browser 浏览器名称
     * - device 设备类型
     *
     * e.g.： /ssqq/umami/pageviews/day?host=tauri.stapxs.com&url=/Messages
     * ========================================================================
     */

    /**
     * 获取 Umami 站点当前在线访客数
     * @returns Umami 站点当前在线访客数
     */
    @Get('umami/active')
    async getUmamiActive() {
        return await this.umamiService.getData(`/websites/${process.env.UMAMI_SITE_ID}/active`);
    }

    /**
     * 【支持详细筛选】获取 Umami 站点页面浏览量数据（柱状图数据）
     * @param unit 时间单位，可选值：hour, day, month, year
     * @param time 时间范围，格式为 start-end（时间戳，毫秒），缺失则为最近 24 小时
     * @param query 其他查询参数
     * @returns 站点页面浏览量数据
     */
    @Get('umami/pageviews/:unit')
    @Get('umami/pageviews/:unit/:time')
    async getUmamiPageviews(@Param('unit') unit: string, @Param('time') time: string, @Query() query: { [key: string]: any }) {
        if(!time) {
            // 缺失默认为最近 24 小时
            time = `${Date.now() - 86400000}-${Date.now()}`;
        }
        if(time.indexOf('-') === -1 || !/^\d{13}$/.test(time.split('-')[0]) || !/^\d{13}$/.test(time.split('-')[1])) {
            return { error: '参数 time 格式错误，正确格式为 start-end（时间戳，毫秒）' };
        }

        if(SSqqController.removeName.includes(query.type) || query.unit) {
            return { error: '请求参数中包含不被允许的字段' };
        }

        const data = await this.umamiService.getData(`/websites/${process.env.UMAMI_SITE_ID}/pageviews`, {
            startAt: Number(time.split('-')[0]),
            endAt: Number(time.split('-')[1]),
            unit: unit,
            ...query
        });
        return data;
    }

    /**
     * 【支持详细筛选】获取 Umami 站点统计数据
     * @param time 时间范围，格式为 start-end（时间戳，毫秒），缺失则为最近 24 小时
     * @param query 其他查询参数
     * @returns 站点统计数据
     */
    @Get('umami/status')
    @Get('umami/status/:time')
    async getUmamiStatus(@Param('time') time: string, @Query() query: { [key: string]: any }) {
        if(!time) {
            // 缺失默认为最近 24 小时
            time = `${Date.now() - 86400000}-${Date.now()}`;
        }
        if(time.indexOf('-') === -1 || !/^\d{13}$/.test(time.split('-')[0]) || !/^\d{13}$/.test(time.split('-')[1])) {
            return { error: '参数 time 格式错误，正确格式为 start-end（时间戳，毫秒）' };
        }

        if(SSqqController.removeName.includes(query.type)) {
            return { error: '请求参数中包含不被允许的字段' };
        }

        const data = await this.umamiService.getData(`/websites/${process.env.UMAMI_SITE_ID}/stats`, {
            startAt: Number(time.split('-')[0]),
            endAt: Number(time.split('-')[1]),
            ...query
        });
        return data;
    }

    /**
     * 【支持详细筛选】获取 Umami 站点指标数据
     * @param name 指标名称, 可选值：url, referrer, browser, os, device, language, screen, event
     * @param time 时间范围，格式为 start-end（时间戳，毫秒），缺失则为最近 24 小时
     * @returns 站点指标数据
     */
    @Get('umami/metrics/:name')
    @Get('umami/metrics/:name/:time')
    async getUmamiMetrics(@Param('name') name: string, @Param('time') time: string, @Query() query: { [key: string]: any }) {
        if(!time) {
            // 缺失默认为最近 24 小时
            time = `${Date.now() - 86400000}-${Date.now()}`;
        }
        if(time.indexOf('-') === -1 || !/^\d{13}$/.test(time.split('-')[0]) || !/^\d{13}$/.test(time.split('-')[1])) {
            return { error: '参数 time 格式错误，正确格式为 start-end（时间戳，毫秒）' };
        }

        if(SSqqController.removeName.includes(name) || name === 'host') {
            return { error: `请求的数据类型 ${name} 不被允许` };
        }

        if(SSqqController.removeName.includes(name) || query.type) {
            return { error: '请求参数中包含不被允许的字段' };
        }

        const data = await this.umamiService.getData(`/websites/${process.env.UMAMI_SITE_ID}/metrics`, {
            startAt: Number(time.split('-')[0]),
            endAt: Number(time.split('-')[1]),
            type: name,
            ...query
        });
        return data;
    }

    /**
     * 获取事件统计数据
     * @returns 事件统计数据
     */
    @Get('umami/events')
    @Get('umami/events/:time')
    async getUmamiEvents(@Param('time') time: string) {
        if(!time) {
            // 缺失默认为最近 24 小时
            time = `${Date.now() - 86400000}-${Date.now()}`;
        }
        if(time.indexOf('-') === -1 || !/^\d{13}$/.test(time.split('-')[0]) || !/^\d{13}$/.test(time.split('-')[1])) {
            return { error: '参数 time 格式错误，正确格式为 start-end（时间戳，毫秒）' };
        }

        const data = await this.umamiService.getData(`/websites/${process.env.UMAMI_SITE_ID}/event-data/events`, {
            startAt: Number(time.split('-')[0]),
            endAt: Number(time.split('-')[1])
        }) as {
            eventName: string;
            propertyName: string;
            dataType: string;
            total: number;
        }[];

        // 获取事件具体数量
        const detailedDataPromises = data.map(async (event) => {
            const detailedData = await this.umamiService.getData(`/websites/${process.env.UMAMI_SITE_ID}/event-data/values`, {
                startAt: Number(time.split('-')[0]),
                endAt: Number(time.split('-')[1]),
                eventName: event.eventName,
                propertyName: event.propertyName
            });
            return {
                ...event,
                details: detailedData
            };
        });

        const detailedData = await Promise.all(detailedDataPromises);
        return detailedData;
    }
}
