package cn.stapxs.api.dao;

import cn.stapxs.api.domain.tool.DoingMsg;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface DoingDao {
    // Select
    @Select("select user_doing_set from sac_set where user_id=#{id}")
    public String getDpingSet(int id);
    @Select("select * from api_doing where user_id=#{id} and name_platform=#{platform}")
    public DoingMsg getDoing(int id, String platform);
    @Select("select * from api_doing where user_id=#{id}")
    public DoingMsg[] getAllDoing(int id);

    // Insert
    @Insert("insert into api_doing (user_id, name_platform, doing, set_date) values" +
            " (#{user_id}, #{name_platform}, #{doing}, NOW())")
    public void newDoing(DoingMsg info);

    // Update
    @Update("update api_doing set doing=#{doing}, set_date=NOW() where user_id=#{user_id} and name_platform=#{name_platform}")
    public void updateDoing(DoingMsg info);
}
