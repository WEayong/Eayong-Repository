package eayong.Dao;

import java.sql.SQLException;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;

import cn.itcast.jdbc.TxQueryRunner;

import eayong.Model.User;

public class UserDao {
	private QueryRunner  qr= new TxQueryRunner();
	public User login(User user) throws SQLException{
		String sql="select * from t_user where userName=?";
		User user1=qr.query(sql, new BeanHandler<User>(User.class));
		return user1;
	}

	public User findByUsername(String userName) throws SQLException {
		String sql="select * from t_user where userName=?";
		User user=qr.query(sql, new BeanHandler<User>(User.class),userName);
		return user;
	}
}
