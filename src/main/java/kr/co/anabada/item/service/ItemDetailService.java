package kr.co.anabada.item.service;

import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.anabada.item.entity.Image;
import kr.co.anabada.item.entity.Item;
import kr.co.anabada.item.entity.Question;
import kr.co.anabada.item.mapper.BidMapper;
import kr.co.anabada.item.mapper.ItemDetailMapper;

@Service
public class ItemDetailService {
	@Autowired
	ItemDetailMapper mapper;
	
	@Autowired
	BidMapper bidMapper;
	
	public Item getItemByNo(int itemNo) {
		return mapper.findItem(itemNo);
	}

	public int getCurrentPrice(int itemNo) {
		return mapper.getCurrentPrice(itemNo);
	}

	public String getCurrentState(int itemNo) {
		String state = mapper.getCurrentState(itemNo);
		
		switch(state) {
		case "waiting":
			return "대기";
		case "bidding":
			return "입찰 가능";
		case "sold":
			return "낙찰";
		case "closed":
			return "종료";
		default:
			return "unknown";
		}
	}
	
	public List<String> getAllImages(int itemNo) {
		List<Image> images = mapper.getAllImages(itemNo);
		List<String> result = new ArrayList<>();
		
		for (Image image : images) {
            String b = Base64.getEncoder().encodeToString(image.getImageFile());
            result.add(b);
        }
		
		return result;
	}

	public int updatePrice(int itemNo, int itemPrice) {
		int price = mapper.getCurrentPrice(itemNo);
		
		if (itemPrice > price) {
			return mapper.updatePrice(itemNo, itemPrice);
		} else {
			return 0;
		}
	}

	public List<Question> getAllQuestions(int itemNo) {
		return mapper.getAllQuestions(itemNo);
	}
}
