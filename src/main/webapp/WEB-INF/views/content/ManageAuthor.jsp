<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="vi">
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
	href="${pageContext.request.contextPath}/template/etc_item.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/template/AdminLayout.css" />
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
						<h2>Tác giả</h2>
					</div>
					<div class="row">
						<p>/Admin/ Quản lý tác giả</p>
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
							<i class="fa-solid fa-trash"></i> Xoá tác giả
						</button>
						<button
							class="btn border border-1 ms-3 btn-outline-warning text-dark"
							style="width: 150px; height: 40px;" data-bs-toggle="modal"
							data-bs-target="#addAuthorModal">
							<i class="fa-solid fa-plus"></i> Thêm tác giả
						</button>
						<c:if test="${not empty sessionScope.findKey}">
							<a href="${pageContext.request.contextPath}/Manage-Book"
								class="btn border border-1 w-auto ms-2 btn-outline-warning text-dark"
								style="height: 40px;"> <i class="fa-solid fa-times"></i> Bỏ
								lọc
							</a>
						</c:if>
					</div>
				</div>
			</div>
			<div class="row px-5">
				<form
					action="${pageContext.request.contextPath}/deleteSelectedAuthor"
					method="post" id="deleteForm"
					onsubmit="return confirm('Bạn có chắc chắn muốn xoá tác giả đã chọn không?');">
					<div style="height: 500px; overflow-y: croll;">
						<table class="table text-center">
							<thead>
								<tr class="position-sticky top-0 bg-light">
									<th><input type="checkbox" id="selectAll"></th>
									<th>Tác giả</th>
									<th>Số lượng sách</th>
									<th>Chỉnh sửa</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${listAuthor }" var="item">
									<tr>
										<td><input type="checkbox" name="selectedAuthor"
											value="${item.authorId}" class="itemCheckbox"></td>
										<td class="text-truncate"
											style="max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${item.authorName }</td>
										<td>${quantityBookList[item.authorId]}</td>
										<td><a
											class="btn w-auto ms-3 btn-outline-warning text-dark border-0"
											href="${pageContext.request.contextPath}/Detail-Author/${item.authorId}"
											style="width: 150px; height: 40px;"><i
												class="fa-solid fa-pen"></i></a> <a
											class="btn w-auto ms-3 btn-outline-warning text-dark border-0"
											href="${pageContext.request.contextPath}/Delete-Author/${item.authorId}?author=${quantityBookList[item.authorId]}"
											onclick="return confirm('Bạn có chắc chắn muốn xoá tác giả này không?');"
											style="width: 150px; height: 40px;"> <i
												class="fa-solid fa-trash"></i></a></td>
									</tr>
								</c:forEach>

							</tbody>
						</table>
					</div>
				</form>

			</div>
		</div>
	</div>


	<div class="modal fade" id="addAuthorModal" tabindex="-1"
		aria-labelledby="addUserModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg"
			style="margin-top: 15vh; max-width: 500px;">
			<div class="modal-content">
				<div class="modal-header ms-auto">
					<a href="${pageContext.request.contextPath}/Manage-FindAuthor">
						<button type="button" class="btn" data-bs-dismiss="modal"
							aria-label="Close">
							<i class="fa-solid fa-x" style="color: #cc9600"></i>
						</button>
					</a>
				</div>
				<h3 class="modal-title text-center w-100" id="addBookModalLabel">
					Thêm tác giả</h3>

				<div class="modal-body">
					<form:form class="w-100"
						action="${pageContext.request.contextPath}/Add-Author"
						modelAttribute="author">
						<div>
							<div class="d-flex justify-content-center">
								<form:input path="authorName" id="authorName"
									class="form-control w-75" placeholder="Tên tác giả" />
							</div>
							<p class="text-danger ps-5 ms-2">
								<form:errors path="authorName"></form:errors>
							</p>
							<div class="d-flex justify-content-center pt-2">
								<form:textarea path="introduction" class="form-control w-75"
									placeholder="Sơ lược về tác giả" rows="3" />
							</div>
							<div class="pt-5 text-center">
								<div class="image-upload-box">
									<button type="submit" class="btn w-auto"
										style="background-color: #CC9600;">Thêm</button>
								</div>
							</div>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="detailAuthorModal" tabindex="-1"
		aria-labelledby="detailAuthorModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg"
			style="margin-top: 15vh; max-width: 500px;">
			<div class="modal-content">
				<div class="modal-header ms-auto">
					<a href="${pageContext.request.contextPath}/Manage-Author">
						<button type="button" class="btn" data-bs-dismiss="modal"
							aria-label="Close">
							<i class="fa-solid fa-x" style="color: #cc9600"></i>
						</button>
					</a>
				</div>
				<h3 class="modal-title text-center w-100" id="addBookModalLabel">
					Cập nhật tác giả</h3>

				<div class="modal-body">
					<form:form class="w-100"
						action="${pageContext.request.contextPath}/Update-Author"
						onsubmit="return confirm('Bạn có chắc chắn muốn cập nhật tác giả này không?');"
						modelAttribute="authorUpdate">
						<form:hidden path="authorId" />
						<div>
							<div class="d-flex justify-content-center">
								<form:input path="authorName" id="authorName"
									class="form-control w-75" placeholder="Tên tác giả" />
							</div>
							<p class="text-danger ps-5 ms-2">
								<form:errors path="authorName"></form:errors>
							</p>
							<div class="d-flex justify-content-center pt-2">
								<form:textarea path="introduction" class="form-control w-75"
									placeholder="Sơ lược về tác giả" rows="3" />
							</div>
							<div class="pt-5 text-center">
								<div class="image-upload-box">
									<button type="submit" class="btn w-auto"
										style="background-color: #CC9600;">Cập nhật</button>
								</div>
							</div>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="deleteAuthorModal" tabindex="-1"
		aria-labelledby="addUserModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg"
			style="margin-top: 15vh; max-width: 450px;">
			<div class="modal-content">
				<div class="modal-header ms-auto">

					<button type="button" class="btn" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-x" style="color: #cc9600"></i>
					</button>

				</div>
				<h3 class="modal-title text-center w-100" id="addBookModalLabel">
					Xoá thất bại</h3>

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
						<p class="text-center text-muted">Tác giả còn sách trong hệ
							thống</p>

					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="aunouceAuthorNotFoundModal" tabindex="-1"
		aria-labelledby="aunouceAuthorNotFoundModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg"
			style="margin-top: 15vh; max-width: 450px;">
			<div class="modal-content">
				<div class="modal-header ms-auto">
					<a href="${pageContext.request.contextPath}/Manage-Author">
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
						<p class="text-center text-muted">Không có tác giả cần tìm</p>
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
	<c:if test="${not empty sessionScope.showNotFoundAuthor}">
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				var modal = new bootstrap.Modal(document
						.getElementById('aunouceAuthorNotFoundModal'));
				modal.show();
			});
		</script>
	</c:if>

	<c:if test="${not empty deleteAuthorError}">
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				var deleteModal = new bootstrap.Modal(document
						.getElementById('deleteAuthorModal'));
				deleteModal.show();
			});
		</script>
	</c:if>

	<c:if test="${not empty showAddAuthorModal}">
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				var deleteModal = new bootstrap.Modal(document
						.getElementById('addAuthorModal'));
				deleteModal.show();
			});
		</script>
	</c:if>

	<c:if test="${not empty showUpdateModal}">
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				var modal = new bootstrap.Modal(document
						.getElementById('detailAuthorModal'));
				modal.show();
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
				updateDeleteButtonVisibility);
	</script>

</body>
</html>
