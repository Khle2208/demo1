<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Book Management</title>
<script src="https://www.gstatic.com/charts/loader.js"></script>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/templates/css/LayoutAdmin.css" />
<style>
.container {
	margin-left: 300px;
}

.row {
	margin-bottom: 40px;
}
</style>
</head>
<body>

	<jsp:include page="../layout/navbar.jsp"></jsp:include>
	<div class="content">
		<jsp:include page="../layout/header_admin.jsp"></jsp:include>
		<div class="mt-4">
			<div class="search w-10 px-3 d-flex justify-content-between">
				<form class="w-25"
					action="${pageContext.request.contextPath}/ChartBook"
					method="POST">
					<div class="input-group mb-3">
						<input class="form-control w-auto" type="number" name="year"
							id="year" min="2000" max="2100" required value="${year}">
						<button type="submit" class="btn btn-primary"><i class="fa-solid fa-magnifying-glass"></i></button>
					</div>
				</form>
				<a href="
					${pageContext.request.contextPath}/DownloadFileBook?yearex=${year}">
					<button class="btn btn-primary" type="submit"><i class="fa-solid fa-file-export"></i></button></a>
						<!-- <form action="
					method="GET">
					<div class="input-group mb-3">
						<button class="btn btn-primary" type="submit">Xuất file</button>
						<input type="text" name="yearex" id="yearex" required
							value="${year}">
					</div>
				</form> -->
				
			</div>
			<script>
    // Khi người dùng thay đổi năm, cập nhật giá trị vào input của form xuất file
    document.getElementById("yearInput").addEventListener("change", function () {
        document.getElementById("yearex").value = this.value;
    });
</script>

			<div id="myChart"
				style="width: 90%; height: 378px; margin-left: 50px;"></div>


			<c:if test="${not empty bookData}">
				<script>
				google.charts.load('current', {packages:['corechart']});
				google.charts.setOnLoadCallback(drawChart);

				function drawChart() {
					var data = google.visualization.arrayToDataTable([
						['Tháng', 'Số lượng','Sách đã bán','Sách tồn kho'],
						<c:forEach items="${bookData}" var="item" varStatus="loop">
					    ['Tháng ${item[0]}', ${item[1] != null ? item[1] : 0}, ${item[2] != null ? item[2] : 0}, ${item[3] != null ? item[3] : 0}] 
					    <c:if test="${!loop.last}">,</c:if>
					</c:forEach>
					]);
					var options = {
						    title: 'Số lượng sách theo tháng - ${year}',
						    hAxis: { title: 'Tháng', minValue: 1, maxValue: 12 },
						    vAxis: { 
						        title: 'Số lượng', 
						        minValue: 0,maxValue:10, 
						      //  viewWindow: { min: 0} // Đảm bảo trục Y không âm
						    },
						    legend: { position: 'top' }, // Hiển thị chú thích
						    colors: ['#00FF00', '#007bff', '#DD0000']
						};
					var chart = new google.visualization.ColumnChart(document.getElementById('myChart'));
					chart.draw(data, options);
				}
			</script>
			</c:if>
		</div>
	</div>


	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
