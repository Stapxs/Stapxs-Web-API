package cn.stapxs.api.service;

import cn.stapxs.api.domain.user.UserBase;
import cn.stapxs.api.domain.user.UserInfo;
import cn.stapxs.api.domain.user.UserKey;
import org.springframework.stereotype.Service;

import java.security.NoSuchAlgorithmException;

/**
 * @Version: 1.0
 * @Date: 2021/9/22 下午 5:27
 * @ClassName: UserService
 * @Author: Stapxs
 * @Description TO DO
 **/
public interface UserService {
    // 获取用户
    public UserBase getUserByName(String name);
    public UserBase getUserByID(int id);
    // 获取用户基本信息
    public UserInfo getUserInfoByID(int id);
    public String getNick(int id);
    // 登录相关
    public String getASaveLoginRSA(int id) throws NoSuchAlgorithmException;
    public void delLoginRSA(int id);
    public void saveToken(int id, String token);
    public boolean verifyLogin(int id, String token);
    public boolean verifyLogin(int id, String token, boolean isBase);
    public void updateLoginInfo(int id, String ip);
    // 登出相关
    public void loginOut(int id);
    // 用户识别 Key 相关
    public boolean createKey(int id);
    public UserKey[] getKey(int id);
    public UserKey getKeyInfo(String key);
    public void deleteKey(int id, int num);
    public void updateKeyName(int id, int num, String str);
    // 用户验证相关
    public void updateCode(int id, String code);
    public String verifyCode(int id, String code);
    // 用户邮箱相关
    public void updateMail(int id, String mail);
    public void updateMailState(int id, boolean state);
}
