package kr.co.anabada.user.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {
	private int usreNo;
	private String userName;
	private String userNick;
	private String userId;
	private String userPw;
	private String userAdd;
	private String userEmail;
	private String userPhone;
}
