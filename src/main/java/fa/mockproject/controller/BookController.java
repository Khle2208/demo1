package fa.mockproject.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
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
import fa.mockproject.service.BookService;

@Controller
public class BookController {
	@Autowired
	private BookService bookService;

	@GetMapping("/ChartBook")
	public String showChartBook(Model model) {
		int currentDate = LocalDate.now().getYear();
		return chartBookController(currentDate, model);
		// return "admin/content/ChartBook";
	}

	@GetMapping("/StatisticBook")
	public String showStatisticPage(HttpSession session) {

		return "content/StatisticBook";
	}

	@PostMapping("/StatisticBook")
	public String getTotalBook(
			@RequestParam(value = "startDateBook", required = true) @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDateBook,
			@RequestParam(value = "endDateBook", required = true) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDateBook,
			Model model ,HttpSession session) {	
		
	    Calendar calendar = Calendar.getInstance();
	    Date today = calendar.getTime();
	    if(startDateBook == null && endDateBook == null) {
	    	calendar.add(Calendar.DAY_OF_MONTH, -7);
	    	startDateBook = (Date) model.addAttribute("startDateB");
	    	endDateBook = (Date) session.getAttribute("endDateB");
	    	
	    	 if (startDateBook == null || endDateBook == null) {
	             startDateBook = calendar.getTime();
	             endDateBook = today;
	         }
	    }else {
	    	session.setAttribute("startDateBook", startDateBook);
	        session.setAttribute("endDateBook", endDateBook);
		}
		while (startDateBook.after(endDateBook)) {
			model.addAttribute("errorMessage", "⚠ Lỗi: Ngày bắt đầu phải nhỏ hơn hoặc bằng ngày kết thúc!");
			return "admin/content/StatisticBook";
		}
		model.addAttribute("startDateBook", startDateBook);
		model.addAttribute("endDateBook", endDateBook);
		
		
	    
		Integer totalBook = bookService.getBookService(startDateBook, endDateBook);
		
		// Integer totalQuantity = bookservice.getTotalBookService();
		model.addAttribute("totalBook", totalBook);
		
		
		if (totalBook == null) {
			totalBook = 0;
		}
//		model.addAttribute("totalQuantity", totalQuantity);
		return "content/StatisticBook";
	}
	@PostMapping("/ChartBook")
	public String chartBookController(@RequestParam(value = "year", required = false, defaultValue = "2025") int year,
			Model model) {
		List<Object[]> bookData = bookService.chartBookService(year);

		Map<Integer, int[]> monthBook = new HashMap<>();
		for (int i = 1; i <= 12; i++) {
			monthBook.put(i, new int[] { 0, 0, 0 });
		}
		for (Object[] item : bookData) {
			int month = (int) item[0];
			int totalBook = (item[1] != null) ? (int) item[1] : 0;
			int totalSaleBook = (item[2] != null) ? (int) item[2] : 0;
			int stockRemaining = (item[3] != null) ? (int) item[3] : 0;

			monthBook.put(month, new int[] { totalBook, totalSaleBook, stockRemaining });
		}

		List<Object[]> converBookData = new ArrayList<>();
		for (int i = 1; i <= 12; i++) {
			int[] values = monthBook.get(i);
			converBookData.add(new Object[] { i, values[0], values[1], values[2] });
		}
		System.out.println(converBookData);
		model.addAttribute("bookData", converBookData);
		model.addAttribute("year", year);

		return "content/ChartBook";
	}

	@GetMapping("/DownloadFileBook")
	public void download(HttpServletResponse respone, @RequestParam("yearex") int year) {

		try (XSSFWorkbook workbook = new XSSFWorkbook()) {
			XSSFSheet sheet = workbook.createSheet("Book Statistic" + year);
			XSSFRow row = sheet.createRow(0);
			row.createCell(0).setCellValue("Tháng");
			row.createCell(1).setCellValue("Số lượng");
			row.createCell(2).setCellValue("Sách đã bán");
			row.createCell(3).setCellValue("Sách tồn kho");

			List<Object[]> books = (List<Object[]>) bookService.chartBookService(year);

			int rowNum = 1;
			for (Object[] listbook : books) {
				XSSFRow excelRow = sheet.createRow(rowNum++);
				excelRow.createCell(0).setCellValue((Integer) listbook[0]);
				excelRow.createCell(1).setCellValue((Integer) listbook[1]);
				excelRow.createCell(2).setCellValue((Integer) listbook[2]);
				excelRow.createCell(3).setCellValue((Integer) listbook[3]);
			}
			respone.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			respone.setHeader("Content-Disposition", "attachment; filename=BookStatistics_" + year + ".xlsx");

			workbook.write(respone.getOutputStream());
			respone.flushBuffer();

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
