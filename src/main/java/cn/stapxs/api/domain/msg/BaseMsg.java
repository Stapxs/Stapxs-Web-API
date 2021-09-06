package cn.stapxs.api.domain.msg;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Version: 1.0
 * @Date: 2021/9/1 下午 10:13
 * @ClassName: BaseMsg
 * @Author: Stapxs
 * @Description TO DO 返回 JSON 的基础格式
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
public class BaseMsg {
    private int status;
    private String message;
}
