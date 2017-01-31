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

    @IBOutlet weak var splashScreen: NSImageView!
    @IBOutlet weak var tileEX: NSImageView!
    @IBOutlet weak var primaryMouseOutlet: NSClickGestureRecognizer!
    
    // Added from here
    @IBOutlet var viewControllerOutlet: NSView!
    //    @IBOutlet var viewScreen: NSView!
    @IBOutlet weak var textLabel: NSTextField!
    @IBOutlet weak var mouseTextLabel: NSTextField!
    @IBOutlet weak var leftClickRecognizer: NSClickGestureRecognizer!
    @IBOutlet weak var rightClickRecognizer: NSClickGestureRecognizer!
    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet weak var keyTest: NSTextField!
    
    let splashURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/img/Splash", ofType:"png"))!)
    
    //menu sound midi
    let menuSoundURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/music/menu", ofType: "mid"))!)
    let menuSoundBankURL = Bundle.main.url(forResource: "data/snd/generalsoundfont", withExtension: "sf2")
    var menuSound = AVMIDIPlayer()
    
    //load wave file for mouse click
    let acknowledge1URL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/basic/acknowledge1", ofType: "wav"))!)
    var acknowledgeSound = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //splash screen
        let splashData = CGDataProvider(url: splashURL as CFURL)
        let splashCG = CGImage(pngDataProviderSource: splashData!, decode: nil, shouldInterpolate: false, intent: CGColorRenderingIntent.defaultIntent)
        let splashOrigin = CGPoint(x: 0, y: (splashCG!.height/2))
        let splashSize = CGSize(width: splashCG!.width, height: (splashCG!.height/2))
        let splashRect = CGRect(origin: splashOrigin, size: splashSize)
        let splashImage = splashCG?.cropping(to: splashRect)
        
        //splash screen: convert to NSImage to display
        splashScreen.image = NSImage(cgImage: splashImage!, size: NSZeroSize)
        
        let map = MapRenderer()
        map.viewDidLoad()
        
        tileEX.image = NSImage(cgImage: map.tileArray[100], size: NSZeroSize)
        //var timerToMenu = Timer(timeInterval: 5.0, target: self, selector: (timerFireMethod: timer), userInfo: nil, repeats: false)
        
        let parseDat = GraphicTileset()
        parseDat.viewDidLoad()
        
        //play mid file
        do {
            try menuSound = AVMIDIPlayer(contentsOf: menuSoundURL, soundBankURL: menuSoundBankURL)
        }
        catch {
            NSLog("Error: Can't play sound file menu.mid")
        }
        //menuSound.prepareToPlay()
        //menuSound.play()
        //menuSound.prepareToPlay()
        //menuSound.play()
        
        //Set bit mask for clicks
        primaryMouseOutlet.buttonMask = 0x1
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
    @IBAction func primaryMouse(_ sender: Any) {
        //play wav file
        do {
            try acknowledgeSound = AVAudioPlayer(contentsOf: acknowledge1URL)
        }
        catch {
            NSLog("Error: Can't play sound file intro.wav")
        }
        acknowledgeSound.prepareToPlay()
        acknowledgeSound.play()
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



}

