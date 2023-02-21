<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

	<head>
	<!-- CSS 관련 파일 -->
		<%@ include file="/WEB-INF/views/common/head.jsp" %>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mail.css"/>
		<script>
        function popup(){
            var url = "trashpopup";
            var name = "trash popup";
            var option = "width = 500, height = 200, top = 100, left = 200, location = no, resizable=no, scrollbars=no  "
            window.open(url, name, option);
        }
		</script>	
	</head>

<body>
	<div class="container-scroller">
		<!-- Navbar -->
		<%@ include file="/WEB-INF/views/common/_navbar.jsp"%>
		<div class="container-fluid page-body-wrapper">
			<!-- To_do_List/Chat -->
			<%@ include file="/WEB-INF/views/common/_settings-panel.jsp"%>
			<!-- Sidebar -->
			<%@ include file="/WEB-INF/views/common/_sidebar.jsp"%>

			<!-- 메인 body -->
			<div class="main-panel">
				<div class="content-wrapper">
					<!-- import and send mail -->
					<div class="row">
						<div class="col-lg-12 grid-margin stretch-card">
							<div class="card">
								<div class="card-body">
									<h4 class="card-title">휴지통</h4>
									<!-- 테이블 -->
									<div class="table-responsive">
										<table class="table table-hover">
											<thead>
												<tr>
													<th class="p-1">
														<div class="d-flex form-check font-weight-bold text-info ml-3">
															<label class="form-check-label m-0">
																<input type="checkbox" class="form-check-input" name="optradio">
															</label>
															<div class="dropdown">
																<button class="dropdown-toggle p-0 ml-3" 
																	 id="dropdownMenuIconButton2"
																	data-toggle="dropdown" aria-haspopup="true"
																	aria-expanded="false">
																</button>
																<div class="dropdown-menu" aria-labelledby="dropdownMenuIconButton2">
																	<a class="dropdown-item" href="#">전체선택</a> 
																	<a class="dropdown-item" href="#">읽은메일</a> 
																	<a class="dropdown-item" href="#">읽지않은메일</a>
																</div>
															</div>
														</div>
													</th>
													<th class="col-2">ID</th>
													<th class="col-6">제목</th>
													<th class="col-2">날짜</th>
													<th class="col-1">읽음</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>
														<div class="form-check font-weight-bold text-info">
															<label class="form-check-label">
																<input type="checkbox" class="form-check-input" name="optradio">
															</label>
														</div>
													</td>
													<td><i class="mdi mdi-arrow-right text-primary"></i> Photoshop</td>
													<td class="text-danger">28.76% <i
														class="ti-arrow-down"></i>
													</td>
													<td><label class="badge badge-danger">Pending</label></td>
													<td>읽음</td>
												</tr>
												<tr>
													<td>
														<div class="form-check font-weight-bold text-info">
															<label class="form-check-label">
																<input type="checkbox" class="form-check-input" name="optradio">
															</label>
														</div>
													</td>
													<td><i class="mdi mdi-arrow-right text-primary"></i> Flash</td>
													<td class="text-danger">21.06% <i
														class="ti-arrow-down"></i></td>
													<td><label class="badge badge-warning">In
															progress</label></td>
													<td>읽음</td>
												</tr>
												<tr>
													<td>
														<div class="form-check font-weight-bold text-info">
															<label class="form-check-label">
																<input type="checkbox" class="form-check-input" name="optradio">
															</label>
														</div>
													</td>
													<td><i class="mdi mdi-arrow-right text-primary"></i> Premier</td>
													<td class="text-danger">35.00% <i
														class="ti-arrow-down"></i></td>
													<td><label class="badge badge-info">Fixed</label></td>
													<td>읽음</td>
												</tr>
												<tr>
													<td>
														<div class="form-check font-weight-bold text-info">
															<label class="form-check-label">
																<input type="checkbox" class="form-check-input" name="optradio">
															</label>
														</div>
													</td>
													<td><i class="mdi mdi-arrow-right text-primary"></i> After effects</td>
													<td class="text-success">82.00% <i class="ti-arrow-up"></i></td>
													<td><label class="badge badge-success">Completed</label></td>
													<td>읽음</td>
												</tr>
												<tr>
													<td>
														<div class="form-check font-weight-bold text-info">
															<label class="form-check-label">
																<input type="checkbox" class="form-check-input" name="optradio">
															</label>
														</div>
													</td>
													<td><i class="mdi mdi-arrow-right text-primary"></i> 53275535</td>
													<td class="text-success">98.05% <i class="ti-arrow-up"></i></td>
													<td><label class="badge badge-warning">In
															progress</label></td>
													<td>읽음</td>
												</tr>
											</tbody>
										</table>
									</div>
									<!-- 테이블 끝 -->

									<!-- 페이징 -->
									<div class="row mt-3">
										<div class="col-3"></div>
										<div class="col" style="text-align: center;">처음 이전 1 2 3
											4 5 다음 끝</div>
										<div class="col-3"></div>
									</div>
									<!-- 페이징 끝 -->
									<!-- 삭제 버튼 -->
									<div class="row">
										<div class="col-2">
											<button class="btn btn-outline-danger btn-sm" onclick="popup()">선택
												삭제</button>
										</div>
									</div>
									<!-- 삭제버튼 끝 -->

								</div>
							</div>
						</div>
					</div>
					<!-- End import and send mail -->
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
