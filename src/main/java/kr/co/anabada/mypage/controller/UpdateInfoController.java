package kr.co.anabada.mypage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import kr.co.anabada.mypage.service.UpdateInfoService;
import kr.co.anabada.user.entity.User;
import kr.co.anabada.user.service.UserService;

@Controller
@RequestMapping("/mypage")
public class UpdateInfoController {

    @Autowired
    private UserService userService;

    // 회원 탈퇴 관련 서비스 + 업데이트에 이용 
    @Autowired
    private UpdateInfoService updateInfoService; 
    
    // 회원정보 수정 페이지 표시
    @GetMapping("/updateinfo")
    public String showUpdateInfoForm(HttpSession session, Model model) {
    	
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        Boolean passwordVerified = (Boolean) session.getAttribute("passwordVerified");
        

        // 로그인 상태 및 비밀번호 확인 여부 검사
        if (loggedInUser == null || passwordVerified == null || !passwordVerified) {
            return "redirect:/mypage/passwordcheck?redirectTo=/mypage/updateinfo";
        }

        // 전화번호 분리
        String userPhone = loggedInUser.getUserPhone();
        String phone1 = "";
        String phone2 = "";
        String phone3 = "";

        if (userPhone != null && userPhone.length() >= 10) {
            phone1 = userPhone.substring(0, 3);
            if (userPhone.length() == 10) {
                phone2 = userPhone.substring(3, 6);
                phone3 = userPhone.substring(6);
            } else if (userPhone.length() == 11) {
                phone2 = userPhone.substring(3, 7);
                phone3 = userPhone.substring(7);
            }
        }

        model.addAttribute("user", loggedInUser);
        model.addAttribute("phone1", phone1);
        model.addAttribute("phone2", phone2);
        model.addAttribute("phone3", phone3);
        //메일 정보 추가
        model.addAttribute("userEmail", loggedInUser.getUserEmail());
        model.addAttribute("userAdd", loggedInUser.getUserAdd());

        System.out.println("UpdateInfoController - showUpdateInfoForm: User phone number: " + loggedInUser.getUserPhone());
        System.out.println("UpdateInfoController - showUpdateInfoForm: Separated phone numbers: " + phone1 + ", " + phone2 + ", " + phone3);

        return "mypage/updateinfo"; 
    }

    @PostMapping("/updateinfo")
    public String updateUserInfo(@ModelAttribute("user") @Valid User updatedUser,
                                 BindingResult bindingResult,
                                 HttpSession session,
                                 Model model,
                                 @RequestParam("userPhone1") String phone1,
                                 @RequestParam("userPhone2") String phone2,
                                 @RequestParam("userPhone3") String phone3,
                                 @RequestParam("detailAddress") String detailAddress) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/user/login";
        }

        // 전화번호 조합 및 설정
        if (!phone1.isEmpty() && !phone2.isEmpty() && !phone3.isEmpty()) {
            String phoneNumber = phone1 + "-" + phone2 + "-" + phone3;
            // 수정: 하이픈(-)이 없는 전화번호 형식 검사
            if (!phoneNumber.replaceAll("-", "").matches("^\\d{10,11}$")) {
                bindingResult.rejectValue("userPhone", "error.userPhone", "올바른 전화번호 형식이 아닙니다.");
            } else {
                // 수정: 하이픈(-)을 제거한 전화번호 설정
                updatedUser.setUserPhone(phoneNumber.replaceAll("-", ""));
            }
        } else {
            bindingResult.rejectValue("userPhone", "error.userPhone", "전화번호는 필수 입력값입니다.");
        }
        
        if (!detailAddress.isEmpty()) {
            updatedUser.setUserAdd(updatedUser.getUserAdd() + " " + detailAddress);
        }

        // 유효성 검사 실패 시
        if (bindingResult.hasErrors()) {
            System.out.println("UpdateInfoController - updateUserInfo: 유효성 검사 실패");
            return "mypage/updateinfo";
        }
        
        //수정사항
        if (!updatedUser.getUserPw().equals(updatedUser.getUserPw2())) {
            System.out.println("UpdateInfoController - updateUserInfo: 비밀번호 불일치");
            // 수정: 비밀번호 불일치 오류 메시지를 BindingResult에 추가
            bindingResult.rejectValue("userPw2", "error.userPw2", "비밀번호가 일치하지 않습니다.");
            return "mypage/updateinfo";
        }
        
        // 닉네임, 이메일, 전화번호 중복 검사 (변경된 경우에만)
        if (!loggedInUser.getUserNick().equals(updatedUser.getUserNick()) && userService.isUserNickDuplicate(updatedUser.getUserNick())) {
            System.out.println("UpdateInfoController - updateUserInfo: 닉네임 중복");
            bindingResult.rejectValue("userNick", "error.userNick", "이미 사용 중인 닉네임입니다.");
        }

//        if (!loggedInUser.getUserEmail().equals(updatedUser.getUserEmail()) && userService.isUserEmailDuplicate(updatedUser.getUserEmail())) {
//            System.out.println("UpdateInfoController - updateUserInfo: 이메일 중복");
//            bindingResult.rejectValue("userEmail", "error.userEmail", "이미 사용 중인 이메일입니다.");
//        }

        if (!loggedInUser.getUserPhone().equals(updatedUser.getUserPhone()) && userService.isUserPhoneDuplicate(updatedUser.getUserPhone())) {
            System.out.println("UpdateInfoController - updateUserInfo: 전화번호 중복");
            bindingResult.rejectValue("userPhone", "error.userPhone", "이미 사용 중인 전화번호입니다.");
        }
        
        // 유효성 검사 오류 확인
        if (bindingResult.hasErrors()) {
            System.out.println("UpdateInfoController - updateUserInfo: 유효성 검사 오류");
            return "mypage/updateinfo";
        }
        // 추가: 기존 이메일 정보 유지
        updatedUser.setUserEmail(loggedInUser.getUserEmail());
        

        String result = updateInfoService.updateUserInfo(updatedUser, loggedInUser.getUserId());
        if ("회원정보 변경 성공".equals(result)) {
            // 세션 정보 업데이트
            session.setAttribute("loggedInUser", updatedUser);
            model.addAttribute("successMessage", "회원정보가 성공적으로 변경되었습니다.");
            return "mypage/updateinfo"; // 회원정보 수정 페이지로 이동
        } else {
            model.addAttribute("error", result);
            return "mypage/updateinfo";
        }
    }

    
    // 회원 탈퇴 관련 서비스    
    @GetMapping("/deactivate")
    public String showDeactivateForm(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        Boolean passwordVerified = (Boolean) session.getAttribute("passwordVerified");

        // 로그인 상태 및 비밀번호 확인 여부 검사
        if (loggedInUser == null || passwordVerified == null || !passwordVerified) {
            return "redirect:/mypage/passwordcheck?redirectTo=/mypage/deactivate";
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