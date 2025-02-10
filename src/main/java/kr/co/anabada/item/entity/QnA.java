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
public class QnA {
	private int qnaNo;
	private int userNo;
	private int itemNo;
	private String qnaName;
	private String qnaQ;
	private String qnaA;
	private LocalDateTime qnaQDate;
	private LocalDateTime qnaADate;
}
