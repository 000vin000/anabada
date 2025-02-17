package kr.co.anabada.mypage.service;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.anabada.mypage.mapper.UpdateInfoMapper;
import kr.co.anabada.user.entity.User;
import kr.co.anabada.user.mapper.UserMapper;
import kr.co.anabada.user.util.PasswordHasher;

@Service
public class UpdateInfoService {

    @Autowired
    private UpdateInfoMapper updateInfoMapper;

    @Autowired
    private UserMapper userMapper;
    
    public boolean deactivateUser(int userNo) {
        LocalDateTime now = LocalDateTime.now();
        int rowsAffected = updateInfoMapper.deactivateUser(userNo, now);
        return rowsAffected > 0;
    }
    
    public String updateUserInfo(User updatedUser, String userId) {
        User existingUser = userMapper.selectByUserId(userId);
        if (existingUser == null) {
            return "존재하지 않는 사용자입니다.";
        }

        // 비밀번호 암호화 처리 (비밀번호가 변경된 경우만)
        if (!updatedUser.getUserPw().isEmpty() && !updatedUser.getUserPw().equals(existingUser.getUserPw())) {
            try {
                String hashedPassword = PasswordHasher.hashPassword(updatedUser.getUserPw());
                updatedUser.setUserPw(hashedPassword);
            } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
                e.printStackTrace();
                return "비밀번호 암호화 중 오류가 발생했습니다.";
            }
        } else {
            updatedUser.setUserPw(existingUser.getUserPw());
        }

        // userId 필드 값 명시적 설정
        updatedUser.setUserId(userId);

        try {
            userMapper.updateUser(updatedUser);
            return "회원정보 변경 성공";
        } catch (Exception e) {
            e.printStackTrace();
            return "회원정보 변경 중 오류가 발생했습니다.";
        }
    }
}