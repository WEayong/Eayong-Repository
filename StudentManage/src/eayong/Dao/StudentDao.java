package eayong.Dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import cn.itcast.jdbc.TxQueryRunner;
import eayong.Model.Grade;
import eayong.Model.PageBean;
import eayong.Model.Student;
import eayong.service.UserException;

public class StudentDao {
	public PageBean<Student> findAll(int page, int rows,Student student,String bgstuBirth,String endstuBirth) {
		// TODO Auto-generated method stub
		try{
			QueryRunner qr=new TxQueryRunner(); 
			PageBean<Student> pb=new PageBean<Student>();
			pb.setPage(page);
			pb.setRows(rows);
			StringBuilder sql=new StringBuilder("select count(*) from t_student A,t_grade B,t_insti C where A.gradeId=B.id and B.insti_id=C.id ");
			StringBuilder sql1=new StringBuilder("select A.stuId,A.stuNo,A.stuName,C.insti_Name,A.stuSex,A.stuBirth,B.gradeName,A.stuEmail," +
					" A.stuDesc from t_student A, t_grade B ,t_insti C where A.gradeId=B.id and B.insti_id=C.id ");
			if(student.getStuName()!=null&&!student.getStuName().equals("")){
				sql.append(" and stuName like '%"+student.getStuName()+"%' ");
				sql1.append(" and stuName like '%"+student.getStuName()+"%' ");
			}
			if(student.getStuNo()!=null&&!student.getStuNo().equals("")){
				sql.append(" and stuNo like '%"+student.getStuNo()+"%'");
				sql1.append(" and stuNo like '%"+student.getStuNo()+"%'");
			}
			if(student.getStuSex()!=null&&!student.getStuSex().equals("")){
				sql.append(" and stuSex='"+student.getStuSex()+"' ");
				sql1.append(" and stuSex='"+student.getStuSex()+"'");
			}
			if(student.getGradeId()!=-1){
				sql.append(" and gradeId ='"+student.getGradeId()+"' ");
				sql1.append(" and gradeId ='"+student.getGradeId()+"' ");
			}
			if(student.getInsti_id()!=-1){
				sql.append(" and C.id ='"+student.getInsti_id()+"' ");
				sql1.append(" and C.id ='"+student.getInsti_id()+"' ");
			}
			if(bgstuBirth!=null&&!bgstuBirth.equals("")){
				sql.append(" and TO_DAYS(stuBirth)>=TO_DAYS('"+bgstuBirth+"')");
				sql1.append(" and TO_DAYS(stuBirth)>=TO_DAYS('"+bgstuBirth+"')");
			}
			if(endstuBirth!=null&&!endstuBirth.equals("")){
				sql.append(" and TO_DAYS(stuBirth)<=TO_DAYS('"+endstuBirth+"')");
				sql1.append(" and TO_DAYS(stuBirth)<=TO_DAYS('"+endstuBirth+"')");
			}
			sql1.append(" order by A.stuId asc limit ?,?");
			Number num=(Number)qr.query(sql.toString(), new ScalarHandler());
			int total=num.intValue();
			pb.setTotal(total);
			List<Student> beanList=qr.query(sql1.toString(), new BeanListHandler<Student>(Student.class),(page-1)*rows,rows);
			pb.setBeanList(beanList);
			return pb;
		}catch (SQLException e) {
			// TODO: handle exception
			throw new RuntimeException();
		}
		
	}

	public List<Grade> GradecomboData(int id) {
		// TODO Auto-generated method stub
		try{
			QueryRunner qr=new TxQueryRunner();
			String sql="select * from t_grade where insti_id=?";
			List<Grade> comdata=qr.query(sql, new BeanListHandler<Grade>(Grade.class),id);
			return comdata;
		}catch (SQLException e) {
			// TODO: handle exception
			throw new RuntimeException();
		}
	}

	public int delList(String delIds) {
		// TODO Auto-generated method stub
		try{
			QueryRunner qr=new TxQueryRunner(); 
			String sql="delete from t_student where stuId in("+delIds+")";
			int delnum = qr.update(sql);
			return delnum;
		}catch (SQLException e) {
			throw new RuntimeException();
		}
	}

	public int AddStudent(Student student) throws UserException {
		// TODO Auto-generated method stub
		try{
			QueryRunner qr=new TxQueryRunner();
			String sql="insert into t_student (stuNo,stuName,stuSex,stuBirth,gradeId,stuEmail,stuDesc) values(?,?,?,?,?,?,?)";
			int num = qr.update(sql, student.getStuNo(),student.getStuName(),student.getStuSex(),student.getStuBirth(),
					student.getGradeId(),student.getStuEmail(),student.getStuDesc());
			return num;
		}catch (SQLException e) {
			throw new UserException("ÃÌº” ß∞‹£¨«Î÷ÿ ‘£°");
		}
	}

	public int updateGrade(Student student) throws UserException {
		// TODO Auto-generated method stub
		try{
			QueryRunner qr=new TxQueryRunner(); 
			String sql="update t_student set stuNo=?,stuName=?,stuSex=?,stuBirth=?,gradeId=?,stuEmail=?,stuDesc=? where stuId=?";
			int num = qr.update(sql, student.getStuNo(),student.getStuName(),student.getStuSex(),student.getStuBirth(),
					student.getGradeId(),student.getStuEmail(),student.getStuDesc(),student.getStuId());
			return num;
		}catch (SQLException e) {
			throw new UserException("–ﬁ∏ƒ ß∞‹£¨«Î÷ÿ ‘£°");
		}
	}
}
