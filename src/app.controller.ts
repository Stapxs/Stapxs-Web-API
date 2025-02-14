/**
 * @FileDescription: 主控制器
 * @Author: Stapxs
 * @Date: 2022-2-10
 * @Version: 1.0
 */

import { Controller, Get } from '@nestjs/common';
import { version } from '../package.json';
import { randomInt } from 'crypto';

import { info as textInfo } from './controller/text.controller';
import { info as toolInfo } from './controller/tool.controller';

@Controller()
export class AppController {
    @Get()
    hello(): {[key:string]: string | number} {
        const welcomeStr = [
            '欢迎使用 Stapxs Web API！',
            '这是 Stapxs Web API！',
            '阿巴啊巴，请随便看 ……',
            '客官要来点茶么 ——'
        ]
        return {
            title: 'Stpaxs Web API',
            msg: welcomeStr[randomInt(0,welcomeStr.length - 1)],
            version: version
        };
    }

    @Get('info')
    apiInfo() {
        return [].concat(textInfo).concat(toolInfo)
    }
}
