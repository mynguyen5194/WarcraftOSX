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
    var acknowledgeSound = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set splash screen
        //let visualElements = VisualElements()
        //splashScreen.image = visualElements.getSplashImage()
        
        //load map tile
        //let map = MapRenderer()
        //tileEX.image = NSImage(cgImage: map.getTile(tilePosition: 100), size: NSZeroSize)
        
        //Get Sound
        let acknowledge1URL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/basic/acknowledge1", ofType: "wav"))!)
        do {
            try acknowledgeSound = AVAudioPlayer(contentsOf: acknowledge1URL)
        } catch {
            NSLog("Error: Unable to load acknowledge1.wav")
        }
        acknowledgeSound.prepareToPlay()
        
        
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    override func mouseDown(with event: NSEvent) {
        acknowledgeSound.play()
    }
}

