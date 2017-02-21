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

    @IBOutlet weak var fxVolumeTextField: NSTextField!
    
    @IBOutlet weak var musicVolumeTextField: NSTextField!
    
    @IBOutlet weak var okButton: NSButton!
    @IBOutlet weak var cancelButton: NSButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuSupporter.formatButtonTitle(sender: okButton, color: NSColor.yellow, title: okButton.title, fontSize: 18)
        menuSupporter.formatButtonTitle(sender: cancelButton, color: NSColor.yellow, title: cancelButton.title, fontSize: 18)
        
        fxVolumeTextField.stringValue = "100"
        musicVolumeTextField.stringValue = "50"
        
    }
    
}
