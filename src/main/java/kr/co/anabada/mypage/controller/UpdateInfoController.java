package kr.co.anabada.mypage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
import kr.co.anabada.mypage.service.UpdateInfoService;
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
        model.addAttribute("user", loggedInUser); 
        return "mypage/updateinfo"; //
    }

    // 회원정보 수정 처리
    @PostMapping("/updateinfo")
    public String updateUserInfo(User updatedUser, HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/user/login"; // 로그인 페이지로
        }
        String result = userService.updateUserInfo(updatedUser, loggedInUser.getUserId());
        if ("회원정보 변경 성공".equals(result)) {
            // 세션 정보 업데이트
            session.setAttribute("loggedInUser", updatedUser);
            model.addAttribute("success", "회원정보가 성공적으로 변경되었습니다.");
            return "redirect:/mypage"; // 
        } else {
            model.addAttribute("error", result);
            return "mypage/updateinfo"; // 다시 수정 페이지로 이동
        }
    }
    
    // 회원 탈퇴 관련 서비스
    @Autowired
    private UpdateInfoService updateInfoService; 
    
    @GetMapping("/deactivate")
    public String showDeactivateForm(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/user/login";
        }
        return "mypage/deactivate"; // deactivate.jsp 페이지로 이동
    }

    @PostMapping("/deactivate")
    public String deactivateUser(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/user/login";
        }

        boolean success = updateInfoService.deactivateUser(loggedInUser.getUserNo());
        if (success) {
            session.invalidate(); // 세션 무효화 처리
            return "redirect:/";  // 메인 페이지로 리다이렉트
        } else {
            model.addAttribute("error", "회원 탈퇴 처리 중 오류가 발생했습니다.");
            return "mypage/updateinfo";
        }
    }
} 