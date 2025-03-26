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
						<p>/Admin/Quản lý sách</p>
					</div>
				</div>
				<div class="col-md-6 text-end">
					<div class="row">
						<br>
					</div>
					<div class="row d-flex justify-content-end">
						<button type="submit" form="deleteForm"
							class="btn border border-1" style="width: 150px; height: 40px;">
							<i class="fa-solid fa-trash"></i> Xoá sách
						</button>
						<button class="btn border border-1 ms-3"
							style="width: 150px; height: 40px;" data-bs-toggle="modal"
							data-bs-target="#addBookModal">
							<i class="fa-solid fa-plus"></i> Thêm sách
						</button>
					</div>
				</div>
			</div>
			<div class="row px-5">
				<form
					action="${pageContext.request.contextPath}/deleteSelectedBooks"
					method="post" id="deleteForm">
					<table class="table ">
						<thead class="text-center">
							<tr>
								<th><input type="checkbox" id="selectAll"></th>
								<th>Hình ảnh</th>
								<th>Tên sách</th>
								<th>Tác giả</th>
								<th>Thể loại</th>
								<th>Giá</th>
								<th class="text-center">Chỉnh sửa</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${listBook}" var="item">
								<tr class="text-center">
									<td><input type="checkbox" name="selectedBooks"
										value="${item.bookId}" class="itemCheckbox"></td>
									<td style="height: 130px; width: 100px;"><img
										src="${pageContext.request.contextPath}/book/image/${item.bookId}"
										alt="Book Image" class="w-100 h-100"></td>
									<td>${item.bookName}</td>
									<td>${item.author}</td>
									<td>${genreMap[item.genreId]}</td>
									<td>${item.price}</td>
									<td class="text-center"><a class="btn w-auto ms-3"
										href="${pageContext.request.contextPath}/Detail-Book/${item.bookId}"
										style="width: 150px; height: 40px;"><i
											class="fa-solid fa-pen-to-square icon-action"></i></a>
										<button type="button" class="btn w-auto ms-3"
											style="width: 150px; height: 40px;" data-bs-toggle="modal"
											data-bs-target="#detailBookModal1">
											<i class="fa-solid fa-file"></i>
										</button> <a class="btn w-auto ms-3"
										href="${pageContext.request.contextPath}/Delete-Book/${item.bookId}?genre=${genreMap[item.genreId]}"
										style="width: 150px; height: 40px;"> <i
											class="fa-solid fa-trash"></i>
									</a></td>
								</tr>
							</c:forEach>

						</tbody>
					</table>

				</form>

			</div>
		</div>
	</div>
	<div class="modal fade" id="detailBookModal" tabindex="-1"
		aria-labelledby="detailBookModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg " style="margin-top: 15vh;">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title text-center w-100" id="detailBookModalLabel">Cập
						nhật sách</h5>
					<button type="button" class="btn" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-x" style="color: #CC9600;"></i>
					</button>

				</div>

				<div class="modal-body">
					<form:form modelAttribute="bookUpdate" method="POST"
						action="${pageContext.request.contextPath}/Update-Book"
						enctype="multipart/form-data">
						<div class="row g-4">
							<input type="hidden" name="bookId" value="${bookUpdate.bookId}" />
							<div class="col-md-6">
								<form:input path="bookName" class="form-control"
									placeholder="Nhập tên sách" />
							</div>
							<div class="col-md-6">
								<form:input path="author" class="form-control"
									placeholder="Tên tác giả" />
							</div>
							<div class="col-md-6">
								<form:input path="quantity" class="form-control"
									placeholder="Số lượng sách" />
							</div>
							<div class="col-md-6">
								<form:input path="price" class="form-control"
									placeholder="Giá cả" />
							</div>
							<div class="col-md-6">
								<p class="ps-2">Thời gian xuất bản</p>
								<form:input path="publishedDate" type="date"
									class="form-control" placeholder="dd/mm/yyyy" />
								<p class="ps-2 pt-2">Mô tả sách</p>
								<form:textarea path="discription" class="form-control"
									placeholder="Mô tả sách" rows="3" />
							</div>
							<div class="col-md-6">
								<div class="upload-box">
									<p class="ps-2">
										<i class="fa-solid fa-cloud-upload-alt"></i><span>
											Upload ảnh</span>
									</p>
									<img
										src="${pageContext.request.contextPath}/book/image/${bookUpdate.bookId}"
										alt="Book Image" style="height: 130px; width: 100px;"> <input
										type="file" name="image" accept="image/*" class="form-control" />
								</div>

							</div>

							<div class="col-md-6">
								<p class="ps-2">Thể loại</p>
								<form:select path="genreId" class="form-control">
									<form:options items="${genreMap}" />
								</form:select>
							</div>
							<div class="col-md-6">
								<p class="ps-2">Ảnh mô tả</p>

								<a class="btn btn-primary w-auto ms-3 form-control"
									href="${pageContext.request.contextPath}/Book-Image/${bookUpdate.bookId}"
									style="width: 150px; height: 40px;">Xem ảnh</a>
							</div>
							<div class="col-md-12 text-center">
								<div class="image-upload-box">
									<button type="submit" name="action" value="addBook"
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

	<div class="modal fade" id="viewBookImageModal" tabindex="-1"
		aria-labelledby="viewBookImageModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg " style="margin-top: 15vh;">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title text-center w-100"
						id="viewBookImageModalLabel">Hình mô tả</h5>
					<button type="button" class="btn" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-x" style="color: #CC9600;"></i>
					</button>

				</div>

				<div class="modal-body">
					<form:form modelAttribute="bookUpdateImage" method="POST"
						action="${pageContext.request.contextPath}/Update-BookImage"
						enctype="multipart/form-data">
						<div class="row justify-content-center">
							<c:forEach items="${listBookImage}" var="item">
								<img
									src="${pageContext.request.contextPath}/book/imageDetail/${item.bookId}?bookImageId=${item.imageId}"
									alt="Book Image" class="d-block mx-auto"
									style="height: 130px; width: 100px;">
							</c:forEach>
						</div>

					</form:form>
				</div>
			</div>
		</div>

	</div>

	<div class="modal fade" id="addBookModal" tabindex="-1"
		aria-labelledby="addBookModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg " style="margin-top: 15vh;">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title text-center w-100" id="addBookModalLabel">Thêm
						sách mới</h5>
					<button type="button" class="btn" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-x" style="color: #CC9600;"></i>
					</button>

				</div>

				<div class="modal-body">
					<form:form modelAttribute="book" method="POST"
						action="/MockProject/Add-Book" enctype="multipart/form-data">
						<div class="row g-4">
							<div class="col-md-6">
								<form:input path="bookName" class="form-control"
									placeholder="Nhập tên sách" />
							</div>
							<div class="col-md-6">
								<form:input path="author" class="form-control"
									placeholder="Tên tác giả" />
							</div>
							<div class="col-md-6">
								<form:input path="quantity" class="form-control"
									placeholder="Số lượng sách" />
							</div>
							<div class="col-md-6">
								<form:input path="price" class="form-control"
									placeholder="Giá cả" />
							</div>
							<div class="col-md-6">
								<p class="ps-2">Thời gian xuất bản</p>
								<form:input path="publishedDate" type="date"
									class="form-control" placeholder="dd/mm/yyyy" />
							</div>
							<div class="col-md-6">
								<div class="upload-box">
									<p class="ps-2">
										<i class="fa-solid fa-cloud-upload-alt"></i><span>
											Upload ảnh</span>
									</p>
									<input type="file" name="image" accept="image/*"
										class="form-control" />
								</div>
							</div>
							<div class="col-md-6">
								<p class="ps-2">Mô tả sách</p>
								<form:textarea path="discription" class="form-control"
									placeholder="Mô tả sách" rows="5" />
							</div>

							<div class="col-md-6">
								<p class="ps-2">Thể loại</p>
								<form:select path="genreId" class="form-control">
									<form:options items="${genreMap}" />
								</form:select>
								<p class="ps-2  mt-3">Ảnh mô tả</p>
								<input type="file" name="images" accept="image/*"
									class="form-control" multiple />
							</div>
							<div class="col-md-12 text-center">
								<div class="image-upload-box">
									<button type="submit" name="action" value="addBook"
										class="btn w-auto" style="background-color: #CC9600;">Thêm
										sách</button>
								</div>
							</div>
						</div>
					</form:form>
				</div>
			</div>
		</div>

	</div>


	<div class="modal fade" id="detailBookModal1" tabindex="-1"
		aria-labelledby="addUserModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg " style="margin-top: 15vh;">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title text-center w-100" id="addBookModalLabel">Thêm
						sách mới</h5>
					<button type="button" class="btn" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-x" style="color: #CC9600;"></i>
					</button>

				</div>

				<div class="modal-body">
					<div class="book-image">
						<img src="/MockProject/image/imgBook.png" alt="Bìa sách">
					</div>
					<div class="book-info">
						<div class="rating">
							<strong>Đánh giá</strong> <i class="fa-solid fa-star"></i> <i
								class="fa-solid fa-star"></i> <i class="fa-solid fa-star"></i> <i
								class="fa-solid fa-star"></i> <i
								class="fa-solid fa-star-half-alt"></i> <span>3 khách hàng
								| Nhận xét</span>
						</div>
						<p>
							<strong>Tác giả:</strong> Zone Hand
						</p>
						<p>
							<strong>Ngày xuất bản:</strong> 17/02/2025
						</p>
						<p>
							<strong>Số lượng tồn kho:</strong> 150 sách
						</p>
						<p>
							<strong>Số lượng đã bán:</strong> 20
						</p>
						<p>
							<strong>Thể loại:</strong> Giáo dục
						</p>
						<p>
							<strong>Đơn giá:</strong> 45.000đ
						</p>
						<p>
							<strong>Mô tả:</strong> ......
						</p>
					</div>
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
						.getElementById('detailBookModal'));
				modal.show();
			});
		</script>
	</c:if>

	<c:if test="${not empty showViewBookImageModal}">
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				var modal = new bootstrap.Modal(document
						.getElementById('viewBookImageModal'));
				modal.show();
			});
		</script>
	</c:if>
</body>
</html>
