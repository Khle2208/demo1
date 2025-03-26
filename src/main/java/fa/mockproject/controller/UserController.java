package fa.mockproject.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

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
import org.springframework.web.bind.annotation.ResponseBody;

import fa.mockproject.service.UserService;

@Controller
public class UserController {
	@Autowired
	private UserService userservice;
	private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);

	// Xử lý GET request để hiển thị trang đăng ký
	@GetMapping("RegisterEmail")
	public String showRegisterPage() {
		return "content/RegisterEmail"; // Trả về trang JSP (WEB-INF/views/register.jsp)
	}

	@GetMapping("/RegisterOTP")
	public String showOTPPage() {
		return "content/RegisterOTP"; // Hiển thị trang nhập OTP (WEB-INF/views/RegisterOTP.jsp)
	}

	@GetMapping("/Register")
	public String showRegister() {
		return "content/Register";
	}

	@GetMapping("/LoginPage")
	public String showLogin() {
		return "content/LoginPage";
	}

	@GetMapping("/ForgotPassword")
	public String showForgotPass() {
		return "content/ForgotPassword";
	}

	@GetMapping("/Home")
	public String showHomePage(HttpSession session) {
		return "content/home";
	}

	// Xử lý POST request để xử lý form đăng ký
//	@PostMapping("/RegisterEmail")
//	public String register(@RequestParam("email") String email, HttpSession session, Model model) {
//		if (email == null || email.trim().isEmpty()) {
//			model.addAttribute("error", "Vui lòng nhập email hợp lệ!");
//			return "content/RegisterEmail";
//		}
//
//		if (userservice.exitMailService(email)) {
//			model.addAttribute("error", "Email đã tồn tại!");
//			return "content/RegisterEmail";
//		}
//
//		// Tạo OTP và lưu vào session
//		String otp = userservice.sendOtp(email, session);
//		session.setAttribute("email", email);
//		session.setAttribute("otp", otp);
//		System.out.println("otp la" + session.getAttribute("otp"));
//		System.out.println("✅ OTP đã lưu vào session: " + otp + " cho email: " + email);
//
//		return "content/RegisterOTP";
//	}
	// Lên lịch xóa OTP sau 30 giây
	private void scheduleOtpRemoval(HttpSession session) {
		scheduler.schedule(() -> {
			session.removeAttribute("otp");
		}, 30, TimeUnit.SECONDS);
	}

	@PostMapping("/RegisterEmail")
	public String register(@RequestParam("email") String email, HttpSession session, Model model) {
		if (email == null || email.trim().isEmpty()) {
			model.addAttribute("error", "Vui lòng nhập email hợp lệ!");
			return "admin/Authentication/RegisterEmail";
		}

		if (userservice.exitMailService(email)) {
			model.addAttribute("error", "Email đã tồn tại!");
			return "admin/Authentication/RegisterEmail";
		}

		// Gửi OTP và lưu vào session
		String otp = userservice.sendOtp(email, session);
		session.setAttribute("email", email);
		session.setAttribute("otp", otp);

		System.out.println(" OTP đã lưu vào session: " + otp + " cho email: " + email);

		// Lên lịch xóa OTP sau 30 giây
		scheduleOtpRemoval(session);

		return "content/RegisterOTP";
	}
	
	// Xử lý yêu cầu gửi lại OTP
	@ResponseBody
    @PostMapping(value = "/ResendEmail",produces = "text/plain;charset=UTF-8")
    public String resendOtp(HttpSession session) {
        String email = (String) session.getAttribute("email");
        if (email == null) {
            return "Vui lòng đăng ký lại!";
        }

        if (session.getAttribute("otp") == null) {
            String newOtp = userservice.sendOtp(email, session);
            session.setAttribute("otp", newOtp);
            System.out.println("🔄 OTP mới đã được tạo và gửi: " + newOtp);

            // Lên lịch xóa OTP sau 30 giây
            scheduleOtpRemoval(session);

            return "OTP đã được gửi lại!";
        }
        return "OTP vẫn còn hiệu lực, vui lòng chờ!";
    }

	@PostMapping("Register")
	public String verifyOTP(@RequestParam("otp1") String otp1, @RequestParam("otp2") String otp2,
			@RequestParam("otp3") String otp3, @RequestParam("otp4") String otp4, @RequestParam("otp5") String otp5,
			@RequestParam("otp6") String otp6, @RequestParam(value = "email", required = false) String email,
			HttpSession session, Model model) {

		// Lấy email từ session nếu không có trong request
		if (email == null || email.trim().isEmpty()) {
			email = (String) session.getAttribute("email");
		} else {
			session.setAttribute("email", email);
		}

		// Ghép OTP từ các ô input
		String otp = otp1 + otp2 + otp3 + otp4 + otp5 + otp6;

		if (otp.trim().isEmpty()) {
			model.addAttribute("error", "Vui lòng nhập mã OTP!");
			return "content/RegisterOTP";
		}

		// Kiểm tra OTP
		System.out.println(email);
		if (userservice.isValidOTP(email, otp, session)) {

			return "content/Register";
		} else {
			model.addAttribute("error", "Mã OTP không hợp lệ, vui lòng thử lại!");
			return "content/RegisterOTP";
		}
	}

	@PostMapping("/LoginPage")
	public String RegisterSuccess(@RequestParam(value = "username", required = false) String username,
			@RequestParam(value = "password", required = false) String password,
			@RequestParam(value = "email", required = false) String email,
			@RequestParam(value = "otp", required = false) String otp, HttpSession session) {
		if ((username == null || username.isEmpty()) && (password == null || password.isEmpty())) {
			return "content/Register";
		}

		if (email == null || email.trim().isEmpty()) {
			email = (String) session.getAttribute("email");
		}
		if (otp == null || otp.trim().isEmpty()) {
			otp = (String) session.getAttribute("otp");
		}

		userservice.Register(username, password, email, otp);
		return "content/LoginPage";
	}

	@PostMapping("/Home")
	public String LoginSuccess(@RequestParam(value = "email", required = false) String email,
			@RequestParam(value = "password", required = false) String password, HttpSession session, Model model) {
//		session.removeAttribute("email");
		// Kiểm tra email và password có bị null hoặc rỗng không
		if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
			model.addAttribute("error", "Email và mật khẩu không được để trống!");
			return "content/LoginPage";
		}

		System.out.println("Email nhận được: " + email);
		System.out.println("Password nhận được: " + password);

		// Gọi Service để kiểm tra đăng nhập
		String loginResult = userservice.Login(email, password);

		// Kiểm tra kết quả đăng nhập

		if ("adminLogin".equals(loginResult)) {
			model.addAttribute("error", loginResult);
			return "redirect:Manage-Book";
		}
		if (!"success".equals(loginResult)) {
			model.addAttribute("error", loginResult);
			return "content/LoginPage";
		}

		// Đăng nhập thành công -> Lưu session
		session.setAttribute("loggedUser", email);
		return "content/home";
	}

	@PostMapping("/ForgotPassword")
	public String forgotPassword(@RequestParam("email") String email, @RequestParam("passWord") String passWord,
			HttpSession session) {
		boolean isupdated = userservice.forgotPasswordService(email, passWord);
		if (isupdated) {
			System.out.println("Doi mat khau thanh cong cho email" + email);
			email = (String) session.getAttribute("email");
			return "content/home";
		} else {
			System.out.println("Doi mat khau khong thanh cong cho email" + email);
			return "content/ForgotPassword";
		}

	}

	@PostMapping("/StatisticUser")
	public String getUserCount(
			@RequestParam(value = "startDateUser", required = true) @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDateUser,
			@RequestParam(value = "endDateUser", required = true) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDateUser,
			Model model, HttpSession session) {
		while (startDateUser.after(endDateUser)) {
			model.addAttribute("errorMessage", "⚠ Lỗi: Ngày bắt đầu phải nhỏ hơn hoặc bằng ngày kết thúc!");
			return "admin/content/StatisticBook";
		}
		LocalDate threeMonthsAgo = LocalDate.now().minusMonths(3).withDayOfMonth(1);
		LocalDate currentDateEnd = LocalDate.now();

		Date startDateU = java.sql.Date.valueOf(threeMonthsAgo);
		Date endDateU = java.sql.Date.valueOf(currentDateEnd);

		session.setAttribute("startDateU", startDateU);
		session.setAttribute("endDateU", endDateU);
		int totalUser = userservice.getTotalUserService(startDateUser, endDateUser);

		// model.addAttribute("totalUser", totalUser);
		session.setAttribute("totalUser", totalUser);

		return "content/StatisticBook"; // Tên file JSP
	}

	@GetMapping("/ChartUser")
	public String showChartBook(Model model) {
		int currentDate = LocalDate.now().getYear();
		return chartUserController(currentDate, model);
		// return "admin/content/ChartBook";
	}

	@PostMapping("/ChartUser")
	public String chartUserController(@RequestParam(value = "year", required = false, defaultValue = "2025") int year,
			Model model) {
		List<Object[]> userData = userservice.chartUserSerivce(year);

		Map<Integer, int[]> monthUser = new HashMap<>();
		for (int i = 1; i <= 12; i++) {
			monthUser.put(i, new int[] { 0, 0, 0 });
		}
		for (Object[] item : userData) {
			int month = (int) item[0];
			int active_users = (item[1] != null) ? (int) item[1] : 0;
			int locked_users = (item[2] != null) ? (int) item[2] : 0;
			int user_count = (item[3] != null) ? (int) item[3] : 0;

			monthUser.put(month, new int[] { active_users, locked_users, user_count });
		}

		List<Object[]> converUserData = new ArrayList<>();
		for (int i = 1; i <= 12; i++) {
			int[] values = monthUser.get(i);
			converUserData.add(new Object[] { i, values[0], values[1], values[2] });
		}
		System.out.println(converUserData);
		model.addAttribute("userData", converUserData);
		model.addAttribute("year", year);

		return "content/ChartUser";
	}

	@GetMapping("/DownloadFileUser")
	public void download(HttpServletResponse respone, @RequestParam("yearex") int year) {

		try (XSSFWorkbook workbook = new XSSFWorkbook()) {
			XSSFSheet sheet = workbook.createSheet("User Statistic" + year);
			XSSFRow row = sheet.createRow(0);
			row.createCell(0).setCellValue("Tháng");
			row.createCell(1).setCellValue("Tài khoản hoạt động");
			row.createCell(2).setCellValue("Tài khoản bị khoá");
			row.createCell(3).setCellValue("Tổng tài khoản");

			List<Object[]> users = (List<Object[]>) userservice.chartUserSerivce(year);

			int rowNum = 1;
			for (Object[] listbook : users) {
				XSSFRow excelRow = sheet.createRow(rowNum++);
				excelRow.createCell(0).setCellValue((Integer) listbook[0]);
				excelRow.createCell(1).setCellValue((Integer) listbook[1]);
				excelRow.createCell(2).setCellValue((Integer) listbook[2]);
				excelRow.createCell(3).setCellValue((Integer) listbook[3]);
			}
			respone.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			respone.setHeader("Content-Disposition", "attachment; filename=UserStatistics_" + year + ".xlsx");

			workbook.write(respone.getOutputStream());
			respone.flushBuffer();

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
