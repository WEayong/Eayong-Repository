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
	public static String flag = "-1";//默认登录不成功
	public void login(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");//请求编码
		response.setContentType("text/html;charset=utf-8");//响应编码
		UserService userService=new UserService();
		//User form=CommonUtils.toBean(request.getParameterMap(), User.class);
		User form=new User();
		form.setUserName(request.getParameter("userName"));
		form.setPassword(request.getParameter("password"));
		form.setVerifyCode(request.getParameter("verifyCode"));
		
		Map<String, String > errors=new HashMap<String, String>();//装载错误信息
		/*String username=form.getUserName();//校验用户名
		if(username==null||username.trim().isEmpty()){
			errors.put("username", "用户名不能为空！");
		}else if(username.length()<3||username.length()>15){
			errors.put("username", "用户名必须在3~15之间！");
		}
		String password =form.getPassword();//校验密码
		if(password==null||password.trim().isEmpty()){
			errors.put("password", "密码不能为空！");
		}else if(password.length()<3||password.length()>15){
			errors.put("password", "密码必须在3~15之间！");
		}*/
		
		String verifyCode =form.getVerifyCode();//校验验证码
		String sessionVerifyCode=(String ) request.getSession().getAttribute("session_vcode");
		if(!sessionVerifyCode.equalsIgnoreCase(verifyCode)){
			errors.put("verifyCode", "验证码错误！");
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
