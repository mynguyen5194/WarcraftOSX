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
    @IBOutlet weak var tileEX: NSImageView!
    @IBOutlet weak var primaryMouseOutlet: NSClickGestureRecognizer!
    
    
    //menu sound midi
    let menuSoundURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/music/load", ofType: "mid"))!)
    let menuSoundBankURL = Bundle.main.url(forResource: "data/snd/generalsoundfont", withExtension: "sf2")
    var menuSound = AVMIDIPlayer()
    
    
    //    //load wave file for mouse click
    let acknowledge1URL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/basic/acknowledge2", ofType: "wav"))!)
    var acknowledgeSound = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        playMidi()
        
        
        
//                let map = MapRenderer()
//                map.viewDidLoad()
        
//                tileEX.image = NSImage(cgImage: map.tileArray[100], size: NSZeroSize)
//                var timerToMenu = Timer(timeInterval: 5.0, target: self, selector: (timerFireMethod: timer), userInfo: nil, repeats: false)
        
//                let parseDat = GraphicTileset()
//                parseDat.viewDidLoad()
        
        
        
        
                //Set bit mask for clicks
//                primaryMouseOutlet.buttonMask = 0x1
        
        
        
        
    }
    
    /*func map(){
     let tower = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/img/TownHall", ofType:"png"))!)
     splashScreen.image = NSImage(byReferencing: tower)
     }*/
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
    

    // Play midi file
    func playMidi() {
        do {
            try menuSound = AVMIDIPlayer(contentsOf: menuSoundURL, soundBankURL: menuSoundBankURL)
        }
        catch {
            NSLog("Error: Can't play sound file menu.mid")
        }
        menuSound.prepareToPlay()
        menuSound.play()
        
    }
    
    
    @IBAction func primaryMouse(_ sender: Any) {
        //play wav file
        do {
//            menuSound.stop()
            try acknowledgeSound = AVAudioPlayer(contentsOf: acknowledge1URL)
        }
        catch {
            NSLog("Error: Can't play sound file intro.wav")
        }
        acknowledgeSound.prepareToPlay()
        acknowledgeSound.play()
    }
    
}

