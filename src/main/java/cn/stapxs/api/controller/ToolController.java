package cn.stapxs.api.controller;

import cn.stapxs.api.domain.msg.BaseMsg;
import cn.stapxs.api.service.MCService;
import cn.stapxs.api.service.NetEaseService;
import cn.stapxs.api.util.Number;
import cn.stapxs.api.util.ServerListPing17;
import cn.stapxs.api.util.UI;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.io.IOException;
import java.net.*;
import java.util.Optional;

/**
 * @Version: 1.0
 * @Date: 2021/9/11 下午 6:39
 * @ClassName: ToolController
 * @Author: Stapxs
 * @Description TO DO
 **/
@Controller
public class ToolController {

    private static final Gson gson = new Gson();

    @Autowired
    MCService mcService;

    @Autowired
    NetEaseService netEaseService;

    @GetMapping(value = {"/MC-Sever/{address}/", "/MC-Sever/{address}/{type}"}, name = "Minecraft 服务器信息获取/获取 MC 服务器基础信息，包括标题、玩家、PING 等。")
    public String getMCSInfo(@PathVariable Optional<String> type, @PathVariable String address, Model model) {
        System.out.println(address);
        try {
            // 初始化数据
            String add = "";
            int pot = 25565;
            if (address.indexOf(":") > 0) {
                add = address.split(":")[0];
                pot = Number.isInteger(address.split(":")[1]) ? Integer.parseInt(address.split(":")[1]) : 25565;
            } else {
                add = address;
            }
            // 请求服务器
            InetSocketAddress socket = null;
            if (!add.equals("")) {
                socket = new InetSocketAddress(InetAddress.getByName(add), pot);
                ServerListPing17 ping = new ServerListPing17();
                ping.setAddress(socket);
                String response = ping.fetchData();
                if(type.isPresent()) {
                    switch (type.get()) {
                        case "json": {
                            return UI.JumpAPI(200, response, model);
                        }
                        case "view": {
                            break;
                        }
                        default: {
                            model.addAttribute("str", response);
                            return "tool/MC-Server";
                        }
                    }
                } else {
                    model.addAttribute("str", response);
                    return "tool/MC-Server";
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            return mcService.MCInfoErr(type, e.getMessage(), model);
        }
        return UI.JumpError(400, model);
    }

    @GetMapping(value = {"/NetEase/{type}/{id}"}, name = "网易云音乐解析/获取网易云音乐音乐直链以及乐曲相关信息。")
    public String getNetEast(@PathVariable String type, @PathVariable String id, Model model) {
        if(!Number.isInteger(id)) {
            return UI.JumpAPI(400, gson.toJson(new BaseMsg(400, "非法 ID")), model);
        }
        System.out.println(id + " / " + type);
        if(!netEaseService.setInfo(type, id)) {
            return UI.JumpAPI(400, gson.toJson(new BaseMsg(400, "非法类型")), model);
        }
        String back = netEaseService.getJson();
        return "api";
    }
}
