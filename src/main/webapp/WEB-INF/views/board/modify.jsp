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
						
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
					
						<input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum }"/>">
						<input type="hidden" name="amount" value="<c:out value="${cri.amount }"/>">
						<input type="hidden" name="keyword" value="<c:out value="${cri.keyword }"/>">
						<input type="hidden" name="type" value="<c:out value="${cri.type }"/>">
					
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
						
						<sec:authentication property="principal" var="pinfo"/>
						
						<sec:authorize access="isAuthenticated()">
						<c:if test="${pinfo.username eq board.writer }"> 
							<button type="submit" data-oper='modify' class="btn btn-default">����</button>
							<button type="submit" data-oper='list' class="btn btn-list">�������</button>
						</c:if>
						</sec:authorize>
						
					</form>
					
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
				
					<div class="form-group uploadDiv">
						<input type="file" name="uploadFile" multiple="multiple">
					</div>
					
					<div class="uploadResult">
						<ul>
						</ul>
					</div>
					
				</div>
			</div>
		</div>
	</div>
	
<%@ include file="../includes/footer.jsp"%>


<!-- button controller -->
<script type="text/javascript">
$(document).ready(function(){
	(function(){
		var bno='<c:out value="${board.bno}"/>';
		
		$.getJSON("/board/getAttachList", {bno:bno}, function(arr){
			console.log("arr: "+arr);
			
			var str="";
			
			$(arr).each(function(i, attach){
				//image type
				if(attach.filetype){
					var fileCallPath=encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
					
					str+="<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.filetype+"'><div>";
					str+="<span> "+attach.fileName+"</span><br/>";
					str+="<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str+="<img src='/display?fileName="+fileCallPath+"'>";
					str+="</div>";
					str+="</li>";
				}
				else{
					str+="<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.filetype+"'><div>";
					str+="<span> "+attach.fileName+"</span><br/>";
					str+="<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str+="<img src='/resources/img/attach.png'>";
					str+="</div>";
					str+="</li>";
				}
			});
			$(".uploadResult ul").html(str);
		});
	})();
	
	//ȭ�� �� ���� ����
	$(".uploadResult").on("click", "button", function(e){
		console.log("delete file");
		
		if(confirm("Remove this file?")){
			var targetLi=$(this).closest("li");
			targetLi.remove();
		}
	});
	
	//�ű� ���� ���
	var regex=new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize=5242880; // 5MB
	
	function checkExtension(fileName, fileSize){
		
		if(fileSize >= maxSize){
			alert("���� ������ �ʰ�");
			return false;
		}
		
		if(regex.test(fileName)){
			alert("�ش� ������ ������ ���ε� �� �� �����ϴ�.");
			return false;
		}
		return true;
	}
	
	var csrfHeaderName="${_csrf.headerName}";
	var csrfToeknValue="${_csrf.token}";
	
	$("input[type='file']").change(function(e){
		var formData=new FormData();
		
		var inputFile=$("input[name='uploadFile']");
		
		var files=inputFile[0].files;
		console.log(files);
		for(var i=0; i<files.length; i++){
			
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
			url : '/uploadAjaxAction',
			processData : false,
			contentType : false,
			data : formData,
			type : 'POST',
			beforeSend : function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			dataType : 'json',
			success : function(result){
				alert("uploaded");
				console.log("result: "+result);
				
				showUploadResult(result);
			}
		});
		
	});
	
	var uploadUL=$(".uploadResult ul");
	
	function showUploadResult(uploadResultArr){
		
		if(!uploadResultArr || uploadResultArr.length==0){
			return;
		}
		
		var str="";
		
		$(uploadResultArr).each(function(i, obj){
			console.log(obj);
			console.log(i);
			
			if(Object.values(obj)[3]){
				var fileCallPath=encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				var originPath=obj.uploadPath+"\\"+obj.uuid+"_"+obj.fileName;
				originPath=originPath.replace(new RegExp(/\\/g), "/");
				
				str+="<li data-path='"+obj.uploadPath+"'";
				str+=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.filetype+"'>"
				str+="<div>";
				str+="<span>"+obj.fileName+"</span>";
				str+="<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str+="<img src='/display?fileName="+fileCallPath+"'></a></li>";
				str+="</div>";
				str+="</li>";
			}else{
				var fileCallPath=encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
				var fileLink=fileCallPath.replace(new RegExp(/\\/g), "/");
				
				str+="<li data-path='"+obj.uploadPath+"'";
				str+=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.filetype+"'>"
				str+="<div>";
				str+="<span>"+obj.fileName+"</span>";
				str+="<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str+="<img src='/resources/img/attach.png'></a></li>";
				str+="</div>";
				str+="</li>";
			}
		});
		
		uploadUL.append(str);
	}
	
	var formObj=$("form");
	
	$('button').on("click", function(e){
		e.preventDefault();
		
		var operation=$(this).data("oper");
		
		console.log(operation);
		
		if(operation==="remove"){
			formObj.attr("action", "/board/remove");
		}
		
		// �������
		else if(operation==='list'){
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
		
		else if(operation=="modify"){
			console.log("submit clicked");
			
			var str="";
			
			$(".uploadResult ul li").each(function(i, obj){
				
				var jobj=$(obj);
				
				console.dir(jobj);
				
				str+="<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				str+="<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				str+="<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
				str+="<input type='hidden' name='attachList["+i+"].filetype' value='"+jobj.data("type")+"'>";
			});
			
			formObj.append(str).submit();
		}
		
		formObj.submit();
	});
});
</script>
