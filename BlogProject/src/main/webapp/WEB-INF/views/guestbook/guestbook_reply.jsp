<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<html>
<head>
<title>���� �亯</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>
<style type="text/css">
		#wrap {
			width: 700px;
			margin: 0 auto 0 auto;
		}
</style>
<script type="text/javascript">
	function checkValue(){
		var form = document.forms[0];

		if(!form.guest_content.value)
		{
			alert("������ �Է��ϼ���.");
			return false;
		}
		else
		{
			form.target = opener.name;
			form.method="post";
			form.action="";
			form.submit();

			if (opener != null) {
               	opener.rForm = null;
               	self.close();
			}
		}
	}
</script>

</head>
<body>
	<div id="wrap">
		<br>
		<b><font size="5" color="gray">���</font></b>
		<hr size="1" width="700">
		<br>
	
		<!-- ��� ��� �κ� ����-->
		<div id="writeReplyForm">
			<form name="replyInfo" target="replyForm">
				<!-- �θ� ������ ������ ���� �����Ѵ�. -->
				<div class="form-group">
					<input type="text" name="user_id" id="user_id" placeholder="���ǿ��� ������ ���̵�" />
					<hr />
	  				<textarea rows="7" cols="80" style="resize: none" class="form-control" name="guest_content"></textarea>
				</div>
				<br>
				<input type="button" value="Ȯ��" id="replyInsert" onclick="checkValue()" class="btn btn-light">
				<input type="button" value="â�ݱ�" onclick="window.close()" class="btn btn-light">
			</form>
		</div>
		<!-- ��� ��� �κ� ��-->
		<div id="listGestFrom">
	        <form method="post" name="listform">
	            <input type="hidden" name="pro">
	            <div id="comment">
	            	<br />
		            <c:if test="${empty reply_list }">
		            	<label>��ϵ� ������ �����ϴ�.</label>
		            </c:if>
		            <c:if test="${not empty reply_list }">
		            	<c:forEach var="guestbookrpl" items="${reply_list}" varStatus="Count">
		            		<hr size="1" width="700">		            			
			                <label>${guestbookrpl.user_id }</label>&nbsp;&nbsp;&nbsp;
			                <label><fmt:formatDate value="${guestbookrpl.guest_date }" pattern="yyyy-MM-dd HH:mm"/></label>&nbsp;&nbsp;&nbsp;&nbsp;
			                <a href="#" onclick="guestbookupdate(${guestbookrpl.guest_id})">[����]</a>&nbsp;
			                <a href="#" onclick="guestbookdel(${guestbookrpl.guest_id})">[����]</a><br />
			                ${guestbookrpl.guest_content } <br>
			                <br />
		                </c:forEach>
					</c:if>
	            </div>
	        </form>
		</div>
	</div>
</body>
</html>