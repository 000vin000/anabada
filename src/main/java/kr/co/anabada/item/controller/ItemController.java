package kr.co.anabada.item.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.validation.Valid;
import kr.co.anabada.item.entity.Item;
import kr.co.anabada.item.service.ItemService;

@Controller
public class ItemController {
	@Autowired
	private ItemService itemservice;
	
	@ModelAttribute("itemupCommand")
	public Item defalultCommand() {
		return new Item();
	}
	
	@GetMapping("/mypage/itemup")
	public String form(@ModelAttribute("itemupCommand") Item item, Model model) {
		return "mypage/itemup";
	}
	
	@PostMapping("/mypage/itemup")
	public String submit(@Valid @ModelAttribute("itemupCommand") Item item, BindingResult errors) {
		if (errors.hasErrors()) {
			return "mypage/itemup";
		}
		
		itemservice.save(item);
		
		return "redirect:/mypage";
	}
}
