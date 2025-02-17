package kr.co.anabada.item.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.anabada.item.entity.QnA;
import kr.co.anabada.item.entity.Question;
import kr.co.anabada.item.mapper.QuestionMapper;

@Service
public class QuestionService {

    @Autowired
    private QuestionMapper questionMapper;
    

   
    // 기존 문의 조회 메서드 추가
    public Question getQuestionByQNo(int qNo) {
        return questionMapper.getQuestionByQNo(qNo);
    }

//    // 문의 수정
//    @Transactional
//    public void updateQ(Question question) {
//        Question existingQuestion = questionMapper.getQuestionByQNo(question.getQNo());
//        
//        if (existingQuestion == null) {
//            throw new IllegalArgumentException("해당 문의가 존재하지 않습니다: qNo=" + question.getQNo());
//        }
//
//        // 문의 내용 업데이트
//        existingQuestion.setQContent(question.getQContent());
//
//        // DB 업데이트 반영
//        questionMapper.updateQ(existingQuestion.getQContent(), existingQuestion.getQNo());
//    }


    // 문의 삭제
    public void deleteQ(int qNo) {
        questionMapper.deleteQ(qNo);
    }
    
    // 내가 작성한 모든 문의글 조회
    public List<QnA> getQList(int userNo) {
        return questionMapper.getQList(userNo); 
    }
    
    //아이템번호 == 올린사람의넘버 비교
    public boolean canAnswer(int itemNo, int userNo) {
        int itemOwner = questionMapper.getItemOwner(itemNo);
        return itemOwner==userNo;
    }

    
    // 상품별 문의 목록 조회
    public List<QnA> getQListByItem(int itemNo) {
        return questionMapper.getQListByItem(itemNo);
    }

    // 문의 등록
    public void insertQ(int itemNo, int userNo, String qTitle, String qContent, LocalDateTime qDate) {      
        questionMapper.insertQ(itemNo, userNo, qTitle, qContent, qDate);
    }
}