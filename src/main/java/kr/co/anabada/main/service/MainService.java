package kr.co.anabada.main.service;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.anabada.item.entity.Item;
import kr.co.anabada.item.entity.ItemImage;
import kr.co.anabada.main.mapper.MainMapper;
import kr.co.anabada.user.entity.User;
import kr.co.anabada.user.mapper.UserMapper;

@Service
public class MainService {
    @Autowired
    private MainMapper mapper;
    
    @Autowired
    private UserMapper userMapper;
    
    // 전체 item List
    @Transactional(readOnly = true)
    public List<Item> selectAll() {
        return mapper.selectAll();
    }
    
    // itemNo의 대표 이미지
    @Transactional(readOnly = true)
    public Resource selectImage1(int itemNo) {
        return mapper.selectImage1(itemNo);
    }

    // 이미지파일이 포함된 Item List
    public List<ItemImage> includeImage(List<Item> itemList) throws IOException {
    	List<ItemImage> includeImageList = new ArrayList<>();
    	
    	for (Item i : itemList) {
    		Resource imageResource = mapper.selectImage1(i.getItemNo());
    		String image = null;
    		
    		if (imageResource != null) {
    			byte[] bytes = imageResource.getContentAsByteArray();
    			image = Base64.getEncoder().encodeToString(bytes);
    		}
    		ItemImage item = new ItemImage(i, image);
    		
    		User user = userMapper.selectByUserNo(i.getUserNo());
    		item.setUserNick(user.getUserNick());
    		
    		includeImageList.add(item); 
    	}
    	
    	return includeImageList;
    }
    
    // List 정렬
    @Transactional(readOnly = true)
    public List<ItemImage> sortByOrder(List<ItemImage> itemList, String sortOrder) {
    	LocalDateTime now = LocalDateTime.now();
    	List<ItemImage> list = new ArrayList<>();
    	for (ItemImage i : itemList) {
    		if (i.getItemEnd().isAfter(now)) {
    			list.add(i);
    		}
    	}
    	
        switch (sortOrder) {
            case "new":
                Collections.sort(list, Comparator.comparing(ItemImage::getItemStart));
                break;
            case "deadline":
                Collections.sort(list, Comparator.comparing(ItemImage::getItemEnd));
                break;
            case "popular":
                // 인기 항목 정렬 로직 추가 필요 (예: 경매기록 많은순)
                // Collections.sort(itemList, Comparator.comparing(Item::getViewCount).reversed());
                break;
            case "asc":
                Collections.sort(list, Comparator.comparing(ItemImage::getItemPrice));
                break;
            case "desc":
                Collections.sort(list, Comparator.comparing(ItemImage::getItemPrice).reversed());
                break;
            default:
                break;
        }
        return list;
    }


}
