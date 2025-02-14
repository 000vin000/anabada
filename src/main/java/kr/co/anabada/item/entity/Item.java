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
	
	public String getItemStatusInKorean() {
	    if (this.itemAuction == null) {
	        return null; 
	    }

	    switch (this.itemAuction.trim().toLowerCase()) {
	        case "waiting":
	            return "대기중";
	        case "bidding":
	            return "입찰중";
	        case "sold":
	            return "판매완료";
	        case "closed":
	            return "종료";
	        default:
	            return "알 수 없음";
	    }
	}

    public void setItemStatusFromString(String auction) {
        this.itemAuction = auction;
    }

}
