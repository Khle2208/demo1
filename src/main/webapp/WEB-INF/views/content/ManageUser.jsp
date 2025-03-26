<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>User Management</title>
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
	<!-- Sidebar -->

	<jsp:include page="../layout/navbar.jsp"></jsp:include>

	<!-- Nội dung chính -->
	<div class="content">
		<jsp:include page="../layout/header_admin.jsp"></jsp:include>

		<div class="mt-4">
			<div class="row px-5">
				<div class="col-md-6">
					<div class="row">
						<h2>User</h2>
					</div>
					<div class="row">
						<p>/Admin/ Quản lý user</p>
					</div>

				</div>

				<div class="col-md-6 text-end">
					<div class="row">
						<br>
					</div>
					<div class="row d-flex justify-content-end flex-nowrap">
						<button type="submit" name="action" value="lock"
							class="btn border border-1 actionButton btn-outline-warning text-dark"
							form="statusForm"
							onclick="return confirm('Bạn có chắc chắn muốn khoá user đã chọn không?');"
							style="width: 150px; height: 40px;">
							<i class="fa-solid fa-lock"></i> Khoá tất cả
						</button>
						<button type="submit" name="action" value="unlock"
							class="btn border text-nowrap border-1 ms-2 actionButton btn-outline-warning text-dark"
							form="statusForm"
							onclick="return confirm('Bạn có chắc chắn muốn mở khoá user đã chọn không?');"
							style="width: auto; height: 40px;">
							<i class="fa-solid fa-lock-open"></i> Mở khoá tất cả
						</button>

						<c:choose>
							<c:when test="${showlistUserStatus == true}">
								<a class="w-auto "
									href="${pageContext.request.contextPath}/Available-User">
									<button
										class="btn border border-1 btn-outline-warning text-dark"
										style="height: 40px;">
										<i class="fa-solid fa-arrow-right-arrow-left"></i> User không
										khoá
									</button>
								</a>
							</c:when>
							<c:otherwise>
								<a class="w-auto"
									href="${pageContext.request.contextPath}/Unavailable-User">
									<button
										class="btn border border-1 btn-outline-warning text-dark"
										style="height: 40px;">
										<i class="fa-solid fa-arrow-right-arrow-left"></i> User đã
										khoá
									</button>
								</a>
							</c:otherwise>
						</c:choose>

						<c:if
							test="${not empty sessionScope.findKey || not empty sessionScope.filterUser}">
							<a href="${pageContext.request.contextPath}/Manage-User"
								class="btn border border-1 w-auto" style="height: 40px;"> <i
								class="fa-solid fa-times"></i> Bỏ lọc
							</a>
						</c:if>
					</div>
				</div>
			</div>
			<div class="row px-5">
				<form
					action="${pageContext.request.contextPath}/setStatusSelectedUser"
					method="post" id="statusForm">
					<div style="height: 500px; overflow-y: croll;">
						<table class="table text-center">
							<thead>
								<tr class="position-sticky top-0 bg-light">
									<th><input type="checkbox" id="selectAll"></th>
									<th>Username</th>
									<th>Email</th>
									<th>Ngày đăng ký</th>
									<th>Chỉnh sửa</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach
									items="${showlistUserStatus == true ? listUserLock : (showlistUserStatus == false ? listUserOpen : listUser) }"
									var="item">
									<tr>
										<td><input type="checkbox" name="selectedUser"
											value="${item.userId}" class="itemCheckbox"></td>
										<td class="text-truncate"
											style="max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${item.username }</td>
										<td class="text-truncate"
											style="max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${item.email}</td>
										<td><fmt:formatDate value="${item.createdAt}"
												pattern="dd/MM/yyyy HH:mm:ss" /></td>
										<td><a
											class="btn w-auto ms-3 btn-outline-warning text-dark border-0"
											href="${pageContext.request.contextPath}/Detail-User/${item.userId}"
											style="width: 150px; height: 40px;"><i
												class="fa-solid fa-file"></i></a> <c:choose>
												<c:when test="${item.status == 1}">
													<a
														class="btn w-auto ms-3 btn-outline-warning text-dark border-0"
														href="${pageContext.request.contextPath}/Status-User/${item.userId}?status=${0}"
														onclick="return confirm('Bạn có chắc chắn muốn khoá user này không?');"
														style="width: 150px; height: 40px;"> <i
														class="fa-solid fa-lock-open"></i>
													</a>
												</c:when>
												<c:otherwise>
													<a
														class="btn w-auto ms-3 btn-outline-warning text-dark border-0"
														href="${pageContext.request.contextPath}/Status-User/${item.userId}?status=${1}"
														onclick="return confirm('Bạn có chắc chắn muốn mở khoá user này không?');"
														style="width: 150px; height: 40px;"> <i
														class="fa-solid fa-lock"></i>
													</a>
												</c:otherwise>
											</c:choose></td>


									</tr>
								</c:forEach>

							</tbody>
						</table>
					</div>
				</form>

			</div>
		</div>
	</div>

	<div class="modal fade" id="detailUserModal" tabindex="-1"
		aria-labelledby="detailUserModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" style="margin-top: 15vh;">
			<div class="modal-content">
				<div class="modal-header ms-auto">
					<a href="${pageContext.request.contextPath}/Manage-FindUser">
						<button type="button" class="btn" data-bs-dismiss="modal"
							aria-label="Close">
							<i class="fa-solid fa-x" style="color: #cc9600"></i>
						</button>
					</a>
				</div>
				<h3 class="modal-title text-center w-100" id="addBookModalLabel">
					Thông tin user</h3>

				<div class="modal-body">
					<form:form class="w-100"
						action="${pageContext.request.contextPath}/Update-Author"
						modelAttribute="userDetail">
						<div class="row g-4">
							<input type="hidden" name="userId" value="${userDetail.userId}" />
							<div class="col-md-6">
								<p class="ps-2">Tài khoản</p>
								<form:input path="username" class="form-control" readonly="true" />
							</div>
							<div class="col-md-6">
								<p class="ps-2">Email</p>
								<form:input path="email" class="form-control" readonly="true" />
							</div>
							<div class="col-md-6">
								<p class="ps-2">Giới tính</p>
								<form:input path="sex" class="form-control" readonly="true" />
							</div>
							<fmt:formatDate value="${userDetail.updatedAt}"
								pattern="dd/MM/yyyy HH:mm:ss" var="formattedUpdatedAt" />
							<div class="col-md-6">
								<p class="ps-2">Ngày cập nhật gần nhất</p>
								<form:input path="updatedAt" class="form-control"
									value="${formattedUpdatedAt}" readonly="true" />
							</div>

							<div class="col-md-6">
								<p class="ps-2">Số điện thoại</p>
								<form:input path="phone" class="form-control" readonly="true" />
							</div>
							<div class="col-md-6">
								<p class="ps-2">Số lượng đơn hàng</p>
								<input class="form-control" value="${quantityOrder}" readonly />
							</div>
							<fmt:formatDate value="${userDetail.createdAt}"
								pattern="dd/MM/yyyy HH:mm:ss" var="formattedCreatedAt" />
							<div class="col-md-6">
								<p class="ps-2">Ngày tạo</p>
								<form:input path="createdAt" class="form-control"
									value="${formattedUpdatedAt}" readonly="true" />
							</div>

							<div class="col-md-6">
								<p class="ps-2">Số lần đánh giá</p>
								<input class="form-control" value="${quantityRating}" readonly />
							</div>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="aunouceUserNotFoundModal" tabindex="-1"
		aria-labelledby="aunouceUserNotFoundModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg"
			style="margin-top: 15vh; max-width: 450px;">
			<div class="modal-content">
				<div class="modal-header ms-auto">
					<a href="${pageContext.request.contextPath}/Manage-User">
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
						<p class="text-center text-muted">Không có user cần tìm</p>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script>
		document.getElementById('selectAll')
				.addEventListener(
						'change',
						function() {
							var checkboxes = document
									.querySelectorAll('.itemCheckbox');
							for (var i = 0; i < checkboxes.length; i++) {
								checkboxes[i].checked = this.checked;
							}
						});
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


	<c:if test="${not empty sessionScope.showNotFoundUser}">
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				var modal = new bootstrap.Modal(document
						.getElementById('aunouceUserNotFoundModal'));
				modal.show();
			});
		</script>
	</c:if>
	<c:if test="${not empty showUpdateModal}">
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				var modal = new bootstrap.Modal(document
						.getElementById('detailUserModal'));
				modal.show();
			});
		</script>
	</c:if>


	<script>
		function updateActionButtonVisibility() {
			// Lấy tất cả các checkbox có class "itemCheckbox"
			var checkboxes = document.querySelectorAll('.itemCheckbox');
			// Kiểm tra xem có checkbox nào được chọn không
			var anyChecked = Array.from(checkboxes).some(function(cb) {
				return cb.checked;
			});
			// Lấy tất cả các nút hành động có class "actionButton"
			var actionButtons = document.querySelectorAll('.actionButton');
			// Hiển thị hoặc ẩn các nút dựa trên kết quả kiểm tra
			actionButtons.forEach(function(btn) {
				btn.style.display = anyChecked ? 'inline-block' : 'none';
			});
		}

		// Gắn sự kiện lắng nghe cho tất cả các checkbox khi có thay đổi
		document.querySelectorAll('.itemCheckbox').forEach(function(checkbox) {
			checkbox.addEventListener('change', updateActionButtonVisibility);
		});

		// Cập nhật lại trạng thái nút khi chọn/ bỏ chọn tất cả
		document.getElementById('selectAll').addEventListener(
				'change',
				function() {
					var isChecked = this.checked;
					document.querySelectorAll('.itemCheckbox').forEach(
							function(checkbox) {
								checkbox.checked = isChecked;
							});
					updateActionButtonVisibility();
				});

		// Kiểm tra trạng thái nút khi trang được tải
		document.addEventListener("DOMContentLoaded",
				updateActionButtonVisibility);
		/* // Hàm kiểm tra xem có checkbox nào được chọn không
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
		document.getElementById('selectAll').addEventListener(
				'change',
				function() {
					var isChecked = this.checked;
					document.querySelectorAll('.itemCheckbox').forEach(
							function(checkbox) {
								checkbox.checked = isChecked;
							});
					updateDeleteButtonVisibility();
				});

		// Kiểm tra trạng thái nút khi trang được tải
		document.addEventListener("DOMContentLoaded",
				updateDeleteButtonVisibility); */
	</script>

</body>
</html>
