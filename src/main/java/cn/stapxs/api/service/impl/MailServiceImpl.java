package cn.stapxs.api.service.impl;

import cn.stapxs.api.service.MailService;
import cn.stapxs.api.util.Network;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import java.util.Random;

/**
 * @Version: 1.0
 * @Date: 2022/01/04 10:16
 * @ClassName: MailService
 * @Author: Stapxs
 * @Description TO DO
 **/
@Service
public class MailServiceImpl implements MailService {

    @Autowired
    JavaMailSender javaMailSender;

    @Value("${spring.mail.username}")
    private String username;

    @Override
    public String sendCode(int id, String mail, HttpServletRequest request) throws MessagingException {
        // 生成四位代码
        Random rand = new Random();
        StringBuilder code = new StringBuilder();
        for (int i=0; i<4; i++) {
            code.append(rand.nextInt(10));
        }
        // 获取验证码页面
        String url = request.getScheme() +"://" + request.getServerName() + ":" +request.getServerPort() + "/model/code?code=" + code + "&id=" + id;
        String page = Network.get(url, "UTF-8");
        // 发送邮件
        MimeMessage message = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true);
        helper.setFrom(username);
        helper.setTo(mail);
        helper.setSubject("林槐服务接口 - 验证邮件");
        helper.setText(page, true);
        javaMailSender.send(message);
        // 返回验证码
        return code.toString();
    }
}
