package kr.co.anabada.item.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import kr.co.anabada.item.entity.Image;
import kr.co.anabada.item.entity.Item;
import kr.co.anabada.item.service.ImageService;
import kr.co.anabada.item.service.ItemService;
import kr.co.anabada.user.entity.User;

@Controller
public class ItemController {
	@Autowired
	private ItemService itemservice;
	
	@Autowired
	private ImageService imageservice;
	
	@ModelAttribute("itemupCommand")
	public Item defalultCommand() {
		return new Item();
	}
	
	@GetMapping("/mypage/itemup")
	public String form(@ModelAttribute("itemupCommand") Item item, Model model) {
		return "mypage/itemup";
	}
	
	@PostMapping("/mypage/itemup")
	    public String submit(@Valid @ModelAttribute("itemupCommand") Item item,
	                         BindingResult errors,
	                         @RequestParam("imageFile") MultipartFile imageFile, HttpServletRequest request) {
	        if (errors.hasErrors()) {
	            return "mypage/itemup";
	        }
	        
	        HttpSession session = request.getSession(false);
	        User loggedInUser = (User) session.getAttribute("loggedInUser");

	        if (loggedInUser == null) {
	            return "redirect:/user/login";  // 로그인되지 않은 경우 로그인 페이지로 리디렉션
	        }
	        
	        Integer userNo = loggedInUser.getUserNo(); 
	        
	        System.out.println("게터 확인: " + userNo);
	        
	        item.setUserNo(userNo); 

	        // Item 저장
	        itemservice.save(item);

	        // 이미지 저장
	        if (!imageFile.isEmpty()) {
	            try {
	                byte[] imageBytes = imageFile.getBytes();
	                Image image = Image.builder()
	                        .itemNo(item.getItemNo())
	                        .imageFile(imageBytes)
	                        .build();
	                imageservice.save(image);

	                // 이미지 저장 후 imageNo 받아오기
	                Integer imageNo = image.getImageNo();
	                System.out.println("저장된 이미지의 imageNo: " + imageNo);

	                // 추가적으로 imageNo를 다른 로직에서 사용할 수 있습니다.

	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        }

	        return "redirect:/mypage";
	    }
	
	@GetMapping("/mypage/itemsell")
    public String itemList(HttpServletRequest request, Model model) {
        
        HttpSession session = request.getSession(false);
        Integer userNo = (Integer) session.getAttribute("userNo");

        if (userNo == null) {
            return "redirect:/user/login";  // 로그인되지 않았다면 로그인 페이지로 리디렉션
        }

        // 로그인한 사용자의 아이템만 가져오기
        List<Item> items = itemservice.findItemsByUserNo(userNo);

        model.addAttribute("items", items);
        return "/mypage/itemsell"; // JSP 페이지 경로
    }
}
