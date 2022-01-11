package cn.stapxs.api.dao;

import cn.stapxs.api.domain.user.UserBase;
import cn.stapxs.api.domain.user.UserInfo;
import cn.stapxs.api.domain.user.UserKey;
import org.apache.ibatis.annotations.*;

import java.util.Date;

@Mapper
public interface UserDao {
    // Select
    @Select("select * from sac_user where user_name=#{name}")
    public UserBase getUserByName(String name);
    @Select("select * from sac_user where user_id=#{id}")
    public UserBase getUserByID(int id);
    @Select("select * from sac_userinfo where user_id=#{id}")
    public UserInfo getUserInfoByID(int id);
    @Select("select mail_status from sac_userinfo where user_id=#{id}")
    public int getMailStatus(int id);
    @Select("select user_nick from sac_userinfo where user_id=#{id}")
    public String getUserNick(int id);
    @Select("select * from sac_key where user_id=#{id}")
    public UserKey[] getUserKey(int id);
    @Select("select * from sac_key where key_value=#{key}")
    public UserKey getKeyInfo(String key);

    // Update
    @Update("update sac_user set login_key=#{pkey} where user_id=#{id}")
    public void setLoginKey(String pkey, Integer id);
    @Update("update sac_user set user_token=#{token} where user_id=#{id}")
    public void setUserToken(String token, Integer id);
    @Update("update sac_user set user_token='' where user_id=#{id}")
    public void delUserToken(Integer id);
    @Update("update sac_user set last_code=#{code}, code_time=#{time} where user_id=#{id}")
    public void updateCode(int id, String code, Date time);
    @Update("update sac_userinfo set time_login=NOW(), ip_login=#{ip} where user_id=#{id}")
    public void setLoginInfo(int id, String ip);
    @Update("update sac_userinfo set user_mail=#{mail} where user_id=#{id}")
    public void updateUserMail(int id, String mail);
    @Update("update sac_userinfo set mail_status=#{statue} where user_id=#{id}")
    public void updateUserMailStatue(int id, int statue);
    @Update("update sac_key set key_name=#{str} where user_id=#{id} and key_id=#{num}")
    public void updateKeyName(int id, int num, String str);

    // Insert
    @Insert("insert into sac_key (user_id, key_id, key_value) values (#{id}, #{num}, #{value})")
    public void createKey(int id, int num, String value);

    // Delete
    @Delete("delete from sac_key where user_id=#{id} and key_id=#{num}")
    public void deleteKet(int id, int num);
}
