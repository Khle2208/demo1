<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <head>
    <title>Book's List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link href="/MockProject/template/book_list.css" rel="stylesheet">
  </head>
  <body>
    <jsp:include page="../layout/header.jsp"></jsp:include>
    <div class="container">
      <h1 style="display: none;">BOOKZONE_BookStore</h1>
      <div class="container my-5">
        <div class="row">
          <div class="col-md-3">
            <div class="row mb-4 form-control ms-0 ">
              <div class="col-md-6 w-auto d-flex justify-content-start">
                <input type="text" onfocus="this.style.outline='none';" class=" border-0 d-inline-block f-start" placeholder="Tìm kiếm sách..."> 
                <span class="input_group_text d-inline-block f-end mt-1">
                  <i class="fa-solid fa-magnifying-glass text-body-tertiary"></i>
                </span>
              </div>
            </div>
            <div class="border p-3 rounded shadow">
              <h5>Mức giá</h5>
              <div class="pb-4 border-bottom">
                <input type="checkbox" id="gia1" />
                <label for="gia1">Giá dưới 50.000đ</label><br />
                <input type="checkbox" id="gia2" />
                <label for="gia2">50.000 - 100.000đ</label><br />
                <input type="checkbox" id="gia3" />
                <label for="gia3">100.000 - 150.000đ</label><br />
                <input type="checkbox" id="gia4" />
                <label for="gia4">150.000 - 200.000đ</label><br />
                <input type="checkbox" id="gia5" />
                <label for="gia5">Giá trên 200.000đ</label>
              </div>

              <h5 class="mt-4">Thể loại</h5>
              <div>
                <input type="checkbox" id="tl1" />
                <label for="tl1">Lập trình</label><br />
                <input type="checkbox" id="tl2" />
                <label for="tl2">Truyện</label><br />
                <input type="checkbox" id="tl3" />
                <label for="tl3">Khoa học</label><br />
                <input type="checkbox" id="tl4" />
                <label for="tl4">Lịch sử</label><br />
                <input type="checkbox" id="tl5" />
                <label for="tl5">Tất cả</label>
              </div>
            </div>
          </div>

          <div class="col-md-9">
            <div class="row g-4">
              <h3 class="text-center mb-4">Sản phẩm trưng bày</h3>
              <div class="col-md-4 col-sm-6 " data-price="120000">
                <div class="card">
                  <button type="button" class="btn btn-warning p-2 text-center ms-auto m-2" style="max-width: 45px;">
                    <i class="fa-solid fa-cart-shopping text-white"></i>
                  </button>
                  
                  <img class="m-auto" style="max-width: 145px; max-height: 210px;"
                    src="${pageContext.request.contextPath}/image/bookImage.png"
                    class="card-img-top"
                    alt="Sản phẩm"
                  />
                  <div class="card-body">
                    <h5 class="card-title">Lập trình Web cơ bản</h5>
                    <div class="mb-1">
                      <span class="fw-bold fs-5">45.000 đ</span>
                      <span class="d-inline-flex justify-content-center align-items-center bg-danger text-white p-1 rounded">-10%</span>
                    </div>
                    <span class="text-decoration-line-through text-secondary">70.000 đ</span>
                    <div>
                      
                    </div>
                  </div>
                </div>
              </div>

              <div class="col-md-4 col-sm-6">
                <div class="card">
                  <button type="button" class="btn btn-warning p-2 text-center ms-auto m-2" style="max-width: 45px;">
                    <i class="fa-solid fa-cart-shopping text-white"></i>
                  </button>
                  
                  <img class="m-auto" style="max-width: 145px; max-height: 210px;"
                    src="${pageContext.request.contextPath}/image/bookImage.png"
                    class="card-img-top"
                    alt="Sản phẩm"
                  />
                  <div class="card-body">
                    <h5 class="card-title">Lập trình Web cơ bản</h5>
                    <div class="mb-1">
                      <span class="fw-bold fs-5">45.000 đ</span>
                      <span class="d-inline-flex justify-content-center align-items-center bg-danger text-white p-1 rounded">-10%</span>
                    </div>
                    <div>
                      <span class="text-decoration-line-through text-secondary">70.000 đ</span>
                    </div>
                  </div>
                </div>
              </div>

              <div class="col-md-4 col-sm-6">
                <div class="card">
                  <button type="button" class="btn btn-warning p-2 text-center ms-auto m-2" style="max-width: 45px;">
                    <i class="fa-solid fa-cart-shopping text-white"></i>
                  </button>
                  
                  <img class="m-auto" style="max-width: 145px; max-height: 210px;"
                    src="${pageContext.request.contextPath}/image/bookImage.png"
                    class="card-img-top"
                    alt="Sản phẩm"
                  />
                  <div class="card-body">
                    <h5 class="card-title">Lập trình Web cơ bản</h5>
                    <div class="mb-1">
                      <span class="fw-bold fs-5">45.000 đ</span>
                      <span class="d-inline-flex justify-content-center align-items-center bg-danger text-white p-1 rounded">-10%</span>
                    </div>
                    <div>
                      <span class="text-decoration-line-through text-secondary">70.000 đ</span>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-md-4 col-sm-6">
                <div class="card">
                  <button type="button" class="btn btn-warning p-2 text-center ms-auto m-2" style="max-width: 45px;">
                    <i class="fa-solid fa-cart-shopping text-white"></i>
                  </button>
                  
                  <img class="m-auto" style="max-width: 145px; max-height: 210px;"
                    src="${pageContext.request.contextPath}/image/bookImage.png"
                    class="card-img-top"
                    alt="Sản phẩm"
                  />
                  <div class="card-body">
                    <h5 class="card-title">Lập trình Web cơ bản</h5>
                    <div class="mb-1">
                      <span class="fw-bold fs-5">45.000 đ</span>
                      <span class="d-inline-flex justify-content-center align-items-center bg-danger text-white p-1 rounded">-10%</span>
                    </div>
                    <div>
                      <span class="text-decoration-line-through text-secondary">70.000 đ</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <jsp:include page="../layout/footer.jsp"></jsp:include>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>