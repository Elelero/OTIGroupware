<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
<!-- CSS 관련 파일 -->
	<%@ include file="/WEB-INF/views/common/head.jsp" %>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board.css"/>
	<script src="<c:url value="/resources/vendors/tinymce/tinymce.min.js"></c:url>"></script>
	<script src="<c:url value="/resources/js/tinymce/tinymceinit.js"></c:url>"></script>
	<script src="<c:url value="/resources/vendors/tinymce/themes/silver/theme.min.js"></c:url>"></script>
	<script src="${pageContext.request.contextPath}/resources/vendors/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
	<script>
	$(function(){
		$('#datepicker').datepicker({
		});	
	});
	
	$(() => {
		const checkAll = $('#checkAll');
		const checklist = $('.checklist');
		
		checkAll.change(function() {
		  checklist.prop('checked', checkAll.prop('checked'));
		});
		
		checklist.change(function() {
		  const allChecked = checklist.filter(':checked').length === checklist.length;
		  checkAll.prop('checked', allChecked);
		});
	});
	
	$(() => {
		if ($("#result").length !== 0) {
			const result = $("#result").val();
			if (result === 'unchanged') {
				swal({
					title: "변경 사항 없음",
					icon: "warning",
					button: "닫기"
				});
			}
			else {
				const resultCount = $("#resultCount").val();
				
				if ($("#type").val() === '삭제') {
					swal({
						title: "삭제",
						text: resultCount + "개가 삭제되었습니다.",
						icon: "warning",
						button: "닫기"
					});
				}
				
				else if($("#type").val() === '회수') {
					swal({
						title: "회수",
						text: resultCount + "개가 회수되었습니다.",
						icon: "warning",
						button: "닫기"
					});
				}
			}
		}
	});
	
	function requestBoardDetail(boardId) {
		$.ajax({
			url: getContextPath() + '/board/viewdetail/' + boardId,
			success: function(Board) {
				$("#boardTitle").text(Board.boardTitle);
				
				let boardDate = new Date(Board.boardDate);
				
				let year = boardDate.getFullYear();
				let month = boardDate.getMonth() + 1;
				let date = boardDate.getDate();
				
				let hours = boardDate.getHours();
				let minutes = boardDate.getMinutes();
				let seconds = boardDate.getSeconds();
				
				let completedDate = year + '/' + month + '/' + date + ' ' + hours + ':' + minutes + ':' + seconds;
				
				$("#boardDate").text(completedDate);
				tinymce.get("boardContent").setContent(Board.boardContent);
			}
		});
	}
	</script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendors/bootstrap-datepicker/bootstrap-datepicker.min.css" />
	<style>
	.table th, .jsgrid .jsgrid-table th,
	.table td,
	.jsgrid .jsgrid-table td {
	  padding: 0.525rem 1.375rem;
	}
	.dropdown-toggle::after{
		content:none;
	}
	collapse, .collapsing {
		box-shadow: 0px 0px 0px white !important;
	}
	</style>
</head>

<body>
	<c:if test="${result != null}">
	<input id="result" type="hidden" value="${result}"/>
	<input id="resultCount" type="hidden" value="${resultCount}"/>
	</c:if>
	<div class="container-scroller ">
		<!-- Navbar -->
		<%@ include file="/WEB-INF/views/common/_navbar.jsp"%>
		<div class="container-fluid page-body-wrapper">
			<!-- Sidebar -->
			<%@ include file="/WEB-INF/views/common/_sidebar.jsp"%>

			<!-- 메인 body -->
			<div class="main-panel">
				<div class="content-wrapper">
					<div class="row">
						<div class="col-6 grid-margin stretch-card">
							<div class="card">
								<div class="card-body">
									<div class="row">
										<div class="col-md-12 grid-margin">
											<!-- main title -->
											<div class="d-flex justify-content-between align-items-center mb-4">
												<div class="card-title mb-0">사내 공지</div>
											</div><!-- 메인 title -->
										</div>
									</div>
									
									<!-- Start search box -->
<!-- 									<form class="card gird-margin shadow-2 p-2" style="background-color: #e7e7ff"> -->
<!-- 				        				<div class="card-body" style="box-shadow: 0px 0px 0px white; padding-top: 0;"> -->
<!-- 				        					<div class="row form-inline"> -->
<!-- 												<div class=" form-group"> -->
<!-- 													<div class="card" style="border-radius:18px; border: 1px solid #4747A1;"> -->
<!-- 						        						<div class="input-daterange input-group" id="datepicker" style="border:none; background-color:transparent;"> -->
<!-- 															<span class="mdi mdi-calendar-clock text-primary" style="position: relative; z-index: 1; top:15px; left: 15px;"></span> -->
<!-- 														    <input type="text" class="input-sm form-control" name="start" style="border:0px; text-align: right;"/> -->
<!-- 														    <span class="input-group-addon text-primary font-weight-bold d-flex align-self-center mx-2 fs-30">~</span> -->
<!-- 															<span class="mdi mdi-calendar-clock text-primary" style="position: relative; z-index: 1; top:15px; left: 15px;"></span> -->
<!-- 														    <input type="text" class="input-sm form-control" name="end" style="border-radius:18px;border:0px; text-align: right;"/> -->
<!-- 														</div> -->
<!-- 													</div> -->
<!-- 												</div> -->
<!-- 											</div> -->
<!-- 			        					</div> -->
<!-- 			        					<div class="row form-inline py-0" style="padding: 1.25rem;"> -->
<!-- 											<div class="form-group" > -->
<!-- 												<label class="h3 my-auto mr-1">카테고리</label> -->
<!-- 												<div class="btn dropdown-toggle d-flex form-control" id="dropdownMenuButton1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" -->
<!-- 													style="font-weight:bold;border-radius: 18px; border: 1px solid #4B49AC; background-color: white;"> -->
<!-- 													<i class="text-primary mdi mdi-menu-down"></i>  -->
<!-- 													<input class="selectmenu my-auto" type="text" value="" style="border:none;width:120px;" readonly> -->
<!-- 												</div> -->
<!-- 												<div class="dropdown-menu" aria-labelledby="dropdownMenuButton1"> -->
<!-- 													<h6 class="dropdown-item" id="select-1" onclick="select(1)">전체</h6> -->
<!-- 													<h6 class="dropdown-item" id="select-2" onclick="select(2)">제목</h6>  -->
<!-- 													<h6 class="dropdown-item" id="select-3" onclick="select(3)">작성자</h6> -->
<!-- 												</div> -->
<!-- 											</div> -->
<!-- 											<div class="form-group"> -->
<!-- 												<label class="h3 my-auto ml-2 mr-1">검색어</label> -->
<!-- 												<input class="form-control p-0" type="text" style="border-radius: 18px; border: 1px solid #4B49AC;"> -->
<!-- 											</div> -->
<!-- 											<div class="form-group"> -->
<!-- 												<button class="btn btn-md btn-primary ml-4" style="font-family: LeferiBaseType-RegularA; font-weight:700;"> -->
<!-- 													<span>검색</span> -->
<!-- 												</button> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 				        			</form> -->
				        			<!-- End search box -->
									<!-- 테이블 -->
									<div class="table-responsive">
										<table class="table table-hover">
											<thead>
												<tr>
													<c:if test="${sessionScope.employee.empId eq '2202041'}">
														<th>
															<div class="form-check font-weight-bold text-info">
																<label class="form-check-label">
																	<input id="checkAll" type="checkbox" class="form-check-input">
																</label>
															</div>
														</th>
													</c:if>
													<c:if test="${sessionScope.employee.empId ne '2202041'}">
														<th>문서번호</th>
													</c:if>
													<th>제목</th>
													<th>작성자</th>
													<th>작성날짜</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${boardList}" var="board">
												<tr>
													<c:if test="${sessionScope.employee.empId eq '2202041'}">
														<td>
															<div class="form-check font-weight-bold text-info">
																<label class="form-check-label">
																	<input type="checkbox" class="checklist form-check-input" name="boardId" form="checkedBox" value="${board.boardId}">
																</label>
															</div>
														</td>
													</c:if>
													<c:if test="${sessionScope.employee.empId ne '2202041'}">
														<td class="py-3" style="font-size: 10px;">${board.boardId}</td>
													</c:if>
													<td onclick="requestBoardDetail(${board.boardId})" style="font-size: 13px;">${board.boardTitle}</td>
													<td style="font-size: 10px;">${board.empName}</td>
													<td style="font-size: 10px;"><fmt:formatDate value="${board.boardDate}" pattern="yyyy/MM/dd"/></td>
												</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
									<!-- 테이블 끝 -->
									
									<!-- 하단 버튼 -->
									<c:if test="${sessionScope.employee.empId eq '2202041'}">
										<div class="row d-flex justify-content-end mr-3 my-3">
											<div class="mx-1">
												<form id="checkedBox" action="<c:url value='/board/delete'></c:url>" method="post">
												<input type="hidden" name="boardId" value="">
												</form>
												<button class="btn btn-danger btn-sm" type="submit" form="checkedBox">선택삭제</button>
											</div>
											<div class="mx-1">
													<a class="btn btn-primary btn-sm" href="<c:url value='/board/boardwrite'/>">게시글 쓰기</a>
											</div>
										</div><!-- 하단 버튼 -->
									</c:if>

									<!-- 페이징 -->
									<div class="row mt-3 d-flex justify-content-center">
										<ul class="pagination  pb-0 mb-0">
											<c:if test="${pager.totalRows > 0}">
											<!-- 이전 -->
											<c:if test = "${pager.groupNo > 1}">
											<li class="page-item"><a class="page-link" href="<c:url value='/board/notice/${pager.startPageNo - 1}'></c:url>">이전</a></li>
											</c:if>
											
											<!-- 페이지그룹 -->
											<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
											<c:if test="${pager.pageNo != i}">
											<li class="page-item"><a class="page-link" href="<c:url value='/board/notice/${i}'></c:url>">${i}</a></li>
											</c:if>
											<c:if test="${pager.pageNo == i}">
											<li class="page-item active"><a class="page-link" href="<c:url value='/board/notice/${i}'></c:url>">${i}</a></li>
											</c:if>
											</c:forEach>
											
											<!-- 다음 -->
											<c:if test = "${pager.groupNo < pager.totalGroupNo }">
											<li class="page-item" onclick="submitFormWithPageNo(${pager.endPageNo + 1})"><a class="page-link" href="<c:url value='/board/notice/${pager.endPageNo + 1}'></c:url>">다음</a></li>
											</c:if>
											</c:if>
										</ul>
									</div>
								</div>
							</div>
						</div>
						<!-- 게시글 자세히 보기 -->
						<div class="col-lg-6 grid-margin stretch-card">
							<div class="card">
								<div class="card-body">
									<div class="d-flex justify-content-between align-items-center mb-4">
										<div id="boardTitle" class="card-title mb-0">${board.boardTitle}</div>
									</div>
									<div class="forms-sample">
										<div class="row mt-2 px-3">
											<div class="col-md-6 d-flex">
												<i class="h3 my-auto mdi mdi-calendar text-primary"></i> 
												<span class="font-weight-bold text-primary">작성날짜</span>
												<div id="boardDate" class="from-control ml-3" style="font-weight:bold; border:none;"><fmt:formatDate pattern="yyyy/MM/dd" value="${board.boardDate}"/></div>
											</div>
											<div class="col-md-6 d-flex">
												<i class="h3 my-auto mdi mdi-dns text-primary"></i> 
												<span class="font-weight-bold text-primary">카테고리</span>
												<span class="from-control ml-3" style="font-weight:bold; border:none;">사내공지</span>
											</div>
										</div>
										<div class="row mt-5 px-3">
											<div class="col-md-12">
												<textarea class="form-control" id="boardContent" style="height: 550px;" readonly>${board.boardContent}</textarea>
											</div>
										</div>
									</div>
									
								</div>
							</div>
						</div><!-- end 게시글 자세히 보기 -->
					</div>
				</div>
				<!-- content-wrapper ends -->
				<!-- partial:partials/_footer.jsp -->
				<%@ include file="/WEB-INF/views/common/_footer.jsp"%>
				<!-- partial -->
			</div>
			<!-- main-panel ends -->
		</div>
		<!-- page-body-wrapper ends -->
	</div>
	<!-- container-scroller -->

</body>

</html>
