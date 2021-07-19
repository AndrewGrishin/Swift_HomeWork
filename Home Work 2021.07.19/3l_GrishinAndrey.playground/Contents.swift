import UIKit

enum CarActions {
    case openWindows, closeWindows
    case launchEngine, stopEngine
    case loadObject(Double), loadOutObject(Double)
}

struct Car {

    enum EngineOnOff {
        case on
        case off
    }
    
    enum WindowsOpenClose {
        case opened, closed
    }

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
    
    private func engineIsOFF() -> Bool {
        if self.engineStatus == .off {
            print("Nothing can be done with this car. Engine is OFF.")
            return false
        }
        return true
    }
    
    mutating func actionDetector(action: CarActions) {
        switch action {
        case .openWindows:
            if self.engineIsOFF() { break }
            
            if self.windowsStatus == .opened {
                print("Windows are already opened.")
            } else {
                self.windowsStatus = .opened
                print("Windows were opened successfully.")
            }
            
        case .closeWindows:
            if self.engineIsOFF() { break }
            
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
            if self.engineIsOFF() { break }
            
            if self.remainedTrunkCapacity - weight < 0 {
                print("Impossible to load. Overweight: \(weight - self.remainedTrunkCapacity)")
            } else {
                self.remainedTrunkCapacity -= weight
                print("The object was successfully loaded. Weight: \(weight). Available: \(self.remainedTrunkCapacity)")
            }
    
        case .loadOutObject(let weight):
            if self.engineIsOFF() { break }
            
            if self.remainedTrunkCapacity + weight > self.totalTrunckCapacity {
                print("Impossible to load out. There is no such object in the trunk. Over load out: \(self.remainedTrunkCapacity + weight - self.totalTrunckCapacity)")
            } else {
                self.remainedTrunkCapacity += weight
                print("The object was successfully loaded out. Weight: \(weight). Available: \(self.remainedTrunkCapacity)")
            }
        }
    }
    
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
    
}

var sportCar: Car? = Car(type: .trunkCar, mark: "Honda", releaseYear: 2017, totalTrunckCapacity: 1000)

if var sportCar = sportCar {
    
}
