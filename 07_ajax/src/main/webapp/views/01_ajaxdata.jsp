<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<h2>서버에 있는 문서파일 내용 가저오기</h2>
	<button id="textData">test.txt 데이타가저오기</button>
	<script>
		$("#textData").click(e=>{
			$.ajax({
				/* GET 방식으로 아래 유알엘 연결 요청 !!! 
					연결에 성공 !! 
					성공하면 success 에 있는 콜백 함수를 실행 @!!*/
				url:"<%=request.getContextPath()%>/upload/test.txt",
				success:data=>{
					console.log(data);
					const dataArr = data.split("\r\n");
					console.log(dataArr);
					const $ul = $("<ul>");
					for(d of dataArr){
						if(d.includes("\\n")){
							const person = d.split("\\n");
							console.log(person);
							const $table = $("<table>");
							person.forEach(p=>{
								const e = p.split(",");
								const $tr = $("<tr>");
								$tr.append($("<td>").text(e[0]))
								$tr.append($("<td>").text(e[1]))
								$tr.append($("<td>").text(e[2]))
								$tr.append($("<td>").text(e[3]))
								$table.append($tr);
							});
							$(e.target).after($table)
						} else{
							const $li=$("<li>").text(d);
							$ul.append($li);
						}
					}
					$(e.target).after($ul);
				}
			});
		});
	</script>
	<h2>서버애서 보내준 문자열 데이터 처리하기</h2>
	<p>
		csv 방식으로 문자열 데이터 전송 ! ! !
	</p>
	<button id="csvdata">csv데이터처리하기</button>
	<div id="csvresult"></div>
	<script>
		$("#csvdata").click(e=>{
			$.get("<%=request.getContextPath()%>/jquery/csvdata.do")
			.done(data=>{
				console.log(data);
				const actors = data.split("\n");
				const $table=$("<table>");
				const $header=$("<tr>");
				$header.html("<th>이름</th><th>전화번호</th><th>프로필</th>")
				actors.forEach(a=>{
					const actor = a.split(",");
					const $tr = $("<tr>");
					
					actor.forEach(d=>{
						if(d.includes(".")){
							$("<td>").append($("<img>").attr({
								src:"<%=request.getContextPath()%>/images/"+actor[2],
								width:"100",
								height:"100"
							})).appendTo($tr);
						} else{
							$tr.append($("<td>").text(d));
						}
					});
					$table.append($tr);
				});
				$("#csvresult").html($table);
			});
		});
	
	</script>
	<h3>html패이지를 서버에서 응답하기</h3>
	<p>
		페이지의 일부 html 코드만 응답 -> 일부만 작성된 jsp페이지를 만듦
	</p>
	<button onclick="htmlPage();">htmlpage</button>
	<div id="htmlresult"></div>
	<script>
		const htmlPage=()=>{
			$.get("<%=request.getContextPath()%>/jquery/htmlpage.do")
			.done(data=>{
				$("#htmlresult").html(data);
			});
		}
	</script>
	<h3>xml파일 데이터 가져오기</h3>
	<button onclick="xmldata();">xml데이타가저오기</button>
	<div id="xmlresult"></div>
	<script>
		const xmldata=()=>{
			$.ajax({
				url:"<%=request.getContextPath()%>/upload/books.xml",
				success:data=>{
					console.log(data);
					const root = $(data).find(":root");
					/* root 를 찾는 방법임 ~ 찾아서 루트를 포함한 하위 모든 태그(객체)를 루트에 담아줌..!!! */
					console.log(root);
					/* const books=$(root).find("book"); */
					const books = $(root).children();
					/* 그 루트중 book 태그인 것들을 모두 찾아 ~ 북스에 담아준 거임 !! */
					console.log(books);
					/* 엘리멘츠 배열은 왜 포이치를 못써 ?! */
							
					const $table = $("<table>");
					books.each((i,book)=>{
						const $tr = $("<tr>");
						$(book).children().each((i,e)=>{
							$("<td>").text($(e).text())
							.appendTo($tr);
						});
						$table.append($tr);
					});
					$("#xmlresult").html($table);
				}
			})
		}
	</script>
</body>
</html>