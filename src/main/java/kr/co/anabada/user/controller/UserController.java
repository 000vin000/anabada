package kr.co.anabada.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
import kr.co.anabada.user.entity.User;
import kr.co.anabada.user.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/join")
    public String showJoinForm() {
        return "user/join";
    }

    @GetMapping("/login")
    public String showLoginForm() {
        return "user/login";
    }

    @PostMapping("/join")
    public String registerUser(User user, Model model) {
        try {
            // 회원가입 처리 로직 호출
            String result = userService.joinUser(user);
            if ("회원가입 성공".equals(result)) {
                return "redirect:/user/login"; // 회원가입 성공 시 로그인 페이지로 리다이렉트
            } else {
                model.addAttribute("error", result); // 에러 메시지 전달
                return "user/join";
            }
        } catch (Exception e) {
            model.addAttribute("error", "회원가입 중 문제가 발생했습니다."); // 예외 처리 메시지 전달
            return "user/join";
        }
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
