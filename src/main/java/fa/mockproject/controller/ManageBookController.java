package fa.mockproject.controller;

import org.springframework.http.MediaType;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BeanPropertyBindingResult;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import fa.mockproject.model.Author;
import fa.mockproject.model.Book;
import fa.mockproject.model.BookImage;
import fa.mockproject.model.Genre;
import fa.mockproject.model.WritedBy;
import fa.mockproject.service.AuthorService;
import fa.mockproject.service.BookImageService;
import fa.mockproject.service.BookService;
import fa.mockproject.service.GenreService;
import fa.mockproject.service.WritedByService;

@Controller
public class ManageBookController {
	@Autowired
	BookService bookService;

	@Autowired
	GenreService genreService;

	@Autowired
	BookImageService bookImageService;

	@Autowired
	AuthorService authorService;

	@Autowired
	WritedByService writedByService;

	public void setUpModel(Model model, HttpSession session) {
		Map<UUID, String> genreMap = new HashMap<UUID, String>();
		List<Genre> listGenre = genreService.findAll();
		@SuppressWarnings("unchecked")
		List<Book> listBook = (List<Book>) session.getAttribute("listBookSearchResult");
		if (listBook == null) {
			// Nếu không có thì lấy danh sách ban đầu từ cơ sở dữ liệu
			listBook = bookService.findAll();
		}
		for (Genre genre : listGenre) {
			genreMap.put(genre.getGenreId(), genre.getGenreName());
		}
		if (!model.containsAttribute("bookUpdate")) {
			model.addAttribute("bookUpdate", new Book());
		}

		if (!model.containsAttribute("listBookImage")) {
			List<BookImage> listBookImage = new ArrayList<BookImage>();
			model.addAttribute("listBookImage", listBookImage);
		}
		if (!model.containsAttribute("book")) {
			model.addAttribute("book", new Book());
		}

		if (!model.containsAttribute("listAuthorDetails")) {
			model.addAttribute("listAuthorDetails", new ArrayList<Author>());
		}
		List<Book> listBookUnavailable = new ArrayList<Book>();
		for (Book book : listBook) {
			if (book.getQuantity() == 0) {
				listBookUnavailable.add(book);
			}
		}

		List<Book> listBookAvailable = new ArrayList<Book>();
		for (Book book : listBook) {
			if (book.getQuantity() > 0) {
				listBookAvailable.add(book);
			}
		}
		Boolean showNotFoundBook = (Boolean) session.getAttribute("showlistBookStatus");
		if (listBookAvailable.isEmpty() && Boolean.FALSE.equals(showNotFoundBook)) {
			session.setAttribute("showNotFoundBook", true);
		}
		if (listBookUnavailable.isEmpty() && Boolean.TRUE.equals(showNotFoundBook)) {
			session.setAttribute("showNotFoundBook", true);
		}

		model.addAttribute("listBook", listBook);
		model.addAttribute("actionUrl", "Manage-Book");
		model.addAttribute("listBookUnavailable", listBookUnavailable);
		model.addAttribute("listBookAvailable", listBookAvailable);
		model.addAttribute("genreMap", genreMap);
	}

	@GetMapping("/Manage-Book")
	public String viewManageBook(Model model, HttpSession session) {
		session.removeAttribute("imageAdd");
		session.removeAttribute("showNotFoundBook");
		session.removeAttribute("showlistBookStatus");
		session.removeAttribute("listBookSearchResult");
		session.removeAttribute("findKey");
		session.removeAttribute("filterBook");
		setUpModel(model, session);
		return "content/ManageBook";
	}

	@GetMapping("/Manage-FindBook")
	public String viewManageFindBook(Model model, HttpSession session) {
		Boolean checkListStatus = (Boolean) session.getAttribute("showlistBookStatus");
		if (Boolean.TRUE.equals(checkListStatus)) {
			return "redirect:/Unavailable-Book";
		}
		if (Boolean.FALSE.equals(checkListStatus)) {
			return "redirect:/Available-Book";
		}
		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {
			setUpModel(model, session);
			return "content/ManageBook";
		}
		return "redirect:Manage-Book";
	}

	@GetMapping(value = "/book/image/{bookId}", produces = MediaType.IMAGE_PNG_VALUE)
	public @ResponseBody byte[] getImage(@PathVariable("bookId") UUID bookId) {
		Book b = new Book(bookId, null, null, 0, null, null, null, 0, null, null, bookId);
		Book book = bookService.findById(b);
		if (book == null || book.getAvatar() == null) {
			return new byte[0];
		}
		byte[] image = book.getAvatar();
		return image;
	}

	@GetMapping(value = "/book/imageDetail/{bookImageId}", produces = MediaType.IMAGE_PNG_VALUE)
	public @ResponseBody byte[] getImageDetail(@PathVariable("bookImageId") UUID bookId,
			@RequestParam(name = "bookImageId") UUID bookImageId) {
		BookImage bi = new BookImage(bookImageId, bookId, null, null);
		BookImage bir = bookImageService.findById(bi);
		byte[] image = bir.getImageData();
		return image;
	}

	@GetMapping("Delete-Book/{bookId}")
	public String deleteBook(@PathVariable("bookId") UUID bookId, HttpSession session) {
		Book b = new Book(bookId, null, null, 0, null, null, null, 0, null, null, bookId);
		Book book = bookService.findById(b);
		bookService.delete(book);
		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {
			List<Book> listBook = bookService.findByName(findKey);
			session.setAttribute("listBookSearchResult", listBook);
			return "redirect:/Manage-FindBook";
		}
		return "redirect:/Manage-Book";
	}

	@GetMapping("Delete-BookImage/{bookImageId}")
	public String deleteBookImage(@PathVariable("bookImageId") String bookIdStr,
			@RequestParam(name = "bookImageId") String bookImageIdStr, RedirectAttributes redirectAttributes,
			HttpSession session) {
		UUID bookImageId = UUID.fromString(bookImageIdStr);
		UUID bookId = UUID.fromString(bookIdStr);
		Book b = new Book(bookId, null, null, 0, null, null, null, 0, null, null, bookId);
		BookImage bi = new BookImage(bookImageId, bookId, null, null);
		BookImage bir = bookImageService.findById(bi);
		bookImageService.delete(bir);
		List<BookImage> listBookImage = bookImageService.findByBookId(b);
		redirectAttributes.addFlashAttribute("bookUpdateImage", b);
		redirectAttributes.addFlashAttribute("listBookImage", listBookImage);
		redirectAttributes.addFlashAttribute("showViewBookImageModal", true);
		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {
			return "redirect:/Manage-FindBook";
		}
		return "redirect:/Manage-Book";
	}

	@PostMapping("Add-Book")
	public String addBook(HttpServletRequest req, @ModelAttribute("book") @Valid Book b, BindingResult bindingResult,
			Model model, @RequestParam(value = "image", required = false) MultipartFile image,
			@RequestParam(value = "images", required = false) MultipartFile[] images, HttpSession session,
			@RequestParam(value = "listAuthor[]") String[] listAuthor) {
		if ((image == null || image.isEmpty()) && bindingResult.hasFieldErrors("avatar")) {
			boolean onlyAvatarErrors = true;
			for (FieldError error : bindingResult.getFieldErrors()) {
				if (!"avatar".equals(error.getField())) {
					onlyAvatarErrors = false;
					break;
				}
			}
			if (onlyAvatarErrors) {
				bindingResult = new BeanPropertyBindingResult(b, "book");
			}
		}

		if (bindingResult.hasErrors()) {
			model.addAttribute("showAddBookModal", true);
			setUpModel(model, session);
			return "content/ManageBook";
		}

		int quantity = Integer.valueOf(b.getQuantity());
		if (quantity > 1000 || bindingResult.hasFieldErrors("quantity")) {
			bindingResult.rejectValue("quantity", "Max.book.quantity");
			return "errorPage";
		}

		try {
			if (image != null && !image.isEmpty()) {
				b.setAvatar(image.getBytes());
			}

			while (true) {
				b.setBookId(UUID.randomUUID());
				Book check = bookService.findById(b);
				if (check == null) {
					break;
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
			req.setAttribute("message", "Lỗi khi xử lý file ảnh!");
			return "content/ManageBook";
		}

		// Lưu sách
		bookService.insert(b);

		for (String authorName : listAuthor) {
			Author a = authorService.findByFullName(authorName);
			if (a == null) {
				a = new Author(null, authorName, null);
				authorService.insert(a);
			}
			writedByService.insert1(a, b);
		}

		// Xử lý ảnh mô tả (nhiều file)
		try {
			if (images != null) {
				int i = 0;
				for (MultipartFile multipartFile : images) {
					if (!multipartFile.isEmpty()) { // Kiểm tra xem file có được chọn hay không
						BookImage bi = new BookImage(null, b.getBookId(), "Ảnh " + ++i, multipartFile.getBytes());
						bookImageService.insert(bi);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:Manage-Book";
	}

	@PostMapping("/deleteSelectedBooks")
	public String deleteSelectedBooks(
			@RequestParam(value = "selectedBooks", required = false) List<UUID> selectedBookIds,
			RedirectAttributes redirectAttributes, HttpSession session) {

		for (UUID bookId : selectedBookIds) {
			try {
				Book b = new Book(bookId, null, null, 0, null, null, null, 0, null, null, bookId);
				bookService.delete(b);
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			}
		}

		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {
			List<Book> listBook = bookService.findByName(findKey);
			session.setAttribute("listBookSearchResult", listBook);
			return "redirect:/Manage-FindBook";
		}
		return "redirect:/Manage-Book";
	}

	@GetMapping("Detail-Book/{bookId}")
	public String detailGenre(@PathVariable("bookId") UUID bookId, Model model, RedirectAttributes redirectAttributes,
			HttpSession session) {
		Book b = new Book(bookId, null, null, 0, null, null, null, 0, null, null, bookId);
		Book bookUpdate = bookService.findById(b);
		redirectAttributes.addFlashAttribute("bookUpdate", bookUpdate);
		redirectAttributes.addFlashAttribute("showUpdateModal", true);
		Boolean checkListStatus = (Boolean) session.getAttribute("showlistBookStatus");
		if (Boolean.TRUE.equals(checkListStatus)) {
			return "redirect:/Unavailable-Book";
		}
		if (Boolean.FALSE.equals(checkListStatus)) {
			return "redirect:/Available-Book";
		}
		List<Author> listAuthorDetail = new ArrayList<Author>();

		List<WritedBy> listWrited = writedByService.findByBookId(bookUpdate.getBookId());
		for (WritedBy writedBy : listWrited) {
			Author a = authorService.findById(writedBy.getAuthorId());
			listAuthorDetail.add(a);
		}
		redirectAttributes.addFlashAttribute("listAuthorDetails", listAuthorDetail);
		setUpModel(model, session);
		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {
			return "redirect:/Manage-FindBook";
		}
		return "redirect:/Manage-Book";
	}

	@GetMapping("Book-Image/{bookId}")
	public String detailBookImage(@PathVariable("bookId") UUID bookId, Model model,
			RedirectAttributes redirectAttributes, HttpSession session) {
		Book b = new Book(bookId, null, null, 0, null, null, null, 0, null, null, bookId);
		List<BookImage> listBookImage = bookImageService.findByBookId(b);
		redirectAttributes.addFlashAttribute("bookUpdateImage", b);
		redirectAttributes.addFlashAttribute("listBookImage", listBookImage);
		redirectAttributes.addFlashAttribute("showViewBookImageModal", true);

		setUpModel(model, session);
		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {
			return "redirect:/Manage-FindBook";
		}

		return "redirect:/Manage-Book";
	}

	@PostMapping("Update-Book")
	public String updateBook(HttpServletRequest req, @ModelAttribute("bookUpdate") @Valid Book b,
			BindingResult bindingResult, @RequestParam("image") MultipartFile image, HttpSession session, Model model,
			@RequestParam(name = "option", defaultValue = "none") String option,
			@RequestParam(value = "listAuthorDetail[]") String[] listAuthor,
			@RequestParam(name = "quantityUpdate") int quantityUpdate) {
		if (bindingResult.hasErrors()) {
			model.addAttribute("showUpdateModal", true);
			setUpModel(model, session);
			return "content/ManageBook";
		}

		try {
			if (!image.isEmpty()) {
				b.setAvatar(image.getBytes());
			} else {
				Book currentBook = bookService.findById(b);
				b.setAvatar(currentBook.getAvatar());
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (option.equals("increase")) {
			b.setQuantity(b.getQuantity() + quantityUpdate);
		} else {
			if (b.getQuantity() - quantityUpdate < 0) {
				b.setQuantity(0);
			} else {
				b.setQuantity(b.getQuantity() - quantityUpdate);
			}
		}
		writedByService.deleteByBookId(b.getBookId());
		for (String authorName : listAuthor) {
			Author a = authorService.findByFullName(authorName);
			if (a == null) {
				a = new Author(null, authorName, null);
				authorService.insert(a);
			}
			writedByService.insert1(a, b);
		}
		bookService.update(b);

		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {
			List<Book> listBook = bookService.findByName(findKey);
			session.setAttribute("listBookSearchResult", listBook);
			return "redirect:/Manage-FindBook";
		}
		return "redirect:/Manage-Book";

	}

	@PostMapping("Update-BookImage")
	public String updateBookImage(HttpServletRequest req, @RequestParam("bookId") UUID bookId,
			@RequestParam("imagesUpdate") MultipartFile[] imagesUpdate, RedirectAttributes redirectAttributes,
			HttpSession session) {
		try {
			int i = 0;
			for (MultipartFile multipartFile : imagesUpdate) {
				if (!multipartFile.isEmpty()) {
					BookImage bi = new BookImage(null, bookId, "Ảnh " + ++i, multipartFile.getBytes());
					bookImageService.insert(bi);
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		Book b = new Book(bookId, null, null, 0, null, null, null, 0, null, null, bookId);
		List<BookImage> listBookImage = bookImageService.findByBookId(b);
		redirectAttributes.addFlashAttribute("bookUpdateImage", b);
		redirectAttributes.addFlashAttribute("listBookImage", listBookImage);
		redirectAttributes.addFlashAttribute("showViewBookImageModal", true);
		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {
			return "redirect:/Manage-FindBook";
		}
		return "redirect:/Manage-Book";
	}

	@GetMapping("View-Book/{bookId}")
	public String viewBook(@PathVariable("bookId") UUID bookId, Model model, HttpSession session) {
		Book b = new Book(bookId, null, null, 0, null, null, null, 0, null, null, bookId);
		Book bookView = bookService.findById(b);
		List<BookImage> listBookImageView = bookImageService.findByBookId(bookView);
		setUpModel(model, session);
		List<Author> listAuthorView = new ArrayList<Author>();

		List<WritedBy> listWrited = writedByService.findByBookId(bookView.getBookId());
		for (WritedBy writedBy : listWrited) {
			Author a = authorService.findById(writedBy.getAuthorId());
			listAuthorView.add(a);
		}
		model.addAttribute("listAuthorView", listAuthorView);
		model.addAttribute("bookView", bookView);
		model.addAttribute("listBookImageView", listBookImageView);
		model.addAttribute("showViewBookModal", true);
		return "content/ManageBook";
	}

	@GetMapping("Unavailable-Book")
	public String viewUnavailableBook(Model model, HttpSession session) {
		session.removeAttribute("listBookSearchResult");
		session.removeAttribute("findKey");
		session.setAttribute("showlistBookStatus", true);
		session.setAttribute("filterBook", true);
		setUpModel(model, session);
		return "content/ManageBook";
	}

	@GetMapping("Available-Book")
	public String viewAvailableBook(Model model, HttpSession session) {
		session.removeAttribute("listBookSearchResult");
		session.removeAttribute("findKey");
		session.setAttribute("showlistBookStatus", false);
		session.setAttribute("filterBook", true);
		setUpModel(model, session);
		return "content/ManageBook";
	}

	@GetMapping("Manage-Book/find")
	public String viewFindList(@RequestParam("findKey") String findKey, HttpSession session) {
		List<Book> listBook = bookService.findByName(findKey);
		session.setAttribute("listBookSearchResult", listBook);
		if (listBook.isEmpty()) {
			session.setAttribute("showNotFoundBook", true);
		}
		session.setAttribute("findKey", findKey);
		return "redirect:/Manage-FindBook";
	}
}
