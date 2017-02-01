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
    
    override func draw(_ dirtyRect: NSRect) {
        mapSetup()
        
    }
    
    func mapSetup() {
        
        let map = MapRenderer()
        let mainContext = NSGraphicsContext.current()?.cgContext
        
        //create initial layer
        let baseLayer = CGLayer.init(mainContext!, size: map.getTileWidthAndHeight(), auxiliaryInfo: nil)
        let baseLayerContext = baseLayer?.context
        baseLayerContext?.draw(map.getTile(tilePosition: 100), in: self.bounds)
        let xPosition = CGFloat.init(0)
        let yPosition = CGFloat.init(50)
        let startingPoint = CGPoint.init(x: xPosition, y: yPosition)
        mainContext?.draw(baseLayer!, at: startingPoint)

    }
    
}
