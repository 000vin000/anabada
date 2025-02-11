package kr.co.anabada.mypage.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import kr.co.anabada.mypage.entity.Favor;
import kr.co.anabada.mypage.service.FavorService;
import kr.co.anabada.user.entity.User;

@Controller
@RequestMapping("/mypage/itemfavor")
public class FavorController {
	@Autowired
	FavorService service;
	
	@GetMapping
	public String favorList(@SessionAttribute(name = "loggedInUser", required = false) User user, Model model) {
		int userNo = user.getUserNo();
		List<Favor> list = service.selectMyFavor(userNo);
		
		model.addAttribute("list", list);
		return "mypage/itemfavor";
	}
	
}
