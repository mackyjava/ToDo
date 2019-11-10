//
//  toDoModel.swift
//  ToDoApp
//
//  Created by Apple Device 21 on 11/2/19.
//  Copyright © 2019 YocelinGR. All rights reserved.
//

import Foundation

struct ToDo {
    var title: String
    var date: Date
    var isCompleted: Bool
    var notes: String?
    
    init(title: String, date: Date, isCompleted: Bool, notes: String?){
        self.title = title
        self.date = date
        self.isCompleted = isCompleted
        self.notes = notes
    }
    
    static func getToDos() -> [ ToDo ]? {
        return nil
    }
    static func generateTodos () -> [ ToDo ] {
        return [
            ToDo(title: "Crear App", date: Date(), isCompleted: false, notes: "luego"),
            ToDo(title: "Estudiar", date: Date(), isCompleted: true, notes: ""),
            ToDo(title: "Subir Repo", date: Date(), isCompleted: false, notes: nil)
        ]
    }
    static var dueDateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
    }
}

//toDo.generateTodos()
