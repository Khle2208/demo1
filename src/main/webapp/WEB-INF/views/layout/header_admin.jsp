<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/template/AdminLayout.css" />
</head>

<div
	class="topbar d-flex justify-content-between align-items-center px-5">


	<form action="${pageContext.request.contextPath}/${actionUrl}/find"
		class="input-group mb-3 w-25 mt-3" style="background: #e7c998">
		<input type="text" name="findKey" class="form-control" value="${sessionScope.findKey != null ? sessionScope.findKey : ''}" placeholder="Tìm kiếm..."
			aria-describedby="basic-addon2">
		<button type="submit" style="background-color: #CC9600;" class="btn h-auto input-group-text">
			<i class="fa-solid fa-magnifying-glass text-light"></i>
		</button>

	</form>

	<div class="d-flex align-items-center">
		<%-- <div class="dropdown">
			<button class="btn dropdown" type="button" id="notificationDropdown"
				data-bs-toggle="dropdown" aria-expanded="false">
				<i class="fa-solid fa-bell fs-3"></i>
			</button>

			<!-- Dropdown Content -->
			<ul class="dropdown-menu dropdown-menu-end"
				aria-labelledby="notificationDropdown">
				<!-- Header -->
				<li class="dropdown-header">
					<h5>Notifications</h5>
				</li>

				<!-- Notifications -->
				<li class="notification-item"><img
					src="${pageContext.request.contextPath}/image/logo.png"
					class="avatar" alt="User">
					<div class="notification-text">
						<strong>Zone Hand</strong>
						<p>Sản phẩm mới đã được thêm vào</p>
						<span>30p trước</span>
					</div>
					<div class="status-container">
						<span class="status-dot red"></span> <i
							class="fa-solid fa-chevron-right arrow"></i>
					</div></li>
				<li class="notification-item"><img
					src="${pageContext.request.contextPath}/image/logo.png"
					class="avatar" alt="User">
					<div class="notification-text">
						<strong>Zone Hand</strong>
						<p>5 sản phẩm đã bị xóa</p>
						<span>30p trước</span>
					</div>
					<div class="status-container">
						<span class="status-dot red"></span> <i
							class="fa-solid fa-chevron-right arrow"></i>
					</div></li>
				<li class="notification-item"><img
					src="${pageContext.request.contextPath}/image/logo.png"
					class="avatar" alt="User">
					<div class="notification-text">
						<strong>Zone Hand</strong>
						<p>Sản phẩm A đã được cập nhật thông tin</p>
						<span>30p trước</span>
					</div>
					<div class="status-container">
						<span class="status-dot green"></span> <i
							class="fa-solid fa-chevron-right arrow"></i>
					</div></li>
			</ul>
		</div> --%>
		<div class="me-3 text-end">
			<div class="fw-bold">User name</div>
			<div>admin</div>
		</div>
		<img src="${pageContext.request.contextPath}/image/logo.png"
			class="rounded-circle" alt="" width="40" /> <a href="#"
			class="text-decoration-none text-dark"><i
			class="fa-solid fa-right-from-bracket ms-3 fs-3"></i></a>
	</div> 

</div>