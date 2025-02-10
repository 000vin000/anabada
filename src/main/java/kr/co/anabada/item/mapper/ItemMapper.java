package kr.co.anabada.item.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;

import kr.co.anabada.item.entity.Item;

@Mapper
public interface ItemMapper {
	@Insert("INSERT INTO item (userNo, cateNo, itemAuction, itemStart, itemEnd, itemPrice, itemName, itemContent, itemStatus) " +
            "VALUES (#{userNo}, #{cateNo}, #{itemAuction}, #{itemStart}, #{itemEnd}, #{itemPrice}, #{itemName}, #{itemContent}, #{itemStatus})")
    @Options(useGeneratedKeys = true, keyProperty = "itemNo", keyColumn = "itemNo")
    int save(Item item);

}
