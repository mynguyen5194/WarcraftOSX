//
//  GameDataType.swift
//  Warcraft
//
//  Created by Jeffrey Wang on 1/29/17.
//  Copyright © 2017 Kristoffer Solomon. All rights reserved.
//
import Foundation

enum playerColor: Int {
    case none = 0
    case blue
    case red
    case green
    case purple
    case orange
    case yellow
    case black
    case white
    case max
}

enum assetAction: Int {
    case none = 0
    case construct
    case build
    case repair
    case walk
    case standGround
    case attack
    case harvestLumber
    case mineGold
    case conveyLumber
    case conveyGold
    case death
    case decay
    case capability
}

enum assetCapabilityType: Int {
    case none = 0
    case buildPeasant
    case buildFootman
    case buildArcher
    case buildRanger
    case buildFarm
    case buildTownHall
    case buildBarracks
    case buildLumberMill
    case buildBlacksmith
    case buildKeep
    case buildCastle
    case buildScoutTower
    case buildGuardTower
    case buildCannonTower
    case move
    case repair
    case mine
    case buildSimple
    case buildAdvanced
    case convey
    case cancel
    case buildWall
    case attack
    case standGround
    case patrol
    case weaponUpgrade1
    case weaponUpgrade2
    case weaponUpgrade3
    case arrowUpgrade1
    case arrowUpgrade2
    case arrowUpgrade3
    case armorUpgrade1
    case armorUpgrade2
    case armorUpgrade3
    case longbow
    case rangerScouting
    case marksmanship
    case max
}

enum assetType: Int {
    case none = 0
    case peasant
    case footman
    case archer
    case ranger
    case goldMine
    case townHall
    case keep
    case castle
    case farm
    case barracks
    case lumberMill
    case blacksmith
    case scoutTower
    case guardTower
    case cannonTower
    case max
}

enum direction: Int {
    case north = 0
    case northEast = 45
    case east = 90
    case southEast = 135
    case south = 180
    case southWest = 225
    case west = 270
    case northWest = 315
    case max = 360
    
    var opposite: direction {
        return direction(rawValue: (rawValue + direction.max.rawValue/2) % direction.max.rawValue)!
    }
}
