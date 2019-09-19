//
//  SwipeTableViewController.swift
//  MyTodos
//
//  Created by Eddy Garcia on 2019-09-19.
//  Copyright © 2019 Eddy Garcia. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    var cell : UITableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    // TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        //check swipe orientation
        guard orientation == .right else { return nil }
        
        //what happens when the cell is swiped
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            print("Deleted something")
            
            self.updateModel(at: indexPath)

        }
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    func updateModel(at indexPath: IndexPath){
        
    }

}
