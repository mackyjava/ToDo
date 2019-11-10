//
//  ToDoViewController.swift
//  ToDoApp
//
//  Created by Adriana Jauregui on 09/11/19.
//  Copyright © 2019 Adriana Jauregui. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {
    
    @IBOutlet weak var complete: UIButton!
    
    @IBOutlet weak var todoText: UITextField!
    
    @IBOutlet weak var DueLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var dateControl: UIDatePicker!
    
    @IBOutlet weak var notesText: UITextView!
    
    @IBOutlet weak var save: UIBarButtonItem!
    
    @IBAction func changeComplete(_ sender: Any) {
        complete.isSelected = !complete.isSelected
    }
    
    @IBAction func textEditChange(_ sender: Any) {
        toggleActivate()
    }
    @IBAction func changeDate(_ sender: Any) {
        dateLabel(date: dateControl.date)
    }
    
    var todo: ToDo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleActivate()
        dateLabel(date: dateControl.date)
    }
    
   
   func toggleActivate() -> Void {
    if todoText.text?.isEmpty ?? false {
               save.isEnabled = false
           }
           else{
               save.isEnabled = true
        }
        
    }
   var isPickerHidden:Bool = true
    
   func dateLabel(date:Date){
        dateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }; override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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

                DueLabel.textColor = isPickerHidden ? .black : tableView.tintColor

                tableView.beginUpdates()
               tableView.endUpdates()
           default:
               break
           }
       }
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     super.prepare(for: segue, sender: sender)
     
     guard segue.identifier == "SaveUnwind" else {return}
     
    let title = todoText.text!
    let isComplete = complete.isSelected
    let dueDate = dateControl.date
    let notes = notesText.text
    
    todo = ToDo(title: title , isCompleted: isComplete, dueDate: dueDate, notes: notes)
     
 }

}
