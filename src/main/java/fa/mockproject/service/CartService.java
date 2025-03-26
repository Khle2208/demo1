package fa.mockproject.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import fa.mockproject.dao.CartDAO;
import fa.mockproject.model.Cart;

@Service
public class CartService implements ServiceInterface<Cart>{
	
	@Autowired
	CartDAO cartDao;
	@Override
	public int insert(Cart t) {
		return cartDao.insert(t);
	}

	@Override
	public int update(Cart t) {
		return cartDao.update(t);
	}

	@Override
	public int delete(Cart t) {
		return cartDao.delete(t);
	}

	@Override
	public ArrayList<Cart> findAll() {
		return cartDao.findAll();
	}

	@Override
	public Cart findById(Cart t) {
		return cartDao.findById(t);
	}
	
}
