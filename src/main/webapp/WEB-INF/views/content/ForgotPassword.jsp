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
	href="${pageContext.request.contextPath}/template/login.css ">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/template/base.css">
<title>BookZone</title>
<style>
.error-container {
	position: relative;
	min-height: 20px; /* Đảm bảo có chỗ trống cho lỗi mà không đẩy xuống */
}

.toggle-password {
	position: absolute;
	right: 15px;
	top: 50%;
	transform: translateY(-50%);
	width: 20px;
	height: 20px;
	cursor: pointer;
	opacity: 0.7;
}

.toggle-password:hover {
	opacity: 1;
}

/* Style khi input có lỗi */
.input-error {none !important;
	
}

.text-danger {
	color: red !important;
}
</style>
</head>
<body>

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
				<h1 class="login-form_text">Đặt lại mật khẩu</h1>
				<%
				HttpSession sessiono = request.getSession(false);
				String email = (sessiono != null) ? (String) sessiono.getAttribute("email") : null;
				if (email != null && email.contains(",")) {
					email = email.split(",")[0]; // Lấy email đầu tiên nếu có dấu phẩy
				}
				%>
				<div class="login-form_textfiled">
					<form id="forgotPasswordForm"
						action="${pageContext.request.contextPath}/ForgotPassword"
						method="POST">
						<input type="text" name="email" value="<%=email%>"
							class="form-control" readonly>
						<div class="form-floating mb-3 error-container position-relative ">
							<input type="password" class="form-control" id="password"
								name="passWord" placeholder="Mật khẩu"> <label
								for="password">Mật khẩu</label> <img class="toggle-password"
								id="togglePassword1"
								src="${pageContext.request.contextPath}/image/Eye.png" alt="eye">
						</div>
						<span id="password-error" class="text-danger"></span>
						<!-- Confirm Password - Quên mật khẩu -->
						<div class="form-floating mb-3 error-container position-relative">
							<input type="password" class="form-control" id="repassword"
								name="forgotpassword" placeholder="Mật khẩu"> <label
								for="forgotpassword">Nhập lại mật khẩu</label> <img
								class="toggle-password" id="togglePassword2"
								src="${pageContext.request.contextPath}/image/Eye.png" alt="eye">
						</div>
						<span id="forgotpassword-error" class="text-danger"></span>
						<div class="login-form_register">
							<a class="login-form_register_click" href="#"> Create an
								account </a>
						</div>
						<div class="login-form_line mb-3"></div>
						<button type="submit" class="btn btn-warning btn-lg">Đăng
							Nhập</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script>
		document
				.getElementById("forgotPasswordForm")
				.addEventListener(
						"submit",
						function(event) {

							var password = document.getElementById("password").value
									.trim();
							var repassword = document
									.getElementById("repassword").value.trim();

							var passwordError = document
									.getElementById("password-error");
							var repasswordError = document
									.getElementById("forgotpassword-error");

							var isValid = true;

							// Kiểm tra mật khẩu
							if (password === "") {
								passwordError.innerText = "Vui lòng nhập mật khẩu.";
								passwordError.style.display = "block";
								document.getElementById("password").classList
										.add("input-error");
								isValid = false;
							} else if (password.length < 6
									|| !/\d/.test(password)
									|| !/[a-zA-Z]/.test(password)) {
								passwordError.innerText = "Mật khẩu phải có ít nhất 6 ký tự, chứa chữ cái và số.";
								passwordError.style.display = "block";
								document.getElementById("password").classList
										.add("input-error");
								isValid = false;
							}

							// Kiểm tra xác nhận mật khẩu
							if (repassword === "") {
								repasswordError.innerText = "Vui lòng nhập lại mật khẩu.";
								repasswordError.style.display = "block";
								document.getElementById("repassword").classList
										.add("input-error");
								isValid = false;
							} else if (password !== repassword) {
								repasswordError.innerText = "Mật khẩu xác nhận không khớp.";
								repasswordError.style.display = "block";
								document.getElementById("repassword").classList
										.add("input-error");
								isValid = false;
							}

							// Nếu có lỗi, ngăn form gửi đi
							if (!isValid) {
								event.preventDefault();
							}
						});

		// Ẩn lỗi khi người dùng nhập lại
		function hideError(fieldId) {
			document.getElementById(fieldId + "-error").style.display = "none";
			document.getElementById(fieldId).classList.remove("input-error");
		}
		document
				.addEventListener(
						"DOMContentLoaded",
						function() {
							function togglePassword(iconId, inputId) {
								var toggleIcon = document
										.getElementById(iconId);
								var passwordInput = document
										.getElementById(inputId);

								toggleIcon
										.addEventListener(
												"click",
												function() {
													if (passwordInput.type === "password") {
														passwordInput.type = "text";
														toggleIcon.src = "${pageContext.request.contextPath}/image/hidden.jpg";
													} else {
														passwordInput.type = "password";
														toggleIcon.src = "${pageContext.request.contextPath}/image/Eye.png";
													}
												});
							}

							// Gọi hàm cho từng ô nhập mật khẩu
							togglePassword("togglePassword1", "password"); // Đăng nhập
							togglePassword("togglePassword2", "repassword"); // Quên mật khẩu
						});
	</script>
</body>
</html>