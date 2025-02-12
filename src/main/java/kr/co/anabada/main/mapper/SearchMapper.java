package kr.co.anabada.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.co.anabada.item.entity.Item;

@Mapper
public interface SearchMapper {
	// 상품명 검색
	@Select("SELECT * FROM item WHERE itemName LIKE CONCAT('%', #{keyword}, '%')")
    List<Item> selectByItemName(String keyword);
	
	// 닉네임 검색
	@Select("SELECT * FROM item WHERE userNo = (SELECT userNo FROM user WHERE userName = #{userName})")
	List<Item> selectByUserName(String keyword);
}
