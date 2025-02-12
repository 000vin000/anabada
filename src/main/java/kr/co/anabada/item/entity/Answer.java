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
public class Answer {
	private int aNo;
	private int qNo;
	private int userNo;
	private String aContent;
	private LocalDateTime aDate;

}
