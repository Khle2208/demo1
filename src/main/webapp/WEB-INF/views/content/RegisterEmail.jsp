<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/template/login.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/template/base.css">
<title>BookZone</title>
<style>
/* Style cho popup lỗi */
.popup-error {
	position: fixed;
	top: 20px;
	left: 50%;
	transform: translateX(-50%);
	background: red;
	color: white;
	padding: 10px 20px;
	border-radius: 5px;
	font-size: 16px;
	display: none;
	z-index: 1000;
}

/* Style cho lỗi dưới input */
.error-message {
	color: red;
	font-size: 14px;
	margin-top: 5px;
	display: none;
}
</style>
</head>
<body>

	<!-- Popup lỗi -->
	<div id="popupError" class="popup-error"></div>

	<div class="main-page">
		<div class="left-side">
			<img
				src="${pageContext.request.contextPath}/image/background-book.png"
				alt="Illustration of books on a shelf">
		</div>
		<div class="rigth-side">
			<div class="login-form">
				<h1 class="login-form_text">Chào mừng đến với BookZone</h1>
				<div class="login-form_img">
					<img
						src="${pageContext.request.contextPath}/image/BookZone-logo.png"
						alt="BookZone logo">
				</div>
				<h1 class="login-form_text">Đăng ký với BookZone</h1>

				<%
				String error = (String) request.getAttribute("error");
				boolean hasError = (error != null && !error.isEmpty());
				%>

				<div class="login-form_textfiled">
					<form id="registerForm"
						action="${pageContext.request.contextPath}/RegisterEmail"
						method="POST" novalidate>
						<div class="form-floating mb-4">
							<input type="email" class="form-control" id="email" name="email"
								placeholder="Nhập email"> <label for="email">Email</label>
						</div>
						<!-- Hiển thị lỗi dưới ô input -->
						<span id="email-error" class="error-message"></span>
						<div class="login-form_line"></div>
						<button type="submit" class="btn btn-warning btn-lg">Gửi
							OTP</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script>
window.onload = function () {
	var errorMessage = "<%=hasError ? error : ""%>";
			if (errorMessage.trim() !== "") {
				document.getElementById("popupError").innerHTML = errorMessage;
				document.getElementById("popupError").style.display = "block";

				// Ẩn popup sau 2 giây
				setTimeout(
						function() {
							document.getElementById("popupError").style.display = "none";
						}, 2000);
			}
		};

		// Kiểm tra lỗi trước khi submit form
		function validateForm() {
			var email = document.getElementById("email").value.trim();
			var emailError = document.getElementById("email-error");

			console.log("validateForm() được gọi");

			if (email === "") {
				emailError.innerHTML = "Vui lòng nhập email!";
				emailError.style.display = "block";
				return false;
			}

			var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
			if (!emailPattern.test(email)) {
				emailError.innerHTML = "Email không hợp lệ!";
				emailError.style.display = "block";
				return false;
			}

			emailError.style.display = "none";
			return true;
		}

		// Ngăn submit nếu có lỗi
		document.getElementById("registerForm").onsubmit = function(event) {
			if (!validateForm()) {
				event.preventDefault();
			}
		};

		// Ẩn lỗi khi nhập lại
		document.getElementById("email").oninput = function() {
			document.getElementById("email-error").style.display = "none";
		};
	</script>

</body>
</html>