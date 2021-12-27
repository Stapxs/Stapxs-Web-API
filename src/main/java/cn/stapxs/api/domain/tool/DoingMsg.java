package cn.stapxs.api.domain.tool;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @Version: 1.0
 * @Date: 2021/12/26 20:36
 * @ClassName: DoingMsg
 * @Author: Stapxs
 * @Description TO DO
 **/
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DoingMsg {
    private int user_id;
    private String name_platform;
    private Date set_date;
    private String doing;
}
