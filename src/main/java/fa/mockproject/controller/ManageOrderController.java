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

import fa.mockproject.model.Address;
import fa.mockproject.model.Order;
import fa.mockproject.model.OrderDetail;
import fa.mockproject.model.Payment;
import fa.mockproject.model.User;
import fa.mockproject.service.AddressService;
import fa.mockproject.service.OrderDetailService;
import fa.mockproject.service.OrderService;
import fa.mockproject.service.PaymentService;
import fa.mockproject.service.UserService;

@Controller
public class ManageOrderController {
	@Autowired
	OrderService orderService;
	@Autowired
	OrderDetailService orderDetailService;
	@Autowired
	AddressService addressService;
	@Autowired 
	PaymentService paymentService;
	@Autowired
	UserService userService;

	public void setUpModel(Model model, HttpSession session) {
		String findKey = (String) session.getAttribute("findKey");

		if (findKey != null) {
			@SuppressWarnings("unchecked")
			List<Order> listOrder = (List<Order>) session.getAttribute("listOrderSearchResult");
			if (listOrder == null) {
				listOrder = orderService.findAll();
			}
			model.addAttribute("listOrder", listOrder);
		} else {
			Boolean filterOrder = (Boolean) session.getAttribute("filterOrder");
			@SuppressWarnings("unchecked")
			List<Order> listOrder = (List<Order>) session.getAttribute("listOrderFilterResult");
			if (listOrder == null && filterOrder == null) {
				listOrder = orderService.findAll();
			}
			model.addAttribute("listOrder", listOrder);
		}
		if (!model.containsAttribute("orderUpdate")) {
			model.addAttribute("orderUpdate", new Order());
		}
		if (!model.containsAttribute("orderDetail")) {
			model.addAttribute("orderDetail", new Order());
		}
		if (!model.containsAttribute("listOrderDetail")) {
			model.addAttribute("listOrderDetail", new ArrayList<OrderDetail>());
		}

		model.addAttribute("actionUrl", "Manage-Order");
	}

	@GetMapping("/Manage-Order")
	public String viewManageOrder(Model model, HttpSession session) {
		session.removeAttribute("status");
		session.removeAttribute("startDate");
		session.removeAttribute("endDate");
		session.removeAttribute("filterOrder");
		session.removeAttribute("showNotFoundOrder");
		session.removeAttribute("message");
		session.removeAttribute("showFilterError");
		session.removeAttribute("listOrderFilterResult");
		session.removeAttribute("listBookSearchResult");
		session.removeAttribute("findKey");
		setUpModel(model, session);
		return "content/ManageOrder";
	}

	@GetMapping("Manage-FindOrder")
	public String viewManageFindOrder(Model model, HttpSession session) {
		Boolean filterOrder = (Boolean) session.getAttribute("filterOrder");

		if (filterOrder != null) {
			setUpModel(model, session);
			return "content/ManageOrder";
		}
		return "redirect:/Manage-Order";

	}

	@GetMapping("View-Order/{orderId}")
	public String viewDetailOrder(Model model, HttpSession session, RedirectAttributes redirectAttributes,
			@PathVariable("orderId") UUID orderId) {
		Order o = new Order(orderId, orderId, null, null, null, null, null);
		Order orderDetail = orderService.findById(o);

		List<OrderDetail> listOrderDetail = orderDetailService.findByOrderId(o);
		User u = new User(orderDetail.getUserId(), null, null, null, null, null, null, null, null, null, null, 0, null);
		User userOrder = userService.findById(u);
		Payment p = paymentService.getPaymentByOrderID(orderDetail.getOrderId());
		Address addressOrderDetail = addressService.findById(p.getAddressId());
		Boolean filterOrder = (Boolean) session.getAttribute("filterOrder");
		if (filterOrder != null) {
			model.addAttribute("listOrderDetail", listOrderDetail);
			model.addAttribute("addressOrderDetail", addressOrderDetail);
			model.addAttribute("userOrder", userOrder);
			model.addAttribute("orderDetail", orderDetail);
			model.addAttribute("showViewModal", true);
			setUpModel(model, session);
			return "content/ManageOrder";
		}
		redirectAttributes.addFlashAttribute("listOrderDetail", listOrderDetail);
		redirectAttributes.addFlashAttribute("addressOrderDetail", addressOrderDetail);
		redirectAttributes.addFlashAttribute("userOrder", userOrder);
		redirectAttributes.addFlashAttribute("orderDetail", orderDetail);
		redirectAttributes.addFlashAttribute("showViewModal", true);
		return "redirect:/Manage-Order";
	}

	@PostMapping("Filter-Order")
	public String FilterOrder(@RequestParam("startDate") String startDate, @RequestParam("endDate") String endDate,
			@RequestParam("mySelect") String status, HttpSession session) {
		List<Order> listFilterOrder = new ArrayList<Order>();
		if (!startDate.isEmpty() && !endDate.isEmpty()) {
			LocalDate start = LocalDate.parse(startDate);
			LocalDate end = LocalDate.parse(endDate);
			if (start.isAfter(end)) {
				listFilterOrder = orderService.findAll();
				session.setAttribute("startDate", startDate);
				session.setAttribute("endDate", endDate);
				session.setAttribute("message", "Ngày bắt đầu phải trước ngày kết thúc đã chọn");
				session.setAttribute("showFilterError", true);
			} else if (start.isAfter(LocalDate.now())) {
				listFilterOrder = orderService.findAll();
				session.setAttribute("startDate", startDate);
				session.setAttribute("message", "Ngày bắt đầu không thể là ngày trong tương lai");
				session.setAttribute("showFilterError", true);
			} else if (status.equals("All")) {
				listFilterOrder = orderService.filterByDate(startDate, endDate);
				session.setAttribute("startDate", startDate);
				session.setAttribute("endDate", endDate);
			} else {
				listFilterOrder = orderService.filterAll(startDate, endDate, status);
				session.setAttribute("status", status);
				session.setAttribute("startDate", startDate);
				session.setAttribute("endDate", endDate);
			}
		} else if (!startDate.isEmpty() && endDate.isEmpty()) {
			listFilterOrder = orderService.findAll();
			session.setAttribute("startDate", startDate);
			session.setAttribute("message", "Vui lòng nhập ngày kết thúc");
			session.setAttribute("showFilterError", true);
		} else if (!endDate.isEmpty() && startDate.isEmpty()) {
			listFilterOrder = orderService.findAll();
			session.setAttribute("endDate", endDate);
			session.setAttribute("message", "Vui lòng nhập ngày bắt đầu");
			session.setAttribute("showFilterError", true);
		} else if (startDate.isEmpty() && endDate.isEmpty() && status.equals("All")) {
			return "redirect:/Manage-Order";
		} else {
			listFilterOrder = orderService.filterByStatus(status);
			session.setAttribute("status", status);
		}
		if (listFilterOrder.isEmpty()) {
			session.setAttribute("showNotFoundOrder", true);
		}
		session.setAttribute("listOrderFilterResult", listFilterOrder);
		session.setAttribute("filterOrder", true);
		return "redirect:/Manage-FindOrder";
	}

	@GetMapping("Manage-Order/find")
	public String viewFindList(@RequestParam("findKey") String findKey, HttpSession session) {
		List<Order> listOrder = orderService.findByEmail(findKey);
		session.setAttribute("listOrderSearchResult", listOrder);
		if (listOrder.isEmpty()) {
			session.setAttribute("showNotFoundOrder", true);
		}
		session.setAttribute("findKey", findKey);
		session.setAttribute("filterOrder", false);
		return "redirect:/Manage-FindOrder";
	}
	
	@GetMapping("Detail-Order/{orderId}")
	public String detailGenre(@PathVariable("orderId") UUID orderId, Model model, RedirectAttributes redirectAttributes,HttpSession session) {
		Order o = new Order(orderId, orderId, null, null, null, null, null);
		Order orderUpdate = orderService.findById(o);
		Boolean filterOrder = (Boolean) session.getAttribute("filterOrder");
		if (filterOrder != null) {
			model.addAttribute("orderUpdate", orderUpdate);
			model.addAttribute("showUpdateModal", true);
			setUpModel(model, session);
			return "content/ManageOrder";
		}
		redirectAttributes.addFlashAttribute("orderUpdate", orderUpdate);
		redirectAttributes.addFlashAttribute("showUpdateModal", true);
		return "redirect:/Manage-Order";
	}
	
	@PostMapping("Update-Order")
	public String updateGenre(@ModelAttribute("genreOrder") @Valid Order o, BindingResult bindingResult,
			HttpSession session, Model model, @RequestParam("mySelectUpdate") String status) {
		if (bindingResult.hasErrors()) {
			model.addAttribute("showUpdateModal", true);
			setUpModel(model, session);
			return "content/ManageOrder";
		}
		o.setStatus(status);
		orderService.update(o);
		String findKey = (String) session.getAttribute("findKey");
		if (findKey != null && !findKey.isEmpty()) {
			List<Order> listOrder = orderService.findByEmail(findKey);
			session.setAttribute("listOrderSearchResult", listOrder); 
		}
		else {
			session.removeAttribute("listOrderSearchResult");
		}

		return "redirect:/Manage-Order";
	}

}
