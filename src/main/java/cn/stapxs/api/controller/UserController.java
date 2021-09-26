package cn.stapxs.api.controller;

import cn.stapxs.api.domain.msg.BaseMsg;
import cn.stapxs.api.domain.user.KeyInfo;
import cn.stapxs.api.domain.user.UserBase;
import cn.stapxs.api.service.UserService;
import cn.stapxs.api.util.PBKDF2;
import cn.stapxs.api.util.RSAEncrypt;
import cn.stapxs.api.util.UI;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.crypto.BadPaddingException;
import java.security.NoSuchAlgorithmException;
import java.util.Optional;

/**
 * @Version: 1.0
 * @Date: 2021/9/22 下午 5:28
 * @ClassName: UserController
 * @Author: Stapxs
 * @Description TODO 暂时不支持多平台登录，token 已预留平台识别号
 **/

@Controller
public class UserController {

    private static final Gson gson = new Gson();

    @Autowired
    UserService userService;

    @GetMapping("/acc/getKey/{name}")
    public String getKey(@PathVariable String name, Model model) throws NoSuchAlgorithmException {
        Optional<UserBase> user = Optional.ofNullable(userService.getUserByName(name));
        if (user.isPresent()) {
            String back = gson.toJson(
                    new KeyInfo(
                            user.get().getUser_id(),
                            userService.getASaveLoginRSA(user.get().getUser_id())
                    )
            );
            return UI.JumpAPI(200, back.replace("\\u003d", "="), model);
        }
        return UI.JumpAPI(404, gson.toJson(new BaseMsg(404, "没有找到这个账号！")), model);
    }

    @PostMapping("/acc/loginAcc")
    public String loginAcc(int id, String str, Model model) {
        System.out.println("操作 > 登陆账号 > loginAcc > " + id + " / " + str);
        str = str.replace(" ", "+");
        Optional<UserBase> user = Optional.ofNullable(userService.getUserByID(id));
        if(user.isPresent()) {
            boolean passLogin = false;
            // 解密
            try {
                RSAEncrypt encrypt = new RSAEncrypt();
                str = encrypt.decrypt(str, user.get().getLogin_key());
                // 验证密码
                PBKDF2 pbkdf2 = new PBKDF2(32, 64, 30000);
                passLogin = pbkdf2.verify(str, user.get().getUser_password());
            } catch (BadPaddingException be) {
                be.printStackTrace();
                // RSA 解密失败
                return UI.JumpAPI(403, gson.toJson(new BaseMsg(403, "账号或密码无效")), model);
            } catch (NullPointerException ne) {
                // 未申请公钥
                return UI.JumpAPI(403, gson.toJson(new BaseMsg(403, "无效的登陆操作")), model);
            } catch (Exception ex) {
                ex.printStackTrace();
                // 其他错误
                return UI.JumpAPI(500, "账号或密码无效", model);
            }
            // 后续流程
            if(passLogin) {
                // 删除私钥
                userService.delLoginRSA(user.get().getUser_id());
                // 生成返回 token
                String back = gson.toJson(
                        new KeyInfo(
                                user.get().getUser_id(),
                                user.get().getToken()
                        )
                );
                // 保存 token
                userService.saveToken(user.get().getUser_id(), user.get().getUser_token());
                return UI.JumpAPI(200, back, model);
            } else {
                return UI.JumpAPI(403, gson.toJson(new BaseMsg(403, "账号或密码错误")), model);
            }
        } else {
            return UI.JumpAPI(404, gson.toJson(new BaseMsg(404, "没有找到这个账号！")), model);
        }
    }

    @PostMapping("/acc/flashToken")
    public String flashToken(int id, String token, Model model) {
        Optional<UserBase> user = Optional.ofNullable(userService.getUserByID(id));
        if(user.isPresent()) {
            try {
                // 验证 token 有效性
                if (user.get().getUser_token().equals(token)) {
                    long time = Long.parseLong(token.substring(0, 5) + token.substring(token.length() - 7, token.length() - 2));
                    long now = System.currentTimeMillis() / 1000;
                    // 判断 token 刷新时间是否过期
                    if (time + 432000 > now) {
                        // 不管 token 有没有过期都刷新
                        // 刷新 token
                        // 生成返回 token
                        String back = gson.toJson(new KeyInfo(user.get().getUser_id(), user.get().getToken()));
                        // 保存 token
                        userService.saveToken(user.get().getUser_id(), user.get().getUser_token());
                        return UI.JumpAPI(200, back, model);
                    } else {
                        // 403 重新登陆
                        return UI.JumpAPI(403, gson.toJson(new BaseMsg(403, "请重新登陆!")), model);
                    }
                } else {
                    return UI.JumpAPI(403, gson.toJson(new BaseMsg(403, "验证账号失败")), model);
                }
            } catch (Exception ex) {
                ex.printStackTrace();
                return UI.JumpAPI(500, "验证账号失败", model);
            }
        } else {
            return UI.JumpAPI(404, gson.toJson(new BaseMsg(404, "没有找到这个账号！")), model);
        }
    }

    @PostMapping("/acc/verifyLogin")
    public String verifyLogin(int id, String token, Model model) {
        try {
            if(userService.verifyLogin(id ,token)) {
                return UI.JumpAPI(200, null, model);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return UI.JumpAPI(500, null, model);
        }
        return UI.JumpAPI(403, null, model);
    }

    // ----------------------------------------------------------------------

    @GetMapping("/acc/info/getNick/{id}")
    public String getNick(@PathVariable int id, Model model) {
        Optional<String> nick = Optional.ofNullable(userService.getNick(id));
        return nick.map(s -> UI.JumpAPI(200, gson.toJson(new BaseMsg(200, s)), model)).orElseGet(() -> UI.JumpAPI(404, gson.toJson(new BaseMsg(404, "没有找到这个账号！")), model));
    }
}
