package kr.co.anabada.mypage.controller;

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
@RequestMapping("/mypage")
public class UpdateInfoController {

    @Autowired
    private UserService userService;

    // 회원정보 수정 페이지 표시
    @GetMapping("/updateinfo")
    public String showUpdateInfoForm(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/user/login"; // 로그인 페이지로 리다이렉트
        }
        model.addAttribute("user", loggedInUser); // 현재 사용자 정보를 모델에 추가
        return "mypage/updateinfo"; // updateinfo.jsp로 이동
    }

    // 회원정보 수정 처리
    @PostMapping("/updateinfo")
    public String updateUserInfo(User updatedUser, HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/user/login"; // 로그인 페이지로 리다이렉트
        }
        String result = userService.updateUserInfo(updatedUser, loggedInUser.getUserId());
        if ("회원정보 변경 성공".equals(result)) {
            // 세션 정보 업데이트
            session.setAttribute("loggedInUser", updatedUser);
            model.addAttribute("success", "회원정보가 성공적으로 변경되었습니다.");
            return "redirect:/mypage"; // 마이페이지 메인으로 리다이렉트
        } else {
            model.addAttribute("error", result);
            return "mypage/updateinfo"; // 다시 수정 페이지로 이동
        }
    }
}