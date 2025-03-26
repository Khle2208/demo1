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
<link rel="stylesheet" href="/MockProject/style/LayoutAdmin.css" />
</head>
<body>
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
						<p>/Admin/Quản lý thể loại</p>
					</div>
				</div>
				<div class="col-md-6 text-end">
					<div class="row">
						<br />
					</div>
					<div class="row d-flex justify-content-end">
						<button type="submit" form="deleteForm"
							class="btn border border-1" style="width: 150px; height: 40px"
							data-bs-toggle="modal" data-bs-target="#deleteGenreModal">
							<i class="fa-solid fa-trash"></i> Xoá thể loại
						</button>
						<button class="btn border border-1 ms-3"
							style="width: 150px; height: 40px" data-bs-toggle="modal"
							data-bs-target="#addGenreModal">
							<i class="fa-solid fa-plus"></i> Thêm thể loại
						</button>
					</div>
				</div>
			</div>
			<div class="row px-5">
				<form
					action="${pageContext.request.contextPath}/deleteSelectedGenre"
					method="post" id="deleteForm">
					<table class="table ">
						<thead class="text-center">
							<tr>
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
										data-quantity="${quantityBookList[item.genreId]}"
										value="${item.genreId}" class="itemCheckbox"></td>
									<td>${item.genreName}</td>
									<td>${quantityBookList[item.genreId]}</td>
									<td class="text-center">
										<a class="btn w-auto ms-3"
										href="${pageContext.request.contextPath}/Detail-Genre/${item.genreId}"
										style="width: 150px; height: 40px;"><i
											class="fa-solid fa-pen-to-square icon-action"></i></a> <a
										class="btn w-auto ms-3"
										href="${pageContext.request.contextPath}/Delete-Genre/${item.genreId}?genre=${quantityBookList[item.genreId]}"
										style="width: 150px; height: 40px;"> <i
											class="fa-solid fa-trash"></i></a>
									</td>
								</tr>
							</c:forEach>

						</tbody>
					</table>

				</form>
			</div>
		</div>


	</div>




	<div class="modal fade" id="addGenreModal" tabindex="-1"
		aria-labelledby="addGenreModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" style="margin-top: 15vh">
			<div class="modal-content">
				<div class="modal-header ms-auto">
					<button type="button" class="btn" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-x" style="color: #cc9600"></i>
					</button>
				</div>
				<h3 class="modal-title text-center w-100" id="addBookModalLabel">
					Thêm thể loại mới</h3>

				<div class="modal-body">

					<form:form modelAttribute="genre" method="POST"
						action="/MockProject/Add-Genre" class="w-100">
						<div class="text-center">
							<div class="d-flex justify-content-center">
								<form:input path="genreName" id="genreName"
									class="form-control w-50" placeholder="Tên thể loại" />
							</div>
							<div class="pt-5 text-center">
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
		<div class="modal-dialog modal-lg" style="margin-top: 15vh">
			<div class="modal-content">
				<div class="modal-header ms-auto">
					<button type="button" class="btn" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-x" style="color: #cc9600;"></i>
					</button>
				</div>
				<h3 class="modal-title text-center w-100" id="detailGenreModalLabel">
					Cập nhật thể loại</h3>
				<div class="modal-body">
					<form:form modelAttribute="genreUpdate" method="POST"
						action="${pageContext.request.contextPath}/Update-Genre"
						class="w-100">
						<input type="hidden" name="genreId" value="${genreUpdate.genreId}" />
						<div class="text-center">
							<div class="d-flex justify-content-center">
								<form:input path="genreName" id="genreName"
									class="form-control w-50" placeholder="Tên thể loại" />
							</div>
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

	<c:if test="${not empty showUpdateModal}">
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				var modal = new bootstrap.Modal(document
						.getElementById('detailGenreModal'));
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

</body>
</html>
