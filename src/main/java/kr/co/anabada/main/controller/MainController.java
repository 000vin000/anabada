package kr.co.anabada.main.controller;

import java.io.IOException;
import java.util.Base64;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import kr.co.anabada.item.entity.Item;
import kr.co.anabada.main.entity.SearchRequest;
import kr.co.anabada.main.service.MainService;

@Controller
public class MainController {
    @Autowired
    private MainService mainService;

    @GetMapping("/")
    public String form(Model model) throws IOException {
        return loadItems(model);
    }

    @PostMapping("/search")
    public String searchItems(@RequestBody SearchRequest searchRequest, Model model) throws IOException {
        List<Item> itemList = mainService.searchItems(searchRequest.getFindType(), searchRequest.getKeyword());
        loadImages(itemList, model);
        return "main/mainForm"; // JSP로 결과를 반환
    }

    @GetMapping(params = "sortOrder")
    public String sortByOrder(@RequestParam String sortOrder, Model model) throws IOException {
        List<Item> itemList = mainService.selectAll();
        List<Item> sortedList = mainService.sortByOrder(itemList, sortOrder);
        
        return loadImages(sortedList, model);
    }

    private String loadItems(Model model) throws IOException {
        List<Item> itemList = mainService.selectAll();
        return loadImages(itemList, model);
    }

    private String loadImages(List<Item> itemList, Model model) throws IOException {
    	/*
        for (Item item : itemList) {
            Resource image = mainService.selectImage1(it());
            String image1 = null;
            if (image != null) {
                byte[] bytes = image.getContentAsByteArray();
                image1 = Base64.getEncoder().encodeToString(bytes);
            }
            model.addAttribute("image_" + item.getItemNo(), image1);
        }
        model.addAttribute("itemList", itemList);
        */
        
        return "main/mainForm"; 
    }
}
