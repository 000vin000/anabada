package kr.co.anabada.main.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.anabada.item.entity.Item;
import kr.co.anabada.main.mapper.MainMapper;

@Service
public class MainService {
    @Autowired
    private MainMapper mapper;
    
    @Transactional(readOnly = true)
    public List<Item> selectAll() {
        return mapper.selectAll();
    }
    
    @Transactional(readOnly = true)
    public Resource selectImage1(int itemNo) {
        return mapper.selectImage1(itemNo);
    }

    @Transactional(readOnly = true)
    public List<Item> sortByOrder(List<Item> itemList, String sortOrder) {
    	LocalDateTime now = LocalDateTime.now();
    	List<Item> list = new ArrayList<>();
    	for (Item i : itemList) {
    		if (i.getItemEnd().isAfter(now)) {
    			list.add(i);
    		}
    	}
    	
        switch (sortOrder) {
            case "new":
                Collections.sort(list, Comparator.comparing(Item::getItemStart));
                break;
            case "deadline":
                Collections.sort(list, Comparator.comparing(Item::getItemEnd));
                break;
            case "popular":
                // 인기 항목 정렬 로직 추가 필요 (예: 경매기록 많은순)
                // Collections.sort(itemList, Comparator.comparing(Item::getViewCount).reversed());
                break;
            case "asc":
                Collections.sort(list, Comparator.comparing(Item::getItemPrice));
                break;
            case "desc":
                Collections.sort(list, Comparator.comparing(Item::getItemPrice).reversed());
                break;
            default:
                break;
        }
        return list;
    }
}
