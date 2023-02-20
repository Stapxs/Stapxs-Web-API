import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { InnerController } from './inner/inner.controller';
import { ConfigModule } from '@nestjs/config';
import { ToolController } from './tool/tool.controller';
import { TextController } from './text/text.controller';

@Module({
  imports: [ConfigModule.forRoot()],
  controllers: [
    AppController, InnerController,
    ToolController, TextController
  ]
})
export class AppModule {}
