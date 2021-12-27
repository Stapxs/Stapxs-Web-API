package cn.stapxs.api.service.impl;

import cn.stapxs.api.dao.DoingDao;
import cn.stapxs.api.domain.tool.DoingMsg;
import cn.stapxs.api.domain.user.UserKey;
import cn.stapxs.api.service.DoingService;
import cn.stapxs.api.service.UserService;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Version: 1.0
 * @Date: 2021/12/26 19:25
 * @ClassName: DoingServiceImpl
 * @Author: Stapxs
 * @Description TO DO
 **/
@Service
public class DoingServiceImpl implements DoingService {

    @Autowired
    UserService userService;

    @Autowired
    DoingDao doingDao;

    public static Double version = 1.0;

    private final static Gson gson = new Gson();
    private final static String[] allowPlatform = new String[] {
      "Windows",
      "Android",
      "Linux"
    };

    /**
     * @Author Stapxs
     * @Description 验证 key 是否可用
     * @Date 20:05 2021/12/26
     * @Param [key]
     * @return boolean
    **/
    @Override
    public String verifyKey(int id, String key, String use) {
        // 验证 key 是否为用户所有
        boolean passKey = false;
        UserKey[] keys = userService.getKey(id);
        for (UserKey ukey : keys) {
            if(ukey.getKey_value().equals(key)) {
                passKey = true;
                break;
            }
        }
        if(!passKey) {
            return "验证 Key 有效性错误！";
        }
        // 验证 key 是否有权进行操作
        String set = doingDao.getDpingSet(id);
        String[] setList = set.split("\\|");
        if(setList.length != 3) {
            return "请进入 /Doing 界面进行初始化设置！";
        }
        switch (use) {
            case "set": {
                String setKey = "";
                for (UserKey ukey : keys) {
                    if(ukey.getKey_id() == Integer.parseInt(setList[1])) {
                        setKey = ukey.getKey_value();
                        break;
                    }
                }
                if(!setKey.equals("")) {
                    return Boolean.toString(setKey.equals(key));
                } else {
                    return "未知错误（key 不存在）";
                }
            }
            case "get": {
                String setKey = "";
                for (UserKey ukey : keys) {
                    if(ukey.getKey_id() == Integer.parseInt(setList[0])) {
                        setKey = ukey.getKey_value();
                        break;
                    }
                }
                if(!setKey.equals("")) {
                    return Boolean.toString(setKey.equals(key));
                } else {
                    return "未知错误（key 不存在）";
                }
            }
        }
        return "未知操作。";
    }

    @Override
    public boolean saveDoing(int id, String json) {
        // 序列化 json
        DoingMsg doing = gson.fromJson(json, DoingMsg.class);
        // 检查数据
        if(!doing.getDoing().equals("") && !doing.getName_platform().equals("")) {
            boolean isInAllow = false;
            for (String allow : allowPlatform) {
                if(allow.equals(doing.getName_platform())) {
                    isInAllow = true;
                    break;
                }
            }
            if(isInAllow) {
                // 检查数据是否存在
                DoingMsg doingMsg = doingDao.getDoing(id, doing.getName_platform());
                if(doingMsg != null) {
                    // 更新数据
                    doing.setUser_id(id);
                    doingDao.updateDoing(doing);
                } else {
                    // 添加数据
                    doing.setUser_id(id);
                    doingDao.newDoing(doing);
                }
                return true;
            }
        }

        return false;
    }

    @Override
    public DoingMsg[] getDoing(int id) {
        return doingDao.getAllDoing(id);
    }
}
