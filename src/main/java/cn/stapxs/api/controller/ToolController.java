package cn.stapxs.api.controller;

import cn.stapxs.api.domain.msg.BaseMsg;
import cn.stapxs.api.util.Number;
import cn.stapxs.api.util.ServerListPing17;
import com.google.gson.Gson;
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

    @GetMapping(value = {"/MC-Sever/{address}/", "/MC-Sever/{address}/{type}"}, name = "Minecraft 服务器信息获取/获取 MC 服务器基础信息，包括标题、玩家、PING 等。")
    public String getMCSInfo(@PathVariable Optional<String> type, @PathVariable String address, Model model) {
        System.out.println(address);
        try {
            String add = "";
            int pot = 25565;
            if (address.indexOf(":") > 0) {
                add = address.split(":")[0];
                pot = Number.isInteger(address.split(":")[1]) ? Integer.parseInt(address.split(":")[1]) : 25565;
            } else {
                add = address;
            }
            InetSocketAddress socket = null;
            if (!add.equals("")) {
                socket = new InetSocketAddress(InetAddress.getByName(add), pot);
                ServerListPing17 ping = new ServerListPing17();
                ping.setAddress(socket);
                String response = ping.fetchData();
                if(type.isPresent()) {
                    switch (type.get()) {
                        case "json": {
                            model.addAttribute("stat", "200");
                            model.addAttribute("str", response);
                            break;
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
        } catch (UnknownHostException e) {
            if (type.isPresent()) {
                e.printStackTrace();
                switch (type.get()) {
                    case "json": {
                        model.addAttribute("stat", "500");
                        model.addAttribute("str", gson.toJson(new BaseMsg(500, "无法解析 IP / 域名！")));
                        break;
                    }
                    case "view": {
                        break;
                    }
                    default: {
                        model.addAttribute("inn", true);
                        model.addAttribute("code", "500");
                        model.addAttribute("str", "无法解析 IP / 域名！");
                        return "err/error";
                    }
                }
            } else {
                model.addAttribute("inn", true);
                model.addAttribute("code", "500");
                model.addAttribute("str", "无法解析 IP / 域名！");
                return "err/error";
            }
        } catch (IOException e){
            e.printStackTrace();
            if (type.isPresent()) {
                switch (type.get()) {
                    case "json": {
                        model.addAttribute("stat", "500");
                        model.addAttribute("str", gson.toJson(new BaseMsg(500, e.getMessage())));
                        break;
                    }
                    case "view": {
                        break;
                    }
                    default: {
                        model.addAttribute("inn", true);
                        model.addAttribute("code", "500");
                        model.addAttribute("str", e.getMessage());
                        return "err/error";
                    }
                }
            } else {
                model.addAttribute("inn", true);
                model.addAttribute("code", "500");
                model.addAttribute("str", e.getMessage());
                return "err/error";
            }
        }
        return "api";
    }
}
