package kr.co.anabada.item.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.anabada.item.entity.QnA;
import kr.co.anabada.item.entity.Question;
import kr.co.anabada.item.mapper.QuestionMapper;

@Service
public class QuestionService {

    @Autowired
    private QuestionMapper questionMapper;
    
    // 문의 작성
    public void insertQ(Question question) {
        questionMapper.insertQ(question);
    }
    
    // 문의 수정
    public void updateQ(Question question) {
        questionMapper.updateQ(question);
    }

    // 문의 삭제
    public void deleteQ(int qNo) {
        questionMapper.deleteQ(qNo);
    }
    
    // 내가 작성한 모든 문의글 조회
    public List<QnA> getQList(int userNo) {
        return questionMapper.getQList(userNo); 
    }
    
    // 상품별 문의 목록 조회
    public List<QnA> getQListByItem(int itemNo) {
        return questionMapper.getQListByItem(itemNo);
    }
}
