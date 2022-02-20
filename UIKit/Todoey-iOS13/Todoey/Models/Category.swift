//
//  Category.swift
//  Todoey
//
//  Created by Le Hoang Anh on 29/01/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @Persisted var name: String = ""
    @Persisted var items: List<Item>
}
