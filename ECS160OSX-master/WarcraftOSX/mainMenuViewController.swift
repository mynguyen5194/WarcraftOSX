//
//  mainMenuViewController.swift
//  WarcraftOSX
//
//  Created by My Nguyen on 2/5/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa
import AVFoundation

class MainMenuViewController: NSViewController {
    var menuSoundURL: URL?
    var menuSoundBankURL: URL?
    var menuSound = AVMIDIPlayer()
    
  
    @IBAction func singlePlayerGameButton(_ sender: NSButton) {
        performSegue(withIdentifier: "singlePlayerGameSegue", sender: self)
        menuSound.stop()
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
        
//        showMenuBackground()
        playMenuMidi()
    }
    
    func showMenuBackground() {
        let imgView = NSImageView(frame:NSRect(x: 0, y: 0, width: 300, height: 300))
        imgView.image = NSImage(named:"Texture")
        self.view.addSubview(imgView)
//        let mainMenuBackground = NSImageView()
//        mainMenuBackground.image = NSImage(named: "Texture.png")
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
