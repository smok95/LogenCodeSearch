using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Android.App;
using Android.Content;
using Android.OS;
using Android.Runtime;
using Android.Views;
using Android.Widget;

namespace LogenCodeX.Droid
{
    [Activity(Label="로젠택배 지점코드",Theme = "@android:style/Theme.NoTitleBar", MainLauncher =true, NoHistory =true)]
    public class SplashActivity : Activity
    {
        protected override void OnCreate(Bundle savedInstanceState)
        {
            base.OnCreate(savedInstanceState);            
            SetContentView(Resource.Layout.SplashScreen);
            FindViewById<TextView>(Resource.Id.txtAppVersion).Text = $"Version {PackageManager.GetPackageInfo(PackageName, 0).VersionName}";
            //System.Threading.Thread.Sleep(3000);
            StartActivity(typeof(MainActivity));
        }
    }
}