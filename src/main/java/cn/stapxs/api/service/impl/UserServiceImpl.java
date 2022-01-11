package cn.stapxs.api.service.impl;

import cn.stapxs.api.dao.UserDao;
import cn.stapxs.api.domain.user.UserBase;
import cn.stapxs.api.domain.user.UserInfo;
import cn.stapxs.api.domain.user.UserKey;
import cn.stapxs.api.service.UserService;
import cn.stapxs.api.util.RSAEncrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.security.NoSuchAlgorithmException;
import java.util.Date;
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

    @Override
    public UserInfo getUserInfoByID(int id) {
        System.out.println("操作 > 获取用户信息 > findUserInfoByID > " + id);
        Optional<UserInfo> infoOptional = Optional.ofNullable(userDao.getUserInfoByID(id));
        return infoOptional.orElse(null);
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
        return verifyLogin(id, token, false);
    }

    @Override
    public boolean verifyLogin(int id, String token, boolean isBase) {
        System.out.println("操作 > 验证登陆 > verifyLogin > " + id + "/" + token);
        Optional<UserBase> user = Optional.ofNullable(getUserByID(id));
        if(user.isPresent()) {
            // 验证 token 有效性
            if (user.get().getUser_token().equals(token)) {
                long time = Long.parseLong(token.substring(0, 5) + token.substring(token.length() - 7, token.length() - 2));
                long now = System.currentTimeMillis() / 1000;
                // 判断 token 是否过期
                if(time + 1800 > now) {
                    if(isBase) {
                        System.out.println("操作 > 验证登陆（基础） > verifyLogin > 成功");
                        return true;
                    } else {
                        // 验证邮箱验证是否通过
                        int statue = userDao.getMailStatus(id);
                        if(statue != 0) {
                            System.out.println("操作 > 验证登陆（严格） > verifyLogin > 成功");
                            return true;
                        } else {
                            System.out.println("操作 > 验证登陆 > verifyLogin > 未验证邮箱");
                            return false;
                        }
                    }
                }
            } else {
                System.out.println("操作 > 验证登陆 > verifyLogin > token 无效");
            }
        }
        System.out.println("操作 > 验证登陆 > verifyLogin > 失败");
        return false;
    }

    @Override
    public void updateLoginInfo(int id, String ip) {
        userDao.setLoginInfo(id, ip);
        // TODO 记得在注册的时候新建 info 表项
    }

    @Override
    public void loginOut(int id) {
        userDao.delUserToken(id);
    }

    @Override
    public boolean createKey(int id) {
        // 获取 key 列表
        UserKey[] keys = userDao.getUserKey(id);
        if(keys.length < 5) {
            // 生成 UUID
            String key = UUID.randomUUID().toString();
            key = key.replace("-", "");
            // 保存 key
            userDao.createKey(id, keys.length + 1, key);
            return true;
        }
        return false;
    }

    @Override
    public UserKey[] getKey(int id) {
        return userDao.getUserKey(id);
    }

    @Override
    public UserKey getKeyInfo(String key) {
        return userDao.getKeyInfo(key);
    }

    @Override
    public void deleteKey(int id, int num) {
        userDao.deleteKet(id, num);
    }

    @Override
    public void updateKeyName(int id, int num, String str) {
        userDao.updateKeyName(id, num, str);
    }

    @Override
    public void updateCode(int id, String code) {
        // 计算过期时间
        Date endDate = new Date(new Date().getTime() + 300000);
        // 保存数据
        userDao.updateCode(id, code, endDate);
    }

    @Override
    public String verifyCode(int id, String code) {
        UserBase base = userDao.getUserByID(id);
        // 验证是否过期
        if(base.getCode_time().after(new Date())) {
            // 比较验证码
            if(base.getLast_code().equals(code)) {
                return "OK";
            } else {
                return "验证码错误！";
            }
        } else {
            return "验证码超时！";
        }
    }

    @Override
    public void updateMail(int id, String mail) {
        userDao.updateUserMail(id, mail);
    }

    @Override
    public void updateMailState(int id, boolean state) {
        int status = state ? 1 : 0;
        userDao.updateUserMailStatue(id, status);
    }

    @Override
    public String getNick(int id) {
        return userDao.getUserNick(id);
    }
}
