package kr.co.anabada.item.controller;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.anabada.item.entity.Item;
import kr.co.anabada.item.entity.Question;
import kr.co.anabada.item.service.ItemDetailService;
import kr.co.anabada.user.mapper.UserMapper;

@Controller
@RequestMapping("/item/detail/{itemNo}")
public class ItemDetailController {
	@Autowired
	private ItemDetailService service;
	
	@Autowired
	private UserMapper mapper;
	
	@GetMapping
	public String getItemDetail(@PathVariable int itemNo, Model model) {
		Item item = service.getItemByNo(itemNo);
		List<String> images = service.getAllImages(itemNo);
		String userNick = mapper.selectUserNick(item.getUserNo());
		long remainTime = calculateRemainTime(item.getItemEnd());
//		List<Question> questions = service.getAllQuestions(itemNo);
		
		model.addAttribute("item", item);
		model.addAttribute("images", images);
		model.addAttribute("userNick", userNick);
		model.addAttribute("remainTime", remainTime);
//		model.addAttribute("questions", questions);
		
		return "item/itemDetail";
	}
	
	@GetMapping("/questions")
	public String viewQuestions(@PathVariable int itemNo, Model model) {
	    List<Question> questions = service.getAllQuestions(itemNo);
	    model.addAttribute("questions", questions);
	    model.addAttribute("itemNo", itemNo);
	    return "item/questions";
	}
	
	private long calculateRemainTime(LocalDateTime itemEnd) {
        LocalDateTime now = LocalDateTime.now();
        Duration duration = Duration.between(now, itemEnd);
        return duration.getSeconds();
    }
	
	@GetMapping("/currentPrice")
	@ResponseBody
    public int getCurrentPrice(@PathVariable int itemNo) {
        return service.getCurrentPrice(itemNo);
    }
	
	@GetMapping("/currentState")
	@ResponseBody
	public String getCurrentState(@PathVariable int itemNo) {
		return service.getCurrentState(itemNo);
	}
	
	@PatchMapping("/bid")
	@ResponseBody
	public ResponseEntity<String> updateItemPrice(@PathVariable int itemNo, @RequestParam int itemPrice) {
		int row = service.updatePrice(itemNo, itemPrice);

	    if (row > 0) {
	        return ResponseEntity.ok("입찰 성공");
	    } else {
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("입찰 실패");
	    }
	}
}
