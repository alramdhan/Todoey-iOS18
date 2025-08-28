//
//  Category.swift
//  Todoey-iOS18
//
//  Created by SKK Staf on 27/08/25.
//

import Foundation
import RealmSwift

class CategoryRealm: Object {
    @Persisted var name: String = ""
    @Persisted var colour: String = ""
    @Persisted var items = List<ToDoItemRealm>()
}
