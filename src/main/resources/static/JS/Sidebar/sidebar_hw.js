/**
 * 
 */
$(function(){
	 
	// Setting the basic position of the sidenav
	// sidenav의 기본적 위치설정 
	var width_container = $(".container").width();
	//alert(width_container);
	var width_window = $(window).width();
	var width_sidebar = $(".sidebar_customized").width();
	width_sidebar = width_window/2-width_container/2-width_sidebar-parseFloat('70px');
	$(".sidebar_customized").css({
		"left":width_sidebar
	}); 
	// On the change of the size of window, the way to detect it is  
	// to $(window).resize()
	// 윈도우 화면이 변할때 감지하는 법은 
	// $(window).resize()을 사용하는 것이다. 
	$(window).resize(function(){
		var width_container = $(".container").width();
		//alert(width_container);
		var width_window = $(window).width();
		var width_sidebar = $(".sidebar_customized").width();
		width_sidebar = width_window/2-width_container/2-width_sidebar-parseFloat('70px');
		$(".sidebar_customized").css({
		"left":width_sidebar
		}); 
	})
	 
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
})