<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.ajax.model.dto.Actor" %>

<% 
	List<Actor> actors = (List<Actor>)request.getAttribute("actors"); 
%>

<table>
	<tr>
		<th>이름</th>
		<th>전화번호</th>
		<th>프로필</th>
	</tr>
	<%if(!actors.isEmpty()) {
		for(Actor a : actors){%>
		 
		<tr>
			<td><%=a.getName() %></td>
			<td><%=a.getPhone() %></td>
			<td>
				<img src="<%=request.getContextPath()%>/images/<%=a.getProfile() %>" width="100" height="100">
			</td>
		</tr>
	<%} 
	}%>
</table>

