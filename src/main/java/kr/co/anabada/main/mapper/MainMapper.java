package kr.co.anabada.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.core.io.ByteArrayResource;

import kr.co.anabada.item.entity.Item;
import kr.co.anabada.item.entity.ItemImage;

@Mapper
public interface MainMapper {
	// 전체 상품 정보
	@Select("SELECT * FROM item")
	List<Item> selectAll();

	// itemNo의 image
	@Select("SELECT imageFile FROM image WHERE imageNo = #{itemImage}")
	ByteArrayResource selectImage1(int itemImage);
	
	// 상품명 검색
	@Select("SELECT * FROM item WHERE itemName LIKE CONCAT('%', #{keyword}, '%')")
    List<Item> selectByItemName(String keyword);
	
	// 닉네임 검색
	@Select("SELECT * FROM item WHERE userNo = (SELECT userNo FROM user WHERE userName = #{userName})")
	List<Item> selectByUserName(String keyword);
}
