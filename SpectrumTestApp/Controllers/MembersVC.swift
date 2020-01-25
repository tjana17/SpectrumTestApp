//
//  MembersVC.swift
//  SpectrumTestApp
//
//  Created by MacBookPro on 1/25/20.
//  Copyright © 2020 MacBookPro. All rights reserved.
//

import UIKit

class MembersVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var members = [Member]()
    var filteredMembers = [Member]()
    var isSearching: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.tableFooterView = UIView()
        
        // Search Controller
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
    }
    
    @IBAction func sortingPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "", message: "Sory by name / age", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Name : Ascending", style: .default , handler:{ (UIAlertAction)in
            self.members = self.members.sorted(by: { $0.name.first < $1.name.first })
            self.tableView.reloadData();
        }))
        
        alert.addAction(UIAlertAction(title: "Name : Descending", style: .default , handler:{ (UIAlertAction)in
            self.members = self.members.sorted(by: { $0.name.first > $1.name.first })
            self.tableView.reloadData();
        }))
        
        alert.addAction(UIAlertAction(title: "Age : Ascending", style: .default , handler:{ (UIAlertAction)in
            self.members = self.members.sorted(by: { $0.age < $1.age })
            self.tableView.reloadData();
        }))
        
        alert.addAction(UIAlertAction(title: "Age : Descending", style: .default , handler:{ (UIAlertAction)in
            self.members = self.members.sorted(by: { $0.age > $1.age })
            self.tableView.reloadData();
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
}

extension MembersVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredMembers.count : members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath) as! MembersCell
        
        if isSearching {
            let searchMember = filteredMembers[indexPath.row]
            cell.membersList = searchMember
        } else {
            let member = members[indexPath.row]
            cell.membersList = member
        }
        
        return cell
    }
    
    // Swipe cell to add favorites
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           // action code for the Favorites
           let favorites = UIContextualAction(style: .normal, title:  "Favorites", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
               print("Update action ...")
               self.addFavorites(indexPath: indexPath)
               success(true)
           })
           favorites.backgroundColor = .orange
           
           return UISwipeActionsConfiguration(actions: [favorites])
       }
       
    func addFavorites(indexPath: IndexPath) {
        
        let favMember = members[indexPath.row]
        let name = "\(favMember.name.first)  \(favMember.name.last)"
        let memberDict = ["name": name, "age": favMember.age,"email": favMember.email,"_id":favMember.id,"phone":favMember.phone] as [String : Any]
        saveUserDefaults(dict: memberDict, key: "FavoriteMember")
        
    }
    
}


extension MembersVC : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //print("Searching with: " + (searchController.searchBar.text ?? ""))
        let searchText = (searchController.searchBar.text ?? "")
        if searchText == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        }
        else {
            isSearching = true
            filteredMembers = self.members.filter({ value -> Bool in
                guard let text =  searchController.searchBar.text else { return false }
                let name = "\(value.name.first) \( value.name.last)"
                return name.contains(text) // According to members name
                
            })
            tableView.reloadData()
        }
    }
}
