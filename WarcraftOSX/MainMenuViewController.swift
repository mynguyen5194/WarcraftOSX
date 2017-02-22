
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

class MainMenuViewController: NSViewController {
    
    var menuSupporter = MenuSupporter()
    
    @IBOutlet weak var theGameText: NSTextField!
    @IBOutlet weak var singlePlayerGameButton: NSButton!
    @IBOutlet weak var multiPlayerGameButton: NSButton!
    @IBOutlet weak var optionsButton: NSButton!
    @IBOutlet weak var exitGameButton: NSButton!
    
    @IBAction func singlePlayerGameButton(_ sender: NSButton) {
        playThunkSound()
        self.performSegue(withIdentifier: "singlePlayerGameSegue", sender: sender)
        
    }
    
    @IBAction func multiPlayerGameButton(_ sender: NSButton) {
        playThunkSound()
        self.performSegue(withIdentifier: "multiPlayerGameSegue", sender: sender)
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
}
