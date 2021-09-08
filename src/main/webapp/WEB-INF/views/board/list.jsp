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
							<td><a class="move" href='<c:out value="${board.bno }"/>'><c:out value="${board.title }" /></a></td>
							<td><c:out value="${board.writer }" /></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
									value="${board.regdate }" /></td>
							<td><c:out value="${board.views }" /></td>
							<td><c:out value="${board.recommendations }" /></td>
							<td><c:out value="${board.not_recommendations }" /></td>
						</tr>
					</c:forEach>
				</table>
				
				<!-- ����¡ ���� �Ķ���� �� -->
				<form action="/board/list" id="actionForm" method="get">
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
					<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
				</form>
				
				<!-- ����¡ ó�� -->
				<div class="pull-right">
					<ul class="pagination">
					
						<c:if test="${pageMaker.prev }">
							<li class="paginate_button previous">
								<a href="${pageMaker.startPage - 1 }">����</a>
							</li>
						</c:if>
						
						<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }"> 
							<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":"" }">
								<a href="${num }">${num }</a>
							</li>
						</c:forEach>
						
						<c:if test="${pageMaker.next }">
							<li class="paginate_button next">
								<a href="${pageMaker.endPage + 1 }">����</a>
							</li>
						</c:if>
						
					</ul>
				</div>
				
				<!-- ���â �߰� -->
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
				
				
			</div>
		</div>
	</div>
</div>

<%@ include file="../includes/footer.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	
	// ���â �̺�Ʈ
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
	
	// ������ ��ȣ Ŭ�� �̺�Ʈ
	
	var actionForm=$("#actionForm")
	
	$(".paginate_button a").on("click", function(e){
		e.preventDefault();
		
		console.log('click');
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	// �Խù� ��ȸ �̺�Ʈ
	$(".move").on("click", function(e){
		e.preventDefault();
		
		actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
		actionForm.attr("action", "/board/get");
		actionForm.submit();
	});
});
</script>