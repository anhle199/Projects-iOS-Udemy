//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Le Hoang Anh on 28/01/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: SwipeTableViewController {

    private static let segueIdentifier = "goToItems"
    
    private let realm = try! Realm()
    private var categories: Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }

    
    // MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        
        return cell
    }
    
    
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: CategoryViewController.segueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    // MARK: - Model Manipulation Methods
    
    private func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    private func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
            tableView.reloadData()
        } catch {
            print("ERROR - saveCategories: \(error.localizedDescription)")
        }
    }
    
    
    // MARK: - Add New Category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var alertTextField: UITextField!
        
        // Alert controller
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        // Alert actions
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            if let categoryName = alertTextField.text?.trimmingCharacters(in: .whitespaces),
               !categoryName.isEmpty {
                
                let category = Category()
                category.name = categoryName
                
                self.save(category: category)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // Add actions to alert controller
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        // Alert TextField
        alert.addTextField { textField in
            textField.placeholder = "Type category's name here..."
            alertTextField = textField
        }
        
        // Present alert controller
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Delete An Existing Category
    override func deleteModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion.items)
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error when deleting an item, \(error.localizedDescription)")
            }
        }
    }
 
}
