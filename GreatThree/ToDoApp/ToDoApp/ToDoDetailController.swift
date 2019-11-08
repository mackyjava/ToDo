//
//  ViewController.swift
//  ToDoApp
//
//  Created by Apple Device 21 on 11/2/19.
//  Copyright © 2019 YocelinGR. All rights reserved.
//

import UIKit

class ToDoDetailController: UITableViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var textInfo: UITextField!
    @IBOutlet weak var checkBoxButton: UIButton!
    
    
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var datePickerValue: UIDatePicker!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var datePickerLabel: UILabel!
    
       override func viewDidLoad() {
           super.viewDidLoad()
           existTextInField()
           // Do any additional setup after loading the view, typically from a nib.
       }
    
    func existTextInField(){
        if(((textInfo?.text) != nil)){
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }
    
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        existTextInField()
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        textInfo.resignFirstResponder()
    }
    
}

