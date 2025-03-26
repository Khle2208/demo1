package fa.mockproject.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import fa.mockproject.dao.HasDiscountDAO;
import fa.mockproject.model.HasDiscount;

@Service
public class HasDiscountService implements ServiceInterface<HasDiscount> {
	@Autowired
	HasDiscountDAO hasDiscountDao;

	@Override
	public int insert(HasDiscount t) {
		return hasDiscountDao.insert(t);
	}

	@Override
	public int update(HasDiscount t) {
		return hasDiscountDao.update(t);
	}

	@Override
	public int delete(HasDiscount t) {
		return hasDiscountDao.delete(t);
	}

	@Override
	public ArrayList<HasDiscount> findAll() {
		return hasDiscountDao.findAll();
	}

	@Override
	public HasDiscount findById(HasDiscount t) {
		return hasDiscountDao.findById(t);
	}
	
	
}
