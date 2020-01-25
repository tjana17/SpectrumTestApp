//
//  Member.swift
//  SpectrumTestApp
//
//  Created by MacBookPro on 1/25/20.
//  Copyright © 2020 MacBookPro. All rights reserved.
//

import Foundation

struct Member : Decodable {
    
    let id      : String
    let age     : Int
    let email   : String
    let name    : Name
    let phone   : String
    
    enum CodingKeys : String, CodingKey {
        case id     = "_id"
        case age    = "age"
        case email  = "email"
        case name   = "name"
        case phone  = "phone"
    }
}
