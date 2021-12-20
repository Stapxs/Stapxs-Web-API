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
    public UserBase getUserByName(String name);
    public UserBase getUserByID(int id);

    public UserInfo getUserInfoByID(int id);
    public String getNick(int id);

    public String getASaveLoginRSA(int id) throws NoSuchAlgorithmException;
    public void delLoginRSA(int id);
    public void saveToken(int id, String token);
    public boolean verifyLogin(int id, String token);

    public void updateLoginInfo(int id, String ip);

    public boolean createKey(int id);
    public UserKey[] getKey(int id);
    public void deleteKey(int id, int num);
}
