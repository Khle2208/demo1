package fa.mockproject.service;

import java.util.ArrayList;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import fa.mockproject.dao.WritedByDAO;
import fa.mockproject.model.Author;
import fa.mockproject.model.Book;
import fa.mockproject.model.WritedBy;

@Service
public class WritedByService implements ServiceInterface<WritedBy>{

	@Autowired
	WritedByDAO writedByDao;

	@Override
	public int insert(WritedBy t) {
		return writedByDao.insert(t);
	}

	@Override
	public int update(WritedBy t) {
		return writedByDao.update(t);
	}

	@Override
	public int delete(WritedBy t) {
		return writedByDao.delete(t);
	}

	@Override
	public ArrayList<WritedBy> findAll() {
		return writedByDao.findAll();
	}

	@Override
	public WritedBy findById(WritedBy t) {
		return writedByDao.findById(t);
	}
	
	public int insert1(Author author, Book book) {
		return writedByDao.insert1(author, book);
	}
	
	public ArrayList<WritedBy> findByAuthorId(UUID authorId){
		return writedByDao.findByAuthorId(authorId);
	}
	
	public ArrayList<WritedBy> findByBookId(UUID bookId){
		return writedByDao.findByBookId(bookId);
	}
	
	public int deleteByBookId(UUID bookId) {
		return writedByDao.deleteByBookId(bookId);
	}
	
	
}
