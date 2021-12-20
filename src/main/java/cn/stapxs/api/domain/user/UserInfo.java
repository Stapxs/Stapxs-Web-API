package cn.stapxs.api.domain.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.util.Date;

/**
 * @Version: 1.0
 * @Date: 2021/12/20 11:51
 * @ClassName: UserInfo
 * @Author: Stapxs
 * @Description TO DO
 **/
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserInfo {
    private int user_id;
    private String user_name;
    private String user_nick;
    private Date time_create;
    private Date time_login;
    private String ip_login;
}
