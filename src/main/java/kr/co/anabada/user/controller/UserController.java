package kr.co.anabada.user.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import kr.co.anabada.user.entity.User;
import kr.co.anabada.user.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;
    
    // 비밀번호 패턴 정의
    private static final String PASSWORD_PATTERN = "^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[@#$%^&+=!])(?=\\S+$).{6,}$";
    private static final Pattern pattern = Pattern.compile(PASSWORD_PATTERN);

    @GetMapping("/join")
    public String showJoinForm(Model model) {
    	model.addAttribute("user", new User());
        return "user/join";
    }

    @GetMapping("/login")
    public String showLoginForm() {
        return "user/login";
    }
    
    
    @PostMapping("/join")
    public String registerUser(@ModelAttribute("user") @Valid User user,
                               BindingResult bindingResult,
                               @RequestParam("userPhone1") String phone1,
                               @RequestParam("userPhone2") String phone2,
                               @RequestParam("userPhone3") String phone3,
                               Model model) {
        // 전화번호 조합 및 설정
        if (!phone1.isEmpty() && !phone2.isEmpty() && !phone3.isEmpty()) {
            String phoneNumber = phone1 + "-" + phone2 + "-" + phone3;
            if (!phoneNumber.matches("^\\d{3}-\\d{3,4}-\\d{4}$")) {
                bindingResult.rejectValue("userPhone", "error.userPhone", "올바른 전화번호 형식이 아닙니다.");
            } else {
                // 수정: 하이픈(-)을 제거한 전화번호 설정
                user.setUserPhone(phoneNumber.replaceAll("-", ""));
            }
        } else {
            bindingResult.rejectValue("userPhone", "error.userPhone", "전화번호는 필수 입력값입니다.");
        }
        

        // 비밀번호 일치 여부 확인
        if (!user.getUserPw().equals(user.getUserPw2())) {
            bindingResult.rejectValue("userPw2", "error.userPw2", "비밀번호가 일치하지 않습니다.");
        }
        // 비밀번호 형식 검사
        if (!pattern.matcher(user.getUserPw()).matches()) {
            bindingResult.rejectValue("userPw", "error.userPw", "비밀번호는 특수문자, 문자, 숫자를 포함하며 6자 이상이어야 합니다.");
        }        
        // 이메일 중복 검사
        if (userService.isUserEmailDuplicate(user.getUserEmail())) {
            bindingResult.rejectValue("userEmail", "error.userEmail", "이미 사용 중인 이메일입니다.");
        }
        // 전화번호 중복 검사
        if (userService.isUserPhoneDuplicate(user.getUserPhone())) {
            bindingResult.rejectValue("userPhone", "error.userPhone", "이미 사용 중인 전화번호입니다.");
        }
        
        // 유효성 검사 오류 확인
        if (bindingResult.hasErrors()) {
            return "user/join";
        }
        
        try {
            String result = userService.joinUser(user);
            if ("회원가입 성공".equals(result)) {
                return "redirect:/user/login";
            } else {
                model.addAttribute("error", result);
                return "user/join";
            }
        } catch (Exception e) {
            model.addAttribute("error", "회원가입 중 문제가 발생했습니다.");
            return "user/join";
        }
    }
   
    //회원가입 유효성 검사 ( 즉시 )
    @GetMapping("/check-duplicate/{field}")
    @ResponseBody
    public Map<String, Boolean> checkDuplicate(@PathVariable String field, @RequestParam String value) {
        boolean isDuplicate = false;

        switch (field) {
            case "userId":
                isDuplicate = userService.isUserIdDuplicate(value);
                break;
            case "userNick":
                isDuplicate = userService.isUserNickDuplicate(value);
                break;
            case "userEmail":
                isDuplicate = userService.isUserEmailDuplicate(value);
                break;
            case "userPhone":
                value = value.replaceAll("-", "");
                if (!value.matches("^\\d{10,11}$")) {
                    // 전화번호 형식이 잘못된 경우 명확한 응답 반환
                    Map<String, Boolean> invalidResponse = new HashMap<>();
                    invalidResponse.put("isDuplicate", false);
                    invalidResponse.put("invalidFormat", true); 
                    return invalidResponse;
                }
                isDuplicate = userService.isUserPhoneDuplicate(value);
                break;


            default:
                throw new IllegalArgumentException("Invalid field for duplication check: " + field);
        }

        Map<String, Boolean> response = new HashMap<>();
        response.put("isDuplicate", isDuplicate);
        return response;
    }


    @PostMapping("/login")
    public String loginUser(User user, HttpSession session, Model model) {
        try {
            // 로그인 처리 로직 호출
            String result = userService.loginUser(user.getUserId(), user.getUserPw());
            if ("로그인 성공".equals(result)) {
                // 주석: 로그인 성공 시 사용자의 전체 정보를 조회하여 세션에 저장
                User fullUserInfo = userService.getUserByUserId(user.getUserId());
                session.setAttribute("loggedInUser", fullUserInfo); // 세션에 사용자 전체 정보 저장
                return "redirect:/"; // 로그인 성공 시 메인 페이지로 리다이렉트
            } else {
                model.addAttribute("error", result); // 에러 메시지 전달
                return "user/login";
            }
        } catch (Exception e) {
            model.addAttribute("error", "로그인 중 문제가 발생했습니다. 관리자에게 문의하세요."); // 예외 처리 메시지 전달
            return "user/login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션 무효화 처리
        return "redirect:/"; // 로그아웃 후 메인 페이지로 리다이렉트
    }
    
}
