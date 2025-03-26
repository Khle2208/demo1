<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<meta charset="utf-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<title>Shopping Cart</title>
<script src="https://cdn.tailwindcss.com"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
	rel="stylesheet" />
<link rel="stylesheet" href="./assets/css/cart.css" />

<style type="text/css">
.width-85 {
	width: 70%;
}

.cursor-pointer {
	cursor: pointer;
}
</style>
</head>
<body >
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="max-w-6xl mx-auto p-4 flex">
		<div class="bg-white p-4 rounded-lg shadow-md mr-3 h-1/2">
			<h1 class="text-xl font-semibold mb-4">GIỎ HÀNG (3 sản phẩm)</h1>
			<div class="flex items-center mb-4">
				<input class="mr-4 cursor-pointer" type="checkbox" /> <span
					class="width-85"> Chọn tất cả (3 sản phẩm) </span> <span
					class="w-1/4 text-end">Số lượng</span> <span
					class="w-1/4 text-center">Thành tiền</span>
			</div>
			<div class="border-t border-gray-200">
				<!-- Product 1 -->
				<div class="flex items-center py-4 border-b border-gray-200"
					data-product-id="product1">
					<input class="mr-4 cursor-pointer" type="checkbox" /> <img
						alt="Book cover of 'Think Again'"
						class="w-16 h-24 object-cover mr-4" height="90"
						src="https://storage.googleapis.com/a1aa/image/X_aarj_jh-fUHEBqTN7UhJC9WA3ntdot5uOlMkBwd7k.jpg"
						width="60" />
					<div class="flex-1">
						<h2 class="text-lg font-semibold">Dám Nghĩ Lại</h2>
						<p class="text-red-500 font-semibold originalPrice">
							122.640 đ <span class="line-through text-gray-500">
								168.000 đ </span>
						</p>
					</div>
					<div class="flex items-center">
						<button class="px-2 py-1 border border-gray-300 decreaseBtn">
							-</button>
						<span class="px-4 quantity"> 1 </span>
						<button class="px-2 py-1 border border-gray-300 increaseBtn">
							+</button>
					</div>
					<p class="text-red-500 font-semibold ml-4 totalPrice">122.640 đ</p>
					<button class="ml-4 text-gray-500">
						<i class="fas fa-trash"> </i>
					</button>
				</div>
				<!-- Product 2 -->
				<div class="flex items-center py-4 border-b border-gray-200"
					data-product-id="product2">
					<input class="mr-4 cursor-pointer" type="checkbox" /> <img
						alt="Book cover of 'Nexus'" class="w-16 h-24 object-cover mr-4"
						height="90"
						src="https://storage.googleapis.com/a1aa/image/SpnJcMDV3Zyk3jtH8oeJ8mOTRdmZufm9cPWqXdRJatw.jpg"
						width="60" />
					<div class="flex-1">
						<h2 class="text-lg font-semibold">Nexus - Lược Sử Của Những
							Mạng Lưới Thông Tin Từ Thời Đại Đồ Đá Đến Trí Tuệ Nhân Tạo - Bìa
							Cứng</h2>
						<p class="text-red-500 font-semibold originalPrice">
							397.600 đ <span class="line-through text-gray-500">
								568.000 đ </span>
						</p>
					</div>
					<div class="flex items-center">
						<button class="px-2 py-1 border border-gray-300 decreaseBtn">
							-</button>
						<span class="px-4 quantity"> 1 </span>
						<button class="px-2 py-1 border border-gray-300 increaseBtn">
							+</button>
					</div>
					<p class="text-red-500 font-semibold ml-4 totalPrice">397.600 đ</p>
					<button class="ml-4 text-gray-500">
						<i class="fas fa-trash"> </i>
					</button>
				</div>
				<!-- Product 3 -->
				<div class="flex items-center py-4" data-product-id="product3">
					<input class="mr-4 cursor-pointer" type="checkbox" /> <img
						alt="Book cover of 'Sapiens'" class="w-16 h-24 object-cover mr-4"
						height="90"
						src="https://storage.googleapis.com/a1aa/image/G10ixJfTapmEbq4eqKehfD7J4WsV1FN1q_IlIXqoDAs.jpg"
						width="60" />
					<div class="flex-1">
						<h2 class="text-lg font-semibold">Sapiens Lược Sử Loài Người</h2>
						<p class="text-red-500 font-semibold originalPrice">
							209.300 đ <span class="line-through text-gray-500">
								299.000 đ </span>
						</p>
					</div>
					<div class="flex items-center">
						<button class="px-2 py-1 border border-gray-300 decreaseBtn">
							-</button>
						<span class="px-4 quantity"> 1 </span>
						<button class="px-2 py-1 border border-gray-300 increaseBtn">
							+</button>
					</div>
					<p class="text-red-500 font-semibold ml-4 totalPrice">209.300 đ</p>
					<button class="ml-4 text-gray-500">
						<i class="fas fa-trash"> </i>
					</button>
				</div>
			</div>
		</div>
		<div class="bg-white p-4 rounded-lg shadow-md h-1/2">
			<div class="flex justify-between items-center mb-4">
				<h2 class="text-lg font-semibold">KHUYẾN MÃI</h2>
				<div class="text-blue-500 cursor-pointer show-modal">Xem thêm</div>
			</div>
			<div id="modal-overlay"
				class="fixed inset-0 bg-black opacity-50 z-40 hidden"></div>
			<div id="modal"
				class="fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-white p-6 rounded-lg shadow-md z-50 hidden w-1/2">
				<div class="flex items-center justify-between p-4 border-b">
					<h2 class="text-lg font-semibold text-blue-600">
						<i class="fas fa-tags"></i> CHỌN MÃ KHUYẾN MÃI
					</h2>
					<button class="text-gray-500 hover:text-gray-700" id="close-modal">
						<i class="fas fa-times"></i>
					</button>
				</div>
				<div class="p-4">
					<p class="text-sm text-gray-600 mb-4">
						Có thể áp dụng đồng thời nhiều mã <i class="fas fa-info-circle"></i>
					</p>
					<div class="flex items-center mb-4">
						<input type="text" placeholder="Nhập mã khuyến mãi/Quà tặng"
							class="flex-grow p-2 border rounded-lg mr-2" />
						<button class="bg-blue-600 text-white px-4 py-2 rounded-lg">
							Áp dụng</button>
					</div>
					<div>
						<h3 class="text-lg font-semibold mb-2">Mã giảm giá</h3>
						<div class="space-y-4">
							<div class="flex items-start p-4 border rounded-lg">
								<div
									class="flex-shrink-0 w-12 h-12 bg-gray-200 flex items-center justify-center rounded-full">
									<i class="fas fa-percent text-gray-600"></i>
								</div>
								<div class="ml-4 flex-grow w-1/2">
									<h4 class="text-sm font-semibold">Mã Giảm 10K - Toàn Sàn</h4>
									<p class="text-sm text-gray-600">Đơn hàng từ 130k - Không
										bao gồm giá trị của các sản phẩm sau Manga, Ngoại...</p>
									<p class="text-sm text-gray-600">HSD: 31/03/2025</p>
								</div>
								<div class="ml-4 mt-4">
									<button class="bg-blue-600 text-white px-4 py-2 rounded-lg">
										Mua thêm</button>
								</div>
							</div>
							<div class="flex items-start p-4 border rounded-lg">
								<div
									class="flex-shrink-0 w-12 h-12 bg-gray-200 flex items-center justify-center rounded-full">
									<i class="fas fa-percent text-gray-600"></i>
								</div>
								<div class="ml-4 flex-grow w-1/2">
									<h4 class="text-sm font-semibold">Mã Giảm 10K - Toàn Sàn</h4>
									<p class="text-sm text-gray-600">Đơn hàng từ 130k - Không
										bao gồm giá trị của các sản phẩm sau Manga, Ngoại...</p>
									<p class="text-sm text-gray-600">HSD: 31/03/2025</p>
								</div>
								<div class="ml-4 mt-4">
									<button class="bg-blue-600 text-white px-4 py-2 rounded-lg">
										Mua thêm</button>
								</div>
							</div>
						</div>
						<div class="text-center mt-4">
							<a href="#" class="text-blue-600">Xem
								thêm <i class="fas fa-chevron-down"></i>
							</a>
						</div>
					</div>
				</div>
			</div>
			<div class="bg-gray-100 p-4 rounded-lg mb-4">
				<p class="text-sm">Mã Giảm 10K - Toàn Sàn</p>
				<p class="text-xs text-gray-500">Đơn hàng từ 130k - Không bao
					gồm giá trị của các sản phẩm sau Manga, Ngoại...</p>
				<p class="text-xs text-gray-500">HSD: 31/03/2025</p>
				<div class="flex items-center mt-2">
					<div class="w-full bg-gray-300 rounded-full h-2.5 mr-2">
						<div class="bg-blue-500 h-2.5 rounded-full" style="width: 80%"></div>
					</div>
					<span class="text-xs text-gray-500"> Mua thêm 7.360 đ </span>
				</div>
				<button class="mt-2 text-blue-500">Mua thêm</button>
			</div>
			<div class="bg-gray-100 p-4 rounded-lg mb-4">
				<p class="text-sm">2 khuyến mãi đủ điều kiện</p>
				<a class="text-blue-500 text-sm" href="#"> Có thể áp dụng đồng
					thời nhiề... </a>
			</div>
			<div class="bg-gray-100 p-4 rounded-lg mb-4">
				<div class="flex justify-between items-center">
					<p class="text-sm">Nhận các voucher ưu đãi</p>
					<a class="text-blue-500 text-sm" href="#"> Nhận ngay </a>
				</div>
			</div>
			<div class="flex justify-between items-center mb-4">
				<p class="text-sm">Thành tiền</p>
				<p class="text-red-500 font-semibold totalPriceElement">0 đ</p>
			</div>
			<div class="flex justify-between items-center mb-4">
				<p class="text-lg font-semibold">Tổng Số Tiền (gồm VAT)</p>
				<p class="text-red-500 text-lg font-semibold totalWithVatElement">
					0 đ</p>
			</div>
			<button class="w-full bg-red-500 text-white py-2 rounded-lg payTotal">
				THANH TOÁN</button>
			<p class="text-xs text-gray-500 mt-2">(Giảm giá trên web chỉ áp
				dụng cho bán lẻ)</p>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
      document.addEventListener("DOMContentLoaded", () => {
        // chọn checkbox để thanh toán sản phẩm
        const totalPriceElement = document.querySelector(
          ".text-red-500.font-semibold.totalPriceElement"
        );
        const totalWithVatElement = document.querySelector(
          ".text-red-500.text-lg.font-semibold.totalWithVatElement"
        );
        const selectAllCheckbox = document.querySelector(
          'input[type="checkbox"]'
        );
        const productCheckboxes = document.querySelectorAll(
          '[data-product-id] input[type="checkbox"]'
        );

        function calculateTotal() {
          let total = 0;
          productCheckboxes.forEach((checkbox) => {
            if (checkbox.checked) {
              const productElement = checkbox.closest("[data-product-id]");
              const priceString = productElement
                .querySelector(".totalPrice")
                .textContent.match(/[\d.]+/)[0];
              const price = parseFloat(priceString.replace(".", ""));
              total += price;
            }
          });
          totalPriceElement.textContent = total.toLocaleString("vi-VN") + " đ";
          totalWithVatElement.textContent =
            total.toLocaleString("vi-VN") + " đ";
        }

        selectAllCheckbox.addEventListener("change", () => {
          productCheckboxes.forEach((checkbox) => {
            checkbox.checked = selectAllCheckbox.checked;
          });
          calculateTotal();
        });

        productCheckboxes.forEach((checkbox) => {
          checkbox.addEventListener("change", calculateTotal);
        });

        calculateTotal(); // Tính tổng ban đầu khi trang tải

        // tăng giảm số lương sản phẩm
        document.querySelectorAll(".increaseBtn").forEach((button) => {
          button.addEventListener("click", increaseQuantity);
        });

        document.querySelectorAll(".decreaseBtn").forEach((button) => {
          button.addEventListener("click", decreaseQuantity);
        });
        function increaseQuantity(event) {
          const productElement = event.target.closest("[data-product-id]");
          updateQuantity(productElement, 1);
        }

        function decreaseQuantity(event) {
          const productElement = event.target.closest("[data-product-id]");
          updateQuantity(productElement, -1);
        }

        function updateQuantity(productElement, change) {
          const quantityElement = productElement.querySelector(".quantity");
          const originalPriceElement =
            productElement.querySelector(".originalPrice");
          const totalPrice = productElement.querySelector(".totalPrice");
          const productCheckbox = productElement.querySelector(
            'input[type="checkbox"]'
          );

          let quantity = parseInt(quantityElement.textContent);
          quantity += change;

          if (quantity < 1) {
            alert("Số lượng không thể nhỏ hơn 1.");
            return;
          }

          quantityElement.textContent = quantity;

          const priceString =
            originalPriceElement.textContent.match(/[\d.]+/)[0];
          const price = parseFloat(priceString.replace(".", ""));

          const total = price * quantity;
          totalPrice.textContent = total.toLocaleString("vi-VN") + " đ";
          if (productCheckbox.checked) {
            calculateTotal();
          }
        }
      });
      //onclick nhập voucher
      document.addEventListener("DOMContentLoaded", () => {
        const showModalBtn = document.querySelector(".show-modal");
        const closeModalBtn = document.getElementById("close-modal");
        const modalOverlay = document.getElementById("modal-overlay");
        const modal = document.getElementById("modal");

        showModalBtn.addEventListener("click", () => {
          modal.classList.remove("hidden");
          modalOverlay.classList.remove("hidden");
        });

        closeModalBtn.addEventListener("click", () => {
          modal.classList.add("hidden");
          modalOverlay.classList.add("hidden");
        });

        modalOverlay.addEventListener("click", () => {
          modal.classList.add("hidden");
          modalOverlay.classList.add("hidden");
        });
      });
      // xử lý điều kiện button thanh toán
      document.addEventListener("DOMContentLoaded", function () {
        const payTotalButton = document.querySelector(".payTotal");
        const totalWithVatElement = document.querySelector(
          ".totalWithVatElement"
        );

        payTotalButton.addEventListener("click", function () {
          const totalWithVatString = totalWithVatElement.textContent
            .trim()
            .replace(" đ", "");
          const totalWithVat =
            parseInt(totalWithVatString.replace(/\./g, "")) || 0;

          if (totalWithVat === 0) {
            alert("Vui lòng chọn sản phẩm để thanh toán!");
          } else {
            // Ví dụ: window.location.href = '/trang-thanh-toan';
            alert("Chuyển sang trang thanh toán");
          }
        });
      });
    </script>
</body>