package kr.co.anabada.user.service;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.anabada.user.entity.User;
import kr.co.anabada.user.mapper.UserMapper;
import kr.co.anabada.user.util.PasswordHasher; // PBKDF2 비밀번호 암호화 유틸리티 클래스 임포트

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

    // 아이디 중복 확인
    public boolean isUserIdDuplicate(String userId) {
        return userMapper.selectByUserId(userId) != null;
    }
//    // 닉네임
//    public boolean isUserNickDuplicate(String userNick) {
//        return userMapper.selectByUserNick(userNick) != null;
//    }
//    // 이메일
//    public boolean isUserEmailDuplicate(String userEmail) {
//        return userMapper.selectByUserEmail(userEmail) != null;
//    }
//    // 전화번호
//    public boolean isUserPhoneDuplicate(String userPhone) {
//        return userMapper.selectByUserPhone(userPhone) != null;
//    }
   
    
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
    
    //사용자 ID로 전체 사용자 정보를 조회하는 메소드 추가
    public User getUserByUserId(String userId) {
        return userMapper.selectByUserId(userId);
    }
    
    // 회원정보 수정
    public String updateUserInfo(User updatedUser, String userId) {
        User existingUser = userMapper.selectByUserId(userId); // userId로 사용자 정보 조회
        if (existingUser == null) {
            return "존재하지 않는 사용자입니다.";
        }

        // 닉네임 중복 검사
        if (!existingUser.getUserNick().equals(updatedUser.getUserNick()) &&
            userMapper.selectByUserNick(updatedUser.getUserNick()) != null) {
            return "이미 사용 중인 닉네임입니다.";
        }

        // 이메일 중복 검사
        if (!existingUser.getUserEmail().equals(updatedUser.getUserEmail()) &&
            userMapper.selectByUserEmail(updatedUser.getUserEmail()) != null) {
            return "이미 사용 중인 이메일입니다.";
        }

        // 비밀번호 암호화 처리 (비밀번호가 변경된 경우만)
        if (!updatedUser.getUserPw().equals(existingUser.getUserPw())) {
            try {
                String hashedPassword = PasswordHasher.hashPassword(updatedUser.getUserPw());
                updatedUser.setUserPw(hashedPassword);
            } catch (Exception e) {
                e.printStackTrace();
                return "비밀번호 암호화 중 오류가 발생했습니다.";
            }
        }

        updatedUser.setUserId(userId); // userId는 변경하지 않음

        userMapper.updateUser(updatedUser); // DB 업데이트 호출
        return "회원정보 변경 성공";
    }   
   	
}