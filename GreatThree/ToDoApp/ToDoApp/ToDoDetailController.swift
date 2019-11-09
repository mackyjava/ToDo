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
        selectDatePicker(dateSelected: Date())
           // Do any additional setup after loading the view, typically from a nib.
       }
    
    func existTextInField(){
        if(((textInfo?.text) != nil)){
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }
    
    
    
    @IBAction func isComplete(_ sender: UIButton) {
        checkBoxButton.isSelected = !checkBoxButton.isSelected
    }
    @IBAction func textEditingChanged(_ sender: UITextField) {
        existTextInField()
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        textInfo.resignFirstResponder()
    }
    func selectDatePicker(dateSelected: Date){
        //toDo.dueDateFormatter
        datePickerLabel.text = toDo.dueDateFormatter.string(from: dateSelected)
    }
     
    @IBAction func datePickerSelected(_ sender: UIDatePicker) {
        selectDatePicker(dateSelected: sender.date)
    }
    var isPickerHidden = false
    @IBAction func datePickerTouch(_ sender: Any) {
        isPickerHidden = !isPickerHidden
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        
        switch indexPath {
        case [1,0]:
            return isPickerHidden ? normalCellHeight:largeCellHeight
        case [2,0]:
            return largeCellHeight
        default:
            return normalCellHeight
        }
    }
}

