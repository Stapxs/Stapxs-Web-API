/**
 * @FileDescription: 主控制器
 * @Author: Stapxs
 * @Date: 2022-2-10
 * @Version: 1.0
 */

import { Controller, Get } from '@nestjs/common';
import { version } from '../package.json';

@Controller()
export class AppController {
    @Get()
    hello(): {[key:string]: string | number} {
        const welcomeStr = [
            '欢迎使用 Stapxs Web API！',
            '这是 Stapxs Web API！'
          ]
          const info = {} as {[key: string]: any}
          info.msg = welcomeStr[Math.round(Math.random() * welcomeStr.length - 1)]
          info.version = version
          return info;
    }
}
