package fa.mockproject.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import fa.mockproject.dao.DiscountDAO;
import fa.mockproject.model.Discount;

@Service
public class DiscountService implements ServiceInterface<Discount>{

	@Autowired
	DiscountDAO discountDao;
	@Override
	public int insert(Discount t) {
		return discountDao.insert(t);
	}

	@Override
	public int update(Discount t) {
		return discountDao.update(t);
	}

	@Override
	public int delete(Discount t) {
		return discountDao.delete(t);
	}

	@Override
	public ArrayList<Discount> findAll() {
		return discountDao.findAll();
	}

	@Override
	public Discount findById(Discount t) {
		return discountDao.findById(t);
	}
	
	public ArrayList<Discount> findByName(String name){
		return discountDao.findByName(name);
	}

}
