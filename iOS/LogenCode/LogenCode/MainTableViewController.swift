/*
 LogenCode, d0nzs00n@gmail.com
 
 Copyright (c) 2017, Kim,Jong-Kook
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are
 met:
 
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 * Neither the name of the <ORGANIZATION> nor the names of its
 contributors may be used to endorse or promote products derived from
 this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER
 OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import UIKit

class MainTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var branches = [Branch]()
    var filteredBranches = [Branch]()
   
    let searchController = UISearchController(searchResultsController: nil);

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // for self-sizing tableview cells
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        
        self.title = "로젠택배 지점코드 조회"
        
        tableView.register(UINib(nibName: "BranchCell", bundle: nil), forCellReuseIdentifier: "BranchCell")
        
        // sqlite파일 열기
        if let filepath = Bundle.main.path(forResource: "LogenBranchCode", ofType: "sqlite"){
            
            if let db = FMDatabase(path: filepath){
             
                if db.open(){
                    let qry = "select category, code, region1, region2, area, color from codelist"
                    let results:FMResultSet? = db.executeQuery(qry, withArgumentsIn: nil)
                    
                    while results?.next() == true{
                        let sCategory = results?.string(forColumnIndex: 0) ?? ""
                        let sCode = results?.string(forColumnIndex: 1) ?? ""
                        let sRegion1 = results?.string(forColumnIndex: 2) ?? ""
                        let sRegion2 = results?.string(forColumnIndex: 3) ?? ""
                        let sArea = results?.string(forColumnIndex: 4) ?? ""
                        let sColor = results?.string(forColumnIndex: 5) ?? ""
                        
                        //print("category='\(sCategory)', code='\(sCode)', region1='\(sRegion1)', region2='\(sRegion2)', area='\(sArea)', color='\(sColor)'")
                        
                        branches.append(Branch(code: sCategory+sCode, city: sRegion1 + "(" + sRegion2 + ")", area: sArea, backColor: sColor))
                    }
                    
                    // 정렬처리
                    branches.sort(by: {$0.code.compare($1.code) == ComparisonResult.orderedAscending})
                }
            }
        }
        
        let rt:CGRect = UIScreen.main.bounds
        
        print("w=\(rt.size.width) , h=\(rt.size.height)")
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.returnKeyType = .done
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredBranches.count
        }
        return branches.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:BranchCell = tableView.dequeueReusableCell(withIdentifier: "BranchCell", for: indexPath) as! BranchCell
        
        let branch:Branch
        
        if searchController.isActive && searchController.searchBar.text != "" {
           branch = filteredBranches[indexPath.row]
        }
        else{
            branch = branches[indexPath.row]
        }
        
        cell.codeLabel?.text = branch.code
        cell.cityLabel?.text = branch.city
        cell.addressLabel?.text = branch.area
        cell.backgroundColor = branch.backColor
        return cell
    }
    
    func filterContextForSearchText(_ searchText:String){
        
        let sArr = searchText.components(separatedBy: " ")
        
        filteredBranches = branches
        
        for text in sArr{
            let t = text.trimmingCharacters(in: .whitespaces)
            
            if t.isEmpty{
                continue
            }
            
            filteredBranches = filteredBranches.filter{branch in
                return branch.area.contains(t) || branch.code.contains(t) || branch.city.contains(t)}
            
            if filteredBranches.count == 0{
                break
            }
        }
        
        print("SearResult count=\(filteredBranches.count)")
    }
    
    // 검색결과 업데이트
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text{
            filterContextForSearchText(text)
            tableView.reloadData()
        }
    }
}

