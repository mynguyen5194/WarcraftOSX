//
//  GraphicTileset.swift
//  WarcraftOSX
//
//  Created by Michelle Lee on 1/28/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa

class GraphicTileset: NSViewController {
    
    var tileHash = [String: Int]()      //DMapping
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let terrainDat = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/img/Terrain", ofType: "dat"))!)
        
        do{
            let terrainString = try String(contentsOf: terrainDat)
            let tileNames = terrainString.components(separatedBy: .newlines)
            
            
            var index = 0;
            for i in 2..<295{
                tileHash[ tileNames[i] ] = index
                index += 1
            }
            
            
        } catch{
            print(error)
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
