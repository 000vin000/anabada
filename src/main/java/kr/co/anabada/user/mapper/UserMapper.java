package kr.co.anabada.user.mapper;

import kr.co.anabada.user.entity.User;
import org.apache.ibatis.annotations.*;

@Mapper
public interface UserMapper {

    @Insert("INSERT INTO user (userId, userPw, userName, userNick, userAdd, userEmail, userPhone) " +
            "VALUES (#{userId}, #{userPw}, #{userName}, #{userNick}, #{userAdd}, #{userEmail}, #{userPhone})")
    void insertUser(User user);

    @Select("SELECT * FROM user WHERE userId = #{userId}")
    User selectByUserId(String userId);

    @Select("SELECT * FROM user WHERE userNick = #{userNick}")
    User selectByUserNick(String userNick);

    @Select("SELECT * FROM user WHERE userEmail = #{userEmail}")
    User selectByUserEmail(String userEmail);
    

    @Update("UPDATE user SET userPw = #{userPw}, userName = #{userName}, userNick = #{userNick}, userAdd = #{userAdd}, userEmail = #{userEmail}, userPhone = #{userPhone} WHERE userId = #{userId}")
    void updateUser(User user);
    
    @Select("SELECT * FROM user WHERE userNo = #{userNo}")
    User selectByUserNo(int userNo); // jhu

}
