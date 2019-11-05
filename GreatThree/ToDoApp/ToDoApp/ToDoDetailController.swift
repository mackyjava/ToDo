//
//  ViewController.swift
//  ToDoApp
//
//  Created by Apple Device 21 on 11/2/19.
//  Copyright © 2019 YocelinGR. All rights reserved.
//

import UIKit

class ToDoDetailController: UITableViewController {
    //@IBOutlet weak var nflLabel: UILabel!
    @IBOutlet weak var textEditChanged: UILabel!
    @IBOutlet weak var checkbox: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func existTextInField(){
        if(((textEditChanged?.text) != nil)){
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }
}

