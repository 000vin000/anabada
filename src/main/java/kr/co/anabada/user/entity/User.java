package kr.co.anabada.user.entity;

import java.time.LocalDateTime;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import kr.co.anabada.user.validator.PasswordMatch;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@PasswordMatch
public class User {
    private int userNo;
    
    @NotBlank(message = "필수 입력값입니다.")
    private String userId;
    
    @NotBlank(message = "필수 입력값입니다.")
    private String userPw;
    
    @NotBlank(message = "필수 입력값입니다.")
    private String userPw2;
    
    @NotBlank(message = "필수 입력값 입니다.")
    private String userName;
    
    @NotBlank(message = "필수 입력값입니다.")
    private String userNick;
    
    @NotBlank(message = "필수 입력값입니다.")
    private String userAdd;
    
    @NotBlank(message = "필수 입력값입니다.")
    @Email(message = "올바른 이메일 형식이 아닙니다.")
    private String userEmail;
    
    @Pattern(regexp = "^\\d{3}-\\d{3,4}-\\d{3,4}$", message = "올바른 전화번호 형식이 아닙니다.")
    private String userPhone;
    
    private String userStatus;
    private LocalDateTime userDeactiveDate;
}
