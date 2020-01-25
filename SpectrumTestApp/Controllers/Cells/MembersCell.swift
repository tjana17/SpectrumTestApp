//
//  MembersCell.swift
//  SpectrumTestApp
//
//  Created by MacBookPro on 1/25/20.
//  Copyright © 2020 MacBookPro. All rights reserved.
//

import UIKit

class MembersCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ageLbl : UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    

    var membersList : Member? {
        didSet {
            guard  let membersList = membersList else { return }
            let name = "\(membersList.name.first) \(membersList.name.last)"
            nameLbl.text = name
            ageLbl.text = "Age - \(membersList.age)"
            emailLbl.text = membersList.email
            phoneLbl.text = membersList.phone
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
