<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>기본 XMLHttpRequest 객체 이용하기</h2>
	<p>
		XMLHttpRequest 객체가 제공하는 속성, 함수를 이용해서 ajax 통신을 할 수 있다. 
		함수/속성(Property) <br>
		onreadystatechange : 요청에 대한 상태가 변경될 때마다 실행되는 이벤트핸들러(callback)를 등록하는 속성 !<br>
		readyState 속성 : 요청을 처리하는 상태값을 저장하는 속성(0~4)값을 가짐 
						  * 4가 되면 응답이 완료된 상태<br>
		status 속성 : response status code 응답코드를 저장하는 속성
					 * 200(정상), 404(페이지없음), 500(서버에러), 302(리다이렉션)<br>
		open("전송방식","전송url") : 요청방식과 요청주소를 설정하는 함수<br>
		send(["data"]) : 설정한대로 요청을 전송하는 함수(Post 방식이면 여기에 데이터를 넣어줌 
		겟방식은 url 주소에 쿼리스트링으로 담아서 데이터를 전달하기 때문이당)<br>				 
	</p>
	<button onclick="basicRequest();">ajax 기본요청</button>
	<div id="result"></div>
	<input type="text" id="name">
	<button id="btn">get방식으로 전송하기!</button><br>
	<input type ="text" id="id"><br>
	<input type="password" id="pw">
	<button id="sendPw">post방식으로 전송하기!</button>
	
	<script>
	/* 포스트 방식으로 전송 */
		document.getElementById("sendPw").addEventListener("click",e=>{
			const xmlRequest = new XMLHttpRequest();
			xmlRequest.onload=()=>{
				if(xmlRequest.status==200){
					alert("완료");
				}
			}
			// 데이터를 보내기 위해서 header 에 설정을 해야한다.
			xmlRequest.open("post","<%=request.getContextPath()%>/ajax/parametertest.do");
			xmlRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			
			const data = document.querySelector("#pw").value;
			const id = document.querySelector("#id").value;
			xmlRequest.send("pw="+data+"&id="+id);
		});
	
	/* 겟방식으로 전송  */
		document.getElementById("btn").addEventListener("click",e=>{
			const xmlRequest = new XMLHttpRequest();
			xmlRequest.onload=()=>{
				if(xmlRequest.status==200){
					document.querySelector("#result").innerHTML = xmlRequest.responseText;
				}
			}
			const nameVal =document.querySelector("#name").value;
			xmlRequest.open("get","<%=request.getContextPath()%>/ajax/parametertest.do?name="+nameVal);
			xmlRequest.send();
		});
	
	/* 기본방식으로 전송 */
		const basicRequest = ()=>{
			// 1. XMLHttpRequest 라는 객체를 기본 생성 !
			//	  - new XMLHttpRequest();
			const request = new XMLHttpRequest();
			// 2. 객체의 속성 을 설정 !
			// onload 속성을 이용해도 됨
			request.onreadystatechange=()=>{
				// 요청상태가 변경되면 실행되는 이벤트핸들러 등록
				if(request.readyState==4){
					// responseText 속성 / responseXML 속성
					console.log(request.responseText);
					if(request.status==200){
						alert("응답완료");
						document.querySelector("#result").innerHTML=request.responseText;
					} else {
						alert("애러애러");
					}
				}
			}
			// 3. 요청정보설정 -> 요청방식, 요청URL
			request.open("GET","<%=request.getContextPath()%>/ajax/basicajax.do");
			// 4. 요청전송하기
			request.send();
		}
	</script>
	
	<h3>js가 제공하는 fetch 함수를 이용해서 요청처리하기 ! </h3>
	<p>
		fetch("url주소",{옵션}) 함수 ! : 헤더에 대한 설정을 할 수 있음 ~ 
		promise 객체를 반환
		.then((e)=>{})
	</p>
	<button id="btn3">fetch()함수이용</button>
	<script>
		document.querySelector("#btn3").addEventListener("click",e=>{
			fetch("<%=request.getContextPath()%>/ajax/basicajax.do")
			/* 이 패치함수가 실행하면 response 객체를 리턴해주는 거임 ,, 따라서 아래에 then 에 들어가는 response 는 패치함수의 리턴값이고 */
			.then(function(response){
				// 응답한 내용을 처리하는 callback 함수 
				// 응답 에러처리, 정상처리 등
				
				console.log(response)
				// fetch 의 response 객체에서 응답한 내용을 가져오려면 ~ 
				// json() : 응답데이터가 JSON 방식일 때 데이터를 json 으로 파싱해주는 함수
				//  		* content-type : application/json 방식일 때 사용함 
				
				// text() : 문자열 전체
				return response.text();
			/* 첫번째 콜백함수에서는 response 를 문자열 방식으로 가저온 값을 리턴해주고 또 아래 콜백함수의 매개변수로 들어가개 되는 거임 */	
			})
			.then(function(data){
				// 응답결과를 페이지에 반영하는 callback 함수
				document.getElementById("result").innerHTML=data;
			});
			/* 여기에서 리스폰스는 ~,, 응답에 대한 정보를 볼 수 잇는 거임 !! status:200 등 */
		});
	</script>
	<input type="text" id="fetchdata">
	<button onclick="testfetch();">두번째fetch()</button>
	<script>
		const testfetch=()=>{
			const data = document.querySelector("#fetchdata").value;
			fetch("<%=request.getContextPath()%>/ajax/fetchtest.do?data="+data)
			.then(response=>{
				if(!response.ok) throw new Error(response.status);
				else return response.json();
			})
			.then(data=>{
				alert(data);
				console.log(data);
				/* document.getElementById("result").innerHTML = "<h3>"+data.test+"</h3>"; */
				document.getElementById("result").innerHTML="<h3>"+data[0]+"</h3>";
			}).catch(e=>{
				alert("애러애러 - "+e);
			})
			;
		}
	</script>
	<h2>post방식으로 데이타 전송하기</h2>
	<p>
		json 방식으로 객체 전달을 많이 함.
	</p>
	<button onclick="postFetch();">post방식전달</button>
	<script>
		const postFetch=()=>{
			fetch("<%=request.getContextPath()%>/ajax/fetchtest.do",{
				// header 에 대한 정보설정, method 방식설정, body에 데이터 저장
				headers:{
					"Content-Type":"application/json;charset=utf-8"
					/* "Content-Type":"application/x-www-form-urlencoded;charset=utf-8" */
				},
				method:"POST",
				/* body:JSON.stringify({test:"testdata"}) */
				/* body:"data=testdata&name=bs" */
				body:"data="+JSON.stringify([1,2,3,4])
			})
			.then(response=>response.text())
			.then(data=>{
				console.log(data);
			});
		}
	
	</script>
	
	<h3>jquery가 제공하는 함수를 이용해서 ajax 요청 처리하기</h3>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js">
		$.ajax
		
	
	</script>
	<p>
		$.ajax({객체}) : 요청에 대해서 상세설정할 때 사용, header, 요청content 설정 등
		$.get("url",callback()) : 겟 방식으로 데이터를 가져올 때 사용
		$.post("url",{},callback()) : 포스트 방식으로 데이터를 저장, 조회할 때 사용
	</p>
	<h3>$.ajax() 함수 이용하기</h3>
	<p>
		매개변수로 객체를 전송 -> property 가 정해져있다 <br>
		url : 요청주소 설정하는 속성<br>
		[type : 요청방식에 대해 설정하는 속성(GET,POST,PUT,DELETE,UPDATE 등)] -> 생략 시 GET<br>
		[data : 서버에 보낼 데이터 작성 object({key:value,key:value})]<br>
		[dataType : 서버응답 데이터 타입 설정(text,json.xml)] -> contentType에 따라 자동으로 처리해줌 <br>
		success : 응답 성공 시 실행할 callback 함수(status==200) -> function(data){} 매개변수 하나 받는 콜백함수 지정 <br>
		[error : 응답 실패 시 실행할 callback 함수 (status!=200) -> function(request,error){}]<br>
		[complete : 요청이 성공 또는 실패했을 때 모두 실행되는 callback 함수 -> function(){}]<br>
		<!-- finally == complete 성공하든 실패하든 어떤로직ㅇㅣ 무조건 돌아가야 한다 ~ ,, 하면 쓰는 게 complete --> 
	</p>
	<input type="text" id="name2">
	<input type="number" id="age">
	<button id="btn4">$.ajax기본요청</button>
	<div id="result2"></div>
	<script>
		$("#btn4").click(e=>{
			$.ajax({
				url:"<%=request.getContextPath()%>/jquery/basicjauery.do",
				type:"POST",
				data:{"name":$("#name2").val(),"age":$("#age").val()},
				success:function(data){
					console.log(data);
					$("#result2").append("<h3>"+data+"</h3>");
				},
				error:function(request,e){
					console.log(request);
					console.log(e);
				},
				complete:function(){
					console.log("무조건실행");
					/* 머가댓든 실행해야 할 때 ! ! !  */
				}
			});
		});
	</script>
	<h3>$.get() get 방식으로 데이터를 가져올 때 사용 ! ! ! </h3>
	<button id="btn5">$.get() 이용하기</button>
	<h3>$.post() post 방식으로 데이터를 가져올 때 사용 ! ! ! </h3>
	<button id="btn6">$.post() 이용하기</button>
	<div id="result3"></div>
	<script>
		$("#btn5").click(e=>{
			<%-- $.get("<%=request.getContextPath()%>/jquery/basicjauery.do?name=bs&age=19",
					e=>{
						$("#result3").html(`<h3>\${e}</h3>`)
					}	
			); --%>
			$.get("<%=request.getContextPath()%>/jquery/basicjauery.do?name=bs&age=19")
			.done(data=>{
				$("#result3").html(`<h2>\${data}</h2>`);
			})
			.fail((r,e)=>{
				console.log(r);
				console.log(e);
			});
		});
		$("#btn6").click(e=>{
			<%-- $.post("<%=request.getContextPath()%>/jquery/basicjauery.do",
					{name:"김class",age:28},
					data=>{
						$("#result3").html(data);
					}); --%>
			/* done 을 쓰는 거~ 가 좋겟다 웬만하면 ~ + fail */
			$.post("<%=request.getContextPath()%>/jquery/basicjauery.do",
					{name:"김class",age:28})
					.done(data=>{
						$("#result3").html(data);
					});
		});
	</script>
</body>
</html>