//
//  Enums.swift
//  5l_GrishinAndrey
//
//  Created by Andrey Grishin on 2021.07.28.
//

import Foundation

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

enum EngineOnOff: String {
    case on
    case off
}

enum WindowsOpenClose: String {
    case opened, closed
}

enum AssembleTypeCar: String {
    case manual, factory
}

enum SpolierEjectedInjected: String {
    case injected, ejected
}

enum HeadlightsUpDown: String {
    case rise, decline
}

enum BackwardSignalType: String {
    case on, off
}

enum TrunkUpDown: String {
    case up, down
}
