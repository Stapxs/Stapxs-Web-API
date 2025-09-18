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
                error: '返回数据解析失败'
            }
        }
    }
}
