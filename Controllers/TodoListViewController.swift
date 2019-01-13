//
//  ViewController.swift
//  Todoey
//
//  Created by Eduardo DuQuesne on 1/12/19.
//  Copyright © 2019 Eduardo DuQuesne. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

//    var itemArray = ["Eat", "Walk Dogs", "Grocery Shop"]
    
    var itemArray = [Item]()
    
    //Step 1: Storing Data Locally
    let defaults = UserDefaults.standard
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let newItem = Item()
        newItem.title = "Eat"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Walk Dogs"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Grocery Shop"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    }
    
    //MARK: - Tableview Datasource Methods
    // 1. Count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    //2. Populate the cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        cell.accessoryType =  itemArray[indexPath.row].done == true ? .checkmark : .none
        return cell
        
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Fades the highlight out of selection
        tableView.deselectRow(at: indexPath, animated: true)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        
    }
        
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new toodoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What happens when user clicks to add item
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            //Step 2: Storing Data Locally - Stored in a plist file
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
}
