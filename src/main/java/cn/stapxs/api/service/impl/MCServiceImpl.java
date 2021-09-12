package cn.stapxs.api.service.impl;

import cn.stapxs.api.domain.msg.BaseMsg;
import cn.stapxs.api.service.MCService;
import cn.stapxs.api.util.UI;
import com.google.gson.Gson;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import java.util.Optional;

/**
 * @Version: 1.0
 * @Date: 2021/9/12 下午 2:31
 * @ClassName: MCServiceImpl
 * @Author: Stapxs
 * @Description TO DO
 **/
@Service
@Transactional
public class MCServiceImpl implements MCService {

    private static final Gson gson = new Gson();

    @Override
    public String MCInfoErr(Optional<String> type, String err, Model model) {
        if (type.isPresent()) {
            switch (type.get()) {
                case "json": {
                    return UI.JumpAPI(500, err, model);
                }
                case "view": {
                    break;
                }
                default: {
                    return UI.JumpError(500, err, model);
                }
            }
        } else {
            return UI.JumpError(500, err, model);
        }
        return UI.JumpError(400, model);
    }
}
