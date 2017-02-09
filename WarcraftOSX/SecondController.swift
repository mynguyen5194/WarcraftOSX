//
//  SecondController.swift
//  WarcraftOSX
//
//  Created by Alan Wei on 2/6/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa

class SecondController: NSViewController {

    let object = StatObjects()
    var peasantView = NSImageView()
    var peasant = NSImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        object.viewDidLoad()
        
        peasantView = NSImageView(frame: NSRect(x: 0, y: 0, width: 100, height: 100))
        peasant = NSImage(cgImage: (object.objectDictArray["Peasant"]![0]), size: NSZeroSize)
        peasantView.image = peasant
        view.addSubview(peasantView)
        
        var xPos = 50
        var yPos = 150
        
        for i in 1 ..< 6 {
            let imageView = NSImageView(frame: NSRect(x: xPos, y: yPos, width: 100, height: 100))
            let images = NSImage(cgImage: (object.objectDictArray[object.objectNames[i]]![0]), size: NSZeroSize)
            imageView.image = images
            view.addSubview(imageView)
            xPos += 100
        }
        
        xPos = 0
        yPos = 250
        
        for i in 6 ..< object.objectDictArray.count {
            let imageView = NSImageView(frame: NSRect(x: xPos, y: yPos, width: 100, height: 100))
            let images = NSImage(cgImage: (object.objectDictArray[object.objectNames[i]]![2]), size: NSZeroSize)
            imageView.image = images
            view.addSubview(imageView)
            xPos += 100
        }
        
        let mouseTrackingArea = NSTrackingArea(rect: peasantView.bounds, options: [NSTrackingAreaOptions.mouseEnteredAndExited, NSTrackingAreaOptions.mouseMoved,NSTrackingAreaOptions.activeInActiveApp], owner: self, userInfo: nil)

        peasantView.addTrackingArea(mouseTrackingArea)

    }
    
    
    override func mouseDown(with event: NSEvent) {
        
        var npeasantView = NSImageView()
        var npeasant = NSImage()
        
        if (Int(NSEvent.mouseLocation().y) > 250 && Int(NSEvent.mouseLocation().x) < 425) {
            npeasantView = NSImageView(frame: NSRect(x: 0, y: 0, width: 100, height: 100))
            npeasant = NSImage(cgImage: (object.objectDictArray["Peasant"]![0]), size: NSZeroSize)
            npeasantView.image = npeasant
            view.replaceSubview(peasantView, with: npeasantView)
            peasantView = npeasantView
        }
        else if (Int(NSEvent.mouseLocation().x) > 415 && Int(NSEvent.mouseLocation().y) > 275) {
            npeasantView = NSImageView(frame: NSRect(x: 0, y: 0, width: 100, height: 100))
            npeasant = NSImage(cgImage: (object.objectDictArray["Peasant"]![5]), size: NSZeroSize)
            npeasantView.image = npeasant
            view.replaceSubview(peasantView, with: npeasantView)
            peasantView = npeasantView
        }
        else if (Int(NSEvent.mouseLocation().y) < 350 && Int(NSEvent.mouseLocation().x) > 425) {
            npeasantView = NSImageView(frame: NSRect(x: 0, y: 0, width: 100, height: 100))
            npeasant = NSImage(cgImage: (object.objectDictArray["Peasant"]![10]), size: NSZeroSize)
            npeasantView.image = npeasant
            view.replaceSubview(peasantView, with: npeasantView)
            peasantView = npeasantView
        }
    }
    
}
