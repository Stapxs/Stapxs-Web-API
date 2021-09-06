package cn.stapxs.api.domain;

import lombok.*;

/**
 * @Version: 1.0
 * @Date: 2021/9/2 下午 8:07
 * @ClassName: BingPicInfo
 * @Author: Stapxs
 * @Description TO DO
 **/
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BingPicInfo {
    private String startdate;
    private String fullstartdate;
    private String enddate;
    private String url;
    private String urlbase;
    private String copyright;
    private String copyrightlink;
}
