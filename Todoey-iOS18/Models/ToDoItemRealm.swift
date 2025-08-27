//
//  ToDoItems.swift
//  Todoey-iOS18
//
//  Created by SKK Staf on 27/08/25.
//

import RealmSwift

class ToDoItemRealm: Object {
    @Persisted var title: String = ""
    @Persisted var done: Bool = false
    @Persisted var parentCategory = LinkingObjects(fromType: CategoryRealm.self, property: "name")
}
