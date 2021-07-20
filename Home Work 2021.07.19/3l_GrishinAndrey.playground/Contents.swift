import UIKit

// Опеределяем перечисление действи автомобиля
enum CarActions {
    case openWindows, closeWindows
    case launchEngine, stopEngine
    case loadObject(Double), loadOutObject(Double)
}

// определеяем структуру автомобиля
struct Car {

    // перечисления EngineOnOff, WindowsOpenClose, CarType определены для удобства работы со структурой Car
    enum EngineOnOff {
        case on
        case off
    }
    
    enum WindowsOpenClose {
        case opened, closed
    }

    // Перечисление CarType создано, чтобы не копировать одинаковые свойства и методы структуры для разных типов машин
    enum CarType {
        case sportCar, trunkCar
    }
    
    private let type: CarType
    private let mark: String
    private let releaseYear: Int
    private let totalTrunckCapacity: Double
    private var remainedTrunkCapacity: Double
    private var engineStatus: EngineOnOff
    private var windowsStatus: WindowsOpenClose
    
    // опциональный инициализатор
    init? (type: CarType, mark: String, releaseYear: Int, totalTrunckCapacity: Double) {
        guard releaseYear >= 0 && totalTrunckCapacity >= 0 else { return nil }
        self.type = type
        self.mark = mark
        self.releaseYear = releaseYear
        self.totalTrunckCapacity = totalTrunckCapacity
        self.remainedTrunkCapacity = totalTrunckCapacity
        self.engineStatus = .off
        self.windowsStatus = .closed
    }
    
    mutating func actionDetector(action: CarActions) {
        
        // Блокирует функционал машины, когда двигатель выключен
        func engineIsOFF() -> Bool {
            if self.engineStatus == .off {
                print("Nothing can be done with this car. Engine is OFF.")
                return true
            }
            return false
        }
        
        switch action {
        case .openWindows:
            if engineIsOFF() { break }
            
            if self.windowsStatus == .opened {
                print("Windows are already opened.")
            } else {
                self.windowsStatus = .opened
                print("Windows were opened successfully.")
            }
            
        case .closeWindows:
            if engineIsOFF() { break }
            
            if self.windowsStatus == .closed {
                print("Windows are already closed.")
            } else {
                self.windowsStatus = .opened
                print("Windows were closed successfully.")
            }
            
        case .launchEngine:
            if self.engineStatus == .on {
                print("The engine is already turned ON.")
            } else {
                self.engineStatus = .on
                print("The engine was turned ON successfully.")
            }
            
        case .stopEngine:
            if self.engineStatus == .off {
                print("The engine is already turned OFF.")
            } else {
                self.engineStatus = .off
                print("The engine was turned OFF successfully.")
            }
            
        case .loadObject(let weight):
            if engineIsOFF() { break }
            
            if self.remainedTrunkCapacity - weight < 0 {
                print("Impossible to load. Overweight: \(weight - self.remainedTrunkCapacity)")
            } else {
                self.remainedTrunkCapacity -= weight
                print("The object was successfully loaded. Weight: \(weight). Available: \(self.remainedTrunkCapacity)")
            }
    
        case .loadOutObject(let weight):
            if engineIsOFF() { break }
            
            if self.remainedTrunkCapacity + weight > self.totalTrunckCapacity {
                print("Impossible to load out. There is no such object in the trunk. Over load out: \(self.remainedTrunkCapacity + weight - self.totalTrunckCapacity)")
            } else {
                self.remainedTrunkCapacity += weight
                print("The object was successfully loaded out. Weight: \(weight). Available: \(self.remainedTrunkCapacity)")
            }
        }
    }
    
    // Так как все параметры private => ими нельзя воспользоваться вне структуры
    // Значит,
    func getCarType() -> CarType {
        return self.type
    }
    
    func getCarMark() -> String {
        return self.mark
    }
    
    func getCarReleaseYear() -> Int {
        return self.releaseYear
    }
    
    func getCarTotalTrunkCapacity() -> Double {
        return self.totalTrunckCapacity
    }
    
    func getCarRemainedTrunkCapacity() -> Double {
        return self.remainedTrunkCapacity
    }
    
    func getEngineStatus() -> EngineOnOff {
        return self.engineStatus
    }
    
    func getWindowsStatus() -> WindowsOpenClose {
        return self.windowsStatus
    }
    
    func showCarInfo() {
        print("\nCar type -> \(self.type)")
        print("Car mark -> \(self.mark)")
        print("Car release year -> \(self.releaseYear)")
        print("Car total trunk capacity -> \(self.totalTrunckCapacity)")
        print("Car remained trunk capacity -> \(self.remainedTrunkCapacity)")
        print("Car's engine status -> \(self.engineStatus)")
        print("Car's windows status -> \(self.windowsStatus)\n\n")
    }
}

var sportCar = Car(type: .sportCar, mark: "Honda", releaseYear: 2017, totalTrunckCapacity: 1000)
var trunkCar = Car(type: .trunkCar, mark: "Toyota", releaseYear: 2010, totalTrunckCapacity: 10_000)
var luxuryCar = Car(type: .sportCar, mark: "Aston Martin", releaseYear: 2018, totalTrunckCapacity: 650)
var wrongCar = Car(type: .sportCar, mark: "Honda", releaseYear: -2017, totalTrunckCapacity: -1000) // nil


if var sportCar = sportCar, var trunkCar = trunkCar, var luxuryCar = luxuryCar {
    sportCar.actionDetector(action: .openWindows)
    sportCar.actionDetector(action: .launchEngine)
    sportCar.actionDetector(action: .loadObject(200))
    sportCar.actionDetector(action: .loadObject(2000))
    sportCar.actionDetector(action: .loadObject(800))
    sportCar.actionDetector(action: .loadOutObject(1000))
    sportCar.actionDetector(action: .openWindows)
    sportCar.actionDetector(action: .openWindows)
    sportCar.actionDetector(action: .closeWindows)
    sportCar.actionDetector(action: .stopEngine)
    sportCar.showCarInfo()
    
    trunkCar.actionDetector(action: .launchEngine)
    trunkCar.actionDetector(action: .closeWindows)
    trunkCar.actionDetector(action: .openWindows)
    trunkCar.actionDetector(action: .loadObject(2000))
    trunkCar.actionDetector(action: .loadOutObject(500))
    trunkCar.actionDetector(action: .closeWindows)
    trunkCar.actionDetector(action: .stopEngine)
    trunkCar.showCarInfo()
    
    luxuryCar.actionDetector(action: .launchEngine)
    luxuryCar.actionDetector(action: .openWindows)
    luxuryCar.actionDetector(action: .loadObject(150))
    luxuryCar.actionDetector(action: .loadObject(300))
    luxuryCar.actionDetector(action: .loadOutObject(451))
    luxuryCar.actionDetector(action: .loadOutObject(450))
    luxuryCar.actionDetector(action: .closeWindows)
    luxuryCar.actionDetector(action: .stopEngine)
    luxuryCar.showCarInfo()
}
