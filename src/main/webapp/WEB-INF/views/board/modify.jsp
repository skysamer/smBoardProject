<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>

	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">글 수정 페이지</h1>
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->

	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
			
				<div class="panel-heading">글 수정</div>
				<!-- /.panel-heading -->

				<div class="panel-body">
				
					<form action="/board/modify" role="form" method="post">
					
						<input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum }"/>">
						<input type="hidden" name="amount" value="<c:out value="${cri.amount }"/>">
						<input type="hidden" name="keyword" value="<c:out value="${cri.keyword }"/>">
						<input type="hidden" name="type" value="<c:out value="${cri.type }"/>">
					
						<div class="form-group">
							<label>글번호</label> <input class="form-control" name='bno' value='<c:out value="${board.bno }"/>' readonly="readonly"/>
						</div>
						<div class="form-group">
							<label>제목</label> <input class="form-control" name='title' value='<c:out value="${board.title }"/>'>
						</div>
						<div class="form-group">
							<label>내용</label> <textarea class="form-control" rows="10" name='content' ><c:out value="${board.content }"/></textarea>
						</div>
						<div class="form-group">
							<label>작성자</label> <input class="form-control" name="writer" value='<c:out value="${board.writer }"/>' readonly="readonly">
						</div>
						
						<button type="submit" data-oper='modify' class="btn btn-default">수정</button>
						<button type="submit" data-oper='list' class="btn btn-list">목록으로</button>
						
					</form>
					
				</div>
				<!-- end panelbody -->

			</div>
			<!-- end panelbody -->

		</div>
		<!-- end panel -->

	</div>
	<!-- /.row -->
	
<%@ include file="../includes/footer.jsp"%>


<!-- button controller -->
<script type="text/javascript">
$(document).ready(function(){
	var formObj=$("form");
	
	$('button').on("click", function(e){
		e.preventDefault();
		
		var operation=$(this).data("oper");
		
		console.log(operation);
		
		// 목록으로
		if(operation==='list'){
			formObj.attr("action", "/board/list").attr("method", "get");
			
			var pageNumTag=$("input[name='pageNum']").clone();
			var amountTag=$("input[name='amount']").clone();
			var keywordTag=$("input[name='keyword']").clone();
			var typeTag=$("input[name='type']").clone();
			
			formObj.empty();
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(keywordTag);
			formObj.append(typeTag);
		}
		formObj.submit();
	});
});
</script>
