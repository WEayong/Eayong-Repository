package eayong.Model;

public class Institute {
	private int id;
	private String insti_Name;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getInsti_Name() {
		return insti_Name;
	}
	public void setInsti_Name(String insti_Name) {
		this.insti_Name = insti_Name;
	}
	public Institute(int id, String insti_Name) {
		super();
		this.id = id;
		this.insti_Name = insti_Name;
	}
	public Institute() {
		super();
		// TODO Auto-generated constructor stub
	}
}
