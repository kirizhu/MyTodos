//
//  ViewController.swift
//  MyTodos
//
//  Created by Eddy Garcia on 2019-09-04.
//  Copyright © 2019 Eddy Garcia. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Study Swift", "Go shopping", "Workout"]
    
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
        
        let selectedTodo = itemArray[indexPath.row]
        
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
        
        print(selectedTodo)
        
    }
}

