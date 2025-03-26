package fa.mockproject.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import fa.mockproject.model.Author;
import fa.mockproject.model.Book;
import fa.mockproject.model.WritedBy;

@Repository
public class WritedByDAO implements DAOInterface<WritedBy> {

	@Autowired
	JdbcTemplate jdbcTemplate;

	@Override
	public int insert(WritedBy t) {
		try {
			String sql = "INSERT INTO [Writed_by] (authorId, bookId) VALUES (?, ?)";
			return jdbcTemplate.update(sql, t.getAuthorId(), t.getBookId());
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public int update(WritedBy t) {
		// Không cần thiết vì bảng này chỉ có khóa ngoại
		return 0;
	}

	@Override
	public int delete(WritedBy t) {
		try {
			String sql = "DELETE FROM [Writed_by] WHERE authorId = ? AND bookId = ?";
			return jdbcTemplate.update(sql, t.getAuthorId(), t.getBookId());
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public ArrayList<WritedBy> findAll() {
		try {
			String sql = "SELECT * FROM [Writed_by]";
			return (ArrayList<WritedBy>) jdbcTemplate.query(sql, new RowMapper<WritedBy>() {
				@Override
				public WritedBy mapRow(ResultSet rs, int rowNum) throws SQLException {
					WritedBy writedBy = new WritedBy();
					writedBy.setAuthorId(UUID.fromString(rs.getString("authorId")));
					writedBy.setBookId(UUID.fromString(rs.getString("bookId")));
					return writedBy;
				}
			});
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ArrayList<>();
	}

	@Override
	public WritedBy findById(WritedBy t) {
		try {
			String sql = "SELECT * FROM [Writed_by] WHERE authorId = ? AND bookId = ?";
			return jdbcTemplate.queryForObject(sql, new Object[] { t.getAuthorId(), t.getBookId() },
					new RowMapper<WritedBy>() {
						@Override
						public WritedBy mapRow(ResultSet rs, int rowNum) throws SQLException {
							WritedBy writedBy = new WritedBy();
							writedBy.setAuthorId(UUID.fromString(rs.getString("authorId")));
							writedBy.setBookId(UUID.fromString(rs.getString("bookId")));
							return writedBy;
						}
					});
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public int insert1(Author author, Book book) {
		try {
			String sql = "INSERT INTO Writed_by (authorId, bookId)"
					+ "SELECT a.authorId, b.bookId FROM Author a, Book b WHERE a.author_name = ? AND b.book_name = ?";
			return jdbcTemplate.update(sql, author.getAuthorName(), book.getBookName());
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	public ArrayList<WritedBy> findByAuthorId(UUID authorId) {
		try {
			String sql = "SELECT * FROM [Writed_by] WHERE authorId = ?";
			return (ArrayList<WritedBy>) jdbcTemplate.query(sql, new Object[] {authorId} ,new RowMapper<WritedBy>() {
				@Override
				public WritedBy mapRow(ResultSet rs, int rowNum) throws SQLException {
					WritedBy writedBy = new WritedBy();
					writedBy.setAuthorId(UUID.fromString(rs.getString("authorId")));
					writedBy.setBookId(UUID.fromString(rs.getString("bookId")));
					return writedBy;
				}
			});
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ArrayList<>();
	}
	
	public ArrayList<WritedBy> findByBookId(UUID bookID) {
		try {
			String sql = "SELECT * FROM [Writed_by] WHERE bookId = ?";
			
			return (ArrayList<WritedBy>) jdbcTemplate.query(sql, new Object[] {bookID} ,new RowMapper<WritedBy>() {
				@Override
				public WritedBy mapRow(ResultSet rs, int rowNum) throws SQLException {
					WritedBy writedBy = new WritedBy();
					writedBy.setAuthorId(UUID.fromString(rs.getString("authorId")));
					writedBy.setBookId(UUID.fromString(rs.getString("bookId")));
					return writedBy;
				}
			});
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ArrayList<>();
	}
	
	public int deleteByBookId(UUID bookId) {
		try {
			String sql = "DELETE FROM [Writed_by] WHERE bookId = ?";
			return jdbcTemplate.update(sql, bookId);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
}
