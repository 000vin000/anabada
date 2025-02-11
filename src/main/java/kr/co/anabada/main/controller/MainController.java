package kr.co.anabada.main.controller;

import java.io.IOException;
import java.util.Base64;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.anabada.item.entity.Image;
import kr.co.anabada.item.entity.Item;
import kr.co.anabada.main.service.MainService;

@Controller
public class MainController {
    @Autowired
    private MainService mainService;
    
    @GetMapping("/")
    public String form(Model model) throws IOException {
        return loadItems(model);
    }
    
    @GetMapping(params = "sortOrder")
    public String sortByOrder(@RequestParam String sortOrder, Model model) throws IOException {
        // 모든 아이템을 가져온 후 정렬
        List<Item> itemList = mainService.selectAll();
        List<Item> sortedList = mainService.sortByOrder(itemList, sortOrder);
        
        // 모델에 정렬된 아이템 목록 추가
        return loadImages(sortedList, model);
    }
    
    private String loadItems(Model model) throws IOException {
        List<Item> itemList = mainService.selectAll();
        return loadImages(itemList, model);
    }

    private String loadImages(List<Item> itemList, Model model) throws IOException {
        for (Item item : itemList) {
            Resource image = mainService.selectImage1(item.getItemImage());
            String image1 = null;
            if (image != null) {
                byte[] bytes = image.getContentAsByteArray();
                image1 = Base64.getEncoder().encodeToString(bytes);
            }
            model.addAttribute("image_" + item.getItemNo(), image1); // 이미지 키를 명확히 하기 위해 접두어 추가
        }
        model.addAttribute("itemList", itemList);
        
        return "main/mainForm"; 
    }
}
