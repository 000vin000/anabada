package kr.co.anabada.main.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.anabada.item.entity.Item;
import kr.co.anabada.main.mapper.CategoryMapper;

@Service
public class CategoryService {
	@Autowired
	private CategoryMapper mapper;
	
	public List<Item> searchItems(String gender, String clothesType) {
		return mapper.selectByGenderAndCate(gender, clothesType);
	}

}
