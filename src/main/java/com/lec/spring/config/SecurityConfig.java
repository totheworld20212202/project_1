package com.lec.spring.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

// 스프링 시큐리티 설정 
@Configuration	// 스프링 컨테이너에 빈 으로 생성
@EnableWebSecurity	//WebSecurity를 활성화
	// 아래 스프링 시큐리티 필터가 스프링 필터 체인에 등록이 된다. 
public class SecurityConfig extends WebSecurityConfigurerAdapter{

	// PasswordEncoder를 bean으로 IoC에 등록
	// IoC에 등록된다, IoC 내에선 '어디서든' 가져다가 사용할수 있다. 
	
	@Bean
	public PasswordEncoder encoder() {
		System.out.println("PasswordEncoder bean 생성");
		return new BCryptPasswordEncoder();
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		 http.csrf().disable();		//CSRF 비활성화 cross site request forgery 
		 
		 http	// HttpSecurity객체 
		 	 
		 	 /**********************************************
			 * ① request URL 에 대한 접근 권한 세팅
		     * ExpressionInterceptUrlRegistry 객체 리턴.  이하 이 객체의 메소드체이닝
		     **********************************************/		
		 	 .authorizeRequests()
		 	 
		 	 // URL과 접근권한 세팅(들)
		     // ↓ /board/detail/** 주소로 들어오는 요청은 '인증'만 필요. 이걸설정안하면 어떤 url이던 로그인하라고 security가 명령함
//		 	 .antMatchers("/board/detail/**").authenticated()	// 가입하는것이고 밑에것은 가입뿐만아니라 authorization도 얻어야 한다. 
		 	 
		 	 .antMatchers("/user/info/**").authenticated()	// 이것은 db에 내용이 있으면 되는것임. 물론 password 아이디 맞아야함. 
		     // ↓ /board/write/** /board/update/** /board/delete/** 주소로 들어오는 요청은 '인증' 뿐 아니라 ROLE_MEMBER 나 ROLE_ADMIN 권한을 갖고 있어야 한다 ('인가')
//		 	 .antMatchers("/board/write/**", "/board/update/**", "/board/delete/**").access("hasRole('ROLE_MEMBER') or hasRole('ROLE_ADMIN')")
		 	 
		 	 .antMatchers("/user/info/**","/user/homework/**").access("hasRole('ROLE_MEMBER') or hasRole('ROLE_TEACHER') or hasRole('ROLE_ADMIN')")
		 	 .antMatchers("/hwlistupload/**").access("hasRole('ROLE_TEACHER') or hasRole('ROLE_ADMIN')")
		 	 .antMatchers("/user/admin/**").access("hasRole('ROLE_ADMIN')")
		 	 .antMatchers("/regClass/**").access("hasRole('ROLE_MEMBER') or hasRole('ROLE_TEACHER')")
		 	 .antMatchers("/mcq/**").access("hasRole('ROLE_MEMBER') or hasRole('ROLE_TEACHER')")
		 	 // ↓ 그 밖의 다른 요청은 모두 permit! (위 주소들만 아니면 누구나 접근 가능!)
			 .anyRequest().permitAll()
			 .and()  // 다시, HttpSecurity 객체 리턴. 세팅중 다른 세팅 전환시 호출
//			 /******************************************** 
//				 * ② 폼 로그인 설정
//				 * FormLoginConfigurer<HttpSecurity> 리턴.  이하 이 객체의 메소드체이닝
//				 ********************************************/			
			 .formLogin()  // form 기반 인증 페이지 활성화.  만약 .loginPage(url) 가 세팅되어 있지 않으면 '디폴트 로그인' form 페이지가 활성화 된다
			 .loginPage("/user/login")	// 로그인 필요한 상황 발생시 매개변수의 url (로그인 폼) 로 request 발생
			 .loginProcessingUrl("/user/login")
//			 	// "/user/login" url 로 POST request 가 들어오면 시큐리티가 낚아채서 처리, 대신 로그인을 진행해준다.
//				// 이와 같이 하면 Controller 에서 /user/login (POST) 를 굳이 만들지 않아도 된다!
//				// 위 요청이 오면 자동으로 UserDetailsService 타입 빈객체의 loadUserByUsername() 가 실행되어 인증여부 확인진행 <- 이를 제공해주어야 한다.
//			 	// UserDetailsService를 implements 하는 .java를 만들어주어야함. com.lec.spring.config밑에 만들었음. : PrincipalDetailService.java
			 .defaultSuccessUrl("/home")  
//										  // 이것은 localhost:8080/user/login으로 직접 reqeust를 인터넷 주소에 연결할때 수행! 	
			 							  // '직접 /login' → /loginOk 에서 성공하면 "/home" 로 이동시키기
			 // 만약 다른 특정페이지에 진입하려다 로그인 하여 성공하면 해당 페이지로 이동 (너무 편리!)
//			 
//			 // 로그인 성공직후 수행할 코드 
//			 //.successHandler(AuthenticationSuccessHandler)  // 로그인 성공후 수행할 코드.  그리고 , redirect 해야 한다 ex) https://galid1.tistory.com/698
			 .successHandler(new CustomLoginSuccessHandler("/home"))	 
//			 // 로그인 실패하면 수행할 코드 
//			 // .failureHandler(AuthenticationFailureHandler)
			 .failureHandler(new CustomLoginFailureHandler())
//			 
			 .and()  // 다시, HttpSecurity 객체 리턴. 세팅중 다른 세팅 전환시 호출
//			 
//			 /********************************************
//	         * ③ 로그아웃 설정
//	         * LogoutConfigurer<HttpSecurity>  리턴.  이하 이 객체의 메소드체이닝
//	         ********************************************/
			 .logout()
			 .logoutUrl("/user/logout")	// 주소창에 이 url을 넣으면 logout된다. 
			 .invalidateHttpSession(false) 	// session invalidate(디폴트 true) session테이블 자체를 날려버린다. 
//			 								// 이따가 CustomLogoutSuccessHandler 에서 꺼낼 정보가 있기 때문에
//			 								// false 로 세팅한다
//			 
//			 // 로그아웃 성공후 수행할 코드
//	         // .logoutSuccessHandler(LogoutSuccessHandler)
			 .logoutSuccessHandler(new CustomLogoutSuccessHandler())
//			 
			 .and()  // 다시, HttpSecurity 객체 리턴. 세팅중 다른 세팅 전환시 호출
//			 
//			 /********************************************
//	         * ④ 예외처리 설정
//	         * ExceptionHandlingConfigurer<HttpSecurity>  리턴.  이하 이 객체의 메소드체이닝
//	         ********************************************/
			 .exceptionHandling()
//				
//	         // 권한(Authorization) 오류 발생시 수행할 코드
//	         // .accessDeniedHandler(AccessDeniedHandler)
// 
			 .accessDeniedHandler(new CustomAccessDeniedHandler())
//			 
			 ;
		 
		 	
		 	 
	}	// end configure()
	
	// alt + shift + v 하고 s하면 overriding 
	
	
	
}
