//
//  TunkCar.swift
//  5l_GrishinAndrey
//
//  Created by Andrey Grishin on 2021.07.28.
//

import Foundation

class TunkCar: CarProtocol {
    let mark: String
    let releaseYear: Int
    let totalTrunkCapacity: Double
    var remainedTrunkCapacity: Double
    var engineStatus: EngineOnOff
    var windowsStatus: WindowsOpenClose
    
    var trunkStatus: TrunkUpDown
    var backwardSignalStatus: BackwardSignalType
    
    init?(
        mark: String?,
        releaseYear: Int,
        totalTrunkCapacity: Double)
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
        
        self.trunkStatus = .down
        self.backwardSignalStatus = .off
    }
    
    
}

extension TunkCar: CustomStringConvertible {
    var description: String {
        let buffer: String = """
        Mark: \(self.mark)
        Release year: \(self.releaseYear)
        Tunk capacity: \(self.totalTrunkCapacity)
        Engine is \(self.engineStatus.rawValue)
        Windows are \(self.windowsStatus.rawValue)
        Trunk is \(self.trunkStatus.rawValue)
        Backward signal is \(self.backwardSignalStatus.rawValue)
        -------------------------\n
        """
        return buffer
    }
}
