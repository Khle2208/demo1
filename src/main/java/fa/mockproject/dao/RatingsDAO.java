package fa.mockproject.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import fa.mockproject.model.Ratings;


@Repository
public class RatingsDAO implements DAOInterface<Ratings> {

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    public int insert(Ratings t) {
        try {
            String sql = "INSERT INTO [Ratings] (ratingsId, content, start_number, created_at, userId, bookId) VALUES (?, ?, ?, ?, ?, ?)";
            return jdbcTemplate.update(sql, t.getRatingsId(), t.getContent(), t.getStarNumber(), t.getCreatedAt(), t.getUserId(), t.getBookId());
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int update(Ratings t) {
        try {
            String sql = "UPDATE [Ratings] SET content = ?, start_number = ?, created_at = ? WHERE ratingsId = ?";
            return jdbcTemplate.update(sql, t.getContent(), t.getStarNumber(), t.getCreatedAt(), t.getRatingsId());
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int delete(Ratings t) {
        try {
            String sql = "DELETE FROM [Ratings] WHERE ratingsId = ?";
            return jdbcTemplate.update(sql, t.getRatingsId());
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public ArrayList<Ratings> findAll() {
        try {
            String sql = "SELECT * FROM [Ratings]";
            return (ArrayList<Ratings>) jdbcTemplate.query(sql, new RowMapper<Ratings>() {
                @Override
                public Ratings mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Ratings ratings = new Ratings();
                    ratings.setRatingsId(UUID.fromString(rs.getString("ratingsId")));
                    ratings.setContent(rs.getString("content"));
                    ratings.setStarNumber(rs.getInt("start_number"));
                    ratings.setCreatedAt(rs.getDate("created_at"));
                    ratings.setUserId(UUID.fromString(rs.getString("userId")));
                    ratings.setBookId(UUID.fromString(rs.getString("bookId")));
                    return ratings;
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ArrayList<>();
    }

    @Override
    public Ratings findById(Ratings t) {
        try {
            String sql = "SELECT * FROM [Ratings] WHERE ratingsId = ?";
            return jdbcTemplate.queryForObject(sql, new Object[]{t.getRatingsId()}, new RowMapper<Ratings>() {
                @Override
                public Ratings mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Ratings ratings = new Ratings();
                    ratings.setRatingsId(UUID.fromString(rs.getString("ratingsId")));
                    ratings.setContent(rs.getString("content"));
                    ratings.setStarNumber(rs.getInt("start_number"));
                    ratings.setCreatedAt(rs.getDate("created_at"));
                    ratings.setUserId(UUID.fromString(rs.getString("userId")));
                    ratings.setBookId(UUID.fromString(rs.getString("bookId")));
                    return ratings;
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public int countRatingsByUserId(UUID userId) {
		try {
			String sql = "SELECT COUNT(*) FROM [Ratings] WHERE userId = ?";
			int count = jdbcTemplate.queryForObject(sql, new Object[] { userId }, Integer.class);
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
}

