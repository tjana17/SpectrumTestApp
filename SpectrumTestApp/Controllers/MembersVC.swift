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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.tableFooterView = UIView()
    }
    
}

extension MembersVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath) as! MembersCell
        
        let member = members[indexPath.row]
        cell.membersList = member
        
        return cell
    }
}
