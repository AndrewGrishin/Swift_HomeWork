import UIKit

class Car {
    
    static func separate() {
        print("------------------------------------------------\n\n")
    }
    
    enum carActions {
        case openWindows, closeWindows
        case launchEngine, stopEngine
        case loadObject(Double), loadOutObject(Double)
        
        // Действия SportCar
        case ejectSpolier, injectSpolier
        case riseHeadLight, declineHeadLight
        
        // Действия TrunkCar
        case riseTrunk, declineTrunk
        case turnOnBackwardSignal, turnOffBackwardSignal
    }
    
    enum EngineOnOff {
        case on
        case off
    }
    
    enum WindowsOpenClose {
        case opened, closed
    }
    
    private let mark: String
    private let releaseYear: Int
    private let totalTrunckCapacity: Double
    private var remainedTrunkCapacity: Double
    private var engineStatus: EngineOnOff
    private var windowsStatus: WindowsOpenClose
    
    init?(mark: String?, releaseYear: Int, totalTrunckCapacity: Double) {
        guard let mark = mark, releaseYear >= 0 && totalTrunckCapacity >= 0 else {
            return nil
        }
        self.mark = mark
        self.releaseYear = releaseYear
        self.totalTrunckCapacity = totalTrunckCapacity
        self.remainedTrunkCapacity = totalTrunckCapacity
        self.engineStatus = .off
        self.windowsStatus = .closed
    }
    
    func actionDetector(action: carActions) {
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
            if self.remainedTrunkCapacity + weight > self.totalTrunckCapacity {
                print("""
                    Impossible to load out. There is no such object in the trunk.
                    Over load out: \(self.remainedTrunkCapacity + weight - self.totalTrunckCapacity)\n
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
    
    func setWindowsStatus(new: WindowsOpenClose) {
        self.windowsStatus = new
    }
    
    func setEngineStatus(new: EngineOnOff) {
        self.engineStatus = new
    }
    
    func setRemainedTrunkCapacity(new: Double) {
        self.remainedTrunkCapacity = new
    }
    
    func showCarInfo() {
        print("Car mark -> \(self.getCarMark())")
        print("Car release year -> \(self.getCarReleaseYear())")
        print("Car total trunk capacity -> \(self.getCarTotalTrunkCapacity())")
        print("Car remained trunk capacity -> \(self.getCarRemainedTrunkCapacity())")
        print("Car engine status -> \(self.getEngineStatus())")
        print("Car windows status -> \(self.getWindowsStatus())")
    }
}

final class SportCar: Car {
    
    enum AssembleTypeCar {
        case manual, factory
    }

    enum SpolierEjectedInjected {
        case injected, ejected
    }

    enum HeadlightsUpDown {
        case rise, decline
    }
    
    private let assembleType: AssembleTypeCar
    private var spoilerStatus: SpolierEjectedInjected
    private var headlightStatus: HeadlightsUpDown
    
    init?(
        mark: String?,
        releaseYear: Int,
        totalTrunckCapacity: Double,
        assembleType: AssembleTypeCar)
    {
        self.assembleType = assembleType
        self.spoilerStatus = .injected
        self.headlightStatus = .decline
        super.init(
            mark: mark,
            releaseYear: releaseYear,
            totalTrunckCapacity: totalTrunckCapacity
        )
    }
    
    func getAssembleType() -> AssembleTypeCar {
        return self.assembleType
    }
    
    func getSpoilerStatus() -> SpolierEjectedInjected {
        return self.spoilerStatus
    }
    
    func getHeadlightStatus() -> HeadlightsUpDown {
        return self.headlightStatus
    }
    
    func setSpoilerStatus(new: SpolierEjectedInjected) {
        self.spoilerStatus = new
    }
    
    func setHeadlightStatus(new: HeadlightsUpDown) {
        self.headlightStatus = new
    }
    
    override func showCarInfo() {
        print("Car mark -> \(self.getCarMark())")
        print("Car release year -> \(self.getCarReleaseYear())")
        print("Car total trunk capacity -> \(self.getCarTotalTrunkCapacity())")
        print("Car remained trunk capacity -> \(self.getCarRemainedTrunkCapacity())")
        print("Car engine status -> \(self.getEngineStatus())")
        print("Car windows status -> \(self.getWindowsStatus())")
        
        print("Car spoiler status -> \(self.getSpoilerStatus())")
        print("Car headlight status -> \(self.getSpoilerStatus())")
        print("Car assemble type -> \(self.getAssembleType())")
    }
    
    override func actionDetector(action: Car.carActions) {
        func engineIsOFF() -> Bool {
            if self.getEngineStatus() == .off {
                print("Nothing can be done with this car. Engine is OFF.\n")
                return true
            }
            return false
        }
        
        // определение действия машины
        // если двигатель выключен, ни одна из функций не работает
        switch action {
        case .injectSpolier:
            if engineIsOFF() { break }
            
            if self.getSpoilerStatus() == .injected {
                print("Spoilers is already injected.\n")
                break
            } else {
                self.setSpoilerStatus(new: .injected)
                print("Spoiler was injected successfully.\n")
            }
            
        case .ejectSpolier:
            if engineIsOFF() { break }
            
            if self.getSpoilerStatus() == .ejected {
                print("Spoilers is already ejected.\n")
                break
            } else {
                self.setSpoilerStatus(new: .ejected)
                print("Spoiler was ejected successfully.\n")
            }
            
        case .riseHeadLight:
            if engineIsOFF() { break }
            
            if self.getHeadlightStatus() == .rise {
                print("Headlights are already up.\n")
                break
            } else {
                self.setHeadlightStatus(new: .rise)
                print("Headlights were up successfully.\n")
            }
        
        case .declineHeadLight:
            if engineIsOFF() { break }
            
            if self.getHeadlightStatus() == .decline {
                print("Headlights are already declined.\n")
                break
            } else {
                self.setHeadlightStatus(new: .decline)
                print("Headlights were declined successfully.\n")
            }
        
        case .openWindows:
            if engineIsOFF() { break }
            
            if self.getWindowsStatus() == .opened {
                print("Windows are already opened.\n")
            } else {
                self.setWindowsStatus(new: .opened)
                print("Windows were opened successfully.\n")
            }
            
        case .closeWindows:
            if engineIsOFF() { break }
            
            if self.getWindowsStatus() == .closed {
                print("Windows are already closed.\n")
            } else {
                self.setWindowsStatus(new: .closed)
                print("Windows were closed successfully.\n")
            }
            
        case .launchEngine:
            if self.getEngineStatus() == .on {
                print("The engine is already turned ON.\n")
            } else {
                self.setEngineStatus(new: .on)
                print("The engine was turned ON successfully.\n")
            }
            
        case .stopEngine:
            if self.getEngineStatus() == .off {
                print("The engine is already turned OFF.\n")
            } else {
                self.setEngineStatus(new: .off)
                print("The engine was turned OFF successfully.\n")
            }
            
        case .loadObject(let weight):
            if engineIsOFF() { break }
            
            // Проверка на возможность перегруза
            if self.getCarRemainedTrunkCapacity() - weight < 0 {
                print("""
                    Impossible to load.
                    Overweight: \(weight - self.getCarRemainedTrunkCapacity())\n
                    """)
            } else {
                self.setRemainedTrunkCapacity(new: self.getCarRemainedTrunkCapacity() - weight)
                print("""
                    The object was successfully loaded. Weight: \(weight).
                    Available: \(self.getCarRemainedTrunkCapacity())\n
                    """)
            }
    
        case .loadOutObject(let weight):
            if engineIsOFF() { break }
            
            // Проверка доступного объема выгрузки ресурсов
            if self.getCarRemainedTrunkCapacity() + weight > self.getCarTotalTrunkCapacity() {
                print("""
                    Impossible to load out. There is no such object in the trunk.
                    Over load out: \(self.getCarRemainedTrunkCapacity() + weight - self.getCarTotalTrunkCapacity())\n
                    """)
            } else {
                self.setRemainedTrunkCapacity(new: self.getCarRemainedTrunkCapacity() + weight)
                print("""
                    The object was successfully loaded out. Weight: \(weight).
                    Available: \(self.getCarRemainedTrunkCapacity())\n
                    """)
            }
        default:
            print("Unknown operation.\n")
        }
    }
}

final class TrunkCar: Car {
    
    enum BackwardSignalType {
        case on, off
    }
    
    enum TrunkUpDown {
        case up, down
    }
    
    private let color: UIColor
    private var trunkStatus: TrunkUpDown
    private var backwardSignalStatus: BackwardSignalType
    
    init?(
        mark: String?,
        releaseYear: Int,
        totalTrunckCapacity: Double,
        color: UIColor
    ) {
        self.color = color
        self.backwardSignalStatus = .off
        self.trunkStatus = .down
        super.init(
            mark: mark,
            releaseYear: releaseYear,
            totalTrunckCapacity: totalTrunckCapacity
        )
    }
    
    func getColor() -> UIColor {
        return self.color
    }
    
    func getBackwardSignalStatus() -> BackwardSignalType {
        return self.backwardSignalStatus
    }
    
    func setBackwardSignalStatus(new: BackwardSignalType) {
        self.backwardSignalStatus = new
    }
    
    func getTrunkStatus() -> TrunkUpDown {
        return self.trunkStatus
    }
    
    func setTrunkStatus(new: TrunkUpDown) {
        self.trunkStatus = new
    }
    
    override func showCarInfo() {
        print("Car mark -> \(self.getCarMark())")
        print("Car release year -> \(self.getCarReleaseYear())")
        print("Car total trunk capacity -> \(self.getCarTotalTrunkCapacity())")
        print("Car remained trunk capacity -> \(self.getCarRemainedTrunkCapacity())")
        print("Car engine status -> \(self.getEngineStatus())")
        print("Car windows status -> \(self.getWindowsStatus())")
        
        print("Car color -> \(self.getColor())")
        print("Car trunk status -> \(self.getTrunkStatus())")
        print("Car backward signal's status -> \(self.getBackwardSignalStatus())")
    }
    
    override func actionDetector(action: Car.carActions) {
        func engineIsOFF() -> Bool {
            if self.getEngineStatus() == .off {
                print("Nothing can be done with this car. Engine is OFF.\n")
                return true
            }
            return false
        }
        
        // определение действия машины
        // если двигатель выключен, ни одна из функций не работает
        switch action {
        
        case .riseTrunk:
            if engineIsOFF() { break }
            
            if self.getTrunkStatus() == .up {
                print("Trunk is already up.\n")
            } else {
                self.setTrunkStatus(new: .up)
                print("Trink status was successfully up.\n")
            }
            
        case .declineTrunk:
            if engineIsOFF() { break }
            
            if self.getTrunkStatus() == .down {
                print("Trunk is already down.\n")
            } else {
                self.setTrunkStatus(new: .down)
                print("Trink status was successfully down.\n")
            }
            
        case .turnOnBackwardSignal:
            if engineIsOFF() { break }
            
            if self.getBackwardSignalStatus() == .on {
                print("Backward Signal is already on.\n")
            } else {
                self.setBackwardSignalStatus(new: .on)
                print("Backward Signal was siccessfully on.\n")
            }
                        
        case .turnOffBackwardSignal:
            if engineIsOFF() { break }
            
            if self.getBackwardSignalStatus() == .off {
                print("Backward Signal is already off.\n")
            } else {
                self.setBackwardSignalStatus(new: .off)
                print("Backward Signal was siccessfully off.\n")
            }
        
        case .openWindows:
            if engineIsOFF() { break }
            
            if self.getWindowsStatus() == .opened {
                print("Windows are already opened.\n")
            } else {
                self.setWindowsStatus(new: .opened)
                print("Windows were opened successfully.\n")
            }
            
        case .closeWindows:
            if engineIsOFF() { break }
            
            if self.getWindowsStatus() == .closed {
                print("Windows are already closed.\n")
            } else {
                self.setWindowsStatus(new: .closed)
                print("Windows were closed successfully.\n")
            }
            
        case .launchEngine:
            if self.getEngineStatus() == .on {
                print("The engine is already turned ON.\n")
            } else {
                self.setEngineStatus(new: .on)
                print("The engine was turned ON successfully.\n")
            }
            
        case .stopEngine:
            if self.getEngineStatus() == .off {
                print("The engine is already turned OFF.\n")
            } else {
                self.setEngineStatus(new: .off)
                print("The engine was turned OFF successfully.\n")
            }
            
        case .loadObject(let weight):
            if engineIsOFF() { break }
            
            // Проверка на возможность перегруза
            if self.getCarRemainedTrunkCapacity() - weight < 0 {
                print("""
                    Impossible to load.
                    Overweight: \(weight - self.getCarRemainedTrunkCapacity())\n
                    """)
            } else {
                self.setRemainedTrunkCapacity(new: self.getCarRemainedTrunkCapacity() - weight)
                print("""
                    The object was successfully loaded. Weight: \(weight).
                    Available: \(self.getCarRemainedTrunkCapacity())\n
                    """)
            }
    
        case .loadOutObject(let weight):
            if engineIsOFF() { break }
            
            // Проверка доступного объема выгрузки ресурсов
            if self.getCarRemainedTrunkCapacity() + weight > self.getCarTotalTrunkCapacity() {
                print("""
                    Impossible to load out.
                    There is no such object in the trunk.
                    Over load out: \(self.getCarRemainedTrunkCapacity() + weight - self.getCarTotalTrunkCapacity())\n
                    """)
            } else {
                self.setRemainedTrunkCapacity(new: self.getCarRemainedTrunkCapacity() + weight)
                print("""
                    The object was successfully loaded out. Weight: \(weight).
                    Available: \(self.getCarRemainedTrunkCapacity())\n
                    """)
            }
            
        default:
            print("Unknown operation.\n")
        }
    }
}

var sportCarOne = SportCar(mark: "Aston Martin", releaseYear: 2019, totalTrunckCapacity: 400, assembleType: .manual)
var sportCarTwo = SportCar(mark: "Toyota", releaseYear: 2017, totalTrunckCapacity: 1400, assembleType: .factory)

var trunkCarOne = TrunkCar(mark: "Gus", releaseYear: 2019, totalTrunckCapacity: 50000, color: .brown)
var trunkCarTwo = TrunkCar(mark: "BMW", releaseYear: 2010, totalTrunckCapacity: 500000, color: .black)

sportCarOne?.actionDetector(action: .launchEngine)
sportCarOne?.actionDetector(action: .openWindows)
sportCarOne?.actionDetector(action: .injectSpolier)
sportCarOne?.actionDetector(action: .ejectSpolier)
sportCarOne?.actionDetector(action: .injectSpolier)
sportCarOne?.actionDetector(action: .closeWindows)
sportCarOne?.actionDetector(action: .loadObject(100))
sportCarOne?.actionDetector(action: .loadOutObject(500))
sportCarOne?.actionDetector(action: .loadObject(1000))
sportCarOne?.actionDetector(action: .loadOutObject(100))
sportCarOne?.actionDetector(action: .stopEngine)
sportCarOne?.showCarInfo()
SportCar.separate()

sportCarTwo?.actionDetector(action: .riseTrunk)
sportCarTwo?.actionDetector(action: .riseHeadLight)
sportCarTwo?.actionDetector(action: .launchEngine)
sportCarTwo?.actionDetector(action: .riseHeadLight)
sportCarTwo?.actionDetector(action: .declineHeadLight)
sportCarTwo?.actionDetector(action: .stopEngine)
sportCarTwo?.showCarInfo()
SportCar.separate()

trunkCarOne?.actionDetector(action: .launchEngine)
trunkCarOne?.actionDetector(action: .riseTrunk)
trunkCarOne?.actionDetector(action: .declineTrunk)
trunkCarOne?.actionDetector(action: .turnOnBackwardSignal)
trunkCarOne?.actionDetector(action: .turnOffBackwardSignal)
trunkCarOne?.actionDetector(action: .loadObject(10000))
trunkCarOne?.actionDetector(action: .loadOutObject(10000))
trunkCarOne?.actionDetector(action: .stopEngine)
trunkCarOne?.showCarInfo()
SportCar.separate()

trunkCarTwo?.actionDetector(action: .riseTrunk)
trunkCarTwo?.actionDetector(action: .launchEngine)
trunkCarTwo?.actionDetector(action: .loadObject(500000))
trunkCarTwo?.actionDetector(action: .loadObject(1))
trunkCarTwo?.actionDetector(action: .loadOutObject(500000))
trunkCarTwo?.actionDetector(action: .loadOutObject(1))
trunkCarTwo?.actionDetector(action: .stopEngine)
trunkCarTwo?.showCarInfo()
SportCar.separate()
