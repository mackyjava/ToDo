//
//  ViewController.swift
//  ToDoApp
//
//  Created by Apple Device 21 on 11/2/19.
//  Copyright © 2019 YocelinGR. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    var ToDoArr = toDo.generateTodos()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoArr.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1. crear celda
        let cell = tableView.dequeueReusableCell(withIdentifier: "UiTableViewCell", for: indexPath)
        
        cell.textLabel?.text = "\(ToDoArr[indexPath.row].title)"
        
        return cell
    }
}

