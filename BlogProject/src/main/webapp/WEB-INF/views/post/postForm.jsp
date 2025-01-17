<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri = "http://www.springframework.org/tags/form" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../include/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board</title>
<script src="https://cdn.ckeditor.com/4.16.1/standard-all/ckeditor.js"></script>
<script>
	
	$(document).on('click', '#btnSave', function() {
		var title = $('#title').val();
		if (title == null || title==""){
			alert("Please Write Title");
			$('#title').focus();
		}else{
			$("#form").submit();
		}
	});
	
	$(document).on('click',	'#btnList',	function() {
		location.href = "${pageContext.request.contextPath}/post/homeList";
	});
	
	$(document).ready(function(){
		var mode = '<c:out value="${mode}"/>';
		if ( mode == 'edit'){
			//입력 폼 셋팅
			$("#reg_id").prop('readonly', true);
			$("input:hidden[name='post_id']").val(<c:out value="${postContent.post_id}"/>);
			$("input:hidden[name='mode']").val('<c:out value="${mode}"/>');
			$("#title").val('<c:out value="${postContent.post_subj}"/>');
			$("#content").val('${postContent.post_content}');
		}
	});
</script>
<style type="text/css">
.ck.ck-editor {
	max-width: 500px;
}
.ck-editor__editable {
	min-height: 300px;
}
</style>
</head>
		<!--? Hero Start -->
        <div class="slider-area2">
            <div class="slider-height2 d-flex align-items-center">
                <div class="container">
                    <div class="row">
                        <div class="col-xl-12">
                            <div class="hero-cap hero-cap2 pt-70">
                                <a href="#"><h2>POST</h2></a>
                                <nav aria-label="breadcrumb">
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Hero End -->
<body>
	<article>
		<section class="blog_area single-post-area section-padding" style="padding-top: 60px;">
		   <div class="container">
			<form:form name="form" id="form" role="form" modelAttribute="postDTO" method="post" 
			action="${pageContext.request.contextPath}/post/savePost">
				<!-- postDTO에는 mode라는 속성을 가지고 있지 않기 때문에 일반적인 form태그 사용 -->
				<form:hidden path="post_id" />
				<input type="hidden" name="mode"/>
				<input type="hidden" name="user_id" value="${udto.user_id }"/>
				<div class="input-group mb-3">
					<label for="category_select" style="font-size: 12px; padding: 5px">category</label>
					<select name="category_id" id="category_select" >
							<c:forEach var="cdto" items="${CategoryList }">
								<option value="${cdto.category_id }">${cdto.category_name }</option>
							</c:forEach>
					</select>				
				</div>
				<!-- form 키워드 사용, name=> path 사용 -->
				<div class="input-group mb-3">
					<form:input path="post_subj" class="form-control" name="name" id="title" placeholder="제목을 입력해 주세요" style="font-size:20px; height: 40px" />
				</div>
				<div class="input-group">
				</div>
				
				<div>
					<form:textarea path="post_content" class="form-control" rows="5" name="content" id="content" placeholder="내용을 입력해 주세요"/>
				</div>				
			</form:form>
			<div style="text-align: center; margin: 40px">
				<button type="button" class="btn btn-sm btn-primary" id="btnSave" style="margin: 10px">저장</button>
				<button type="button" class="btn btn-sm btn-primary" id="btnList">목록</button>
			</div>
		</div>
		</section>
	</article>
	<script type="text/javascript">
	
	var ckeditor_config = {
			height : 500,
		resize_enaleb : false,
		resize_maxHeight : 200,
		resize_maxWidth : 200,
		enterMode : CKEDITOR.ENTER_BR,
		shiftEnterMode : CKEDITOR.ENTER_P,
		filebrowserUploadUrl : "/post/ckUpload",
		uploadUrl: "/post/ckUpload"
	};
	CKEDITOR.replace('content', ckeditor_config);
	
	</script>
	<%@ include file="../include/footer.jsp" %>
</body>
</html>