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
	href="${pageContext.request.contextPath}/template/AdminLayout.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/template/etc_item.css" />
<style>
body {
	font-family: 'Roboto', sans-serif;
	background-color: #f8f9fa;
}

.remove-author {
	border: none;
	background: transparent;
}
</style>
</head>
<body class="overflow-y-hidden position-fixed w-100">
	<!-- Sidebar -->

	<jsp:include page="../layout/navbar.jsp"></jsp:include>

	<!-- Nội dung chính -->
	<div class="content">
		<jsp:include page="../layout/header_admin.jsp"></jsp:include>

		<div class="mt-4">
			<div class="row px-3 px-md-5">
				<div class="col-md-6">
					<div class="row">
						<h2>Sách</h2>
					</div>
					<div class="row">
						<p>Admin / Quản lý sách</p>
					</div>
				</div>
				<div class="col-md-6 text-end">
					<div class="row">
						<br>
					</div>
					<div class="row d-flex justify-content-end flex-nowrap">
						<button type="submit" form="deleteForm" id="deleteButton"
							class="btn btn-outline-warning border border-1 mb-2 mb-md-0"
							style="width: 150px; height: 40px; color: black;">
							<i class="fa-solid fa-trash"></i> Xoá sách
						</button>
						<button
							class="btn btn-outline-warning text-dark border border-1 ms-3 mb-2 mb-md-0"
							style="width: 150px; height: 40px;" data-bs-toggle="modal"
							data-bs-target="#addBookModal">
							<i class="fa-solid fa-plus"></i> Thêm sách
						</button>

						<c:choose>
							<c:when test="${showlistBookStatus == true}">
								<a class="w-auto"
									href="${pageContext.request.contextPath}/Available-Book">
									<button
										class="btn btn-outline-warning text-dark border border-1 mb-2 mb-md-0"
										style="height: 40px;">
										<i class="fa-solid fa-arrow-right-arrow-left"></i> Sách khả
										dụng
									</button>
								</a>
							</c:when>
							<c:otherwise>
								<a class="w-auto"
									href="${pageContext.request.contextPath}/Unavailable-Book">
									<button
										class="btn btn-outline-warning text-dark border border-1 mb-2 mb-md-0"
										style="height: 40px;">
										<i class="fa-solid fa-arrow-right-arrow-left"></i> Sách không
										khả dụng
									</button>
								</a>
							</c:otherwise>
						</c:choose>

						<c:if
							test="${not empty sessionScope.findKey || not empty sessionScope.filterBook }">
							<a href="${pageContext.request.contextPath}/Manage-Book"
								class="btn btn-outline-warning text-dark border border-1 w-auto mb-2 mb-md-0"
								style="height: 40px;"> <i class="fa-solid fa-times"></i> Bỏ
								lọc
							</a>
						</c:if>
					</div>
				</div>
			</div>
			<div class="row px-3 px-md-5" style="height: 50%">
				<form
					action="${pageContext.request.contextPath}/deleteSelectedBooks"
					method="post" id="deleteForm"
					onsubmit="return confirm('Bạn có chắc chắn muốn xoá sách đã chọn không?');">

					<div style="height: 500px; overflow-y: auto;">
						<div class="table-responsive">
							<table class="table w-100">
								<thead class="text-center">
									<tr class="position-sticky top-0">
										<th><input type="checkbox" id="selectAll"></th>
										<th>Hình ảnh</th>
										<th>Tên sách</th>
										<!-- <th>Tác giả</th> -->
										<th>Thể loại</th>
										<th>Giá</th>
										<th>Chỉnh sửa</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach
										items="${showlistBookStatus == true ? listBookUnavailable : (showlistBookStatus == false ? listBookAvailable : listBook)}"
										var="item">
										<tr class="text-center" style="overflow-y: auto;">
											<td><input type="checkbox" name="selectedBooks"
												value="${item.bookId}" class="itemCheckbox"></td>
											<td style="height: 130px; width: 100px;"><img
												src="${pageContext.request.contextPath}/book/image/${item.bookId}"
												alt="Book Image" class="w-100 h-100"></td>
											<td class="text-truncate"
												style="max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
												${item.bookName}</td>

											<%-- <td>${item.author}</td> --%>
											<td>${genreMap[item.genreId]}</td>
											<td>${item.price}</td>
											<td>
												<div class="d-flex justify-content-center">
													<a
														class="btn w-auto ms-3 btn-outline-warning text-dark border-0"
														href="${pageContext.request.contextPath}/Detail-Book/${item.bookId}"
														style="max-width: 150px; max-height: 40px;"><i
														class="fa-solid fa-pen"></i></a> <a
														class="btn w-auto ms-3 btn-outline-warning text-dark border-0"
														href="${pageContext.request.contextPath}/View-Book/${item.bookId}"
														style="max-width: 150px; max-height: 40px;"> <i
														class="fa-solid fa-file"></i></a> <a
														class="btn w-auto ms-3 btn-outline-warning text-dark border-0"
														href="${pageContext.request.contextPath}/Delete-Book/${item.bookId}?genre=${genreMap[item.genreId]}"
														style="max-width: 150px; max-height: 40px;"
														onclick="return confirm('Bạn có chắc chắn muốn xóa sách này?');">
														<i class="fa-solid fa-trash"></i>
													</a>

												</div>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
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
					<a href="${pageContext.request.contextPath}/Manage-FindBook">
						<button type="button" class="btn" data-bs-dismiss="modal"
							aria-label="Close">
							<i class="fa-solid fa-x" style="color: #CC9600;"></i>
						</button>
					</a>

				</div>

				<div class="modal-body">
					<form:form modelAttribute="bookUpdate" method="POST"
						action="${pageContext.request.contextPath}/Update-Book"
						enctype="multipart/form-data"
						onsubmit="return confirm('Bạn có chắc chắn muốn cập nhật thông tin sách này không?');">
						<div class="row g-4">
							<input type="hidden" name="bookId" value="${bookUpdate.bookId}" />
							<div class="col-md-12">
								<p class="ps-2">Tên sách</p>
								<form:input path="bookName" class="form-control"
									placeholder="Nhập tên sách" />
								<p class="text-danger ps-2">
									<form:errors path="bookName"></form:errors>
								</p>
							</div>
							<div class="col-md-6">
								<p class="ps-2">Số lượng ${bookUpdate.quantity}</p>
								<form:input path="quantity" type="hidden" />
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
							<div class="col-md-6">
								<p class="ps-2">Giá sách</p>
								<form:input path="price" class="form-control"
									placeholder="Giá sách" />
								<p class="text-danger ps-2">
									<form:errors path="price"></form:errors>
								</p>
							</div>
							<div class="col-md-12">
								<p class="ps-2">Tác giả</p>
								<div id="authorsDetail">
									<c:forEach items="${listAuthorDetails}" var="item">
										<div class="input-group mb-2" >
											<input type="text" name="listAuthorDetail[]"
												value="${item.authorName}" class="form-control"
												placeholder="Enter author name" required>
											<button type="button"
												class="btn btn-outline-danger remove-authorDetail">
												<i class="fas fa-minus-circle"></i>
											</button>
										</div>
									</c:forEach>
								</div>
								<button type="button" id="add-authorDetail"
									class="btn btn-link text-decoration-none">
									<i class="fas fa-plus-circle"></i> Add Author
								</button>

							</div>
							<div class="col-md-6">
								<p class="ps-2">Thời gian xuất bản</p>
								<form:input path="publishedDate" type="date"
									class="form-control" />

								<p class="text-danger ps-2">
									<form:errors path="publishedDate"></form:errors>
								</p>
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
										alt="Book Image" style="height: 140px; width: 110px;"> <input
										type="file" name="image" accept="image/*"
										class="form-control mt-2" />
								</div>

							</div>

							<div class="col-md-6">
								<p class="ps-2">Thể loại</p>
								<form:select path="genreId" class="form-control">
									<form:options items="${genreMap}" />
								</form:select>
								<p class="text-danger ps-2">
									<form:errors path="genreId"></form:errors>
								</p>
							</div>
							<div class="col-md-6">
								<p class="ps-2">Ảnh mô tả</p>

								<a
									class="btn text-white ps-2 w-auto form-control btn-outline-warning text-dark btn-primary border-0"
									href="${pageContext.request.contextPath}/Book-Image/${bookUpdate.bookId}"
									style="width: 150px; height: 40px;">Xem ảnh</a>
							</div>
							<div class="col-md-12 text-center">
								<div class="image-upload-box">
									<button type="submit" name="action" value="addBook"
										class="btn text-white w-auto btn-outline-warning text-dark btn-primary border-0">Cập
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
					<a
						href="${pageContext.request.contextPath}/Detail-Book/${bookUpdateImage.bookId}">
						<button type="button" class="btn" data-bs-dismiss="modal"
							aria-label="Close">
							<i class="fa-solid fa-x" style="color: #CC9600;"></i>
						</button>
					</a>

				</div>

				<div class="modal-body d-flex justify-content-center">
					<form:form modelAttribute="bookUpdateImage" method="POST"
						action="${pageContext.request.contextPath}/Update-BookImage"
						enctype="multipart/form-data">
						<input type="hidden" name="bookId"
							value="${bookUpdateImage.bookId}" />
						<div class="d-flex justify-content-center">
							<c:forEach items="${listBookImage}" var="item">
								<div class="position-relative rounded m-2"
									style="width: 100px; height: 130px;">
									<img class="img-fluid h-100 b-0" style="object-fit: cover;"
										src="${pageContext.request.contextPath}/book/imageDetail/${item.bookId}?bookImageId=${item.imageId}"
										alt="Book Image">
									<div
										class="position-absolute top-0 end-0 translate-middle z-2 p-1 rounded-circle"
										style="cursor: pointer;">
										<a
											href="${pageContext.request.contextPath}/Delete-BookImage/${item.bookId}?bookImageId=${item.imageId}">
											<i class="fa-solid fa-circle-xmark bg-white "
											style="border-radius: 8px; color: red;"></i>
										</a>
									</div>
								</div>
							</c:forEach>
						</div>
						<div class="d-flex justify-content-center pt-3">
							<input type="file" name="imagesUpdate" accept="image/*"
								class="form-control me-2" multiple />
							<button type="submit" name="action" value="addBook"
								class="btn w-auto h-auto text-nowrap"
								style="background-color: #CC9600;">Cập nhật</button>
						</div>
					</form:form>
				</div>
			</div>
		</div>

	</div>

	<div class="modal fade" id="addBookModal" tabindex="-1"
		aria-labelledby="addBookModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg " style="margin-top: 5vh;">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title text-center w-100" id="addBookModalLabel">Thêm
						sách mới</h5>
					<a href="${pageContext.request.contextPath}/Manage-Book">
						<button type="button" class="btn" data-bs-dismiss="modal"
							aria-label="Close">
							<i class="fa-solid fa-x" style="color: #CC9600;"></i>
						</button>
					</a>

				</div>

				<div class="modal-body">
					<form:form modelAttribute="book" method="POST"
						action="${pageContext.request.contextPath}/Add-Book"
						enctype="multipart/form-data">
						<div class="row g-4">
							<div class="col-md-12">
								<p class="ps-2">Tên sách</p>
								<form:input path="bookName" class="form-control"
									placeholder="Nhập tên sách" />
								<p class="text-danger ps-2">
									<form:errors path="bookName"></form:errors>
								</p>
							</div>
							<div class="col-md-6">
								<p class="ps-2">Số lượng</p>
								<form:input path="quantity" type="number" min="1" max="1000"
									class="form-control" placeholder="Số lượng sách"
									oninput="this.value = this.value.replace(/[^0-9]/g, '');" />
								<p class="text-danger ps-2">
									<form:errors path="quantity"></form:errors>
								</p>
							</div>
							<div class="col-md-6">
								<p class="ps-2">Giá sách</p>
								<form:input path="price" class="form-control"
									placeholder="Giá cả"
									oninput="this.value = this.value.replace(/[^0-9]/g, '');" />
								<p class="text-danger ps-2">
									<form:errors path="price"></form:errors>
								</p>
							</div>
							<div class="col-md-6">
								<p class="ps-2">Thời gian xuất bản</p>
								<form:input path="publishedDate" type="date"
									class="form-control" placeholder="dd/mm/yyyy" />
								<p class="text-danger ps-2">
									<form:errors path="publishedDate"></form:errors>
								</p>
							</div>
							<div class="col-md-6">
								<div class="upload-box">
									<p class="ps-2">
										<i class="fa-solid fa-cloud-upload-alt"></i><span>
											Upload ảnh</span>
									</p>
									<input type="file" name="image" accept="image/*"
										class="form-control" />
									<p class="text-danger">
										<form:errors path="avatar"></form:errors>
									</p>



								</div>
							</div>


							<div class="col-md-6">
								<p class="ps-2">Thể loại</p>
								<form:select path="genreId" class="form-control">
									<form:options items="${genreMap}" />
								</form:select>
								<p class="text-danger">
									<form:errors path="genreId"></form:errors>
								</p>
							</div>
							<div class="col-md-6">
								<p class="ps-2">Ảnh mô tả</p>
								<input type="file" name="images" accept="image/*"
									class="form-control" multiple />
							</div>
							<div class="col-md-12">
								<p class="ps-2">Tác giả</p>
								<div id="authors">
									<div class="input-group mb-2">
										<input type="text" name="listAuthor[]" class="form-control"
											placeholder="Enter author name" required>
										<button type="button"
											class="btn btn-outline-danger remove-author">
											<i class="fas fa-minus-circle"></i>
										</button>
									</div>
								</div>
								<button type="button" id="add-author"
									class="btn btn-link text-decoration-none">
									<i class="fas fa-plus-circle"></i> Add Author
								</button>
							</div>
							<div class="col-md-12">
								<p class="ps-2">Mô tả sách</p>
								<form:textarea path="discription" class="form-control"
									placeholder="Mô tả sách" rows="5" />
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


	<div class="modal fade" id="viewBookModal" tabindex="-1"
		aria-labelledby="viewBookModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg " style="margin-top: 15vh;">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title text-center w-100" id="viewBookModalLabel">Thông
						tin sách</h5>
					<a href="${pageContext.request.contextPath}/Manage-FindBook">
						<button type="button" class="btn" data-bs-dismiss="modal"
							aria-label="Close">
							<i class="fa-solid fa-x" style="color: #CC9600;"></i>
						</button>
					</a>

				</div>

				<div class="modal-body">
					<div class="d-flex align-items-start">
						<div>
							<div class="book-image me-3">
								<img
									src="${pageContext.request.contextPath}/book/image/${bookView.bookId}"
									alt="Bìa sách" style="height: 280px; width: 200px;">

							</div>

							<div class="d-flex">
								<c:forEach items="${listBookImageView}" var="item" begin="0"
									end="2">
									<div class="position-relative rounded m-2"
										style="width: 90px; height: 120px;">
										<img class="img-fluid h-100 b-0" style="object-fit: cover;"
											src="${pageContext.request.contextPath}/book/imageDetail/${item.bookId}?bookImageId=${item.imageId}"
											alt="Book Image">
									</div>
								</c:forEach>
							</div>
						</div>
						<div class="book-info">
							<div class="rating">
								<strong>Đánh giá</strong> <i class="fa-solid fa-star"></i> <i
									class="fa-solid fa-star"></i> <i class="fa-solid fa-star"></i>
								<i class="fa-solid fa-star"></i> <i
									class="fa-solid fa-star-half-alt"></i> <span>3 khách
									hàng | Nhận xét</span>
							</div>
							<p class="text-wrap pt-3"
								style="max-width: 350px; word-break: break-all;">
								<strong>Tên sách:</strong> ${bookView.bookName}
							</p>

							<p>
								<strong>Tác giả:</strong>
								<c:forEach items="${listAuthorView}" var="item" varStatus="status">${item.authorName}${status.last ? '.' : ', '}</c:forEach>
							</p>
							<p>
								<strong>Ngày xuất bản:</strong> ${bookView.publishedDate }
							</p>
							<p>
								<strong>Số lượng tồn kho:</strong> ${bookView.quantity}
							</p>
							<p>
								<strong>Số lượng đã bán:</strong> 20
							</p>
							<p>
								<strong>Thể loại:</strong> ${genreMap[bookView.genreId]}
							</p>
							<p>
								<strong>Đơn giá:</strong> ${bookView.price}
							</p>
							<p>
								<strong>Mô tả:</strong>
								<textarea rows="5" class="form-control mt-2" readonly> ${bookView.discription}</textarea>
							</p>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<div class="modal fade" id="aunouceBookModal" tabindex="-1"
		aria-labelledby="aunouceBookModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg"
			style="margin-top: 15vh; max-width: 450px;">
			<div class="modal-content">
				<div class="modal-header ms-auto">

					<button type="button" class="btn" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-x" style="color: #cc9600"></i>
					</button>

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
						<p class="text-center text-muted">Có sách hết số lượng tồn kho</p>
						<div class="d-flex justify-content-center">
							<a class="btn text-light w-auto"
								href="${pageContext.request.contextPath}/Unavailable-Book"
								style="background-color: #CC9600;">Đến Xem</a>
						</div>

					</form>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="aunouceBookNotFoundModal" tabindex="-1"
		aria-labelledby="aunouceBookNotFoundModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg"
			style="margin-top: 15vh; max-width: 450px;">
			<div class="modal-content">
				<div class="modal-header ms-auto">
					<a href="${pageContext.request.contextPath}/Manage-Book">
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
						<p class="text-center text-muted">Không có sách cần tìm</p>
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
						.getElementById('detailBookModal'));
				modal.show();
			});
		</script>
	</c:if>

	<c:if test="${not empty sessionScope.showNotFoundBook}">
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				var modal = new bootstrap.Modal(document
						.getElementById('aunouceBookNotFoundModal'));
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

	<c:if test="${not empty showViewBookModal}">
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				var modal = new bootstrap.Modal(document
						.getElementById('viewBookModal'));
				modal.show();
			});
		</script>
	</c:if>
	<c:if
		test="${not empty listBookUnavailable && empty showlistBookUnavailable}">
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				if (!sessionStorage.getItem('unavailablePopupShown')) {
					var modal = new bootstrap.Modal(document
							.getElementById('aunouceBookModal'));
					modal.show();
					sessionStorage.setItem('unavailablePopupShown', 'true');
				}

			});
		</script>
	</c:if>
	<c:if test="${not empty showAddBookModal}">
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				var modal = new bootstrap.Modal(document
						.getElementById('addBookModal'));
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

	<script>
    document.getElementById('add-author').addEventListener('click', function() {
      const authorsDiv = document.getElementById('authors');
      const newAuthorDiv = document.createElement('div');
      newAuthorDiv.classList.add('input-group', 'mb-2');
      newAuthorDiv.innerHTML = `
        <input type="text" name="listAuthor[]" class="form-control" placeholder="Enter author name" required>
        <button type="button" class="btn btn-outline-danger remove-author">
          <i class="fas fa-minus-circle"></i>
        </button>
      `;
      authorsDiv.appendChild(newAuthorDiv);
    });
    
    document.getElementById('add-authorDetail').addEventListener('click', function() {
        const authorsDiv = document.getElementById('authorsDetail');
        const newAuthorDiv = document.createElement('div');
        newAuthorDiv.classList.add('input-group', 'mb-2');
        newAuthorDiv.innerHTML = `
          <input type="text" name="listAuthorDetail[]" class="form-control" placeholder="Enter author name" required>
          <button type="button" class="btn btn-outline-danger remove-authorDetail">
            <i class="fas fa-minus-circle"></i>
          </button>
        `;
        authorsDiv.appendChild(newAuthorDiv);
      });

    // Sử dụng event delegation để xử lý sự kiện xóa trên các nút "remove-author"
    document.addEventListener('click', function(e) {
  if (e.target.closest('.remove-author')) {
    const authors = document.querySelectorAll('#authors .input-group');
    // Nếu có nhiều hơn 1 ô, cho phép xóa
    if (authors.length > 1) {
      e.target.closest('.input-group').remove();
    } else {
      // Hoặc hiển thị thông báo, hoặc chỉ đơn giản là không làm gì
      alert('Phải có ít nhất một tác giả!');
    }
  }
});
    
    document.addEventListener('click', function(e) {
    	  if (e.target.closest('.remove-authorDetail')) {
    	    const authorsDetail = document.querySelectorAll('#authorsDetail .input-group');
    	    // Nếu có nhiều hơn 1 ô, cho phép xóa
    	    if (authorsDetail.length > 1) {
    	      e.target.closest('.input-group').remove();
    	    } else {
    	      // Hoặc hiển thị thông báo, hoặc chỉ đơn giản là không làm gì
    	      alert('Phải có ít nhất một tác giả!');
    	    }
    	  }
    	});
    
    function validateAuthors() {
        const authorInputs = document.querySelectorAll('input[name="listAuthor[]"]');
        let valid = true;
        authorInputs.forEach(function(input) {
            // Nếu ô nhập bị trống, thêm class để hiển thị lỗi và đặt thông báo
            if (input.value.trim() === "") {
                valid = false;
                input.classList.add('is-invalid');
                // Tạo hoặc hiển thị phần thông báo lỗi bên dưới input
                let errorDiv = input.parentElement.querySelector('.invalid-feedback');
                if (!errorDiv) {
                    errorDiv = document.createElement('div');
                    errorDiv.classList.add('invalid-feedback');
                    errorDiv.innerText = "Trường này không được để trống!";
                    input.parentElement.appendChild(errorDiv);
                }
            } else {
                input.classList.remove('is-invalid');
                const errorDiv = input.parentElement.querySelector('.invalid-feedback');
                if (errorDiv) {
                    errorDiv.remove();
                }
            }
        });
        return valid;
    }

    // Ví dụ: thêm sự kiện submit cho form
    document.querySelector('form').addEventListener('submit', function(e) {
        if (!validateAuthors()) {
            e.preventDefault(); // Ngăn form không được submit nếu có lỗi
        }
    });

  </script>
</body>
</html>
