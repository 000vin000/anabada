package kr.co.anabada.config;

import kr.co.anabada.user.filter.LoginCheckFilter;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class FilterConfig {

    @Bean(name = "customLoginCheckFilter")
    public FilterRegistrationBean<LoginCheckFilter> loginCheckFilter() {
        FilterRegistrationBean<LoginCheckFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new LoginCheckFilter());
        
        // 필터가 적용될 URL 패턴 설정
        registrationBean.addUrlPatterns("/mypage/*", "/item/*");
        registrationBean.setOrder(1); // 필터 실행 순서 설정
        
        return registrationBean;
    }
}
