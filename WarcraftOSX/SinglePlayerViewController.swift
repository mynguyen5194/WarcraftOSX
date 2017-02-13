//
//  SinglePlayerViewController.swift
//  WarcraftOSX
//
//  Created by My Nguyen on 2/13/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa
import AVFoundation

class SinglePlayerViewController: NSViewController {
    var farmURL: URL?
    var farmSound = AVAudioPlayer()
    
    var game1SoundURL: URL?
    var game1SoundBankURL: URL?
    var game1Sound = AVMIDIPlayer()

    @IBAction func loadMapButton(_ sender: NSButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playBackgroundMusic()
    }
    
    func playBackgroundMusic() {
        game1SoundURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/music/game1", ofType: "mid"))!)
        game1SoundBankURL = Bundle.main.url(forResource: "data/snd/generalsoundfont", withExtension: "sf2")
        
        do {
            try game1Sound = AVMIDIPlayer(contentsOf: game1SoundURL!, soundBankURL: game1SoundBankURL)
        }
        catch {
            NSLog("Error: Can't play sound file menu.mid")
        }
        game1Sound.prepareToPlay()
        game1Sound.play()
        //        game1Sound.stop()
    }
    
}
