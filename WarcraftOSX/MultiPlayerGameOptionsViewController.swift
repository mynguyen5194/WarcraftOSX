//
//  MultiPlayerGameOptionsViewController.swift
//  WarcraftOSX
//
//  Created by My Nguyen on 2/21/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa

class MultiPlayerGameOptionsViewController: NSViewController {
    var menuSupporter = MenuSupporter()
    
    @IBOutlet weak var hostButton: NSButton!
    @IBOutlet weak var joinButton: NSButton!
    @IBOutlet weak var backButton: NSButton!
    
    @IBAction func hostButton(_ sender: NSButton) {
        thunkSound.play()
        self.performSegue(withIdentifier: "hostMultiPlayerGameSegue", sender: sender)
    }
    @IBAction func joinButton(_ sender: NSButton) {
//        self.performSegue(withIdentifier: "optionsSegue", sender: sender)
    }
    @IBAction func backButton(_ sender: NSButton) {
        thunkSound.play()
        self.performSegue(withIdentifier: "backMultiplayerGameSegue", sender: sender)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        menuSupporter.formatButtonTitle(sender: hostButton, color: NSColor.yellow, title: hostButton.title, fontSize: 18)
        menuSupporter.formatButtonTitle(sender: joinButton, color: NSColor.yellow, title: joinButton.title, fontSize: 18)
        menuSupporter.formatButtonTitle(sender: backButton, color: NSColor.yellow, title: backButton.title, fontSize: 18)
    }
    
}
