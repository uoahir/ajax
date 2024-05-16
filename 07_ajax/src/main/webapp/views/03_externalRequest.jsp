<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax 외부통신</title>
</head>
<body>
	<h3>외부통신</h3>
	<p>
		js에서 ajax로 다른 서버에 요청을 보내는 것
		http://localhost:9090/07_axax/~~
		http://14.36.141.71:9994/dockers/
		js 에서 cors 에러를 발생시킴 ! -> 보안위협 ! 
	</p>
	<button onclick="extenalTest();">외부요청</button>
	<div id="loading" style="display:none">loading...</div>
	<script>
		const extenalTest=()=>{
			fetch("<%=request.getContextPath()%>/dockers")
			.then(response=>response.text())
			.then(data=>{
				console.log(data);
				document.querySelector("#loading").
				/* document.querySelector("#loading").style.display="none"; */
			});
			document.querySelector("#loading").style.display="block";
		}
	</script>
</body>
</html>