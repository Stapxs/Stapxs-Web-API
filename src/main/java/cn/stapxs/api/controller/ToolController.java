package cn.stapxs.api.controller;

import cn.stapxs.api.domain.msg.BaseMsg;
import cn.stapxs.api.service.MCService;
import cn.stapxs.api.util.Network;
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
import java.util.*;

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

    @GetMapping(value = {"/Page-Info"}, name = "链接预览/获取页面的 The Open Graph protocol 媒体信息。")
    public String getPageInfo(String address, Model model) {
        try {
            // 获取页面 html
            String pageHTML = Network.get(address, "UTF-8");
            if(pageHTML.indexOf("<meta") > 0) {
                // 拆分 html
                String html = pageHTML.substring(pageHTML.indexOf("<head>") + 6, pageHTML.indexOf("</head>"));
                // 获取 meta 条目
                List<String> metaList = new ArrayList<>();
                while (html.contains("<meta")) {
                    String meta = html.substring(html.indexOf("<meta"), html.indexOf(">", html.indexOf("<meta") + 5) + 1);
                    html = html.replace(meta, "");
                    metaList.add(meta);
                }
                // 获取 meta 属性
                Map<String, String> backInfo = new HashMap<>();
                for (String meta : metaList) {
                    String name = meta.substring(meta.indexOf("property=\"") + 10, meta.indexOf("\"", meta.indexOf("property=\"") + 10));
                    String content = meta.substring(meta.indexOf("content=\"") + 9, meta.indexOf("\"", meta.indexOf("content=\"") + 9));
                    if (name.indexOf("og:") == 0) {
                        backInfo.put(name, content);
                    }
                }
                // 返回信息
                return UI.JumpAPI(200, gson.toJson(backInfo), model);
            } else {
                return UI.JumpAPI(404, new Gson().toJson(new BaseMsg(500, "获取失败，可能是请求超时或页面没有媒体信息。")), model);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return UI.JumpError(503, e.getMessage(), model);
        }
    }
}
