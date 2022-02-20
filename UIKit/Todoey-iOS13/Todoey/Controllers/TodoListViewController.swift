//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: SwipeTableViewController {

    private let realm = try! Realm()
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    private var items: Results<Item>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        // configure this cell
        if let item = items?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added Yet"
        }
        
        return cell
    }

    
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath),
           let item = items?[indexPath.row] {
            
            do {
                try realm.write {
                    item.done = !item.done
                    cell.accessoryType = item.done ? .checkmark : .none
                }
            } catch {
                print("Error when clicking a specific item, \(error.localizedDescription)")
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Add New Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var alertTextField: UITextField!
        
        // alert controller
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        // actions
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            if let taskName = alertTextField.text?.trimmingCharacters(in: .whitespaces),
               !taskName.isEmpty {

                if let currentCategory = self.selectedCategory {
                    do {
                        try self.realm.write {
                            let item = Item()
                            item.title = taskName
                            item.dateCreated = Date()
                            
                            currentCategory.items.append(item)
                        }
                        self.tableView.reloadData()
                    } catch {
                        print("Error when saving items, \(error.localizedDescription)")
                    }
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // add actions to alert controller
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        // add an alert text field to input a new task's name
        alert.addTextField { textField in
            textField.placeholder = "Type task's name here..."
            alertTextField = textField
        }
        
        // present alert controller
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Model Manipulation Methods
    
    private func loadItems() {
        items = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    override func deleteModel(at indexPath: IndexPath) {
        if let itemForDeletion = items?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(itemForDeletion)
                }
            } catch {
                print("Error when deleting item, \(error.localizedDescription)")
            }
        }
    }
    
}


// MARK: - SearchBar Delegate Methods
extension TodoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text?.trimmingCharacters(in: .whitespaces), !query.isEmpty {
            items = selectedCategory?.items
                .filter("title CONTAINS[cd] %@", query)
                .sorted(byKeyPath: "dateCreated", ascending: true)
        } else {
            items = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        }
    
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let query = searchBar.text?.trimmingCharacters(in: .whitespaces), query.isEmpty {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }

}
