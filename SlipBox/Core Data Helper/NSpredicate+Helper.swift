//
//  NSpredicate+Helper.swift
//  SlipBox
//
//  Created by Kasun Wickramanayake on 12/07/23.
//

import Foundation

extension NSPredicate {
    
    static let all = NSPredicate(format: "TRUEPREDICATE")
    static let none = NSPredicate(format: "FALSEPREDICATE")
}
