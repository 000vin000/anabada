package kr.co.anabada.item.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import kr.co.anabada.item.entity.Answer;
import kr.co.anabada.item.entity.QnA;
import kr.co.anabada.item.service.AnswerService;
import kr.co.anabada.user.entity.User;

@Controller
public class AnswerController {
    @Autowired
    private AnswerService aService;
    
//    // 답변 작성 처리
//    @PostMapping("/item/detail/writeA")
//    public String insertA(Answer answer) {
//    	aService.insertA(answer);
//    	return "item/detail";
//    }
//    
//    // 답변 수정 처리
//    @PostMapping("/item/detail/editA")
//    public String updateA(Answer answer) {
//    	aService.updateA(answer);
//    	return "item/detail";
//    }
//    
//    // 답변 삭제 처리
//    @PostMapping("/item/detail/deleteA")
//    public String deleteA(@RequestParam int aNo) {
//    	aService.deleteA(aNo);
//    	return "item/detail";
//    }
    
    // 내 모든 물건에 대한 문의글 조회
    @GetMapping("/mypage/a")
    public String getAList(@SessionAttribute(name = "loggedInUser", required = false) User user, Model model) { 
        List<QnA> list = aService.getAList(user.getUserNo());
        model.addAttribute("list", list);
    	return "mypage/a";
    }

}
