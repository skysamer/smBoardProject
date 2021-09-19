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

<!-- ��� -->
<div class="row">
	<div class="col-lg-12">
		
		<!-- �ǳ� -->
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> ��ü ���
				<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">��� ���</button>
			</div>
		</div>
		
		<div class="panel-body">
			<ul class="chat">
				<li class="left clearfix">
					<div>
						<div class="header">
							<strong class="primary-font"></strong>
							<small class="pull-right text-muted"></small>
						</div>
						<p></p>
					</div>
				</li> 
				
			</ul>
		</div>
		
		
	</div>
</div>

<!-- ��� ���â -->
<div class="modal fade" id="myModalReply" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
		
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">��� ���</h4>
			</div>
			
			<div class="modal-body">
				<div class="form-group">
					<label>���</label>
					<input class="form-control" name="reply" value="��۳���">
				</div>
				<div class="form-group">
					<label>�ۼ���</label>
					<input class="form-control" name="replier" value="�ۼ���">
				</div>
				<div class="form-group">
					<label>��¥</label>
					<input class="form-control" name="replyDate" value="">
				</div>
			</div>
			
			<div class="modal-footer">
				<button id="modalModBtn" type="button" class="btn btn-warning">����</button>
				<button id="modalRemoveBtn" type="button" class="btn btn-danger">����</button>
				<button id="modalRegisterBtn" type="button" class="btn btn-primary" data-dismiss="modal">���</button>
				<button id="modalCloseBtn" type="button" class="btn btn-default" data-dismiss="modal">�ݱ�</button>
			</div>
			
		</div>
	</div>
</div>


<%@ include file="../includes/footer.jsp"%>

<script type="text/javascript" src="/resources/js/reply.js"></script>

<script>

$(document).ready(function(){
	
	var bnoValue='<c:out value="${board.bno}"/>';
	var replyUL=$(".chat");
	
	// ��� ���â
	var modal=$("#myModalReply");
	var modalInputReply=modal.find("input[name='reply']");
	var modalInputReplier=modal.find("input[name='replier']");
	var modalInputReplyDate=modal.find("input[name='replyDate']");
	
	var modalModBtn=$("#modalModBtn");
	var modalRemoveBtn=$("#modalRemoveBtn");
	var modalRegisterBtn=$("#modalRegisterBtn");
	
	$("#addReplyBtn").on("click", function(e){
		modal.find("input").val("");
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id != 'modalCloseBtn']").hide();
		
		modalRegisterBtn.show();
		
		$("#myModalReply").modal("show");
	});
	
	// ��� �󼼺���
	$(".chat").on("click", "li", function(e){
		var rno=$(this).data("rno");
		
		replyService.get(rno, function(reply){
			modalInputReply.val(reply.reply);
			modalInputReplier.val(reply.replier);
			modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
			modal.data("rno", reply.rno);
			
			modal.find("button[id != 'modalCloseBtn']").hide();
			modalModBtn.show();
			modalRemoveBtn.show();
			
			$("#myModalReply").modal("show");
		});
	});
	
	
	// ��� ����
	modalModBtn.on("click", function(e){
		var reply={rno : modal.data("rno"), reply : modalInputReply.val()};
		
		replyService.update(reply, function(result){
			alert(result);
			modal.modal("hide");
			showList(1);
		});
	});
	
	// ��� ����
	modalRemoveBtn.on("click", function(e){
		var rno=modal.data("rno");
		
		replyService.remove(rno, function(result){
			alert(result);
			modal.modal("hide");
			showList(1);
		});
	});
	
	showList(1);
	
	// ��� ���
	function showList(page){
		replyService.getList({bno:bnoValue, page:page||1}, function(list){
			
			var str="";
			
			if(list == null || list.length == 0){
				ReplyUL.html("");
				
				return;
			}
			
			for(var i=0, len=list.length || 0; i<len; i++){
				str+="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
				str+=" <div><div class='header'><strong class='primary-font'>"+list[i].replier+"</strong>";
				str+="<small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
				str+="<p>"+list[i].reply+"</p></div></li>";
			}
			
			replyUL.html(str);
		});
	}
	
	// ��� ���
	modalRegisterBtn.on("click", function(e){
		var reply={
				reply : modalInputReply.val(),
				replier : modalInputReplier.val(),
				bno : bnoValue
		};
		replyService.add(reply, function(result){
			alert(result);
			
			modal.find("input").val("");
			modal.modal("hide");
			
			showList(1);
		});
		
	});
});
</script>




<script type="text/javascript">
$(document).ready(function(){
	
	console.log(replyService);
	
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