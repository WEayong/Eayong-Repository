package eayong.service;

import java.sql.SQLException;

import eayong.Dao.UserDao;
import eayong.Model.User;
import eayong.web.servlet.UserServlet;

/**
 * ҵ���
 * @author admin
 *
 */
public class UserService {
	private UserDao userDao=new UserDao();  
	/**
	 * ע�Ṧ��
	 * @throws SQLException 
	 */
	
	/*public void Regist(User user) throws UserException{
		User userSel=userDao.findByUsername(user.getUserName());
		if(userSel!=null)
			throw new UserException("�û���"+ user.getUserName() + "�ѱ�ע��");
		userDao.add(user);
	}*/
	/*
	 * ��½
	 */
	public User Login(User form) throws UserException, SQLException {
		User user=userDao.findByUsername(form.getUserName());  
		if(user==null){
			throw new  UserException("�û��������ڣ�");
		}
		if(!form.getPassword().equals(user.getPassword())){
			throw new  UserException("�������");
		}
		UserServlet.flag="1";
		return user;
	}
}
 