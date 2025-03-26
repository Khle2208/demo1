package fa.mockproject.controller;

import java.time.LocalDate;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import fa.mockproject.service.AuthorService;
import fa.mockproject.service.BookService;
import fa.mockproject.service.OrderService;
import fa.mockproject.service.UserService;

@Controller
@RequestMapping("statistic")
public class StatisticController {

    @Autowired
    private BookService bookService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private UserService userService;
    @Autowired
    private AuthorService authorService;

  
    @GetMapping("/StatisticController")
    public String showStatisticPage(Model model, HttpSession session,
            @RequestParam(value = "startDateBook", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDateBook,
            @RequestParam(value = "endDateBook", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDateBook,
            @RequestParam(value = "startDateOrder", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDateOrder,
            @RequestParam(value = "endDateOrder", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDateOrder,
            @RequestParam(value = "startDateUser", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDateUser,
            @RequestParam(value = "endDateUser", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDateUser) {

        //lấy 3 tháng
        LocalDate threeMonthsAgo = LocalDate.now().minusMonths(3);
        LocalDate currentDate = LocalDate.now();

      
        Date defaultStartDate = java.sql.Date.valueOf(threeMonthsAgo);
        Date defaultEndDate = java.sql.Date.valueOf(currentDate);

        // giá trị null lấy từ mặc định
        startDateBook = (startDateBook != null) ? startDateBook : (Date) session.getAttribute("startDateB");
        endDateBook = (endDateBook != null) ? endDateBook : (Date) session.getAttribute("endDateB");
        startDateOrder = (startDateOrder != null) ? startDateOrder : (Date) session.getAttribute("startDateO");
        endDateOrder = (endDateOrder != null) ? endDateOrder : (Date) session.getAttribute("endDateO");
        startDateUser = (startDateUser != null) ? startDateUser : (Date) session.getAttribute("startDateU");
        endDateUser = (endDateUser != null) ? endDateUser : (Date) session.getAttribute("endDateU");

       // session null -> lấy giá trị 3 tháng mặc định
        startDateBook = (startDateBook != null) ? startDateBook : defaultStartDate;
        endDateBook = (endDateBook != null) ? endDateBook : defaultEndDate;
        startDateOrder = (startDateOrder != null) ? startDateOrder : defaultStartDate;
        endDateOrder = (endDateOrder != null) ? endDateOrder : defaultEndDate;
        startDateUser = (startDateUser != null) ? startDateUser : defaultStartDate;
        endDateUser = (endDateUser != null) ? endDateUser : defaultEndDate;

        // ngay start > ngay end -> lỗi
        if (startDateBook.after(endDateBook) || startDateOrder.after(endDateOrder) || startDateUser.after(endDateUser)) {
            model.addAttribute("errorMessage", "⚠ Lỗi: Ngày bắt đầu phải nhỏ hơn hoặc bằng ngày kết thúc!");
            return "content/StatisticBook";
        }


        Integer totalBook = bookService.getBookService(startDateBook, endDateBook);
        Integer totalOrder = orderService.statisticOrderService(startDateOrder, endDateOrder);
        Integer totalUser = userService.getTotalUserService(startDateUser, endDateUser);
        Integer authorData = authorService.statisticAuthorService();

        //set
        session.setAttribute("startDateB", startDateBook);
        session.setAttribute("endDateB", endDateBook);
        session.setAttribute("startDateO", startDateOrder);
        session.setAttribute("endDateO", endDateOrder);
        session.setAttribute("startDateU", startDateUser);
        session.setAttribute("endDateU", endDateUser);
        session.setAttribute("totalBook", totalBook);
        session.setAttribute("totalOrder", totalOrder);
        session.setAttribute("totalUser", totalUser);

        
        model.addAttribute("totalBook", totalBook);
        model.addAttribute("totalOrder", totalOrder);
        model.addAttribute("totalUser", totalUser);
        model.addAttribute("authorData", authorData);

        return "content/StatisticBook";
    }
}
