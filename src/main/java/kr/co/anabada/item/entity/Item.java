package kr.co.anabada.item.entity;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Item {
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
	
	
	public String getItemAuctionStr(String itemAuction) {
		if (itemAuction.equals("waiting")) {
			return getStartTime(this.itemStart);
		} else if (itemAuction.equals("bidding")) {
			return getCountDown(this.itemEnd);
		} else {
			return null;
		}
	}
	
	public String getCountDown(LocalDateTime itemEnd) {
		LocalDateTime now = LocalDateTime.now();
		Duration countdown = Duration.between(now, itemEnd);
		
		long hour = countdown.getSeconds() / 60 / 60;
		
		long day = hour / 24;
		hour = hour % 24;
		
		return day + "일 " + hour +"시간";
	}
	
	public String getStartTime(LocalDateTime itemStart) {
		return itemStart.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm 오픈"));
	}

}
