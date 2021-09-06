package cn.stapxs.api.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Version: 1.0
 * @Date: 2021/9/6 下午 7:50
 * @ClassName: BaseClass
 * @Author: Stapxs
 * @Description TO DO
 **/
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BaseClass {
    private int id;
    private String name;
}
