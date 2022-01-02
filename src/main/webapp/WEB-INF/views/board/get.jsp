<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@include file="../includes/header.jsp"%>
<style>
	.uploadResult{
		width: 100%;
		background-color: gray;
	}
	
	.uploadResult ul{
		display: flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	
	.uploadResult ul li{
		list-style: none;
		padding: 10px;
	}
	
	.uploadResult ul li img{
		width: 40px;
	}
	
	.uploadResult ul li span{
		color:white;
	}
	
	.bigPictureWrapper{
		position:absolute;
		display:none;
		justify-content:center;
		align-items:center;
		top:0%;
		width:100%;
		height:100%;
		background-color:gray;
		z-index:100;
		background:rgba(255, 255, 255, 0.5);
	}
	
	.bigPicture{
		position:relative;
		display:flex;
		justify-content:center;
		align-items:center;
	}
	
	.bigPicture img{
		width:600px;
	}
</style>

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
			<div class="form-group">
				<p align="right">��ȸ��: <c:out value="${board.views }" /></p>
			</div>

			<div class="panel-body">
				<div class="form-group">
					<label>����</label> <textarea class="form-control" rows="10" name='content' readonly="readonly"><c:out value="${board.content }"/></textarea>
				</div>
				
				<sec:authentication property="principal" var="pinfo"/>
					<sec:authorize access="isAuthenticated()">
						<c:if test="${pinfo.username eq board.writer }">
							<button data-oper="modify" class="btn btn-default" onclick="location.href='/board/modify?bno='<c:out value="${board.bno }"/>'">����</button>
							<button id="btnDelModal" data-oper="removeModal" class="btn btn-danger">����</button>
						</c:if>
					</sec:authorize>
				<button data-oper="list" class="btn btn-circle.btn-lg" >�������</button>
				<button name="likeBtn" type="button" class="btn btn-info">
					��õ  <c:out value="${board.likehit }" />
				</button>
				<button name="hateBtn" type="button" class="btn btn-danger">
					����õ  <c:out value="${board.hatehit }" />
				</button>
				
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

<!-- �̹��� ���� -->
<div class="bigPictureWrapper">
	<div class="bigPicture">
	</div>
</div>

<!-- ÷������ -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">÷������</div>
			
			<div class="panel-body">
				<div class="uploadResult">
					<ul>
					</ul>
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
				<i class="fa fa-comments fa-fw"></i> ��ü ���<b>[<c:out value="${board.replyCnt }"/>]</b>
					<sec:authorize access="isAuthenticated()">
						<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">��� ���</button>
					</sec:authorize>	
			</div>
		</div>
		
		<div class="panel-body">
			<ul class="chat">
			</ul>
			
		</div>
		
		<div class="panel-footer">
		
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
	(function(){
		var bno='<c:out value="${board.bno}"/>';
		
		$.getJSON("/board/getAttachList", {bno : bno}, function(arr){
			var str="";
			
			$(arr).each(function(i, attach){
				//image type
				if(attach.filetype){
					var fileCallPath=encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
					
					str+="<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.filetype+"'><div>";
					str+="<span> "+attach.fileName+"</span><br/>";
					str+="<img src='/display?fileName="+fileCallPath+"'>";
					str+="</div>";
					str+="</li>";
				}
				else{
					str+="<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.filetype+"'><div>";
					str+="<span> "+attach.fileName+"</span><br/>";
					str+="<img src='/resources/img/attach.png'>";
					str+="</div>";
					str+="</li>";
				}
			});
			$(".uploadResult ul").html(str);
		});
	})();
	
	//���ƿ� �񵿱� ó��
		$("button[name='likeBtn']").on("click", function(){
			
			var bno="${board.bno}";
			
				$.ajax({
					type : "POST",  
		            url : "/board/updateLike",       
		            dataType : "json",   
		            data : {"bno" : bno},
		            error : function(request, status, error){
		            	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		                alert("��� ����");
		            },
		            success : function(likeCheck) {
		                
		                if(likeCheck == 0){
		                    alert("��õ�Ϸ�");
		                    location.reload();
		                }
		                else if (likeCheck == 1){
		                    alert("��õ���");
		                    location.reload();
		                }
		                else if(likeCheck==9999){
		                	alert("�α��� �� �̿� �����մϴ�.");
		                }
		            }
				});
		});
	
	// �Ⱦ�� �񵿱� ó��
	$("button[name='hateBtn']").on("click", function(){
		var bno="${board.bno}";
		
		$.ajax({
			type : "POST",
			url : "/board/updateHate",
			dataType : "json",
			data : {"bno" : bno},
			error : function(){
				alert("��� ����");
			},
			success : function(hateCheck){
				if(hateCheck==0){
					alert("����õ�Ϸ�");
					location.reload();
				}
				else if(hateCheck==1){
					alert("����õ���");
					location.reload();
				}
				else if(hateCheck==9999){
					alert("�α��� �� �̿� �����մϴ�.");
				}
			}
		});
	});
	
	$(".uploadResult").on("click", "li", function(e){
		console.log("view image");
		
		var liObj=$(this);
		console.log(liObj.data("fileName"));
		var path=encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));
		
		if(liObj.data("type")){
			showImage(path.replace(new RegExp(/\\/g), "/"));
		}
		else{
			self.location="/download?fileName="+path
		}
	});
	
	$(".bigPictureWrapper").on("click", function(e){
		$(".bigPicture").animate({width:"0%", height:"0%"}, 1000);
		setTimeout(function(){
			$(".bigPictureWrapper").hide();
		}, 1000);
	});
	
	function showImage(fileCallPath){
		alert(fileCallPath);
		
		$(".bigPictureWrapper").css("display", "flex").show();
		
		$(".bigPicture")
		.html("<img src='/display?fileName="+fileCallPath+"'>")
		.animate({width:"100%", height:"100%"}, 1000);
	}
	
	var alreadyLikeClick = false;
	var alreadyHateClick = false;
	
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
	
	var replier=null;
	
	<sec:authorize access="isAuthenticated()">
	
	replier='<sec:authentication property="principal.username"/>';
	
	</sec:authorize>
	
	var csrfHeaderName="${_csrf.headerName}";
	var csrfTokenValue="${_csrf.token}";
	
	$("#addReplyBtn").on("click", function(e){
		
		modal.find("input").val("");
		modal.find("input[name='replier']").val(replier);
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id != 'modalCloseBtn']").hide();
		
		modalRegisterBtn.show();
		
		$("#myModalReply").modal("show");
	});
	
	// ajax security header
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
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
		var originalReplier=modalInputReplier.val();
		
		var reply={
				rno : modal.data("rno"), 
				reply : modalInputReply.val(),
				replier : originalReplier};
		
		if(!replier){
			alert("�α��� �� ������ �����մϴ�.");
			modal.modal("hide");
			return;
		}
		
		console.log("Original Replier: "+originalReplier);
		
		if(replier!=originalReplier){
			alert("���� �ۼ��� ��۸� ������ �����մϴ�.");
			modal.modal("hide");
			return;
		}
		
		replyService.update(reply, function(result){
			alert(result);
			modal.modal("hide");
			showList(pageNum);
		});
	});
	
	// ��� ����
	modalRemoveBtn.on("click", function(e){
		var rno=modal.data("rno");
		
		if(!replier){
			alert("�α��� �� ������ �����մϴ�.");
			modal.modal("hide");
			return;
		}
		
		var originalReplier=modalInputReplier.val();
		
		if(replier!=originalReplier){
			alert("���� �ۼ��� ��۸� ������ �����մϴ�.");
			modal.modal("hide");
			return;
		}
		
		replyService.remove(rno, originalReplier, function(result){
			alert(result);
			modal.modal("hide");
			showList(pageNum);
		});
	});
	
	showList(1);
	
	// ��� ���
	function showList(page){
		console.log("show list "+page);
		
		replyService.getList({bno : bnoValue, page : page||1}, 
			function(replyCnt, list){
			
				console.log("replyCnt: "+replyCnt);
				console.log("list: "+list);
				console.log(list);
				
				if(page == -1){
					pageNum=Math.ceil(replyCnt / 10.0);
					showList(pageNum);
					return;
				}
				
			
				var str="";
				
				if(list == null || list.length == 0){
					return;
				}
				
				for(var i=0, len=list.length || 0; i<len; i++){
					str+="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
					str+=" <div><div class='header'><strong class='primary-font'>"+list[i].replier+"</strong>";
					str+="<small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
					str+="<p>"+list[i].reply+"</p></div></li>";
				}
				
				replyUL.html(str);
				
				showReplyPage(replyCnt);
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
			
			showList(-1);
		});
		
	});
	
	// ��� ����¡ ó��
	var pageNum=1;
	var replyPageFooter=$(".panel-footer");
	
	function showReplyPage(replyCnt){
		
		var endNum=Math.ceil(pageNum / 10.0) * 10;
		var startNum = endNum - 9;
		
		var prev=startNum != 1;
		var next=false;
		
		if(endNum * 10 >= replyCnt){
			endNum=Math.ceil(replyCnt / 10.0);
		}
		
		if(endNum*10 < replyCnt){
			next=true;
		}
		
		var str="<ul class='pagination pull-right'>";
		
		if(prev){
			str+="<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>����</a></li>";
		}
		
		for(var i=startNum; i<=endNum; i++){
			var active = pageNum == i ? "active" : "";
			
			str+="<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
		}
		
		if(next){
			str+="<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>����</a></li>";
		}
		
		str+="</ul></div>";
		
		console.log(str);
		
		replyPageFooter.html(str);
	}
	
	replyPageFooter.on("click", "li a", function(e){
		e.preventDefault();
		console.log("page click");
		
		var targetPageNum=$(this).attr("href");
		
		console.log("targetPageNum: "+targetPageNum);
		
		pageNum=targetPageNum;
		
		showList(pageNum);
	});
});
</script>


<sec:authentication property="principal" var="pinfo"/>
<sec:authorize access="isAuthenticated()">
        <!-- csrf ó�� -->
<c:if test="${pinfo.username eq board.writer }"> 
<script type="text/javascript">
$(document).ready(function(){
	
	var csrfHeaderName = "${_csrf.parameterName }";
	var csrfTokenValue = "${_csrf.token}";
	
	
	console.log(replyService);
	
	/* data-oper */
	var operForm=$("#operForm");
	
	
	$("button[data-oper='modify']").on("click", function(e){
		operForm.attr("action", "/board/modify").submit();
	});
	
	$("button[data-oper='remove']").on("click", function(e){
		var input   = document.createElement('input');
		
		input.type= 'hidden';
		input.name= csrfHeaderName;
		input.value= csrfTokenValue;
		
		var input2=document.createElement('input');
		
		input2.type= 'hidden';
		input2.name= 'writer';
		input2.value= '<sec:authentication property="principal.username"/>';

		console.log(input);
		console.log(input2);
		operForm.attr("action", "/board/remove").attr("method", "post").appendTo('body').append(input, input2).submit();
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
</c:if>
</sec:authorize>
