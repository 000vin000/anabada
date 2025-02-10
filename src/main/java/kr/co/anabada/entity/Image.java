package kr.co.anabada.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Image {
	private int imageNo;
	private int itemNo;
	private byte[] imageFile;
}
