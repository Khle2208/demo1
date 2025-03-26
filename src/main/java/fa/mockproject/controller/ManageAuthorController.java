package fa.mockproject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import fa.mockproject.model.Author;
import fa.mockproject.service.AuthorService;
import fa.mockproject.service.WritedByService;

@Controller
public class ManageAuthorController {

	@Autowired
	AuthorService authorService;
	@Autowired
	WritedByService writedByService;

	public void setupModel(Model model, HttpSession session) {

		@SuppressWarnings("unchecked")
		List<Author> listAuthor = (List<Author>) session.getAttribute("listAuthorSearchResult");
		if (listAuthor == null) {
			listAuthor = authorService.findAll();
		}
		Map<UUID, Integer> quantityBookList = new HashMap<UUID, Integer>();

		for (Author author : listAuthor) {
			quantityBookList.put(author.getAuthorId(), authorService.countBookByAuthorId(author));
		}

		if (!model.containsAttribute("author")) {
			model.addAttribute("author", new Author());
		}
		if (!model.containsAttribute("authorUpdate")) {
			model.addAttribute("authorUpdate", new Author());
		}
		model.addAttribute("quantityBookList", quantityBookList);
		model.addAttribute("actionUrl", "Manage-Author");
		model.addAttribute("listAuthor", listAuthor);

	}

	@GetMapping("Manage-Author")
	public String viewMangeAuthor(Model model, HttpSession session) {
		session.removeAttribute("listAuthorSearchResult");
		session.removeAttribute("showNotFoundAuthor");
		session.removeAttribute("findKey");
		setupModel(model, session);
		return "content/ManageAuthor";
	}

	@GetMapping("Manage-FindAuthor")
	public String viewMangeFindAuthor(Model model, HttpSession session) {
		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {
			setupModel(model, session);
			return "content/ManageAuthor";
		}
		return "redirect:Manage-Author";
	}

	@PostMapping("Add-Author")
	public String addAuthor(@ModelAttribute("author") @Valid Author a, BindingResult bindingResult, Model model,
			HttpSession session) {
		if (bindingResult.hasErrors()) {
			model.addAttribute("showAddAuthorModal", true);
			setupModel(model, session);
			return "content/ManageAuthor";
		}
		authorService.insert(a);
		return "redirect:Manage-Author";
	}

	@GetMapping("Delete-Author/{authorId}")
	public String deleteBook(@PathVariable("authorId") UUID authorId, @RequestParam("author") int quantityBook,
			RedirectAttributes redirectAttributes, HttpSession session) {
		if (quantityBook > 0) {
			redirectAttributes.addFlashAttribute("deleteAuthorError", true);
		} else {
			Author a = new Author(authorId, null, null);
			Author author = authorService.findById(a);
			authorService.delete(author);
		}
		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {		
			List<Author> listAuthor = authorService.findByName(findKey);
	        session.setAttribute("listAuthorSearchResult", listAuthor);
			return "redirect:/Manage-FindAuthor";
		}
		return "redirect:/Manage-Author";
	}

	@PostMapping("/deleteSelectedAuthor")
	public String deleteSelectedBooks(
			@RequestParam(value = "selectedAuthor", required = false) List<UUID> selectedAuthorIds,
			RedirectAttributes redirectAttributes, HttpSession session) {

		for (UUID authorId : selectedAuthorIds) {
			try {
				Author a = new Author(authorId, null, null);
				int quantity = authorService.countBookByAuthorId(a);
				if (quantity > 0) {
					redirectAttributes.addFlashAttribute("deleteAuthorError", true);
					return "redirect:/Manage-Author";
				} else {
					authorService.delete(a);
				}
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			}
		}

		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {		
			List<Author> listAuthor = authorService.findByName(findKey);
	        session.setAttribute("listAuthorSearchResult", listAuthor);
			return "redirect:/Manage-FindAuthor";
		}
		return "redirect:/Manage-Author";
	}

	@GetMapping("Manage-Author/find")
	public String viewFindList(@RequestParam("findKey") String findKey, HttpSession session) {
		List<Author> listAuthor = authorService.findByName(findKey);
		session.setAttribute("listAuthorSearchResult", listAuthor);
		if (listAuthor.isEmpty()) {
			session.setAttribute("showNotFoundAuthor", true);
		}
		session.setAttribute("findKey", findKey);
		return "redirect:/Manage-FindAuthor";
	}

	@GetMapping("Detail-Author/{authorId}")
	public String detailGenre(@PathVariable("authorId") UUID authorId, Model model,
			RedirectAttributes redirectAttributes, HttpSession session) {
		Author a = new Author(authorId, null, null);
		Author authorUpdate = authorService.findById(a);

		// Bạn có thể lưu trạng thái khác (nếu cần) vào session thông qua flash
		// attributes hoặc trực tiếp vào session attribute
		redirectAttributes.addFlashAttribute("authorUpdate", authorUpdate);
		redirectAttributes.addFlashAttribute("showUpdateModal", true);

		setupModel(model, session);
		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {		
			return "redirect:/Manage-FindAuthor";
		}
		return "redirect:/Manage-Author";
	}

	@PostMapping("Update-Author")
	public String updateGenre(@ModelAttribute("authorUpdate") Author a, HttpSession session, Model model) {
		authorService.update(a);
		// Nếu không có findKey thì có thể xóa attribute kết quả tìm kiếm (nếu cần)
		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {		
			List<Author> listAuthor = authorService.findByName(findKey);
	        session.setAttribute("listAuthorSearchResult", listAuthor);
			return "redirect:/Manage-FindAuthor";
		}
		return "redirect:/Manage-Author";
	}

}
