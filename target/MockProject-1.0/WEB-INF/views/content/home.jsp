<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Home</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
      rel="stylesheet"
    />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link href="/MockProject/template/home.css" rel="stylesheet" />
  </head>
  <body class="bg-gray-100">
    <h1 style="display: none">Book Store</h1>
    <jsp:include page="../layout/header.jsp"></jsp:include>
    <div class="container w-100 mt-5">
      <div class="intro mx-5 px-5 text-center mb-3">
        <h3 class="slogan mb-3 fw-bold">Xứ sở mộng mơ của người yêu sách!</h3>
        <p class="paragraph">
          Chào mừng đến với thiên đường của người yêu sách! Hãy tham gia cộng
          đồng của chúng tôi và đóng góp cho thư viện truyện ngày càng phát
          triển, nơi mỗi cuốn sách đều có cơ hội truyền cảm hứng cho một người
          mới.
        </p>
      </div>
      <div class="search_register col-sm-3 m-auto ps-3 border rounded-3">
        <input
          type="text"
          onfocus="this.style.outline='none';"
          class="border-0 d-inline-block f-start"
          placeholder="Tìm kiếm sách..."
        />
        <span class="input_group_text d-inline-block f-end">
          <i class="fa-solid fa-magnifying-glass text-body-tertiary"></i>
        </span>
      </div>
      <img class="col-md-8 mx-auto d-block mb-5" src="/MockProject/image/Book.png" alt="" />
      <div class="best_choice mb-5">
        <h3 class="text-center my-5">Lựa chọn tốt nhất</h3>
        <!-- Item_List -->
        <div class="cart-list d-flex justify-content-between gap-2 mx-auto">
          <!-- item_cart -->
          <div class="cart_item d-grid pb-2 px-3" style="max-width: 23%;">
            <button
              type="button"
              class="btn btn-warning text-center mt-3 order-1 ms-auto"
              style="max-width: 45px"
            >
              <i class="fa-solid fa-cart-shopping text-white"></i>
            </button>
            <img
              class="m-auto order-2"
              style="max-width: 145px; max-height: 210px"
              src="/MockProject/image/bookImage.png"
              class="card-img-top"
              alt="Sản phẩm"
            />
            <div class="card-body order-3">
              <h5 class="card-title">Lập trình Web cơ bản</h5>
              <div class="my-1">
                <span class="fw-bold fs-5">45.000 đ</span>
                <span
                  class="d-inline-flex justify-content-center align-items-center bg-danger text-white px-1 rounded"
                  > -10% </span>
              </div>
              <span class="text-decoration-line-through text-secondary fw-bold">
                70.000 đ</span>
            </div>
          </div>

          <div class="cart_item px-3 d-grid pb-2 " style="max-width: 23%;">
            <button
              type="button"
              class="btn btn-warning text-center mt-3 order-1 ms-auto"
              style="max-width: 45px"
            >
              <i class="fa-solid fa-cart-shopping text-white"></i>
            </button>
            <img
              class="m-auto order-2"
              style="max-width: 145px; max-height: 210px"
              src="/MockProject/image/bookImage.png"
              class="card-img-top"
              alt="Sản phẩm"
            />
            <div class="card-body order-3">
              <h5 class="card-title">Lập trình Web cơ bản</h5>
              <div class="my-1">
                <span class="fw-bold fs-5">45.000 đ</span>
                <span
                  class="d-inline-flex justify-content-center align-items-center bg-danger text-white px-1 rounded"
                  >-10%</span
                >
              </div>
              <span class="text-decoration-line-through text-secondary fw-bold">
                70.000 đ</span
              >
            </div>
          </div>

          <div class="cart_item px-3 d-grid pb-2" style="max-width: 23%;">
            <button
              type="button"
              class="btn btn-warning text-center mt-3 order-1 ms-auto"
              style="max-width: 45px"
            >
              <i class="fa-solid fa-cart-shopping text-white"></i>
            </button>
            <img
              class="m-auto order-2"
              style="max-width: 145px; max-height: 210px"
              src="/MockProject/image/bookImage.png"
              class="card-img-top"
              alt="Sản phẩm"
            />
            <div class="card-body order-3">
              <h5 class="card-title">Lập trình Web cơ bản</h5>
              <div class="my-1">
                <span class="fw-bold fs-5">45.000 đ</span>
                <span
                  class="d-inline-flex justify-content-center align-items-center bg-danger text-white px-1 rounded"
                  >-10%</span
                >
              </div>
              <span class="text-decoration-line-through text-secondary fw-bold">
                70.000 đ</span
              >
            </div>
          </div>

          <div class="cart_item col-md-3 px-3 d-grid pb-2" style="max-width: 23%;">
            <button
              type="button"
              class="btn btn-warning text-center mt-3 order-1 ms-auto"
              style="max-width: 45px"
            >
              <i class="fa-solid fa-cart-shopping text-white"></i>
            </button>
            <img
              class="m-auto order-2"
              style="max-width: 145px; max-height: 210px"
              src="/MockProject/image/bookImage.png"
              class="card-img-top"
              alt="Sản phẩm"
            />

            <div class="card-body order-3">
              <h5 class="card-title">Lập trình Web cơ bản</h5>
              <div class="my-1">
                <span class="fw-bold fs-5">45.000 đ</span>
                <span
                  class="d-inline-flex justify-content-center align-items-center bg-danger text-white px-1 rounded"
                  >-10%</span
                >
              </div>
              <span class="text-decoration-line-through text-secondary fw-bold">
                70.000 đ</span
              >
            </div>
          </div>
        </div>
      </div>
      <div class="px-3 py-5  mb-5 border-top d-flex justify-content-between gap-5">
        <img src="/MockProject/image/Read_image.png" class="" alt="Read Image" />
        <div class="paragraph_readHere">
          <h3 class="title_readHere fw-bold mb-4 fs-2">Reads Are Here!</h3>
          <p class="fs-6">
            Mua sách yêu thích trực tuyến dễ dàng! Tận hưởng các ưu đãi và giảm
            giá độc quyền cho các tựa sách đã chọn. Khám phá bộ sưu tập của
            chúng tôi và tìm các ưu đãi đặc biệt giúp việc đọc sách trở nên dễ
            dàng hơn. Mua ngay và mở khóa nhiều khoản tiết kiệm hơn với mỗi lần
            mua hàng!
          </p>
          <div class="statictis d-flex justify-content-between">
            <div class="bookListing">
              <p class="fw-bolder fs-2 mb-0">800+</p>
              <p class="fst-italic">Book Orders</p>
            </div>
            <div class="bookListing">
              <p class="fw-bolder fs-2 mb-0">1000+</p>
              <p class="fst-italic">Registered Member</p>
            </div>
            <div class="bookListing">
              <p class="fw-bolder fs-2 mb-0">3</p>
              <p class="fst-italic">Branch Count</p>
            </div>
          </div>
        </div>
      </div>
    </div>
   <jsp:include page="../layout/footer.jsp"></jsp:include>
  </body>
</html>
    