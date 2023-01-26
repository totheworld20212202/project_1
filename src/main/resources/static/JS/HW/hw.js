/**
 * 
 */
//alert("Hello");

$(function(){
	$(".homeworkConfirm").click(function(){
		//alert($(this).parent().children().eq(0).html());
		
		
		var E = $(this).parent().children().eq(0).html();
		D = E-1;
		//var F = $(this).parent().parent().children().eq(1).val();
		var F = $(this).parent().next().val();
		//alert(F); 
		console.log(D);
		console.log("클릭한 ID는 입니다"); 
		$(".homeworkList").css({
			"display":"block"
			
		})
		//alert(D); 
		//alert("${userdetails.user.lectures["+D+"]}")
		$("#hwSelected").attr("value",D)
		$("#lectureSelected").attr("value",F) 
		$("#lecSelected").attr("value",F)
		//$("#hw").attr("items","${userdetails.user.lectures["+D+"]}");
  		$("#target").submit();
  		$("#target-1").submit(); 
		//$("#hw").empty();
		//var hwlist = "${userdetails.user.lectures["+D+"].homeworks}"; 
		//var hwlist = "${userdetails.user.lectures["+D+"]}";
		
		//alert(hwlist);
		
		//https://stackoverflow.com/questions/45366750/change-cforeach-list-items-using-javascript
	/* 
		$.each(hwlist, function(index, value){
			$("#hw").append(
				'<tr>'+
				'<td>'+index+'</td>'+
				'<td>a</td>'+
				'<td>b</td>'+
				'<td>submit</td>'+
				'</tr>'
			);
		})
	 */
/*		
		var list = [
			{title : '다음', url : 'http://daum.net'},
			{title : '네이버', url : 'http://naver.com'}
		] 
		$.each(list, function(index, value){
			$("#hw").append(
				'<tr>'+
				'<td>'+value.title+'</td>'+
				'<td>a</td>'+
				'<td>b</td>'+
				'<td>submit</td>'+
				'</tr>'
			);
		})
*/	
	})


	/****************** BEGIN : HWUPLOAD *******************/
	
	

	$(".fileupload").change(function(){
		//alert("Hi");
		$(this).parent()
		.css({
			"padding": "6px 25px",
	  		"background-color":"#334CFF ",
		    "border-radius": "4px",
		    "color": "white",
		    "cursor": "pointer"	
		})
		.children()
		.eq(0)
		.html("업로드 완료!");
	})

	$(".button-hwsubmit").click(function(){
		//alert($(this).parent().parent().html());
		var C=$(this).parent().parent().children().eq(4)
		.children().eq(0)
		;
		//alert(C);
		C.submit();
	})


	/****************** BEGIN : HWUPLOAD *******************/
	




























	
})