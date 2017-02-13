//
//  SoundOptionViewController.swift
//  WarcraftOSX
//
//  Created by My Nguyen on 2/13/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa

class SoundOptionViewController: NSViewController {

    @IBOutlet weak var fxVolumeTextField: NSTextField!
    
    @IBOutlet weak var musicVolumeTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fxVolumeTextField.stringValue = "100"
        musicVolumeTextField.stringValue = "50"
    }
    
    
}
