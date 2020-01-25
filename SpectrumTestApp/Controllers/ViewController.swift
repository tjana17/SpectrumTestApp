//
//  ViewController.swift
//  SpectrumTestApp
//
//  Created by MacBookPro on 1/25/20.
//  Copyright © 2020 MacBookPro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var companyModel = [Company]()
    var filteredCompany = [Company]()
    var isSearching : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        getDataFromURL()
        
        //Search Controller
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
    }
    
    func getDataFromURL() {
        // 1. setup url
        let urlString = "https://next.json-generator.com/api/json/get/Vk-LhK44U"
        guard  let url =  URL(string: urlString) else {
            return
        }
        
        // Session Task
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            do{
                //3. Decode Data
                let decoder = JSONDecoder()
                let companies = try decoder.decode([Company].self, from: data)
                //print(companies)
                for model in companies {
                    self.companyModel.append(model)
                }
                
                //4. Dispatch reload tableview
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let jsonError {
                print(jsonError)
            }
        
        
        }.resume()
        
    }
    
    @IBAction func sortingPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "", message: "Sort by", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Ascending", style: .default, handler: { (UIAlertAction) in
            self.companyModel = self.companyModel.sorted(by: { $0.company < $1.company })
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Descending", style: .default, handler: { (UIAlertAction) in
            self.companyModel = self.companyModel.sorted(by: { $0.company > $1.company })
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "membersVC") {
            let destination = segue.destination as! MembersVC
            if let indexPath = tableView.indexPathForSelectedRow?.row {
                if isSearching {
                    destination.members = filteredCompany[indexPath].members
                } else {
                    destination.members = companyModel[indexPath].members
                }
            }
        }
    }


}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredCompany.count : companyModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "companyCell", for: indexPath) as! CompanyCell
        
        if isSearching {
            let searchCompany = filteredCompany[indexPath.row]
            cell.companies = searchCompany
        } else {
            let company = companyModel[indexPath.row]
            cell.companies = company
            
        }
        
        return cell
    }
    
}


extension ViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = (searchController.searchBar.text ?? "")
        if searchText == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        }
        else {
            isSearching = true
            filteredCompany = self.companyModel.filter({ value -> Bool in
                guard let text =  searchController.searchBar.text else { return false }
                return value.company.contains(text.uppercased()) // According to title from JSON
            })
            tableView.reloadData()
        }
    }
    
}
