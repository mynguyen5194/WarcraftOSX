//
//  CustomView.swift
//  WarcraftOSX
//
//  Created by Kristoffer Solomon on 1/31/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa
import Foundation
import AVFoundation

class CustomView: NSView {
    
    let map = MapRenderer()
    var mainContext:CGContext?
    var baseLayerContext:CGContext?
    
    override func draw(_ dirtyRect: NSRect) {
        mapSetup()
    }
    
    func mapSetup() {

        mainContext = NSGraphicsContext.current()?.cgContext
        
        //create initial layer
        let baseLayer = CGLayer.init(mainContext!, size: map.getTileWidthAndHeight(), auxiliaryInfo: nil)
        baseLayerContext = baseLayer?.context
        
        drawTile(xPos:50, yPos: 50, tileIndex: 200, layer: baseLayer!)
        drawTile(xPos:82, yPos: 82, tileIndex: 100, layer: baseLayer!)
    }
    
    //drawing the specified tile (given by tileIndex) at specified position (xPos, yPos) on layer (layer)
    func drawTile(xPos: Int, yPos: Int, tileIndex: Int, layer: CGLayer){
        baseLayerContext?.draw(map.getTile(tilePosition: tileIndex), in: self.bounds)
        let xPosition = CGFloat(xPos)
        let yPosition = CGFloat(yPos)
        let startingPoint = CGPoint(x: xPosition, y: yPosition)
        mainContext?.draw(layer, at: startingPoint)
    }
    
    
}
