//
//  OSXCustomMiniMapView.swift
//  WarcraftOSX
//
//  Created by Kristoffer Solomon on 2/12/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//
import Cocoa
import Foundation

class MiniMapView: NSView {
 
    weak var mapRenderer: MapRenderer?
 
    convenience init(frame: CGRect, mapRenderer: MapRenderer) {
        self.init(frame: frame)
        self.mapRenderer = mapRenderer
    }
 
    override func draw(_ dirtyRect: CGRect) {
        guard let mapRenderer = mapRenderer else {
            return
        }
        let context = UIGraphicsGetCurrentContext()!
        let layer = CGLayer(context, size: bounds.size, auxiliaryInfo: nil)!
        mapRenderer.drawMiniMap(on: layer)
        context.draw(layer, in: dirtyRect)
    }
}
