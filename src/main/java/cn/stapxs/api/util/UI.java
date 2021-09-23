package cn.stapxs.api.util;

import cn.stapxs.api.domain.msg.BaseMsg;
import com.google.gson.Gson;
import org.springframework.ui.Model;

/**
 * @Version: 1.0
 * @Date: 2021/9/12 下午 2:14
 * @ClassName: UI
 * @Author: Stapxs
 * @Description TO DO
 **/
public class UI {

    private static final Gson gson = new Gson();

    public static String JumpError(int code, String str, Model model) {
        model.addAttribute("inn", true);
        model.addAttribute("code", String.valueOf(code));
        switch (code) {
            case 500:
            case 400:
            case 404: {
                if(str != null) {
                    model.addAttribute("str", str);
                }
                break;
            }
        }
        return "err/error";
    }

    public static String JumpError(int code, Model model) {
        return JumpError(code, null, model);
    }

    public static String JumpAPI(int code, String str, Model model) {
        model.addAttribute("stat", String.valueOf(code));
        switch (code) {
            case 400:
            case 403:
            case 404:
            case 302:
            case 200: {
                model.addAttribute("str", str);
                break;
            }
            case 500: {
                model.addAttribute("str", gson.toJson(new BaseMsg(500, str)));
                break;
            }
        }
        return "api";
    }
}
