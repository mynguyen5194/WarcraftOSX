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
    var mapName: String = "maze"
    
    @IBOutlet weak var selectButton: NSButton!
    @IBOutlet weak var cancelButton: NSButton!
    @IBOutlet weak var northSouthDivideText: NSTextField!
    @IBOutlet weak var mazeText: NSTextField!
    
    

    @IBAction func northSouthDivide(_ sender: NSTextField) {
//        print("North-South Divide Clicked")
          self.mapName = "2playerdivide"
//          mazeText.textColor = NSColor.yellow
//          northSouthDivideText.textColor = NSColor.white
    }
    
    @IBAction func maze(_ sender: NSTextField) {
//        print("Maze Clicked")
          self.mapName = "maze"
//          northSouthDivideText.textColor = NSColor.yellow
//          mazeText.textColor = NSColor.white
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuSupporter.formatButtonTitle(sender: selectButton, color: NSColor.yellow, title: selectButton.title, fontSize: 18)
        menuSupporter.formatButtonTitle(sender: cancelButton, color: NSColor.yellow, title: cancelButton.title, fontSize: 18)
        
    }
    
    
    
}
