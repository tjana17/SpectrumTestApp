//
//  Name.swift
//  SpectrumTestApp
//
//  Created by MacBookPro on 1/25/20.
//  Copyright © 2020 MacBookPro. All rights reserved.
//

import Foundation

struct Name : Decodable {
    
    let first   : String
    let last    : String
    
    enum CodingKeys: String, CodingKey {
        case first = "first"
        case last = "last"
    }
}
