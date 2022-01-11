package cn.stapxs.api.controller;

import cn.stapxs.api.appInfo;
import cn.stapxs.api.domain.msg.BaseMsg;
import cn.stapxs.api.domain.user.KeyInfo;
import cn.stapxs.api.domain.user.UserBase;
import cn.stapxs.api.domain.user.UserInfo;
import cn.stapxs.api.domain.user.UserKey;
import cn.stapxs.api.service.MailService;
import cn.stapxs.api.service.UserService;
import cn.stapxs.api.util.NetWork;
import cn.stapxs.api.util.PBKDF2;
import cn.stapxs.api.util.RSAEncrypt;
import cn.stapxs.api.util.UI;
import com.google.gson.Gson;
import org.apache.poi.util.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.SecurityProperties;
import org.springframework.http.HttpRequest;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.crypto.BadPaddingException;
import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.Optional;
import java.util.Random;

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
    @Autowired
    MailService mailService;

    // ----------------------------------------------------------------------
    // 账户登录登出相关

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
    public String loginAcc(int id, String str, Model model, HttpServletRequest request) {
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
                // 刷新登录信息
                String ip = NetWork.getIP(request);
                if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                    ip = request.getRemoteAddr();
                }
                userService.updateLoginInfo(id, ip);
                // 返回
                return UI.JumpAPI(200, back, model);
            } else {
                return UI.JumpAPI(403, gson.toJson(new BaseMsg(403, "账号或密码错误")), model);
            }
        } else {
            return UI.JumpAPI(404, gson.toJson(new BaseMsg(404, "没有找到这个账号！")), model);
        }
    }

    @PostMapping("/acc/OutAcc")
    public String loginOutAcc(int id, String token, Model model) {
        // 验证登录
        try {
            if(userService.verifyLogin(id ,token, true)) {
                // 登出
                userService.loginOut(id);
                return UI.JumpAPI(200, gson.toJson(new BaseMsg(200, "操作成功！")), model);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return UI.JumpAPI(500, null, model);
        }
        return UI.JumpAPI(403, gson.toJson(new BaseMsg(403, "验证登陆失败！")), model);
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
    public String verifyLogin(int id, String token, @Nullable boolean notBase, Model model) {
        try {
            if(notBase) {
                if (userService.verifyLogin(id, token)) {
                    return UI.JumpAPI(200, null, model);
                }
            } else {
                if (userService.verifyLogin(id, token, true)) {
                    return UI.JumpAPI(200, null, model);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return UI.JumpAPI(500, null, model);
        }
        return UI.JumpAPI(403, null, model);
    }

    // ----------------------------------------------------------------------
    // 账户注册相关
    @PostMapping("/acc/verifyMail")
    public String sendMail(int id, String token, String mail, Model model, HttpServletRequest request) {
        // 验证邮箱验证状态（使用严格模式验证登陆）
        try {
            if(!userService.verifyLogin(id ,token)) {
                // 判断发送是否频繁
                UserBase base = userService.getUserByID(id);
                if(base.getCode_time() != null) {
                    Date afterDate = new Date(base.getCode_time().getTime() - 240000);
                    if(afterDate.after(new Date())) {
                        return UI.JumpAPI(403, gson.toJson(new BaseMsg(403, "操作频繁！")), model);
                    }
                }
                // 发送
                String code = mailService.sendCode(id, mail, request);
                // 记录数据
                userService.updateMail(id, mail);
                userService.updateCode(id, code);
                // 返回
                return UI.JumpAPI(200, gson.toJson(new BaseMsg(200, "操作成功！")), model);
            } else {
                return UI.JumpAPI(403, gson.toJson(new BaseMsg(403, "邮箱已验证！")), model);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return UI.JumpAPI(500, null, model);
        }
    }

    @PostMapping("/acc/passMail")
    public String passMail(int id, String token, String code, Model model) {
        // 验证登录
        try {
            if(userService.verifyLogin(id ,token, true)) {
                // 验证 Code
                String back = userService.verifyCode(id, code);
                if(back.equals("OK")) {
                    userService.updateMailState(id, true);
                    return UI.JumpAPI(200, gson.toJson(new BaseMsg(200, "验证完成！")), model);
                } else {
                    return UI.JumpAPI(403, gson.toJson(new BaseMsg(403, back)), model);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return UI.JumpAPI(500, null, model);
        }
        return UI.JumpAPI(403, gson.toJson(new BaseMsg(403, "验证登陆失败！")), model);
    }

    // ----------------------------------------------------------------------
    // 获取账户信息相关

    @GetMapping("/acc/info/getNick/{id}")
    public String getNick(@PathVariable int id, Model model) {
        Optional<String> nick = Optional.ofNullable(userService.getNick(id));
        return nick.map(s -> UI.JumpAPI(200, gson.toJson(new BaseMsg(200, s)), model)).orElseGet(() -> UI.JumpAPI(404, gson.toJson(new BaseMsg(404, "没有找到这个账号！")), model));
    }

    @GetMapping("/acc/info/getAvatar/{id}")
    public String getAvatar(@PathVariable int id, HttpServletResponse response) throws IOException {
        File file = new File(appInfo.root + "User/Avatars/" + id + ".jpg");
        if(file.exists()) {
            FileInputStream fis = new FileInputStream(file);
            response.setContentType("image/jpg");
            response.setHeader("Access-Control-Allow-Origin", "*");
            IOUtils.copy(fis, response.getOutputStream());
        }
        return null;
    }

    @PostMapping("/acc/info/getInfo")
    public String getInfo(int id, String token, Model model) {
        // 验证登录
        try {
            if(userService.verifyLogin(id ,token, true)) {
                // 获取 info
                Optional<UserBase> base = Optional.ofNullable(userService.getUserByID(id));
                Optional<UserInfo> info = Optional.ofNullable(userService.getUserInfoByID(id));
                if(base.isPresent() && info.isPresent()) {
                    info.get().setUser_name(base.get().getUser_name());
                    return UI.JumpAPI(200, gson.toJson(info), model);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return UI.JumpAPI(500, null, model);
        }
        return UI.JumpAPI(403, gson.toJson(new BaseMsg(403, "验证登陆失败！")), model);
    }

    // ----------------------------------------------------------------------
    // 用户识别 key 相关

    @PostMapping("/acc/key/new")
    public String newKey(int id, String token, Model model) {
        // 验证登录
        try {
            if(userService.verifyLogin(id ,token)) {
                // 新建 key
                boolean back = userService.createKey(id);
                if(back) {
                    return UI.JumpAPI(200, gson.toJson(new BaseMsg(200, "创建成功！")), model);
                } else {
                    return UI.JumpAPI(403, gson.toJson(new BaseMsg(403, "key 数量已满！")), model);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return UI.JumpAPI(500, null, model);
        }
        return UI.JumpAPI(403, gson.toJson(new BaseMsg(403, "验证登陆失败！")), model);
    }

    @PostMapping("/acc/key/get")
    public String getKey(int id, String token, Model model) {
        // 验证登录
        try {
            if(userService.verifyLogin(id ,token)) {
                // 获取 key
                UserKey[] keys = userService.getKey(id);
                return UI.JumpAPI(200, gson.toJson(keys), model);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return UI.JumpAPI(500, null, model);
        }
        return UI.JumpAPI(403, gson.toJson(new BaseMsg(403, "验证登陆失败！")), model);
    }

    @PostMapping("/acc/key/delete")
    public String deleteKey(int id, int num, String token, Model model) {
        // 验证登录
        try {
            if(userService.verifyLogin(id ,token)) {
                // 删除 key
                userService.deleteKey(id, num);
                return UI.JumpAPI(200, null, model);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return UI.JumpAPI(500, null, model);
        }
        return UI.JumpAPI(403, gson.toJson(new BaseMsg(403, "验证登陆失败！")), model);
    }

    @PostMapping("/acc/key/name")
    public String changeName(int id, int num, String name, String token, Model model) {
        // 验证登录
        try {
            if(userService.verifyLogin(id ,token)) {
                // 更新备注
                userService.updateKeyName(id, num, name);
                return UI.JumpAPI(200, gson.toJson(new BaseMsg(200, "提交成功！")), model);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return UI.JumpAPI(500, gson.toJson(new BaseMsg(500, e.getMessage())), model);
        }
        return UI.JumpAPI(403, gson.toJson(new BaseMsg(403, "验证登陆失败！")), model);
    }
}
