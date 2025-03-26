package fa.mockproject.service;

import java.util.ArrayList;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import fa.mockproject.dao.AddressDAO;

import fa.mockproject.model.Address;

@Service
public class AddressService implements ServiceInterface<Address>{
	@Autowired
	AddressDAO addressDao;

	@Override
	public int insert(Address t) {
		return addressDao.insert(t);
	}

	@Override
	public int update(Address t) {
		return addressDao.update(t);
	}

	@Override
	public int delete(Address t) {
		return addressDao.delete(t);
	}

	@Override
	public ArrayList<Address> findAll() {
		return addressDao.findAll();
	}

	@Override
	public Address findById(Address t) {
		return addressDao.findById(t);
	}
	
	public Address findById(UUID addressId) {
		return addressDao.findById(addressId);
	}
	
}
