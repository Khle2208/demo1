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

@Repository
public class AuthorDAO implements DAOInterface<Author> {

	@Autowired
	JdbcTemplate jdbcTemplate;

	@Override
	public int insert(Author t) {
		try {
			String sql = "INSERT INTO [Author] " + "(author_name, introduction) " + "VALUES (?, ?)";

			return jdbcTemplate.update(sql, t.getAuthorName(), t.getIntroduction());
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public int update(Author t) {
		try {
			String sql = "UPDATE [Author] SET author_name = ? WHERE authorId = ?";
			String sql1 = "UPDATE b\r\n"
					+ "SET b.author = ?\r\n"
					+ "FROM [Book] b\r\n"
					+ "INNER JOIN [Writed_By] wb ON b.bookId = wb.bookId\r\n"
					+ "WHERE wb.authorId = ?\r\n"; 
			jdbcTemplate.update(sql1, t.getAuthorName(), t.getAuthorId());
			return jdbcTemplate.update(sql, t.getAuthorName(), t.getAuthorId());

		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public int delete(Author t) {
		try {
			String sql = "DELETE FROM [Author] WHERE authorId = ?";
			return jdbcTemplate.update(sql, t.getAuthorId());
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public ArrayList<Author> findAll() {
		try {
			String sql = "SELECT * FROM [Author]";
			return (ArrayList<Author>) jdbcTemplate.query(sql, new RowMapper<Author>() {
				@Override
				public Author mapRow(ResultSet rs, int rowNum) throws SQLException {
					Author author = new Author();
					author.setAuthorId(UUID.fromString(rs.getString("authorId")));
					author.setAuthorName(rs.getString("author_name"));
					author.setIntroduction(rs.getString("introduction"));
					return author;
				}
			});
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ArrayList<>();
	}

	@Override
	public Author findById(Author t) {
		try {
			String sql = "SELECT * FROM [Author] WHERE authorId = ?";
			return jdbcTemplate.queryForObject(sql, new Object[] { t.getAuthorId() }, new RowMapper<Author>() {
				@Override
				public Author mapRow(ResultSet rs, int rowNum) throws SQLException {
					Author author = new Author();
					author.setAuthorId(UUID.fromString(rs.getString("authorId")));
					author.setAuthorName(rs.getString("author_name"));
					author.setIntroduction(rs.getString("introduction"));
					return author;
				}

			});

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public Author findByFullName(String name) {
		try {
			String sql = "SELECT * FROM [Author] WHERE author_name = ?";
			return jdbcTemplate.queryForObject(sql, new Object[] { name }, new RowMapper<Author>() {
				@Override
				public Author mapRow(ResultSet rs, int rowNum) throws SQLException {
					Author author = new Author();
					author.setAuthorId(UUID.fromString(rs.getString("authorId")));
					author.setAuthorName(rs.getString("author_name"));
					author.setIntroduction(rs.getString("introduction"));
					return author;
				}

			});

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public ArrayList<Author> findByName(String name) {
		try {
			String sql = "SELECT * FROM [Author] WHERE author_name LIKE ?";
			return (ArrayList<Author>) jdbcTemplate.query(sql, new Object[] { "%" + name + "%" },
					new RowMapper<Author>() {
						@Override
						public Author mapRow(ResultSet rs, int rowNum) throws SQLException {
							Author author = new Author();
							author.setAuthorId(UUID.fromString(rs.getString("authorId")));
							author.setAuthorName(rs.getString("author_name"));
							author.setIntroduction(rs.getString("introduction"));
							return author;
						}
					});
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public Author findById(UUID authorId) {
		try {
			String sql = "SELECT * FROM [Author] WHERE authorId = ?";
			return jdbcTemplate.queryForObject(sql, new Object[] { authorId }, new RowMapper<Author>() {
				@Override
				public Author mapRow(ResultSet rs, int rowNum) throws SQLException {
					Author author = new Author();
					author.setAuthorId(UUID.fromString(rs.getString("authorId")));
					author.setAuthorName(rs.getString("author_name"));
					author.setIntroduction(rs.getString("introduction"));
					return author;
				}

			});

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public int countBookByAuthorId(Author t) {
		try {
			String sql = "SELECT COUNT(*) FROM [Writed_by] WHERE authorId = ?";
			int count = jdbcTemplate.queryForObject(sql, new Object[] { t.getAuthorId() }, Integer.class);
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	public Integer statisticAuthorDAO() {
		String sql="  SELECT COUNT(*) FROM [Author]";
		return jdbcTemplate.queryForObject(sql, Integer.class);
		
	}
	
	

}
