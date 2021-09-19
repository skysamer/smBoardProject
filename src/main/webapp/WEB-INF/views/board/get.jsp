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
				<label>작성자: </label> <c:out value="${board.writer }" />
			</div>

			<div class="panel-body">
				<div class="form-group">
					<label>내용</label> <textarea class="form-control" rows="10" name='content' readonly="readonly"><c:out value="${board.content }"/></textarea>
				</div>
				
				<button data-oper="modify" class="btn btn-default" onclick="location.href='/board/modify?bno='<c:out value="${board.bno }"/>'">수정</button>
				<button id="btnDelModal" data-oper="removeModal" class="btn btn-danger">삭제</button>
				<button data-oper="list" class="btn btn-info" >목록으로</button>
				
				<form id="operForm" action="/board/modify" method="get">
					<input type="hidden" id="bno" name="bno" value="<c:out value="${board.bno }"/>">
					<input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum }"/>">
					<input type="hidden" name="amount" value="<c:out value="${cri.amount }"/>">
					<input type="hidden" name="keyword" value="<c:out value="${cri.keyword }"/>">
					<input type="hidden" name="type" value="<c:out value="${cri.type }"/>">
				</form>
				
				<!-- 모달창 추가 -->
				<div class="modal fade" id="myModal" tabindex="1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
					
					<div class="modal-dialog">
						<div class="modal-content">
						
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">게시글 삭제</h4>
								<div class="modal-body">정말로 삭제하시겠습니까? 삭제하면 다시 복구할 수 없습니다.</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default"
										data-dismiss="modal">취소</button>
									<button id="btnDel" type="button" class="btn btn-danger"
										data-oper="remove">삭제</button>
								</div>
							</div>
							
						</div>
					</div>
				</div>
				
				
			</div>

		</div>

	</div>

</div>

<!-- 댓글 -->
<div class="row">
	<div class="col-lg-12">
		
		<!-- 판넬 -->
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> 전체 댓글
				<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">댓글 등록</button>
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

<!-- 댓글 모달창 -->
<div class="modal fade" id="myModalReply" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
		
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">댓글 등록</h4>
			</div>
			
			<div class="modal-body">
				<div class="form-group">
					<label>댓글</label>
					<input class="form-control" name="reply" value="댓글내용">
				</div>
				<div class="form-group">
					<label>작성자</label>
					<input class="form-control" name="replier" value="작성자">
				</div>
				<div class="form-group">
					<label>날짜</label>
					<input class="form-control" name="replyDate" value="">
				</div>
			</div>
			
			<div class="modal-footer">
				<button id="modalModBtn" type="button" class="btn btn-warning">수정</button>
				<button id="modalRemoveBtn" type="button" class="btn btn-danger">삭제</button>
				<button id="modalRegisterBtn" type="button" class="btn btn-primary" data-dismiss="modal">등록</button>
				<button id="modalCloseBtn" type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
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
	
	// 댓글 모달창
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
	
	// 댓글 상세보기
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
	
	
	// 댓글 수정
	modalModBtn.on("click", function(e){
		var reply={rno : modal.data("rno"), reply : modalInputReply.val()};
		
		replyService.update(reply, function(result){
			alert(result);
			modal.modal("hide");
			showList(1);
		});
	});
	
	// 댓글 삭제
	modalRemoveBtn.on("click", function(e){
		var rno=modal.data("rno");
		
		replyService.remove(rno, function(result){
			alert(result);
			modal.modal("hide");
			showList(1);
		});
	});
	
	showList(1);
	
	// 댓글 목록
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
	
	// 댓글 등록
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