package kr.co.anabada.mypage.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.anabada.mypage.entity.Favor;
import kr.co.anabada.mypage.service.FavorService;

@Controller
@RequestMapping("/mypage/itemfavor")
public class FavorController {
	@Autowired
	FavorService service;
	
	@GetMapping("/{userNo}")
	public String favorList(@PathVariable int userNo, Model model) {
		List<Favor> list = service.selectMyFavor(userNo);
		
		model.addAttribute("list", list);
		return "mypage/favor";
	}
	
}
