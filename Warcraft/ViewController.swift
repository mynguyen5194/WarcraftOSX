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
//    @IBOutlet var viewScreen: NSView!
    @IBOutlet weak var textLabel: NSTextField!
    @IBOutlet weak var mouseTextLabel: NSTextField!
    @IBOutlet weak var leftClickRecognizer: NSClickGestureRecognizer!
    @IBOutlet weak var rightClickRecognizer: NSClickGestureRecognizer!
    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet weak var keyTest: NSTextField!
    
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
        
        //self.view.frame = NSMakeRect(100, 100, 400, 400)
        
        //dynamically sets mouseLocation variable to the location of mouse
        var mouseLocation: NSPoint {
            return NSEvent.mouseLocation()
        }
        
        /*
         implement fuction that allows scrolling when mouse is near the borders of the View
        */
        
        //setup
        startupAnimation = NSImage(byReferencing: startupAnimationURL)
        splashScreen.image = startupAnimation
        textLabel.stringValue = "No Input Received"
        mouseTextLabel.stringValue = "Mouse not detected"
        mouseTextLabel.isSelectable = false
        
        //mouse tracking
        let mouseTrackingArea = NSTrackingArea(rect: viewControllerOutlet.bounds , options: [NSTrackingAreaOptions.mouseEnteredAndExited, NSTrackingAreaOptions.mouseMoved,NSTrackingAreaOptions.activeInActiveApp], owner: self, userInfo: nil)
        
        viewControllerOutlet.addTrackingArea(mouseTrackingArea)
        
//        let area = NSTrackingArea(rect: NSMakeRect(0, 0, 200, 600), options: [NSTrackingAreaOptions.mouseEnteredAndExited, NSTrackingAreaOptions.activeAlways], owner: self, userInfo: nil)
        
//        startStopButton.addTrackingArea(area)
        
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
        
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
            (event) -> NSEvent? in self.keyDown(with: event)
            return event
        }
        
        NSEvent.addLocalMonitorForEvents(matching: .keyUp) {
            (event) -> NSEvent? in self.keyUp(with: event)
            return event
        }
        
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
        
        var point = scrollView.contentView.bounds.origin
        
        if (Int(NSEvent.mouseLocation().y) > 600) {
            point.y += 10
            scrollView?.documentView?.scroll(point)
        }
        else if (Int(NSEvent.mouseLocation().y) < 200) {
            point.y -= 10
            scrollView?.documentView?.scroll(point)
        }
    }
    
    override func mouseEntered(with event: NSEvent) {
        mouseTextLabel.stringValue = "Mouse Entered"
    }
    
    override func mouseExited(with event: NSEvent) {
        mouseTextLabel.stringValue = "Mouse Exited"
    }
    
    //implement scrolling with mouse drag
    override func mouseDragged(with event: NSEvent){
        
        let point = scrollView?.contentView.bounds.origin
        
        if var point = point {
            point.y += event.deltaY
            point.x -= event.deltaX
            scrollView?.documentView?.scroll(point)
        }
        
    }
    
    //pan with arrow keys
    override func keyDown(with event: NSEvent) {
        
        var point = scrollView.contentView.bounds.origin
        
        //left arrow
        if event.keyCode == 123 {
            keyTest.stringValue = "Left"
            point.x -= 25
            scrollView?.documentView?.scroll(point)
        }
        //right arrow
        else if event.keyCode == 124 {
            keyTest.stringValue = "Right"
            point.x += 25
            scrollView?.documentView?.scroll(point)
        }
        //down arrow
        else if event.keyCode == 125 {
            keyTest.stringValue = "Down"
            point.y -= 25
            scrollView?.documentView?.scroll(point)
        }
        //up arrow
        else if event.keyCode == 126 {
            keyTest.stringValue = "Up"
            point.y += 25
            scrollView?.documentView?.scroll(point)
        }
        
    }
    
    override func keyUp(with event: NSEvent) {
        
        keyTest.stringValue = "Key Not Pressed"
        
    }
    
    
    //override scrolling function of the trackpad/scrolling wheel
    /*override func scrollWheel(with event: NSEvent) {
        let screen = splashScreen.image?.size
        if var screen = screen {
        screen.width -= event.deltaX
        screen.height -= event.deltaY
        }
        
    } */

}

