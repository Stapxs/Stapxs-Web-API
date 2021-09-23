package cn.stapxs.api.domain.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Version: 1.0
 * @Date: 2021/9/22 下午 8:05
 * @ClassName: LoginKeyInfo
 * @Author: Stapxs
 * @Description TO DO
 **/
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class KeyInfo {
    private int id;
    private String token;
}
