//
//  GraphicTileset.swift
//  WarcraftOSX
//
//  Created by Michelle Lee on 1/28/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa

class OSXGraphicTileset {
    
    var tileHash = [String: Int]()      //DMapping
    var index = 0;
    let terrainDat = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/img/Terrain", ofType: "dat"))!)
    
    init(){
        do {
            let terrainString = try String(contentsOf: terrainDat)
            let tileNames = terrainString.components(separatedBy: .newlines)
            for i in 2..<295{
                tileHash[ tileNames[i] ] = index
                index += 1
            }
        } catch {
            NSLog("Error: terrainDat failed to load")
        }
    }
    
    //CGraphicTileset::FindTile
    func findTile(tilename: String) -> Int{
        if tileHash[tilename] != nil {
            return tileHash[tilename]!
        } else {
            return -1
        }
    }
}
 


