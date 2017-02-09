//
//  SinglePlayerViewController.swift
//  WarcraftOSX
//
//  Created by My Nguyen on 2/5/17.
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
    
    @IBOutlet weak var tile: NSImageCell!
    
    @IBAction func mouseClickOnTile(_ sender: NSClickGestureRecognizer) {
        farmURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/buildings/farm", ofType: "wav"))!)
        do {
            try farmSound = AVAudioPlayer(contentsOf: farmURL!)
        } catch {
            NSLog("Error: Can't play sound file intro.wav")
        }
        
        farmSound.prepareToPlay()
        farmSound.volume = 1.0
        farmSound.play()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let imgView = NSImageView()
        //        imgView.image = NSImage(named:"farm")
        
        playBackgroundMusic()
        
        let map = MapRenderer()
        map.viewDidLoad()
        
        tile.image = NSImage(cgImage: map.tileArray[100], size: NSZeroSize)
        let parseDat = GraphicTileset()
        parseDat.viewDidLoad()
        
        ////        Set bit mask for clicks
        //            primaryMouseOutlet.buttonMask = 0x1
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
