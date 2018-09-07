package eayong.web.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import cn.itcast.servlet.BaseServlet;
import eayong.Dao.GradeDao;
import eayong.Dao.StudentDao;
import eayong.Model.Grade;
import eayong.Model.Institute;
import eayong.Model.PageBean;
import eayong.Model.Student;
import eayong.service.JsonDateValueProcessor;
import eayong.service.UserException;

public class StudentServlet extends BaseServlet {
	public void pagelist(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");//«Î«Û±‡¬Î
		response.setContentType("text/html;charset=utf-8");//œÏ”¶±‡¬Î
		StudentDao studentDao=new StudentDao();
		String stuNo= request.getParameter("stuNo");
		String stuSex= request.getParameter("stuSex");
		String bgstuBirth= request.getParameter("bgstuBirth");
		String endstuBirth= request.getParameter("endstuBirth");
		String gradeId= request.getParameter("gradeId");
		String page= request.getParameter("page");
		String rows=request.getParameter("rows");
		String stuName=request.getParameter("stuName");
		String insti_id= request.getParameter("insti_id");
		Student student=new Student();
		/*if(stuName==null||stuNo==null||stuSex==null){
			stuName="";
			stuNo="";
			stuSex="";
		}*/
		if(gradeId!=null&&!gradeId.equals("")){
			student.setGradeId(Integer.parseInt(gradeId));
		}
		if(insti_id!=null&&!insti_id.equals("")){
			student.setInsti_id(Integer.parseInt(insti_id));
		}
		student.setStuName(stuName);
		student.setStuNo(stuNo);
		student.setStuSex(stuSex);
		PageBean<Student> pb=studentDao.findAll(Integer.parseInt(page),Integer.parseInt(rows),student,bgstuBirth,endstuBirth);
		JsonConfig jsonConfig = new JsonConfig();   //JsonConfig «net.sf.json.JsonConfig÷–µƒ’‚∏ˆ£¨Œ™πÃ∂®–¥∑®
		jsonConfig.registerJsonValueProcessor(Date.class , new JsonDateValueProcessor());
		JSONObject jb=new JSONObject();
		JSONArray jb1=JSONArray.fromObject(pb.getBeanList(),jsonConfig);
		jb.put("rows", jb1);
		jb.put("total", pb.getTotal());
		PrintWriter out =response.getWriter();
		out.println(jb.toString());
		out.flush();
		out.close();
	}
	public void InsticomboData(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");//«Î«Û±‡¬Î
		response.setContentType("text/html;charset=utf-8");//œÏ”¶±‡¬Î
		GradeDao gradeDao=new GradeDao();
		List<Institute> insti=gradeDao.comData();
		JSONObject jb=new JSONObject();
		jb.put("id", "");
		jb.put("insti_Name", "«Î—°‘ÒÀ˘ Ù—ß‘∫...");
		JSONArray ja=new JSONArray();
		ja.add(jb);
		ja.addAll(JSONArray.fromObject(insti));
		PrintWriter out =response.getWriter();
		out.println(ja.toString());
		out.flush();
		out.close();
	}
	public void GradecomboData(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");//«Î«Û±‡¬Î
		response.setContentType("text/html;charset=utf-8");//œÏ”¶±‡¬Î
		String id1=request.getParameter("id");
		int id=-1;
		if(id1!=null&&id1!=""){
			id=Integer.parseInt(id1);
		}
		StudentDao studentDao=new StudentDao();
		List<Grade> gradeList=studentDao.GradecomboData(id);
		JSONObject jb=new JSONObject();
		jb.put("id", "");
		jb.put("gradeName", "À˘ Ù∞‡º∂...");
		JSONArray ja=new JSONArray();
		ja.add(jb);
		ja.addAll(JSONArray.fromObject(gradeList));
		PrintWriter out =response.getWriter();
		out.println(ja.toString());
		out.flush();
		out.close();
	}
	public void delList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");//«Î«Û±‡¬Î
		response.setContentType("text/html;charset=utf-8");//œÏ”¶±‡¬Î
		StudentDao studentDao=new StudentDao();
		String delIds= request.getParameter("delIds");
		int delnum=studentDao.delList(delIds);
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
	public void updateStu(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");//«Î«Û±‡¬Î
		response.setContentType("text/html;charset=utf-8");//œÏ”¶±‡¬Î
		StudentDao studentDao=new StudentDao();
		String stuName=request.getParameter("stuName");
		String stuNo=request.getParameter("stuNo");
		String stuSex=request.getParameter("stuSex");
		String stuBirth=request.getParameter("stuBirth");
		String stuEmail=request.getParameter("stuEmail");
		String stuDesc=request.getParameter("stuDesc");
		String gradeId= request.getParameter("gradeid");
		String stuId= request.getParameter("id");
		String option= request.getParameter("op");
		Student student=new Student();
		JSONObject jb=new JSONObject();
		if(stuName!=null&&stuNo!=null&&stuSex!=null&&stuBirth!=null&&stuEmail!=null&&stuDesc!=null&&gradeId!=null){
			java.sql.Date stuBirth1=java.sql.Date.valueOf(stuBirth);
			student.setStuNo(stuNo);
			student.setStuName(stuName);
			student.setStuSex(stuSex);
			student.setStuBirth(stuBirth1);
			student.setStuEmail(stuEmail);
			student.setStuDesc(stuDesc);
			student.setGradeId(Integer.parseInt(gradeId));
			if(option.equals("Add")){
				try{
					int num=studentDao.AddStudent(student);
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
				student.setStuId(Integer.parseInt(stuId));
				try{
					int num=studentDao.updateGrade(student);
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
