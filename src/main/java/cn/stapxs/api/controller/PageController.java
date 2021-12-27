package cn.stapxs.api.controller;

import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

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
    @RequestMapping("About")
    public String About() { return "about"; }
    @RequestMapping("Account")
    public String Account() { return "account"; }
    @RequestMapping("Center")
    public String Center() { return "center"; }

    @RequestMapping("SS-Ana")
    public String SSAna(String id, Model model) {
        model.addAttribute("id", id);
        return "tool/SS-Ana";
    }
    @RequestMapping("Doing")
    public String SteveDoing() {
        return "tool/Steve-Doing";
    }

    @RequestMapping("Error")
    public String Error(boolean debug, Model model) {
        model.addAttribute("debug", debug);
        return "err/error";
    }
}
