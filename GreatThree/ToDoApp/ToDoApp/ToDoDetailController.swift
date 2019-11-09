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
    var toDo: ToDo?
    
    
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var datePickerValue: UIDatePicker!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var datePickerLabel: UILabel!
    
       override func viewDidLoad() {
           super.viewDidLoad()
           existTextInField()
        selectDatePicker(dateSelected: Date())
        if let todo = toDo {
            print("goes here");
            navigationItem.title = "To-Do"
            textInfo.text = todo.title
            checkBoxButton.isSelected = todo.isCompleted
            datePickerValue.date = todo.date
            notesTextView.text = todo.notes
        } else {
            print(" h")
            datePickerValue.date = Date().addingTimeInterval(24*60*60)
        }

       }
    
    func existTextInField(){
        if(((textInfo?.text) != "")){
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    
    
    @IBAction func isComplete(_ sender: UIButton) {
        checkBoxButton.isSelected = !checkBoxButton.isSelected
        if(checkBoxButton.isSelected == true){
            print("true");
            checkBoxButton.backgroundColor = .red
        } else {
            print("false"); checkBoxButton.backgroundColor = .blue
        }
        
    }
    @IBAction func textEditingChanged(_ sender: UITextField) {
        existTextInField()
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        textInfo.resignFirstResponder()
    }
    func selectDatePicker(dateSelected: Date){
        //toDo.dueDateFormatter
        datePickerLabel.text = ToDo.dueDateFormatter.string(from: dateSelected)
    }
     
    @IBAction func datePickerSelected(_ sender: UIDatePicker) {
        selectDatePicker(dateSelected: sender.date)
    }
    var isPickerHidden = false
    
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath) {
        case [1,0]:
            isPickerHidden = !isPickerHidden
            print(isPickerHidden)
            
            dueDateLabel.textColor = isPickerHidden ? .black : tableView.tintColor
            
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "Save" else {return}
        
        
        let title = textInfo.text!
        let isComplete = checkBoxButton.isSelected
        let dueDate = datePickerValue.date
        let notes = notesTextView.text
        
        toDo = ToDo(title: title, date: dueDate, isCompleted: isComplete, notes: notes ?? "")
    }
}

