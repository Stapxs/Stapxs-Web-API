package cn.stapxs.api.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * @Version: 1.0
 * @Date: 2021/9/4 下午 6:46
 * @ClassName: apiInfo
 * @Author: Stapxs
 * @Description TO DO
 **/
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ApiInfo {

    private List<info> text;
    private List<info> pic;
    private List<info> tool;
    private List<info> other;

    public static class info {
        private String name;
        private String info;
        private String url;

        public info(String s, String s1, String s2) {
            name = s;
            info = s1;
            url = s2;
        }
    }
}
