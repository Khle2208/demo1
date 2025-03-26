package fa.mockproject.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import fa.mockproject.model.Book;
import fa.mockproject.service.BookService;
import fa.mockproject.service.OrderService;
import fa.mockproject.service.UserService;

@Controller
public class HomeController {
	
	@Autowired
	BookService bookService;
	@Autowired
	OrderService orderService;
	@Autowired
	UserService userService;
	@GetMapping("home")
	public String viewHome(HttpServletRequest req, HttpSession session, Model model) {
		String numberOfUsers = numberOf(userService.findAll().size());
		String numberOfOrders = numberOf(orderService.findAll().size());
		
		List<Book> books = null;
		books = bookService.findTop4();
		model.addAttribute("books",books);
		model.addAttribute("books",books);
		model.addAttribute("numberOfUsers", numberOfUsers);
		model.addAttribute("numberOfOrders", numberOfOrders);
		return "content/home";
	}
	public String numberOf(int number) {
		if(number > 100) {
			return String.valueOf(Math.floorDiv(number, 100) * 100)+ "+" ;
		} else {
			return String.valueOf(number);
		}
	}
	
	@GetMapping("home/search")
	public String searchBook(@RequestParam("search_value") String search_value, Model model) {
		
		List<Book> books = null;
		books = bookService.findByName(search_value);
		int totalBooksFound  = (books != null) ? books.size() : 0;
		model.addAttribute("books", books );
		model.addAttribute("totalBooksFound",totalBooksFound);
		model.addAttribute("search_value", search_value);
		
		return "content/book_list";
	}
}
