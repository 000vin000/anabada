package kr.co.anabada.item.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.anabada.item.entity.Bid;
import kr.co.anabada.item.service.BidService;

@Controller
public class BidController {
	@Autowired
	private BidService bidService;
		
//  // 입찰하기
//  @PostMapping("/item/detail/addBid")
//  public String insertBid(Bid bid) {
//  	bidService.insertBid(bid);
//  	return "item/detail";
//  }
	
	// 입찰 취소하기
	@PostMapping("/item/bidList/deleteBid")
	public String deleteBid(@RequestParam int bidNo) {
		bidService.deleteBid(bidNo);
		return "item/bidList";
	}
			
	 // 입찰한 기록 조회
    @GetMapping("/item/bidList")
    public String getBidList(@RequestParam int itemNo, Model model) {
        List<Bid> list = bidService.getBidList(itemNo);
        model.addAttribute("list", list);
        return "item/bidList";
    }

}
