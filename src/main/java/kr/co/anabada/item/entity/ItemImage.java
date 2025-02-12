package kr.co.anabada.item.entity;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ItemImage {
	private int itemNo;
	private int userNo;
	private String itemGender;
	private String itemCate; //ENUM 변경으로 컬럼명 itemCate > itemCate, 값 int >String
	private String itemAuction; //ENUM 변경으로 값 int >String
	private LocalDateTime itemStart;
	private LocalDateTime itemEnd;
	private int itemPrice;
	private String itemName;
	private String itemContent;
	private String itemStatus;
	private byte[] image;
}
