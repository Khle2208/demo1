<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Payment</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
    />
  </head>
  
  <body class="bg-gray-100">
  <jsp:include page="../layout/header.jsp" ></jsp:include>
   <div class=" p-4 max-w-6xl mx-auto p-4">
   	<div class="bg-white p-4 rounded shadow-md mb-4">
      <h2 class="text-lg font-semibold mb-2 border-b">ĐỊA CHỈ GIAO HÀNG</h2>
      <div class="border-b border-gray-300 pb-2 mb-2">
        <label class="flex items-center mb-2">
          <input
            type="radio"
            name="address"
            class="form-radio text-red-600 h-4 w-4"
            checked
          />
          <span class="ml-2"
            >Viet Cuong | gg, Phường Hòa Khánh Bắc, Quận Liên Chiểu, Đà Nẵng, VN
            | 0918445925</span
          >
          <a href="#" class="ml-auto text-blue-600">Sửa</a>
        </label>
        <label class="flex items-center">
          <input
            type="radio"
            name="address"
            class="form-radio text-red-600 h-4 w-4"
          />
          <span class="ml-2"
            >Pham Viet | ddff, Phường Hòa Khánh Nam, Quận Liên Chiểu, Đà Nẵng,
            VN | 0918445925</span
          >
          <a href="#" class="ml-auto text-blue-600">Sửa</a>
          <a href="#" class="ml-2 text-blue-600">Xóa</a>
        </label>
      </div>
      <div class="flex items-center">
        <i class="fas fa-plus text-red-600"></i>
        <span class="ml-2 text-red-600">Giao hàng đến địa chỉ khác</span>
      </div>
    </div>

    <div class="bg-white p-4 rounded shadow-md mb-4">
      <h2 class="text-lg font-semibold mb-2 border-b">
        PHƯƠNG THỨC VẬN CHUYỂN
      </h2>
      <div class="border-b border-gray-300 pb-2 mb-2">
        <label class="flex items-center">
          <input
            type="radio"
            name="shipping"
            class="form-radio text-red-600 h-4 w-4"
            checked
          />
          <span class="ml-2">
            <span class="font-semibold">Giao hàng tiêu chuẩn: 32.000 đ</span
            ><br />
            <span class="text-sm text-gray-600"
              >Dự kiến giao: Thứ Hai - 10/03</span
            >
          </span>
        </label>
      </div>
    </div>

    <div class="bg-white p-4 rounded shadow-md mb-4">
      <h2 class="text-lg font-bold mb-4">PHƯƠNG THỨC THANH TOÁN</h2>
      <div class="space-y-4">
        <div class="flex items-center">
          <input class="mt-1" name="payment" type="radio" />
          <img
            alt="ATM logo"
            class="ml-2"
            height="20"
            src="https://storage.googleapis.com/a1aa/image/J4YYbxOZ0VFQF2At4Iei7jDPGgWjGrDYQ7rbwDmgtSY.jpg"
            width="35"
          />
          <span class="ml-2"> ATM / Internet Banking </span>
        </div>
        <div class="flex items-center">
          <input class="mt-1" name="payment" type="radio" />
          <img
            alt="Visa/Master/JCB logo"
            class="ml-2"
            height="20"
            src="https://storage.googleapis.com/a1aa/image/DbR_HKN24RnkqSr749Jb5eCQjlNjnVXbDiCQ_5gyHh8.jpg"
            width="35"
          />
          <span class="ml-2"> Visa / Master / JCB </span>
        </div>
        <div class="flex items-center">
          <input  class="mt-1" name="payment" type="radio" />
          <img
            alt="Cash on delivery logo"
            class="ml-2"
            height="20"
            src="https://storage.googleapis.com/a1aa/image/K_RAGxM1INmDZZH8yjhxpMy8c761gXY4CKWwpiSm4t8.jpg"
            width="35"
          />
          <span class="ml-2"> Thanh toán bằng tiền mặt khi nhận hàng </span>
        </div>
      </div>
    </div>

    <div class="bg-white p-4 rounded shadow-md mb-4">
      <h2 class="text-lg font-semibold mb-4">MÃ KHUYẾN MÃI/MÃ QUÀ TẶNG</h2>
      <div class="flex items-center mb-4">
        <label for="promo-code" class="w-1/5 text-gray-700"
          >Mã KM/Quà tặng</label
        >
        <input
          id="promo-code"
          type="text"
          placeholder="Nhập mã khuyến mãi/Quà tặng"
          class="w-1/2 p-2 border border-gray-300 rounded"
        />
        <button class="ml-4 px-4 py-2 bg-blue-500 text-white rounded">
          Áp dụng
        </button>
        <a href="#" class="ml-4 text-blue-500">Chọn mã khuyến mãi</a>
      </div>
      <div class="flex items-center mb-4">
        <span
          class="bg-yellow-200 text-yellow-800 px-2 py-1 rounded-full text-sm font-semibold ml-56"
          >Mã giảm 10k</span
        >
        <button class="ml-2 text-gray-500 hover:text-gray-700">
          <i class="fas fa-times"></i>
        </button>
      </div>
      <p class="text-gray-500 text-sm ml-56">
        Chỉ có thể áp dụng được 1 mã <i class="fas fa-info-circle"></i>
      </p>
    </div>

    <div class="bg-white p-4 rounded shadow-md mb-4">
      <h1 class="text-xl font-semibold mb-4">Kiểm tra lại đơn hàng</h1>
      <div class="border-t border-gray-200">
        <!-- Product 1 -->
        <div class="flex items-center p-4 border-b border-gray-200">
          <img
            alt="Book cover of 'Think Again'"
            class="w-16 h-24 object-cover mr-4"
            height="90"
            src="https://storage.googleapis.com/a1aa/image/X_aarj_jh-fUHEBqTN7UhJC9WA3ntdot5uOlMkBwd7k.jpg"
            width="60"
          />
          <div class="flex-1">
            <h2 class="text-lg font-semibold">Dám Nghĩ Lại</h2>
            <p class="text-red-500 font-semibold originalPrice">
              122.640 đ
              <span class="line-through text-gray-500"> 168.000 đ </span>
            </p>
          </div>
          <div class="flex items-center w-1/6">
            <span class="px-4 quantity"> 1 </span>
          </div>
          <p class="text-red-500 font-semibold ml-4 w-1/6">122.640 đ</p>
        </div>
        <!-- Product 2 -->
        <div class="flex items-center p-4 border-b border-gray-200">
          <img
            alt="Book cover of 'Think Again'"
            class="w-16 h-24 object-cover mr-4"
            height="90"
            src="https://storage.googleapis.com/a1aa/image/X_aarj_jh-fUHEBqTN7UhJC9WA3ntdot5uOlMkBwd7k.jpg"
            width="60"
          />
          <div class="flex-1">
            <h2 class="text-lg font-semibold">Dám Nghĩ Lại</h2>
            <p class="text-red-500 font-semibold originalPrice">
              122.640 đ
              <span class="line-through text-gray-500"> 168.000 đ </span>
            </p>
          </div>
          <div class="flex items-center w-1/6">
            <span class="px-4 quantity"> 1 </span>
          </div>
          <p class="text-red-500 font-semibold ml-4 w-1/6">122.640 đ</p>
        </div>
        <!-- Product 3 -->
        <div class="flex items-center p-4 border-b border-gray-200">
          <img
            alt="Book cover of 'Think Again'"
            class="w-16 h-24 object-cover mr-4"
            height="90"
            src="https://storage.googleapis.com/a1aa/image/X_aarj_jh-fUHEBqTN7UhJC9WA3ntdot5uOlMkBwd7k.jpg"
            width="60"
          />
          <div class="flex-1">
            <h2 class="text-lg font-semibold">Dám Nghĩ Lại</h2>
            <p class="text-red-500 font-semibold originalPrice">
              122.640 đ
              <span class="line-through text-gray-500"> 168.000 đ </span>
            </p>
          </div>
          <div class="flex items-center w-1/6">
            <span class="px-4 quantity"> 1 </span>
          </div>
          <p class="text-red-500 font-semibold ml-4 w-1/6">122.640 đ</p>
        </div>
      </div>
    </div>

    <div class="bg-white p-4 rounded shadow-md mb-4">
      <div class="flex justify-between items-center border-b pb-4">
        <div>
          <p class="text-gray-600">Thành tiền</p>
          <p class="text-gray-600">Phí vận chuyển (Giao hàng tiêu chuẩn)</p>
          <p class="text-gray-600">
            Giảm giá (Nhập mã thành công - Mã giảm giá 10K TOÀN SÀN - Đơn hàng
            từ 130K)
          </p>
          <p class="font-bold text-lg">Tổng Số Tiền (gồm VAT)</p>
        </div>
        <div class="text-right">
          <p class="text-gray-600">209.300 đ</p>
          <p class="text-gray-600">32.000 đ</p>
          <p class="text-gray-600">-10.000 đ</p>
          <p class="font-bold text-lg text-red-600">231.300 đ</p>
        </div>
      </div>
      <div class="flex items-center mt-4">
        <input
          type="checkbox"
          class="form-checkbox h-5 w-5 text-red-600"
          checked
        />
        <span class="ml-2 text-gray-600"
          >Bằng việc tiến hành Mua hàng, Bạn đã đồng ý với</span
        >
        <a href="#" class="ml-1 text-blue-600"
          >Điều khoản & Điều kiện của Fahasa.com</a
        >
      </div>
      <div class="flex justify-between items-center mt-4">
        <div class="flex items-center text-red-600">
          <i class="fas fa-gift"></i>
          <span class="ml-2">Bạn chưa chọn món quà kèm theo đơn hàng</span>
          <i class="fas fa-chevron-right ml-2"></i>
        </div>
        <button class="bg-red-600 text-white px-6 py-2 rounded">
          Xác nhận thanh toán
        </button>
      </div>
    </div>
   </div>
    <jsp:include page="../layout/footer.jsp"></jsp:include>
   
  </body>   
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>