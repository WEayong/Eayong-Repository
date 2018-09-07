package eayong.web.servlet;



import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.junit.Test;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;

import cn.itcast.servlet.BaseServlet;
import eayong.Dao.GradeDao;
import eayong.Model.Grade;
import eayong.Model.Institute;
import eayong.Model.PageBean;
import eayong.service.UserException;

public class GradeServlet extends BaseServlet {
	UserException userException=new UserException();
	public void pagelist(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");//«Î«Û±‡¬Î
		response.setContentType("text/html;charset=utf-8");//œÏ”¶±‡¬Î
		GradeDao gradeDao=new GradeDao();
		String page= request.getParameter("page");
		String rows=request.getParameter("rows");
		String gradeName=request.getParameter("gradeName");
		if(gradeName==null){
			gradeName="";
		}
		Grade grade=new Grade();
		grade.setGradeName(gradeName);
		PageBean<Grade> pb=gradeDao.findAll(Integer.parseInt(page),Integer.parseInt(rows),grade);
		JSONObject jb=new JSONObject();
		JSONArray ja=JSONArray.fromObject(pb.getBeanList());
		jb.put("rows", ja);
		jb.put("total", pb.getTotal());
		PrintWriter out =response.getWriter();
		out.println(jb.toString());
		out.flush();
		out.close();
		
	}
	public void searchStu(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");//«Î«Û±‡¬Î
		response.setContentType("text/html;charset=utf-8");//œÏ”¶±‡¬Î
		GradeDao gradeDao=new GradeDao();
		String delIds= request.getParameter("delIds1");
		List<Grade> searchstu=gradeDao.searchStu(delIds);
		JSONArray ja=JSONArray.fromObject(searchstu);
		System.out.println(ja);
		JSONObject jb=new JSONObject();
		if(searchstu.size()!=0){
			jb.put("searchstu", ja);
			jb.put("success1", "true");
		}else{
			jb.put("errorMsg", "Œ“ ß∞‹¡À£°");
		}
		PrintWriter out =response.getWriter();
		out.println(jb.toString());
		out.flush();
		out.close();
		
	}
	public void delList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");//«Î«Û±‡¬Î
		response.setContentType("text/html;charset=utf-8");//œÏ”¶±‡¬Î
		GradeDao gradeDao=new GradeDao();
		String delIds= request.getParameter("delIds");
		int delnum=gradeDao.delList(delIds);
		JSONObject jb=new JSONObject();
		if(delnum>0){
			jb.put("delnum", delnum);
			jb.put("success", "true");
		}else{
			jb.put("errorMsg", "…æ≥˝ ß∞‹£°");
		}
		PrintWriter out =response.getWriter();
		out.println(jb.toString());
		out.flush();
		out.close();
	}
	public void comData(HttpServletRequest request, HttpServletResponse response)//º”‘ÿœ¬¿≠øÚ ˝æ›
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");//«Î«Û±‡¬Î
		response.setContentType("text/html;charset=utf-8");//œÏ”¶±‡¬Î
		GradeDao gradeDao=new GradeDao();
		List<Institute> insti=gradeDao.comData();
		JSONObject jb=new JSONObject();
		JSONArray ja=JSONArray.fromObject(insti);
		System.out.println(ja);
		jb.put("data", ja);
		PrintWriter out =response.getWriter();
		out.println(jb.toString());
		out.flush();
		out.close();
	}
	public void addGrade(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");//«Î«Û±‡¬Î
		response.setContentType("text/html;charset=utf-8");//œÏ”¶±‡¬Î
		GradeDao gradeDao=new GradeDao();
		String instiId= request.getParameter("instiId");
		String id= request.getParameter("id");
		String gradeName= request.getParameter("gradeName");
		String option= request.getParameter("op");
		String gradeDesc= request.getParameter("gradeDesc");
		Grade grade =new Grade();
		JSONObject jb=new JSONObject();
		if(instiId!=null&&gradeName!=null&&gradeDesc!=null){
			grade.setInsti_id(Integer.parseInt(instiId));
			grade.setGradeName(gradeName);
			grade.setGradeDesc(gradeDesc);
			if(option.equals("Add")){
				try{
					int num=gradeDao.AddGrade(grade);
					if(num>0){
						jb.put("result", "true");
						jb.put("num", num);
					}else{
						jb.put("errorMsg", "ÃÌº” ß∞‹£¨«Î÷ÿ ‘£°");
					}
				}catch (UserException e) {
					jb.put("errorMsg", "ÃÌº” ß∞‹£¨«Î÷ÿ ‘£°");
				}
			}else if(option.equals("Mod"))
			{
				grade.setId(Integer.parseInt(id));
				try{
					int num=gradeDao.updateGrade(grade);
					if(num>0){
						jb.put("result", "true");
						jb.put("num", num);
					}else{
						jb.put("errorMsg1", "–ﬁ∏ƒ ß∞‹£¨«Î÷ÿ ‘£°");
					}
				}catch (UserException e) {
					// TODO: handle exception
					jb.put("errorMsg1", "ÃÌº” ß∞‹£¨«Î÷ÿ ‘£°");
				}
				
			}
		}else{
			jb.put("errorMsg", "ÃÌº” ß∞‹£¨«ÎºÏ≤È∫Û÷ÿ ‘£°");
			jb.put("errorMsg1", "–ﬁ∏ƒ ß∞‹£¨«ÎºÏ≤È∫Û÷ÿ ‘£°");
		}
		PrintWriter out =response.getWriter();
		out.println(jb.toString());
		out.flush();
		out.close();
	}
}
