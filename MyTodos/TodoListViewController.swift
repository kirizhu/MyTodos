//
//  ViewController.swift
//  MyTodos
//
//  Created by Eddy Garcia on 2019-09-04.
//  Copyright © 2019 Eddy Garcia. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Study Swift", "Go shopping", "Workout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        
        //TableView cells have a textLabel by dafault, populate it
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }

    //MARK - Tableview delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Checks to see if there is a checkmark for a selected row
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            //Removes checkmark for selected row
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            //Adds checkmark for selected row
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
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
            self.itemArray.append(textField.text!)
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

