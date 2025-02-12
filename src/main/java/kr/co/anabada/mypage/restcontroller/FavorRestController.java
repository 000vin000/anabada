package kr.co.anabada.mypage.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import kr.co.anabada.mypage.service.FavorService;
import kr.co.anabada.user.entity.User;

@RestController
@RequestMapping("/api/favor")
public class FavorRestController {
	@Autowired
	private FavorService service;
	
	@PostMapping
	public String addFavor(@RequestParam int userNo, @RequestParam int itemNo) {
		service.addFavor(userNo, itemNo);
		return "add to favorite";
	}
	
	@DeleteMapping("/{itemNo}")
	public String removeFavor(@SessionAttribute(name = "loggedInUser", required = false) User user, @PathVariable int itemNo) {
		service.removeFavor(user.getUserNo(), itemNo);
		return "remove from favorite";
	}
}
