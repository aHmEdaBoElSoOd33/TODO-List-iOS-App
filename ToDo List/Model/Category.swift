//
//  Category.swift
//  ToDo List
//
//  Created by Ahmed on 05/01/2023.
//

import Foundation
import RealmSwift

class Category : Object {
    
    @objc dynamic var name : String = ""
    let Item = List<Item>()
    
}
