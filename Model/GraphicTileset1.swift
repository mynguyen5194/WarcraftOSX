//
//  GraphicTileset.swift
//  Warcraft
//
//  Created by My Nguyen on 1/27/17.
//  Copyright © 2017 My Nguyen. All rights reserved.
//

import Foundation

class CGraphicTileset {
    // NEED IMPLEMENTATION
    //std::shared_ptr<CGraphicSurface> DSurfaceTileset;
    //std::vector< std::shared_ptr<CGraphicSurface> > DClippingMasks;
    
    private var DMapping = [String : Int]()
    private var DTileNames = [String]()
    private var DGroupNames = [String]()
    private var DGroupSteps = [String : Int]()
    
    var DTileCount = 0
    var DTileWidth = 0
    var DTileHeight = 0
    var DTileHalfWidth = 0
    var DTileHalfHeight = 0
    
    func ParseGroupName(tilename: String, aniname: String, anistep: Int) -> Bool {
        var anistep = anistep
        var aniname = aniname
        
        if(tilename.isEmpty){
            return false
        }
        
        //integer for loop control
        var i:Int = tilename.characters.count
        
        //scalar pair
        var scalar = tilename.unicodeScalars
        var LastIndex = scalar.endIndex

        //digit set
        let digitSet = CharacterSet.decimalDigits
        
        //normal string index
        var LastIndexString = tilename.endIndex
        
        repeat{
            i-=1;
            LastIndexString = tilename.index(before: LastIndexString)
            LastIndex = scalar.index(before: LastIndex)
            if !digitSet.contains(scalar[LastIndex]){
                if scalar.index(after: LastIndex) == scalar.endIndex{
                    return false
                }
                
                var newLast = tilename.index(after: LastIndexString)
                aniname = tilename.substring(to: newLast)
                anistep = Int (tilename.substring(from: newLast))!
                return true
            }
        }while(i > 0)
        
        return false
    }
    func UpdateGroupNames() {
        DGroupSteps.removeAll()
        DGroupNames.removeAll()
        
        for var Index in 0 ..< DTileCount {
            var GroupName = ""
            var GroupStep = 0
            
            if ParseGroupName(tilename: DTileNames[Index], aniname: GroupName, anistep: GroupStep) {
                if DGroupSteps.index(forKey: GroupName) != DGroupSteps.endIndex {
                    if DGroupSteps[GroupName]! <= GroupStep{ /////////unwrap?
                        DGroupSteps.updateValue(GroupStep+1, forKey: GroupName)
                    }
                }
                else{
                    DGroupSteps.updateValue(GroupStep+1, forKey: GroupName)
                    DGroupNames.append(GroupName)
                }
            }

        }
    }
    
    func TileCount() -> Int {
        
        return DTileCount
    }
    
    func TileCount(count: Int) -> Int {
        if count < 0 {
            return DTileCount
        }
        if DTileWidth != 0 || DTileHeight != 0 {
            return DTileCount
        }
        if(count < DTileCount) {
//            let Iterator = DMapping.first               // First element in the DMapping
            DTileCount = count
            
            for (first , second) in DMapping {
                if second >= DTileCount {
                    DMapping.removeValue(forKey: first)
                }
            }
        }
        
        DTileNames.reserveCapacity(DTileCount)
//        UpdateGroupNames()                               // ADD IMPLEMENTATION
        return DTileCount
    }
    
    func TileWidth() -> Int {
        return DTileWidth
    }
    
    func TileHeight() -> Int {
        return DTileHeight
    }
    
    func TileHalfWidth() -> Int {
        return DTileHalfWidth
    }
    
    func TileHalfHeight() -> Int {
        return DTileHalfHeight
    }
    
    
    
    ////boo's stuff
    ///bool CGraphicTileset::ClearTile(int index){
    func CGrphicTileset(index: Int) -> Bool{
        if 0 > index || index >= DTileCount{
            return false
        }
//        if
        
        return false
    }
    
    
    
    
    
    
    
    
}
