<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- Plugin css,js for this page -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendors/clockpicker/bootstrap-clockpicker.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendors/clockpicker/jquery-clockpicker.css">
<script src="${pageContext.request.contextPath}/resources/vendors/clockpicker/bootstrap-clockpicker.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendors/clockpicker/jquery-clockpicker.js"></script>

<style>
	.custom-border-left {
		border-left: 1px solid rgb(206, 212, 218);
	}
	
	.custom-border-right {
		border-right: 1px solid rgb(206, 212, 218);
	}
	
	#intime-clockpicker .mdi-timer, #outtime-clockpicker .mdi-timer {
		position: relative;
		z-index: 1;
		top: 11px;
		left: 35px;
}
</style>

<script>
	//form 내용 제출 후, 이동
	function levAppAprv(state, id) {
// 		if ($('#textarea-reason').val()) {
// // 			location.href = "<c:url value='/hr/hrapplication'/>";
// // 			window.close();
// 		}
		
		//"승인" 버튼을 눌렀을 경우
		if(state == "승인") {
			$.ajax({
				type: 'GET',
				url: '../hr/levappaprvstatecomplete',
				data: {levAppProcessState: state, levAppId: id},
				error: function() {
					alert('결재를 실패하였습니다.');
				},
				success: function(data) {
					$('#lev-app-aprv-detail').html(data);
					$('#aprv-state').html('<div class="badge badge-success font-weight-bold text-white">승인</div>');
				}
			});
		} else if(state == "반려") {
			$("#refuse-reason").css("display", "block");
			$("#cancel-btn").css("display", "block");
			$("#approve-btn").css("display", "none");
			
			let opinion = $("#textarea-reason").val(); //반려사유 선택
			$.ajax({
				 type : 'GET',
				 url : "../hr/levappaprvstatecomplete",
				 data : {levAppProcessState: data, levAppId: id, levAppOpinion: opinion},
				 error : function() {
					 alert('통신실패!');
				 },
				 success : function(data) {
					 $('#lev-app-aprv-detail').html(data);
				 }
			 });
		}
	}

	//취소버튼
	function cancel() {
		$('#textarea-reason').val('');
		$("#refuse-reason").css("display", "none");
		$("#cancel-btn").css("display", "none");
		$("#approve-btn").css("display", "block");
	}
</script>
<!-- End plugin css,js for this page -->
</head>

<div class="grid-margin stretch-card">
	<div class="card">
		<div class="card-body">
			<div class="d-flex justify-content-between align-items-baseline">
				<div class="card-title">휴가 신청서 </div>
				<button type="button" onclick="backLevList()" class="btn btn-sm"><h3 class="mdi mdi-window-close text-primary mt-1 mb-0"></h3></button>
			</div>
			<div class="table-responsive px-3 py-2">
				<!-- 고정 내용 -->
				<table class="table">
					<tbody>
						<tr class="custom-border-left custom-border-right">
							<td class="custom-border-right"><h4
									class="font-weight-bold text-center m-0">작성자</h4></td>
							<td>${sessionScope.employee.empName}</td>
							<td></td>
							<td></td>
							<td class="custom-border-left custom-border-right">
								<h4 class="font-weight-bold text-center m-0">신청날짜</h4>
							</td>
							<td><fmt:formatDate value="${levApp.levAppDate}" pattern="yyyy-MM-dd" /></td>
							<td></td>
						</tr>
						<tr class="custom-border-left custom-border-right">
							<td class="custom-border-right">
								<h4 class="font-weight-bold text-center m-0">결재자</h4>
							</td>
							<td>${levApp.levAppApprovalEmpName}</td>
							<td></td>
							<td></td>
							<td class="custom-border-left custom-border-right"><h4
									class="font-weight-bold text-center m-0">신청결과</h4></td>
							<td>
								<!-- 결재상태 --> 
								<c:if test="${levApp.levAppProcessState == '미처리'}">
									<div class="badge badge-secondary font-weight-bold text-white">${levApp.levAppProcessState}</div>
								</c:if> 
								<c:if test="${levApp.levAppProcessState == '승인'}">
									<div class="badge badge-success font-weight-bold">${levApp.levAppProcessState}</div>
								</c:if> 
								<c:if test="${levApp.levAppProcessState == '반려'}">
									<div class="badge badge-danger font-weight-bold">${levApp.levAppProcessState}</div>
								</c:if>
							</td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- 변경내용-->
			<div class="container-fluid">
				<div class="row justify-content-center">
					<div style="border: 1px solid #a3a4a5; opacity: 0.5; width: 90%;"></div>
				</div>
				<!-- 휴가 유형 -->
				<div class="row">
					<div class="col-md d-flex align-items-center px-5 py-2">
						<h4 class="mx-4 mb-0 font-weight-bold">휴가유형</h4>
						<h6 class="ml-2 mb-0 text-primary font-weight-bold">
							${levApp.levAppCategory}
						</h6>
					</div>
				</div>
				<!-- 기간(날짜) 선택 -->
				<div class="row px-5 py-2">
					<div class="col-md d-flex align-items-center pl-0">
						<h4 class="mx-4 mb-0 font-weight-bold">휴가기간</h4>
						<h6 class="ml-2 mb-0 text-primary font-weight-bold">
							<fmt:formatDate value="${levApp.levAppStartDate}" pattern="yyyy-MM-dd" />
							~
							<fmt:formatDate value="${levApp.levAppEndDate}" pattern="yyyy-MM-dd" />
						</h6>
						<!-- 휴가 날짜 -->
						<small class="text-muted ml-2">
							( 총 ${levApp.levPeriod}일 )
							<input id="lev-period" type="hidden" value="${levApp.levPeriod}" />
						</small>
					</div>
				</div>
				<!-- 휴가사유 -->
				<div class="row px-5 mt-4 justify-content-start">
					<h4 class="mx-4 mb-0 font-weight-bold ">사유</h4>
				</div>
				<div class="row px-5 mt-3 ml-1">
					<h6 class="ml-1 mb-0 text-primary font-weight-bold">${levApp.levAppReason}</h6>
				</div>
				<div class="row justify-content-center mt-3">
					<div style="border-bottom: 2px solid #4B49AC; width: 90%;"></div>
				</div>
				<!-- 반려사유 조회 -->
				<c:if test="${!empty levApp.levAppOpinion}">
					<div class="row px-5 mt-3 justify-content-start">
						<h4 class="mx-4 mb-0 font-weight-bold text-danger">반려 사유</h4>
					</div>
					<div class="row px-5 mt-3 ml-1">
						<h6 class="ml-1 mb-0 text-danger">${levApp.levAppOpinion}</h6>
					</div>
				</c:if>
				<!-- 반려사유 c:if 사용하기 -->
				<div id="refuse-reason" class="row px-5 mt-4 justify-content-center" style="display: none;">
					<div class="form-group">
						<label class="ml-1" for="reason"><div class="h5 m-0 font-weight-bold text-danger">반려사유</div></label>
						<textarea class="form-control" id="textarea-reason" rows="5" cols="68"></textarea>
					</div>
				</div>
			</div>
			<!-- 일반 임직원일 경우의 버튼 -->
			<c:if
				test="${sessionScope.employee.empId ne levApp.levAppApprovalEmpId}">
				<div class="row px-5 mt-3 justify-content-end">
					<button onclick="window.close()" type="button"
						class="btn btn-inverse-primary mr-2">닫기</button>
				</div>
			</c:if>
			<!-- 부서장일 경우의 버튼 - 미처리 결재인 경우 -->
			<c:if test="${(sessionScope.employee.empId eq levApp.levAppApprovalEmpId) && (levApp.levAppProcessState eq '미처리') }">
				<div class="row px-5 mt-3 justify-content-end">
					<button id="approve-btn" onclick="levAppAprv('승인', '${levApp.levAppId}')" type="button" class="btn btn-primary mr-2">승인</button>
					<button id="cancel-btn" onclick="cancel()" type="button"
						class="btn btn-inverse-primary mr-2" style="display: none">취소</button>
					<button onclick="levAppAprv('반려', '${levApp.levAppId}')" type="button"
						class="btn btn-danger mr-2">반려</button>
				</div>
			</c:if>
			<!-- 변경내용:end -->
		</div>
		<!-- card-body:end -->
	</div>
</div>