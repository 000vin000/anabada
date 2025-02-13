package kr.co.anabada.main.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.anabada.item.entity.Item;
import kr.co.anabada.item.entity.ItemImage;
import kr.co.anabada.main.service.CategoryService;
import kr.co.anabada.main.service.MainService;

@Controller
@RequestMapping("/category")
public class CategoryController {
	@Autowired
	private CategoryService cateSer;
	
	@Autowired
	private MainService mainSer;
	
	@GetMapping
	public String searchCategory(@RequestParam String gender, @RequestParam String clothesType,
									Model model) throws IOException {
		List<Item> item = cateSer.searchItems(gender, clothesType);
		List<ItemImage> itemList = mainSer.includeImage(item);
		
		if (!itemList.isEmpty()) {
			model.addAttribute("itemList", itemList);
		} else {
			model.addAttribute("error", "검색 결과가 없습니다.");
		}
		
		return "main/cateForm";
	}
	
	// 정렬
	@GetMapping(params = "sortOrder")
	public String sortByOrder(@RequestParam String gender, @RequestParam String clothesType, 
									@RequestParam String sortOrder, Model model) throws IOException {
		List<Item> item = cateSer.searchItems(gender, clothesType);
		List<ItemImage> itemList = mainSer.includeImage(item);
		
		List<ItemImage> sortedList = mainSer.sortByOrder(itemList, sortOrder);
		model.addAttribute("itemList", sortedList);
		
		return "main/cateForm";
	}
	
}
