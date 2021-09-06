package cn.stapxs.api.controller;

import cn.stapxs.api.domain.ApiInfo;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.mvc.method.RequestMappingInfo;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @Version: 1.0
 * @Date: 2021/9/4 下午 6:21
 * @ClassName: InfoController
 * @Author: Stapxs
 * @Description TO DO 应用程序和接口信息相关
 **/
@Controller
public class InfoController {

    private static final Gson gson = new Gson();

    @Autowired
    private RequestMappingHandlerMapping requestMappingHandlerMapping;

    /**
     * @Author Stapxs
     * @Description 获取所有有效的 API 接口信息
     * @Date 下午 8:32 2021/9/4
     * @Param [model]
     * @return java.lang.String
    **/
    @RequestMapping("/sys/getInfo")
    public String getAllUrl(Model model) {
        Map<RequestMappingInfo, HandlerMethod> map = requestMappingHandlerMapping.getHandlerMethods();
        List<ApiInfo.info> text = new ArrayList<>();
        List<ApiInfo.info> pic = new ArrayList<>();
        List<ApiInfo.info> tool = new ArrayList<>();
        List<ApiInfo.info> other = new ArrayList<>();
        for (Map.Entry<RequestMappingInfo, HandlerMethod> m : map.entrySet()) {
            RequestMappingInfo info = m.getKey();
            HandlerMethod method = m.getValue();
            String className = method.getMethod().getDeclaringClass().toString();
            String packageName = className.substring(className.lastIndexOf('.') + 1);
            switch (packageName) {
                case "TextController" : {
                    if(info.getName() != null) {
                        text.add(new ApiInfo.info(info.getName().split("/")[0], info.getName().split("/")[1], info.getPatternsCondition().toString()));
                    }
                } break;
                case "PicController" : {
                    if(info.getName() != null) {
                        pic.add(new ApiInfo.info(info.getName().split("/")[0], info.getName().split("/")[1], info.getPatternsCondition().toString()));
                    }
                } break;
                case "ToolController" : {
                    if(info.getName() != null) {
                        tool.add(new ApiInfo.info(info.getName().split("/")[0], info.getName().split("/")[1], info.getPatternsCondition().toString()));
                    }
                } break;
                case "OtherController" : {
                    if(info.getName() != null) {
                        other.add(new ApiInfo.info(info.getName().split("/")[0], info.getName().split("/")[1], info.getPatternsCondition().toString()));
                    }
                } break;
            }
        }
        ApiInfo apis = new ApiInfo();
        apis.setText(text);
        apis.setPic(pic);
        apis.setTool(tool);
        apis.setOther(other);

        String json = gson.toJson(apis);
        model.addAttribute("stat", "200");
        model.addAttribute("str", json);

        return "api";
    }
}
