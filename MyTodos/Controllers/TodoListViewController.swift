//
//  ViewController.swift
//  MyTodos
//
//  Created by Eddy Garcia on 2019-09-04.
//  Copyright © 2019 Eddy Garcia. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
    //array of items from the data model
    var todoItems : Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    //path to were the data is being stored for our current app
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    //We need to create the context but In order to access the persistent container view context from the Appdelegate object but since AppDelegate is a class we first need to tap into UIApplication.shared which is a singleton app instance which corresponds to our live application object were we can access the UIApplication delegate and then we downcast it as our class Appdelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(dataFilePath)

    }
    //MARK: - Tableview Datasource Methods
    
    //Number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoItems?.count ?? 1
    }
    //What to display as our data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //Create the tableView Reusable Cell with our set identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        if let item = todoItems?[indexPath.row]{
            //TableView cells have a textLabel by dafault, populate it
            cell.textLabel?.text = item.title
            //ternary operator
            // Value = condition ? valueIftrue : valueIfFalse
            cell.accessoryType = item.done ? .checkmark : .none
        }else{
            cell.textLabel?.text = "No items added"
        }

        
        return cell
    }

    //MARK: - Tableview delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let item = todoItems?[indexPath.row]{
            do{
                try realm.write {
                    item.done = !item.done
                }
            }catch{
                print("Error saving done status,\(error)")
            }
        }
        tableView.reloadData()
        //Animates the color of the selected row
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - Add new items button

    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        //local variable used
        var textField = UITextField()
        //create an alert
        let alert = UIAlertController(title: "Add a new ToDo", message: "", preferredStyle: .alert)
        //create the action
        let action = UIAlertAction(title: "Add ToDo", style: .default) { (action) in
            //What will happen once the user clicks the Add ToDo
            //append the alert textfield text stored in the local variable
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        currentCategory.items.append(newItem)
                    }
                }catch{
                    print("Error saving new items, \(error)")
                }

            }
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
    
    //MARK: - Model manipulation methods
    
    func save(item : Item) {
        do{
            try realm.write {
                realm.add(item)
            }
        } catch {
            print("Error saving context \(error)")
        }
        
        //Reload the data so that the tableview displays the added text from the alert textfield
        self.tableView.reloadData()
    }
    
    func loadItems(){
        //create a request of datatype nsFetchRequest that is gonna get a bunch of items  and then tap into our item entity and we make a new fetchrequest
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        self.tableView.reloadData()
    }

}

//MARK: - Search bar methods

//extension TodoListViewController : UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request, predicate: predicate)
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadItems()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        }
//
//    }
//}
//
