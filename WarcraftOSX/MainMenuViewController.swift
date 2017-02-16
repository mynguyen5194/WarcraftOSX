
//
//  MainMenuViewController.swift
//  WarcraftOSX
//
//  Created by My Nguyen on 2/14/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa
import AVFoundation

class MainMenuViewController: NSViewController {
    
    @IBOutlet var menuScreen: NSImageView!
    var thunkURL: URL?
    var thunkSound = AVAudioPlayer()
    
    var menuSoundURL: URL?
    var menuSoundBankURL: URL?
    var menuSound = AVMIDIPlayer()
    
    @IBAction func singlePlayerGameButton(_ sender: NSButton) {
        playthunk()
        performSegue(withIdentifier: "singlePlayerGameSegue", sender: self)
        //        menuSound.stop()
    }
    
    @IBAction func multiPlayerGameButton(_ sender: NSButton) {
    }
    
    @IBAction func optionsButton(_ sender: NSButton) {
    }
    
    @IBAction func exitGameButton(_ sender: NSButton) {
        exit(0)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //set splash screen
        
        let visualElements = OSXMainMenu()
        
        menuScreen.image = visualElements.getMenuImage()
        
        //Button Elements
        
        
        
        //showMenuBackground()
        
        playMenuMidi()
        
    }
    
    func showMenuBackground() {
        let imgView = NSImageView(frame:NSRect(x: 0, y: 0, width: 300, height: 300))
        imgView.image = NSImage(named:"Texture")
        self.view.addSubview(imgView)
    }
    
    
    func playMenuMidi() {
        menuSoundURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/music/menu", ofType: "mid"))!)
        menuSoundBankURL = Bundle.main.url(forResource: "data/snd/generalsoundfont", withExtension: "sf2")
        
        do {
            try menuSound = AVMIDIPlayer(contentsOf: menuSoundURL!, soundBankURL: menuSoundBankURL)
        }
        catch {
            NSLog("Error: Can't play sound file menu.mid")
        }
        menuSound.prepareToPlay()
        menuSound.play()
        print("Play menuSound")
    }
    
    func playthunk() {
        self.thunkURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/misc/thunk", ofType: "wav"))!)
        do {
            try self.thunkSound = AVAudioPlayer(contentsOf: self.thunkURL!)
        } catch {
            NSLog("Error: Can't play sound file thunk.wav")
        }
        
        self.thunkSound.prepareToPlay()
        self.thunkSound.play()
    }

    
}
