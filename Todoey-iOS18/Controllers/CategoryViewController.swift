//
//  CategoryViewController.swift
//  Todoey-iOS18
//
//  Created by SKK Staf on 27/08/25.
//

import UIKit
//import CoreData
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
//    var categories = [Category]()
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let realm = try! Realm()
    var categories: Results<CategoryRealm>?

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadCategories()
        initNavigationBar(self.navigationController)
    }
    
    //MARK: - TableView Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = category.name
            cell.backgroundColor = UIColor(hexString: category.colour)
        }
//        cell.delegate = self
        
        return cell
    }
    
    //MARK: - TableView Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//        saveItem()
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //MARK: - Add New Category
    @IBAction func addButtonPresed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert);
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            if let safeCategory = textField.text {
                let newCategory = CategoryRealm()
                newCategory.name = safeCategory
                newCategory.colour = UIColor.randomFlat.hexValue()
                
//                self.categories.append(newItem)
                self.saveCategory(data: newCategory)
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Data Manipulation methods
    func saveCategory(data category: CategoryRealm) {
        do {
//            try context.save()
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context: \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func reloadCategories() {
        categories = realm.objects(CategoryRealm.self)
        tableView.reloadData()
        //let request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
//        do {
//            categories = try context.fetch(request)
//        } catch {
//            print("Error fetch data: \(error)")
//        }
    }
    
    override func updateModel(at indexPath: IndexPath) {
        super.updateModel(at: indexPath)
        if let catForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(catForDeletion)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
        }
    }
}

