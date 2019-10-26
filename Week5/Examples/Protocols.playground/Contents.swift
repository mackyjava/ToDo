import UIKit

protocol Identifiable {
    var id: String {get set}
    func showId()
}

protocol Payable {func calculateWages() -> Int}
protocol NeedsTraining {func study()}
protocol HasVacation{func takeVacation(days:Int)}

protocol Employee: Payable,NeedsTraining,HasVacation {}

//Structs conform to protocols
//Classes inherits from other classes 

struct User: Identifiable, Employee {
    func calculateWages() -> Int {
        return 200
    }
    
    func study() {
        print("Studying")
    }
    
    func takeVacation(days: Int) {
        print("Going offline for \(days) days")
    }
    
    var id: String
    func showId() {
        print(id)
    }
}

let user = User(id: "0987654")
user.showId()
print(user.calculateWages())
user.study()
user.takeVacation(days: 10)

