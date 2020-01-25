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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        getDataFromURL()
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
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "membersVC") {
            let destination = segue.destination as! MembersVC
            if let indexPath = tableView.indexPathForSelectedRow?.row {
                destination.members = companyModel[indexPath].members
            }
        }
    }


}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companyModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "companyCell", for: indexPath) as! CompanyCell
        
        let company = companyModel[indexPath.row]
        cell.companies = company
        
        return cell
    }
    
}
