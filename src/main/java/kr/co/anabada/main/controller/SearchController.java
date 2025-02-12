package kr.co.anabada.main.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.anabada.item.entity.Item;
import kr.co.anabada.item.entity.ItemImage;
import kr.co.anabada.main.service.MainService;
import kr.co.anabada.main.service.SearchService;

@Controller
@RequestMapping("/search")
public class SearchController {
    @Autowired
    private MainService mainService;
    
    @Autowired
    private SearchService searchService;
    
    @GetMapping
    public String search(@RequestParam String findType, @RequestParam String keyword,
            				Model model) throws IOException {
        List<Item> item = searchService.searchItems(findType, keyword);
        List<ItemImage> itemList = mainService.includeImage(item);

        if (!itemList.isEmpty()) {
        	model.addAttribute("itemList", itemList);
        } else {
        	model.addAttribute("error", "검색 결과가 없습니다.");
        }
       
        return "main/searchForm"; // 검색 결과를 보여줄 뷰 이름
    }
    
    // 정렬
    @GetMapping(params = "sortOrder")
    public String sortByOrder(@RequestParam String findType, @RequestParam String keyword, @RequestParam String sortOrder, Model model) throws IOException {
        // 현재 모델에서 itemList를 가져옴
    	List<Item> item = searchService.searchItems(findType, keyword);
        List<ItemImage> itemList = mainService.includeImage(item);
        
        List<ItemImage> sortedList = mainService.sortByOrder(itemList, sortOrder);
        model.addAttribute("itemList", sortedList);

        return "main/searchForm";
    }
}
