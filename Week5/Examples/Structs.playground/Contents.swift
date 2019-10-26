import UIKit

//Structs

struct Classroom {
    //Propiedades almacenadas
    
    let address: String
    var isSaturday: Bool
    
    //Propiedades calculadas
    var name: String {
        if isSaturday {
            return "ECC @ Laboratoria"
        } else {
            return "Laborotoria Bootcamp"
        }
    }
    
    //Observadores de propiedades
    var minutesPassed: Int {
        willSet{
            print("\(name) will change now from \(minutesPassed) to \(newValue)")
        }
        didSet {
            print("\(name) is now \(minutesPassed) minutes long")
        }
    }
    
    //Métodos
    func whatsNext() -> String {
        switch self.minutesPassed {
        case 0...90:
            return "Hora de clase"
        default:
            return "Hora de proyectos"
        }
    }
}

//var classRoom = Classroom(address: "Tonalá 10", isSaturday: true, minutesPassed: 0)
//classRoom.name
//classRoom.minutesPassed = 40
//print(classRoom.whatsNext())



// {get} {set}

struct Point {
    var x = 0.0, y=0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

//var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
//print("Square's center x:\(square.center.x) y: \(square.center.y)")
//square.center = Point(x: 15.0, y: 15.0)
//print("\nSquare's center x:\(square.center.x) y: \(square.center.y)")
//print("Square's new origin x:\(square.origin.x) y: \(square.origin.y)")







//Static properties and static methods
struct Student {
    static var className = "ECC @ Laboratoria"
    static var classSize = 0
    
    var name: String
    init(name: String) {
        self.name = name
        //Static property
        Student.classSize += 1
    }
}
let someStudent = Student(name: "Ed")
let anotherStudent = Student(name: "Rob")

print(Student.className)
print(Student.classSize)

//Access control
struct Robot {
    private var id: Int
    
    init(id: Int) {
        self.id = id
        doSomethingInside()
    }
    
    private func doSomethingInside() {
        print("doing sth")
    }
    
    func identify() -> String {
        return "My id is \(self.id)"
    }
    
}
var robot = Robot(id: 109876546789)
print(robot.identify())


//mutating methods
struct SomeStruct {
    var a: Int
    mutating func modifyA() {
        a += 10
    }
}
var someS = SomeStruct(a: 10)
someS.modifyA()








