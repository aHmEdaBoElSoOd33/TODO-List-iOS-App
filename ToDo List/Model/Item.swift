//
//  Item.swift
//  ToDo List
//
//  Created by Ahmed on 04/01/2023.
//

import Foundation
import RealmSwift
class Item : Object {
    
    @objc dynamic var name : String = ""
    @objc dynamic var checked : Bool = false
    let perant = LinkingObjects(fromType: Category.self, property: "Item")
}
