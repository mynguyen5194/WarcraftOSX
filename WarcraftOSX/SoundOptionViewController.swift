//
//  SoundOptionViewController.swift
//  WarcraftOSX
//
//  Created by My Nguyen on 2/14/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa

class SoundOptionViewController: NSViewController {
    var menuSupporter = MenuSupporter()
    var fxVolume = 100
    var musicVolume = 100
    
    @IBOutlet weak var fxVolumeTextField: NSTextField!
    @IBOutlet weak var musicVolumeTextField: NSTextField!
    
    @IBOutlet weak var okButton: NSButton!
    @IBOutlet weak var cancelButton: NSButton!
    
    @IBAction func okButton(_ sender: NSButton) {
        thunkSound.play()
        self.performSegue(withIdentifier: "okSoundOptionsSegue", sender: sender)
        fxVolume = fxVolumeTextField.integerValue
        musicVolume = musicVolumeTextField.integerValue
    }
    
    @IBAction func cancelButton(_ sender: NSButton) {
        thunkSound.play()
        self.performSegue(withIdentifier: "cancelSoundOptionsSegue", sender: sender)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuSupporter.formatButtonTitle(sender: okButton, color: NSColor.yellow, title: okButton.title, fontSize: 18)
        menuSupporter.formatButtonTitle(sender: cancelButton, color: NSColor.yellow, title: cancelButton.title, fontSize: 18)
        
        fxVolumeTextField.stringValue = "100"
        musicVolumeTextField.stringValue = "100"
    
    }
}
