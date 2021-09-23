package cn.stapxs.api.domain.user;

import cn.stapxs.api.service.UserService;
import cn.stapxs.api.service.impl.UserServiceImpl;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static org.junit.Assert.*;

public class UserBaseTest {


    @Test
    public void testGetToken() {
        UserBase user = new UserBase();
        user.setUser_id(0);

        System.out.println(user.getToken());
    }
}