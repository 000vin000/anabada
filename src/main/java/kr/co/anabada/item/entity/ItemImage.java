package kr.co.anabada.item.entity;

import java.time.Duration;
import java.time.LocalDateTime;

import org.springframework.core.io.Resource;

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
	private String image;
	private String userNick;	// 유저 닉네임
	
	public ItemImage(Item item, String image) {
		this.itemNo = item.getItemNo();
		this.userNo = item.getUserNo();
		this.itemGender = item.getItemGender();
		this.itemCate = item.getItemCate();
		this.itemAuction = item.getItemAuction();
		this.itemStart = item.getItemStart();
		this.itemEnd = item.getItemEnd();
		this.itemPrice = item.getItemPrice();
		this.itemName = item.getItemName();
		this.itemContent = item.getItemContent();
		this.itemStatus = item.getItemStatus();
		this.image = image;
	}
	
	public String get(LocalDateTime itemEnd) {
		return String.valueOf(itemEnd.getSecond());
	}
	public String getCountDown(LocalDateTime itemEnd) {
		LocalDateTime now = LocalDateTime.now();
		Duration countdown = Duration.between(now, itemEnd);
		
		long hour = countdown.getSeconds() / 60 / 60;
		
		long day = hour / 24;
		hour = hour % 24;
		
		return day + "일 " + hour +"시간";
	}
}
