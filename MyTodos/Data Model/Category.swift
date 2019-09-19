//
//  Category.swift
//  MyTodos
//
//  Created by Eddy Garcia on 2019-09-19.
//  Copyright © 2019 Eddy Garcia. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}

