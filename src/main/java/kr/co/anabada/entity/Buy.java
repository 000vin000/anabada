package kr.co.anabada.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Buy {
	private int buyNo;
	private int itemNo;
	private int usreNo;
}
