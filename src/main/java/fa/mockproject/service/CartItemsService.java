package fa.mockproject.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import fa.mockproject.dao.CartItemDAO;
import fa.mockproject.model.CartItems;

 @Service
public class CartItemsService implements ServiceInterface<CartItems> {

	@Autowired
	CartItemDAO cartItemsDao;

	@Override
	public int insert(CartItems t) {
		return cartItemsDao.insert(t);
	}

	@Override
	public int update(CartItems t) {
		return cartItemsDao.update(t);
	}

	@Override
	public int delete(CartItems t) {
		return cartItemsDao.delete(t);
	}

	@Override
	public ArrayList<CartItems> findAll() {
		return cartItemsDao.findAll();
	}

	@Override
	public CartItems findById(CartItems t) {
		return cartItemsDao.findById(t);
	}
	
	
}
