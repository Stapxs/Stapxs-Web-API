package cn.stapxs.api.dao;

import cn.stapxs.api.domain.user.UserBase;
import cn.stapxs.api.domain.user.UserInfo;
import cn.stapxs.api.domain.user.UserKey;
import org.apache.ibatis.annotations.*;

@Mapper
public interface UserDao {
    // Select
    @Select("select * from sac_user where user_name=#{name}")
    public UserBase getUserByName(String name);
    @Select("select * from sac_user where user_id=#{id}")
    public UserBase getUserByID(int id);
    @Select("select * from sac_userinfo where user_id=#{id}")
    public UserInfo getUserInfoByID(int id);
    @Select("select user_nick from sac_userinfo where user_id=#{id}")
    public String getUserNick(int id);
    @Select("select * from sac_key where user_id=#{id}")
    public UserKey[] getUserKey(int id);

    // Update
    @Update("update sac_user set login_key=#{pkey} where user_id=#{id}")
    public void setLoginKey(String pkey, Integer id);
    @Update("update sac_user set user_token=#{token} where user_id=#{id}")
    public void setUserToken(String token, Integer id);
    @Update("update sac_userinfo set time_login=NOW(), ip_login=#{ip} where user_id=#{id}")
    public void setLoginInfo(int id, String ip);

    // Insert
    @Insert("insert into sac_key (user_id, key_id, key_value) values (#{id}, #{num}, #{value})")
    public void createKey(int id, int num, String value);

    // Delete
    @Delete("delete from sac_key where user_id=#{id} and key_id=#{num}")
    public void deleteKet(int id, int num);
}
