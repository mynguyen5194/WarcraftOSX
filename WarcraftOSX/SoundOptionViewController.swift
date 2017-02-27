//
//  SoundOptionViewController.swift
//  WarcraftOSX
//
//  Created by My Nguyen on 2/14/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa

var fxVolume = 100
var musicVolume = 100

class SoundOptionViewController: NSViewController {
    var menuSupporter = MenuSupporter()
    
    @IBOutlet weak var fxVolumeTextField: NSTextField!
    @IBOutlet weak var musicVolumeTextField: NSTextField!
    
    @IBOutlet weak var okButton: NSButton!
    @IBOutlet weak var cancelButton: NSButton!
    
    @IBAction func okButton(_ sender: NSButton) {
        thunkSound.play()
        self.performSegue(withIdentifier: "okSoundOptionsSegue", sender: sender)
        
        fxVolume = Int(fxVolumeTextField.intValue)
        musicVolume = Int(musicVolumeTextField.intValue)
        
        thunkSound.volume = Float((Float(fxVolume)*1.0)/100.0)
        menuSound.volume = Float((Float(musicVolume)*1.0)/100.0)
        
        fxVolumeTextField.stringValue = String(fxVolume)
        musicVolumeTextField.stringValue = String(musicVolume)
    }
    
    @IBAction func cancelButton(_ sender: NSButton) {
        thunkSound.play()
        self.performSegue(withIdentifier: "cancelSoundOptionsSegue", sender: sender)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuSupporter.formatButtonTitle(sender: okButton, color: NSColor.yellow, title: okButton.title, fontSize: 18)
        menuSupporter.formatButtonTitle(sender: cancelButton, color: NSColor.yellow, title: cancelButton.title, fontSize: 18)
        
        fxVolumeTextField.stringValue = String(fxVolume)
        musicVolumeTextField.stringValue = String(musicVolume)
        
    }
}
