<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<style>
.dropdown-toggle::after {
	display: none;
	.
	dropdown
	{
	background-color
	:
	transparent
	!important;
}
}
</style>
<link rel="stylesheet" href="/MockProject/template/AdminLayout.css" />
</head>

<div class="sidebar">
	<div class="sidebar-row-title">
		<h3>
			<img src="${pageContext.request.contextPath}/image/LogoImage.png"
				class="img-fluid" alt="" /> BOOKZONE
		</h3>
	</div>
	<div class="sidebar-row">
		<a href="${pageContext.request.contextPath}/Manage-Book"><i
			class="fas fa-book"></i> Sách</a>
	</div>
	<div class="sidebar-row">
		<a href="${pageContext.request.contextPath}/Manage-Genre"><i
			class="fas fa-layer-group"></i> Thể loại</a>
	</div>
	<div class="sidebar-row">
		<a href="${pageContext.request.contextPath}/Manage-Author"><i
			class="fas fa-user"></i> Tác giả</a>
	</div>
	<div class="sidebar-row">
		<a href="${pageContext.request.contextPath}/Manage-User"><i
			class="fas fa-user-circle"></i> Tài khoản</a>
	</div>
	<div class="sidebar-row">
		<a href="${pageContext.request.contextPath}/Manage-Order"><i
			class="fas fa-box"></i> Đơn hàng</a>
	</div>
	<div class="sidebar-row">
		<a href="${pageContext.request.contextPath}/Manage-Discount"><i
			class="fas fa-tags"></i> Ưu đãi</a>
	</div>
	<div class="sidebar-row">
		<div class="dropdown">
			<button class="dropdown-toggle bg-transparent border-0 text-light"
				data-bs-flip="false" type="button" id="dropdownMenuButton1"
				data-bs-toggle="dropdown" aria-expanded="false">
				<i class="fas fa-chart-line"></i> Thống kê
			</button>
			<ul class="dropdown-menu w-auto border-0 bg-transparent"
				aria-labelledby="dropdownMenuButton1">
				<li><a href="${pageContext.request.contextPath}/StatisticBook">Tổng
						quát</a></li>
				<li><a class=""
					href="${pageContext.request.contextPath}/ChartOrder">Đơn hàng</a></li>
				<li><a class=""
					href="${pageContext.request.contextPath}/ChartRevenue">Doanh
						thu</a></li>
				<li><a class=""
					href="${pageContext.request.contextPath}/ChartBook">Sách</a></li>
				<li><a class=""
					href="${pageContext.request.contextPath}/ChartUser">Tài khoản</a></li>
			</ul>
		</div>
	</div>
</div>