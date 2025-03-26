package fa.mockproject.service;

import java.util.ArrayList;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import fa.mockproject.dao.RatingsDAO;
import fa.mockproject.model.Ratings;

@Service
public class RatingsService implements ServiceInterface<Ratings>{

	@Autowired
	RatingsDAO ratingDao;

	@Override
	public int insert(Ratings t) {
		return ratingDao.insert(t);
	}

	@Override
	public int update(Ratings t) {
		return ratingDao.update(t);
	}

	@Override
	public int delete(Ratings t) {
		return ratingDao.delete(t);
	}

	@Override
	public ArrayList<Ratings> findAll() {
		return ratingDao.findAll();
	}

	@Override
	public Ratings findById(Ratings t) {
		return ratingDao.findById(t);
	}
	
	
	public int countRatingsByUserId(UUID userId) {
		return ratingDao.countRatingsByUserId(userId);
	}
	
}
