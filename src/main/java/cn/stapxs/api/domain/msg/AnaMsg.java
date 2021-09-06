package cn.stapxs.api.domain.msg;

import lombok.*;

import java.util.Date;

/**
 * @Version: 1.0
 * @Date: 2021/9/1 下午 10:50
 * @ClassName: AnaMsg
 * @Author: Stapxs
 * @Description TO DO
 **/
@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AnaMsg extends BaseMsg {
    private int id;
    private String ana;
    private String time;
}
