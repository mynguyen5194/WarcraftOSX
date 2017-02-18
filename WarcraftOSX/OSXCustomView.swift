//
//  CustomView.swift
//  WarcraftOSX
//
//  Created by Kristoffer Solomon on 1/31/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa
import AVFoundation

class OSXCustomView: NSView {
    
    weak var viewportRenderer: ViewportRenderer?
    
    convenience init(frame: CGRect, viewportRenderer: ViewportRenderer) {
        self.init(frame: frame)
        self.viewportRenderer = viewportRenderer
        
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
            (event) -> NSEvent? in self.keyDown(with: event)
            return event
        }
    }

    override var isFlipped: Bool{
        return true
    }
    
    // Mouse dragging allows user to scroll through the map
    override func mouseDragged(with event: NSEvent) {
        frame.origin.x += event.deltaX
        frame.origin.y -= event.deltaY
        
        // NOTE: Set bounds to scrolling
        frame.origin.x = max(min(frame.origin.x, 0), -frame.size.width + 700)
        frame.origin.y = max(min(frame.origin.y, 0), -frame.size.height + 500)
    }
    
    // Arrow keys allows user to scroll through the map
    override func keyDown(with event: NSEvent) {
        
        let myCGFloat = CGFloat(50)
        
        //left arrow
        if event.keyCode == 123 {
            frame.origin.x += myCGFloat
        }
            //right arrow
        else if event.keyCode == 124 {
            frame.origin.x -= myCGFloat
        }
            //down arrow
        else if event.keyCode == 125 {
            frame.origin.y += myCGFloat
        }
            //up arrow
        else if event.keyCode == 126 {
            frame.origin.y -= myCGFloat
        }
    }
    
    override func draw(_ dirtyRect: CGRect) {
        
        guard let viewportRenderer = viewportRenderer else {
            return
        }
        do {
            let rectangle = Rectangle(xPosition: 0, yPosition: 0, width: viewportRenderer.lastViewportWidth, height: viewportRenderer.lastViewportHeight)
            let layer = GraphicFactory.createSurface(width: viewportRenderer.lastViewportWidth, height: viewportRenderer.lastViewportHeight, format: .a1)!
            let typeLayer = GraphicFactory.createSurface(width: viewportRenderer.lastViewportWidth, height: viewportRenderer.lastViewportHeight, format: .a1)!
            try viewportRenderer.drawViewport(on: layer, typeSurface: typeLayer, selectionMarkerList: [], selectRect: rectangle, currentCapability: .none)
            let context = UIGraphicsGetCurrentContext()!
            context.draw(layer as! CGLayer, in: self.bounds)
            context.draw(typeLayer as! CGLayer, in: dirtyRect)
        } catch {
            let error = NSError.init(domain: "Failed in draw function of OSXCustomView", code: 0, userInfo: nil)
            fatalError(error.localizedDescription)
        }
    }
    
}

