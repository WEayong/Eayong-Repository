package eayong.Model;

import java.util.Date;

public class Student {
	private int stuId;
	private String stuNo;
	private String stuName;
	private String stuSex;
	private Date stuBirth;
	private int gradeId=-1;
	private String stuEmail;
	private String stuDesc;
	private String gradeName;
	private String insti_Name;
	private int insti_id=-1;
	public int getStuId() {
		return stuId;
	}
	public void setStuId(int stuId) {
		this.stuId = stuId;
	}
	public String getStuNo() {
		return stuNo;
	}
	public void setStuNo(String stuNo) {
		this.stuNo = stuNo;
	}
	public String getStuName() {
		return stuName;
	}
	public void setStuName(String stuName) {
		this.stuName = stuName;
	}
	public String getStuSex() {
		return stuSex;
	}
	public void setStuSex(String stuSex) {
		this.stuSex = stuSex;
	}
	public Date getStuBirth() {
		return stuBirth;
	}
	public void setStuBirth(Date stuBirth) {
		this.stuBirth = stuBirth;
	}
	public int getGradeId() {
		return gradeId;
	}
	public void setGradeId(int gradeId) {
		this.gradeId = gradeId;
	}
	public String getStuEmail() {
		return stuEmail;
	}
	public void setStuEmail(String stuEmail) {
		this.stuEmail = stuEmail;
	}
	public String getStuDesc() {
		return stuDesc;
	}
	public void setStuDesc(String stuDesc) {
		this.stuDesc = stuDesc;
	}
	public Student(int stuId, String stuNo, String stuName, String stuSex,
			Date stuBirth, int gradeId, String stuEmail, String stuDesc) {
		super();
		this.stuId = stuId;
		this.stuNo = stuNo;
		this.stuName = stuName;
		this.stuSex = stuSex;
		this.stuBirth = stuBirth;
		this.gradeId = gradeId;
		this.stuEmail = stuEmail;
		this.stuDesc = stuDesc;
	}
	public Student() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getGradeName() {
		return gradeName;
	}
	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}
	public String getInsti_Name() {
		return insti_Name;
	}
	public void setInsti_Name(String insti_Name) {
		this.insti_Name = insti_Name;
	}
	public int getInsti_id() {
		return insti_id;
	}
	public void setInsti_id(int insti_id) {
		this.insti_id = insti_id;
	}
	
	
}
