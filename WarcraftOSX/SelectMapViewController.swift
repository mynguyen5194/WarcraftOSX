//
//  SinglePlayerViewController.swift
//  WarcraftOSX
//
//  Created by My Nguyen on 2/14/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa
import AVFoundation


var northSouthDivide = false


class SelectMapViewController: NSViewController {
    var menuSupporter = MenuSupporter()
    var mapName: String = "maze"
    
    @IBOutlet weak var miniMap: NSImageView!
    
    
    @IBOutlet weak var selectButton: NSButton!
    @IBOutlet weak var cancelButton: NSButton!


    
    @IBOutlet weak var northSouthDivideButton: NSButton!
    @IBAction func northSouthDivideButton(_ sender: NSButton) {
        miniMap.image = NSImage(named: "North-South Divide Map")
        
        menuSupporter.formatButtonTitle(sender: northSouthDivideButton, color: NSColor.white, title: northSouthDivideButton.title, fontSize: 16)
        menuSupporter.formatButtonTitle(sender: mazeButton, color: NSColor.yellow, title: mazeButton.title, fontSize: 16)
        northSouthDivide = true
    }
    
    @IBOutlet weak var mazeButton: NSButton!
    @IBAction func mazeButton(_ sender: NSButton) {
        miniMap.image = NSImage(named: "Maze Map")
        
        menuSupporter.formatButtonTitle(sender: northSouthDivideButton, color: NSColor.yellow, title: northSouthDivideButton.title, fontSize: 16)
        menuSupporter.formatButtonTitle(sender: mazeButton, color: NSColor.white, title: mazeButton.title, fontSize: 16)
        northSouthDivide = false

    }

    @IBAction func selectButton(_ sender: NSButton) {
        thunkSound.play()
        self.performSegue(withIdentifier: "selectSegue", sender: sender)
    }
    @IBAction func cancelButton(_ sender: NSButton) {
        thunkSound.play()
        self.performSegue(withIdentifier: "cancelSelectMapSegue", sender: sender)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuSupporter.formatButtonTitle(sender: selectButton, color: NSColor.yellow, title: selectButton.title, fontSize: 18)
        menuSupporter.formatButtonTitle(sender: cancelButton, color: NSColor.yellow, title: cancelButton.title, fontSize: 18)
        menuSupporter.formatButtonTitle(sender: northSouthDivideButton, color: NSColor.white, title: northSouthDivideButton.title, fontSize: 16)
        menuSupporter.formatButtonTitle(sender: mazeButton, color: NSColor.yellow, title: mazeButton.title, fontSize: 16)

        miniMap.image = NSImage(named: "North-South Divide Map")
    }
}
