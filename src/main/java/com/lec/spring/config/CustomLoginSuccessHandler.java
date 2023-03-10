package com.lec.spring.config;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

//AuthenticationSuccessHandler(I)
//└─ SavedRequestAwareAuthenticationSuccessHandler
//https://docs.spring.io/spring-security/site/docs/4.0.x/apidocs/org/springframework/security/web/authentication/SavedRequestAwareAuthenticationSuccessHandler.html

public class CustomLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler{

	public CustomLoginSuccessHandler(String defaultTargetUrl) {
		// 로그인후 특별히 redirect할 url이 없는 경우 기본적으로 redirect할 url 
		setDefaultTargetUrl(defaultTargetUrl);	//localhost:8080/user/login으로 직접 request할때 
	}											// 로그인 성공시 redirect 할 곳 세팅 
	
	// 로그인 성공 직후 호출 
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {
		System.out.println("### 로그인 성공: onAuthenticationSuccess() 호출 ###");
    	
    	// 로그인 정보 출력해보기
    	System.out.println("접속IP: " + getClientIp(request));
    	PrincipalDetails userDetails = (PrincipalDetails)authentication.getPrincipal();
    	System.out.println("username: " + userDetails.getUsername());
    	System.out.println("password: " + userDetails.getPassword());
    	List<String> roleNames = new ArrayList<>();   // 권한이름들
    	authentication.getAuthorities().forEach(authority -> {
    		roleNames.add(authority.getAuthority());
    	});
    	System.out.println("authorities: " + roleNames);

        // 로그인시간을 세션에 저장하기 (※ logout 예제에서 사용 )
        LocalDateTime loginTime = LocalDateTime.now();
        System.out.println("로그인 시간: " + loginTime);
        request.getSession().setAttribute("loginTime", loginTime);
    	
        // 로그인 직전 url 로 redirect 하기
        super.onAuthenticationSuccess(request, response, authentication);	// override되기전 method on~
		// 위에는 위에 override한 내용 뿐아니라 super.에는 다른 method들도 같이 들어있어서 login시 그 다음으로 이동하게 세팅되어있는코드 수행된다.
	}	// super.onAu~ 에 나머지 코드가 들어있다. 
	 // request 를 한 client ip 가져오기
    public static String getClientIp(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
         if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
             ip = request.getHeader("Proxy-Client-IP");
         }
         if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
             ip = request.getHeader("WL-Proxy-Client-IP");
         }
         if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
             ip = request.getHeader("HTTP_CLIENT_IP");
         }
         if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
             ip = request.getHeader("HTTP_X_FORWARDED_FOR");
         }
         if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
             ip = request.getRemoteAddr();
         }
         return ip;
    }    
}
