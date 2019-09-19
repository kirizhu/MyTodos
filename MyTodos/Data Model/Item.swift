//
//  Item.swift
//  MyTodos
//
//  Created by Eddy Garcia on 2019-09-19.
//  Copyright © 2019 Eddy Garcia. All rights reserved.
//

import Foundation
import RealmSwift
class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
