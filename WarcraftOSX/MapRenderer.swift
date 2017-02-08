//
//  singlePlayer.swift
//  WarcraftOSX
//
//  Created by Michelle Lee on 1/28/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa

class MapRenderer: NSViewController {

    var tileArray = [CGImage]()
    
    override func viewDidLoad() {           //treating this like initalizer
        super.viewDidLoad()
        
        let terrainURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/img/Terrain", ofType:"png"))!)
        
        //terrain png to CGimage
        let terrainData = CGDataProvider(url: terrainURL as CFURL)
        let terrainCG = CGImage(pngDataProviderSource: terrainData!, decode: nil, shouldInterpolate: false, intent: CGColorRenderingIntent.defaultIntent)
        
        //initalize tile specifications
        let tileHeight = (terrainCG!.height / 293)
        let tileSize = CGSize(width: terrainCG!.width, height: tileHeight)
        var tileOrigin = CGPoint()
        var tileRect = CGRect()
        var tileYCoord = 0
        
        //storing each individual tile in tileArray
        for _ in 0..<293{
            tileOrigin = CGPoint(x: 0, y: tileYCoord)
            tileRect = CGRect(origin: tileOrigin, size: tileSize)
            let tile = terrainCG?.cropping(to: tileRect)
            tileArray.append(tile!.copy()!)
            
            tileYCoord += tileHeight
        }
    }   //end viewDidLoad()
    
    func drawMap(){
        
    }
    
}
