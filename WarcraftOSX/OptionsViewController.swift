//
//  OptionsViewController.swift
//  WarcraftOSX
//
//  Created by My Nguyen on 2/21/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa

class OptionsViewController: NSViewController {
    var menuSupporter = MenuSupporter()
    
    @IBOutlet weak var soundButton: NSButton!
    @IBOutlet weak var networkButton: NSButton!
    @IBOutlet weak var backButton: NSButton!
    
    @IBAction func soundButton(_ sender: NSButton) {
        thunkSound.play()
        self.performSegue(withIdentifier: "soundOptionsSegue", sender: sender)
    }
    @IBAction func networkButton(_ sender: NSButton) {
        thunkSound.play()
        self.performSegue(withIdentifier: "networkOptionsSegue", sender: sender)
    }
    @IBAction func backButton(_ sender: NSButton) {
        thunkSound.play()
        self.performSegue(withIdentifier: "backOptionsSegue", sender: sender)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuSupporter.formatButtonTitle(sender: soundButton, color: NSColor.yellow, title: soundButton.title, fontSize: 18)
        menuSupporter.formatButtonTitle(sender: networkButton, color: NSColor.yellow, title: networkButton.title, fontSize: 18)
        menuSupporter.formatButtonTitle(sender: backButton, color: NSColor.yellow, title: backButton.title, fontSize: 18)
    }
    
}
