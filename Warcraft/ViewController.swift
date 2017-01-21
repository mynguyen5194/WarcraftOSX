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
    
    
    @IBOutlet weak var splashScreen: NSImageView!
    @IBOutlet var viewControllerOutlet: NSView!
    @IBOutlet weak var textLabel: NSTextField!
    @IBOutlet weak var mouseTextLabel: NSTextField!
    @IBOutlet weak var leftClickRecognizer: NSClickGestureRecognizer!
    @IBOutlet weak var rightClickRecognizer: NSClickGestureRecognizer!
    
    //intro sound wav
    let startupSoundURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "intro", ofType: "wav"))!)
    var startupSound = AVAudioPlayer()
    
    //splash screen
    let startupAnimationURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "Splash", ofType: "png"))!)
    var startupAnimation = NSImage()
    
    //menu sound midi
    let menuSoundURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "menu", ofType: "mid"))!)
    let menuSoundBankURL = Bundle.main.url(forResource: "generalsoundfont", withExtension: "sf2")
    var menuSound = AVMIDIPlayer()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //setup
        startupAnimation = NSImage(byReferencing: startupAnimationURL)
        splashScreen.image = startupAnimation
        textLabel.stringValue = "No Input Received"
        mouseTextLabel.stringValue = "Mouse not detected"
        mouseTextLabel.isSelectable = false
        
        
        //mouse tracking
        let mouseTrackingArea = NSTrackingArea(rect: viewControllerOutlet.bounds , options: [NSTrackingAreaOptions.mouseEnteredAndExited,NSTrackingAreaOptions.mouseMoved,NSTrackingAreaOptions.activeInActiveApp], owner: self, userInfo: nil)
        viewControllerOutlet.addTrackingArea(mouseTrackingArea)
        
        //Set bit mask for clicks
        leftClickRecognizer.buttonMask = 0x1
        rightClickRecognizer.buttonMask = 0x2
        
        
        //play wav file
        do {
            try startupSound = AVAudioPlayer(contentsOf: startupSoundURL)
        }
        catch {
            NSLog("Error: Can't play sound file intro.wav")
        }
        startupSound.prepareToPlay()
        startupSound.play()
        
        //play mid file
        do {
            try menuSound = AVMIDIPlayer(contentsOf: menuSoundURL, soundBankURL: menuSoundBankURL)
        }
        catch {
            NSLog("Error: Can't play sound file menu.mid")
        }
        //menuSound.prepareToPlay()
        //menuSound.play()
        
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func primaryMouse(_ sender: Any) {
        textLabel.stringValue = "Primary Mouse"
    }
    
    @IBAction func secondaryMouse(_ sender: Any) {
        textLabel.stringValue = "Secondary Mouse"
    }
    
    override func mouseMoved(with event: NSEvent) {
        textLabel.stringValue = "Mouse Moving"
    }
    
    override func mouseEntered(with event: NSEvent) {
        mouseTextLabel.stringValue = "Mouse Entered"
    }
    
    override func mouseExited(with event: NSEvent) {
        mouseTextLabel.stringValue = "Mouse Exited"
    }
    
}




