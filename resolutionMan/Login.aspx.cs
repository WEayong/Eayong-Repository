using System;
using System.Data.SqlClient;
using System.Data;
using System.Web.Services;
using System.Web.UI;
using System.Web;

public partial class Login : System.Web.UI.Page
{
    public static SqlConnection GetConn()
    {
        string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["SqlConnStr"].ConnectionString;
        SqlConnection myconn = new SqlConnection(constr);
        return myconn;
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Response.Clear();
        if (Request.QueryString["teachloginnum"] != null)
        {

            string username = Request.QueryString["teachloginnum"];
            string pwd = Request.QueryString["teachpwd"];
            string usertype = Request.QueryString["usertype"];
            string type = "2";
            SqlConnection connection = GetConn();
            string strsql=null;
            string res ;
            if (usertype == "undefined")
            {
                res = "4";
                Response.Write(res);
                Response.End();
            }
            else
            {
                if (usertype == "普通用户")
                {
                    strsql = "select * from teachers where teach_num='" + username + "'and teach_password='" + pwd + "' and userType!='"+type+"'";
                }
                else if (usertype == "管理员")
                {
                    strsql = "select * from teachers where teach_num='" + username + "'and teach_password='" + pwd + "' and userType='" + type + "'";
                }
                SqlCommand cmd = new SqlCommand(strsql, connection);
                connection.Open();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);
                if (ds.Tables[0].Rows.Count == 0)
                {
                    res = "2";//用户名或密码错误
                }
                else if (ds.Tables[0].Rows.Count == 1)
                {
                    Session["id"]= ds.Tables[0].Rows[0][0];
                    Session["teach_num"] = ds.Tables[0].Rows[0][1];
                    Session["teach_name"] = ds.Tables[0].Rows[0][2];
                    Session["teach_password"] = ds.Tables[0].Rows[0][5];
                    res = "1";
                }
                else
                {
                    res = "3";
                }
                connection.Close();
                Response.Write(res);
                Response.End();
            }
        }
        /*
         *用户注册代码
         *       
        this.Response.Clear();
        if (Request.QueryString["teachloginnum"] != null)
        {
            string name = Request.QueryString["teachloginnum"].ToString();
            SqlConnection connection = GetConn();
            string res = string.Empty;
            string strsql = "select * from teachers where teach_num='" + name + "'";
            SqlCommand cmd = new SqlCommand(strsql, connection);
            connection.Open();
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            if (ds.Tables[0].Rows.Count == 0)
            {
                res = "1";
            }else
            {
                res = "0";
            }
        Response.Write(res);
        Response.End();

        }*/



    }
    
    /*protected void btnLogin_Click(object sender, EventArgs e)
    {
        SqlConnection connection = GetConn();
        if (teachloginnum.Value.ToString() != string.Empty && teachpwd.Value.ToString()!= string.Empty)
        {
            if (T_user.Checked == false && C_user.Checked == false)
            {
                Response.Write("<script language='javascript' > alert('请选择用户类型！');</script>");
            }
            else
            {
                if (T_user.Checked == true)
                {

                    string strsql = "select * from teachers where teach_num='" + teachloginnum.Value.ToString() + "'and teach_password='" + teachpwd.Value.ToString() + "'";
                    SqlCommand cmd = new SqlCommand(strsql, connection);
                    connection.Open();
                    // SqlDataReader dr = cmd.ExecuteReader();
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    sda.Fill(ds);
                    string loginname = teachloginnum.Value.ToString();
                    string loginpwd = teachpwd.Value.ToString();
                    if (ds.Tables[0].Rows.Count == 0)
                    {
                        Response.Write("<script language='javascript' > alert('用户名或密码错误！');</script>");
                    }
                    else
                    {
                        if (loginname ==ds.Tables[0].Rows[0][1].ToString() && loginpwd ==ds.Tables[0].Rows[0][5].ToString())
                        {
                            Session["teach_num"] = ds.Tables[0].Rows[0][1];
                            Session["teach_name"] = ds.Tables[0].Rows[0][2];
                            Session["teach_password"] = ds.Tables[0].Rows[0][5];
                            Server.Transfer("mainForm.aspx");
                        }
                        else
                        {
                            Response.Write("<script language='javascript' > alert('用户名或密码错误！');</script>");
                        }
                    }
                }
                else if (C_user.Checked == true)
                {

                    string strsql = "select * from administrators where admin_num='" + teachloginnum.Value.ToString() + "'and admin_password='" + teachpwd.Value.ToString() + "'";
                    SqlCommand cmd = new SqlCommand(strsql, connection);
                    connection.Open();
                    // SqlDataReader dr = cmd.ExecuteReader();
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    sda.Fill(ds);
                    string loginname = teachloginnum.Value.ToString();
                    string loginpwd = teachpwd.Value.ToString();
                    if (ds.Tables[0].Rows.Count == 0)
                    {
                        Response.Write("<script language='javascript' > alert('用户名或密码错误！');</script>");
                    }

                    else
                    {
                        if (loginname ==ds.Tables[0].Rows[0][1].ToString() && loginpwd == ds.Tables[0].Rows[0][5].ToString())
                        {
                            Session["teach_num"] = ds.Tables[0].Rows[0][1];
                            Session["teach_name"] = ds.Tables[0].Rows[0][2];
                            Session["teach_password"] = ds.Tables[0].Rows[0][5];
                            Server.Transfer("managerMainform.aspx");
                        }
                        else
                        {
                            Response.Write("<script language='javascript' > alert('用户名或密码错误！');</script>");
                        }
                    }
                }
            }
        }
        else
        {
            Response.Write("<script language='javascript' > alert('用户名和密码不能为空！');</script>");
        }
        
            connection.Close();
        
    }*/
}