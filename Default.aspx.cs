using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AirportManagement
{
    public partial class DefaultPage : Page
    {
        private readonly string ConnectionString = ConfigurationManager.ConnectionStrings["AirportDb"].ConnectionString;
        private static readonly Dictionary<string, string> PrimaryKeys = new Dictionary<string, string> {
            {"Airport","Airport_ID"},{"Aircraft","Aircraft_ID"},{"Terminal","Terminal_ID"},{"Gate","Gate_ID"},{"Flight","Flight_ID"}
        };
        private string CurrentTable { get { return ViewState["CurrentTable"] as string ?? "Airport"; } }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadDashboard();
        }

        private SqlConnection OpenConnection() { return new SqlConnection(ConnectionString); }

        protected void DashboardLink_Click(object sender, EventArgs e) { LoadDashboard(); }
        protected void TableLink_Command(object sender, CommandEventArgs e) { LoadTable(Convert.ToString(e.CommandArgument)); }
        protected void RefreshButton_Click(object sender, EventArgs e) { LoadTable(CurrentTable); }

        private void LoadDashboard()
        {
            ViewState["CurrentTable"] = null;
            DashboardPanel.Visible = true; TablePanel.Visible = false; ErrorPanel.Visible = false;
            PageHeading.Text = "Operations overview";
            try
            {
                using (SqlConnection cn = OpenConnection())
                {
                    cn.Open();
                    AirportCount.Text = Count(cn, "Airport");
                    AircraftCount.Text = Count(cn, "Aircraft");
                    TerminalCount.Text = Count(cn, "Terminal");
                    GateCount.Text = Count(cn, "Gate");
                    FlightCount.Text = Count(cn, "Flight");
                    string sql = @"SELECT TOP 8 f.Flight_ID, f.Flight_No, f.[Date], a.Airport_name,
                                   ac.Aircraft_type, g.Gate_No
                                   FROM Flight f
                                   LEFT JOIN Airport a ON a.Airport_ID=f.Airport_ID
                                   LEFT JOIN Aircraft ac ON ac.Aircraft_ID=f.Aircraft_ID
                                   LEFT JOIN Gate g ON g.Gate_ID=f.Gate_ID
                                   ORDER BY f.[Date] DESC, f.Flight_ID DESC";
                    using (SqlDataAdapter da = new SqlDataAdapter(sql, cn))
                    {
                        DataTable dt = new DataTable(); da.Fill(dt); RecentFlights.DataSource = dt; RecentFlights.DataBind();
                    }
                }
            }
            catch (Exception ex) { ShowError(ex); }
        }

        private string Count(SqlConnection cn, string table)
        {
            using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM [" + table + "]", cn))
                return Convert.ToString(cmd.ExecuteScalar());
        }

        private void LoadTable(string table)
        {
            if (!PrimaryKeys.ContainsKey(table)) return;
            ViewState["CurrentTable"] = table;
            DashboardPanel.Visible = false; TablePanel.Visible = true; ErrorPanel.Visible = false;
            PageHeading.Text = table + " management"; TableHeading.Text = table + " records"; Message.Text = "";
            try
            {
                DataTable schema = GetSchema(table);
                RecordsGrid.Columns.Clear();
                foreach (DataColumn col in schema.Columns)
                {
                    if (col.ColumnName == "__PK") continue;
                    BoundField field = new BoundField { DataField = col.ColumnName, HeaderText = col.ColumnName.Replace("_", " ") };
                    RecordsGrid.Columns.Add(field);
                }
                RecordsGrid.DataKeyNames = new string[] { "__PK" };
                CommandField actions = new CommandField { ShowEditButton = true, ShowDeleteButton = true, EditText = "Edit", DeleteText = "Delete", UpdateText = "Save", CancelText = "Cancel" };
                RecordsGrid.Columns.Add(actions);
                RecordsGrid.DataSource = schema; RecordsGrid.DataBind();
                BuildInsertFields(table);
            }
            catch (Exception ex) { ShowError(ex); }
        }

        private DataTable GetSchema(string table)
        {
            DataTable dt = new DataTable();
            using (SqlConnection cn = OpenConnection())
            using (SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM [" + table + "]", cn)) da.Fill(dt);
            dt.Columns.Add("__PK", typeof(string));
            string pk = PrimaryKeys[table];
            foreach (DataRow row in dt.Rows) row["__PK"] = Convert.ToString(row[pk]);
            return dt;
        }

        private void BuildInsertFields(string table)
        {
            InsertFields.Controls.Clear();
            using (SqlConnection cn = OpenConnection())
            using (SqlCommand cmd = new SqlCommand("SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME=@table ORDER BY ORDINAL_POSITION", cn))
            {
                cmd.Parameters.AddWithValue("@table", table); cn.Open();
                using (SqlDataReader r = cmd.ExecuteReader())
                {
                    while (r.Read())
                    {
                        string name = Convert.ToString(r["COLUMN_NAME"]);
                        string type = Convert.ToString(r["DATA_TYPE"]);
                        Label label = new Label { Text = name.Replace("_", " "), CssClass = "field-label" };
                        TextBox input = new TextBox { ID = "input_" + name, CssClass = "field-input" };
                        input.Attributes["placeholder"] = type == "date" ? "YYYY-MM-DD" : "Enter " + name.Replace("_", " ");
                        if (type == "date") input.TextMode = TextBoxMode.Date;
                        if (type == "int") input.TextMode = TextBoxMode.Number;
                        Panel wrap = new Panel { CssClass = "field-wrap" };
                        wrap.Controls.Add(label); wrap.Controls.Add(input); InsertFields.Controls.Add(wrap);
                    }
                }
            }
        }

        protected void InsertButton_Click(object sender, EventArgs e)
        {
            string table = CurrentTable;
            try
            {
                using (SqlConnection cn = OpenConnection())
                using (SqlCommand meta = new SqlCommand("SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME=@t ORDER BY ORDINAL_POSITION", cn))
                {
                    meta.Parameters.AddWithValue("@t", table); cn.Open();
                    List<string> cols = new List<string>(); List<string> vals = new List<string>();
                    using (SqlDataReader r = meta.ExecuteReader())
                    {
                        while (r.Read())
                        {
                            string name = Convert.ToString(r["COLUMN_NAME"]);
                            TextBox box = FindControlRecursive(InsertFields, "input_" + name) as TextBox;
                            string value = box == null ? "" : box.Text.Trim();
                            if (value.Length == 0 && Convert.ToString(r["IS_NULLABLE"]) == "YES") continue;
                            if (value.Length == 0) throw new Exception(name + " is required.");
                            cols.Add("[" + name + "]"); vals.Add("@p" + cols.Count);
                        }
                    }
                    if (cols.Count == 0) throw new Exception("Enter at least one value.");
                    using (SqlCommand insert = new SqlCommand("INSERT INTO [" + table + "] (" + string.Join(",", cols) + ") VALUES (" + string.Join(",", vals) + ")", cn))
                    {
                        for (int i = 0; i < cols.Count; i++)
                        {
                            string col = cols[i].Trim('[', ']');
                            TextBox box = FindControlRecursive(InsertFields, "input_" + col) as TextBox;
                            insert.Parameters.AddWithValue("@p" + (i + 1), box.Text.Trim());
                        }
                        insert.ExecuteNonQuery();
                    }
                }
                Message.Text = "Record added successfully."; Message.CssClass = "message success"; LoadTable(table);
            }
            catch (Exception ex) { Message.Text = "Could not add record: " + ex.Message; Message.CssClass = "message error"; }
        }

        private Control FindControlRecursive(Control root, string id)
        {
            if (root.ID == id) return root;
            foreach (Control child in root.Controls) { Control found = FindControlRecursive(child, id); if (found != null) return found; }
            return null;
        }

        protected void RecordsGrid_RowEditing(object sender, GridViewEditEventArgs e) { RecordsGrid.EditIndex = e.NewEditIndex; LoadTable(CurrentTable); }
        protected void RecordsGrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) { RecordsGrid.EditIndex = -1; LoadTable(CurrentTable); }

        protected void RecordsGrid_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string table = CurrentTable; string pk = PrimaryKeys[table];
            try
            {
                string id = Convert.ToString(RecordsGrid.DataKeys[e.RowIndex].Value);
                List<string> sets = new List<string>();
                using (SqlConnection cn = OpenConnection())
                {
                    cn.Open();
                    using (SqlCommand meta = new SqlCommand("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME=@t AND COLUMN_NAME<>@pk ORDER BY ORDINAL_POSITION", cn))
                    {
                        meta.Parameters.AddWithValue("@t", table); meta.Parameters.AddWithValue("@pk", pk);
                        using (SqlDataReader r = meta.ExecuteReader())
                        {
                            while (r.Read()) sets.Add(Convert.ToString(r[0]));
                        }
                    }
                    GridViewRow row = RecordsGrid.Rows[e.RowIndex];
                    List<string> assignments = new List<string>();
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.Connection = cn; cmd.Parameters.AddWithValue("@id", id);
                        int p = 0;
                        foreach (string col in sets)
                        {
                            int visibleIndex = RecordsGrid.Columns.Cast<DataControlField>().ToList().FindIndex(f => f.HeaderText.Replace(" ", "_") == col);
                            if (visibleIndex < 0) continue;
                            TextBox box = row.Cells[visibleIndex].Controls.OfType<TextBox>().FirstOrDefault();
                            if (box == null) continue;
                            string parameter = "@v" + p++;
                            assignments.Add("[" + col + "]=" + parameter); cmd.Parameters.AddWithValue(parameter, box.Text.Trim());
                        }
                        cmd.CommandText = "UPDATE [" + table + "] SET " + string.Join(",", assignments) + " WHERE [" + pk + "]=@id";
                        if (assignments.Count > 0) cmd.ExecuteNonQuery();
                    }
                }
                RecordsGrid.EditIndex = -1; LoadTable(table); Message.Text = "Record updated."; Message.CssClass = "message success";
            }
            catch (Exception ex) { Message.Text = "Update failed: " + ex.Message; Message.CssClass = "message error"; }
        }

        protected void RecordsGrid_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string table = CurrentTable; string pk = PrimaryKeys[table];
            try
            {
                string id = Convert.ToString(RecordsGrid.DataKeys[e.RowIndex].Value);
                using (SqlConnection cn = OpenConnection())
                using (SqlCommand cmd = new SqlCommand("DELETE FROM [" + table + "] WHERE [" + pk + "]=@id", cn))
                {
                    cmd.Parameters.AddWithValue("@id", id); cn.Open(); cmd.ExecuteNonQuery();
                }
                LoadTable(table); Message.Text = "Record deleted."; Message.CssClass = "message success";
            }
            catch (Exception ex) { Message.Text = "Delete failed. Check whether another record references this row. " + ex.Message; Message.CssClass = "message error"; }
        }

        private void ShowError(Exception ex)
        {
            DashboardPanel.Visible = false; TablePanel.Visible = false; ErrorPanel.Visible = true;
            ErrorText.Text = Server.HtmlEncode(ex.Message);
        }
    }
}