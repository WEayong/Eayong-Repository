using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class managerMainform : System.Web.UI.Page
{
    SQLHelper sqlhp = new SQLHelper();
    static string index = null;
    public static SqlConnection GetConn()
    {
        string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["SqlConnStr"].ConnectionString;
        SqlConnection myconn = new SqlConnection(constr);
        return myconn;
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Session.Timeout = 30;
        Response.AddHeader("Refresh", Convert.ToString((Session.Timeout * 60) + 5));
        if (Session["teach_name"].ToString() == null)
        {
            Response.Redirect("Login.aspx");
        }
        Label2.Text = "用户：" + Session["teach_name"].ToString() + "";
        inforPerson();
        if (Request.Form["method"] == "addUser")
        {
            string userNum= Request.QueryString["userNum"];
            string userName = Request.QueryString["userName"];
            string userAge = Request.QueryString["userAge"];
            string userSex = Request.QueryString["userSex"];
            string userPhone = Request.QueryString["userPhone"];
            string userType = Request.QueryString["userType"];
            string userEmail = Request.QueryString["userEmail"];
            string userPwd = Request.QueryString["userPwd"];
            string Depart = Request.QueryString["Depart"];
            addUser(userNum, userName, userAge, userSex, userPhone, userType, userEmail, userPwd, Depart);
        }
        if (!IsPostBack)
        {
            GridView1.BottomPagerRow.Visible = true;
            GridView2.BottomPagerRow.Visible = true;
        }
    }
    [WebMethod]
    public static string addUser(string userNum, string userName, string userAge, string userSex, string userPhone, string userType, string userEmail, string userPwd, string Depart)
    {
        SqlConnection myconn = GetConn();
        myconn.Open();
        string strsql = "insert into teachers values('" + userNum + "','"+ userName + "','" + userSex + "','" + userAge + "','" + userPwd + "','" + userType + "','" + userPhone + "','" + userEmail + "','" + Depart + "')";
        string res = null;
        SqlCommand cmd = new SqlCommand(strsql, myconn);
        if (cmd.ExecuteNonQuery() == 1)
        {
            res = "1";
        }else 
        {
            res = "2";
        }
        cmd.Dispose();
        myconn.Close();
        return res;
    }
    protected void inforPerson()
    {
        SqlConnection myconn = GetConn();
        myconn.Open();
        string type = "2";
        string strsql = "select * from teachers where teach_num='" + Session["teach_num"] + "'and userType='" + type + "' ";
        SqlCommand cmd = new SqlCommand(strsql, myconn);
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);
        sda.Dispose();
        string depart = ds.Tables[0].Rows[0][9].ToString();
        string strsql1 = "select teach_depart from teachDepart where id='" + depart + "'";
        SqlCommand cmd1 = new SqlCommand(strsql1, myconn);
        SqlDataAdapter sda1 = new SqlDataAdapter(cmd1);
        DataSet ds1 = new DataSet();
        sda1.Fill(ds1);
        sda1.Dispose();
        string strsql2 = "select uesrType from userType where id='" + ds.Tables[0].Rows[0][6] + "'";
        SqlCommand cmd2 = new SqlCommand(strsql2, myconn);
        SqlDataAdapter sda2 = new SqlDataAdapter(cmd2);
        DataSet ds2 = new DataSet();
        sda2.Fill(ds2);
        inforNum.Value = ds.Tables[0].Rows[0][1].ToString();
        inforName.Value = ds.Tables[0].Rows[0][2].ToString();
        inforSex.Value = ds.Tables[0].Rows[0][3].ToString();
        inforAge.Value = ds.Tables[0].Rows[0][4].ToString();
        inforType.Value = ds2.Tables[0].Rows[0][0].ToString();
        inforPhone.Value = ds.Tables[0].Rows[0][7].ToString();
        inforEmail.Value = ds.Tables[0].Rows[0][8].ToString();
        inforDepart.Value = ds1.Tables[0].Rows[0][0].ToString();
        sda1.Dispose();
        myconn.Close();
    }
    protected void s_Resolu(object sender, EventArgs e)
    {
        string strGrup = ((LinkButton)sender).CommandArgument.ToString();
        SqlConnection myconn = GetConn();
        myconn.Open();
        string strsql = "select * from resolution where id='" + strGrup + "'";
        SqlCommand cmd = new SqlCommand(strsql, myconn);
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);
        sda.Dispose();
        string sql = "SELECT C.id, C.resoluTitle, D.teach_name, A.teach_name, B.teach_name, C.subTime FROM resolution AS C INNER JOIN teachers AS A ON C.teach1 = A.id INNER JOIN teachers AS B ON C.teach2 = B.id INNER JOIN teachers AS D ON C.mainteach = D.id where C.id='" + strGrup + "'";
        //string strsql1= "select teach_name from teachers where id='" + ds.Tables[0].Rows[0][3].ToString() + "'";
        SqlCommand cmd1 = new SqlCommand(sql, myconn);
        SqlDataAdapter sda1 = new SqlDataAdapter(cmd1);
        DataSet ds1 = new DataSet();
        sda1.Fill(ds1);
        sda1.Dispose();
        reTitle.InnerText = "标题：" + ds.Tables[0].Rows[0][1].ToString();
        mteach.InnerText = "申请人：" + ds1.Tables[0].Rows[0][2].ToString();
        teach1Text.InnerText = "联名人1：" + ds1.Tables[0].Rows[0][3].ToString();
        teach2Text.InnerText = "联名人2：" + ds1.Tables[0].Rows[0][4].ToString();
        mtime.InnerText = "审批时间："+ds.Tables[0].Rows[0][6].ToString();
        reContent.InnerText = ds.Tables[0].Rows[0][2].ToString();
        ScriptManager.RegisterStartupScript(this.UpdatePanel3, this.GetType(), "AlertMessage", "$('#checkRes').modal();", true);
        //s_resolution.Attributes.Add("style", "display:none;");
        //ab.Attributes.Add("style", "color:red;");
        //s_resolution.Style["display"] = "none";
        //ab.Style["display"] = "block";
        //ClientScript.RegisterStartupScript(ClientScript.GetType(), "myscript", "<script>hideDiv();</script>");
        // Response.Redirect("mainForm.aspx?Checkid=" + strGrup);

    }
    protected void s_Resolu2(object sender, EventArgs e)
    {
        string strGrup = ((LinkButton)sender).CommandArgument.ToString();
        SqlConnection myconn = GetConn();
        myconn.Open();
        index = strGrup;
        string strsql = "select * from applyResolu where id='" + strGrup + "'";
        SqlCommand cmd = new SqlCommand(strsql, myconn);
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);
        sda.Dispose();
        string sql = "SELECT C.id, C.resoluTitle, D.teach_name, A.teach_name AS Expr1, B.teach_name AS Expr2, C.time FROM applyResolu AS C INNER JOIN teachers AS A ON C.teach1 = A.id INNER JOIN teachers AS B ON C.teach2 = B.id INNER JOIN teachers AS D ON C.mainteach = D.id where C.id='" + strGrup + "'";
        //string strsql1= "select teach_name from teachers where id='" + ds.Tables[0].Rows[0][3].ToString() + "'";
        SqlCommand cmd1 = new SqlCommand(sql, myconn);
        SqlDataAdapter sda1 = new SqlDataAdapter(cmd1);
        DataSet ds1 = new DataSet();
        sda1.Fill(ds1);
        sda1.Dispose();
        reTitle2.InnerText = "标题：" + ds.Tables[0].Rows[0][1].ToString();
        mteach2.InnerText = "申请人：" + ds1.Tables[0].Rows[0][2].ToString();
        teach1Text2.InnerText = "联名人1：" + ds1.Tables[0].Rows[0][3].ToString();
        teach2Text2.InnerText = "联名人2：" + ds1.Tables[0].Rows[0][4].ToString();
        mtime2.InnerText = "提交时间："+ds.Tables[0].Rows[0][6].ToString();
        reContent2.InnerText = ds.Tables[0].Rows[0][2].ToString();
        ScriptManager.RegisterStartupScript(this.UpdatePanel3, this.GetType(), "AlertMessage", "$('#opRes').modal();", true);
        //s_resolution.Attributes.Add("style", "display:none;");
        //ab.Attributes.Add("style", "color:red;");
        //s_resolution.Style["display"] = "none";
        //ab.Style["display"] = "block";
        //ClientScript.RegisterStartupScript(ClientScript.GetType(), "myscript", "<script>hideDiv();</script>");
        // Response.Redirect("mainForm.aspx?Checkid=" + strGrup);

    }
    protected void applyResolu(object sender,EventArgs e)
    {
        if (T_yes.Checked == true)
        {
            string res = null;
            // string strGrup = ((LinkButton)sender).CommandArgument.ToString();
            SqlConnection myconn = GetConn();
            myconn.Open();
            string strsql = "select * from applyResolu where id='" + index + "'";
            SqlCommand cmd = new SqlCommand(strsql, myconn);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            sda.Dispose();
            string strsql1 = "insert into resolution values('" + ds.Tables[0].Rows[0][1].ToString() + "','" + ds.Tables[0].Rows[0][2].ToString() + "','" + ds.Tables[0].Rows[0][3].ToString() + "','" + ds.Tables[0].Rows[0][4].ToString() + "','" + ds.Tables[0].Rows[0][5].ToString() + "','" + ds.Tables[0].Rows[0][6].ToString() + "')";
            string sql = "Delete FROM applyResolu WHERE id='" + ds.Tables[0].Rows[0][0].ToString() + "'";
            SqlCommand cmd2 = new SqlCommand(strsql1, myconn);
            if (cmd2.ExecuteNonQuery() == 1)
            {
                //res = "1";
                Response.Write("<script language='javascript' > alert('审批成功！');</script>");
                SqlCommand cmd1 = new SqlCommand(sql, myconn);
                cmd1.ExecuteNonQuery();
                cmd1.Dispose();
                Server.Transfer("managerMainform.aspx");
            }
            else
            {
                //res = "2";
                Response.Write("<script language='javascript' > alert('审批失败，请重试！');</script>");
            }
            cmd.Dispose();
            cmd2.Dispose();
            myconn.Close();
        }else if(T_no.Checked==true)
        {
            Response.Write("<script language='javascript' > alert('审批不通过！');</script>");
            return;
        }
        else
        {
            Response.Write("<script language='javascript' > alert('请选择审批意见！');</script>");
            return;
        }
    }
}