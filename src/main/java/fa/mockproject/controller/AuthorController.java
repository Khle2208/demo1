package fa.mockproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import fa.mockproject.service.AuthorService;

@Controller
public class AuthorController {
	@Autowired
	public AuthorService authorService;
	
	@GetMapping("StatisticAuthor")
	public String statisticAuthorService(Model model) {
		Integer authorData = authorService.statisticAuthorService();
		model.addAttribute("authorData", authorData);
		System.out.println(authorData);
		return "content/StatisticBook";
		
	}
}
