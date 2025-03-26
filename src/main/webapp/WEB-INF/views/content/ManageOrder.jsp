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
<link rel="stylesheet" href="/MockProject/template/AdminLayout.css" />
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
						<h2>Đơn hàng</h2>
					</div>
					<div class="row">
						<p>/Admin/ Quản lý đơn hàng</p>
					</div>

				</div>

				<div class="col-md-6 text-end">
					<div class="row">
						<br>
					</div>
					<form
						class="row d-flex justify-content-end flex-nowrap align-items-center"
						action="${pageContext.request.contextPath}/Filter-Order"
						method="POST">
						<input type="date" name="startDate" class="w-auto form-control"
							value="${sessionScope.startDate != null ? sessionScope.startDate : ''}">
						<p class="w-auto text-nowrap pt-3">-</p>
						<input type="date" name="endDate" class="w-auto  form-control"
							value="${sessionScope.endDate != null ? sessionScope.endDate : ''}">
						<section class="w-auto text-nowrap">
							<select id="mySelect" name="mySelect" class="form-control">
								<option value="All"
									<c:if test="${sessionScope.status == 'All'}">selected</c:if>>Trạng
									thái</option>
								<option value="Completed"
									<c:if test="${sessionScope.status == 'Completed'}">selected</c:if>>Completed</option>
								<option value="Pending"
									<c:if test="${sessionScope.status == 'Pending'}">selected</c:if>>Pending</option>
								<option value="Failed"
									<c:if test="${sessionScope.status == 'Failed'}">selected</c:if>>Failed</option>
							</select>
						</section>
						<button
							class="btn border border-1 w-auto btn-outline-warning text-dark"
							type="submit" style="height: 40px;">
							<i class="fa-solid fa-filter"></i> Tìm kiếm
						</button>
						<c:if
							test="${sessionScope.filterOrder == true || not empty sessionScope.findKey}">
							<a href="${pageContext.request.contextPath}/Manage-Order"
								class="btn border border-1 w-auto ms-2" style="height: 40px;">
								<i class="fa-solid fa-times"></i> Bỏ lọc
							</a>
						</c:if>
					</form>
				</div>
			</div>
			<div class="row px-5">
				<form action="${pageContext.request.contextPath}/deleteSelectedUser"
					method="post" id="deleteForm">
					<div style="height: 500px; overflow-y: croll;">
						<table class="table text-center">
							<thead>
								<tr class="position-sticky top-0 bg-light">
									<th>Đơn hàng</th>
									<th>Tổng tiền</th>
									<th>Ngày đặt</th>
									<th>Trạng thái</th>
									<th>Chi tiết</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${listOrder}" var="item">
									<tr>
										<td>${item.orderId }</td>
										<td>${item.totalPrice}</td>
										<td><fmt:formatDate value="${item.orderDate}"
												pattern="dd/MM/yyyy HH:mm:ss" /></td>
										<td>${item.status}</td>
										<td>
											<div class="d-flex justify-content-center">
												<a
													class="btn w-auto ms-3 btn-outline-warning text-dark border-0"
													href="${pageContext.request.contextPath}/Detail-Order/${item.orderId}"
													style="max-width: 150px; max-height: 40px;"><i
													class="fa-solid fa-pen"></i></a> <a
													class="btn w-auto ms-3 btn-outline-warning text-dark border-0"
													href="${pageContext.request.contextPath}/View-Order/${item.orderId}"
													style="width: 150px; height: 40px;"><i
													class="fa-solid fa-file"></i></a>
											</div>
										</td>
									</tr>
								</c:forEach>

							</tbody>
						</table>
					</div>
				</form>

			</div>
		</div>
	</div>

	<div class="modal fade" id="viewOrderModal" tabindex="-1"
		aria-labelledby="orderViewOrderModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" style="margin-top: 15vh;">
			<div class="modal-content">
				<div class="modal-header ms-auto">
					<!-- Nút đóng modal -->
					<a href="${pageContext.request.contextPath}/Manage-FindOrder">
						<button type="button" class="btn" data-bs-dismiss="modal"
							aria-label="Close">
							<i class="fa-solid fa-x" style="color: #cc9600"></i>
						</button>
					</a>
				</div>
				<h3 class="modal-title text-center w-100" id="orderDetailModalLabel">Chi
					Tiết Đơn Hàng</h3>
				<div class="modal-body">
					<!-- Nội dung chi tiết đơn hàng -->
					<div class="container">
						<div class="">
							<div class="card-body">
								<div class="border-bottom pb-4 mb-4">
									<c:forEach items="${listOrderDetail}" var="item">
										<div
											class="d-flex justify-content-between align-items-center mb-4">
											<div class="d-flex align-items-center">
												<img
													src="${pageContext.request.contextPath}/book/image/${item.bookId}"
													alt="Book cover of 'Lập trình Java'" class="img-fluid mr-4"
													style="height: 130px; width: 100px;" />
												<div class="ps-2">
													<h2 class="h6">${item.bookName}</h2>
													<p class="text-muted">Giá: ${item.price}đ | Số lượng:
														${item.quantityOrder}</p>
												</div>
											</div>
											<p class="h6 ">${item.totalPrice}</p>
										</div>
									</c:forEach>


								</div>
								<div class="d-flex justify-content-between mb-4">
									<div>
										<h3 class="h6 font-weight-semibold">Payment</h3>
										<p class="d-flex align-items-center">
											<span class="mr-2">Visa **56</span> <i
												class="fab fa-cc-visa text-primary"></i>
										</p>
										<p class="text-primary">Trạng thái: ${orderDetail.status}</p>
									</div>
									<div>
										<h3 class="h6 font-weight-semibold">Delivery</h3>
										<p class="text-muted">Địa chỉ:</p>
										<p class="text-primary">${addressOrderDetail.street},
											${addressOrderDetail.ward }, ${addressOrderDetail.district },
											${addressOrderDetail.province }</p>
									</div>
								</div>
								<div class="border-top pt-4">
									<div class="d-flex justify-content-between mb-4">
										<div>
											<h3 class="h6 font-weight-semibold">Thông tin khác</h3>
											<p class="text-muted">Người mua: ${userOrder.name }</p>
											<p class="text-muted">Email: ${userOrder.email }</p>
											<p class="text-muted">Phone: ${userOrder.phone }</p>
											<p class="text-muted">Thời gian đặt hàng:
												${orderDetail.orderDate }</p>
										</div>
										<div>
											<h3 class="h6 font-weight-semibold">Order Summary</h3>
											<p class="d-flex justify-content-between">
												<span>Thành tiền</span> <span class="ms-2">${orderDetail.price}đ</span>
											</p>
											<p class="d-flex justify-content-between">
												<span>Vận chuyển</span> <span>0.000đ</span>
											</p>
											<p class="d-flex justify-content-between">
												<span>Giảm giá</span> <span>${orderDetail.totalDiscount}đ</span>
											</p>
											<p class="d-flex justify-content-between font-weight-bold">
												<span>Tổng tiền</span> <span>${orderDetail.totalPrice}đ</span>
											</p>
										</div>
									</div>
								</div>
							</div>
							<!-- end card-body -->
						</div>
						<!-- end card -->
					</div>
					<!-- end container -->
				</div>
				<!-- end modal-body -->
			</div>
			<!-- end modal-content -->
		</div>
		<!-- end modal-dialog -->
	</div>
	<!-- end modal -->

	<div class="modal fade" id="anouceFilterModal" tabindex="-1"
		aria-labelledby="addUserModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg"
			style="margin-top: 15vh; max-width: 450px;">
			<div class="modal-content">
				<div class="modal-header ms-auto">
					<a href="${pageContext.request.contextPath}/Manage-Order">
						<button type="button" class="btn" data-bs-dismiss="modal"
							aria-label="Close">
							<i class="fa-solid fa-x" style="color: #cc9600"></i>
						</button>
					</a>

				</div>
				<h3 class="modal-title text-center w-100" id="addBookModalLabel">
					Tìm kiếm thất bại</h3>

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
						<p class="text-center text-muted">${sessionScope.message}</p>


					</form>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="detailOrderModal" tabindex="-1"
		aria-labelledby="detailGenreModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg"
			style="margin-top: 15vh; max-width: 450px;">
			<div class="modal-content">
				<div class="modal-header ms-auto">
					<a href="${pageContext.request.contextPath}/Manage-FindOrder">
						<button type="button" class="btn" data-bs-dismiss="modal"
							aria-label="Close">
							<i class="fa-solid fa-x" style="color: #cc9600;"></i>
						</button>
					</a>
				</div>
				<h3 class="modal-title text-center w-100" id="detailGenreModalLabel">
					Trạng thái đơn hàng</h3>
				<div class="modal-body">
					<form:form modelAttribute="orderUpdate" method="POST"
						action="${pageContext.request.contextPath}/Update-Order"
						onsubmit="return confirm('Bạn có chắc chắn muốn cập nhật đơn hàng này không?');"
						class="w-100">
						<input type="hidden" name="orderId" value="${orderUpdate.orderId}" />
						<div class="text-center">
							<div class="d-flex justify-content-center">
								<section class="w-auto text-nowrap">
									<select id="mySelect" name="mySelectUpdate"
										class="form-control">
										<%-- <option value="Completed"
											<c:if test="${orderUpdate.status == 'Completed'}">selected</c:if>>Completed</option> --%>
										<option value="Pending"
											<c:if test="${orderUpdate.status == 'Pending'}">selected</c:if>>Pending</option>
										<option value="Failed"
											<c:if test="${orderUpdate.status == 'Failed'}">selected</c:if>>Failed</option>
									</select>
								</section>
							</div>

							<div class="pt-5 text-center">
								<div class="image-upload-box">
									<button type="submit" name="action" value="updateOrder"
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


	<div class="modal fade" id="aunouceOrderNotFoundModal" tabindex="-1"
		aria-labelledby="aunouceOrderNotFoundModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg"
			style="margin-top: 15vh; max-width: 450px;">
			<div class="modal-content">
				<div class="modal-header ms-auto">
					<a href="${pageContext.request.contextPath}/Manage-Order">
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
						<p class="text-center text-muted">Không có đơn hàng cần tìm</p>
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

	<c:if test="${not empty sessionScope.showNotFoundOrder}">
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				var modal = new bootstrap.Modal(document
						.getElementById('aunouceOrderNotFoundModal'));
				modal.show();
			});
		</script>
	</c:if>

	<c:if test="${not empty showUpdateModal}">
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				var modal = new bootstrap.Modal(document
						.getElementById('detailOrderModal'));
				modal.show();
			});
		</script>
	</c:if>
	<c:if test="${not empty showFilterError}">
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				var deleteModal = new bootstrap.Modal(document
						.getElementById('anouceFilterModal'));
				deleteModal.show();
			});
		</script>
	</c:if>

	<c:if test="${not empty showViewModal}">
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				var modal = new bootstrap.Modal(document
						.getElementById('viewOrderModal'));
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
