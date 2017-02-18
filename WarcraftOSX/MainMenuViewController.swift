
//
//  MainMenuViewController.swift
//  WarcraftOSX
//
//  Created by My Nguyen on 2/14/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa
import AVFoundation

var menuSound = AVMIDIPlayer()

func playThunkSound() {
    let thunkURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/misc/thunk", ofType: "wav"))!)
    var thunkSound = AVAudioPlayer()
    
    do {
        try thunkSound = AVAudioPlayer(contentsOf: thunkURL)
    } catch {
        NSLog("Error: Can't play sound file thunk.wav")
    }
    
    thunkSound.prepareToPlay()
    thunkSound.play()
}

class MainMenuViewController: NSViewController {
    
    var menuSoundURL: URL?
    var menuSoundBankURL: URL?
    
    @IBAction func singlePlayerGameButton(_ sender: NSButton) {
        playThunkSound()
        performSegue(withIdentifier: "singlePlayerGameSegue", sender: self)
    }
    
    @IBAction func multiPlayerGameButton(_ sender: NSButton) {
        playThunkSound()
    }
    
    @IBAction func optionsButton(_ sender: NSButton) {
        playThunkSound()
    }
    
    @IBAction func exitGameButton(_ sender: NSButton) {
        playThunkSound()
        exit(0)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
}
