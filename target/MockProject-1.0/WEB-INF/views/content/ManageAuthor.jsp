<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
						<h2>Tác giả</h2>
					</div>
					<div class="row">
						<p>/Admin/Quản lý tác giả</p>
					</div>
				</div>
				<div class="col-md-6 text-end">
					<div class="row">
						<br>
					</div>
					<div class="row d-flex justify-content-end">
						<button type="button" class="btn border border-1"
							style="width: 150px; height: 40px;">
							<i class="fa-solid fa-trash"></i> Xoá tác giả
						</button>
						<button class="btn border border-1 ms-3"
							style="width: 150px; height: 40px;" data-bs-toggle="modal"
							data-bs-target="#addAuthorModal">
							<i class="fa-solid fa-plus"></i> Thêm tác giả
						</button>
					</div>
				</div>
			</div>
			<div class="row px-5">
				<table class="table">
					<thead>
						<tr>
							<th><input type="checkbox"></th>
							<th>Tác giả</th>
							<th>Số lượng sách</th>
							<th>Chỉnh sửa</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="checkbox"></td>
							<td>Bàu Huyện Thanh Quan</td>
							<td>100</td>
							<td>
								<button class="btn w-auto ms-3"
									style="width: 150px; height: 40px;" data-bs-toggle="modal"
									data-bs-target="#detailAuthorModal">
									<i class="fa-solid fa-pen-to-square icon-action"></i>
								</button>
							</td>
						</tr>
						<tr>
							<td><input type="checkbox"></td>
							<td>Bàu Huyện Thanh Quan</td>
							<td>100</td>
							<td>
								<button class="btn w-auto ms-3"
									style="width: 150px; height: 40px;" data-bs-toggle="modal"
									data-bs-target="#detailAuthorModal">
									<i class="fa-solid fa-pen-to-square icon-action"></i>
								</button>
							</td>
						</tr>
						<tr>
							<td><input type="checkbox"></td>
							<td>Bàu Huyện Thanh Quan</td>
							<td>100</td>
							<td>
								<button class="btn w-auto ms-3"
									style="width: 150px; height: 40px;" data-bs-toggle="modal"
									data-bs-target="#detailAuthorModal">
									<i class="fa-solid fa-pen-to-square icon-action"></i>
								</button>
							</td>
						</tr>
					</tbody>
				</table>

			</div>
		</div>
	</div>


	<div class="modal fade" id="addAuthorModal" tabindex="-1"
		aria-labelledby="addUserModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" style="margin-top: 15vh; max-width: 500px;">
			<div class="modal-content">
				<div class="modal-header ms-auto">
					<button type="button" class="btn" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-x" style="color: #cc9600"></i>
					</button>
				</div>
				<h3 class="modal-title text-center w-100" id="addBookModalLabel">
					Thêm tác giả mới</h3>

				<div class="modal-body">
					<form class="w-100">
						<div class="text-center">
							<div class="d-flex justify-content-center">
								<input type="text" id="genreName" class="form-control w-75"
									placeholder="Tên tác giả" />
							</div>
							<div class="d-flex justify-content-center pt-3">
								<textarea class="form-control w-75" placeholder="Sơ lược về tác giả" rows="3"></textarea>
							</div>
							<div class="pt-5 text-center">
								<div class="image-upload-box">
									<button type="button" class="btn w-auto"
										style="background-color: #CC9600;">Thêm</button>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
