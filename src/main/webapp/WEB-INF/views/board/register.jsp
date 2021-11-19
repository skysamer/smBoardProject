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
			<h1 class="page-header">�� �� ���</h1>
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->

	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
			
				<div class="panel-heading">�� �� ���</div>
				<!-- /.panel-heading -->

				<div class="panel-body">
				
					<form action="/board/register" role="form" method="post" >
					
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					
						<div class="form-group">
							<label>����</label> <input class="form-control" name='title'>
						</div>
						<div class="form-group">
							<label>����</label> <textarea class="form-control" rows="10" name='content'></textarea>
						</div>
						<div class="form-group">
							<label>�ۼ���</label> <input class="form-control" name="writer"
							value='<sec:authentication property="principal.username"/>' readonly="readonly">
						</div>
						
						<button type="submit" class="btn btn-primary">���</button>
						<button type="reset" class="btn btn-default">�ʱ�ȭ</button>
					</form>
					
				</div>
			</div>
		</div>
	</div>

	
	<!-- ���� ÷�� -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				
				<div class="panel-heading">���� ÷��</div>
				
				<div class="panel-body">
					<div class="from-group uploadDiv">
						<input type="file" name="uploadFile" multiple>
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

<script type="text/javascript">
$(document).ready(function(e){
	
	var formObj=$("form[role='form']");
	
	$("button[type='submit']").on("click", function(e){
		e.preventDefault();
		
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
	});
	
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
	var csrfTokenValue="${_csrf.token}";
	
	$("input[type='file']").change(function(e){
		var formData=new FormData();
		
		var inputFile=$("input[name='uploadFile']");
		
		var files=inputFile[0].files;
		
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
			beforeSend : function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data : formData,
			type : 'POST',
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
	
	
	
	$(".uploadResult").on("click", "button", function(e){
		console.log("delete file");
		
		var targetFile=$(this).data("file");
		var type=$(this).data("type");
		
		var targetLi=$(this).closest("li");
		
		$.ajax({
			url : "/deleteFile",
			data : {fileName : targetFile, 
					type : type},
			beforeSend : function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			dataType : "text",
			type : "POST",
			success : function(result){
				alert(result);
				console.log(type)
				$("img:first").remove();
				targetLi.remove();
			}
			
		});
		
	});
	
});
</script>