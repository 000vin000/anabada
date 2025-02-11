package kr.co.anabada.mypage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.anabada.mypage.entity.Favor;
import kr.co.anabada.mypage.mapper.FavorMapper;

@Service
public class FavorService {
	@Autowired
	private FavorMapper favorMapper;
	
//	@Autowired
//	ItemMapper itemMapper;
	
	public List<Favor> selectMyFavor(int userNo) {
		List<Favor> list = favorMapper.selectMyFavor(userNo);
		
		return list;
	}
	
	public int addFavor(int userNo, int itemNo) {
//		if (!favorMapper.)
		return favorMapper.addFavor(userNo, itemNo);
	}
	
	public int removeFavor(int userNo, int itemNo) {
		return favorMapper.removeFavor(userNo, itemNo);
	}
}

// TODO 마이페이지, 물품페이지가 완성되면 마이페이지에서 연결해서 부르기, 물품페이지에서 버튼을 눌렀을때 등록하고 삭제되도록 구현하기