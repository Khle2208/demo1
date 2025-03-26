<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Quản lý Doanh thu Sách</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/template/LayoutAdmin.css" />
<style>
.container {
	margin-left: 80px;
	max-width: 100%;
}

.row {
	margin-bottom: 40px;
}

.card {
	border-radius: 10px;
	box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
	min-width: 250px; /* Giữ cho card không quá nhỏ */
}

.overflow-auto {
	white-space: nowrap; /* Ngăn xuống hàng */
	overflow-x: auto; /* Hiển thị thanh cuộn ngang nếu quá dài */
	scrollbar-width: thin; /* Làm thanh cuộn mỏng */
}

.error-popup {
	display: none;
	position: fixed;
	top: 20%;
	left: 60%;
	transform: translateX(-80%);
	background-color: #dc3545; /* Màu đỏ */
	color: white;
	padding: 10px 30px;
	border-radius: 5px;
	z-index: 1000;
	font-size: 15px;
	text-align: center;
	transform: translateX(-50%);
}
</style>
</head>
<body>

	<!-- Navbar -->
	<jsp:include page="../layout/navbar.jsp"></jsp:include>

	<!-- Nội dung chính -->
	<div class="content">
		<jsp:include page="../layout/header_admin.jsp"></jsp:include>

		<div class="mt-4 px-5">
			<h2>Quản lý Doanh thu</h2>
			<p>Admin / Thống kê doanh thu sách</p>
			<hr>
			<c:set var="totalBook"
				value="${sessionScope.totalBook != null ? sessionScope.totalBook : 0}" />
			<c:set var="totalOrder"
				value="${sessionScope.totalOrder != null ? sessionScope.totalOrder : 0}" />
			<c:set var="totalUser"
				value="${sessionScope.totalUser != null ? sessionScope.totalUser : 0}" />

			<fmt:formatDate var="startDateB" value="${sessionScope.startDateB}"
				pattern="yyyy-MM-dd" />
			<fmt:formatDate var="endDateB" value="${sessionScope.endDateB}"
				pattern="yyyy-MM-dd" />
			<fmt:formatDate var="startDateO" value="${sessionScope.startDateO}"
				pattern="yyyy-MM-dd" />
			<fmt:formatDate var="endDateO" value="${sessionScope.endDateO}"
				pattern="yyyy-MM-dd" />
			<fmt:formatDate var="startDateU" value="${sessionScope.startDateU}"
				pattern="yyyy-MM-dd" />
			<fmt:formatDate var="endDateU" value="${sessionScope.endDateU}"
				pattern="yyyy-MM-dd" />
			<%
			HttpSession sessionob = request.getSession(false);

			String errorMessage = (String) request.getAttribute("errorMessage");
			%>
			<!-- Form 1 -->
			<div class=" d-flex flex-row gap-5 p-4">
				<div class=" rounded-2 p-4 w-100 w-md-150 w-lg-40"
					style="border: #464545 solid 1px; background: #ffffff; width: fit-content;">
					<form
						action="${pageContext.request.contextPath}/statistic/StatisticController"
						method="GET" class="text-center">
						<h5
							class="fw-bold text-warning fw-semibold d-flex justify-content-center text-center">
							<i class="fa-solid fa-book"></i>
							<p class="ms-2">Thống kê đơn hàng</p>
						</h5>
						<div class="d-flex justify-content-center gap-4 mt-2">
							<div class="position-relative">
								<input type="date" name="startDateOrder"
									class="form-control form-control-sm" required
									value="${startDateO}">
							</div>
							<div class="position-relative">
								<input type="date" name="endDateOrder"
									class="form-control form-control-sm" required
									value="${endDateO}">
							</div>
						</div>
						<p class="mt-3 fw-semibold text-success">
							📚 Số lượng: <span class="fs-6"
								style="font-weight: bold; color: #248d5c">${not empty totalOrder ? totalOrder : 0}</span>
						</p>
						<button type="submit" class="btn btn-outline-primary btn-sm">
							<i class="fa-solid fa-chart-bar"></i> Thống kê
						</button>
					</form>
				</div>
				<!-- Form 2 -->
				<div class=" rounded-2 p-4 w-100 w-md-150 w-lg-40"
					style="border: #464545 solid 1px; background: #ffffff; width: fit-content;">
					<form
						action="${pageContext.request.contextPath}/statistic/StatisticController"
						method="GET" class="text-center">
						<h5
							class="fw-bold text-warning fw-semibold d-flex justify-content-center text-center">
							<i class="fa-solid fa-book"></i>
							<p class="ms-2">Thống kê sách</p>
						</h5>
						<div class="d-flex justify-content-center gap-4 mt-2">
							<div class="position-relative">
								<input type="date" name="startDateBook"
									class="form-control form-control-sm" required
									value="${startDateB}">
							</div>
							<div class="position-relative">
								<input type="date" name="endDateBook"
									class="form-control form-control-sm" required
									value="${endDateB}">
							</div>
						</div>
						<p class="mt-3 fw-semibold text-success">
							📚 Số lượng: <span class=" fs-6">${not empty totalBook ? totalBook : 0}</span>
						</p>
						<button type="submit" class="btn btn-outline-primary btn-sm">
							<i class="fa-solid fa-chart-bar"></i> Thống kê
						</button>
					</form>
				</div>

			</div>
			<div class=" d-flex flex-row gap-5 p-4">
				<!-- Form 1 -->
				<div class=" rounded-2 p-4 w-100 w-md-150 w-lg-40"
					style="border: #464545 solid 1px; background: #ffffff; width: fit-content;">
					<form
						action="${pageContext.request.contextPath}/statistic/StatisticController"
						method="GET" class="text-center">
						<h5
							class="fw-bold text-warning fw-semibold d-flex justify-content-center text-center">
							<i class="fa-solid fa-book"></i>
							<p class="ms-2">Thống kê tài khoản</p>
						</h5>
						<div class="d-flex justify-content-center gap-4 mt-2">
							<div class="position-relative">
								<input type="date" name="startDateUser"
									class="form-control form-control-sm" required
									value="${startDateU}">
							</div>
							<div class="position-relative">
								<input type="date" name="endDateUser"
									class="form-control form-control-sm" required
									value="${endDateU}">
							</div>
						</div>
						<p class="mt-3 fw-semibold text-success">
							📚 Số lượng: <span class=" fs-6">${not empty totalUser ? totalUser : 0}</span>
						</p>
						<button type="submit" class="btn btn-outline-primary btn-sm">
							<i class="fa-solid fa-chart-bar"></i> Thống kê
						</button>
					</form>
				</div>
				<!-- Form 2 -->

				<div class=" rounded-2 p-4 w-100 w-md-150 w-lg-40"
					style="border: #464545 solid 1px; background: #ffffff; width: fit-content;">
					<form
						action="${pageContext.request.contextPath}/statistic/StatisticController"
						method="get" class="text-center">
						<h5
							class="fw-bold text-warning fw-semibold d-flex justify-content-center">
							<i class="fa-solid fa-book"></i>
							<p class="ms-2">Thống kê Tác giả</p>
						</h5>
						<p class="mt-5 fw-semibold text-success">
							📚 Số lượng: <span class=" fs-6">${not empty authorData ? authorData : 0}</span>
						</p>
						<button type="submit" class="btn btn-outline-primary btn-sm">
							<i class="fa-solid fa-chart-bar"></i> Thống kê
						</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div id="popupError" class="error-popup"
		style="<%=(errorMessage != null) ? "display: block;" : "display: none;"%>">
		<%=(errorMessage != null) ? errorMessage : ""%>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
	function showErrorPopup(message) {
			    let popup = document.getElementById("popupError");
			    popup.innerHTML = message;
			    popup.className = "error-popup"; 
			    popup.style.display = "block";
			    setTimeout(() => { popup.style.display = "none"; }, 3000);
			}
	document.addEventListener("DOMContentLoaded", function () {
	    let popup = document.getElementById("popupError");
	    if (popup && popup.style.display === "block") {
	        setTimeout(() => {
	            popup.style.display = "none";
	        }, 3000); // Ẩn sau 2 giây
	    }
	});
	</script>
</body>
</html>