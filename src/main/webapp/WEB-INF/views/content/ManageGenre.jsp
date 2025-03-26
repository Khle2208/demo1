<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="vi">
<head>
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
	<!-- Sidebar -->

	<jsp:include page="../layout/navbar.jsp"></jsp:include>

	<!-- Nội dung chính -->
	<div class="content">
		<jsp:include page="../layout/header_admin.jsp"></jsp:include>

		<div class="mt-4">
			<div class="row px-5">
				<div class="col-md-6">
					<div class="row">
						<h2>Sách</h2>
					</div>
					<div class="row">
						<p>/Admin/ Quản lý thể loại</p>
					</div>
				</div>
				<div class="col-md-6 text-end">
					<div class="row">
						<br />
					</div>
					<div class="row d-flex justify-content-end flex-nowrap">
						<button type="submit" id="deleteButton" form="deleteForm"
							class="btn border border-1 btn-outline-warning text-dark"
							style="width: 150px; height: 40px"
							onclick="return confirm('Bạn có chắc chắn muốn xoá thể loại đã chọn không?');">
							<i class="fa-solid fa-trash"></i> Xoá thể loại
						</button>

						<button
							class="btn border border-1 ms-3 btn-outline-warning text-dark"
							style="width: 150px; height: 40px" data-bs-toggle="modal"
							data-bs-target="#addGenreModal">
							<i class="fa-solid fa-plus"></i> Thêm thể loại
						</button>
						<c:if test="${not empty sessionScope.findKey}">
							<a href="${pageContext.request.contextPath}/Manage-Genre"
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
					action="${pageContext.request.contextPath}/deleteSelectedGenre"
					method="post" id="deleteForm"
					onsubmit="return confirm('Bạn có chắc chắn muốn xoá thể loại đã chọn không?');">
					<div style="height: 40%; overflow-y: croll;">
						<table class="table ">
							<thead class="text-center">
								<tr class="position-sticky top-0">
									<th><input type="checkbox" id="selectAll"></th>
									<th>Thể loại</th>
									<th>Số lượng sách</th>
									<th class="text-center">Chỉnh sửa</th>
								</tr>
							</thead>
							<tbody>

								<c:forEach items="${listGenre}" var="item">
									<tr class="text-center">
										<td><input type="checkbox" name="selectedGenre"
											value="${item.genreId}" class="itemCheckbox"></td>
										<td class="text-truncate"
											style="max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${item.genreName}</td>
										<td>${quantityBookList[item.genreId]}</td>
										<td class="text-center"><a
											class="btn w-auto ms-3 btn-outline-warning text-dark border-0"
											href="${pageContext.request.contextPath}/Detail-Genre/${item.genreId}"
											style="width: 150px; height: 40px;"><i
												class="fa-solid fa-pen"></i> </a> <a
											class="btn w-auto ms-3 btn-outline-warning text-dark border-0"
											href="${pageContext.request.contextPath}/Delete-Genre/${item.genreId}?genre=${quantityBookList[item.genreId]}"
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




	<div class="modal fade" id="addGenreModal" tabindex="-1"
		aria-labelledby="addGenreModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg"
			style="margin-top: 15vh; max-width: 500px;">
			<div class="modal-content">
				<div class="modal-header ms-auto">
					<a href="${pageContext.request.contextPath}/Manage-Genre">
						<button type="button" class="btn" data-bs-dismiss="modal"
							aria-label="Close">
							<i class="fa-solid fa-x" style="color: #cc9600"></i>
						</button>
					</a>
				</div>
				<h3 class="modal-title text-center w-100" id="addBookModalLabel">
					Thêm thể loại mới</h3>

				<div class="modal-body">

					<form:form modelAttribute="genre" method="POST"
						action="${pageContext.request.contextPath}/Add-Genre"
						class="w-100">
						<div class="text-center">
							<div class="d-flex justify-content-center">
								<form:input path="genreName" id="genreName"
									class="form-control w-50" placeholder="Tên thể loại" />
							</div>
							<p class="text-danger">
								<form:errors path="genreName"></form:errors>
							</p>
							<div class="pt-2 text-center">
								<div class="image-upload-box">
									<button type="submit" name="action" value="addGenre"
										class="btn w-auto" style="background-color: #CC9600;">Thêm
										thể loại</button>
								</div>
							</div>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="detailGenreModal" tabindex="-1"
		aria-labelledby="detailGenreModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg"
			style="margin-top: 15vh; max-width: 450px;">
			<div class="modal-content">
				<div class="modal-header ms-auto">
					<a href="${pageContext.request.contextPath}/Manage-FindGenre">
						<button type="button" class="btn" data-bs-dismiss="modal"
							aria-label="Close">
							<i class="fa-solid fa-x" style="color: #cc9600;"></i>
						</button>
					</a>
				</div>
				<h3 class="modal-title text-center w-100" id="detailGenreModalLabel">
					Cập nhật thể loại</h3>
				<div class="modal-body">
					<form:form modelAttribute="genreUpdate" method="POST"
						action="${pageContext.request.contextPath}/Update-Genre"
						onsubmit="return confirm('Bạn có chắc chắn muốn cập nhật thể loại này không?');"
						class="w-100">
						<input type="hidden" name="genreId" value="${genreUpdate.genreId}" />
						<div class="text-center">
							<div class="d-flex justify-content-center">
								<form:input path="genreName" id="genreName"
									class="form-control w-50" placeholder="Tên thể loại" />
							</div>
							<p class="text-danger">
								<form:errors path="genreName"></form:errors>
							</p>
							<div class="pt-5 text-center">
								<div class="image-upload-box">
									<button type="submit" name="action" value="updateGenre"
										class="btn w-auto" style="background-color: #CC9600;">
										Cập nhật</button>
								</div>
							</div>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>



	<div class="modal fade" id="deleteGenreModal" tabindex="-1"
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
						<p class="text-center text-muted">Tồn tại sách trong danh mục
							đã chọn</p>


					</form>
				</div>
			</div>
		</div>
	</div>


	<div class="modal fade" id="addFailGenreModal" tabindex="-1"
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
					Thêm thất bại</h3>

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
						<p class="text-center text-muted">Danh mục tồn tại</p>


					</form>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="aunouceGenreNotFoundModal" tabindex="-1"
		aria-labelledby="aunouceGenreNotFoundModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg"
			style="margin-top: 15vh; max-width: 450px;">
			<div class="modal-content">
				<div class="modal-header ms-auto">
					<a href="${pageContext.request.contextPath}/Manage-Genre">
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
						<p class="text-center text-muted">Không có thể loại cần tìm</p>
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

	<c:if test="${not empty sessionScope.showNotFoundGenre}">
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				var modal = new bootstrap.Modal(document
						.getElementById('aunouceGenreNotFoundModal'));
				modal.show();
			});
		</script>
	</c:if>
	<c:if test="${not empty showUpdateModal}">
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				var modal = new bootstrap.Modal(document
						.getElementById('detailGenreModal'));
				modal.show();
			});
		</script>
	</c:if>
	<c:if test="${not empty addFailGenreModal}">
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				var modal = new bootstrap.Modal(document
						.getElementById('addFailGenreModal'));
				modal.show();
			});
		</script>
	</c:if>
	<c:if test="${not empty showAddGenreModal}">
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				var modal = new bootstrap.Modal(document
						.getElementById('addGenreModal'));
				modal.show();
			});
		</script>
	</c:if>
	<c:if test="${not empty deleteGenreError}">
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				var deleteModal = new bootstrap.Modal(document
						.getElementById('deleteGenreModal'));
				deleteModal.show();
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
