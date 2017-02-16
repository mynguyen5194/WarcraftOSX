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
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
            (event) -> NSEvent? in self.keyDown(with: event)
            return event
        }
    }
    
    // Flips the inverted map to display map correctly
    override var isFlipped: Bool{
        return true
    }
    
    // Mouse dragging allows user to scroll through the map
    override func mouseDragged(with event: NSEvent) {
        
        // Moves frame of the NSView by the deltaX and deltaY of the mouseDrag
        frame.origin.x += event.deltaX
        frame.origin.y -= event.deltaY
        
        // Hard coded to set boundary to 990 for xPos and 600 yPos
        frame.origin.x = max(min(frame.origin.x, 0), -frame.size.width + (window?.frame.width)!)
        frame.origin.y = max(min(frame.origin.y, 0), -frame.size.height + (window?.frame.height)!)
    }
    
    // Arrow keys allows user to scroll through the map
    override func keyDown(with event: NSEvent) {
        
        // Convert an integer to CGFloat to be used in changing frame coordinates
        let myCGFloat = CGFloat(50)
        
        //left arrow
        if event.keyCode == 123 {
            frame.origin.x += myCGFloat
            frame.origin.x = max(min(frame.origin.x, 0), -frame.size.width + self.visibleRect.width)
        }
        //right arrow
        else if event.keyCode == 124 {
            frame.origin.x -= myCGFloat
            frame.origin.x = max(min(frame.origin.x, 0), -frame.size.width + self.visibleRect.width)
        }
        //down arrow
        else if event.keyCode == 125 {
            frame.origin.y += myCGFloat
            frame.origin.y = max(min(frame.origin.y, 0), -frame.size.height + 600)
        }
        //up arrow
        else if event.keyCode == 126 {
            frame.origin.y -= myCGFloat
            frame.origin.y = max(min(frame.origin.y, 0), -frame.size.height + 600)
        }
    }
    
    override func draw(_ dirtyRect: CGRect) {
        
        guard let mapRenderer = mapRenderer, let assetRenderer = assetRenderer else {
            return
        }
        do {
            let rectangle = Rectangle(xPosition: 0, yPosition: 0, width: mapRenderer.detailedMapWidth, height: mapRenderer.detailedMapHeight)
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

class OSXMainMenu {
    
    var menu:NSImage
    
    init(){
        
        let menuURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/img/Texture", ofType:"png"))!)
        
        let menuData = CGDataProvider(url: menuURL as CFURL)
        
        let menuCG = CGImage(pngDataProviderSource: menuData!, decode: nil, shouldInterpolate: false, intent: CGColorRenderingIntent.defaultIntent)
        
        let menuOrigin = CGPoint(x: 0, y: 0)
        
        let menuSize = CGSize(width: menuCG!.width, height: menuCG!.height)
        
        let menuRect = CGRect(origin: menuOrigin, size: menuSize)
        
        let menuImage = menuCG?.cropping(to: menuRect)
        
        menu = NSImage(cgImage: menuImage!, size: NSZeroSize)
        
    }
    
    
    
    func getMenuImage() -> NSImage {
        
        return self.menu
        
    }
    
}
