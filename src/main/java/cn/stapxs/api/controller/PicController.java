package cn.stapxs.api.controller;

import cn.stapxs.api.appInfo;
import cn.stapxs.api.domain.BaseClass;
import cn.stapxs.api.domain.BingPicInfo;
import cn.stapxs.api.domain.msg.BaseMsg;
import cn.stapxs.api.service.BingPicService;
import cn.stapxs.api.util.Number;
import cn.stapxs.api.util.UI;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.apache.poi.util.IOUtils;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.*;

/**
 * @Version: 1.0
 * @Date: 2021/9/2 下午 7:19
 * @ClassName: PicController
 * @Author: Stapxs
 * @Description TO DO
 **/
@Controller
public class PicController {

    @Autowired
    BingPicService bingPicService;

    @GetMapping(value = {"/BingPic", "/BingPic/{size}", "/BingPic/{size}/{day}"}, name = "Bing 每日一图获取/获取 Bing 每日一图，支持获取本周内的任何一张。")
    public String bingPic(@PathVariable Optional<String> day, @PathVariable Optional<String> size, Model model) {
        int dayInt = 0;
        if(day.isPresent() && Number.isInteger(day.get())) {
            dayInt = Integer.parseInt(day.get());
        } else {
            Random random = new Random();
            int s = random.nextInt(9);
            if(s == 8) s = -1;
            dayInt = s;
        }
        if(!size.isPresent()) size = Optional.of("1920x1080");
        BingPicInfo pic = bingPicService.getInfo(dayInt);
        String baseUrl = "https://www.bing.com" + pic.getUrlbase();
        String url = baseUrl + "_" + size.get() + ".jpg";
        return UI.JumpAPI(302, url, model);
    }

    @GetMapping(value = {"/PicLib", "/PicLib/{lib}", "/PicLib/{lib}/{type}"}, name = "林槐图片库/获取 SS 收集在库的一些图片。")
    public String ssPicLib(@PathVariable Optional<String> type, @PathVariable Optional<String> lib, Model model, HttpServletResponse response) throws IOException {
        String picRoot = appInfo.root + "Pics";
        List<BaseClass> allType = new ArrayList<>();
        if(!lib.isPresent()) {
            // 返回全部的库名
            File file = new File(picRoot);
            File[] files = file.listFiles();
            int i = 0;
            if (files != null) {
                for (File f: files) {
                    if(f.isDirectory()) {
                        allType.add(new BaseClass(i, f.getName()));
                        i ++;
                    }
                }
            }
            return UI.JumpAPI(200, new Gson().toJson(allType), model);
        } else {
            // 抽取图片
            File file = new File(picRoot + "/" + lib.get());
            if(file.exists()) {
                File[] files = file.listFiles();
                Random random = new Random();
                if(files != null && files.length > 0) {
                    String name = files[random.nextInt(files.length)].getName();
                    FileInputStream fis = new FileInputStream(file + "/" + name);
                    response.setContentType("image/jpg");
                    response.setHeader("Access-Control-Allow-Origin", "*");
                    IOUtils.copy(fis, response.getOutputStream());
                    return null;
                } else {
                    if(type.isPresent() && type.get().equals("json")) {
                        return UI.JumpAPI(404, new Gson().toJson(new BaseMsg(404, "此存储库没有图片。")), model);
                    } else {
                        return UI.JumpError(404, "此存储库没有图片", model);
                    }
                }
            } else {
                if(type.isPresent() && type.get().equals("json")) {
                    return UI.JumpAPI(404, new Gson().toJson(new BaseMsg(404, "此存储库不存在。")), model);
                } else {
                    return UI.JumpError(404, "此存储库不存在", model);
                }
            }
        }
    }
}
