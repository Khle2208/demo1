
package fa.mockproject.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
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
import fa.mockproject.model.Discount;
import fa.mockproject.service.DiscountService;

@Controller
public class ManageDiscountController {
	@Autowired
	DiscountService discountService;

	public void setUpModel(Model model, HttpSession session) {
		if (!model.containsAttribute("discount")) {
			model.addAttribute("discount", new Discount());
		}

		@SuppressWarnings("unchecked")
		List<Discount> listDiscount = (List<Discount>) session.getAttribute("listDiscountSearchResult");
		if (listDiscount == null) {
			// Nếu không có thì lấy danh sách ban đầu từ cơ sở dữ liệu
			listDiscount = discountService.findAll();
		}

		List<Discount> listDiscountUnavailable = new ArrayList<Discount>();
		for (Discount discount : listDiscount) {
			if (discount.getQuantity() <= 0 || discount.getOutDate().isBefore(LocalDate.now())) {
				listDiscountUnavailable.add(discount);
			}
		}

		List<Discount> listDiscountAvailable = new ArrayList<Discount>();
		for (Discount discount : listDiscount) {
			if (discount.getQuantity() > 0 && discount.getOutDate().isAfter(LocalDate.now())) {
				listDiscountAvailable.add(discount);
			}
		}

		Boolean showNotFoundDiscount = (Boolean) session.getAttribute("showlistDiscountStatus");
		if (listDiscountAvailable.isEmpty() && Boolean.FALSE.equals(showNotFoundDiscount)) {
			session.setAttribute("showNotFoundDiscount", true);
		}
		if (listDiscountUnavailable.isEmpty() && Boolean.TRUE.equals(showNotFoundDiscount)) {
			session.setAttribute("showNotFoundDiscount", true);
		}

		if (!model.containsAttribute("discountUpdate")) {
			model.addAttribute("discountUpdate", new Discount());
		}
		model.addAttribute("actionUrl", "Manage-Discount");
		model.addAttribute("listDiscountUnavailable", listDiscountUnavailable);
		model.addAttribute("listDiscountAvailable", listDiscountAvailable);
		model.addAttribute("listDiscount", listDiscount);
	}

	@GetMapping("Manage-Discount")
	public String viewManageDiscount(Model model, HttpSession session) {
		session.removeAttribute("filterDiscount");
		session.removeAttribute("showNotFoundDiscount");
		session.removeAttribute("showlistDiscountStatus");
		session.removeAttribute("listDiscountSearchResult");
		session.removeAttribute("findKey");
		setUpModel(model, session);
		return "content/ManageDiscount";
	}

	@GetMapping("/Manage-FindDiscount")
	public String viewManageFindDiscount(Model model, HttpSession session) {
		Boolean checkListStatus = (Boolean) session.getAttribute("showlistDiscountStatus");
		if (Boolean.TRUE.equals(checkListStatus)) {
			return "redirect:/Unavailable-Discount";
		}
		if (Boolean.FALSE.equals(checkListStatus)) {
			return "redirect:/Available-Discount";
		}
		setUpModel(model, session);
		return "content/ManageDiscount";
	}

	@PostMapping("Add-Discount")
	public String addDiscount(@ModelAttribute("discount") @Valid Discount d, BindingResult bindingResult, Model model,
			HttpSession session) {
		if (bindingResult.hasErrors()) {
			model.addAttribute("showAddDiscountModal", true);
			setUpModel(model, session);
			return "content/ManageDiscount";
		}
		discountService.insert(d);
		return "redirect:/Manage-Discount";
	}

	@GetMapping("Delete-Discount/{discountId}")
	public String deleteDiscount(@PathVariable("discountId") UUID discountId, RedirectAttributes redirectAttributes,
			HttpSession session) {
		Discount d = new Discount(discountId, null, null, 0, null);
		discountService.delete(d);

		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {
			List<Discount> listDiscount = discountService.findByName(findKey);
			session.setAttribute("listDiscountSearchResult", listDiscount);
			return "redirect:/Manage-FindDiscount";
		}
		return "redirect:/Manage-Discount";
	}

	@PostMapping("/deleteSelectedDiscount")
	public String deleteSelectedBooks(
			@RequestParam(value = "selectedDiscount", required = false) List<UUID> selectedDiscountIds,
			HttpSession session) {
		for (UUID discountId : selectedDiscountIds) {
			Discount d = new Discount(discountId, null, null, 0, null);
			discountService.delete(d);
		}
		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {
			List<Discount> listDiscount = discountService.findByName(findKey);
			session.setAttribute("listDiscountSearchResult", listDiscount);
			return "redirect:/Manage-FindDiscount";
		}
		return "redirect:/Manage-Discount";
	}

	@GetMapping("Unavailable-Discount")
	public String viewUnavailableDiscount(Model model, HttpSession session) {
		session.removeAttribute("listDiscountSearchResult");
		session.removeAttribute("findKey");
		session.setAttribute("showlistDiscountStatus", true);
		session.setAttribute("filterDiscount", true);
		setUpModel(model, session);
		return "content/ManageDiscount";
	}

	@GetMapping("Available-Discount")
	public String viewAvailableDiscount(Model model, HttpSession session) {
		session.removeAttribute("listDiscountSearchResult");
		session.removeAttribute("findKey");
		session.setAttribute("showlistDiscountStatus", false);
		session.setAttribute("showNotFoundBook", true);
		session.setAttribute("filterDiscount", true);
		setUpModel(model, session);
		return "content/ManageDiscount";
	}

	@GetMapping("Detail-Discount/{discountId}")
	public String detailGenre(@PathVariable("discountId") UUID discountId, Model model,
			RedirectAttributes redirectAttributes, HttpSession session) {
		Discount d = new Discount(discountId, null, null, 0, null);
		Discount discountUpdate = discountService.findById(d);
		redirectAttributes.addFlashAttribute("discountUpdate", discountUpdate);
		redirectAttributes.addFlashAttribute("showUpdateModal", true);
		Boolean checkListStatus = (Boolean) session.getAttribute("showlistDiscountStatus");
		if (Boolean.TRUE.equals(checkListStatus)) {
			return "redirect:/Unavailable-Discount";
		} else if (Boolean.FALSE.equals(checkListStatus)) {
			return "redirect:/Available-Discount";
		}
		setUpModel(model, session);
		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {
			return "redirect:/Manage-FindDiscount";
		}
		return "redirect:/Manage-Discount";
	}

	@PostMapping("Update-Discount")
	public String updateGenre(@ModelAttribute("discountUpdate") @Valid Discount d, BindingResult bindingResult,
			HttpSession session, Model model, @RequestParam(name = "option", defaultValue = "none") String option,
			@RequestParam(name = "quantityUpdate") int quantityUpdate) {

		if (bindingResult.hasErrors()) {
			model.addAttribute("showUpdateModal", true);
			setUpModel(model, session);
			return "content/ManageDiscount";
		}
		if (option.equals("increase")) {
			d.setQuantity(d.getQuantity() + quantityUpdate);
		} else {
			if (d.getQuantity() - quantityUpdate < 0) {
				d.setQuantity(0);
			} else {
				d.setQuantity(d.getQuantity() - quantityUpdate);
			}
		}
		discountService.update(d);

		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {
			List<Discount> listDiscount = discountService.findByName(findKey);
			session.setAttribute("listDiscountSearchResult", listDiscount);
			return "redirect:/Manage-FindDiscount";
		}
		return "redirect:Manage-Discount";
	}

	@GetMapping("Manage-Discount/find")
	public String viewFindList(@RequestParam("findKey") String findKey, HttpSession session) {
		List<Discount> listDiscount = discountService.findByName(findKey);
		session.setAttribute("listDiscountSearchResult", listDiscount);
		if (listDiscount.isEmpty()) {
			session.setAttribute("showNotFoundDiscount", true);
		}
		session.setAttribute("findKey", findKey);
		return "redirect:/Manage-FindDiscount";
	}
}
