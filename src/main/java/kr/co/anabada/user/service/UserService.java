package kr.co.anabada.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.anabada.user.entity.User;
import kr.co.anabada.user.mapper.UserMapper;
import kr.co.anabada.user.util.PasswordHasher; // PBKDF2 비밀번호 암호화 유틸리티 클래스 임포트

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    // 회원가입 로직
    public String joinUser(User user) {
        if (userMapper.selectByUserId(user.getUserId()) != null) {
            return "이미 존재하는 아이디입니다.";
        }
        try {
            // 비밀번호를 PBKDF2 방식으로 암호화
            String hashedPassword = PasswordHasher.hashPassword(user.getUserPw());
            user.setUserPw(hashedPassword); // 암호화된 비밀번호를 User 객체에 설정
            userMapper.insertUser(user); // DB에 사용자 정보 저장
            return "회원가입 성공";
        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            e.printStackTrace(); // 예외 발생 시 로그 출력
            return "회원가입 실패: 비밀번호 암호화 오류";
        }
    }

    // 로그인 로직
    public String loginUser(String userId, String userPw) {
        User user = userMapper.selectByUserId(userId);
        if (user == null) {
            return "존재하지 않는 사용자입니다.";
        }
        try {
            // 입력된 비밀번호와 DB에 저장된 암호화된 비밀번호 비교
            if (PasswordHasher.verifyPassword(userPw, user.getUserPw())) {
                return "로그인 성공";
            } else {
                return "비밀번호가 일치하지 않습니다.";
            }
        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            e.printStackTrace(); // 예외 발생 시 로그 출력
            return "로그인 실패: 비밀번호 검증 오류";
        }
    }
}
