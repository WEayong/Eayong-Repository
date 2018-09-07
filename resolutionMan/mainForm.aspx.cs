using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data.SqlClient;
using System.Data;
using System.Web.Services;

public partial class mainForm : System.Web.UI.Page
{
    SQLHelper sqlhp = new SQLHelper();
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
        Label2.Text ="用户："+Session["teach_name"].ToString()+ "";
        inforPerson();
        if (Request.Form["method"] == "submit")
        {
            string title = Request.QueryString["title"];
            string texa1 = Request.QueryString["texa1"];
            string mainteach = Request.QueryString["userSession"];
            string teach1 = Request.QueryString["teach1"];
            string teach2 = Request.QueryString["teach2"];
            submit(title, texa1,mainteach ,teach1, teach2);
        }
        if (!IsPostBack)
        {
            GridView1.BottomPagerRow.Visible = true;
        }
    }
    //提案表单提交
    [WebMethod]
    public static string submit(string title, string texa1,string mainteach, string teach1, string teach2)
    {
        SqlConnection myconn = GetConn();
        myconn.Open();
        string res=null;
        string date = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");
        string strsql = "insert into applyResolu values('" + title + "','" + texa1+ "','" + mainteach + "','" + teach1 + "','" +teach2 + "','" + date + "')";
        SqlCommand cmd = new SqlCommand(strsql, myconn);
        if (cmd.ExecuteNonQuery() ==1)
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
    protected void abc(object sender, GridViewCommandEventArgs e)
    {
        //if (e.CommandName == "Check")
        //{
        //    int RowIndex = Convert.ToInt32(e.CommandArgument);
        //    GridView1.DataKeyNames = new string[] { "id" };
        //    DataKey keys = GridView1.DataKeys[RowIndex].Value.ToString();      //行中的数据;
        //    string perid = keys.Value.ToString();
        //    Response.Redirect("Login.aspx?id=" + perid);
        //}
    }
    protected void abcd(object sender, EventArgs e)
    {
        string strGrup = ((LinkButton)sender).CommandArgument.ToString();
        SqlConnection myconn = GetConn();
        myconn.Open();
        string strsql = "select * from resolution where id='"+strGrup+"'";
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
        reTitle.InnerText= "标题：" + ds.Tables[0].Rows[0][1].ToString();
        mteach.InnerText= "申请人："+ds1.Tables[0].Rows[0][2].ToString();
        teach1Text.InnerText = "联名人1：" + ds1.Tables[0].Rows[0][3].ToString();
        teach2Text.InnerText = "联名人2：" + ds1.Tables[0].Rows[0][4].ToString();
        mtime.InnerText= "审批时间：" + ds1.Tables[0].Rows[0][5].ToString();
        reContent.InnerText =ds.Tables[0].Rows[0][2].ToString();
        ScriptManager.RegisterStartupScript(this.UpdatePanel3, this.GetType(), "AlertMessage", "$('#checkRes').modal();", true);
        //s_resolution.Attributes.Add("style", "display:none;");
        //ab.Attributes.Add("style", "color:red;");
        //s_resolution.Style["display"] = "none";
        //ab.Style["display"] = "block";
        //ClientScript.RegisterStartupScript(ClientScript.GetType(), "myscript", "<script>hideDiv();</script>");
        // Response.Redirect("mainForm.aspx?Checkid=" + strGrup);

    }
    protected void inforPerson()
    {
        SqlConnection myconn = GetConn();
        myconn.Open();
        string type = "2";
        string strsql= "select * from teachers where teach_num='"+ Session["teach_num"] + "'and userType!='" + type + "' ";
        SqlCommand cmd = new SqlCommand(strsql, myconn);
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);
        sda.Dispose();
        string depart = ds.Tables[0].Rows[0][9].ToString();
        string strsql1 = "select teach_depart from teachDepart where id='"+ depart + "'";
        SqlCommand cmd1 = new SqlCommand(strsql1, myconn);
        SqlDataAdapter sda1 = new SqlDataAdapter(cmd1);
        DataSet ds1 = new DataSet();
        sda1.Fill(ds1);
        inforNum.Value = ds.Tables[0].Rows[0][1].ToString();
        inforName.Value= ds.Tables[0].Rows[0][2].ToString();
        inforSex.Value= ds.Tables[0].Rows[0][3].ToString();
        inforAge.Value= ds.Tables[0].Rows[0][4].ToString();
        inforType.Value= ds.Tables[0].Rows[0][6].ToString();
        inforPhone.Value= ds.Tables[0].Rows[0][7].ToString();
        inforEmail.Value= ds.Tables[0].Rows[0][8].ToString();
        inforDepart.Value= ds1.Tables[0].Rows[0][0].ToString();
        sda1.Dispose();
        myconn.Close();
    }
}