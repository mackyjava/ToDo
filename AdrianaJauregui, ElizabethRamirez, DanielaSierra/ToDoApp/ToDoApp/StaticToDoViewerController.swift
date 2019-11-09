//
//  StaticToDoViewerController.swift
//  ToDoApp
//
//  Created by Adriana Jauregui on 09/11/19.
//  Copyright © 2019 Adriana Jauregui. All rights reserved.
//

import UIKit

class StaticToDoViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleActivate()
        dateLabel(date: date.date)
    }
    
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var buttonImg: UIButton!
    
    @IBOutlet weak var remember: UITextField!
    
    @IBOutlet weak var date: UIDatePicker!
    
    @IBOutlet weak var text: UITextView!
    
    @IBOutlet weak var save: UIBarButtonItem!
    @IBOutlet weak var dateLabel: UILabel!
    @IBAction func textEditingChange(_ sender: Any) {
        toggleActivate()
    }
    
    @IBAction func returnPrressed(_ sender: Any) {
        remember.resignFirstResponder()
    }

    @IBAction func isComplete(_ sender: Any) {
        buttonImg.isSelected = !buttonImg.isSelected
    }
    
    @IBAction func dayPicker(_ sender: Any) {
        dateLabel(date: date.date)
    }
    
    
    func toggleActivate() -> Void {
        if remember.text?.isEmpty == false {
            save.isEnabled = true
        }
        else{
            save.isEnabled = false
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

               dueDateLabel.textColor = isPickerHidden ? .black : tableView.tintColor

               tableView.beginUpdates()
               tableView.endUpdates()
           default:
               break
           }
       }
    
    
    
    
    
    
    
}





