//
//  ViewController.swift
//  Todoey-iOS18
//
//  Created by Dika Alfarell on 18/08/25.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    var itemArray = [ToDoItem]()
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
//    let defaults = UserDefaults.standard
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

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
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        itemArray[indexPath.row].setValue("Completed", forKey: "title") // for update data Core Data and still to call context.save()
//        context.delete(itemArray[indexPath.row]) // untuk menghapus dari Core Data dan perlu memanggil code context.save()
//        itemArray.remove(at: indexPath.row) // untuk delete dari array untuk update tampilan tanpa menyentuh Core Data
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItem()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert);
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let safeItem = textField.text {
                let newItem = ToDoItem(context: self.context)
                newItem.title = safeItem
                newItem.done = false
                newItem.parentCategory = self.selectedCategory
                self.itemArray.append(newItem)
//                self.defaults.set(self.itemArray, forKey: "TodoListArray")
                self.saveItem()
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
    func saveItem() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest(), predicate: NSPredicate? = nil) {
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
            print("ini")
        } else {
            request.predicate = categoryPredicate
            print("else")
        }
        
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetch data: \(error)")
        }
        
        tableView.reloadData()
    }
}

//MARK: - Search bar method
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        print("text \(searchBar.text!)")
        
        loadItems(with: request, predicate: predicate)
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
