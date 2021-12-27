package cn.stapxs.api;

import lombok.Builder;
import lombok.Data;
import org.springframework.context.annotation.Bean;

/**
 * @Version: 1.0
 * @Date: 2021/9/2 上午 11:44
 * @ClassName: appInfo
 * @Author: Stapxs
 * @Description TO DO 应用信息
 **/
@Data
@Builder
public class appInfo {
    public static String version = "1.1.4";
    public static int build = 1;
    public static String type = "Dev";
    public static double verNum = 1.1;

    public static String root = "C://Users/Stapxs/Desktop/SS-Web-API/";

    public String getVersion() {
        return version;
    }

    public int getBuild() {
        return build;
    }
}
