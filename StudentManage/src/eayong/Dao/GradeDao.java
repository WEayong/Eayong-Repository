package eayong.Dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import cn.itcast.jdbc.TxQueryRunner;

import eayong.Model.Grade;
import eayong.Model.Institute;
import eayong.Model.PageBean;
import eayong.service.UserException;

public class GradeDao {
	public PageBean<Grade> findAll(int page, int rows,Grade grade) {
		// TODO Auto-generated method stub
		try{
			QueryRunner qr=new TxQueryRunner(); 
			PageBean<Grade> pb=new PageBean<Grade>();
			pb.setPage(page);
			pb.setRows(rows);
			String sql="select count(*) from t_grade  where gradeName like '%"+grade.getGradeName()+"%'";
			Number num=(Number)qr.query(sql, new ScalarHandler());
			int total=num.intValue();
			pb.setTotal(total);
			sql="select A.id,B.insti_Name,A.gradeName,A.gradeDesc from t_grade A, t_insti B where A.insti_id=B.id and A.gradeName like '%"+grade.getGradeName()+"%' order by A.id asc limit ?,?";
			List<Grade> beanList=qr.query(sql, new BeanListHandler<Grade>(Grade.class),(page-1)*rows,rows);;
			pb.setBeanList(beanList);
			return pb;
		}catch (SQLException e) {
			// TODO: handle exception
			throw new RuntimeException();
		}
		
	}

	public int delList(String delIds) {
		// TODO Auto-generated method stub
		try{
			QueryRunner qr=new TxQueryRunner(); 
			String sql="delete from t_grade where id in("+delIds+")";
			int delnum = qr.update(sql);
			return delnum;
		}catch (SQLException e) {
			throw new RuntimeException();
		}
	}

	public List<Institute> comData() {
		// TODO Auto-generated method stub
		try{
			QueryRunner qr=new TxQueryRunner();
			String sql="select * from t_insti";
			List<Institute> comdata=qr.query(sql, new BeanListHandler<Institute>(Institute.class));
			return comdata;
		}catch (SQLException e) {
			// TODO: handle exception
			throw new RuntimeException();
		}
	}

	public int updateGrade(Grade grade ) throws UserException {
		// TODO Auto-generated method stub
		try{
			QueryRunner qr=new TxQueryRunner(); 
			String sql="update t_grade set insti_id=?,gradeName=?,gradeDesc=? where id=?";
			int num = qr.update(sql, grade.getInsti_id(),grade.getGradeName(),grade.getGradeDesc(),grade.getId());
			return num;
		}catch (SQLException e) {
			throw new UserException("–ﬁ∏ƒ ß∞‹£¨«Î÷ÿ ‘£°");
		}
	}

	public int AddGrade(Grade grade) throws UserException {
		// TODO Auto-generated method stub
		try{
			QueryRunner qr=new TxQueryRunner();
			String sql="insert into t_grade (insti_id,gradeName,gradeDesc) values(?,?,?)";
			int num = qr.update(sql, grade.getInsti_id(),grade.getGradeName(),grade.getGradeDesc());
			return num;
		}catch (SQLException e) {
			throw new UserException("ÃÌº” ß∞‹£¨«Î÷ÿ ‘£°");
		}
	}

	public List<Grade> searchStu(String delIds) {
		// TODO Auto-generated method stub
		try{
			QueryRunner qr=new TxQueryRunner();
			String sql="select B.gradeName,COUNT(B.id) counts from t_student A, t_grade B where A.gradeId=B.id and B.id in("+delIds+") GROUP BY B.id";
			List<Grade> seachstu=qr.query(sql, new BeanListHandler<Grade>(Grade.class));
			return seachstu;
		}catch (SQLException e) {
			// TODO: handle exception
			throw new RuntimeException();
		}
	}

}
