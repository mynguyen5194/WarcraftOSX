//
//  NetworkOptionsViewController.swift
//  WarcraftOSX
//
//  Created by My Nguyen on 2/21/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa

class NetworkOptionsViewController: NSViewController {
    var menuSupporter = MenuSupporter()
    
    @IBOutlet weak var okButton: NSButton!
    @IBOutlet weak var cancelButton: NSButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuSupporter.formatButtonTitle(sender: okButton, color: NSColor.yellow, title: okButton.title, fontSize: 18)
        menuSupporter.formatButtonTitle(sender: cancelButton, color: NSColor.yellow, title: cancelButton.title, fontSize: 18)
    }
    
}
