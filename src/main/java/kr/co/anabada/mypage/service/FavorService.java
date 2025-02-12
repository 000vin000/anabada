package kr.co.anabada.mypage.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;

import kr.co.anabada.item.entity.Item;
import kr.co.anabada.item.entity.ItemImage;
import kr.co.anabada.item.mapper.ImageMapper;
import kr.co.anabada.item.mapper.ItemMapper;
import kr.co.anabada.mypage.entity.Favor;
import kr.co.anabada.mypage.mapper.FavorMapper;
import kr.co.anabada.user.entity.User;
import kr.co.anabada.user.mapper.UserMapper;

@Service
public class FavorService {
	@Autowired
	private FavorMapper favorMapper;
	@Autowired
	private ItemMapper itemMapper;
	@Autowired
	private ImageMapper imageMapper;
	@Autowired
	private UserMapper userMapper;
	
	public List<ItemImage> selectMyFavor(int userNo) throws IOException {
		List<Favor> list = favorMapper.selectMyFavor(userNo);
		List<ItemImage> favorItemList = new ArrayList<>();
		for (Favor f : list) {
			Item item = itemMapper.findItemsByItemNo(f.getItemNo());
			User user = userMapper.selectByUserNo(item.getUserNo());
			Resource imageRep = imageMapper.imageRep(f.getItemNo());
			String image = null;
			if (imageRep != null) {
				byte[] bytes = imageRep.getContentAsByteArray();
				image = Base64.getEncoder().encodeToString(bytes);
			}
			ItemImage favorItem = new ItemImage(item, image);
			favorItem.setUserNick(user.getUserNick());
			favorItemList.add(favorItem);
		}
		
		return favorItemList;
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