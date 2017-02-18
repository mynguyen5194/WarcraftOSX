<<<<<<< HEAD
=======

>>>>>>> origin/master
//
//  MainMenuViewController.swift
//  WarcraftOSX
//
<<<<<<< HEAD
//  Created by My Nguyen on 2/13/17.
=======
//  Created by My Nguyen on 2/14/17.
>>>>>>> origin/master
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa
import AVFoundation

class MainMenuViewController: NSViewController {
    
    var thunkURL: URL?
    var thunkSound = AVAudioPlayer()
<<<<<<< HEAD

=======
    
>>>>>>> origin/master
    var menuSoundURL: URL?
    var menuSoundBankURL: URL?
    var menuSound = AVMIDIPlayer()
    
    @IBAction func singlePlayerGameButton(_ sender: NSButton) {
        playthunk()
        performSegue(withIdentifier: "singlePlayerGameSegue", sender: self)
<<<<<<< HEAD
//        menuSound.stop()
        print("Stop menuSound")
    }
    
    @IBAction func multiPlayerGameButton(_ sender: NSButton) {
        playthunk()
        print("Play Thunk")
=======
        //        menuSound.stop()
    }
    
    @IBAction func multiPlayerGameButton(_ sender: NSButton) {
>>>>>>> origin/master
    }
    
    @IBAction func optionsButton(_ sender: NSButton) {
    }
    
    @IBAction func exitGameButton(_ sender: NSButton) {
        exit(0)
    }
<<<<<<< HEAD
    
    
=======

>>>>>>> origin/master
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
<<<<<<< HEAD
=======

>>>>>>> origin/master
    
}
