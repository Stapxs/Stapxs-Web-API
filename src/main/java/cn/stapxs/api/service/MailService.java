package cn.stapxs.api.service;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

public interface MailService {
    public String sendCode(int id, String mail, HttpServletRequest request) throws MessagingException;
}
