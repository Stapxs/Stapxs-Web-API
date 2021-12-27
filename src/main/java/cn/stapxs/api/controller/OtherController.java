package cn.stapxs.api.controller;

import cn.stapxs.api.domain.msg.BaseMsg;
import cn.stapxs.api.domain.tool.DoingMsg;
import cn.stapxs.api.domain.user.UserKey;
import cn.stapxs.api.service.DoingService;
import cn.stapxs.api.service.UserService;
import cn.stapxs.api.service.impl.DoingServiceImpl;
import cn.stapxs.api.util.UI;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

/**
 * @Version: 1.0
 * @Date: 2021/12/26 22:06
 * @ClassName: OtherController
 * @Author: Stapxs
 * @Description TO DO
 **/
@Controller
public class OtherController {

    private final static Gson gson = new Gson();

    @Autowired
    DoingService doingService;
    @Autowired
    UserService userService;


    @GetMapping(value = "/Doing/version", name = "What Is Steve Doing/上传和获取你目前的状态。")
    public String doingVersion(Model model) {
        return UI.JumpAPI(200, gson.toJson(new BaseMsg(200, DoingServiceImpl.version.toString())), model);
    }

    @PostMapping("/Doing/set")
    public String updateDoing(int id, String key, String json, Model model) {
        try {
            // 验证 key
            String back = doingService.verifyKey(id, key, "set");
            if (back.equals("true")) {
                // 保存 Doing 数据
                doingService.saveDoing(id, json);
                return UI.JumpAPI(200, gson.toJson(new BaseMsg(200, "操作成功！")), model);
            } else {
                return UI.JumpAPI(403, gson.toJson(new BaseMsg(403, back)), model);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return UI.JumpAPI(500, gson.toJson(new BaseMsg(500, e.getMessage())), model);
        }
    }

    @GetMapping("/Doing/get/{key}")
    public String getDoing(@PathVariable String key, Model model) {
        try {
            UserKey ukey = userService.getKeyInfo(key);
            if (ukey != null) {
                int id = ukey.getUser_id();
                // 验证 key
                String back = doingService.verifyKey(id, key, "get");
                if(back.equals("true")) {
                    // 获取 Doing
                    DoingMsg[] msgs = doingService.getDoing(id);
                    for(DoingMsg msg : msgs) {
                        msg.setUser_id(-1);
                    }
                    return UI.JumpAPI(200, gson.toJson(msgs), model);
                } else {
                    return UI.JumpAPI(403, gson.toJson(new BaseMsg(403, back)), model);
                }
            } else {
                return UI.JumpAPI(404, gson.toJson(new BaseMsg(404, "Key 不存在！")), model);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return UI.JumpAPI(500, gson.toJson(new BaseMsg(500, e.getMessage())), model);
        }
    }
}
