package cn.stapxs.api.service.impl;

import cn.stapxs.api.domain.msg.BaseMsg;
import cn.stapxs.api.service.NetEaseService;
import cn.stapxs.api.util.NetWork;
import cn.stapxs.api.util.UI;
import org.springframework.stereotype.Service;

/**
 * @Version: 1.0
 * @Date: 2021/9/17 上午 11:19
 * @ClassName: NetEaseImpl
 * @Author: Stapxs
 * @Description TO DO
 **/
@Service
public class NetEaseImpl implements NetEaseService {

    private String url = "";
    private String type = "";
    private String id = "";

    @Override
    public String getJson() {
        String json = sendUrl();
        System.out.println(json);
        return null;
    }

    @Override
    public boolean setInfo(String type, String id) {
        this.type = type;
        this.id = id;
        switch (type) {
            case "song": {
                this.url = "http://music.163.com/api/song/detail/?ids=[" + id + "]";
            }
            case "album": {
                this.url = "http://music.163.com/api/album/" + id +"?id=" + id;
                break;
            }
            case "artist": {
                this.url = "http://music.163.com/api/artist/" + id + "?id=" + id;
                break;
            }
            case "list": {
                this.url = "http://music.163.com/api/playlist/detail?id=" + id;
                break;
            }
            default: return false;
        }
        return true;
    }

    // ----------------------------------------------------------------------------

    private String sendUrl() {
        return null;
//        String json = NetWork.get(this.url, "Cookie:appver=2.0.2");
//        if(json.contains("\"songs\":[]")) {
//            return "Err";
//        }
//        return json;
    }
}
