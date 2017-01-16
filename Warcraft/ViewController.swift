//
//  ViewController.swift
//  Warcraft
//
//  Created by Kristoffer Solomon on 1/11/17.
//  Copyright © 2017 Kristoffer Solomon. All rights reserved.
//

import Cocoa
import AVFoundation

class ViewController: NSViewController {
    
    let startupSoundURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "intro", ofType: "wav"))!)
    var startupSound = AVAudioPlayer()
    
    let startupAnimationURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "Splash", ofType: "png"))!)
    var startupAnimation = NSImage()
    
    
    @IBOutlet weak var splashScreen: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        do {
            try startupSound = AVAudioPlayer(contentsOf: startupSoundURL)
        } catch {
            NSLog("Error: Can't play sound file intro.wav")
        }
        startupSound.play()
        startupAnimation = NSImage(byReferencing: startupAnimationURL)
        splashScreen.image = startupAnimation

    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
}

