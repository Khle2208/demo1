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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/template/register.css">
<script
	src="${pageContext.request.contextPath}/template/js/movecell.js?v=<%=System.currentTimeMillis()%>"
	defer></script>

<title>BookZone</title>
<style>
.error-popup {
	display: none;
	position: fixed;
	top: 10%;
	left: 50%;
	transform: translateX(-50%);
	background-color: #dc3545; /* Màu đỏ */
	color: white;
	padding: 10px 20px;
	border-radius: 5px;
	z-index: 1000;
	font-size: 16px;
	text-align: center;
}

.otp-container {
	display: flex;
	justify-content: center;
	gap: 10px;
}

.otp-input {
	width: 40px;
	height: 40px;
	font-size: 20px;
	text-align: center;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.warning-popup {
	display: none;
	position: fixed;
	top: 10%;
	left: 50%;
	transform: translateX(-50%);
	background-color: #00FF7F; /* Màu xanh */
	color: black;
	padding: 10px 20px;
	border-radius: 5px;
	z-index: 1000;
	font-size: 16px;
	text-align: center;
}
</style>
</head>
<body>

	<div id="popupWarning" class="warning-popup"></div>

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
				<h1 class="login-form_text">Đăng kí với OTP</h1>

				<%-- Lấy email từ session --%>
				<%
				HttpSession sessionob = request.getSession(false);
				String email = (sessionob != null) ? (String) sessionob.getAttribute("email") : null;
				if (email != null && email.contains(",")) {
					email = email.split(",")[0]; // Lấy email đầu tiên nếu có dấu phẩy
				}
				String otp = (sessionob != null) ? (String) sessionob.getAttribute("otp") : null;
				String errorMessage = (String) request.getAttribute("error");
				%>


				<div class="login-form_textfiled">
					<form action="${pageContext.request.contextPath}/Register"
						method="POST" onsubmit="return validateForm()">
						<input type="text" name="email" value="<%=email%>"
							class="form-control" readonly> <input type="text"
							name="otp" value="<%=otp%>" class="form-control" readonly>

						<%-- Các ô nhập OTP --%>
						<div class="form-floating mt-3 otp-container">
							<input type="text" name="otp1" maxlength="1"
								class="otp-input form-control" id="otp1"> <input
								type="text" name="otp2" maxlength="1"
								class="otp-input form-control" id="otp2"> <input
								type="text" name="otp3" maxlength="1"
								class="otp-input form-control" id="otp3"> <input
								type="text" name="otp4" maxlength="1"
								class="otp-input form-control" id="otp4"> <input
								type="text" name="otp5" maxlength="1"
								class="otp-input form-control" id="otp5"> <input
								type="text" name="otp6" maxlength="1"
								class="otp-input form-control" id="otp6">
						</div>
						<div class="d-flex justify-content-end mt-5">
							<a href="javascript:void(0);"
								class="btn btn-link resend-otp-link" onclick="resendOTP()">
								Gửi lại OTP (<span id="countdown">30</span>s)
							</a>
						</div>
						<div class="login-form_line mb-4"></div>
						<button type="submit" class="btn btn-warning btn-lg">Xác
							nhận OTP</button>
					</form>
				</div>


			</div>
		</div>
	</div>
	<div id="popupError" class="error-popup"
		style="<%=(errorMessage != null) ? "display: block;" : "display: none;"%>">
		<%=(errorMessage != null) ? errorMessage : ""%>
	</div>

	<script>
			let wrongOtpAttempts = 0; 
			let isOTPCorrect = false; 

				function validateForm() {
				    var otpInputs = document.querySelectorAll(".otp-input");
				    var otpValue = "";
	
				    otpInputs.forEach(input => {
				        otpValue += input.value.trim();
				    });
	
				    if (otpValue.length < 6) {
				        showErrorPopup("Vui lòng nhập đầy đủ OTP!");
				        isOTPValid = false;
				        return false;
				    }
	
				   
				    return true;
				}
			

			function enableResendOTP() {
			    let button = document.querySelector(".resend-otp-link");
			    button.style.pointerEvents = "auto"; // Kích hoạt lại nút gửi OTP
			    button.style.color = "blue";
			}

			function resendOTP() {
			    fetch("${pageContext.request.contextPath}/ResendEmail", { method: "POST" })
			        .then(response => response.text())
			        .then(message => {
			            showWarningPopup(message); // Hiển thị thông báo màu vàng
			            wrongOtpAttempts = 0; // Reset số lần nhập sai

			            
			            let countdownElement = document.getElementById("countdown");
			            let currentCountdown = parseInt(countdownElement.innerText);

			            if (currentCountdown <= 0) {
			                clearInterval(timer);
			                countdownElement.innerText = "30"; 
			                startCountdown(); 
			            }
			        })
			        .catch(error => {
			            console.error("Thông báo:", );
			            showWarningPopup("Gửi OTP thành công!"); 
			            enableResendOTP();
			        });
			}

			function showErrorPopup(message) {
			    let popup = document.getElementById("popupError");
			    popup.innerHTML = message;
			    popup.className = "error-popup"; 
			    popup.style.display = "block";
			    setTimeout(() => { popup.style.display = "none"; }, 3000);
			}

			// Hiển thị popup thông báo màu vàng
			function showWarningPopup(message) {
			    let popup = document.getElementById("popupWarning");
			    popup.innerHTML = message;
			    popup.className = "warning-popup"; 
			    popup.style.display = "block";
			    setTimeout(() => { popup.style.display = "none"; }, 3000);
			}

			// Bắt đầu bộ đếm thời gian gửi lại OTP
			let timer;
			function startCountdown() {
			    let countdownElement = document.getElementById("countdown");
			    let button = document.querySelector(".resend-otp-link");
			    let countdown = 30; 

			    button.style.pointerEvents = "none";
			    button.style.color = "gray"; 

			    countdownElement.innerText = countdown;  

			    timer = setInterval(() => {
			        countdown--;
			        countdownElement.innerText = countdown;

			        if (countdown <= 0) {
			        clearInterval(timer);
			            button.style.pointerEvents = "auto";
			            button.style.color = "blue";
			            button.innerText = "Gửi lại OTP";
			        }
			    }, 1000);
			}

			// Chặn nhập ký tự không phải số
			document.querySelectorAll(".otp-input").forEach(input => {
			    input.addEventListener("input", function () {
			        this.value = this.value.replace(/[^0-9]/g, '');
			    });
			});

		
			document.addEventListener("DOMContentLoaded", function () {
			    let popup = document.getElementById("popupError");
			    startCountdown();
			    if (popup && popup.style.display === "block") {
			        setTimeout(() => {
			            popup.style.display = "none";
			        }, 3000); // Ẩn sau 3 giây
			    }
			});

		</script>



</body>
</html>