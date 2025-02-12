package kr.co.anabada.item.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.anabada.item.entity.QnA;
import kr.co.anabada.item.entity.Question;
import kr.co.anabada.item.service.QuestionService;

@Controller
public class QuestionController {
	 @Autowired
	 private QuestionService qService;
	 
//	// 문의 작성 처리
//	 @PostMapping("/item/detail/writeQ")
//	 public String insertQ(Question question) {
//	     qService.insertQ(question);
//	     return "item/detail"; 
//	 }
//	 
//	// 문의 수정 처리
//	 @PostMapping("/item/detail/editQ")
//	 public String updateQ(Question question) {
//	     qService.updateQ(question);
//	     return "item/detail";
//	 }
//
//	 // 문의 삭제 처리
//	 @PostMapping("/item/detail/deleteQ")
//	 public String deleteQ(@RequestParam int qNo) {
//	     qService.deleteQ(qNo);
//	     return "item/detail"; 
//	 }
	 
	 // 내가 작성한 모든 문의글 조회
	 @GetMapping("/mypage/q")
	 public String getQList(@RequestParam int userNo, Model model) {
	     List<QnA> list = qService.getQList(userNo);
	     model.addAttribute("list", list);
	     return "mypage/q";
	 }
	 
//	 // 상품의 모든 문의글 조회
//	 @GetMapping("/item/detail")
//	 public String getQListByItem(@RequestParam int itemNo, Model model) {
//		 List<QnA> list = qService.getQListByItem(itemNo);
//		 model.addAttribute("list", list);
//		 return "item/detail";
//	 }
}
