package fa.mockproject.controller;

import java.util.ArrayList;
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
import fa.mockproject.model.Genre;
import fa.mockproject.service.GenreService;

@Controller
public class ManageGenreController {
	@Autowired
	GenreService genreService;

	@ModelAttribute("selectedGenreIds")
	public List<UUID> selectedGenreIds() {
		return new ArrayList<>();
	}

	public void setUpModel(Model model, HttpSession session) {
		// Nếu có kết quả tìm kiếm trong session thì ưu tiên sử dụng nó
		@SuppressWarnings("unchecked")
		List<Genre> listGenre = (List<Genre>) session.getAttribute("listGenreSearchResult");
		if (listGenre == null) {
			// Nếu không có thì lấy danh sách ban đầu từ cơ sở dữ liệu
			listGenre = genreService.findAll();
		}
		Map<UUID, Integer> quantityBookList = new HashMap<>();
		for (Genre genre : listGenre) {
			quantityBookList.put(genre.getGenreId(), genreService.counBookByGenreId(genre));
		}
		if (!model.containsAttribute("genreUpdate")) {
			model.addAttribute("genreUpdate", new Genre());
		}
		if (!model.containsAttribute("genre")) {
			model.addAttribute("genre", new Genre());
		}
		model.addAttribute("listGenre", listGenre);
		model.addAttribute("actionUrl", "Manage-Genre");
		model.addAttribute("quantityBookList", quantityBookList);
	}

	@GetMapping("Manage-Genre")
	public String viewMangeGenre(Model model, HttpSession session) {
		session.removeAttribute("listGenreSearchResult");
		session.removeAttribute("findKey");
		session.removeAttribute("showNotFoundGenre");
		setUpModel(model, session);
		return "content/ManageGenre";
	}

	@GetMapping("Manage-FindGenre")
	public String viewMangeFindGenre(Model model, HttpSession session) {
		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {
			setUpModel(model, session);
			return "content/ManageGenre";
		}
		return "redirect:Manage-Genre";
	}

	

	@GetMapping("Delete-Genre/{genreId}")
	public String deleteBook(@PathVariable("genreId") UUID genreId, @RequestParam("genre") int quantityBook,
			RedirectAttributes redirectAttributes, HttpSession session) {
		if (quantityBook > 0) {
			redirectAttributes.addFlashAttribute("deleteGenreError", true);
		} else {
			Genre g = new Genre(genreId, null);
			Genre genre = genreService.findById(g);
			genreService.delete(genre);
		}
		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {
			List<Genre> listGenre = genreService.findByName(findKey);
			session.setAttribute("listGenreSearchResult", listGenre);
			return "redirect:/Manage-FindGenre";
		}
		return "redirect:/Manage-Genre";
	}

	@GetMapping("Detail-Genre/{genreId}")
	public String detailGenre(@PathVariable("genreId") UUID genreId, Model model, RedirectAttributes redirectAttributes,
			@ModelAttribute("selectedGenreIds") List<UUID> sessionSelectedGenres, HttpSession session) {
		Genre g = new Genre(genreId, null);
		Genre genreUpdate = genreService.findById(g);

		// Bạn có thể lưu trạng thái khác (nếu cần) vào session thông qua flash
		// attributes hoặc trực tiếp vào session attribute
		redirectAttributes.addFlashAttribute("genreUpdate", genreUpdate);
		redirectAttributes.addFlashAttribute("showUpdateModal", true);

		setUpModel(model, session);
		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {
			return "redirect:/Manage-FindGenre";
		}
		return "redirect:/Manage-Genre";
	}

	@PostMapping("Add-Genre")
	public String addGenre(@ModelAttribute("genre") @Valid Genre g, BindingResult bindingResult, Model model,
			RedirectAttributes redirectAttributes, HttpSession session) {
		if (bindingResult.hasErrors()) {
			model.addAttribute("showAddGenreModal", true);
			setUpModel(model, session);
			return "content/ManageGenre";
		}
		if (genreService.findByFullName(g.getGenreName()) != null) {
			redirectAttributes.addFlashAttribute("addFailGenreModal", true);
		} else {			
			genreService.insert(g);
		}
		return "redirect:Manage-Genre";

	}

	@PostMapping("Update-Genre")
	public String updateGenre(@ModelAttribute("genreUpdate") @Valid Genre g, BindingResult bindingResult,
			HttpSession session, Model model) {
		if (bindingResult.hasErrors()) {
			model.addAttribute("showUpdateModal", true);
			setUpModel(model, session);
			return "content/ManageGenre";
		}
		genreService.update(g);
		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {
			// Nếu có, cập nhật lại kết quả tìm kiếm theo từ khóa đó
			List<Genre> listGenre = genreService.findByName(findKey);
			session.setAttribute("listGenreSearchResult", listGenre);
		}

		// Nếu không có findKey thì có thể xóa attribute kết quả tìm kiếm (nếu cần)
		else {
			session.removeAttribute("listGenreSearchResult");
		}

		return "redirect:/Manage-Genre";
	}

	@PostMapping("/deleteSelectedGenre")
	public String deleteSelectedBooks(
			@RequestParam(value = "selectedGenre", required = false) List<UUID> selectedGenreIds,
			RedirectAttributes redirectAttributes, Model model, HttpSession session) {
		for (UUID genreId : selectedGenreIds) {
			try {
				Genre g = new Genre(genreId, null);
				int quantity = genreService.counBookByGenreId(g);

				if (quantity > 0) {
					redirectAttributes.addFlashAttribute("deleteGenreError", true);
					return "redirect:/Manage-Genre";
				} else {
					genreService.delete(g);
				}
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			}
		}
		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {
			List<Genre> listGenre = genreService.findByName(findKey);
			session.setAttribute("listGenreSearchResult", listGenre);
			return "redirect:/Manage-FindGenre";
		}
		return "redirect:/Manage-Genre";
	}

	@GetMapping("Manage-Genre/find")
	public String viewFindList(@RequestParam("findKey") String findKey, HttpSession session) {
		List<Genre> listGenre = genreService.findByName(findKey);
		session.setAttribute("listGenreSearchResult", listGenre);
		if (listGenre.isEmpty()) {
			session.setAttribute("showNotFoundGenre", true);
		}
		session.setAttribute("findKey", findKey);
		return "redirect:/Manage-FindGenre";
	}

}
