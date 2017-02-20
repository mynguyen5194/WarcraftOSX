
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

class MainMenuViewController: NSViewController {
    var menuSoundURL: URL?
    var menuSoundBankURL: URL?
    var thunkSound = AVAudioPlayer()
    
    @IBAction func singlePlayerGameButton(_ sender: NSButton) {
        playThunkSound()
        thunkSound.prepareToPlay()
        thunkSound.play()
    }
    
    @IBAction func multiPlayerGameButton(_ sender: NSButton) {
        playThunkSound()
    }
    
    @IBAction func optionsButton(_ sender: NSButton) {

    }
    
    @IBAction func exitGameButton(_ sender: NSButton) {

        exit(0)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        background.image = MenuSupporter().getMenuImage()
        playMenuMidi()
        
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
    
    func playThunkSound() {// -> AVAudioPlayer {
        let thunkURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/misc/thunk", ofType: "wav"))!)
        
        
        do {
            try thunkSound = AVAudioPlayer(contentsOf: thunkURL)
        } catch {
            NSLog("Error: Can't play sound file thunk.wav")
        }
        
        
        print("play thunk")
//        return thunkSound
    }
}
