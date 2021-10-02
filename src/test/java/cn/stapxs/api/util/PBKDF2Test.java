package cn.stapxs.api.util;

import lombok.SneakyThrows;
import org.junit.Assert;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class PBKDF2Test {

    @Test
    public void testGetPBKDF2() {
        try {
            PBKDF2 pbkdf2 = new PBKDF2(32, 64, 30000);
            String msg = "这是条加密内容";
            System.out.println("加密内容：" + msg);
            String out = pbkdf2.getSaveStr(msg);
            System.out.println("验证字符串：" + out);
            Assert.assertTrue(pbkdf2.verify(msg, out));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}