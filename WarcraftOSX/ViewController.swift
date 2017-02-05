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
    var acknowledgeSound = AVAudioPlayer()
    let acknowledge1URL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/basic/acknowledge1", ofType: "wav"))!)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set splash screen
        //let visualElements = VisualElements()
        //splashScreen.image = visualElements.getSplashImage()
        
        let mapRenderingDat = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/img/MapRendering", ofType: "dat"))!)
        do{
            let mapRenderingString = try String(contentsOf: mapRenderingDat)
            let mapRenderingArr = mapRenderingString.components(separatedBy: " ")
            
            var map = TerrainMap()
            
            
        } catch {
            print(error)
        }
        
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

