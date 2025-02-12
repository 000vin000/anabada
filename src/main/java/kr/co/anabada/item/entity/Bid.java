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
public class Bid {
	private int bidNo;
	private int itemNo;
	private int userNo;
	private int bidPrice;
	private LocalDateTime bidTime;
	private String userNick;
}
