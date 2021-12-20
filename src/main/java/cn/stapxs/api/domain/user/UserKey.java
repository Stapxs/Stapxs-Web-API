package cn.stapxs.api.domain.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Version: 1.0
 * @Date: 2021/12/20 20:00
 * @ClassName: UserKey
 * @Author: Stapxs
 * @Description TO DO
 **/
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserKey {
    private int user_id;
    private int key_id;
    private String key_value;
}
