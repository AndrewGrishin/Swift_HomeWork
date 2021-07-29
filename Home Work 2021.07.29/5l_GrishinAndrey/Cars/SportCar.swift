//
//  SportCar.swift
//  5l_GrishinAndrey
//
//  Created by Andrey Grishin on 2021.07.28.
//

import Foundation

class SportCar: CarProtocol {
    let mark: String
    let releaseYear: Int
    let totalTrunkCapacity: Double
    var remainedTrunkCapacity: Double
    var engineStatus: EngineOnOff
    var windowsStatus: WindowsOpenClose
    
    let assembleType: AssembleTypeCar
    var spoilerStatus: SpolierEjectedInjected
    var headlightsStatus: HeadlightsUpDown
    
    init?(
        mark: String?,
        releaseYear: Int,
        totalTrunkCapacity: Double,
        assembleType: AssembleTypeCar)
    {
        guard let mark = mark, releaseYear >= 0 && totalTrunkCapacity >= 0 else {
            return nil
        }
        self.mark = mark
        self.releaseYear = releaseYear
        self.totalTrunkCapacity = totalTrunkCapacity
        self.remainedTrunkCapacity = totalTrunkCapacity
        self.engineStatus = .off
        self.windowsStatus = .closed
        self.assembleType = assembleType
        self.spoilerStatus = .injected
        self.headlightsStatus = .decline
    }
    
    
}

extension SportCar: CustomStringConvertible {
    var description: String {
        let buffer: String = """
        Mark: \(self.mark)
        Release year: \(self.releaseYear)
        Tunk capacity: \(self.totalTrunkCapacity)
        Engine is \(self.engineStatus.rawValue)
        Windows are \(self.windowsStatus.rawValue)
        Assemble type: \(self.assembleType.rawValue)
        Spoiler is \(self.spoilerStatus.rawValue)
        Headlights are \(self.headlightsStatus.rawValue)
        -------------------------\n
        """
        return buffer
    }
}
