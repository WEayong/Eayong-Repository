package eayong.web.servlet;



import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import cn.itcast.commons.CommonUtils;
import cn.itcast.servlet.BaseServlet;
import eayong.Dao.UserDao;
import eayong.Model.User;
import eayong.service.UserException;
import eayong.service.UserService;

public class UserServlet extends BaseServlet {
	public static String flag = "-1";//Ĭ�ϵ�¼���ɹ�
	public void login(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");//�������
		response.setContentType("text/html;charset=utf-8");//��Ӧ����
		UserService userService=new UserService();
		//User form=CommonUtils.toBean(request.getParameterMap(), User.class);
		User form=new User();
		form.setUserName(request.getParameter("userName"));
		form.setPassword(request.getParameter("password"));
		form.setVerifyCode(request.getParameter("verifyCode"));
		
		Map<String, String > errors=new HashMap<String, String>();//װ�ش�����Ϣ
		/*String username=form.getUserName();//У���û���
		if(username==null||username.trim().isEmpty()){
			errors.put("username", "�û�������Ϊ�գ�");
		}else if(username.length()<3||username.length()>15){
			errors.put("username", "�û���������3~15֮�䣡");
		}
		String password =form.getPassword();//У������
		if(password==null||password.trim().isEmpty()){
			errors.put("password", "���벻��Ϊ�գ�");
		}else if(password.length()<3||password.length()>15){
			errors.put("password", "���������3~15֮�䣡");
		}*/
		
		String verifyCode =form.getVerifyCode();//У����֤��
		String sessionVerifyCode=(String ) request.getSession().getAttribute("session_vcode");
		if(!sessionVerifyCode.equalsIgnoreCase(verifyCode)){
			errors.put("verifyCode", "��֤�����");
			request.setAttribute("errors", errors);
			request.setAttribute("user", form);
			flag="0";
			response.getWriter().print(flag);
			flag="-1";
			return;
		}
		/*if(errors!=null&&errors.size()>0){
			request.setAttribute("errors", errors);
			request.setAttribute("user", form);
			response.getWriter().print(flag);
			flag="false";
			//request.getRequestDispatcher("/jsps/index.jsp").forward(request, response);
			return;
		}*/
		try {
			User user=userService.Login(form);
			request.getSession().setAttribute("sessionUser", user);
			//response.sendRedirect(request.getContextPath()+"/jsps/main.jsp");
			response.setContentType("text/html;charset=utf-8");
			response.getWriter().print(flag);
			flag="false";
		} catch (UserException e) {
			request.setAttribute("error", e.getMessage());
			request.setAttribute("user", form);
			response.getWriter().print(flag);
			flag="false";
			//request.getRequestDispatcher("/jsps/index.jsp").forward(request, response);
		}
		
	}
}
