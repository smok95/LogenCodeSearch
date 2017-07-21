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
using System.IO;
using Android.Content.Res;
using Xamarin.Forms;
using LogenCodeX.Droid;

[assembly:Dependency(typeof(FileHelper))]
namespace LogenCodeX.Droid
{
    public class FileHelper : IFileHelper
    {
        public string GetLocalFilePath(string filename)
        {
            string path = System.Environment.GetFolderPath(System.Environment.SpecialFolder.Personal);
            string dbpath = Path.Combine(path, filename);

            if (!File.Exists(dbpath))
            {
                AssetManager assets = Android.App.Application.Context.Assets;
                using (var br = new BinaryReader(assets.Open(filename)))
                {
                    using (var bw = new BinaryWriter(new FileStream(dbpath, FileMode.Create)))
                    {
                        byte[] buffer = new byte[2048];
                        int len = 0;
                        while ((len = br.Read(buffer, 0, buffer.Length)) > 0)
                            bw.Write(buffer, 0, len);
                    }
                }
            }
            return dbpath;
        }
    }
}