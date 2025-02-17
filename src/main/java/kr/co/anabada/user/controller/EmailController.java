package kr.co.anabada.user.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpSession;
import kr.co.anabada.user.service.EmailService;

@Controller
@RequestMapping("/email")
public class EmailController {

    @Autowired
    private EmailService emailService;

    @GetMapping("/verification")
    public String showEmailVerificationForm(HttpSession session) {
        // 추가: 기존 인증 정보 제거
        session.removeAttribute("emailVerified");
        session.removeAttribute("verificationEmail");
        session.removeAttribute("verificationCode");
        
        return "user/emailVerification";
    }

    @PostMapping(value = "/send-verification", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, String> sendVerificationEmail(@RequestParam String email, HttpSession session) {
        String verificationCode = emailService.generateVerificationCode();
        emailService.sendVerificationEmail(email, verificationCode);

        // 세션에 인증 코드 저장 (5분 후 만료)
        session.setAttribute("verificationCode", verificationCode);
        session.setAttribute("verificationEmail", email);
        session.setMaxInactiveInterval(300); // 5분

        Map<String, String> response = new HashMap<>();
        response.put("message", "인증 코드가 이메일로 전송되었습니다.");
        return response;
    }

    @PostMapping(value = "/verify", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, String> verifyEmail(@RequestParam String code, HttpSession session) {
        String storedCode = (String) session.getAttribute("verificationCode");

        Map<String, String> response = new HashMap<>();
        if (storedCode != null && storedCode.equals(code)) {
            session.setAttribute("emailVerified", true);
            response.put("message", "이메일 인증이 완료되었습니다.");
            response.put("status", "success");
        } else {
            response.put("message", "인증 코드가 일치하지 않습니다.");
            response.put("status", "fail");
        }
        
        return response;
    }
}