package kr.co.anabada.main.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.anabada.main.service.MainService;
import kr.co.anabada.main.service.SearchService;

@Controller
@RequestMapping("/search")
public class SearchController {
    @Autowired
    private MainService mainService;
    
    @Autowired
    private SearchService searchService;
    
}
