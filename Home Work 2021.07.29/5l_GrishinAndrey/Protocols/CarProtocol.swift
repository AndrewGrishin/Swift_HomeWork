//
//  CarProtocol.swift
//  5l_GrishinAndrey
//
//  Created by Andrey Grishin on 2021.07.28.
//

import Foundation

protocol CarProtocol {
    var mark: String { get }
    var releaseYear: Int { get }
    var totalTrunkCapacity: Double { get }
    var remainedTrunkCapacity: Double { get set }
    var engineStatus: EngineOnOff { get set }
    var windowsStatus: WindowsOpenClose { get set }
    
//    func getCarMark() -> String
//    func getEngineStatus() -> EngineOnOff
//    mutating func setEngineStatus(new: EngineOnOff)
//    func getWindowsStatus() -> WindowsOpenClose
//    mutating func setWindowsStatus(new: WindowsOpenClose)
//    func getCarRemainedTrunkCapacity() -> Double
//    mutating func setRemainedTrunkCapacity(new: Double)
//    func getCarReleaseYear() -> Int
//    func getCarTotalTrunkCapacity() -> Double

    mutating func actionDetector(action: carActions)
}

extension CarProtocol {
    
//    func getCarMark() -> String {
//        return self.mark
//    }
//    func getEngineStatus() -> EngineOnOff {
//        return self.engineStatus
//    }
    
//    mutating func setEngineStatus(new: EngineOnOff) {
//        self.engineStatus = new
//    }
//    func getWindowsStatus() -> WindowsOpenClose {
//        return self.windowsStatus
//    }
//    mutating func setWindowsStatus(new: WindowsOpenClose) {
//        self.windowsStatus = new
//    }
//    func getCarRemainedTrunkCapacity() -> Double {
//        return self.remainedTrunkCapacity
//    }
//    mutating func setRemainedTrunkCapacity(new: Double) {
//        self.remainedTrunkCapacity = new
//    }
//    func getCarReleaseYear() -> Int {
//        return self.releaseYear
//    }
//    func getCarTotalTrunkCapacity() -> Double {
//        return self.totalTrunkCapacity
//    }
    
    mutating func actionDetector(action: carActions) {
        func engineIsOFF() -> Bool {
            if self.engineStatus == .off {
                print("Nothing can be done with this car. Engine is OFF.\n")
                return true
            }
            return false
        }
        
        // определение действия машины
        // если двигатель выключен, ни одна из функций не работает
        switch action {
        case .openWindows:
            if engineIsOFF() { break }
            
            if self.windowsStatus == .opened {
                print("Windows are already opened.\n")
            } else {
                self.windowsStatus = .opened
                print("Windows were opened successfully.\n")
            }
            
        case .closeWindows:
            if engineIsOFF() { break }
            
            if self.windowsStatus == .closed {
                print("Windows are already closed.\n")
            } else {
                self.windowsStatus = .opened
                print("Windows were closed successfully.\n")
            }
            
        case .launchEngine:
            if self.engineStatus == .on {
                print("The engine is already turned ON.\n")
            } else {
                self.engineStatus = .on
                print("The engine was turned ON successfully.\n")
            }
            
        case .stopEngine:
            if self.engineStatus == .off {
                print("The engine is already turned OFF.\n")
            } else {
                self.engineStatus = .off
                print("The engine was turned OFF successfully.\n")
            }
            
        case .loadObject(let weight):
            if engineIsOFF() { break }
            
            // Проверка на возможность перегруза
            if self.remainedTrunkCapacity - weight < 0 {
                print("Impossible to load. Overweight: \(weight - self.remainedTrunkCapacity)\n")
            } else {
                self.remainedTrunkCapacity -= weight
                print("""
                    The object was successfully loaded. Weight: \(weight).
                    Available: \(self.remainedTrunkCapacity)\n
                    """)
            }
    
        case .loadOutObject(let weight):
            if engineIsOFF() { break }
            
            // Проверка доступного объема выгрузки ресурсов
            if self.remainedTrunkCapacity + weight > self.totalTrunkCapacity {
                print("""
                    Impossible to load out. There is no such object in the trunk.
                    Over load out: \(self.remainedTrunkCapacity + weight - self.totalTrunkCapacity)\n
                    """)
            } else {
                self.remainedTrunkCapacity += weight
                print("""
                    The object was successfully loaded out. Weight: \(weight).
                    Available: \(self.remainedTrunkCapacity)\n
                    """)
            }
        default:
            print("Unknown operation.\n")
        }
    }
    
}
