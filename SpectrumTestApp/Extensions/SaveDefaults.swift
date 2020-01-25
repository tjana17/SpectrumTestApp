//
//  SaveDefaults.swift
//  SpectrumTestApp
//
//  Created by MacBookPro on 1/25/20.
//  Copyright © 2020 MacBookPro. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func saveUserDefaults(dict: [String : Any], key: String) {
        let defaults = UserDefaults.standard
        let array = [dict]
        defaults.set(array, forKey: key)
        defaults.synchronize()
    }
    
    public func retrieveDefaults(key: String)-> [String] {
        let defaults = UserDefaults.standard
        let array = defaults.object(forKey: key) as? [String] ?? [String]()
        return array
    }
    
}
