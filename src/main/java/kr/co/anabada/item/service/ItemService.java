package kr.co.anabada.item.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.anabada.item.entity.Item;
import kr.co.anabada.item.mapper.ItemMapper;

@Service
public class ItemService {
	@Autowired
	private ItemMapper itemMapper;
	
	public void save(Item item) {
        itemMapper.save(item);
    }
}
