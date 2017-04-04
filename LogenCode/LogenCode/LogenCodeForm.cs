using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SQLite;
using System.Diagnostics;

namespace LogenCode
{
    public partial class LogenCodeForm : Form
    {
        SQLiteConnection m_dbConn = null;
        public LogenCodeForm()
        {
            InitializeComponent();

            this.Text += " (2017년 4월 현재)";
            //SQLiteConnection.CreateFile("LogenBranchCode.sqlite");
            m_dbConn = new SQLiteConnection("Data Source=LogenBranchCode.sqlite;Version=3;");
            m_dbConn.Open();
        }

        ~LogenCodeForm()
        {
            m_dbConn.Close();
        }

        private void m_tbSearch_TextChanged(object sender, EventArgs e)
        {
            // UI갱신 중지
            m_listview.BeginUpdate();
            m_listview.Items.Clear();
            
            string sql = "select category, code, region1,region2,area,color from codelist where region2 like '%" + m_tbSearch.Text + "%' or area like '%" + m_tbSearch.Text + "%'";
            SQLiteCommand cmd = new SQLiteCommand(sql, m_dbConn);
            SQLiteDataReader rd = cmd.ExecuteReader();
            while (rd.Read())
            {
                Console.WriteLine((string)rd[5]);
                ListViewItem item = new ListViewItem((string)rd[0]);
                item.SubItems.Add(rd[1].ToString());
                item.SubItems.Add((string)rd[2]);
                item.SubItems.Add((string)rd[3]);
                item.SubItems.Add((string)rd[4]);
                string rgb = (string)rd[5];
                Debug.Print(rgb);
                item.BackColor = Color.FromArgb(
                    Convert.ToInt32(rgb.Substring(0,2), 16),
                    Convert.ToInt32(rgb.Substring(2,2),16),
                    Convert.ToInt32(rgb.Substring(4,2), 16)
                    );
                //item.SubItems.Add(rd[5]);
                m_listview.Items.Add(item);
            }
            m_listview.EndUpdate();
        }

        private void LogenCodeForm_Load(object sender, EventArgs e)
        {
            this.ActiveControl = m_tbSearch;
        }

        private void linkLabelAbout_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            string msg =

                "문의 : d0nzs00n@gmail.com\r\n" +
                "\r\n사용법\r\n" +
                "예) '인천시 남동구 만수1동' \r\n" +
                "만수1동 -> 남동구 -> 인천 순서로 검색하시면 됩니다.";
            MessageBox.Show(msg);
        }
    }
}
