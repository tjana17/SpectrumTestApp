//
//  CompanyCell.swift
//  SpectrumTestApp
//
//  Created by MacBookPro on 1/25/20.
//  Copyright © 2020 MacBookPro. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell {
    
    @IBOutlet weak var companyNameLbl: UILabel!
    @IBOutlet weak var websiteLbl : UILabel!
    @IBOutlet weak var aboutLbl: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    var companies : Company? {
        didSet {
            guard let companies = companies else { return }
            companyNameLbl.text = companies.company
            websiteLbl.text = companies.website
            aboutLbl.text = companies.about
            logoImageView.loadImageUsingCache(withUrl: companies.logo)
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
