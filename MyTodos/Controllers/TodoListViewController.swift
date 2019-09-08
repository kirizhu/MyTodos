//
//  ViewController.swift
//  MyTodos
//
//  Created by Eddy Garcia on 2019-09-04.
//  Copyright © 2019 Eddy Garcia. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    //array of items from the data model
    var itemArray = [Item]()
    //create a User defaults object, User defaults is an interface to the user deafaults database where you store key vaue pairs persistently
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        //Optional binding
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
        
    }
    //MARK - Tableview Datasource Methods
    
    //Number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    //What to display as our data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //Create the tableView Reusable Cell with our set identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        //TableView cells have a textLabel by dafault, populate it
        cell.textLabel?.text = item.title
        //ternary operator
        // Value = condition ? valueIftrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }

    //MARK - Tableview delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //set it to the opposite of what it is now everytime we select something
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        tableView.reloadData()
        //Animates the color of the selected row
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    //MARK - Add new items button

    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        //local variable used
        var textField = UITextField()
        //create an alert
        let alert = UIAlertController(title: "Add a new ToDo", message: "", preferredStyle: .alert)
        //create the action
        let action = UIAlertAction(title: "Add ToDo", style: .default) { (action) in
            //What will happen once the user clicks the Add ToDo
            //append the alert textfield text stored in the local variable
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            //Save that updated item array
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            //Reload the data so that the tableview displays the added text from the alert textfield
            self.tableView.reloadData()
        }
        //add textfield to alert with placeholder, and passing the value to our local variable so that it is accesible outside the closure
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        //add the action to our alert
        alert.addAction(action)
        //present our alert
        present(alert, animated: true, completion: nil)
    }
    
}

