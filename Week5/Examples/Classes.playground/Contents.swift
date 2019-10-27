import UIKit

//Classes

//Base class or SuperClass
//UpperCamelCase for structs, enums and class names
class Vehicle {
    //lowerCamelCalse for properties and methods
    var currentSpeed: Double
    var description: String {
        return "traveling at \(currentSpeed) km/h"
    }
    func makeNoise() {
        //nothing here
    }
    //new thing
    init(currentSpeed: Double) {
        self.currentSpeed = currentSpeed
    }
}
let someVehicle = Vehicle(currentSpeed: 0.0)
someVehicle.description

//Child class
class Bicycle: Vehicle {
    var hasBasket: Bool
    init(hasBasket: Bool,currentSpeed: Double) {
        self.hasBasket = hasBasket
        super.init(currentSpeed: currentSpeed)
    }
}

let b = Bicycle(hasBasket: true, currentSpeed: 5.0)
b.description

class Train: Vehicle {
    
    override var description: String {
        return "这是火车 " + super.description
    }
    
    override func makeNoise() {
        print("🚂 Choo choo !!")
    }
}

let train = Train(currentSpeed: 120.0)
//print(train.description)
//train.makeNoise()


//
struct Resolution {
    var height: Int
    var width: Int
}

class VideoMode {
    var resolution: Resolution
    var frameRate: Double
    
    init(resolution: Resolution, frameRate: Double) {
        self.resolution = resolution
        self.frameRate = frameRate
    }
}


var hd = Resolution(height: 1080, width: 1920)
var cinema = hd
cinema.height = 2000
print(hd.height)
print(cinema.height)
print()
var tenEighty = VideoMode(resolution: hd, frameRate: 25.0)
var alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print(tenEighty.frameRate)
print(alsoTenEighty.frameRate)
