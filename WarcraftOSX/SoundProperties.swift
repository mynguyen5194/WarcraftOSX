//
//  SoundProperties.swift
//  WarcraftOSX
//
//  Created by Kristoffer Solomon on 1/30/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import AVFoundation
import Cocoa

class SoundProperties {
    
    var menuSound = AVMIDIPlayer()
    var acknowledgeSound = AVAudioPlayer()
    
    init() {
        
        //menu sound midi
        let menuSoundURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/music/menu", ofType: "mid"))!)
        let menuSoundBankURL = Bundle.main.url(forResource: "data/snd/generalsoundfont", withExtension: "sf2")
        //load wave file for mouse click
        let acknowledge1URL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/basic/acknowledge1", ofType: "wav"))!)
        
        do {
            try acknowledgeSound = AVAudioPlayer(contentsOf: acknowledge1URL)
        }
        catch {
            NSLog("Error: Can't play sound file menu.mid")
        }
        do {
            try menuSound = AVMIDIPlayer(contentsOf: menuSoundURL, soundBankURL: menuSoundBankURL)
        }
        catch {
            NSLog("Error: Can't play sound file menu.mid")
        }
        menuSound.prepareToPlay()
        acknowledgeSound.prepareToPlay()
    }
    
    func playMenuSound() {
        menuSound.play()
    }
    
    func playClickSound() {
        acknowledgeSound.play()

    }

}





