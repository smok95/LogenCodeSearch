using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;

// 성능향상팁, https://blog.xamarin.com/5-ways-boost-xamarin-forms-app-startup-time/
[assembly: XamlCompilation(XamlCompilationOptions.Compile)]
namespace LogenCodeX
{
	public partial class App : Application
	{
        static Data.LogenCodeDB g_db;
		public App ()
		{
			InitializeComponent();

			MainPage = new LogenCodeX.MainPage();
		}

        public static Data.LogenCodeDB Database
        {
            get
            {
                if (g_db == null)
                    g_db = new Data.LogenCodeDB(DependencyService.Get<IFileHelper>().GetLocalFilePath("LogenBranchCode.sqlite"));
                return g_db;
            }
        }

		protected override void OnStart ()
		{
			// Handle when your app starts
		}

		protected override void OnSleep ()
		{
			// Handle when your app sleeps
		}

		protected override void OnResume ()
		{
			// Handle when your app resumes
		}
	}
}
