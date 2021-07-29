//
//  main.swift
//  5l_GrishinAndrey
//
//  Created by Andrey Grishin on 2021.07.28.
//

import Foundation

var astonMartin = SportCar(mark: "Aston Martin",
                        releaseYear: 2018,
                        totalTrunkCapacity: 400,
                        assembleType: .manual)

var ferrari = SportCar(mark: "Ferrari",
                       releaseYear: 2017,
                       totalTrunkCapacity: 500,
                       assembleType: .manual)

var gusOne = TunkCar(mark: "Gus",
                       releaseYear: 2010,
                       totalTrunkCapacity: 50_000)

var gusTwo = TunkCar(mark: "Gus",
                     releaseYear: 2011,
                     totalTrunkCapacity: -1000)

astonMartin?.actionDetector(action: .launchEngine)
astonMartin?.actionDetector(action: .loadOutObject(10))
astonMartin?.actionDetector(action: .loadObject(10))
astonMartin?.actionDetector(action: .loadOutObject(10))
astonMartin?.actionDetector(action: .loadObject(401))
astonMartin?.actionDetector(action: .ejectSpolier)
astonMartin?.actionDetector(action: .ejectSpolier)
astonMartin?.actionDetector(action: .injectSpolier)
astonMartin?.actionDetector(action: .stopEngine)
print(astonMartin ?? "There is no car object")

ferrari?.actionDetector(action: .launchEngine)
ferrari?.actionDetector(action: .loadOutObject(10))
ferrari?.actionDetector(action: .loadObject(10))
ferrari?.actionDetector(action: .loadOutObject(10))
ferrari?.actionDetector(action: .loadObject(401))
ferrari?.actionDetector(action: .ejectSpolier)
ferrari?.actionDetector(action: .ejectSpolier)
ferrari?.actionDetector(action: .injectSpolier)
ferrari?.actionDetector(action: .stopEngine)
print(ferrari ?? "There is no car object")

gusOne?.actionDetector(action: .launchEngine)
gusOne?.actionDetector(action: .declineTrunk)
gusOne?.actionDetector(action: .riseTrunk)
gusOne?.actionDetector(action: .declineTrunk)
gusOne?.actionDetector(action: .ejectSpolier)
gusOne?.actionDetector(action: .loadObject(10000))
gusOne?.actionDetector(action: .loadOutObject(10000))
gusOne?.actionDetector(action: .openWindows)
gusOne?.actionDetector(action: .closeWindows)
gusOne?.actionDetector(action: .stopEngine)
print(gusOne ?? "There is no car object")

gusTwo?.actionDetector(action: .launchEngine)
gusTwo?.actionDetector(action: .declineTrunk)
gusTwo?.actionDetector(action: .riseTrunk)
gusTwo?.actionDetector(action: .declineTrunk)
gusTwo?.actionDetector(action: .ejectSpolier)
gusTwo?.actionDetector(action: .loadObject(10000))
gusTwo?.actionDetector(action: .loadOutObject(10000))
gusTwo?.actionDetector(action: .openWindows)
gusTwo?.actionDetector(action: .closeWindows)
gusTwo?.actionDetector(action: .stopEngine)
print(gusTwo ?? "There is no car object")
