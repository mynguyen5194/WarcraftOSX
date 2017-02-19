
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
//    var thunk = MenuSupporter().playThunkSound()
    
    @IBAction func singlePlayerGameButton(_ sender: NSButton) {
        MenuSupporter().playThunkSound().play()
        performSegue(withIdentifier: "singlePlayerGameSegue", sender: self)
    }
    
    @IBAction func multiPlayerGameButton(_ sender: NSButton) {
        MenuSupporter().playThunkSound().play()
    }
    
    @IBAction func optionsButton(_ sender: NSButton) {
//        MenuSupporter().playThunkSound()
    }
    
    @IBAction func exitGameButton(_ sender: NSButton) {
//        MenuSupporter().playThunkSound()
        exit(0)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        background.image = MenuSupporter().getMenuImage()
//        MenuSupporter().playMenuMidi()
        
    }
}
