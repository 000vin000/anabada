package kr.co.anabada.mypage.favor;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.anabada.mypage.entity.Favor;

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
