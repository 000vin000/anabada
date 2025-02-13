package kr.co.anabada.item.service;

import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.anabada.item.entity.Image;
import kr.co.anabada.item.entity.Item;
import kr.co.anabada.item.mapper.ItemDetailMapper;

@Service
public class ItemDetailService {
	@Autowired
	ItemDetailMapper mapper;
	
	public Item getItemByNo(int itemNo) {
		return mapper.findItem(itemNo);
	}

	public int getCurrentPrice(int itemNo) {
		return mapper.getCurrentPrice(itemNo);
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
}
