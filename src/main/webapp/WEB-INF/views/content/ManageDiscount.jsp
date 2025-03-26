<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Book Management</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/template/AdminLayout.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/template/etc_item.css" />
</head>
<body class="overflow-y-hidden position-fixed w-100">
	<jsp:include page="../layout/navbar.jsp"></jsp:include>

	<!-- Nội dung chính -->
	<div class="content">
		<jsp:include page="../layout/header_admin.jsp"></jsp:include>

		<div class="mt-4">
			<div class="row px-5">
				<div class="col-md-6">
					<div class="row">
						<h2>Ưu đãi</h2>
					</div>
					<div class="row">
						<p>/Admin/Quản lý ưu đãi</p>
					</div>
				</div>
				<div class="col-md-6 text-end">
					<div class="row">
						<br>
					</div>
					<div class="row d-flex justify-content-end flex-nowrap">
						<button type="submit" id="deleteButton"
							class="btn border border-1 btn-outline-warning text-dark"
							form="deleteForm" style="width: 150px; height: 40px;">
							<i class="fa-solid fa-trash"></i> Xoá ưu đãi
						</button>
						<button
							class="btn border border-1 ms-3 btn-outline-warning text-dark"
							style="width: 150px; height: 40px;" data-bs-toggle="modal"
							data-bs-target="#addDiscountModal">
							<i class="fa-solid fa-plus"></i> Thêm ưu đãi
						</button>
						<c:choose>
							<c:when test="${showlistDiscountStatus == true}">
								<a class="w-auto"
									href="${pageContext.request.contextPath}/Available-Discount">
									<button
										class="btn border border-1 btn-outline-warning text-dark"
										style="height: 40px;">
										<i class="fa-solid fa-arrow-right-arrow-left"></i> Ưu đãi khả
										dụng
									</button>
								</a>
							</c:when>
							<c:otherwise>
								<a class="w-auto"
									href="${pageContext.request.contextPath}/Unavailable-Discount">
									<button
										class="btn border border-1 btn-outline-warning text-dark"
										style="height: 40px;">
										<i class="fa-solid fa-arrow-right-arrow-left"></i> Ưu đãi
										không khả dụng
									</button>
								</a>
							</c:otherwise>
						</c:choose>

						<c:if
							test="${not empty sessionScope.findKey || not empty sessionScope.filterDiscount}">
							<a href="${pageContext.request.contextPath}/Manage-Discount"
								class="btn border border-1 w-auto btn-outline-warning text-dark"
								style="height: 40px;"> <i class="fa-solid fa-times"></i> Bỏ
								lọc
							</a>
						</c:if>
					</div>
				</div>
			</div>
			<div class="row px-5">
				<form
					action="${pageContext.request.contextPath}/deleteSelectedDiscount"
					method="post" id="deleteForm"
					onsubmit="return confirm('Bạn có chắc chắn muốn xoá ưu đãi đã chọn không?');">
					<div style="height: 40%; overflow-y: croll;">
						<table class="table text-center">
							<thead>
								<tr class="position-sticky top-0 bg-light">
									<th><input type="checkbox" id="selectAll"></th>
									<th>Ưu đãi</th>
									<th>Giá trị</th>
									<th>Số lượng</th>
									<th>Thời hạn</th>
									<th>Chỉnh sửa</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach
									items="${showlistDiscountStatus == true  ? listDiscountUnavailable : (showlistDiscountStatus == false ? listDiscountAvailable : listDiscount)}"
									var="item">
									<tr>
										<td><input type="checkbox" name="selectedDiscount"
											value="${item.discountId}" class="itemCheckbox"></td>
										<td class="text-truncate"
											style="max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${item.nameDiscount}</td>
										<td>${item.discountPrice}</td>
										<td>${item.quantity}</td>
										<td>${item.outDate}</td>
										<td><a
											class="btn w-auto ms-3 btn-outline-warning text-dark border-0"
											href="${pageContext.request.contextPath}/Detail-Discount/${item.discountId}"
											style="width: 150px; height: 40px;"> <i
												class="fa-solid fa-pen"></i>
										</a> <a
											class="btn w-auto ms-3 btn-outline-warning text-dark border-0"
											href="${pageContext.request.contextPath}/Delete-Discount/${item.discountId}"
											onclick="return confirm('Bạn có chắc chắn muốn xóa ưu đãi này?');"
											style="width: 150px; height: 40px;"> <i
												class="fa-solid fa-trash"></i>
										</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>

				</form>

			</div>
		</div>
	</div>

</body>

<div class="modal fade" id="addDiscountModal" tabindex="-1"
	aria-labelledby="addDiscountModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg " style="margin-top: 15vh;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title text-center w-100" id="addDiscountModalLabel">Thêm
					ưu đãi mới</h5>
				<a href="${pageContext.request.contextPath}/Manage-Discount">
					<button type="button" class="btn" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-x" style="color: #CC9600;"></i>
					</button>
				</a>

			</div>

			<div class="modal-body">
				<form:form modelAttribute="discount" method="POST"
					action="${pageContext.request.contextPath}/Add-Discount">
					<div class="row g-4">
						<div class="col-md-6">
							<p class="ps-2">Tên ưu đãi</p>
							<form:input path="nameDiscount" class="form-control"
								placeholder="Nhập tên ưu đãi" />
							<p class="text-danger ps-2">
								<form:errors path="nameDiscount"></form:errors>
							</p>
						</div>
						<div class="col-md-6">
							<p class="ps-2">Ngày hết hạn</p>
							<form:input path="outDate" type="date" class="form-control"
								placeholder="dd/mm/yyyy" />
							<p class="text-danger ps-2">
								<form:errors path="outDate"></form:errors>
							</p>
						</div>
						<div class="col-md-6">
							<p class="ps-2">Giá trị</p>
							<form:input path="discountPrice" class="form-control"
								placeholder="Nhập giá trị"
								oninput="this.value = this.value.replace(/[^0-9]/g, '');" />
							<p class="text-danger ps-2">
								<form:errors path="discountPrice"></form:errors>
							</p>
						</div>
						<div class="col-md-6">
							<p class="ps-2">Số lượng</p>
							<form:input path="quantity" type="number" min="1" max="1000"
								class="form-control" placeholder="Nhập số lượng ưu đãi"
								oninput="this.value = this.value.replace(/[^0-9]/g, '');" />
							<p class="text-danger ps-2">
								<form:errors path="quantity"></form:errors>
							</p>
						</div>

						<div class="col-md-12 text-center">
							<div>
								<button type="submit" name="action" value="addBook"
									class="btn w-auto" style="background-color: #CC9600;">Thêm
									ưu đãi</button>
							</div>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>

</div>


<div class="modal fade" id="detailDiscountModal" tabindex="-1"
	aria-labelledby="detailDiscountModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg " style="margin-top: 15vh;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title text-center w-100"
					id="detailDiscountModalLabel">Cập nhật ưu đãi</h5>
				<a href="${pageContext.request.contextPath}/Manage-FindDiscount">
					<button type="button" class="btn" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-x" style="color: #CC9600;"></i>
					</button>
				</a>

			</div>

			<div class="modal-body">
				<form:form modelAttribute="discountUpdate" method="POST"
					action="${pageContext.request.contextPath}/Update-Discount"
					onsubmit="return confirm('Bạn có chắc chắn muốn cập nhật ưu đãi này không?');">
					<input type="hidden" name="discountId"
						value="${discountUpdate.discountId}" />
					<div class="row g-4">
						<div class="col-md-6">
							<p class="ps-2">Tên ưu đãi</p>
							<form:input path="nameDiscount" class="form-control"
								placeholder="Nhập tên ưu đãi" />
							<p class="text-danger ps-2">
								<form:errors path="nameDiscount"></form:errors>
							</p>
						</div>
						<div class="col-md-6">
							<p class="ps-2">Ngày hết hạn</p>
							<form:input path="outDate" type="date" class="form-control"
								placeholder="dd/mm/yyyy" />
							<p class="text-danger ps-2">
								<form:errors path="outDate"></form:errors>
							</p>
						</div>
						<div class="col-md-6">
							<p class="ps-2">Giá trị</p>
							<form:input path="discountPrice" class="form-control"
								placeholder="Nhập giá trị"
								oninput="this.value = this.value.replace(/[^0-9]/g, '');" />
							<p class="text-danger ps-2">
								<form:errors path="discountPrice"></form:errors>
							</p>
						</div>
						<div class="col-md-6">
							<p class="ps-2">Số lượng ${discountUpdate.quantity}</p>
							<form:input path="quantity" type="hidden"/>
							<div class="d-flex">
									<input class="w-25" type="number" value="0"
										placeHolder="Số lượng" name="quantityUpdate" min="0"
										max="1000">

									<div class="form-check mx-2">
										<input class="form-check-input" type="radio" name="option"
											id="option1" value="increase"> <label
											class="form-check-label" for="option1">Thêm</label>
									</div>

									<div class="form-check">
										<input class="form-check-input" type="radio" name="option"
											id="option2" value="decrease"> <label
											class="form-check-label" for="option2">Giảm</label>
									</div>
								</div>
						</div>

						<div class="col-md-12 text-center">
							<div>
								<button type="submit" name="action" value="update"
									class="btn w-auto" style="background-color: #CC9600;">Cập
									nhật</button>
							</div>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>

</div>

<div class="modal fade" id="aunouceDiscountModal" tabindex="-1"
	aria-labelledby="aunouceDiscountModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg"
		style="margin-top: 15vh; max-width: 450px;">
		<div class="modal-content">
			<div class="modal-header ms-auto">

				<button type="button" class="btn" data-bs-dismiss="modal"
					aria-label="Close">
					<i class="fa-solid fa-x" style="color: #cc9600"></i>
				</button>

			</div>
			<h3 class="modal-title text-center w-100"
				id="aunouceDiscountModalLabel">Thông báo</h3>

			<div class="modal-body">
				<form class="w-100">
					<div class="d-flex justify-content-center mb-4">
						<div class="position-relative">
							<div
								class="d-flex align-items-center justify-content-center bg-danger rounded-circle"
								style="width: 100px; height: 100px;">
								<i class="fas fa-times text-white" style="font-size: 48px;"></i>
							</div>
						</div>
					</div>
					<p class="text-center text-muted">Có ưu đãi không khả dụng</p>
					<div class="d-flex justify-content-center">
						<a class="btn text-light w-auto"
							href="${pageContext.request.contextPath}/Unavailable-Discount"
							style="background-color: #CC9600;">Đến Xem</a>
					</div>

				</form>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="aunouceDiscountNotFoundModal" tabindex="-1"
		aria-labelledby="aunouceDiscountkNotFoundModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg"
			style="margin-top: 15vh; max-width: 450px;">
			<div class="modal-content">
				<div class="modal-header ms-auto">
					<a href="${pageContext.request.contextPath}/Manage-Discount">
						<button type="button" class="btn" data-bs-dismiss="modal"
							aria-label="Close">
							<i class="fa-solid fa-x" style="color: #cc9600"></i>
						</button>
					</a>

				</div>
				<h3 class="modal-title text-center w-100" id="aunouceBookModalLabel">Thông
					báo</h3>

				<div class="modal-body">
					<form class="w-100">
						<div class="d-flex justify-content-center mb-4">
							<div class="position-relative">
								<div
									class="d-flex align-items-center justify-content-center bg-danger rounded-circle"
									style="width: 100px; height: 100px;">
									<i class="fas fa-times text-white" style="font-size: 48px;"></i>
								</div>
							</div>
						</div>
						<p class="text-center text-muted">Không có ưu đãi cần tìm</p>
					</form>
				</div>
			</div>
		</div>
	</div>


<script>
	document.getElementById('selectAll').addEventListener('change', function() {
		var checkboxes = document.querySelectorAll('.itemCheckbox');
		for (var i = 0; i < checkboxes.length; i++) {
			checkboxes[i].checked = this.checked;
		}
	});
</script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<c:if test="${not empty sessionScope.showNotFoundDiscount}">
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			var modal = new bootstrap.Modal(document
					.getElementById('aunouceDiscountNotFoundModal'));
			modal.show();
		});
	</script>
</c:if>
<c:if test="${not empty showAddDiscountModal}">
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			var modal = new bootstrap.Modal(document
					.getElementById('addDiscountModal'));
			modal.show();
		});
	</script>
</c:if>
<c:if test="${not empty showUpdateModal}">
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			var modal = new bootstrap.Modal(document
					.getElementById('detailDiscountModal'));
			modal.show();
		});
	</script>
</c:if>
<c:if
	test="${not empty listDiscountUnavailable && empty showlistDiscountStatus}">
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			if (!sessionStorage.getItem('unavailablePopupShown')) {
				var modal = new bootstrap.Modal(document
						.getElementById('aunouceDiscountModal'));
				modal.show();
				sessionStorage.setItem('unavailablePopupShown', 'true');
			}

		});
	</script>
</c:if>
<script>
	// Hàm kiểm tra xem có checkbox nào được chọn không
	function updateDeleteButtonVisibility() {
		// Lấy tất cả các checkbox có class "itemCheckbox"
		var checkboxes = document.querySelectorAll('.itemCheckbox');
		// Kiểm tra xem có checkbox nào được chọn không
		var anyChecked = Array.from(checkboxes).some(function(cb) {
			return cb.checked;
		});
		// Lấy nút xoá theo id
		var deleteButton = document.getElementById('deleteButton');
		// Nếu không có checkbox nào được chọn, ẩn nút xoá, ngược lại hiện nút xoá
		if (!anyChecked) {
			deleteButton.style.display = 'none';
		} else {
			deleteButton.style.display = 'inline-block'; // hoặc 'block' tùy theo giao diện
		}
	}

	// Gắn sự kiện lắng nghe cho tất cả các checkbox khi có thay đổi
	document.querySelectorAll('.itemCheckbox').forEach(function(checkbox) {
		checkbox.addEventListener('change', updateDeleteButtonVisibility);
	});

	// Cập nhật lại trạng thái nút khi chọn/ bỏ chọn tất cả
	document.getElementById('selectAll').addEventListener('change', function() {
		var isChecked = this.checked;
		document.querySelectorAll('.itemCheckbox').forEach(function(checkbox) {
			checkbox.checked = isChecked;
		});
		updateDeleteButtonVisibility();
	});

	// Kiểm tra trạng thái nút khi trang được tải
	document.addEventListener("DOMContentLoaded", updateDeleteButtonVisibility);
</script>
</html>