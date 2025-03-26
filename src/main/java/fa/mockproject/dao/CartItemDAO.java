package fa.mockproject.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import fa.mockproject.model.CartItems;

@Repository
public class CartItemDAO implements DAOInterface<CartItems>{

	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Override
	public int insert(CartItems t) {
		try {
			String sql = "INSERT INTO [Cart_items] "
					+ "(cartId, bookId, book_name, price, quantity_order, discount, total_price, avatar) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

			return jdbcTemplate.update(sql, t.getCartId(), t.getBookId(), t.getBookId(), t.getBookName(),
					t.getPrice(), t.getQuantityOrder(), t.getDiscount(), t.getTotalPrice(), t.getAvatar());
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public int update(CartItems t) {
		try {
			String sql = "UPDATE [Cart_items] " + "SET book_name = ?, price=? , quantity_order = ?, discount = ?, total_price = ?, avatar = ?" + "WHERE cart_itemId = ?";
			return jdbcTemplate.update(sql,t.getBookName(), t.getPrice(), t.getQuantityOrder(), t.getDiscount(), t.getAvatar(), t.getCartItemId());
			
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public int delete(CartItems t) {
		try {
			String sql = "DELETE FROM [Cart_items] WHERE cart_itemId = ?";
			return jdbcTemplate.update(sql, t.getCartItemId());
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public ArrayList<CartItems> findAll() {
		try {
			String sql = "SELECT * FROM [Cart_items]";
			return (ArrayList<CartItems>) jdbcTemplate.query(sql, new RowMapper<CartItems>() {
				@Override
				public CartItems mapRow(ResultSet rs, int rowNum) throws SQLException {
					CartItems cartItem = new CartItems();
					cartItem.setCartItemId(UUID.fromString(String.valueOf(rs.getInt("cart_itemsId"))));
					cartItem.setCartId(UUID.fromString(String.valueOf(rs.getInt("cartId"))));
					cartItem.setBookId(UUID.fromString(String.valueOf(rs.getInt("bookId"))));
					cartItem.setBookName(rs.getString("book_name"));
					cartItem.setPrice(rs.getBigDecimal("price"));
					cartItem.setQuantityOrder(rs.getInt("quantity_order"));
					cartItem.setDiscount(rs.getBigDecimal("discount"));
					cartItem.setTotalPrice(rs.getBigDecimal("total_price"));
					cartItem.setAvatar(rs.getBytes("avatar"));
					return cartItem;
				}
			});
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ArrayList<>();
	}

	@Override
	public CartItems findById(CartItems t) {
		try {
			String sql = "SELECT * FROM [Cart_items] WHERE cart_itemsId = ?";
			return jdbcTemplate.queryForObject(sql, new Object[] { t.getCartItemId() }, new RowMapper<CartItems>() {
				@Override
				public CartItems mapRow(ResultSet rs, int rowNum) throws SQLException {
					CartItems cartItem = new CartItems();
					cartItem.setCartItemId(UUID.fromString(String.valueOf(rs.getInt("cart_itemsId"))));
					cartItem.setCartId(UUID.fromString(String.valueOf(rs.getInt("cartId"))));
					cartItem.setBookId(UUID.fromString(String.valueOf(rs.getInt("bookId"))));
					cartItem.setBookName(rs.getString("book_name"));
					cartItem.setPrice(rs.getBigDecimal("price"));
					cartItem.setQuantityOrder(rs.getInt("quantity_order"));
					cartItem.setDiscount(rs.getBigDecimal("discount"));
					cartItem.setTotalPrice(rs.getBigDecimal("total_price"));
					cartItem.setAvatar(rs.getBytes("avatar"));
					return cartItem;
				}

			});

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
		}


}
