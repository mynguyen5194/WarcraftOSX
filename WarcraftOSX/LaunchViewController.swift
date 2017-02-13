//
//  ViewController.swift
//  WarcraftOSX
//
//  Created by Michelle Lee on 1/28/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa
import AVFoundation

class LaunchViewController: NSViewController {
    
    @IBOutlet var viewOfViewController: NSView!
    @IBOutlet weak var splashScreen: NSImageView!
    @IBOutlet weak var loadMapButton: NSButton!
    var acknowledgeSound = AVAudioPlayer()
    let acknowledge1URL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/basic/acknowledge1", ofType: "wav"))!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set splash screen
        let visualElements = OSXVisualElements()
        splashScreen.image = visualElements.getSplashImage()
        
        //Button Elements
        loadMapButton.title = "Load Map"
        
    }
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        do {
            try acknowledgeSound = AVAudioPlayer(contentsOf: acknowledge1URL)
        } catch {
            NSLog("Error: Unable to load acknowledge1.wav")
        }
        acknowledgeSound.prepareToPlay()
        acknowledgeSound.play()
    }
    
}

