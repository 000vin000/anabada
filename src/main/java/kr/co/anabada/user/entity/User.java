package kr.co.anabada.user.entity;

import jakarta.persistence.*; // JPA 관련 어노테이션
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity // JPA 엔티티로 선언
@Table(name = "user") // DB의 'user' 테이블과 매핑
public class User {

    @Id // 기본 키 설정
    @GeneratedValue(strategy = GenerationType.IDENTITY) // AUTO_INCREMENT 설정
    @Column(name = "userNo") // DB 컬럼 이름과 매핑
    private int userNo;

    @Column(name = "userId", unique = true, nullable = false, length = 20)
    private String userId;

    @Column(name = "userPw", nullable = false, length = 255)
    private String userPw;

    @Column(name = "userName", nullable = false, length = 20)
    private String userName;

    @Column(name = "userNick", unique = true, nullable = false, length = 20)
    private String userNick;

    @Column(name = "userAdd", nullable = false, length = 255)
    private String userAdd;

    @Column(name = "userEmail", unique = true, nullable = false, length = 255)
    private String userEmail;

    @Column(name = "userPhone", nullable = false, length = 20)
    private String userPhone;
}
