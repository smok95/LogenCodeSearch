using LogenCodeX.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Xamarin.Forms;

namespace LogenCodeX
{
	public partial class MainPage : ContentPage
	{
        private List<CodeList> m_list;

		public MainPage()
		{
			InitializeComponent();

            // DB에서 데이터 로드
            m_list = App.Database.GetItemAsync().Result;
            
            listview.BeginRefresh();
            listview.ItemsSource = m_list;
            listview.EndRefresh();
        }

        public static bool IsHangulJamo(char c)
        {
            // 유니코드 한글 완성형여부 (가 ~ 힣)
            //return (c >= '\xAC00' && c <= '\xD7AF');

            // 자음 또는 모음인지?
            return (c >= '\x3130' && c <= '\x318F');
        }

        void OnTextChanged(object sender, TextChangedEventArgs e)
        {
            listview.BeginRefresh();
            
            // 자음 또는 모음만 입력된 경우 제외처리.
            string filteredStr = "";
            foreach(char c in e.NewTextValue)
            {
                if (!IsHangulJamo(c))
                    filteredStr += c;
            }

            Console.WriteLine("'{0}', '{1}'", e.NewTextValue, filteredStr);

            if (string.IsNullOrWhiteSpace(filteredStr))
                listview.ItemsSource = m_list;
            else
            {
                IEnumerable<CodeList> searchList = m_list.AsEnumerable();
                
                string[] keywords = filteredStr.Split(null);

                foreach(string keyword in keywords)
                {
                    searchList = searchList.Where(k => k.Branch.Contains(keyword) || k.Area.Contains(keyword) || k.Region1.Contains(keyword) ||
                    k.Region2.Contains(keyword));                    
                }

                listview.ItemsSource = searchList;
            }
            listview.EndRefresh();


        }
	}
}
