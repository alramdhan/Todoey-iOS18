//
//  CategoryViewController.swift
//  Todoey-iOS18
//
//  Created by SKK Staf on 27/08/25.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadCategories()
        initNavigationBar(self.navigationController)
    }
    
    //MARK: - TableView Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categories[indexPath.row]
        
        cell.textLabel?.text = category.name
        
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
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    //MARK: - Add New Category
    @IBAction func addButtonPresed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert);
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            if let safeItem = textField.text {
                let newItem = Category(context: self.context)
                newItem.name = safeItem
                
                self.categories.append(newItem)
                self.saveCategory()
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Data Manipulation methods
    func saveCategory() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func reloadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        //let request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error fetch data: \(error)")
        }
    }
}
