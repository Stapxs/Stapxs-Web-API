package cn.stapxs.api.domain.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.UUID;

/**
 * @Version: 1.0
 * @Date: 2021/9/22 下午 5:23
 * @ClassName: UserInfo
 * @Author: Stapxs
 * @Description TO DO
 **/
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserBase {
    private int user_id;
    private String user_name;
    private String user_password;
    private String user_token;
    private String login_token;
    private String login_key;
    private int account_state;

    public String getToken() {
        System.out.print("操作 > 生成 token > getToken > ");
        String uuid = UUID.randomUUID().toString().replaceAll("-", "").toUpperCase();
        String time = String.valueOf(System.currentTimeMillis() / 1000);
        System.out.println(uuid +", " + time);

        user_token = time.substring(0, 5) + uuid.substring(0, 16) + user_id + time.substring(5) + "01";

        return user_token;
    }
}
