<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">
			<c:out value="${board.title }" />
		</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading">
				<label>�ۼ���: </label> <c:out value="${board.writer }" />
			</div>

			<div class="panel-body">
				<div class="form-group">
					<label>����</label> <textarea class="form-control" rows="10" name='content' readonly="readonly"><c:out value="${board.content }"/></textarea>
				</div>
				
				<button data-oper="modify" class="btn btn-default" onclick="location.href='/board/modify?bno='<c:out value="${board.bno }"/>'">����</button>
				<button id="btnDelModal" data-oper="removeModal" class="btn btn-danger">����</button>
				<button data-oper="list" class="btn btn-info" >�������</button>
				
				<form id="operForm" action="/board/modify" method="get">
					<input type="hidden" id="bno" name="bno" value="<c:out value="${board.bno }"/>">
					<input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum }"/>">
					<input type="hidden" name="amount" value="<c:out value="${cri.amount }"/>">
					<input type="hidden" name="keyword" value="<c:out value="${cri.keyword }"/>">
					<input type="hidden" name="type" value="<c:out value="${cri.type }"/>">
				</form>
				
				<!-- ���â �߰� -->
				<div class="modal fade" id="myModal" tabindex="1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
					
					<div class="modal-dialog">
						<div class="modal-content">
						
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">�Խñ� ����</h4>
								<div class="modal-body">������ �����Ͻðڽ��ϱ�? �����ϸ� �ٽ� ������ �� �����ϴ�.</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default"
										data-dismiss="modal">���</button>
									<button id="btnDel" type="button" class="btn btn-danger"
										data-oper="remove">����</button>
								</div>
							</div>
							
						</div>
					</div>
				</div>
				
			</div>

		</div>

	</div>

</div>


<%@ include file="../includes/footer.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	
	/* data-oper */
	var operForm=$("#operForm");
	
	$("button[data-oper='modify']").on("click", function(e){
		operForm.attr("action", "/board/modify").submit();
	});
	
	$("button[data-oper='remove']").on("click", function(e){
		operForm.attr("action", "/board/remove").attr("method", "post").submit();
	});
	
	$("button[data-oper='list']").on("click", function(e){
		operForm.find("#bno").remove();
		operForm.attr("action", "/board/list")
		operForm.submit();
	});
	
	
	/* modal */
	$("button[data-oper='removeModal']").on("click", function(e){
		$("#myModal").modal("show");
	});
	
});
</script>