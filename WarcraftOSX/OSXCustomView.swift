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
    
    
    /*let map = OSXMapRenderer()
    var mainContext:CGContext?
    var baseLayerContext:CGContext?
    
    override func draw(_ dirtyRect: NSRect) {
        mapSetup()
    }
    
    func mapSetup() {
    //ORIGINAL BELOW THIS---------
        
        mainContext = NSGraphicsContext.current()?.cgContext
        
        //create initial layer
        let baseLayer = CGLayer(mainContext!, size: map.getTileWidthAndHeight(), auxiliaryInfo: nil)
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
    }*/
    
    weak var mapRenderer: MapRenderer?
    weak var assetRenderer: AssetRenderer?
    
    convenience init(frame: CGRect, mapRenderer: MapRenderer, assetRenderer: AssetRenderer) {
        self.init(frame: frame)
        self.mapRenderer = mapRenderer
        self.assetRenderer = assetRenderer
    }
    /*
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self), let previousLocation = touches.first?.previousLocation(in: self) else {
            return
        }
        frame.origin.x += location.x - previousLocation.x
        frame.origin.y += location.y - previousLocation.y
        frame.origin.x = max(min(frame.origin.x, 0), -frame.size.width + UIScreen.main.bounds.width)
        frame.origin.y = max(min(frame.origin.y, 0), -frame.size.height + UIScreen.main.bounds.height)
    }*/
    
    override func draw(_ rect: CGRect) {
        guard let mapRenderer = mapRenderer, let assetRenderer = assetRenderer else {
            return
        }
        do {
            let rectangle = Rectangle(xPosition: 0, yPosition: 0, width: mapRenderer.detailedMapWidth, height: mapRenderer.detailedMapHeight)
            let layer = GraphicFactory.createSurface(width: mapRenderer.detailedMapWidth, height: mapRenderer.detailedMapHeight, format: .a1)!
            let typeLayer = GraphicFactory.createSurface(width: mapRenderer.detailedMapWidth, height: mapRenderer.detailedMapHeight, format: .a1)!
            try mapRenderer.drawMap(on: layer, typeSurface: typeLayer, in: rectangle, level: 0)
            try assetRenderer.drawAssets(on: layer, typeSurface: layer, in: rectangle)
            try mapRenderer.drawMap(on: layer, typeSurface: typeLayer, in: rectangle, level: 1)
            // let builder = PlayerAsset(playerAsset: PlayerAssetType())
            // try assetRenderer.drawPlacement(on: layer, in: rectangle, position: Position(x: 100, y: 100), type: .goldMine, builder: builder)
            // try assetRenderer.drawOverlays(on: layer, in: rectangle)
            //let context = UIGraphicsGetCurrentContext()!
            let context = NSGraphicsContext.current()?.cgContext
            context?.draw(layer as! CGLayer, in: rect)
            context?.draw(typeLayer as! CGLayer, in: rect)
        } catch {
            //print(error.localizedDescription) // TODO: Handle Error
        }
    }
    
    
}
