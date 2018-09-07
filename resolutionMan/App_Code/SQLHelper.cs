using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.ComponentModel;
using System.Web.Security;
using System.Web.UI.WebControls;
using System.Linq;
using System.Web;

/// <summary>
/// SQLHelper 的摘要说明
/// </summary>
public class SQLHelper
{
    private SqlConnection conn = null;
    private readonly string temp = "temp";
     private void Open()
        {
            if (conn == null)
            {
                conn = new System.Data.SqlClient.SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["SqlConnStr"].ToString());
            }
            if (conn.State == ConnectionState.Closed)
            {
                try
                {
                    conn.Open();
                }
                catch (Exception ex)
                {

                    throw new Exception(ex.Message);
                }
                finally
                {
                    Close();
                }
            }
        }
    public void Close()
    {
        if (conn != null)
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
        }
    }
    public void Dispose()
    {
        if (conn != null)
        {
            conn.Dispose();
            conn = null;
        }
    }
    public string ExcuteSqlReturn(string cmdText)
    {
        string strRenturn = "";
        SqlCommand cmd = CreateSQLCommand(cmdText, null);
        try
        {
            strRenturn = cmd.ExecuteScalar().ToString();
        }
        catch (Exception ex)
        {

            throw new Exception(ex.Message);
        }
        finally
        {
            Close();
        }
        return strRenturn;
    }
    public int ExcuteSQL(string cmdText,params SqlParameter[] prams)
    {
        SqlCommand cmd = CreateSQLCommand(cmdText, prams);
        try
        {
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {

            throw new Exception(ex.Message);
        }
        finally
        {
            Close();
        }
        return (int)cmd.Parameters[temp].Value;
    }
    public void ExcuteSQL(string cmdText, ref DataSet dataSet)
    {
        
        if (dataSet == null)
        {
            dataSet = new DataSet();
        }
        SqlDataAdapter da = CreateSQLDataAdapter(cmdText, null);
        try
        {
            da.Fill(dataSet);
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        finally
        {
            Close();
        }
    }
    private SqlCommand CreateSQLCommand(string cmdText,SqlParameter[] prams)
    {
        Open();
        SqlCommand cmd = new SqlCommand(cmdText, conn);
        if (prams != null)
        {
            foreach(SqlParameter parameter in prams)
            {
                cmd.Parameters.Add(parameter);
            }
        }
        cmd.Parameters.Add(new SqlParameter(temp, SqlDbType.Int, 4, ParameterDirection.ReturnValue, false, 0, 0, string.Empty, DataRowVersion.Default, null));
        return cmd;
    }
    private SqlDataAdapter CreateSQLDataAdapter(string cmdText, SqlParameter[] prams)
    {
        Open();
        SqlDataAdapter da = new SqlDataAdapter(cmdText, conn);
        if (prams != null)
        {
            foreach (SqlParameter parameter in prams)
            {
                da.SelectCommand.Parameters.Add(parameter);
            }
        }
        da.SelectCommand.Parameters.Add(new SqlParameter(temp, SqlDbType.Int, 4, ParameterDirection.ReturnValue, false, 0, 0, string.Empty, DataRowVersion.Default, null));
        return da;
    }
    public void BindGV(GridView gv,string sqlstring)
    {
        DataSet dataSet = new DataSet();
        ExcuteSQL(sqlstring, ref dataSet);
        gv.DataSource = dataSet;
        try
        {
            gv.DataBind();
        }
        catch (Exception ex)
        {

            throw new Exception(ex.Message);
        }
        finally
        {
            conn.Close();
        }
    }
}

