<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>About_Us</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
      rel="stylesheet"
    />
    <link href="/MockProject/template/about_us.css" rel="stylesheet" />
  </head>
  <body>
   <jsp:include page="../layout/header.jsp" ></jsp:include>
    
    <div class="banner text-center">
        <img
          src="${pageContext.request.contextPath}/image/About_us_image.png"
          alt="Book Zone" class="w-100"
        />
      </div>
      <div class="container p-0">
      
      <div class="content_container">
        <div class="text-center my-5">
          <h3 class="text-warning">Về chúng tôi</h3>
          <p>
            Chào mừng bạn đến với Book Zone, nguồn đáng tin cậy của bạn về nhiều
            loại sách đa dạng đáp ứng sở thích của mọi độc giả. Được thành lập
            với sứ mệnh nuôi dưỡng niềm yêu thích đọc sách trong cộng đồng,
            chúng tôi tự hào về việc cung cấp dịch vụ xuất sắc và nhiều lựa chọn
            sách. Hành trình của chúng tôi bắt đầu vào năm 2021 và kể từ đó,
            chúng tôi đã phát triển trở thành điểm đến yêu thích của những người
            yêu sách. Dưới đây, bạn sẽ tìm thấy thông tin về bốn chi nhánh của
            chúng tôi, địa điểm và số liên lạc của họ.
          </p>
        </div>

        <div class="text-center">
          <h3 class="text-warning">Chi nhánh của chúng tôi</h3>
          <div class="row">
            <div class="col-md-4 branch-info">
              <span>Zone</span>
              <p>
                Đường Chính, Trung Tâm Thành Phố<br/>Liên hệ: 123-456-7890<br />Giờ
                hoạt động: Thứ Hai đến Thứ Bảy, 9 giờ sáng - 7 giờ tối; Chủ
                nhật, 10 giờ sáng - 5 giờ chiều
              </p>
            </div>
            <div class="col-md-4 branch-info">
              <span>Zone</span>
              <p>
                Đường Chính, Trung Tâm Thành Phố<br />Liên hệ: 123-456-7890<br />Giờ
                hoạt động: Thứ Hai đến Thứ Bảy, 9 giờ sáng - 7 giờ tối; Chủ
                nhật, 10 giờ sáng - 5 giờ chiều
              </p>
            </div>
            <div class="col-md-4 branch-info">
              <span>Zone</span>
              <p>
                Đường Chính, Trung Tâm Thành Phố<br />Liên hệ: 123-456-7890<br />Giờ
                hoạt động: Thứ Hai đến Thứ Bảy, 9 giờ sáng - 7 giờ tối; Chủ
                nhật, 10 giờ sáng - 5 giờ chiều
              </p>
            </div>
          </div>
        </div>
        <div class="text-center my-5">
          <h3 class="text-warning">Cam kết của chúng tôi</h3>
          <p>
            Tại Book Zone, chúng tôi cam kết cung cấp một môi trường thân thiện
            và đầy cảm hứng cho tất cả những người đam mê sách. Mỗi chi nhánh
            của chúng tôi đều có đội ngũ nhân viên am hiểu và thân thiện sẵn
            sàng hỗ trợ bạn tìm kiếm cuốn sách hoàn hảo. Cho dù bạn đang tìm
            kiếm cuốn sách bán chạy mới nhất, một cuốn sách hiếm hay một nơi ấm
            cúng để đọc, Book Zone là điểm đến dành cho bạn. Chúng tôi tin vào
            sức mạnh của việc đọc sách để thay đổi cuộc sống và xây dựng cộng
            đồng. Hãy tham gia cùng chúng tôi tại một trong các chi nhánh của
            chúng tôi hoặc khám phá các dịch vụ trực tuyến của chúng tôi. Chúng
            tôi ở đây để hỗ trợ hành trình đọc sách của bạn và giúp trải nghiệm
            mua sách của bạn trở nên thú vị và trọn vẹn.
          </p>
        </div>
      </div>
    </div>
    
	<jsp:include page="../layout/footer.jsp"></jsp:include>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>

    