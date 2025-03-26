package fa.mockproject.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import fa.mockproject.model.User;
import fa.mockproject.service.OrderService;
import fa.mockproject.service.RatingsService;
import fa.mockproject.service.UserService;

@Controller
public class ManageUserController {

	@Autowired
	UserService userService;
	@Autowired 
	OrderService orderService;
	
	@Autowired
	RatingsService ratingsService;

	public void setUpModel(Model model, HttpSession session) {
		@SuppressWarnings("unchecked")
		List<User> listUser = (List<User>) session.getAttribute("listUserSearchResult");
		if (listUser == null) {
			listUser = userService.findAll();
		}
		if (!model.containsAttribute("user")) {
			model.addAttribute("user", new User());
		}
		if (!model.containsAttribute("userDetail")) {
			model.addAttribute("userDetail", new User());
		}
		List<User> listUserLock = new ArrayList<User>();
		for (User user : listUser) {
			if (user.getStatus() == 0) {
				listUserLock.add(user);
			}
		}
		List<User> listUserOpen = new ArrayList<User>();
		for (User user : listUser) {
			if (user.getStatus() == 1) {
				listUserOpen.add(user);
			}
		}
		
		Boolean showNotFoundBook = (Boolean) session.getAttribute("showlistUserStatus");
		if (listUserOpen.isEmpty() && Boolean.FALSE.equals(showNotFoundBook)) {
			session.setAttribute("showNotFoundUser", true);
		}
		if (listUserLock.isEmpty() && Boolean.TRUE.equals(showNotFoundBook)) {
			session.setAttribute("showNotFoundUser", true);
		}
		model.addAttribute("listUserLock", listUserLock);
		model.addAttribute("listUserOpen", listUserOpen);
		model.addAttribute("actionUrl", "Manage-User");
		model.addAttribute("listUser", listUser);
	}

	@GetMapping("/Manage-User")
	public String viewMangeUser(Model model, HttpSession session) {
		session.removeAttribute("showlistUserStatus");
		session.removeAttribute("showNotFoundUser");
		session.removeAttribute("listUserSearchResult");
		session.removeAttribute("filterUser");
		session.removeAttribute("findKey");
		setUpModel(model, session);
		return "content/ManageUser";
	}

	@GetMapping("Manage-FindUser")
	public String viewMangeFindUser(Model model, HttpSession session) {
		Boolean checkListUnavailable = (Boolean) session.getAttribute("showlistUserLock");
		if (Boolean.TRUE.equals(checkListUnavailable)) {
			return "redirect:/Unavailable-User";
		}
		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {
			setUpModel(model, session);
			return "content/ManageUser";
		}
		return "redirect:Manage-User";
	}

	@GetMapping("Detail-User/{userId}")
	public String detailUser(@PathVariable("userId") UUID userId, Model model, RedirectAttributes redirectAttributes,
			HttpSession session) {
		User u = new User(userId, null, null, null, null, null, null, null, null, null, null, 0, null);
		User userDetail = userService.findById(u);
		int quantityOrder = orderService.countOrderByUserId(u.getUserId());
		int quantityRating = ratingsService.countRatingsByUserId(u.getUserId());
		redirectAttributes.addFlashAttribute("quantityOrder", quantityOrder);
		redirectAttributes.addFlashAttribute("quantityRating", quantityRating);
		redirectAttributes.addFlashAttribute("userDetail", userDetail);
		redirectAttributes.addFlashAttribute("showUpdateModal", true);
		Boolean checkListUnavailable = (Boolean) session.getAttribute("showlistUserLock");
		if (Boolean.TRUE.equals(checkListUnavailable)) {
			return "redirect:/Unavailable-User";
		}
		setUpModel(model, session);
		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {
			return "redirect:/Manage-FindUser";
		}
		return "redirect:/Manage-User";

	}

	@GetMapping("Status-User/{userId}")
	public String setStatus(@PathVariable("userId") UUID userId, Model model, @RequestParam("status") int status,
			HttpSession session) {
		User u = new User(userId, null, null, null, null, null, null, null, null, null, null, status, null);
		userService.setStatusUser(u);
		Boolean checkListUnavailable = (Boolean) session.getAttribute("showlistUserLock");
		if (Boolean.TRUE.equals(checkListUnavailable)) {
			return "redirect:/Unavailable-User";
		}
		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {
			List<User> listUser = userService.findByName(findKey);
			session.setAttribute("listUserSearchResult", listUser);
			return "redirect:/Manage-FindUser";
		}
		return "redirect:/Manage-User";

	}

	@PostMapping("/setStatusSelectedUser")
	public String deleteSelectedBooks(
			@RequestParam(value = "selectedUser", required = false) List<UUID> selectedUserIds, @RequestParam("action") String action,
			RedirectAttributes redirectAttributes, Model model, HttpSession session) {
		if (action.equals("lock")) {			
			for (UUID userId : selectedUserIds) {
				User u = new User(userId, null, null, null, null, null, null, null, null, null, null, 0, null);
				userService.setStatusUser(u);
			}
		} else {			
			for (UUID userId : selectedUserIds) {
				User u = new User(userId, null, null, null, null, null, null, null, null, null, null, 1, null);
				userService.setStatusUser(u);
			}
		}
		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {
			List<User> listUser = userService.findByName(findKey);
			session.setAttribute("listUserSearchResult", listUser);
			return "redirect:/Manage-FindUser";
		}
		return "redirect:/Manage-User";
	}

	@GetMapping("Manage-User/find")
	public String viewFindList(@RequestParam("findKey") String findKey, HttpSession session) {
		List<User> listUser = userService.findByName(findKey);
		session.setAttribute("listUserSearchResult", listUser);
		if (listUser.isEmpty()) {
			session.setAttribute("showNotFoundUser", true);
		}
		session.setAttribute("findKey", findKey);
		
		return "redirect:/Manage-FindUser";
	}

	@GetMapping("Unavailable-User")
	public String viewUnavailableUser(Model model, HttpSession session) {
		session.setAttribute("showlistUserStatus", true);
		session.setAttribute("filterUser", true);
		setUpModel(model, session);
		return "content/ManageUser";
	}
	
	@GetMapping("Available-User")
	public String viewAvailableUser(Model model, HttpSession session) {
		session.setAttribute("showlistUserStatus", false);
		session.setAttribute("filterUser", true);
		setUpModel(model, session);
		return "content/ManageUser";
	}
}
