package kr.co.anabada.mypage.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.co.anabada.mypage.service.FavorService;

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
	
	@DeleteMapping
	public String removeFavor(@RequestParam int userNo, @RequestParam int itemNo) {
		service.removeFavor(userNo, itemNo);
		return "remove from favorite";
	}
}
