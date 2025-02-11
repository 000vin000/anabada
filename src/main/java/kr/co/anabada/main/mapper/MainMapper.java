package kr.co.anabada.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.core.io.ByteArrayResource;

import kr.co.anabada.item.entity.Item;

@Mapper
public interface MainMapper {
	// 전체 상품 정보
	@Select("SELECT * FROM item")
	List<Item> selectAll();

	// itemNo의 image
	@Select("SELECT imageFile FROM image WHERE imageNo = #{itemImage}")
	ByteArrayResource selectImage1(int itemImage);
}
