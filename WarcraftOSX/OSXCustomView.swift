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

class OSXCustomView: NSView {
    
    weak var mapRenderer: MapRenderer?
    weak var assetRenderer: AssetRenderer?
    convenience init(frame: CGRect, mapRenderer: MapRenderer, assetRenderer: AssetRenderer) {
        self.init(frame: frame)
        self.mapRenderer = mapRenderer
        self.assetRenderer = assetRenderer
    }
    
    override var isFlipped: Bool{
        return true
    }
    
    
    // Mouse dragging allows user to scroll through the map
    override func mouseDragged(with event: NSEvent) {
        frame.origin.x += event.deltaX
        frame.origin.y -= event.deltaY
    }
    
    override func draw(_ dirtyRect: CGRect) {
        
        guard let mapRenderer = mapRenderer, let assetRenderer = assetRenderer else {
            return
        }
        do {
            let rectangle = Rectangle(xPosition: 100, yPosition: -1450, width: mapRenderer.detailedMapWidth, height: mapRenderer.detailedMapHeight)
            let layer = GraphicFactory.createSurface(width: mapRenderer.detailedMapWidth, height: mapRenderer.detailedMapHeight, format: .a1)!
            let typeLayer = GraphicFactory.createSurface(width: mapRenderer.detailedMapWidth, height: mapRenderer.detailedMapHeight, format: .a1)!
            try mapRenderer.drawMap(on: layer, typeSurface: typeLayer, in: rectangle, level: 0)
            try assetRenderer.drawAssets(on: layer, typeSurface: typeLayer, in: rectangle)
            try mapRenderer.drawMap(on: layer, typeSurface: typeLayer, in: rectangle, level: 1)
            let context = UIGraphicsGetCurrentContext()!
            context.draw(layer as! CGLayer, in: self.bounds)
            context.draw(typeLayer as! CGLayer, in: dirtyRect)
        } catch {
            let error = NSError.init(domain: "Failed in draw function of OSXCustomView", code: 0, userInfo: nil)
            fatalError(error.localizedDescription)
        }
    }
}
