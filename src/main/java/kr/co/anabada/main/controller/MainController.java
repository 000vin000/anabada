package kr.co.anabada.main.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.co.anabada.item.entity.Item;
import kr.co.anabada.main.service.MainService;

@Controller
public class MainController {
	@Autowired
	private MainService mainService;
	
	@GetMapping("/")
	public String form(Model model) {
		List<Item> itemList = mainService.selectAll();
		model.addAttribute("itemList", itemList);
		
		return "main/mainForm";
	}
	
}
