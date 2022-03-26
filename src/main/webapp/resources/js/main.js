		
		function fnSideMenu() {
			
			var leftLiWidth = parseInt($("#leftDv").width());
			
			if(leftLiWidth > 106){
				
				$(".leftLi").hide();
				$(".leftLicon").show();
				$(".leftLicon2").hide();
				$("#sideNv").hide();
				$("#leftDv").css("width","5%");
				$("#leftDv").css("height","1077px");
				$(".leftLicon").css("padding","0px");
				$("#rightDv").css("width","95%");
				
			}else{
				
				$(".leftLi").show();
				$(".leftLicon").hide();
				$(".leftLicon2").show();
				$("#sideNv").show();
				$("#leftDv").css("width","12%");
				$("#leftDv").css("height","1077px");
				$(".leftLicon").css("padding","40px");
				$("#rightDv").css("width","88%");
				
			}
			
			
		}
		
		function startDate() { 
	        date = setInterval(function () { 
	            var dateString = " "; 

	            var newDate = new Date(); 

	            //String.slice(-2) : 문자열을 뒤에서 2자리만 출력한다. (문자열 자르기) 
	            /* dateString += newDate.getFullYear() + "/"; 
	            dateString += ("0" + (newDate.getMonth() + 1)).slice(-2) + "/"; //월은 0부터 시작하므로 +1을 해줘야 한다. 
	            dateString += ("0" + newDate.getDate()).slice(-2) + " ";  */
	            dateString += ("0" + newDate.getHours()).slice(-2) + ":"; 
	            dateString += ("0" + newDate.getMinutes()).slice(-2) + ":"; 
	            dateString += ("0" + newDate.getSeconds()).slice(-2);
	            //document.write(dateString); 문서에 바로 그릴 수 있다. 
	            $("#date").text(dateString); 
	        }, 1000); 
	    } 
	    
		function fnInfo() {
			
			var display = $(".infoDv").css("display");
			
			if(display == "none"){
				$(".infoDv").show();
			}else{
				$(".infoDv").hide();
			}
			
		}
			
		function fnInfoPage(userSeq) {
			
			window.location.href="/user/userView.do?userSeq="+userSeq+"&menuCode=user&nowPage=1&cntPerPage=10&infoCode=y";
			
		}	
			
		function fnLogout(){
			
			window.location.href="/login/logout.do";
			
		}	    
		
		function fnMenu(pageUrl,menuCode){
			
			window.location.href= pageUrl+"?menuCode="+menuCode;
			
		}
		
		function fnIstPop(userSeq){
			var url = "/ist/istListPop.do?userSeq="+userSeq+"&nowPage=1&cntPerPage=10";
			var name = "istListPop";
			var popupX = (document.body.offsetWidth / 2) - (1000 / 2);
			var popupY= (window.screen.height / 2) - (600 / 2);
			
			var options = 'top='+popupY+', left='+popupX+', width=1000, height=600, status=no, menubar=no, toolbar=no, resizable=no';
			
		    window.open(url, name, options);
		}