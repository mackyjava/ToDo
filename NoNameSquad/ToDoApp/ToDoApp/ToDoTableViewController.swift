//
//  ToDoTableViewController.swift
//  ToDoApp
//
//  Created by Adriana Jauregui on 02/11/19.
//  Copyright © 2019 Adriana Jauregui. All rights reserved.
//

import UIKit
struct ToDo {
    var title: String
    var isCompleted: Bool
    var dueDate: Date
    var notes: String?
    static func loadTodos() -> [ToDo]?  {
           return nil
       }
       static func generateTodos() -> [ToDo] {
           return [
               ToDo(title: "primer To do", isCompleted: false, dueDate: Date(), notes: "some notes"),
               ToDo(title: "segundo To do", isCompleted: false, dueDate: Date(), notes: "some notes"),
               ToDo(title: "tercer To do", isCompleted: false, dueDate: Date(), notes: "some notes"),
               ToDo(title: "cuarto To do", isCompleted: false, dueDate: Date(), notes: "some notes")
           ]
       }
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}

class ToDoTableViewController: UITableViewController {
    
    var data: [ToDo] = ToDo.generateTodos()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].title
        cell.showsReorderControl = true
        // Configure the cell...

    return cell
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindToEmojiTableViewController(_ unwindSegue: UIStoryboardSegue) {
       
               if unwindSegue.identifier == "Save" {
                print("unwind")
                  let sourceVC = unwindSegue.source as! ToDoViewController
                  guard let todo = sourceVC.todo else {return}
                  if let selectedIndexPath = tableView.indexPathForSelectedRow {
                      data[selectedIndexPath.row] = todo
                      tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
                  }
                  else {
                      let newIndexPath = IndexPath(row: data.count, section: 0)
                      print(todo)
                      data.append(todo)
                      tableView.insertRows(at: [newIndexPath], with: .automatic)
                  }
              }
        
    }
   
}
