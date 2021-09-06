package cn.stapxs.api.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @Version: 1.0
 * @Date: 2021/9/2 下午 5:41
 * @ClassName: Number
 * @Author: Stapxs
 * @Description TO DO
 **/
public class Number {
    public static boolean isInteger(String str) {
        Pattern pattern = Pattern.compile("^[-\\+]?[\\d]*$");
        return pattern.matcher(str).matches();
    }
}
