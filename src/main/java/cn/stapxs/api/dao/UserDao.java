package cn.stapxs.api.dao;

import cn.stapxs.api.domain.user.UserBase;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface UserDao {
    // Select
    @Select("select * from sac_user where user_name=#{name}")
    public UserBase getUserByName(String name);
    @Select("select * from sac_user where user_id=#{id}")
    public UserBase getUserByID(int id);

    @Select("select user_nick from sac_userinfo where user_id=#{id}")
    public String getUserNick(int id);

    // Update
    @Update("update sac_user set login_key=#{pkey} where user_id=#{id}")
    public void setLoginKey(String pkey, Integer id);
    @Update("update sac_user set user_token=#{token} where user_id=#{id}")
    public void setUserToken(String token, Integer id);
}
