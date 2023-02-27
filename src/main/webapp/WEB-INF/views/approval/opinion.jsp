<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>
	<!-- CSS, JS 관련 파일 -->
	<%@ include file="/WEB-INF/views/common/head.jsp" %>
	<!-- Custom js for this page-->
	<style>
	#overflow {
		overflow: auto;
	}
	.highlight:hover {
		font-weight: bold;
		color: #4747A1;
	}
	.container-fluid{
		padding:0px;
		margin:0px;
	}
	.main-panel-popup {
	  transition: width 0.25s ease, margin 0.25s ease;
	  width: 100%;
	  min-height: 100vh;
	  display: -webkit-flex;
	  display: flex;
	  -webkit-flex-direction: column;
	  flex-direction: column;
	}
	</style>
</head>

<body>
	<div class="main-panel-popup">
			<div class="content-wrapper">
				<!-- Start information -->
				<div class="row">
					<div class="col-12 grid-margin stretch-card">
						<div class="card">
							<form class="card-body row m-0">
								<div class="container-fluid">
									<div class="card-title row mx-1 my-3">
										<label for="exampleTextarea1">반려 의견</label>
									</div>
									<div class="row m-1 mt-3 form-group d-flex flex-column">
										<div class="form-group">
											<textarea class="form-control" id="exampleTextarea1" rows="4"></textarea>
										</div>
									</div>
									<div class="row mb-3" >
										<div class="col"></div>
										<button class="col btn btn-primary btn-md mt-1 mx-3" onclick="window.close()">반려하기</button>
										<button class="col btn btn-outline-primary btn-md mt-1 mx-3" onclick="window.close()">작성 취소</button>
										<div class="col"></div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
				
			</div>
		</div>
</body>

</html>