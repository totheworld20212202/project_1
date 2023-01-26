/**
 * 
 */
 
$(function(){
	 
/************ BEGIN adding hw problems**************/
		$("#newhw").click(function(){
			var lecId =$("#form-hw").children().eq(2).val().trim();
			//alert(lecId);
			//console.log(lecId); 
			 
			if(lecId == null || lecId == ""){
				alert("homework list를 선택하세요!\nhomework list가 없다면 강의 등록을 해주세요!")
				//return false;
				return;
			}
			 
			
			$("#newhwregister").css({
				"display":"block"
			})
			$(this).css({
				"display":"none"
			})
			$("#registerhw").css({
				"display":"inline"
			})
		})		
		
		$("#registerhw").click(function(){
			 
			
			 
			$("#form-hw").submit();
		})
	
/************ END adding hw problems**************/

/************ BEGIN adding hw-selected to the newhw**************/
/** 	
		$(".homeworkConfirm").click(function(){
			//alert($(this).parent().children().eq(0).html());
			
			
			var E = $(this).parent().children().eq(0).html();
			D = E-1;
		  
			$("#hw-selected").attr("value",D)
			 
		 
		})	
*/	 
/************ END adding hw-selected to the newhw**************/		
});