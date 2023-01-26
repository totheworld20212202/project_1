package com.lec.spring.config;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
/*
* 실패한 Exception을 검사하여 해당 Exception에 맞는 에러 메시지를 로그인 페이지에 같이 전달하여 
* 로그인 실패 이유를 사용자에게 노출시킵니다.
* 
* 아래에 구현된 Exception을 포함한 AuthenticationException의 종류는 다음과 같습니다.
*    UsernameNotFoundException : 계정 없음
*    BadCredentialsException : 비밀번호 불일치
*    AccountExpiredException : 계정만료
*    CredentialExpiredException : 비밀번호 만료
*    DisabledException : 계정 비활성화
*    LockedException : 계정잠김
*/

public class CustomLoginFailureHandler implements AuthenticationFailureHandler{

	private final String DEFAULT_FAILURE_URL = "/user/login?error=true";	// Post method 필요함. 
	// loginsuccess일경우 그 form submit시에 낚아채서 원래 의도된 url로 가게 만들거나 아니면 default url로 가게함
	// loginfailure일경우 위의 DEFAULT_FAILURE_URL가 아래에서 dispatcher에서 forwarding되면서 내부적으로 
	// /user/login?error=true로 보내게됨. 뒤에 error=true도 어쨋든 /user/login으로보내지는것
	// 그러면, controller에서도 등록이 되어야 함. success의 경우 등록이 필요없음. 
	// success일때 controller에 post등록 안해도 문제가 안되었던것은 security가 submit할때 낚아채기 때문 
	// failure일때는 get방식으로 url이 전달되는데, submit 코드도 함께 동작하는것 같음 
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		System.out.println("### 로그인 실패 : onAuthenticationFailure() 호출 ###");
		
		String errorMessage = null;
		
		//=================================================
		//< set the error message
		//=================================================
		//< incorrect the identify or password
		if(exception instanceof BadCredentialsException || exception instanceof InternalAuthenticationServiceException) {
			errorMessage = "아이디나 비밀번호가 맞지 않습니다. 다시 확인해 주십시오.";
		}
		//< account is disabled
		else if(exception instanceof DisabledException) {
			errorMessage = "계정이 비활성화 되었습니다. 관리자에게 문의하세요.";
		}
		//< expired the credential
		else if(exception instanceof CredentialsExpiredException) {
			errorMessage = "비밀번호 유효기간이 만료 되었습니다. 관리자에게 문의하세요.";
		}
		else {
			errorMessage = "알수 없는 이유로 로그인에 실패하였습니다. 관리자에게 문의하세요.";
		}
		//< set attributes
		request.setAttribute("errorMessage", errorMessage);
		request.setAttribute("username", request.getParameter("username"));
		//< forwarding
		request.getRequestDispatcher(DEFAULT_FAILURE_URL).forward(request, response);	// Post method 필요함. 
	}

}
