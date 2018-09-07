package eayong.Model;

public class User {
	private int id;
	private String userName;
	private String password;
	private String verifyCode;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getVerifyCode() {
		return verifyCode;
	}
	public void setVerifyCode(String verifyCode) {
		this.verifyCode = verifyCode;
	}
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}
	public User(int id, String userName, String password, String verifyCode) {
		super();
		this.id = id;
		this.userName = userName;
		this.password = password;
		this.verifyCode = verifyCode;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", userName=" + userName + ", password="
				+ password + ", verifyCode=" + verifyCode + "]";
	}
	
}
