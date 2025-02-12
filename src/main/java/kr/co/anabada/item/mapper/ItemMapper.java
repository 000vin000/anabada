package kr.co.anabada.item.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.anabada.item.entity.Item;

@Mapper
public interface ItemMapper {
	@Insert("INSERT INTO item (userNo, itemAuction, itemStart, itemEnd, itemPrice, itemName, itemContent, itemStatus, itemImage) " +
            "VALUES (#{userNo}, #{itemAuction}, #{itemStart}, #{itemEnd}, #{itemPrice}, #{itemName}, #{itemContent}, #{itemStatus}, #{itemImage})")
    @Options(useGeneratedKeys = true, keyProperty = "itemNo", keyColumn = "itemNo")
    int save(Item item);
	
	@Update("UPDATE item SET itemAuction = #{itemAuction} WHERE itemNo = #{itemNo}")
    int updateAuctionStatus(@Param("itemNo") int itemNo, @Param("itemAuction") String itemAuction);

	@Select("SELECT * FROM item WHERE userNo = #{userNo}")
    List<Item> findItemsByUserNo(int userNo);
	
	@Select("SELECT * FROM item WHERE itemNo = #{itemNo} ORDER BY itemEnd ASC")
	Item findItemsByItemNo(int itemNo); // jhu
	
}
