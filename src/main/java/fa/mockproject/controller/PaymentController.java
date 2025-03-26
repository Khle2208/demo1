package fa.mockproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PaymentController {
	@GetMapping("Payment")
	public String viewPayment() {
		return "content/payment";
	}
}
