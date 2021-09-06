package cn.stapxs.api.service;

import cn.stapxs.api.domain.msg.AnaMsg;

/**
 * @Version: 1.0
 * @Date: 2021/9/1 下午 4:34
 * @ClassName: AnaService
 * @Author: Stapxs
 * @Description TO DO
 **/
public interface AnaService {
    public AnaMsg getAna(String file);
    public AnaMsg getAna(String file, int index);
}
