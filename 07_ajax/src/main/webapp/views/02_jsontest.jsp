<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>json을 이용해서 데이터 통신하기</h2>
	<p>서버와 클라이언트가 데이터를 주고받을 때 데이터를 표현하는 방식</p>
	<p>문자열로 javascript 에서 object 를 표현하는 구조로 작성하자</p>
	<p>
		객체 : {key:value, key:value, ...}<br>
		배열 : [값, 값, 값, 값 ...] <br>
		객체배열 : [{key:value, key:value, ...},{key:value, key:value, ...},{key:value, key:value, ...} ...]
	</p>
	<ul>
		json파서에 대한 라이브러리
		<li>
			json-simple : 기본적으로 json 문자열을 변환해주는 라이브러리
			JSONObject, JSONArray 클래스를 이용해서 파싱처리
		</li>
		<li>Gson : Google에서 만든 라이브러리 -> toJson(), fromJson() 파싱처리 : DTO 만들어 두면 알아서 얘가 처리해줌</li>
		<li>Jackson : ObjectMapper 클래스를 이용해서 파싱처리 -> spring에서 : DTO 만들어 두면 알아서 얘가 처리해줌</li>
	</ul>
	<p>javascript 에서 json 문자열 변환하기</p>
	<p>JSON.parse(): 서버에서 문자열로 전송된 데이터를 js 객체로 변경</p>
	<p>JSON.stringify() : js 객체를 json 구조의 문자열로 변경 -> 서버전송 ! </p>
	<!-- 컨텐트타입을 어플리케이션 제이슨으로 하면 알아서 지가 다닫닥! 바꽈준다. -->
	<script>
		let obj="[1,2,3,4]";
		obj = "{\"name\":\"유병승\",\"age\":19}";
		console.log(JSON.parse(obj));
		const arrObj = JSON.parse(obj);
		const strObj = JSON.stringify(arrObj);
		console.log(strObj);
	</script>
	
	<button id="jsonbtn">jsonSimple 이용하기</button>
	<div id="dataresult"></div>
	<script>
		const btn = document.getElementById("jsonbtn");
		btn.addEventListener("click",e=>{
			fetch("<%=request.getContextPath()%>/json/jsonsimple.do")
			.then(response=>response.json())
			.then(data=>{
				const $table=document.createElement("table");
				const $header=document.createElement("tr");
				$header.innerHTML="<th>이름</th><th>전화번호</th><th>프로필</th>";
				$table.appendChild($header);
				data.filter(a=>a.married).forEach(a=>{
					console.log(a);
					const $tr = document.createElement("tr");
					const $name = document.createElement("td");
					$name.innerText=a["name"];
					const $phone = document.createElement("td");
					$phone.innerText=a["phone"];
					const $profile = document.createElement("td");
					$profile.innerText=a["profile"];
					$tr.appendChild($name);
					$tr.appendChild($phone);
					$tr.appendChild($profile);
					$table.appendChild($tr);
				});
				document.getElementById("dataresult").appendChild($table);
			});
		});
	</script>
	
	<h2>Gson으로 데이터 가져오기</h2>
	<button onclick="useGson();">gson이용</button>
	<div id="gsonResult"></div>
	<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script>
		const useGson = ()=>{
			$.ajax({
				url:"<%=request.getContextPath()%>/gson/actordata.do",
				success:data=>{
					console.log(data);
				}
			})
		}
	</script>
	<div id="enrollActorContainer">
		<input type="text" id="name"><br>
		<input type="text" id="phone"><br>
		<input type="text" id="profile"><br>
		<input type="number" id="age"><br>
		<input type="text" id="height"><br>
		<input type="text" id="married"><br>
	</div>
	<button onclick="enrollActor();">배우저장</button>
	<script>
		const enrollActor=()=>{
			const inputs = document.querySelectorAll("#enrollActorContainer>input");
			let actor ={};
			inputs.forEach(e=>{
				actor[e.id]=e.value;
			});
			console.log(actor);
			fetch("<%=request.getContextPath()%>/json/enroll.do",{
				headers:{
					"Content-Type":"application/x-www-form-urlencoded"
				},
				method:"POST",
				body:"data="+JSON.stringify(actor)
			})
			.then(response=>response.text())
			.then(data=>{
				console.log(data);
			});
		}
	</script>
	
</body>
</html>