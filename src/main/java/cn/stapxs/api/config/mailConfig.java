package cn.stapxs.api.config;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.mail.MailProperties;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

import java.nio.charset.Charset;

/**
 * @Version: 1.0
 * @Date: 2022/01/04 10:00
 * @ClassName: mailConfig
 * @Author: Stapxs
 * @Description TO DO
 **/
@Component
@PropertySource("classpath:mail.properties")
@Data
public class mailConfig {
    @Value("${spring.mail.host}")
    private String host;
    @Value("${spring.mail.port}")
    private Integer port;
    @Value("${spring.mail.username}")
    private String username;
    @Value("${spring.mail.password}")
    private String password;
    @Value("${spring.mail.default-encoding}")
    private String defaultEncoding;
    @Value("${spring.mail.smtp.timeout}")
    private int timeout;
}
