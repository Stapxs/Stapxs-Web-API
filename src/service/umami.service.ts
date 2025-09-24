import { SSqqController } from 'src/controller/ssqq.controller';

export class UmamiService {
    private static address = 'https://status.stapxs.cn/api';

    private ready = false;
    private token: string | undefined;

    constructor() {
        this.token = undefined;
        this.getToken().then(() => {
            this.token = this.token;
            this.ready = true;
        });
    }

    public async getUmamiPageviews(time: string, unit: string, query: { [key: string]: any }) {
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

        const data = await this.getData(`/websites/${process.env.UMAMI_SITE_ID}/pageviews`, {
            startAt: Number(time.split('-')[0]),
            endAt: Number(time.split('-')[1]),
            unit: unit,
            ...query
        });
        return data;
    }

    public async getUmamiStatus(time: string, query: { [key: string]: any }) {
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

        const data = await this.getData(`/websites/${process.env.UMAMI_SITE_ID}/stats`, {
            startAt: Number(time.split('-')[0]),
            endAt: Number(time.split('-')[1]),
            ...query
        });
        return data;
    }

    public async getUmamiMetrics(name: string, time: string, query: { [key: string]: any }) {
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

        const data = await this.getData(`/websites/${process.env.UMAMI_SITE_ID}/metrics`, {
            startAt: Number(time.split('-')[0]),
            endAt: Number(time.split('-')[1]),
            type: name,
            ...query
        });
        return data;
    }

    public async getUmamiEvents(time: string) {
        if(!time) {
            // 缺失默认为最近 24 小时
            time = `${Date.now() - 86400000}-${Date.now()}`;
        }
        if(time.indexOf('-') <= 0 || !/^\d{13}$/.test(time.split('-')[0]) || !/^\d{13}$/.test(time.split('-')[1])) {
            return { error: '参数 time 格式错误，正确格式为 start-end（时间戳，毫秒）' };
        }

        const data = await this.getData(`/websites/${process.env.UMAMI_SITE_ID}/event-data/events`, {
            startAt: Number(time.split('-')[0]),
            endAt: Number(time.split('-')[1])
        }) as {
            eventName: string;
            propertyName: string;
            dataType: string;
            total: number;
        }[];

        if(data instanceof Object && (data as any).error) {
            return data;
        }

        // 想要排除的 eventName 列表
        const excludedEvents = ['link_view'];
    
        const filteredData = data.filter(
            (event) => !excludedEvents.includes(event.eventName)
        );

        // 获取事件具体数量
        const detailedDataPromises = data.map(async (event) => {
            const detailedData = await this.getData(`/websites/${process.env.UMAMI_SITE_ID}/event-data/values`, {
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

    public async getUmamiSessions(time: string) {
        if(!time) {
            // 缺失默认为最近 24 小时
            time = `${Date.now() - 86400000}-${Date.now()}`;
        }
        if(time.indexOf('-') <= 0 || !/^\d{13}$/.test(time.split('-')[0]) || !/^\d{13}$/.test(time.split('-')[1])) {
            return { error: '参数 time 格式错误，正确格式为 start-end（时间戳，毫秒）' };
        }

        const data = await this.getData(`/websites/${process.env.UMAMI_SITE_ID}/session-data/properties`, {
            startAt: Number(time.split('-')[0]),
            endAt: Number(time.split('-')[1])
        }) as {
            propertyName: string;
            total: number;
        }[];

        if(data instanceof Object && (data as any).error) {
            return data;
        }

        const detailedDataPromises = data.map(async (item) => {
            const detailedData = await this.getData(`/websites/${process.env.UMAMI_SITE_ID}/session-data/values`, {
                startAt: Number(time.split('-')[0]),
                endAt: Number(time.split('-')[1]),
                propertyName: item.propertyName
            });
            return {
                ...item,
                details: detailedData
            };
        });

        const detailedData = await Promise.all(detailedDataPromises);
        return detailedData;
    }

    // ==================================================================

    /**
     * 获取 Umami API 的访问 token
     * @returns Umami API 的访问 token
     */
    private async getToken(): Promise<string | undefined> {
        const path = '/auth/login';
        const body = {
            username: process.env.UMAMI_USER,
            password: process.env.UMAMI_PASSWORD
        };
        const res = await fetch(UmamiService.address + path, {
            method: 'POST',
            headers: {
                'content-type': 'application/json'
            },
            body: JSON.stringify(body)
        });
        const result = await res.json();
        if (result.token) {
            return result.token;
        } else {
            throw new Error('Umami 登录失败');
        }
    }

    /**
     * 检查当前 token 是否有效
     * @returns Token 是否有效
     */
    private async checkToken(): Promise<boolean> {
        const path = '/auth/verify';
        const res = await fetch(UmamiService.address + path, {
            method: 'POST',
            headers: {
                'content-type': 'application/json',
                'Authorization': `Bearer ${this.token}`
            },
        });
        const result = await res.text();
        try {
            const data = JSON.parse(result);
            if(data.id != undefined) {
                return true;
            }
        } catch (e) {
            // do nothing
        }
        return false;
    }

    /**
     * 获取 Umami API 的数据(GET 请求)
     * @param path API 路径
     * @param params 查询参数
     * @returns Umami API 的响应数据
     */
    public async getData(path: string, params: any = {}): Promise<any> {
        if(!this.ready) {
            return { error: 'Umami 服务尚未准备好，请稍后再试' };
        }

        if (!this.token) {
            this.token = await this.getToken();
        } else {
            const valid = await this.checkToken();
            if (!valid) {
                this.token = await this.getToken();
            }
        }
        const url = new URL(UmamiService.address + path);
        Object.keys(params).forEach(key => url.searchParams.append(key, params[key]));
        const res = await fetch(url.toString(), {
            method: 'GET',
            headers: {
                'content-type': 'application/json',
                'Authorization': `Bearer ${this.token}`
            },
        });
        const result = await res.text();
        try {
            return JSON.parse(result);
        } catch (e) {
            return {
                error: result
            }
        }
    }
}
