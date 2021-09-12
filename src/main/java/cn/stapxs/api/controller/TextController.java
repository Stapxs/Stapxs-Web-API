package cn.stapxs.api.controller;

import cn.stapxs.api.appInfo;
import cn.stapxs.api.domain.msg.AnaMsg;
import cn.stapxs.api.domain.msg.BaseMsg;
import cn.stapxs.api.service.AnaService;
import cn.stapxs.api.util.Number;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Enumeration;
import java.util.Optional;

/**
 * @Version: 1.0
 * @Date: 2021/9/1 下午 10:03
 * @ClassName: AnasController
 * @Author: Stapxs
 * @Description TO DO
 **/
@Controller
public class TextController {

    private static final Gson gson = new Gson();

    @Autowired
    AnaService anaService;

    @GetMapping(value = {"/SS-Ana/{type}", "/SS-Ana/{type}/{id}"}, name = "林槐语录/获取林槐语录（负能量警告）。")
    public String getSSAna(@PathVariable Optional<Integer> id, @PathVariable Optional<String> type, Model model, HttpServletRequest request) throws IOException {
        // 兼容旧访问方式（非 RESTful 的 Get 方式）
        if(type.isPresent() && type.get().equals("Get")) {
            Enumeration names = request.getParameterNames();
            while(names.hasMoreElements()){
                String name = (String) names.nextElement();
                String value = request.getParameter(name);
                if(name.equals("id")) {
                    id = Optional.of(Integer.parseInt(value));
                }
                if(name.equals("type")) {
                    type =  Optional.of(value);
                }
            }
            if(type.get().equals("Get")) {
                type = Optional.of("txt");
            }
        }
        // 处理
        String SSAnaFile = appInfo.root + "Anas/SS.txt";
        AnaMsg ana = null;
        /*
         * 如果 type 不是 json / txt 并且是数字就直接显示为主页
         * 其他情况正常请求
        **/
        if(type.isPresent()) {
            switch (type.get()) {
                case "json" :
                case "txt" : {
                    if(id.isPresent()) {
                        ana = anaService.getAna(SSAnaFile, id.get());
                    } else {
                        ana = anaService.getAna(SSAnaFile);
                    }
                    // 输出 API
                    if(ana != null) {
                        model.addAttribute("stat", "200");
                        if(type.get().equals("json")) {
                            String jsonObject = gson.toJson(ana);
                            model.addAttribute("str", jsonObject);
                        } else {
                            model.addAttribute("str", ana.getAna());
                        }
                    } else {
                        model.addAttribute("stat", "404");
                        if(type.get().equals("json")) {
                            model.addAttribute("str", gson.toJson(new BaseMsg(404, "未找到指定语录！")));
                        } else {
                            model.addAttribute("str", "未找到指定语录！");
                        }
                    }
                    return "api";
                }
                case "view": {
                    break;
                }
                default: {
                    if(Number.isInteger(type.get())) {
                        // 返回主页
                        ana = anaService.getAna(SSAnaFile, Integer.parseInt(type.get()));
                        model.addAttribute("title", "林槐语录");
                        model.addAttribute("id", String.valueOf(ana.getId()));
                        model.addAttribute("ana", ana.getAna());
                        return "tool/SS-Ana";
                    }
                }
            }
        }
        // 返回 400
        model.addAttribute("stat", "400");
        model.addAttribute("str", "调用方式错误！");
        model.addAttribute("show", true);
        return "api";
    }
}
