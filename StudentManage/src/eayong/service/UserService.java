package eayong.service;

import java.sql.SQLException;

import eayong.Dao.UserDao;
import eayong.Model.User;
import eayong.web.servlet.UserServlet;

/**
 * 业务层
 * @author admin
 *
 */
public class UserService {
	private UserDao userDao=new UserDao();  
	/**
	 * 注册功能
	 * @throws SQLException 
	 */
	
	/*public void Regist(User user) throws UserException{
		User userSel=userDao.findByUsername(user.getUserName());
		if(userSel!=null)
			throw new UserException("用户名"+ user.getUserName() + "已被注册");
		userDao.add(user);
	}*/
	/*
	 * 登陆
	 */
	public User Login(User form) throws UserException, SQLException {
		User user=userDao.findByUsername(form.getUserName());  
		if(user==null){
			throw new  UserException("用户名不存在！");
		}
		if(!form.getPassword().equals(user.getPassword())){
			throw new  UserException("密码错误！");
		}
		UserServlet.flag="1";
		return user;
	}
}
 