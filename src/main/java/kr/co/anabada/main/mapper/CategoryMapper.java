package kr.co.anabada.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.co.anabada.item.entity.Item;

@Mapper
public interface CategoryMapper {
	// 성별&옷 종류 검색
	@Select("SELECT * FROM item WHERE itemGender = #{itemGender} "
					+ "AND itemCate = #{itemCate} "
					+ "AND itemAuction NOT IN ('sold', 'closed')")
	List<Item> selectByGenderAndCate(String itemGender, String itemCate);
}
