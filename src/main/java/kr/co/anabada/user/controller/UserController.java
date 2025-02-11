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
        String result = userService.joinUser(user);
        if ("회원가입 성공".equals(result)) {
            return "redirect:/user/login";
        } else {
            model.addAttribute("error", result);
            return "user/join";
        }
    }

    @PostMapping("/login")
    public String loginUser(User user, HttpSession session, Model model) {
        String result = userService.loginUser(user.getUserId(), user.getUserPw());
        if ("로그인 성공".equals(result)) {
            session.setAttribute("loggedInUser", user.getUserId());
            return "redirect:/";
        } else {
            model.addAttribute("error", result);
            return "user/login";
        }
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
