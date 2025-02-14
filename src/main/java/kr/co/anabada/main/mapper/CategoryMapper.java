package kr.co.anabada.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.co.anabada.item.entity.Item;

@Mapper
public interface CategoryMapper {
	// 성별&옷 종류 검색
	@Select("SELECT * FROM item WHERE itemGender = #{itemGender} "
					+ "AND itemCate = #{itemCate} "
					+ "AND itemAuction NOT IN ('sold', 'closed')")
	List<Item> selectByGenderAndCate(String itemGender, String itemCate);

	// 성별&전체 검색
	@Select("SELECT * FROM item WHERE itemGender = #{itemGender} "
					+ "AND itemAuction NOT IN ('sold', 'closed')")
	List<Item> searchGender(String itemGender);

	// 전체&옷 종류 검색
	@Select("SELECT * FROM item WHERE itemCate = #{itemCate} "
					+ "AND itemAuction NOT IN ('sold', 'closed')")
	List<Item> searchClothesType(String itemCate);
}
