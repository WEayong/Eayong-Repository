package eayong.Model;

public class Grade {
	private int id;
	private int insti_id;
	private String insti_Name;
	private String gradeName;
	private String gradeDesc;
	private int Counts;
	public int getInsti_id() {
		return insti_id;
	}
	public void setInsti_id(int insti_id) {
		this.insti_id = insti_id;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getGradeName() {
		return gradeName;
	}
	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}
	public String getGradeDesc() {
		return gradeDesc;
	}
	public void setGradeDesc(String gradeDesc) {
		this.gradeDesc = gradeDesc;
	}
	public String getInsti_Name() {
		return insti_Name;
	}
	public void setInsti_Name(String insti_Name) {
		this.insti_Name = insti_Name;
	}
	public Grade() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Grade(int id, int insti_id, String insti_Name, String gradeName,
			String gradeDesc) {
		super();
		this.id = id;
		this.insti_id = insti_id;
		this.insti_Name = insti_Name;
		this.gradeName = gradeName;
		this.gradeDesc = gradeDesc;
	}
	public int getCounts() {
		return Counts;
	}
	public void setCounts(int counts) {
		Counts = counts;
	}
	
	

}
