const inputs = document.querySelectorAll(".otp-input");

    inputs.forEach((input, index) => {
        input.addEventListener("input", (e) => {
            if (e.target.value.length === 1 && index < inputs.length - 1) {
                inputs[index + 1].focus(); // Chuyển sang ô tiếp theo khi nhập
            }
        });

        input.addEventListener("keydown", (e) => {
            if (e.key === "Backspace" && index > 0 && !e.target.value) {
                inputs[index - 1].focus(); // Quay lại ô trước khi xoá
            }
        });
		document.querySelector("form").addEventListener("submit", function(event) {
		    console.log(new FormData(this)); // Kiểm tra dữ liệu gửi đi có `otp1`, `otp2` không
		});
    });