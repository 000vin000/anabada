package kr.co.anabada.main.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.anabada.item.entity.Image;
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
	public byte[] selectImage1(int itemNo) {
		return mapper.selectImage1(itemNo);
	}
}
