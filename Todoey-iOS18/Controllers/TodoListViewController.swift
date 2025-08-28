//
//  ViewController.swift
//  Todoey-iOS18
//
//  Created by Dika Alfarell on 18/08/25.
//

import UIKit
//import CoreData
import RealmSwift

class TodoListViewController: SwipeTableViewController {
    let realm = try! Realm()
    var todoItems: Results<ToDoItemRealm>? //ToDoItem by Core Data
    var selectedCategory: CategoryRealm? { //Category by Core Data
        didSet {
            loadItems()
        }
    }
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
//    let defaults = UserDefaults.standard
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewWillAppear(_ animated: Bool) {
        initNavigationBar(self.navigationController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        if let items = defaults.array(forKey: "TodoListArray") as? [ToDoItem] {
//            itemArray = items
//        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        itemArray[indexPath.row].setValue("Completed", forKey: "title") // for update data Core Data and still to call context.save()
//        context.delete(itemArray[indexPath.row]) // untuk menghapus dari Core Data dan perlu memanggil code context.save()
//        itemArray.remove(at: indexPath.row) // untuk delete dari array untuk update tampilan tanpa menyentuh Core Data
//        itemArray?[indexPath.row].done = !itemArray?[indexPath.row].done
//        saveItem()
        
        //update data dengan Realm
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        
        //delete data dengan Realm
//        if let item = todoItems?[indexPath.row] {
//            do {
//                try realm.write {
//                    realm.delete(item)
//                }
//            } catch {
//                print("Error deleting Data, \(error)")
//            }
//        }
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert);
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let safeItem = textField.text {
                if let currentCategory = self.selectedCategory {
                    do {
                        try self.realm.write {
                            let newItem = ToDoItemRealm() // ToDoItem(context: self.context) // by Core Data
                            newItem.title = safeItem
                            newItem.dateCreated = Date.now
                            currentCategory.items.append(newItem)
                        }
                    } catch {
                        print("Error saving new items, \(error)")
                    }
                    
                }
                
//                self.itemArray.append(newItem)
//                self.defaults.set(self.itemArray, forKey: "TodoListArray")
//                self.saveItem(data: newItem)
                self.tableView.reloadData()
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Model Manipulation Methods
//    load Items by Realm
    func loadItems() {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
//    load Items by Core Data
//    func loadItems(with request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest(), predicate: NSPredicate? = nil) {
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//            print("ini")
//        } else {
//            request.predicate = categoryPredicate
//            print("else")
//        }
//        
//        do {
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Error fetch data: \(error)")
//        }
//        
//        tableView.reloadData()
//    }
    
    override func updateModel(at indexPath: IndexPath) {
        super.updateModel(at: indexPath)
        if let itemForDeletion = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(itemForDeletion)
                }
            } catch {
                print("Error deleted data, \(error)")
            }
        }
    }
}

//MARK: - Search bar method
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //querying using Core Data
//        let request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        print("text \(searchBar.text!)")
//        
//        loadItems(with: request, predicate: predicate)
        
        //querying using Realm
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: false)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
