package kr.co.anabada.mypage.service;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.anabada.mypage.mapper.UpdateInfoMapper;

@Service
public class UpdateInfoService {

    @Autowired
    private UpdateInfoMapper updateInfoMapper;

    public boolean deactivateUser(int userNo) {
        LocalDateTime now = LocalDateTime.now();
        int rowsAffected = updateInfoMapper.deactivateUser(userNo, now);
        return rowsAffected > 0;
    }
}

