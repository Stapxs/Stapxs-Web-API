package cn.stapxs.api.service.impl;

import cn.stapxs.api.domain.BingPicInfo;
import cn.stapxs.api.service.BingPicService;
import cn.stapxs.api.util.NetWork;
import com.google.gson.Gson;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @Version: 1.0
 * @Date: 2021/9/2 下午 7:24
 * @ClassName: BingPicServiceImpl
 * @Author: Stapxs
 * @Description TO DO
 **/
@Service
@Transactional
public class BingPicServiceImpl implements BingPicService {
    @Override
    public BingPicInfo getInfo(int day) {
        String json = NetWork.get("https://www.bing.com/HPImageArchive.aspx?format=js&idx=" + day +"&n=1", "UTF-8");
        json = "{" + json.substring(json.indexOf("\"startdate\""));
        json = json.substring(0, json.indexOf("\"title\"") - 1) + "}";
        Gson gson = new Gson();
        return gson.fromJson(json, BingPicInfo.class);
    }
}
