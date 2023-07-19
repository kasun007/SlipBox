//
//  Status.swift
//  SlipBox
//
//  Created by Kasun Wickramanayake on 19/07/23.
//

import Foundation
enum Status :String,Identifiable,CaseIterable{
    case draft = "Draft"
    case review = "Review"
    case archived = "Archived"
    
    var id:String{
        return self.rawValue
    }
    
    
}
