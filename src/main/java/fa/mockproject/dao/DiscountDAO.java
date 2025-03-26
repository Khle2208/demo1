package fa.mockproject.dao;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import fa.mockproject.model.Discount;

@Repository
public class DiscountDAO implements DAOInterface<Discount> {

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    public int insert(Discount t) {
        try {
            String sql = "INSERT INTO [Discount] (name_discount, discount_price, quantity, out_date) VALUES (?, ?, ?, ?)";
            return jdbcTemplate.update(sql, t.getNameDiscount(), t.getDiscountPrice(), t.getQuantity(), t.getOutDate());
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int update(Discount t) {
        try {
            String sql = "UPDATE [Discount] SET name_discount = ?, discount_price = ?, quantity = ?, out_date = ? WHERE discountId = ?";
            return jdbcTemplate.update(sql, t.getNameDiscount(), t.getDiscountPrice(), t.getQuantity(), t.getOutDate(), t.getDiscountId());
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int delete(Discount t) {
        try {
            String sql = "DELETE FROM [Discount] WHERE discountId = ?";
            String sqlHasDicount = "DELETE FROM [Has_discount] WHERE discountId = ?";
            jdbcTemplate.update(sqlHasDicount, t.getDiscountId());
            return jdbcTemplate.update(sql, t.getDiscountId());
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public ArrayList<Discount> findAll() {
        try {
            String sql = "SELECT * FROM [Discount]";
            return (ArrayList<Discount>) jdbcTemplate.query(sql, new RowMapper<Discount>() {
                @Override
                public Discount mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Discount discount = new Discount();
                    discount.setDiscountId(UUID.fromString(rs.getString("discountId")));
                    discount.setNameDiscount(rs.getString("name_discount"));
                    discount.setDiscountPrice(rs.getBigDecimal("discount_price"));
                    discount.setQuantity(rs.getInt("quantity"));
                    Timestamp timestamp = rs.getTimestamp("out_date");
					if (timestamp != null) {
						LocalDate out_date = timestamp.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
						discount.setOutDate(out_date);
					}
                    return discount;
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public Discount findById(Discount t) {
        try {
            String sql = "SELECT * FROM [Discount] WHERE discountId = ?";
            return jdbcTemplate.queryForObject(sql, new Object[]{t.getDiscountId()}, new RowMapper<Discount>() {
                @Override
                public Discount mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Discount discount = new Discount();
                    discount.setDiscountId(UUID.fromString(rs.getString("discountId")));
                    discount.setNameDiscount(rs.getString("name_discount"));
                    discount.setDiscountPrice(rs.getBigDecimal("discount_price"));
                    discount.setQuantity(rs.getInt("quantity"));
                    Timestamp timestamp = rs.getTimestamp("out_date");
					if (timestamp != null) {
						LocalDate out_date = timestamp.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
						discount.setOutDate(out_date);
					}
                    return discount;
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public ArrayList<Discount> findByName(String name){
    	try {
            String sql = "SELECT * FROM [Discount] WHERE name_discount LIKE ?";
            return (ArrayList<Discount>) jdbcTemplate.query(sql, new Object[] {"%" + name + "%"},new RowMapper<Discount>() {
                @Override
                public Discount mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Discount discount = new Discount();
                    discount.setDiscountId(UUID.fromString(rs.getString("discountId")));
                    discount.setNameDiscount(rs.getString("name_discount"));
                    discount.setDiscountPrice(rs.getBigDecimal("discount_price"));
                    discount.setQuantity(rs.getInt("quantity"));
                    Timestamp timestamp = rs.getTimestamp("out_date");
					if (timestamp != null) {
						LocalDate out_date = timestamp.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
						discount.setOutDate(out_date);
					}
                    return discount;
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}

