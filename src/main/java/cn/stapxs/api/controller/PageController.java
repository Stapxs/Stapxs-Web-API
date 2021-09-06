package cn.stapxs.api.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * @Version: 1.0
 * @Date: 2021/9/1 下午 4:54
 * @ClassName: PageController
 * @Author: Stapxs
 * @Description TO DO
 **/

@Controller
public class PageController {
    @RequestMapping("/")
    public String index() { return "index"; }
    @RequestMapping("List")
    public String List() { return "list"; }
    @RequestMapping("Doc")
    public String Doc() { return "doc"; }

    @RequestMapping("SS-Ana")
    public String SSAna(String id, Model model) {
        model.addAttribute("title", "林槐语录");
        model.addAttribute("id", id);
        return "SS-Ana";
    }
}
