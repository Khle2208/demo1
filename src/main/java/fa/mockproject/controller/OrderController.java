package fa.mockproject.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import fa.mockproject.service.OrderService;
@Controller
public class OrderController {
	@Autowired
	OrderService orderService;

	@GetMapping("/ChartRevenue")
	public String displayChartRevenue(Model model) {
		int currentYear = LocalDate.now().getYear();
		return chartRevenueController(currentYear, model);
		// return "admin/content/ChartRevenue";
	}

	@PostMapping("/ChartRevenue")
	public String chartRevenueController(@RequestParam("year") int year, Model model) {
		List<Object[]> revenueData = orderService.chartRevenueService(year);
		Map<Integer, int[]> mothRevenue = new HashMap<>();
		for (int i = 1; i <= 12; i++) {
			mothRevenue.put(i, new int[] { 0 });
		}

		for (Object[] item : revenueData) {
			int month = (int) item[0];
			int revenue = (item[1] != null) ? (int) item[1] : 0;
			mothRevenue.put(month, new int[] { revenue });
		}

		List<Object[]> converRevenueData = new ArrayList<>();
		for (int i = 1; i <= 12; i++) {
			int[] values = mothRevenue.get(i);
			converRevenueData.add(new Object[] { i, values[0] });

		}
		model.addAttribute("revenueData", converRevenueData);
		model.addAttribute("year", year);
		return "content/ChartRevenue";
	}

	@GetMapping("downloadFileRevenue")
	public void downloadRevenue(@RequestParam("yearex") int year, HttpServletResponse response) {
		try (XSSFWorkbook workbook = new XSSFWorkbook()) {
			XSSFSheet sheet = workbook.createSheet("Revenue Statistic" + year);
			XSSFRow row = sheet.createRow(0);
			row.createCell(0).setCellValue("Month");
			row.createCell(1).setCellValue("Revenue");

			List<Object[]> revenues = orderService.chartRevenueService(year);

			int rowNum = 1;
			for (Object[] listRevenues : revenues) {
				XSSFRow excelRow = sheet.createRow(rowNum++);
				excelRow.createCell(0).setCellValue((Integer) listRevenues[0]);
				excelRow.createCell(1).setCellValue((Integer) listRevenues[1]);
			}
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			response.setHeader("Content-Disposition", "attachment; filename=RevenueStatistic_" + year + ".xlsx");

			workbook.write(response.getOutputStream());
			response.flushBuffer();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@GetMapping("/ChartOrder")
	public String displayChartOrder(Model model) {
		int currentYear = LocalDate.now().getYear();
		return chartOrderController(currentYear, model);
		// return "admin/content/ChartOrder";
	}

	@PostMapping("/ChartOrder")
	public String chartOrderController(@RequestParam("year") int year, Model model) {

		List<Object[]> orderData = orderService.chartOrderService(year);

		Map<Integer, int[]> monthOrder = new HashMap<>();
		for (int i = 1; i <= 12; i++) {
			monthOrder.put(i, new int[] { 0, 0, 0 });
		}

		for (Object[] item : orderData) {
			int month = (int) item[0];
			int completed = (item[1] != null) ? (int) item[1] : 0;
			int pending = (item[2] != null) ? (int) item[2] : 0;
			int failed = (item[3] != null) ? (int) item[3] : 0;

			monthOrder.put(month, new int[] { completed, pending, failed });
		}

		List<Object[]> converOrderData = new ArrayList<>();
		for (int i = 1; i <= 12; i++) {
			int[] values = monthOrder.get(i);
			converOrderData.add(new Object[] { i, values[0], values[1], values[2] });
		}
		model.addAttribute("orderData", converOrderData);
		model.addAttribute("year", year);
		System.out.println(orderData);
		return "content/ChartOrder";
	}

	@GetMapping("downloadFileOrder")
	public void downloadOrder(@RequestParam("yearex") int year, HttpServletResponse response) {
		try (XSSFWorkbook workbook = new XSSFWorkbook()) {
			XSSFSheet sheet = workbook.createSheet("Order Statistic" + year);
			XSSFRow row = sheet.createRow(0);
			row.createCell(0).setCellValue("Tháng");
			row.createCell(1).setCellValue("Hoàn thành");
			row.createCell(2).setCellValue("Đang gửi");
			row.createCell(3).setCellValue("Huỷ");

			List<Object[]> revenues = orderService.chartOrderService(year);

			int rowNum = 1;
			for (Object[] listRevenues : revenues) {
				XSSFRow excelRow = sheet.createRow(rowNum++);
				excelRow.createCell(0).setCellValue((Integer) listRevenues[0]);
				excelRow.createCell(1).setCellValue((Integer) listRevenues[1]);
				excelRow.createCell(2).setCellValue((Integer) listRevenues[2]);
				excelRow.createCell(3).setCellValue((Integer) listRevenues[3]);
			}
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			response.setHeader("Content-Disposition", "attachment; filename=OrderStatistic_" + year + ".xlsx");

			workbook.write(response.getOutputStream());
			response.flushBuffer();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@GetMapping("StatisticOrder")
	public String statisticOrder(
			@RequestParam(value = "startDateOrder", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDateOrder,
			@RequestParam(value = "endDateOrder", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDateOrder,
			Model model, HttpSession session) {

		
		if (startDateOrder == null && endDateOrder == null) {
			LocalDate threeMonthsAgo = LocalDate.now().minusMonths(2).withDayOfMonth(1);
			LocalDate currentDateEnd = LocalDate.now();

			startDateOrder = java.sql.Date.valueOf(threeMonthsAgo);
			endDateOrder = java.sql.Date.valueOf(currentDateEnd);
			model.addAttribute("startDateOrder", startDateOrder);
			model.addAttribute("endDateOrder", endDateOrder);
			
		}
		
		Integer totalOrder = orderService.statisticOrderService(startDateOrder, endDateOrder);
	
	
		model.addAttribute("totalOrder", totalOrder);
		if (startDateOrder != null && endDateOrder != null) {
			session.setAttribute("startDateOrder", startDateOrder);
			session.setAttribute("endDateOrder", endDateOrder);
		}

		return "content/StatisticBook";
	}
}
