<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일업로드테스트</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<h2>ajax 를 이용해서 파일 업로드하기 ! </h2>
	<input type="file" id="upFile" multiple accept="image/*">
	<button id="btnupload">업로드</button>
	<div id="preview"></div>
	<script>
		$("#upFile").change(e=>{
			$("#preview").html('');
			$.each(e.target.files,(i,file)=>{
				const fileReader = new FileReader();
				fileReader.readAsDataURL(file);
				fileReader.onload=(e)=>{
					const path=e.target.result;
					const img=$("<img>").attr({
						src:path,
						width:"200",
						height:"200"
					});
					$("#preview").append(img);
				}
			});
		});
		$("#btnupload").click(e=>{
			// formdata 객체를 이용해서 업로드 처리할 수 있음
			const form = new FormData();
			const files = ($("#upFile")[0].files);
			for(let i=0;i<files.length;i++){
				form.append("upFile"+i,files[i]);
			}
			/* form.append("upFile",$("#upFile")[0].files[0]); */
			
			form.append("name","유병승");
			$.ajax({
				url:"<%=request.getContextPath()%>/ajax/upload.do",
				data:form,
				type:"POST",
				processData:false,
				contentType:false,
				success:data=>{
					console.log(data);
					const responseData = JSON.parse(data);
					if(responseData.result){
						alert("업로드성공");
					} else{
						alert("업로드실패");
					}
				},
				complete:()=>{
					$("#upFile").val("");
					$("#preview").html("");
				}
				
			});
		});
		
	</script>
</body>
</html>