//
//  Item.swift
//  Todoey
//
//  Created by Le Hoang Anh on 29/01/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @Persisted var title: String = ""
    @Persisted var done: Bool = false
    @Persisted var dateCreated: Date?
    
    @Persisted(originProperty: "items") var parentCategory: LinkingObjects<Category>
}
