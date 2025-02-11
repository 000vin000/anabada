package kr.co.anabada.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.anabada.user.entity.User;
import kr.co.anabada.user.mapper.UserMapper;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    public String joinUser(User user) {
        if (userMapper.selectByUserId(user.getUserId()) != null) {
            return "이미 존재하는 아이디입니다.";
        }
        userMapper.insertUser(user);
        return "회원가입 성공";
    }

    public String loginUser(String userId, String userPw) {
        User user = userMapper.selectByUserId(userId);
        if (user == null) {
            return "존재하지 않는 사용자입니다.";
        }
        if (!user.getUserPw().equals(userPw)) {
            return "비밀번호가 일치하지 않습니다.";
        }
        return "로그인 성공";
    }
}
