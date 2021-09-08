<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>

	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">새 글 등록</h1>
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->

	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
			
				<div class="panel-heading">새 글 등록</div>
				<!-- /.panel-heading -->

				<div class="panel-body">
				
					<form action="/board/register" role="form" method="post">
					
						<div class="form-group">
							<label>제목</label> <input class="form-control" name='title'>
						</div>
						<div class="form-group">
							<label>내용</label> <textarea class="form-control" rows="10" name='content'></textarea>
						</div>
						<div class="form-group">
							<label>작성자</label> <input class="form-control" name="writer">
						</div>
						
						<button type="submit" class="btn btn-default">등록</button>
						<button type="reset" class="btn btn-default">초기화</button>
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