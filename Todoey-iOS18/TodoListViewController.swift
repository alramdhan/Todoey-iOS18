//
//  ViewController.swift
//  Todoey-iOS18
//
//  Created by Dika Alfarell on 18/08/25.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let navbar = self.navigationController!.navigationBar
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = .systemPink
        standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//        standardAppearance.backgroundImage = backImageForDefaultBarMetrics
        let compactAppearance = standardAppearance.copy()
        compactAppearance.backgroundColor = .systemPink
        compactAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navbar.standardAppearance = standardAppearance
        navbar.scrollEdgeAppearance = standardAppearance
        navbar.compactAppearance = compactAppearance
        navbar.barTintColor = .systemBlue
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row at \(indexPath.row) value \(itemArray[indexPath.row])")
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

