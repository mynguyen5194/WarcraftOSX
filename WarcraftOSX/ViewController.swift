//
//  ViewController.swift
//  WarcraftOSX
//
//  Created by Michelle Lee on 1/28/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa
import AVFoundation

class ViewController: NSViewController {

    @IBOutlet var viewOfViewController: NSView!
    @IBOutlet weak var splashScreen: NSImageView!
    @IBOutlet weak var tileEX: NSImageView!
    @IBOutlet weak var primaryMouseOutlet: NSClickGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set bit mask for clicks
        primaryMouseOutlet.buttonMask = 0x1
        //set splash screen
        let visualElements = VisualElements()
        splashScreen.image = visualElements.getSplashImage()
        //load map tile
        let map = MapRenderer()
        tileEX.image = NSImage(cgImage: map.getTile(tilePosition: 100), size: NSZeroSize)
        //Display Map
        
        //map
        //let mapDisplay = CGContext.init(data: nil, width: 50, height: 50, bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        //Display Map
        //mapDisplay?.draw(map.tileArray[100], in: viewOfViewController.bounds, byTiling: true)
        
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func primaryMouse(_ sender: Any) {
        let sound = SoundProperties()
        sound.acknowledgeSound.play()
    }


}

