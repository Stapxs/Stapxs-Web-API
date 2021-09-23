package cn.stapxs.api.service.impl;

import cn.stapxs.api.dao.UserDao;
import cn.stapxs.api.domain.user.UserBase;
import cn.stapxs.api.service.UserService;
import cn.stapxs.api.util.RSAEncrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.security.NoSuchAlgorithmException;
import java.util.Optional;
import java.util.UUID;

/**
 * @Version: 1.0
 * @Date: 2021/9/22 下午 5:27
 * @ClassName: UserServiceImpl
 * @Author: Stapxs
 * @Description TO DO
 **/
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserDao userDao;

    @Override
    public UserBase getUserByName(String name) {
        System.out.println("操作 > 获取用户 > findUserByName > " + name);
        Optional<UserBase> userOptional = Optional.ofNullable(userDao.getUserByName(name));
        return userOptional.orElse(null);
    }

    @Override
    public UserBase getUserByID(int id) {
        System.out.println("操作 > 获取用户 > findUserByID > " + id);
        Optional<UserBase> userOptional = Optional.ofNullable(userDao.getUserByID(id));
        return userOptional.orElse(null);
    }

    /**
     * @Author Stapxs
     * @Description 生成密钥对
     * @Date 下午 6:41 2021/9/22
     * @Param [id]
     * @return java.lang.String
    **/
    @Override
    public String getASaveLoginRSA(int id) throws NoSuchAlgorithmException {
        System.out.println("操作 > 获取保存登录公钥 > getASaveLoginRSA > " + id);
        // 生成钥匙对
        RSAEncrypt encrypt = new RSAEncrypt();
        encrypt.genKeyPair();
        // 保存私钥
        userDao.setLoginKey(encrypt.getKeyMap().get(1), id);
        // 返回公钥
        return encrypt.getKeyMap().get(0);
    }

    @Override
    public void delLoginRSA(int id) {
        System.out.println("操作 > 删除登录公钥 > delLoginRSA > " + id);
        userDao.setLoginKey(null, id);
    }

    @Override
    public void saveToken(int id, String token) {
        System.out.println("操作 > 保存 token > saveToken > " + id + "/" + token);
        userDao.setUserToken(token, id);
    }

    @Override
    public boolean verifyLogin(int id, String token) {
        System.out.println("操作 > 验证登陆 > verifyLogin > " + id + "/" + token);
        Optional<UserBase> user = Optional.ofNullable(getUserByID(id));
        if(user.isPresent()) {
                // 验证 token 有效性
                if (user.get().getUser_token().equals(token)) {
                    long time = Long.parseLong(token.substring(0, 5) + token.substring(token.length() - 7, token.length() - 2));
                    long now = System.currentTimeMillis() / 1000;
                    // 判断 token 是否过期
                    if(time + 1800 > now) {
                        System.out.println("操作 > 验证登陆 > verifyLogin > 成功");
                        return true;
                    }
                } else {
                    System.out.println("操作 > 验证登陆 > verifyLogin > token 无效");
                }
        }
        System.out.println("操作 > 验证登陆 > verifyLogin > 失败");
        return false;
    }
}
