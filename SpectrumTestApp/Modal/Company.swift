//
//  Company.swift
//  SpectrumTestApp
//
//  Created by MacBookPro on 1/25/20.
//  Copyright © 2020 MacBookPro. All rights reserved.
//

import Foundation

struct  Company : Decodable {
    
    let id      : String
    let about   : String
    let company : String
    let logo    : String
    let members : [Member]
    let website : String
    
    enum CodingKeys: String, CodingKey {
        case id         = "_id"
        case about      = "about"
        case company    = "company"
        case logo       = "logo"
        case members    = "members"
        case website    = "website"
    }

}
