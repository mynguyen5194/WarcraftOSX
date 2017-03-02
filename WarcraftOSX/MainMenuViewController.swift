
//
//  MainMenuViewController.swift
//  WarcraftOSX
//
//  Created by My Nguyen on 2/14/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa
import AVFoundation

var thunkSound = AVAudioPlayer()
var tickSound = AVAudioPlayer()
var singlePlayerGame = false

class MainMenuViewController: NSViewController {
    
    var menuSupporter = MenuSupporter()
    
    @IBOutlet weak var singlePlayerGameButton: NSButton!
    @IBOutlet weak var multiPlayerGameButton: NSButton!
    @IBOutlet weak var optionsButton: NSButton!
    @IBOutlet weak var exitGameButton: NSButton!
    
    @IBAction func singlePlayerGameButton(_ sender: NSButton) {
        playThunkSound()
        self.performSegue(withIdentifier: "singlePlayerGameSegue", sender: sender)
        singlePlayerGame = true
    }
    
    @IBAction func multiPlayerGameButton(_ sender: NSButton) {
        playThunkSound()
        self.performSegue(withIdentifier: "multiPlayerGameSegue", sender: sender)
        singlePlayerGame = false
    }
    
    @IBAction func optionsButton(_ sender: NSButton) {
        playThunkSound()
        self.performSegue(withIdentifier: "optionsSegue", sender: sender)
    }
    
    @IBAction func exitGameButton(_ sender: NSButton) {
        exit(0)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuSupporter.formatButtonTitle(sender: singlePlayerGameButton, color: NSColor.yellow, title: singlePlayerGameButton.title, fontSize: 18)
        menuSupporter.formatButtonTitle(sender: multiPlayerGameButton, color: NSColor.yellow, title: multiPlayerGameButton.title, fontSize: 18)
        menuSupporter.formatButtonTitle(sender: optionsButton, color: NSColor.yellow, title: optionsButton.title, fontSize: 18)
        menuSupporter.formatButtonTitle(sender: exitGameButton, color: NSColor.yellow, title: exitGameButton.title, fontSize: 18)
        
        let area = NSTrackingArea.init(rect: singlePlayerGameButton.bounds, options: [NSTrackingAreaOptions.mouseEnteredAndExited, NSTrackingAreaOptions.activeAlways], owner: self, userInfo: nil)
        singlePlayerGameButton.addTrackingArea(area)
        
        
    }
    
    func mouseHandler(sender: NSButton) {
//        let pstyle = NSMutableParagraphStyle()
//        pstyle.alignment = .center
//        var attributes = [String: AnyObject]()
//        
//        attributes[NSFontAttributeName] = NSFonts(name: "Apple Chancery", size: fontSize)
//        attributes[NSForegroundColorAttributeName] = NSColor.white
//        attributes[NSParagraphStyleAttributeName] = pstyle
//        
//        sender.attributedTitle = NSAttributedString(string: sender.title, attributes: attributes )
        
        
        let buttonArea = NSTrackingArea.init(rect: sender.bounds, options: [NSTrackingAreaOptions.mouseEnteredAndExited, NSTrackingAreaOptions.activeAlways], owner: self, userInfo: nil)
        sender.addTrackingArea(buttonArea)
        
    }
    
    override func mouseEntered(with event: NSEvent) {
        
        menuSupporter.formatButtonTitle(sender: singlePlayerGameButton, color: NSColor.white, title: singlePlayerGameButton.title, fontSize: 18)
        playTickSound()
        
    }
    override func mouseExited(with event: NSEvent) {
        menuSupporter.formatButtonTitle(sender: singlePlayerGameButton, color: NSColor.yellow, title: singlePlayerGameButton.title, fontSize: 18)
    }
    
    
    func playThunkSound() {
        let thunkURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/misc/thunk", ofType: "wav"))!)
        
        do {
            try thunkSound = AVAudioPlayer(contentsOf: thunkURL)
        } catch {
            NSLog("Error: Can't play sound file thunk.wav")
        }
        
        thunkSound.prepareToPlay()
        thunkSound.play()
    }
    
    func playTickSound() {
        let tickURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/misc/tick", ofType: "wav"))!)
        
        do {
            try tickSound = AVAudioPlayer(contentsOf: tickURL)
        } catch {
            NSLog("Error: Can't play sound file thunk.wav")
        }
        
        tickSound.prepareToPlay()
        tickSound.play()
    }
}
