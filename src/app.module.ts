import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { InnerController } from './controller/inner.controller';
import { ConfigModule } from '@nestjs/config';
import { ToolController } from './controller/tool.controller';
import { TextController } from './controller/text.controller';
import { SSqqController } from './controller/ssqq.controller';

@Module({
    imports: [ConfigModule.forRoot()],
    controllers: [
        AppController, InnerController,
        ToolController, TextController,
        SSqqController
    ]
})
export class AppModule {}
