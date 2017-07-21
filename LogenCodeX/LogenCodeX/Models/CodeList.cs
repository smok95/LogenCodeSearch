using SQLite;
using Xamarin.Forms;

namespace LogenCodeX.Models
{
    public class CodeList
    {
        public string Category { get; set; }
        [PrimaryKey]
        public int Code { get; set; }
        public string Region1 { get; set; }
        public string Region2 { get; set; }
        public string Branch { get; set; }
        public string Area { get; set; }
        public string Color { get; set; }
        
        [Ignore]
        public string DisplayName
        {
            get { return Category + " " + Code; }
        }

        [Ignore]
        public string DisplayArea
        {
            get { return Region1 + "(" + Region2 + ")"; }
        }

        [Ignore]
        public Color BackColor
        {
            get
            {
                return Xamarin.Forms.Color.FromHex(Color);
            }
        }
    }
}
