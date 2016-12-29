namespace LogenCode
{
    partial class LogenCodeForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(LogenCodeForm));
            this.m_tbSearch = new System.Windows.Forms.TextBox();
            this.panel1 = new System.Windows.Forms.Panel();
            this.label1 = new System.Windows.Forms.Label();
            this.linkLabelAbout = new System.Windows.Forms.LinkLabel();
            this.m_listview = new LogenCode.ListViewNF();
            this.columnHeader1 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader2 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader3 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader4 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader5 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // m_tbSearch
            // 
            this.m_tbSearch.ImeMode = System.Windows.Forms.ImeMode.Hangul;
            this.m_tbSearch.Location = new System.Drawing.Point(53, 3);
            this.m_tbSearch.Name = "m_tbSearch";
            this.m_tbSearch.Size = new System.Drawing.Size(131, 21);
            this.m_tbSearch.TabIndex = 0;
            this.m_tbSearch.TextChanged += new System.EventHandler(this.m_tbSearch_TextChanged);
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.linkLabelAbout);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Controls.Add(this.m_tbSearch);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel1.Location = new System.Drawing.Point(0, 0);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(661, 27);
            this.panel1.TabIndex = 3;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(6, 6);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(41, 12);
            this.label1.TabIndex = 3;
            this.label1.Text = "검색어";
            // 
            // linkLabelAbout
            // 
            this.linkLabelAbout.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.linkLabelAbout.AutoSize = true;
            this.linkLabelAbout.Location = new System.Drawing.Point(572, 9);
            this.linkLabelAbout.Name = "linkLabelAbout";
            this.linkLabelAbout.Size = new System.Drawing.Size(77, 12);
            this.linkLabelAbout.TabIndex = 4;
            this.linkLabelAbout.TabStop = true;
            this.linkLabelAbout.Text = "프로그램안내";
            this.linkLabelAbout.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.linkLabelAbout_LinkClicked);
            // 
            // m_listview
            // 
            this.m_listview.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.m_listview.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader1,
            this.columnHeader2,
            this.columnHeader3,
            this.columnHeader4,
            this.columnHeader5});
            this.m_listview.Font = new System.Drawing.Font("DotumChe", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(129)));
            this.m_listview.Location = new System.Drawing.Point(0, 30);
            this.m_listview.Name = "m_listview";
            this.m_listview.Size = new System.Drawing.Size(661, 386);
            this.m_listview.TabIndex = 1;
            this.m_listview.UseCompatibleStateImageBehavior = false;
            this.m_listview.View = System.Windows.Forms.View.Details;
            // 
            // columnHeader1
            // 
            this.columnHeader1.Text = "분류";
            this.columnHeader1.Width = 40;
            // 
            // columnHeader2
            // 
            this.columnHeader2.Text = "코드";
            // 
            // columnHeader3
            // 
            this.columnHeader3.Text = "권역";
            // 
            // columnHeader4
            // 
            this.columnHeader4.Text = "지역";
            // 
            // columnHeader5
            // 
            this.columnHeader5.Text = "관할지역";
            this.columnHeader5.Width = 400;
            // 
            // LogenCodeForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(661, 416);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.m_listview);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MinimumSize = new System.Drawing.Size(400, 300);
            this.Name = "LogenCodeForm";
            this.Text = "로젠택배 지점코드 검색";
            this.Load += new System.EventHandler(this.LogenCodeForm_Load);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private ListViewNF m_listview;
        //private System.Windows.Forms.ListView m_listview;
        private System.Windows.Forms.ColumnHeader columnHeader1;
        private System.Windows.Forms.ColumnHeader columnHeader2;
        private System.Windows.Forms.ColumnHeader columnHeader3;
        private System.Windows.Forms.ColumnHeader columnHeader4;
        private System.Windows.Forms.ColumnHeader columnHeader5;
        private System.Windows.Forms.TextBox m_tbSearch;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.LinkLabel linkLabelAbout;
    }
}

