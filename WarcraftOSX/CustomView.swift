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
        let context = NSGraphicsContext.current()?.cgContext
        context?.draw(map.getTile(tilePosition: 100), in: self.bounds, byTiling: true)
    }
    
}
