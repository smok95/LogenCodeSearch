using System;
using System.Collections.Generic;
using System.Text;
using SQLite;
using LogenCodeX.Models;
using System.Threading.Tasks;

namespace LogenCodeX.Data
{
    public class LogenCodeDB
    {
        readonly SQLiteAsyncConnection m_db;
        
        public LogenCodeDB(string dbPath)
        {
            m_db = new SQLiteAsyncConnection(dbPath, SQLiteOpenFlags.ReadOnly);
        }

        public Task<List<CodeList>> GetItemAsync()
        {
            return m_db.Table<CodeList>().ToListAsync();
        }
    }
}
