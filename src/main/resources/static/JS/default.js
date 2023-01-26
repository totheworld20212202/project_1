/**
 * 
 */
// alert("Hello");
/**
$(document).ready(function(){
	
	$("#addlecture").click(function(){
		alert("Hello");
	});
});
 */
 
	
/**
$(document).ready(function(){});와 $(function(){}); 같은 의미임. function()을 이미 호출한상태 
$(document).ready(function(){}); html이 로드될때  
 */	
//js for lecture 
$(function(){
	
	$("#addlecture").click(function(){
		//alert("Hello");
		//alert($('form[name="addlec"]').html());
		$('form[name="addlec"]').submit();
	});
	 
	$(".subject").click(function(){
		var ID = $(this).parent().children().eq(0).html(); 
		//alert(ID);
		window.open('/detail?id=' + ID,'_blank','width=800,height=600'); 
		return false;
		
	})
	$("#updatelecture").click(function(){
		//alert("Hello");
		//alert($('form[name="addlec"]').html());
		$('form[name="updatelec"]').submit();
	});
});


// js for user 
$(function(){
	$("#addmember").click(function(){
		//alert("Hello");
		//alert($('form[name="addlec"]').html());
		var s = $("#usertype").val();
		//var s = document.getElementById('selectlectures').value; 
		//alert(s);
		     			if (s==null || s==""){
		     				alert('회원종류는 최소한 하나 선택해야합니다. 선택 후 초록색버튼의 "회원종류등록"을 눌러주세요!')
		     				 
		     				return; 
		     			}
		     			
		$('form[name="addmem"]').submit();
	});
	
	$(".userdetail").click(function(){
		var ID = $(this).parent().children().eq(0).html(); 
		//alert(ID);
		window.open('/user/detail?id=' + ID,'_blank','width=800,height=600'); 
		return false;
		
	}) 
	
	$("#selectlectures").click(function(){
		$(".selectlecture").html('<i class="fa-solid fa-check"></i>');
		for(var i=0;i<list.length;i++){
			removeID(i);
		}
		$(this).val("");
		$("#subjectlist").css({
			"display":"block"
		})
		 
		
	})
	
	 
	$(".closesubject").click(function(){
		//alert("Hello");
		$("#subjectlist").css({
			"display":"none"
		})
		$(this).css({
			"display":"none"
		})
		$("#opensubject").css({
			"display":"block"
		})
		
	});
	$(".selectlecture").click(function(){
		//alert("Hi");
		 
		
		var ID = $(this).parent().children().eq(0).html();
		//alert(ID);
		console.log("클릭한 ID는 "+ID+ "입니다"); 
		for(var i=0;i<list.length;i++){
			if(list[i]==ID){
				$(this).html('<i class="fa-solid fa-check"></i>');
				removeID(i);
				return; 	// exiting the function and 
			}
		}
		
				$(this).html('<i class="fa-solid fa-circle-check"></i>');
				addID(ID);
				
		console.log("list에는 다음값이 담겨있습니다.")
		for(var i=0;i<list.length;i++){
			console.log(i+"번째 list값은 "+ list[i]+ " 입니다.");
		} 
		//location.href("/user/addlecture?lecid="+ID);
	})
	
	var list = [];
	function addID(ID){
		list.push(ID);
	}
	function removeID(i){
		list.splice(i,1);	// i번째 index부터 1개의 원소를 삭제. 
		for(var j=0;j<list.length;j++){
			console.log(j+"번째 list값은 "+ list[j]+ " 입니다.");
		} 
	}
	function collection(){
		return list;
	}
	$("#checksubject").click(function(){
		//alert(collection());
		$("#selectlectures").val(collection());
		list = [];
		$("#subjectlist").css({
			"display":"none"
		})
	})
	
	// 회원추가 / 회원종류 / 클릭시 select 
//	$("#usertype").click(function(){	
//		$(this).parent().children().append()
		
//		.append("<select name='fruits' class='select'>"
//		+"<option disabled selected>fruits</option>"
//		+"<option value='apple'>apple</option>"
//		+"</select>");
//	});
	// 회원종류 선택 
	$("#usertype").click(function(){
		$(".selectauthority").html('<i class="fa-solid fa-check"></i>');
		for(var i=0;i<list.length;i++){
			removeID(i);
		}
		$(this).val("");
		$("#authoritylist").css({
			"display":"block"
		})
	})
	
	$(".selectauthority").click(function(){
		var ID = $(this).parent().children().eq(0).html();
		//alert(ID);
		console.log("클릭한 ID는 "+ID+ "입니다"); 
		for(var i=0;i<list.length;i++){
			if(list[i]==ID){
				$(this).html('<i class="fa-solid fa-check"></i>');
				removeID(i);
				return; 	// exiting the function and 
			}
		}
		
				$(this).html('<i class="fa-solid fa-circle-check"></i>');
				addID(ID);
				
		console.log("list에는 다음값이 담겨있습니다.")
		for(var i=0;i<list.length;i++){
			console.log(i+"번째 list값은 "+ list[i]+ " 입니다.");
		} 
		//location.href("/user/addlecture?lecid="+ID);
		
	}) 
	
	$("#checkauthoritylist").click(function(){
		//alert("Hello");
		//alert(collection());
		$("#usertype").val(collection());
		list = [];
		$("#authoritylist").css({
			"display":"none"
		})
	})
	 
	
})