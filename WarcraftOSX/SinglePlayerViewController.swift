//
//  SinglePlayerViewController.swift
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

class SinglePlayerViewController: NSViewController {
    var game1SoundURL: URL?
    var game1SoundBankURL: URL?
    var game1Sound = AVMIDIPlayer()
<<<<<<< HEAD

    @IBAction func selectButton(_ sender: NSButton) {
        // MARK: Menu Sound should stop here
    }

    
    @IBAction func northSouthDivideTextField(_ sender: NSTextField) {
        print("North-South Divide Selected")
    }
    
    @IBAction func mazeTextField(_ sender: NSTextField) {
        print("Maze Selected")
    }
    
=======
    
    @IBAction func selectButton(_ sender: NSButton) {
    }
    
    @IBAction func northSouthDivideTextField(_ sender: NSTextField) {
    }
    
    @IBAction func mazeTextField(_ sender: NSTextField) {
    }
    
    @IBAction func cancelButton(_ sender: NSButton) {
    }

>>>>>>> origin/master
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
<<<<<<< HEAD
                game1Sound.stop()
=======
        game1Sound.stop()
>>>>>>> origin/master
    }
    
}
