package fa.mockproject.service;

import java.util.ArrayList;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import fa.mockproject.dao.PaymentDAO;
import fa.mockproject.model.Payment;

@Service
public class PaymentService implements ServiceInterface<Payment>{

	@Autowired
	PaymentDAO paymetnDao;

	@Override
	public int insert(Payment t) {
		return paymetnDao.insert(t);
	}

	@Override
	public int update(Payment t) {
		return paymetnDao.update(t);
	}

	@Override
	public int delete(Payment t) {
		return paymetnDao.delete(t);
	}

	@Override
	public ArrayList<Payment> findAll() {
		return paymetnDao.findAll();
	}

	@Override
	public Payment findById(Payment t) {
		return paymetnDao.findById(t);
	}
	public Payment getPaymentByOrderID(UUID orderId) {
		return paymetnDao.getPaymentByOrderID(orderId);
	}
	
}
