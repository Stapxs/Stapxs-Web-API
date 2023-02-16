import { Test, TestingModule } from '@nestjs/testing';
import { InnerController } from './inner.controller';

describe('InnerController', () => {
  let controller: InnerController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [InnerController],
    }).compile();

    controller = module.get<InnerController>(InnerController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
