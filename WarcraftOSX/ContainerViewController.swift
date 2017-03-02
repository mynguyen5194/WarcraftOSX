//
//  ContainerViewController.swift
//  WarcraftOSX
//
//  Created by Kristoffer Solomon on 2/13/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa
import Foundation

class ContainerViewController: NSViewController {
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.view.wantsLayer = true
        let mainStoryboard: NSStoryboard = self.storyboard!
        let launchViewController: NSViewController = mainStoryboard.instantiateController(withIdentifier: "launchViewController") as! NSViewController
        self.insertChildViewController(launchViewController, at: 0)
        self.view.addSubview(launchViewController.view)
        self.view.frame = launchViewController.view.frame
    }
}
