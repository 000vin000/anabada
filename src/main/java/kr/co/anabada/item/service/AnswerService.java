package kr.co.anabada.item.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.anabada.item.entity.Answer;
import kr.co.anabada.item.entity.QnA;
import kr.co.anabada.item.mapper.AnswerMapper;

@Service
public class AnswerService {
	
	@Autowired
	private AnswerMapper answerMapper;
	
    // 답변 작성
	public void insertA(Answer answer) {
		answerMapper.insertA(answer);
	}
	
	// 답변 수정
	public void updateA(Answer answer) {
		answerMapper.updateA(answer);
	}
	
	// 답변 삭제
	public void deleteA(int aNo) {
		answerMapper.deleteA(aNo);
	}

    // 내가 받은 모든 문의글 조회
    public List<QnA> getAList(int userNo) {
        return answerMapper.getAList(userNo); 
    }
}
