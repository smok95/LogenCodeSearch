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
using Microsoft.Win32;

namespace LogenCode
{
    /// <summary>
    /// 2017.06.04 kim,jk 사용자의 요청으로 글꼴설정 기능 추가
    /// 2018.08.20 kim,jk x86으로 빌드해야함.
    /// </summary>
    public partial class LogenCodeForm : Form
    {
        #region Variables
        SQLiteConnection m_dbConn = null;

        #endregion


        public LogenCodeForm()
        {
            InitializeComponent();

            this.Text += " (2018년 5월 현재)";
            //SQLiteConnection.CreateFile("LogenBranchCode.sqlite");
            m_dbConn = new SQLiteConnection("Data Source=LogenBranchCode.sqlite;Version=3;");
            m_dbConn.Open();

            LoadSetting();
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
        
        /// <summary>
        /// 사용자 설정정보 로드
        /// </summary>
        private void LoadSetting()
        {
            string key = Registry.CurrentUser + "\\LogenCode";
            string val = (string)Registry.GetValue(key, "font", "");
            if(!string.IsNullOrEmpty(val))
            {
                TypeConverter converter = TypeDescriptor.GetConverter(typeof(Font));
                // ListView 폰트 설정
                m_listview.Font = (Font)converter.ConvertFromString(val);
            }

            key = key + "\\ColumnWIdth";
            foreach (ColumnHeader hd in m_listview.Columns)
            {
                int w = -1;
                object obj = Registry.GetValue(key, hd.Text, -1);
                if (obj != null)
                    w = (int)obj;
                if (w != -1)
                    hd.Width = w;
            }
        }

        /// <summary>
        /// 사용자 설정정보 저장
        /// </summary>
        private void SaveSetting()
        {
            TypeConverter converter = TypeDescriptor.GetConverter(typeof(Font));
            string key = Registry.CurrentUser + "\\LogenCode";
            string val = (string)converter.ConvertToString(m_listview.Font);
            Registry.SetValue(key, "font", val);

            key = key + "\\ColumnWIdth";
            foreach (ColumnHeader hd in m_listview.Columns)
            {
                Registry.SetValue(key, hd.Text, hd.Width);
            }
        }

        private void OnMenuFontSetting(object sender, EventArgs e)
        {
            FontDialog dlg = new FontDialog();
            if (dlg.ShowDialog() == DialogResult.OK)
            {
                m_listview.Font = dlg.Font;
                // 변경폰트 정보 저장
                SaveSetting();
            }
        }

        private void m_listview_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Right)
            {   
                ContextMenuStrip menu = new ContextMenuStrip();
                menu.Items.Add("글꼴변경", null, OnMenuFontSetting);
                menu.Show(Cursor.Position);
            }
        }

        private void LogenCodeForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            SaveSetting();
        }
    }
}
