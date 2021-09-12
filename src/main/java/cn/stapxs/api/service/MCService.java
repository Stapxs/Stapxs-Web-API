package cn.stapxs.api.service;

import org.springframework.ui.Model;

import java.util.Optional;

/**
 * @Version: 1.0
 * @Date: 2021/9/12 下午 2:27
 * @ClassName: MCService
 * @Author: Stapxs
 * @Description TO DO
 **/
public interface MCService {
    public String MCInfoErr(Optional<String> type, String err, Model model);
}
