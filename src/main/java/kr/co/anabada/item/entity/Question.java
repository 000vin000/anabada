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
public class Question {
	
	private int qNo;
	private int itemNo;
	private int userNo;
	private String qTitle;
	private String qContent;
	private LocalDateTime qDate;
}
