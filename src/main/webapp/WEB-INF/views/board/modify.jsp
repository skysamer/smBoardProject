<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>

	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">�� ���� ������</h1>
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->

	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
			
				<div class="panel-heading">�� ����</div>
				<!-- /.panel-heading -->

				<div class="panel-body">
				
					<form action="/board/modify" role="form" method="post">
					
						<div class="form-group">
							<label>�۹�ȣ</label> <input class="form-control" name='bno' value='<c:out value="${board.bno }"/>' readonly="readonly"/>
						</div>
						<div class="form-group">
							<label>����</label> <input class="form-control" name='title' value='<c:out value="${board.title }"/>'>
						</div>
						<div class="form-group">
							<label>����</label> <textarea class="form-control" rows="10" name='content' ><c:out value="${board.content }"/></textarea>
						</div>
						<div class="form-group">
							<label>�ۼ���</label> <input class="form-control" name="writer" value='<c:out value="${board.writer }"/>' readonly="readonly">
						</div>
						
						<button type="submit" data-oper='modify' class="btn btn-default">����</button>
						<button type="submit" data-oper='list' class="btn btn-list">�������</button>
						
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
		
		if(operation==='remove'){
			formObj.attr("action", "/board/remove");
		}else if(operation==='list'){
			formObj.attr("action", "/board/list").attr("method", "get");
			formObj.empty();
			return;
		}
		
		formObj.submit();
	});
});
</script>
