<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<jsp:include page="../../include/header.jsp" />
	
	<div class="container my-5" style="width: 900px">
	
		<h5 class="text-danger fw-bold">�� ��� ����Ʈ</h2>
		<table class="table table-bordered table-striped align-middle text-center">
		<c:set value="${myComments }" var="mycom"></c:set>
			<thead class="table-primary">	
				<tr style="text-align: center">
					<th style="width: 70px;">�۹�ȣ</th>
					<th style="width: 415px;">�Խù� ����</th>
					<th style="width: 415px;">�� ���</th>
					
				</tr>
			</thead>	
			<tbody>
				<c:forEach items="${mycom }" var="myc">
					<tr style="background-color: lightgray">
						<td>${myc.post_id }</td>
						<td ><a href="<%=request.getContextPath()%>/post_detail.go?id=${myc.post_id}&page=1">${myc.post_title }</a></td>
						<td style="color: red; text-align:left "> �� ${myc.content }</td>
						
					</tr>
						
				</c:forEach>
		
			</tbody>	
		</table>
		
		<div class="text-center my-4">
		  <ul class="pagination justify-content-center">
		    <c:forEach begin="${paging.startBlock}" end="${paging.endBlock}" var="i">
		      <li class="page-item ${i == currentPage ? 'active' : ''}">
		        <a class="page-link" href="mycomments.go?page=${i}">${i}</a>
		      </li>
		    </c:forEach>
		  </ul>
		</div>
		
	
	</div>
	
	
	<div align="center">
		<form method="get" action="<%= request.getContextPath() %>/mycomment_search.go">
			<input name="mycomment_search" placeholder="��� ����">
			<input type="submit" value="�˻�">
	
		</form>
	</div>
</body>
</html>