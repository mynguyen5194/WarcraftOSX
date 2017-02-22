//
//  SinglePlayerViewController.swift
//  WarcraftOSX
//
//  Created by My Nguyen on 2/14/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa
import AVFoundation

class SelectMapViewController: NSViewController {
    var menuSupporter = MenuSupporter()
    
    @IBOutlet weak var selectButton: NSButton!
    @IBOutlet weak var cancelButton: NSButton!
    @IBOutlet weak var northSouthDivideText: NSTextField!
    @IBOutlet weak var mazeText: NSTextField!

    @IBAction func northSouthDivide(_ sender: NSTextField) {
        print("North-South Divide Clicked")
        
//        mazeText.textColor = NSColor.white
//        northSouthDivideText.textColor = NSColor.yellow
    }
    
    @IBAction func maze(_ sender: NSTextField) {
        print("Maze Clicked")
        
//        northSouthDivideText.textColor = NSColor.white
//        mazeText.textColor = NSColor.yellow
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuSupporter.formatButtonTitle(sender: selectButton, color: NSColor.yellow, title: selectButton.title, fontSize: 18)
        menuSupporter.formatButtonTitle(sender: cancelButton, color: NSColor.yellow, title: cancelButton.title, fontSize: 18)
        
    }
    
    
    
}
