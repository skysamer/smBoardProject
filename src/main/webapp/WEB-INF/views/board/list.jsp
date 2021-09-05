<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>


<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Ŀ�´�Ƽ �Խ���</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading">
				�۸��
				<button id="regBtn" type="button" class="btn btn-xs pull-right"
				onclick="location.href='/board/register'">�۵��</button>
			
			</div>
			
			<!-- �Խñ� ��� -->
			<div class="panel-body">
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th>��ȣ</th>
							<th>����</th>
							<th>�ۼ���</th>
							<th>�ۼ���</th>
							<th>��ȸ��</th>
							<th>��õ��</th>
							<th>����õ��</th>
						</tr>
					</thead>

					<c:forEach items="${list }" var="board">
						<tr>
							<td><c:out value="${board.bno }" /></td>
							<td><a href='/board/get?bno=<c:out value="${board.bno }"/>'><c:out value="${board.title }" /></a></td>
							<td><c:out value="${board.writer }" /></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
									value="${board.regdate }" /></td>
							<td><c:out value="${board.views }" /></td>
							<td><c:out value="${board.recommendations }" /></td>
							<td><c:out value="${board.not_recommendations }" /></td>
						</tr>
					</c:forEach>
				</table>

				<!-- Modal �߰� -->
				<div class="modal fade" id="myModal" tabindex="1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
					
					<div class="modal-dialog">
						<div class="modal-content">
						
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">�۾��Ϸ�</h4>
								<div class="modal-body">ó���� �Ϸ�Ǿ����ϴ�.</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default"
										data-dismiss="modal">�ݱ�</button>
									<button type="button" class="btn btn-primary"
										data-dismiss="modal">�Ϸ�</button>
								</div>
							</div>
							
						</div>
					</div>
				</div>
				<!-- /.modal -->
				
			</div>
		</div>
	</div>
</div>

<%@ include file="../includes/footer.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	var result='<c:out value="${result}"/>';
	
	checkModal(result);
	
	history.replaceState({}, null, null);
	
	function checkModal(result){
		if(result==='' || history.state){
			return;
		}
		
		if(parseInt(result)>0){
			$(".modal-body").html("�Խñ� ����� �Ϸ�Ǿ����ϴ�.");
		}
		$("#myModal").modal("show");
	}
});
</script>