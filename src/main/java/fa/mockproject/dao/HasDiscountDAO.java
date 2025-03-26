package fa.mockproject.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import fa.mockproject.model.HasDiscount;

@Repository
public class HasDiscountDAO implements DAOInterface<HasDiscount> {

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    public int insert(HasDiscount t) {
        try {
            String sql = "INSERT INTO [Has_discount] (userId, discountId) VALUES (?, ?)";
            return jdbcTemplate.update(sql, t.getUserId(), t.getDiscountId());
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int update(HasDiscount t) {
        try {
            String sql = "UPDATE [Has_discount] SET discountId = ? WHERE userId = ?";
            return jdbcTemplate.update(sql, t.getDiscountId(), t.getUserId());
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int delete(HasDiscount t) {
        try {
            String sql = "DELETE FROM [Has_discount] WHERE userId = ? AND discountId = ?";
            return jdbcTemplate.update(sql, t.getUserId(), t.getDiscountId());
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public ArrayList<HasDiscount> findAll() {
        try {
            String sql = "SELECT * FROM [Has_discount]";
            return (ArrayList<HasDiscount>) jdbcTemplate.query(sql, new RowMapper<HasDiscount>() {
                @Override
                public HasDiscount mapRow(ResultSet rs, int rowNum) throws SQLException {
                    HasDiscount hasDiscount = new HasDiscount();
                    hasDiscount.setUserId(UUID.fromString(rs.getString("userId")));
                    hasDiscount.setDiscountId(UUID.fromString(rs.getString("discountId")));
                    return hasDiscount;
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ArrayList<>();
    }

    @Override
    public HasDiscount findById(HasDiscount t) {
        try {
            String sql = "SELECT * FROM [Has_discount] WHERE userId = ? AND discountId = ?";
            return jdbcTemplate.queryForObject(sql, new Object[]{t.getUserId(), t.getDiscountId()}, new RowMapper<HasDiscount>() {
                @Override
                public HasDiscount mapRow(ResultSet rs, int rowNum) throws SQLException {
                    HasDiscount hasDiscount = new HasDiscount();
                    hasDiscount.setUserId(UUID.fromString(rs.getString("userId")));
                    hasDiscount.setDiscountId(UUID.fromString(rs.getString("discountId")));
                    return hasDiscount;
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}

