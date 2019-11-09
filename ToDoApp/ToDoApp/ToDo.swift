//
//  ToDo.swift
//  ToDoApp
//
//  Created by Apple Device 18 on 11/2/19.
//  Copyright © 2019 Tonipocket. All rights reserved.
//

import Foundation

struct ToDo {
    var title: String
    var isCompleted: Bool
    var dueDate: Date
    var notes: String?
    
    static func loadToDos() -> [ToDo]?  {
        return nil
    }
    static func generateToDos() -> [ToDo] {
        return [
            ToDo(title: "1 título", isCompleted: false, dueDate: Date(), notes: "..."),
           ToDo(title: "2 título", isCompleted: false, dueDate: Date(), notes: "..."),
           ToDo(title: "3 título", isCompleted: false, dueDate: Date(), notes: "..."),
        ]
    }
}

