package kr.co.anabada.mypage.service;

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

    //수정3
    @Autowired
    private UserMapper userMapper;
    
    public boolean deactivateUser(int userNo) {
        LocalDateTime now = LocalDateTime.now();
        int rowsAffected = updateInfoMapper.deactivateUser(userNo, now);
        return rowsAffected > 0;
    }
    
    //수정 2
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

